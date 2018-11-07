Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCA0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A082085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="URdXQvdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A082085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeKHAYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:24:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56260 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeKHAYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HcDGpzFmdPz54w/eDo7mysv+gZrE7LMA4tYSCUejGUo=; b=URdXQvdV+zgsb0442pCp4mVTu
        1cTiUgwegG4S20dWlPeZ/cxSBvm8GodTS1SuSm8Wu7UYd4vwZWeE2pak+ptnssI6tSiwcQGXeigiU
        dW2lp0/eCRKiUpUxp8NsCx0+bB4Btf5XuPeXRuaqyM+TGNcAs9kYmN3ClDVRnLaXVZeqY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKPDJ-0006aH-Rs; Wed, 07 Nov 2018 14:53:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 343A01124E14; Wed,  7 Nov 2018 14:53:49 +0000 (GMT)
Date:   Wed, 7 Nov 2018 14:53:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     lgirdwood@gmail.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        boris.brezillon@bootlin.com
Subject: Re: [PATCH 1/2] regulator: act8945: Implement PM functionalities
Message-ID: <20181107145349.GA6809@sirena.org.uk>
References: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
 <1540570753-16370-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <1540570753-16370-2-git-send-email-claudiu.beznea@microchip.com>
X-Cookie: PURGE COMPLETE.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 04:19:48PM +0000, Claudiu.Beznea@microchip.com wrot=
e:

> +static unsigned int act8945a_of_map_mode(unsigned int mode)
> +{
> +	if (mode =3D=3D ACT8945A_DCDC_MODE_POWER_SAVING)
> +		return REGULATOR_MODE_STANDBY;
> +
> +	return REGULATOR_MODE_NORMAL;
> +}

This should error out if it gets an unknown value rather than silently
mapping it to normal - we don't know what the user intended to set here.
There should also be some binding documentation updates saying what the
values that can be set are.

> +static void act8945a_pmic_shutdown(struct platform_device *pdev)
> +{
> +	struct act8945a_pmic *act8945a =3D platform_get_drvdata(pdev);
> +	struct regmap *regmap =3D act8945a->regmap;
> +
> +	/*
> +	 * Ask the PMIC to shutdown everything on the next PWRHLD transition.
> +	 */
> +	regmap_write(regmap, ACT8945A_SYS_CTRL, 0x0);
>  }
> =20

This shutdown function appears to be independant of the mode setting and
would be better split out as a separate patch (you could have one patch
adding the regmap stuff, one for this and one for the mode setting).
It makes review a lot simpler if each patch does a minimal set of
changes.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvi/HwACgkQJNaLcl1U
h9AjUAf/X+WZCSFnCaLptlSyx3bSbfDqjwhXcTHPCFdi8kpE9K91VD6YjpHdWeU6
BjGcASumUktHi1Hd0wFAxlvzoA683OTmS9tEWmKdI/FtsqpzjqZqmJG9OYfQ2HtP
juwAYFduRaswN6CP9RS7G4DniYJSO1VnC6UfPfKWbicqDaByyDYvQ7v1IT2qOGjC
N8YCI7v0fnZ270y78XWFsW8iDDfIIw8nGaZAuUN5bgOcOcLlHAF0jiHLAByebYO4
P344faEDGfWchNWjmIqdhGR2Gtsk6J3QGcQJFM5mb0BXMxMSLq8LBXCUruYzj63N
O+9S5CbneOG3tdWhfICkGBcoY3gOQA==
=OI5M
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
