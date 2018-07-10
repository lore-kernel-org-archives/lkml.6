Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C888208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LqtgyWSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C888208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbeGJSjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:39:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34790 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbeGJSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ad9hMUl6RK1UFNtAW8eNrgJbJFVH8gHoz3XYYDmN6tc=; b=LqtgyWSdhaEi8EN00Ee6A0uKM
        3UCpOxMkDA0x4QoKoop/UjKBjNKOvfTpat5VhslHPiTXIagvhIkIFN+3m/H70BQ0cXqYUO5vLVHjD
        PxQyaGOdoRCGg25iDXtpwlUBoaZi42BcwN6+6EYyyK42zXytypsnNJUfj3XBFffQEOx04=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcwh2-00027d-GG; Tue, 10 Jul 2018 17:44:52 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcwh1-0000FE-PR; Tue, 10 Jul 2018 18:44:51 +0100
Date:   Tue, 10 Jul 2018 18:44:51 +0100
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
Subject: Re: [PATCH v2 2/2] regulator: uniphier: add regulator driver for
 UniPhier SoC
Message-ID: <20180710174451.GE8104@sirena.org.uk>
References: <1531186037-16630-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1531186037-16630-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Content-Disposition: inline
In-Reply-To: <1531186037-16630-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Cookie: To teach is to learn.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 10, 2018 at 10:27:17AM +0900, Kunihiko Hayashi wrote:

> +static int uniphier_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> +
> +	return regmap_update_bits(priv->regmap, rdev->desc->enable_reg,
> +				  rdev->desc->enable_mask,
> +				  rdev->desc->enable_val);
> +}

This is just regulator_enable_regmap() isn't it?  Same for disable,
unless I'm missing something (which is possible).

> +static int uniphier_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> +	unsigned int val;
> +	int ret = -EINVAL;
> +
> +	regmap_read(priv->regmap, rdev->desc->enable_reg, &val);
> +	val &= rdev->desc->enable_mask;
> +
> +	if (val == rdev->desc->enable_val)
> +		ret = 1;
> +	else if (val == rdev->desc->disable_val)
> +		ret = 0;
> +
> +	return ret;
> +}

This isn't *quite* regulator_is_enabled_regmap() as it explicitly checks
if the disable value is set and errors otherwise which would be a good
fix for that.  Could you do a patch for that?

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltE8JMACgkQJNaLcl1U
h9C0lAf9EN7tiUq+OQLkqrSK5NlvtDJpVLLFZf7YOZnTyPDjYxPlWsJCfEOTkk0g
Sbz0YPx+oeyjNrmrBQR/lbBbyNRmYCHQusBRRpCBuUsIM2Cd425NfHeXoTf7syQX
PYqPNQO0T8X4lc4S6pxppvOI+lqQjQXeIVQ+DXjQZt93jVsjIf7VGzdVVNatYyRe
EcthOmX3lr6C4rDWQqkFTdl1NRqibzWnzA0HRaH4vtNeVarWemNRB6KGVMaTF3Pv
w+Y1iwJSF5H5j/NLRIHgi2IBIbqMmz1EixmxR64YC13MpxAilFv4vJV2s+xLYzZb
OCbVychkBg9G50+dypHDtaIis8qSdA==
=+Iz7
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
