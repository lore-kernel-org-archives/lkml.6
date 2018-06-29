Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BCDC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC64827CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="C3EkDPh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC64827CB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755103AbeF2LED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:04:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53092 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754814AbeF2LD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kbUesms0IOiv3Id5wh+b8NqCy7HraqEyzgREQ+UMZTY=; b=C3EkDPh9IokBe3Hd4nMqhJVL9
        /Xz8HqVvLcXcDVD5mBrtI2iDWfcqgaO4tnsat+8m/pABzTHEORvuMUW5bEQw+PMnwqZ9L9I7IqyBI
        ldhIYjBy8voOV5k2YqhNmVyNVXODGU5kHqrN1zvxvX0yri/ggDFskRBQjnMVz0nWw+OpQ=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYrBm-0007k5-0F; Fri, 29 Jun 2018 11:03:42 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYrBl-0002MM-7n; Fri, 29 Jun 2018 12:03:41 +0100
Date:   Fri, 29 Jun 2018 12:03:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 2/2] regulator: uniphier: add regulator driver for
 UniPhier SoC
Message-ID: <20180629110341.GA6556@sirena.org.uk>
References: <1530260533-19415-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1530260533-19415-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1530260533-19415-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Cookie: Thank God I'm an atheist.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 29, 2018 at 05:22:13PM +0900, Kunihiko Hayashi wrote:

> +++ b/drivers/regulator/uniphier-regulator.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Regulator controller driver for UniPhier SoC
> + * Copyright 2018 Socionext Inc.
> + * Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> + */

Please make the entire header a C++ comment so that it looks intentional
rather than mixing C and C++ like this.

> +static int uniphier_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> +	u32 val;
> +
> +	val = readl_relaxed(priv->base + rdev->desc->enable_reg);
> +	val &= ~rdev->desc->enable_mask;
> +	val |= rdev->desc->enable_val;
> +	writel_relaxed(val, priv->base + rdev->desc->enable_reg);
> +
> +	return 0;
> +}

Could you use a MMIO regmap for this driver?  All the operations look
like they're just straight up operations of the sort the standard
helpers support them and it means the driver will be able to take
advantage of any improvements the core makes for free.

Otherwise this looks great, and the above two issues can be fixed as
followup patches so I'll apply.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls2EgoACgkQJNaLcl1U
h9AsXgf+MRnX8FkOk0vX/KB9mHeOwDsvFGJLp/N7zOdoizH96U9cZwHFYB5CNPW1
Tm5bYkEGJwexsgKJaMxTmjLBoy6Fn0hFNezTIdkNccPqGRrFslRXDXmbtMqSbXP8
Ms9dDrcL/muaMlMwLvmdmsKwwyLT+Lc9av7O+IK2Nrvf598P0nT8TlG1OUT9IoS9
AN1LdRxou4r/Bua8fl8q71+oewZ3x7NOOOH/WI6kHUSp/6AqrMNwabixa//R3rK8
phi3VVo7q4iwgun7Uakyj2fdmpQeAc5jbnGdKQ/qdFlMY9PalH8LPoM2VFgMSgZd
+TatjwzgoeFOtMpFOat2c0KUgDxv+Q==
=F2Hb
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
