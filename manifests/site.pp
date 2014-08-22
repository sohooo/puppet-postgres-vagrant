# Our Testfile to validate the Puppet provider.
file { '/tmp/tyler':
  ensure  => present,
  content => 'The things you own end up owning you.',
}

# Set Postgres version to 9.3.
class { 'postgresql::globals':
  manage_package_repo => true,
  version             => '9.3',
} -> 
class { 'postgresql::server':
  listen_addresses           => '*',
  postgres_password          => 'funkytown',
}

postgresql::server::db { 'mydb':
  user     => 'funky',
  password => postgresql_password('funky', 'funkytown'),
}
# rule for remote connections
postgresql::server::pg_hba_rule { 'allow remote connections with password':
  type        => 'host',
  database    => 'all',
  user        => 'all',
  address     => 'all',
  auth_method => 'md5',
}

