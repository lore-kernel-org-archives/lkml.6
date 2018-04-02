Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeDBQ0D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:26:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54180 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeDBQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:26:00 -0400
Date: Mon, 2 Apr 2018 17:25:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for v4.17
Message-ID: <20180402162558.GT29239@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xiprIVX1FSGBv8kC"
Content-Disposition: inline
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xiprIVX1FSGBv8kC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v4.17

for you to fetch changes up to 2889312616aecf1a1153be0fab19206a6b1f768f:

  Merge remote-tracking branches 'regmap/topic/debugfs' and 'regmap/topic/mmio-clk' into regmap-next (2018-03-12 09:50:42 -0700)

----------------------------------------------------------------
regmap: Updates for v4.17

This is a fairly large set of updates for regmap, mainly bugfixes.  The
biggest bit of this is some fixes for the bulk operations code which
had issues in some use cases, Charles Keepax has sorted them out.  We
also gained the ability to use debugfs with syscon regmaps and to
specify the clock to be used with MMIO regmaps.

----------------------------------------------------------------
Charles Keepax (12):
      regmap: Correct offset handling in regmap_volatile_range
      regmap: Correct comparison in regmap_cached
      regmap: Don't use format_val in regmap_bulk_read
      regmap: Use helper function for register offset
      regmap: Move the handling for max_raw_read into regmap_raw_read
      regmap: Tidy up regmap_raw_read chunking code
      regmap: Use _regmap_read in regmap_bulk_read
      regmap: Format data for raw write in regmap_bulk_write
      regmap: Remove unnecessary printk for failed allocation
      regmap: Move the handling for max_raw_write into regmap_raw_write
      regmap: Tidy up regmap_raw_write chunking code
      regmap: Merge redundant handling in regmap_bulk_write

Dan Carpenter (2):
      regmap: Fix reversed bounds check in regmap_raw_write()
      regmap-i2c: Off by one in regmap_i2c_smbus_i2c_read/write()

David Lechner (2):
      regmap: Allow missing device in regmap_name_read_file()
      regmap: use debugfs even when no device

Fabio Estevam (2):
      regmap: debugfs: Disambiguate dummy debugfs file name
      regmap: debugfs: Improve warning message on debugfs_create_dir() failure

Jeffy Chen (1):
      regmap: debugfs: Free map->debugfs_name when debugfs_create_dir() failed

Mark Brown (7):
      Merge branch 'fix/core' of https://git.kernel.org/.../broonie/regmap into regmap-bulk
      regmap: debugfs: Don't leak dummy names
      Merge remote-tracking branch 'regmap/fix/cache' into regmap-linus
      Merge remote-tracking branch 'regmap/fix/core' into regmap-linus
      Merge remote-tracking branches 'regmap/fix/i2c' and 'regmap/fix/volatile' into regmap-linus
      Merge remote-tracking branch 'regmap/topic/bulk' into regmap-next
      Merge remote-tracking branches 'regmap/topic/debugfs' and 'regmap/topic/mmio-clk' into regmap-next

Maxime Ripard (1):
      regmap: mmio: Add function to attach a clock

 drivers/base/regmap/regmap-debugfs.c |  20 ++-
 drivers/base/regmap/regmap-i2c.c     |   4 -
 drivers/base/regmap/regmap-mmio.c    |  24 +++
 drivers/base/regmap/regmap.c         | 306 ++++++++++++++---------------------
 include/linux/regmap.h               |   3 +
 5 files changed, 168 insertions(+), 189 deletions(-)

--xiprIVX1FSGBv8kC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrCWZUACgkQJNaLcl1U
h9BV3gf9FgH1z7gW21I1g4raaekG3zZFXdhF+0xsMAFnBtsG87mqhzQWkVn2UQ55
bOUYZpLts/ClhiWs2Bg12I8Cbw0+keEEsVymEiCe/lgwQEWboiXkVBjQWHZ63aFw
mZTvyMDN9DohIZFMHtcqn4ymR8P1pfsRBlagQO+D/fEtfqp8nzGmGsIO9IoxcDHo
wKYwItK+eZsW8J4TMzxTSuETefMEwExdPzeTSCeM3WIY5p7o36FItUYl1V3hZYlj
jnXCt5IJYW9yJ2HVKjhNbsA7vHgj6/x4blj+JHcGF+M/iKafyfuqnt05p67oTKqE
+XRBh5YmvfZxaAm5i5vDrmwoFTgr4Q==
=i0Dr
-----END PGP SIGNATURE-----

--xiprIVX1FSGBv8kC--
