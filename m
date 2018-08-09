Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CABBC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE2A21A88
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xcsyoAmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE2A21A88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbeHIMjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:39:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47750 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIMjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eJW1Uob3FK7qpzKmgIuT06cRT+R4sWGGUlssqNny4wo=; b=xcsyoAmoey+kHgd8iluQf3nuX
        1IvZdn0B/mWlLpB9LFOK7WHyumKyoktn9MZGRjvkmEMqho7+zHxpI5NnChc9JCMDa93AowNzgaLV1
        To1wc7V6Fy1b0OFYjVYtdLaWZ+vMZ6Ru6z3iCdc4uO9198q1eehfE2BneFaIMhw2p4PpI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnhy1-0003CP-SM; Thu, 09 Aug 2018 10:14:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6959E1124347; Thu,  9 Aug 2018 11:14:53 +0100 (BST)
Date:   Thu, 9 Aug 2018 11:14:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v5 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180809101453.GD6132@sirena.org.uk>
References: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
 <1533653540-24796-4-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <1533653540-24796-4-git-send-email-stefan.popa@analog.com>
X-Cookie: UNIX enhancements aren't.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 05:52:17PM +0300, Stefan Popa wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>=20
> The regmap API usually assumes that bulk read operations will read a
> range of registers but some I2C/SPI devices have certain registers for

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/r=
egmap-noinc-read

for you to fetch changes up to 74fe7b551f3385fa585d92616c85b3a575b2b2cb:

  regmap: Add regmap_noinc_read API (2018-08-09 11:00:15 +0100)

----------------------------------------------------------------
regmap: Support non-incrementing registers

Some devices have individual registers that don't autoincrement the
register address during bulk reads but instead repeatedly read the same
value, for example for monitoring GPIOs or ADCs.  Add support for these.

----------------------------------------------------------------
Crestez Dan Leonard (1):
      regmap: Add regmap_noinc_read API

 drivers/base/regmap/internal.h |  3 ++
 drivers/base/regmap/regmap.c   | 79 ++++++++++++++++++++++++++++++++++++++=
+++-
 include/linux/regmap.h         | 19 ++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltsFBwACgkQJNaLcl1U
h9AwzAf9G5jIyT2s7YVz52yfMsuS6N1K4QWtidmqdlvpf4lsJBHl705VZC4JkFTV
tLA3Aetv8lFmxfSm5ePOmSjpYxg0N2vflgHxAbDMqcyaUQutV0vHcVAeMZ5Q0lZP
xk3BDi48esQbvjeyPxJKcPgC8WpOhVzVdrcmGBNJo+aOj6UKYQKurh2P5LVZDYL9
qJzOaPmC95DaJYAaddNTtq8G7o/bUvTpvYnaMNqicyKLLdmvjNunEDiLAXcx6h+t
TGGRs0TFJ8WFfJ+sLX24KrRR945voVIEYzETpBS3iVwe8Tz9jVfMjyWAaizBtDpo
BNB+GDHU07RlkgimF2S9huU5BfAtGg==
=Wwqu
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
