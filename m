Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93443C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8432087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+5r2i0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8432087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeJVTwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbeJVTvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:51:41 -0400
Received: from earth.universe (unknown [185.7.230.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CA672087D;
        Mon, 22 Oct 2018 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540208010;
        bh=r3uw0TOS/iNvLkqiWaJa0FLl9eyWDb4wjPbgjATDcII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+5r2i0KP9i5jyjBRzts/xWtCZRSaVDC8YohIk+/u5bf9BDvUbhDGO2J/MJ/DTFVF
         H2xjWaECwcMzUkN7vZ2H83Fa5B2/kemf9wwlBSHG9TGFpI10rg+fLO8rZpjI/p+zs5
         pHuIU7946iKgRxtsHETH+NXnHl6t51ZTiXTzWADc=
Received: by earth.universe (Postfix, from userid 1000)
        id 6E3F03C098E; Sun, 21 Oct 2018 23:16:45 +0200 (CEST)
Date:   Sun, 21 Oct 2018 23:16:45 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 5/7] power: supply: add AC power supply driver for
 AXP813
Message-ID: <20181021211645.g7yrfudolmrtayb5@earth.universe>
References: <20181013080848.29894-1-oskari@lemmela.net>
 <20181013080848.29894-6-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mhir7tnyekmtbebi"
Content-Disposition: inline
In-Reply-To: <20181013080848.29894-6-oskari@lemmela.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mhir7tnyekmtbebi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 13, 2018 at 11:08:46AM +0300, Oskari Lemmela wrote:
> AXP813 and AXP803 PMICs can control input current and
> minimum voltage.
>=20
> Both of these values are configurable.
>=20
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---

Looks good to me apart from Chen-Yu Tsai's comments.

-- Sebastian

>  drivers/power/supply/axp20x_ac_power.c | 92 ++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h             |  1 +
>  2 files changed, 93 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/suppl=
y/axp20x_ac_power.c
> index 0771f951b11f..059a97d6e14c 100644
> --- a/drivers/power/supply/axp20x_ac_power.c
> +++ b/drivers/power/supply/axp20x_ac_power.c
> @@ -27,6 +27,16 @@
>  #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
>  #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
> =20
> +#define AXP813_VHOLD_MASK		GENMASK(5, 3)
> +#define AXP813_VHOLD_UV_TO_BIT(x)	((((x) / 100000) - 40) << 3)
> +#define AXP813_VHOLD_REG_TO_UV(x)	\
> +	(((((x) & AXP813_VHOLD_MASK) >> 3) + 40) * 100000)
> +
> +#define AXP813_CURR_LIMIT_MASK		GENMASK(2, 0)
> +#define AXP813_CURR_LIMIT_UA_TO_BIT(x)	(((x) / 500000) - 3)
> +#define AXP813_CURR_LIMIT_REG_TO_UA(x)	\
> +	((((x) & AXP813_CURR_LIMIT_MASK) + 3) * 500000)
> +
>  #define DRVNAME "axp20x-ac-power-supply"
> =20
>  struct axp20x_ac_power {
> @@ -102,6 +112,55 @@ static int axp20x_ac_power_get_property(struct power=
_supply *psy,
> =20
>  		return 0;
> =20
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		ret =3D regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval =3D AXP813_VHOLD_REG_TO_UV(reg);
> +
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval =3D AXP813_CURR_LIMIT_REG_TO_UA(reg);
> +
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int axp813_ac_power_set_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					const union power_supply_propval *val)
> +{
> +	struct axp20x_ac_power *power =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		if (val->intval < 4000000 || val->intval > 4700000)
> +			return -EINVAL;
> +
> +		return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
> +					  AXP813_VHOLD_MASK,
> +					  AXP813_VHOLD_UV_TO_BIT(val->intval));
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		if (val->intval < 1500000 || val->intval > 4000000)
> +			return -EINVAL;
> +
> +		return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
> +					  AXP813_CURR_LIMIT_MASK,
> +					  AXP813_CURR_LIMIT_UA_TO_BIT
> +					  (val->intval));
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -109,6 +168,13 @@ static int axp20x_ac_power_get_property(struct power=
_supply *psy,
>  	return -EINVAL;
>  }
> =20
> +static int axp813_ac_power_prop_writeable(struct power_supply *psy,
> +					  enum power_supply_property psp)
> +{
> +	return psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> +	       psp =3D=3D POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
> +}
> +
>  static enum power_supply_property axp20x_ac_power_properties[] =3D {
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_PRESENT,
> @@ -123,6 +189,14 @@ static enum power_supply_property axp22x_ac_power_pr=
operties[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
>  };
> =20
> +static enum power_supply_property axp813_ac_power_properties[] =3D {
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +};
> +
>  static const struct power_supply_desc axp20x_ac_power_desc =3D {
>  	.name =3D "axp20x-ac",
>  	.type =3D POWER_SUPPLY_TYPE_MAINS,
> @@ -139,6 +213,16 @@ static const struct power_supply_desc axp22x_ac_powe=
r_desc =3D {
>  	.get_property =3D axp20x_ac_power_get_property,
>  };
> =20
> +static const struct power_supply_desc axp813_ac_power_desc =3D {
> +	.name =3D "axp813-ac",
> +	.type =3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties =3D axp813_ac_power_properties,
> +	.num_properties =3D ARRAY_SIZE(axp813_ac_power_properties),
> +	.property_is_writeable =3D axp813_ac_power_prop_writeable,
> +	.get_property =3D axp20x_ac_power_get_property,
> +	.set_property =3D axp813_ac_power_set_property,
> +};
> +
>  struct axp_data {
>  	const struct power_supply_desc	*power_desc;
>  	bool				acin_adc;
> @@ -154,6 +238,11 @@ static const struct axp_data axp22x_data =3D {
>  	.acin_adc =3D false,
>  };
> =20
> +static const struct axp_data axp813_data =3D {
> +	.power_desc =3D &axp813_ac_power_desc,
> +	.acin_adc =3D false,
> +};
> +
>  static int axp20x_ac_power_probe(struct platform_device *pdev)
>  {
>  	struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
> @@ -234,6 +323,9 @@ static const struct of_device_id axp20x_ac_power_matc=
h[] =3D {
>  	}, {
>  		.compatible =3D "x-powers,axp221-ac-power-supply",
>  		.data =3D &axp22x_data,
> +	}, {
> +		.compatible =3D "x-powers,axp813-ac-power-supply",
> +		.data =3D &axp813_data,
>  	}, { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 517e60eecbcb..2302b620d238 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -266,6 +266,7 @@ enum axp20x_variants {
>  #define AXP288_RT_BATT_V_H		0xa0
>  #define AXP288_RT_BATT_V_L		0xa1
> =20
> +#define AXP813_ACIN_PATH_CTRL		0x3a
>  #define AXP813_ADC_RATE			0x85
> =20
>  /* Fuel Gauge */
> --=20
> 2.17.1
>=20

--mhir7tnyekmtbebi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvM7L0ACgkQ2O7X88g7
+poHAg//Z16M6EShkrvd9ccrxlcV7nkv08XaxTvLMGlZNg9JhuO/yE38Lu0P8lwm
i2fRYjSA1dlHgxay7t4oMuhj5Ws/Azxp88Ro/3CUKy/IdmChVlAp3f0UZSInDKkI
c46rWFf/MtWnDLMI28dIfrLtC7wkqUQqrmXSmFUOT0O/oAgO4yh+ls981GteVzEf
cTxyZ7htNQEbdO0qXzaJ2bloqsNafePkBNIwoDe5nBjhnJE+akP8+LNgooSMPTdi
nNHlBXvhPqtCE530an4Ra5QU5sqLwTzU9iqlISGtKXnEHVlRguZ7mme6QOY0IWry
18Relry4yI6EhVAROGeW9jaBGcaA29QSsgAjlEmCCQgz6HGXNHe885QLMJyPdMWX
TLA5Jg88Mp/wcq8d1ohdcDDyBrs5uOkNgIo4XVgyCc1IHYpcsTuFa5JNLAGwSvDt
FJJYBpqFyx02ULTEkkmWO13zevjInJgQs2G9Ayz1NM+9J+4Q2ulLTfPalMxcEHCS
twgOm7OVLwBG5wYS1frIxMFmyXE8DPCrV6UGM5GD8JuK0hLUKiHgJk3Vavmsmv2g
JkUWFpzkyAcfGZxI1UZHU7+/Hot/3NMwlWmUcXi/UvaMW77KETj+91IujopmydO8
4LpYItDFyiyDmDOq5PNPbD0kJLSQA0BSiVfZ0z3KKben3Ywaf5I=
=WCP8
-----END PGP SIGNATURE-----

--mhir7tnyekmtbebi--
