Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F94C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBF2208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XJ5x1jik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBF2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeKNDpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:45:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46870 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbeKNDpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M4VQJ6860cQi5dXHNiEkoJAFAq9LB38YrK35XX96EFo=; b=XJ5x1jikiWChM5060q/no8XDU
        +7oqXgB8f1w1TrHkvG0NGNBGWxWxm7Hzl+KOYFpnbpkYn/V6n7lYb/ZbYUqDKiA9eHxATQwCxBJiZ
        CdhQ1VKCtkjguNrP7vWc9nOZku4TKYWbVf1L3YqbdBf1gaEBGayrGCkeNIWlEepMbzvQ4=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMcl0-0002Ly-Ci; Tue, 13 Nov 2018 17:45:46 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8B862440078; Tue, 13 Nov 2018 17:45:39 +0000 (GMT)
Date:   Tue, 13 Nov 2018 09:45:39 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Andrei.Stefanescu@microchip.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        Cristian.Birsan@microchip.com, Claudiu.Beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: mcp16502: add regulator driver for
 MCP16502
Message-ID: <20181113174539.GB2089@sirena.org.uk>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542108563-10108-4-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <1542108563-10108-4-git-send-email-andrei.stefanescu@microchip.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 11:29:41AM +0000, Andrei.Stefanescu@microchip.com w=
rote:

> index 0000000..29c72d3
> --- /dev/null
> +++ b/drivers/regulator/mcp16502.c
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MCP16502 PMIC driver

Please make the entire comment a C++ comment so it looks more
intentional.

> +/*
> + * This macro is useful for iterating over all regulators and accessing =
their
> + * registers in a generic way or accessing a regulator device by its id.
> + */
> +#define BASE(i) (((i) + 1) << 4)

This macro name is likely to run into collisions at some point, a prefix
would be better.

> +static int mcp16502_update_regulator(struct regulator_dev *rdev,
> +				     bool hibernate,
> +				     unsigned int mask, unsigned int val)
> +{
> +	struct mcp16502 *mcp =3D rdev_get_drvdata(rdev);
> +	unsigned int reg =3D BASE(rdev_get_id(rdev));
> +
> +	reg +=3D (hibernate) ? OFFSET_MODE_HIB : OFFSET_MODE_A;

Please write this as a normal if statement to improve legibility.

> +static int mcp16502_read(struct regulator_dev *rdev, bool hibernate,
> +			 unsigned int mask)
> +{
> +	struct mcp16502 *mcp =3D rdev_get_drvdata(rdev);
> +	unsigned int reg =3D BASE(rdev_get_id(rdev));
> +	int ret, val;
> +
> +	reg +=3D (hibernate) ? OFFSET_MODE_HIB : OFFSET_MODE_A;
> +
> +	ret =3D regmap_read(mcp->rmap, reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	return val & mask;
> +}

I'm not convinced that these custom read/write functions are adding much
compared to just using the standard regmap helpers for things - they're
adding a bunch of code instead of data.  If you need extra helpers for
suspend mode just add those, I'm sure they'd be useful for other
drivers.

> +static unsigned int mcp16502_get_mode(struct regulator_dev *rdev)
> +{
> +	int val;
> +
> +	val =3D mcp16502_read(rdev, false, MCP16502_MODE_MASK);
> +	if (val < 0)
> +		return val;
> +
> +	if (val =3D=3D MCP16502_MODE_FPWM)
> +		return REGULATOR_MODE_NORMAL;
> +	else if (val =3D=3D MCP16502_MODE_AUTO_PFM)
> +		return REGULATOR_MODE_IDLE;
> +
> +	return REGULATOR_MODE_INVALID;
> +}

Please just write a switch statement to improve legibility.

> +/*
> + * mcp16502_is_enabled - regulator_ops is_enabled
> + */
> +static int mcp16502_is_enabled(struct regulator_dev *rdev)
> +{
> +	int val;
> +
> +	val =3D mcp16502_read(rdev, false, MCP16502_EN_MASK);
> +	if (val < 0)
> +		return val;
> +
> +	return !!val;
> +}

This can use regulator_is_enabled_regmap(). =20

> +	if (mode !=3D REGULATOR_MODE_NORMAL && mode !=3D REGULATOR_MODE_IDLE)
> +		return -EINVAL;
> +
> +	val =3D (mode =3D=3D REGULATOR_MODE_NORMAL) ? MCP16502_MODE_FPWM :
> +						MCP16502_MODE_AUTO_PFM;
> +
> +	return mcp16502_update_regulator(rdev, hibernate, MCP16502_MODE_MASK,
> +					 val);

Again a switch statement would be clearer.

> +static int mcp16502_get_status(struct regulator_dev *rdev)
> +{
> +	int mode =3D mcp16502_get_mode(rdev);
> +
> +	if (!mcp16502_is_enabled(rdev))
> +		return REGULATOR_STATUS_OFF;
> +	else if (mode =3D=3D REGULATOR_MODE_NORMAL)
> +		return REGULATOR_STATUS_NORMAL;
> +	else if (mode =3D=3D REGULATOR_MODE_IDLE)
> +		return REGULATOR_STATUS_IDLE;
> +
> +	return REGULATOR_STATUS_UNDEFINED;
> +}

The _status() function should only be implemented if there's hardware
support for reading back the actual status from the device, we already
know what we set through software.

> +#ifdef CONFIG_PM_SLEEP
> +static int mcp16502_suspend(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct mcp16502 *mcp =3D i2c_get_clientdata(client);
> +
> +	mcp16502_gpio_set_mode(mcp, MCP16502_MODE_HIB);
> +
> +	return 0;
> +}

This will put the regulators into hibernate mode before the system has
finished suspending which is likely to cause breakage - hibernate mode
in the PMIC is expected to be triggered by the SoC as it shuts down.

> +static int __init mcp16502_init(void)
> +{
> +	return i2c_add_driver(&mcp16502_drv);
> +}

module_i2c_driver.

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrDcIACgkQJNaLcl1U
h9C3gAf/SicsBuIH1Q+/QiqEoF8THWZCG+zUJj8KGARosNcy5l39rVowgiBL+nAY
ySXWaioNMEDNbaCF2Pd8jSK31IJerNcQk8VBtMX9ajFBb5Zt2spwJm910QtJqJGZ
u7bZ2Waq1Z+6cqaVfLXyIxSjQjiI+nNSgP+4AmsjkjlPzXtIWp4RInBf6DnaYh+N
G03t99XeJTnLCB3SCfxJrhTF5zsspHladXGp6NVS86vRfYVSyCSKc7E/rva03C6O
CR+XTqJE/zgvTpM+66FO9nvxEpjJV4yGQzEd25SDzyUT7oCMVmhc/kmifxutfCZp
yqvyaFNQMsQ4rNAvLO1whgsP7kdIkA==
=YXcl
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
