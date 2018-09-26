Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BA6214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="muTYVl9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BA6214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeIZUE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbeIZUE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:04:59 -0400
Received: from earth.universe (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D0D1208E4;
        Wed, 26 Sep 2018 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537969915;
        bh=my09wrW9ci//JdiEFsxygjjgmARhABR7I6liZ4o2u7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=muTYVl9x8jKoLV5zBHd2vvq8621O3P7Y+29HzKwrbLQrTWw8B214HNBSopXTNqzYu
         z/J6eGbbkXhPAJgDz+4y4LRTd8bEtbO6ypSzGWprIEeIPmWzyNWTqGMZIFGW2DIKhQ
         KdpbFHeUPqQUWmnYIiRIGJUbnb7GyaLEQK1SgtWc=
Received: by earth.universe (Postfix, from userid 1000)
        id 21BB73C09D6; Wed, 26 Sep 2018 15:51:50 +0200 (CEST)
Date:   Wed, 26 Sep 2018 15:51:50 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v2 2/4] power: supply: core: Introduce properties to
 present the battery OCV table
Message-ID: <20180926135150.fla2r4ilfco3atws@earth.universe>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <b78ff03ecd251b63430f05b505e02b19e196364e.1537930252.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75thj6og2rjp7i7z"
Content-Disposition: inline
In-Reply-To: <b78ff03ecd251b63430f05b505e02b19e196364e.1537930252.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--75thj6og2rjp7i7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 26, 2018 at 10:59:12AM +0800, Baolin Wang wrote:
> Some battery driver will use the open circuit voltage (OCV) value to look
> up the corresponding battery capacity percent in one certain degree Celsi=
us.
> Thus this patch provides some battery properties to present the OCV table
> temperatures and OCV capacity table values.
>=20
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |   14 +++++
>  drivers/power/supply/power_supply_core.c           |   63 ++++++++++++++=
+++++-
>  include/linux/power_supply.h                       |   11 ++++
>  3 files changed, 87 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> index 25b9d2e..ac2b303 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -23,6 +23,16 @@ Optional Properties:
>   - constant-charge-current-max-microamp: maximum constant input current
>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>   - internal-resistance-micro-ohms: battery internal resistance
> + - ocv-capacity-table-0: An array providing the battery capacity percent
> +   with corresponding open circuit voltage (OCV) of the battery, which
> +   is used to look up battery capacity according to current OCV value.
> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
> + ......
> + - ocv-capacity-table-n: Same as ocv-capacity-table-0
> + - ocv-capacity-table-temperatures: An array containing the temperature
> +   in degree Celsius, for each of the battery capacity lookup table.
> +   The first temperature value specifies the OCV table 0, and the second
> +   temperature value specifies the OCV table 1, and so on.
> =20
>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -44,6 +54,10 @@ Example:
>  		constant-charge-current-max-microamp =3D <900000>;
>  		constant-charge-voltage-max-microvolt =3D <4200000>;
>  		internal-resistance-micro-ohms =3D <250000>;
> +		ocv-capacity-table-temperatures =3D <(-10) 0 10>;
> +		ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>, ..=
=2E;
> +		ocv-capacity-table-1 =3D <4200000 100>, <4185000 95>, <4113000 90>, ..=
=2E;
> +		ocv-capacity-table-2 =3D <4250000 100>, <4200000 95>, <4185000 90>, ..=
=2E;
>  	};
> =20
>  	charger: charger@11 {
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 9f3452f..151ff03 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -570,7 +570,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  {
>  	struct device_node *battery_np;
>  	const char *value;
> -	int err;
> +	int err, len, index;
> =20
>  	info->energy_full_design_uwh         =3D -EINVAL;
>  	info->charge_full_design_uah         =3D -EINVAL;
> @@ -581,6 +581,12 @@ int power_supply_get_battery_info(struct power_suppl=
y *psy,
>  	info->constant_charge_voltage_max_uv =3D -EINVAL;
>  	info->internal_resistance_uohm       =3D -EINVAL;
> =20
> +	for (index =3D 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
> +		info->ocv_table[index]       =3D NULL;
> +		info->ocv_temp[index]        =3D -EINVAL;
> +		info->ocv_table_size[index]  =3D -EINVAL;
> +	}
> +
>  	if (!psy->of_node) {
>  		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
>  			 __func__);
> @@ -620,10 +626,65 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  	of_property_read_u32(battery_np, "internal-resistance-micro-ohms",
>  			     &info->internal_resistance_uohm);
> =20
> +	len =3D of_property_count_u32_elems(battery_np,
> +					  "ocv-capacity-table-temperatures");
> +	if (len < 0 && len !=3D -EINVAL) {
> +		return len;
> +	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
> +		dev_err(&psy->dev, "Too many temperature values\n");
> +		return -EINVAL;
> +	} else if (len > 0) {
> +		of_property_read_u32_array(battery_np,
> +					   "ocv-capacity-table-temperatures",
> +					   info->ocv_temp, len);
> +	}
> +
> +	for (index =3D 0; index < len; index++) {
> +		struct power_supply_battery_ocv_table *table;
> +		char *propname;
> +		const __be32 *list;
> +		int i, tab_len, size;
> +
> +		propname =3D kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
> +		list =3D of_get_property(battery_np, propname, &size);
> +		kfree(propname);
> +		if (!list || !size) {
> +			dev_err(&psy->dev, "failed to get ocv capacity table\n");

I think it's better to replace "ocv capacity table" with %s / propname.

> +			power_supply_put_battery_info(psy, info);
> +			return -EINVAL;
> +		}
> +
> +		tab_len =3D size / sizeof(*table);

I think this should be

tab_len =3D size / (2 * sizeof(__be32));

which decouples DT memory layout from kernel memory layout.

> +		info->ocv_table_size[index] =3D tab_len;
> +
> +		table =3D info->ocv_table[index] =3D devm_kzalloc(&psy->dev,
> +						tab_len * sizeof(*table),
> +						GFP_KERNEL);
> +		if (!info->ocv_table[index]) {
> +			power_supply_put_battery_info(psy, info);
> +			return -ENOMEM;
> +		}
> +
> +		for (i =3D 0; i < tab_len; i++) {
> +			table[i].ocv =3D be32_to_cpu(*list++);
> +			table[i].capacity =3D be32_to_cpu(*list++);
> +		}
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
> =20
> +void power_supply_put_battery_info(struct power_supply *psy,
> +				   struct power_supply_battery_info *info)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++)
> +		kfree(info->ocv_table[i]);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
> +
>  int power_supply_get_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    union power_supply_propval *val)
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 019452d..b0a2768 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -309,6 +309,12 @@ struct power_supply_info {
>  	int use_for_apm;
>  };
> =20
> +struct power_supply_battery_ocv_table {
> +	int ocv;	/* microVolts */
> +	int capacity;	/* percent */
> +};
> +
> +#define POWER_SUPPLY_OCV_TEMP_MAX 20
>  /*
>   * This is the recommended struct to manage static battery parameters,
>   * populated by power_supply_get_battery_info(). Most platform drivers s=
hould
> @@ -327,6 +333,9 @@ struct power_supply_battery_info {
>  	int constant_charge_current_max_ua; /* microAmps */
>  	int constant_charge_voltage_max_uv; /* microVolts */
>  	int internal_resistance_uohm;       /* microOhms */
> +	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];  /* celsius */
> +	struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_=
MAX];
> +	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
>  };
> =20
>  extern struct atomic_notifier_head power_supply_notifier;
> @@ -350,6 +359,8 @@ extern struct power_supply *devm_power_supply_get_by_=
phandle(
> =20
>  extern int power_supply_get_battery_info(struct power_supply *psy,
>  					 struct power_supply_battery_info *info);
> +extern void power_supply_put_battery_info(struct power_supply *psy,
> +					  struct power_supply_battery_info *info);
>  extern void power_supply_changed(struct power_supply *psy);
>  extern int power_supply_am_i_supplied(struct power_supply *psy);
>  extern int power_supply_set_input_current_limit_from_supplier(

Looks good to me. Technically this can result in existing users of
power_supply_get_battery_info leaking memory, if they have an OCV
table in DT.

-- Sebastian

--75thj6og2rjp7i7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlurjusACgkQ2O7X88g7
+poS+w/+KXo2vY47qj5s6fq95tMy7cI2512rUl003mIxeRLZiME9MaUCoHpP5RKp
PwobOfxmZfx7/QiRBmZsB0NPpUvZK8lUsxzgTta1RFrzCJbawDW0cWzehZW4QfkE
KPOTZNf9ICYDoQ5CPe7/pR73yYceTO8xPNryQR2ldONgUpNZL0j57CTOyPH4ijXk
aKaHVLCfmTF+U3MThp3385t9QPFAB8gjHNT7EDOYC44s+25zZcJzumKYAZJhY6b9
uuTH8ViGaJUDUde2kwx+ZDs0vzt6YXbEXaeECAR3olSkfMoIxhvYmJwZ78yno954
h5SY8ndADUcgGhZAihjCVvdeFiBQov5vR3Nn2nzkRYjMg4FCLM0pBx4aoki7pm8Z
gYzeJd3XZ+DmS/rdSGGGN5sJhAdfYYv1JUh7JzTofietWo9/I/sTRQOagcsDSkmE
ZZ2rPmnGYTIwsGTLAmSzCGyqeVFrGuoCMjQPSVH8uXQ7tL3ur/S/gOZodYhG3W4r
pLnpid+fRgznPWwL23HXVUR8dsKSZemNPC6j8gVj0OmnXDXnmGF+igQCP6bBN3qH
MOjEZOjIVaZ+nt08eDfrwZ64yydxluOneq7ufN4d0i38iuCeYUsC+qSqCwrZky5l
hF84gBqOL9h6cG+kVfoBUBRzgBluG2/Tk4bgU53uEARzVA9133k=
=DReh
-----END PGP SIGNATURE-----

--75thj6og2rjp7i7z--
