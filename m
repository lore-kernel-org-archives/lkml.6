Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EE1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F012075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DWkVbHPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F012075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeGRPZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:25:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbeGRPZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3bZiLq81Cxs3BHeOvqv3+kt8haKApMVa+AO1QF5R2Kw=; b=DWkVbHPYlBamFLZvDQP5+kSlI
        Ad0pe9TmNiV0CCW7zQPm80sH+tpilq2sPLSLS7nhYwA9AfsqozTlq7p15NXNgbgdyfnTMvTextkXM
        yk1N7S1cQl6tRk+5EpBYigjTaSiX7BITvlV1tYEvUxjXzcXSR0uV+9kFjE3pnkWFivt7A=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffnjg-0003ef-T5; Wed, 18 Jul 2018 14:47:24 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffnjg-0003WS-0X; Wed, 18 Jul 2018 15:47:24 +0100
Date:   Wed, 18 Jul 2018 15:47:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH -next v4 1/3] regmap: add SCCB support
Message-ID: <20180718144723.GM5700@sirena.org.uk>
References: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
 <1531756070-8560-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrXiCraHbXeog9mY"
Content-Disposition: inline
In-Reply-To: <1531756070-8560-2-git-send-email-akinobu.mita@gmail.com>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nrXiCraHbXeog9mY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 17, 2018 at 12:47:48AM +0900, Akinobu Mita wrote:
> This adds Serial Camera Control Bus (SCCB) support for regmap API that
> is intended to be used by some of Omnivision sensor drivers.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-sccb

for you to fetch changes up to bcf7eac3d97f49d8400ba52c71bee5934bf20093:

  regmap: add SCCB support (2018-07-18 15:45:23 +0100)

----------------------------------------------------------------
regmap: Add support for SCCB

This is an I2C subset.

----------------------------------------------------------------
Akinobu Mita (1):
      regmap: add SCCB support

 drivers/base/regmap/Kconfig       |   4 ++
 drivers/base/regmap/Makefile      |   1 +
 drivers/base/regmap/regmap-sccb.c | 128 ++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h            |  35 +++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-sccb.c

--nrXiCraHbXeog9mY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPUvsACgkQJNaLcl1U
h9CHfwf/WlS+6f05pFZez91zy/MYpUBD++y4VxOnJn3t7kUo4VaFyYGLVXG9cx+e
b2LEyr52WkvjL/K61SeY1GDvo+ANBGcA26VTD6S22DIVBSekDEe4hh9tbkRcBMHE
kfLrSC+hdLX+bAv8Ws0kcKyNm5pOLTZPdNr0CoIo7yGK2nmH/54mOAfMroIS4RNb
xFjAGGoWbH7xXRrXuhe5PNdbzXecrE/pmKl/3IG6IN5gu2GYLd+niTgiM+X2Rv69
P29kD9izCb2rd8O1xl1UfudAGeJsZeerjtVqV7fc0YSIYNW3vQNbcC8pWvMmZ7Gb
W0iwocfPy2uzSnv8Jgz54PnROPubJg==
=CKOC
-----END PGP SIGNATURE-----

--nrXiCraHbXeog9mY--
