Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26186ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE3720658
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RupHv7gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE3720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeJVDmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbeJVDmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 23:42:31 -0400
Received: from earth.universe (unknown [62.214.5.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F092089E;
        Sun, 21 Oct 2018 19:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540150030;
        bh=7wsgEIPkHlIv/PgD+L5011mFTOj7cQKQh95mWCO+uqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RupHv7gwgOD7tw2dOgt7r/EsHXJruAadBu+FKBmsMr6579jXZqcWAD5fnyS/IODAG
         lDSA1ctJrcivu5snGaWquEenfx+I/KDj7vdkdFInfWKidKi1rnpXBTpfv41HW8yLRs
         fuIUrnXUoNw7bE5lhztnDfzVpqw3pnwtAy3VROys=
Received: by earth.universe (Postfix, from userid 1000)
        id 828F03C098D; Sun, 21 Oct 2018 18:22:10 +0200 (CEST)
Date:   Sun, 21 Oct 2018 18:22:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v5 2/6] power: supply: core: Add one field to present the
 battery internal resistance
Message-ID: <20181021162210.jq3bzgxnw4xucbvm@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
 <b70d55f008cfbbb79abf27018261d8a6f16e9673.1539915051.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zadvt6bl3wgb755k"
Content-Disposition: inline
In-Reply-To: <b70d55f008cfbbb79abf27018261d8a6f16e9673.1539915051.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zadvt6bl3wgb755k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 06:53:11PM +0800, Baolin Wang wrote:
> Add one field for 'struct power_supply_battery_info' to present the batte=
ry
> factory internal resistance.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Looks good to me.

-- Sebastian

> Changes from v4:
>  - None.
>=20
> Changes from v3:
>  - New patch in v3, which splits code into one separate patch.
>  - Add Linusw reviewed tag.
> ---
>  drivers/power/supply/power_supply_core.c |    3 +++
>  include/linux/power_supply.h             |    1 +
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index e853618..307e0995 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -579,6 +579,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  	info->charge_term_current_ua         =3D -EINVAL;
>  	info->constant_charge_current_max_ua =3D -EINVAL;
>  	info->constant_charge_voltage_max_uv =3D -EINVAL;
> +	info->factory_internal_resistance_uohm  =3D -EINVAL;
> =20
>  	if (!psy->of_node) {
>  		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
> @@ -616,6 +617,8 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  			     &info->constant_charge_current_max_ua);
>  	of_property_read_u32(battery_np, "constant_charge_voltage_max_microvolt=
",
>  			     &info->constant_charge_voltage_max_uv);
> +	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohm=
s",
> +			     &info->factory_internal_resistance_uohm);
> =20
>  	return 0;
>  }
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index f807691..d089566 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -326,6 +326,7 @@ struct power_supply_battery_info {
>  	int charge_term_current_ua;	    /* microAmps */
>  	int constant_charge_current_max_ua; /* microAmps */
>  	int constant_charge_voltage_max_uv; /* microVolts */
> +	int factory_internal_resistance_uohm;   /* microOhms */
>  };
> =20
>  extern struct atomic_notifier_head power_supply_notifier;
> --=20
> 1.7.9.5
>=20

--zadvt6bl3wgb755k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvMp7IACgkQ2O7X88g7
+poqng/9Ft61j2F8QNqbZ3meLD0Sw0omW44rldkmL4u2AnZwLAIBBDV5xu2uENOI
tdsqC/AB0+eb0Er6d/MwmPr7jnWFq0UqU/Vr+fL+Ia2F45z5cTWEkrewu+xNJR5l
rOtKl57zX4He5A/Ach2ugyJQEACKJ+WIEpxyfEXb4yWLPwIJQIrlZo69G/RB/WmB
Wq+kYvGH8uYMiQH7kY0c9yl2xTFM4Ar8aD2kGJR2xQV9P5ft7pX2oQD7OuWTKgA6
i2tTAjrOPUz4eIkV9lLSJrNDtQZwphJLjS/VFOU0ACp+JXq9j1Rzv/VCe2XmPtK2
SyzjxA2FKEel9vGVw4tX4ElXriu8QkpIcn8DLz78lxCzHFiilubhCX96L8WC15A4
jAIUmnflDnnTCpK/sOo8WJRw4fj8fEjWQN/LLQmhJJqSgfmmlAyWvbHWKtIS9ZCL
6wBUALl6Rr9nT3SP70pxOzIH2wX53tPRckYUfGqjg8b8vhsb+JOCxRSx9eQ/JsrE
pdWWK4u7oFBgYp6yeC/gp0ONOaLfuvXuNNx1Vk+SfAUuwikyIPLLvDx3PbOFENL+
J2A1d5X0bLjla+dKVNiXg9w1oqY7zpAop/Q6K8wPMnweiCufkRRcINaZ3EWP/TpW
7MOWjFSE6N4VE8GPX5bOjaEnE+MnCv4TIvHRryJ2WvepIMoBbMA=
=GikG
-----END PGP SIGNATURE-----

--zadvt6bl3wgb755k--
