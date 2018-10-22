Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A54C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13892064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XNb/hX5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13892064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeJVUZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:25:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55482 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJVUZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9fGStvygYgdHhQavVB16dJWsedPBKWvpA+LZW+VrQxI=; b=XNb/hX5NH/ilIyT3kI45byUdQ
        StZfSn6frP5z1Cj3ZJzyt2YCcAhxInBZt9U2eIYEoF8XfKf6Qqtr2xaMRUkVr2miELzc3WAfhi9gd
        1CwN+dPzCPrFcH3Y0MeQY+aefHAWB9kVu0r0TyXDsKWi/8EpJNYT0UEYXFksdaSxt3iB4=;
Received: from [167.98.65.38] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gEYzc-00069a-NL; Mon, 22 Oct 2018 12:07:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 544C2440078; Mon, 22 Oct 2018 14:07:32 +0200 (CEST)
Date:   Mon, 22 Oct 2018 13:07:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for the next release
Message-ID: <20181022120732.GC2103@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e:

  Linux 4.19-rc8 (2018-10-15 07:20:24 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.0

for you to fetch changes up to ae2399c48c023ef8a6e0d260950420296252b3e9:

  Merge remote-tracking branches 'regmap/topic/noinc' and 'regmap/topic/single-rw' into regmap-next (2018-10-21 12:07:26 +0100)

----------------------------------------------------------------
regmap: Updates for v5.0

A small update with a couple of new APIs that are useful for some small
sets of devices:

 - Split up the single_rw flagging to map read and write separately as
   some devices support bulk operations for only read or only write.
 - Add a write version of the noinc API.
 - Clean up the code for LOG_DEVICE a bit.

----------------------------------------------------------------
Ben Dooks (1):
      regmap: use less #ifdef for LOG_DEVICE

Ben Whitten (1):
      regmap: Add regmap_noinc_write API

David Frey (2):
      regmap: fix comment for regmap.use_single_write
      regmap: split up regmap_config.use_single_rw

Mark Brown (2):
      Merge branch 'regmap-4.20' into regmap-next
      Merge remote-tracking branches 'regmap/topic/noinc' and 'regmap/topic/single-rw' into regmap-next

 drivers/base/regmap/internal.h           |  5 +-
 drivers/base/regmap/regmap.c             | 99 +++++++++++++++++++++++++++++---
 drivers/edac/altera_edac.c               |  3 +-
 drivers/hwmon/lm75.c                     |  3 +-
 drivers/hwmon/lm95245.c                  |  3 +-
 drivers/hwmon/tmp102.c                   |  3 +-
 drivers/hwmon/tmp108.c                   |  3 +-
 drivers/iio/light/apds9960.c             |  3 +-
 drivers/iio/light/max44000.c             | 23 ++++----
 drivers/iio/temperature/mlx90632.c       |  3 +-
 drivers/input/touchscreen/tsc200x-core.c |  3 +-
 drivers/mfd/altera-a10sr.c               |  3 +-
 drivers/mfd/da9052-spi.c                 |  3 +-
 drivers/mfd/mc13xxx-spi.c                |  3 +-
 drivers/mfd/twl6040.c                    |  3 +-
 drivers/regulator/ltc3589.c              |  3 +-
 drivers/regulator/ltc3676.c              |  3 +-
 include/linux/regmap.h                   | 31 ++++++++--
 sound/hda/hdac_regmap.c                  |  3 +-
 sound/soc/codecs/cs35l33.c               |  3 +-
 sound/soc/codecs/cs35l35.c               |  3 +-
 sound/soc/codecs/cs43130.c               |  4 +-
 sound/soc/codecs/es8328.c                |  3 +-
 sound/soc/codecs/rt1305.c                |  3 +-
 sound/soc/codecs/rt5514.c                |  3 +-
 sound/soc/codecs/rt5616.c                |  3 +-
 sound/soc/codecs/rt5640.c                |  3 +-
 sound/soc/codecs/rt5645.c                |  9 ++-
 sound/soc/codecs/rt5651.c                |  3 +-
 sound/soc/codecs/rt5660.c                |  3 +-
 sound/soc/codecs/rt5663.c                |  9 ++-
 sound/soc/codecs/rt5665.c                |  3 +-
 sound/soc/codecs/rt5668.c                |  3 +-
 sound/soc/codecs/rt5670.c                |  3 +-
 sound/soc/codecs/rt5682.c                |  3 +-
 35 files changed, 205 insertions(+), 59 deletions(-)

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvNvYMACgkQJNaLcl1U
h9BRngf+JnpVsNrolWhkwHfZcd1481IU1ynTjdGJRTbSuuCnm44cs7PrAI23sZ5Z
DIrH5W8XDxhGe4Ptwo6ggXavt+LVRDCT/639hO0UHWaoBgCBkdJfR+KAQmyvhk04
zxWvSGW03e+mJVH05WPesaRGC3ilexhw/Nr6Cr2R1inL8zH5wmEiH1RRYwugwl2D
waXn5aM17JrAi0DzRZUHd8FafIHKQq+Fh9FPU7ADOUaqgt4KcPPRPthWQgMHNpxI
TPf6WGbGLrwpK5yQXuHWEE35vjiRYitsaDQZULLZp8eAMnWQIlCbyYttHYR+F/UQ
XMKqpJN8QSFNtvhPJzcKVSctHOYxoA==
=/sGf
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
