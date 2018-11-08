Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75863C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C322146E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pR2+6Koz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C322146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeKHVvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:51:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34766 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHVvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BSfJKbTAvAEVps4AeAdJIDvyRB429YMajVFXC9dr+m8=; b=pR2+6KozCeCvxaMqIgsQcD1Yo
        bm+b2zeIkHM237Yver5/RLbkz4xEJ0eWzyyHk52pVzGIEJIzO5oY3CBz5DG9Ogr7qjPKYNUvom7D5
        2i5RUdcGus1+RXX2ZuuAE7X9stEFbUWPLxP91LYq6wZh7JqPYgK50+EnbbwyUt8A9M79s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKjEb-0008Ij-PZ; Thu, 08 Nov 2018 12:16:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4E3761124D9D; Thu,  8 Nov 2018 12:16:29 +0000 (GMT)
Date:   Thu, 8 Nov 2018 12:16:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/6] regulator: lochnagar: Move driver to binding from DT
Message-ID: <20181108121629.GD6675@sirena.org.uk>
References: <20181108101405.14062-1-ckeepax@opensource.cirrus.com>
 <20181108101405.14062-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <20181108101405.14062-3-ckeepax@opensource.cirrus.com>
X-Cookie: I'm having a BIG BANG THEORY!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2018 at 10:14:01AM +0000, Charles Keepax wrote:

> +static const struct of_device_id lochnagar_of_match[] = {
> +	{ .compatible = "cirrus,lochnagar-regulator" },
> +	{},
> +};

This is obviously just dumping the Linux driver model into the DT, the
regulators are clearly different.  If you want to explicitly list the
regulators in DT it'd be better to reflect the hardware and enumerate
the regulators individually - you can use one driver for all the MICVDDs
and a separate one for VDDCORE for example.

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvkKRwACgkQJNaLcl1U
h9Bftgf/YG896fIVqX6Do66HLJIcHNJAzK00x3THF6XqoLUIBKhVrovcy7fW69jw
Vw2QDuIv8oet/R2vvKPFrx153wE1ADwU5CfBfufFigUi+OPJTAVKHzVZUurYEcnQ
ULPI+vcXMD8jDaKVFRIGIM9/CtPll/c1Rcu0T4WsCdAWXQ0C4lJ+gBe8Cge8kDTX
U3h0jvOIHd9mnWiK/GCfSINRDyeYGeVn1SXuMfYOlrmCkNou8TQVI/phg50Q6+2Q
C0f3oNXRlgQoQe01AqXussavzBQ7dAV1o8ClN3FFgfSkdZjfWy/APBcN5RuBmGAH
+Gjtsp7RPdWYoMk/weGZwBMXNt/8BQ==
=78JL
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
