Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB035ECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C232083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN1TYpxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C232083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeJVDm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbeJVDm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 23:42:29 -0400
Received: from earth.universe (unknown [62.214.5.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9396B2083C;
        Sun, 21 Oct 2018 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540150027;
        bh=wiQttENLXnk9hHEiXAptwf+UY40hE3B5VP57EAiFvEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PN1TYpxt0y1eR8Madv7uRJYVZ7xVrBElopfeB23fXBlGyuWGg9nyssTmXDtyX20nI
         YQjHnueWMzJrGtbB01/g38ctBZTi+e5/DdrHoqTDIlUFCUhgw/f4ftFblQB50SJ1aI
         Ltb0AG1nE/p0RB2tdLxG84YNfj5lan8lCAfNUOvM=
Received: by earth.universe (Postfix, from userid 1000)
        id 39C993C0995; Sun, 21 Oct 2018 18:26:29 +0200 (CEST)
Date:   Sun, 21 Oct 2018 18:26:29 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v5 4/6] power: supply: core: Add some helpers to use the
 battery OCV capacity table
Message-ID: <20181021162629.2rjsbqhmvx24cdno@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
 <f1529c567a340e4d31354a4b117954eeebf89942.1539915051.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m7za4vanxjulrryw"
Content-Disposition: inline
In-Reply-To: <f1529c567a340e4d31354a4b117954eeebf89942.1539915051.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m7za4vanxjulrryw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 06:53:13PM +0800, Baolin Wang wrote:
> We have introduced some battery properties to present the OCV table
> temperatures and OCV capacity table values. Thus this patch add OCV
> temperature and OCV table for battery information, as well as providing
> some helper functions to use the OCV capacity table for users.
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
>  - Split core modification into one separate patch.
>  - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
>=20
> Changes from v2:
>  - Use type __be32 to calculate the table length.
>  - Update error messages.
>  - Add some helper functions.
>=20
> Changes from v1:
>  - New patch in v2.
> ---
>  drivers/power/supply/power_supply_core.c |  123 ++++++++++++++++++++++++=
+++++-
>  include/linux/power_supply.h             |   19 +++++
>  2 files changed, 141 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 307e0995..58c4309 100644
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
>  	info->factory_internal_resistance_uohm  =3D -EINVAL;
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
> @@ -620,10 +626,125 @@ int power_supply_get_battery_info(struct power_sup=
ply *psy,
>  	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohm=
s",
>  			     &info->factory_internal_resistance_uohm);
> =20
> +	len =3D of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
> +	if (len < 0 && len !=3D -EINVAL) {
> +		return len;
> +	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
> +		dev_err(&psy->dev, "Too many temperature values\n");
> +		return -EINVAL;
> +	} else if (len > 0) {
> +		of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
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
> +		if (!list || !size) {
> +			dev_err(&psy->dev, "failed to get %s\n", propname);
> +			kfree(propname);
> +			power_supply_put_battery_info(psy, info);
> +			return -EINVAL;
> +		}
> +
> +		kfree(propname);
> +		tab_len =3D size / (2 * sizeof(__be32));
> +		info->ocv_table_size[index] =3D tab_len;
> +
> +		table =3D info->ocv_table[index] =3D
> +			devm_kzalloc(&psy->dev, tab_len * sizeof(*table),
> +				     GFP_KERNEL);
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
> +int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *t=
able,
> +				int table_len, int ocv)
> +{
> +	int i, cap, tmp;
> +
> +	for (i =3D 0; i < table_len; i++)
> +		if (ocv > table[i].ocv)
> +			break;
> +
> +	if (i > 0 && i < table_len) {
> +		tmp =3D (table[i - 1].capacity - table[i].capacity) *
> +			(ocv - table[i].ocv);
> +		tmp /=3D table[i - 1].ocv - table[i].ocv;
> +		cap =3D tmp + table[i].capacity;
> +	} else if (i =3D=3D 0) {
> +		cap =3D table[0].capacity;
> +	} else {
> +		cap =3D table[table_len - 1].capacity;
> +	}
> +
> +	return cap;
> +}
> +EXPORT_SYMBOL_GPL(power_supply_ocv2cap_simple);
> +
> +struct power_supply_battery_ocv_table *
> +power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
> +				int temp, int *table_len)
> +{
> +	int best_temp_diff =3D INT_MAX, best_index =3D 0, temp_diff, i;
> +
> +	if (!info->ocv_table[0])
> +		return NULL;
> +
> +	for (i =3D 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
> +		temp_diff =3D abs(info->ocv_temp[i] - temp);
> +
> +		if (temp_diff < best_temp_diff) {
> +			best_temp_diff =3D temp_diff;
> +			best_index =3D i;
> +		}
> +	}
> +
> +	*table_len =3D info->ocv_table_size[best_index];
> +	return info->ocv_table[best_index];
> +}
> +EXPORT_SYMBOL_GPL(power_supply_find_ocv2cap_table);
> +
> +int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
> +				 int ocv, int temp)
> +{
> +	struct power_supply_battery_ocv_table *table;
> +	int table_len;
> +
> +	table =3D power_supply_find_ocv2cap_table(info, temp, &table_len);
> +	if (!table)
> +		return -EINVAL;
> +
> +	return power_supply_ocv2cap_simple(table, table_len, ocv);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_batinfo_ocv2cap);
> +
>  int power_supply_get_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    union power_supply_propval *val)
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index d089566..84fe93f 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -309,6 +309,13 @@ struct power_supply_info {
>  	int use_for_apm;
>  };
> =20
> +struct power_supply_battery_ocv_table {
> +	int ocv;	/* microVolts */
> +	int capacity;	/* percent */
> +};
> +
> +#define POWER_SUPPLY_OCV_TEMP_MAX 20
> +
>  /*
>   * This is the recommended struct to manage static battery parameters,
>   * populated by power_supply_get_battery_info(). Most platform drivers s=
hould
> @@ -327,6 +334,9 @@ struct power_supply_battery_info {
>  	int constant_charge_current_max_ua; /* microAmps */
>  	int constant_charge_voltage_max_uv; /* microVolts */
>  	int factory_internal_resistance_uohm;   /* microOhms */
> +	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];/* celsius */
> +	struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_=
MAX];
> +	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
>  };
> =20
>  extern struct atomic_notifier_head power_supply_notifier;
> @@ -350,6 +360,15 @@ extern struct power_supply *devm_power_supply_get_by=
_phandle(
> =20
>  extern int power_supply_get_battery_info(struct power_supply *psy,
>  					 struct power_supply_battery_info *info);
> +extern void power_supply_put_battery_info(struct power_supply *psy,
> +					  struct power_supply_battery_info *info);
> +extern int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_t=
able *table,
> +				       int table_len, int ocv);
> +extern struct power_supply_battery_ocv_table *
> +power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
> +				int temp, int *table_len);
> +extern int power_supply_batinfo_ocv2cap(struct power_supply_battery_info=
 *info,
> +					int ocv, int temp);
>  extern void power_supply_changed(struct power_supply *psy);
>  extern int power_supply_am_i_supplied(struct power_supply *psy);
>  extern int power_supply_set_input_current_limit_from_supplier(
> --=20
> 1.7.9.5
>=20

--m7za4vanxjulrryw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvMqLUACgkQ2O7X88g7
+pqluA/7BpU6uBlgYBJ2XG7xV0Z7NBYNHGecHSO/Fvetd4KEmOFZLSNZL8pTXesf
wXHqwXh9cXErtUoTlntMWDlqadauUKqUAJ0dr+kMqp3eWoCz+Ni7d/kAihpBT89t
NtlPudBXVKspxiYVlosveOy64Kll7QjF6Lm6cjj/NSsoA31eH+MC1UzCiwX8Ar8S
as7uuJr2a5Tp5jBRoFK+ss6o24brTthf/NLvcx7WzLTnTy+QZRHNRlcnqQ3c4Bgs
gDFZZ2BT0QwTCQJ3z7pxB2AByJaO1KqDRlPofDohqm85CCIVKrkZke2/s9I7/A6D
nn70WP7UpEKGXwXeAh4tyLWmOi6XxqHuGf+t1CgKCUf7cJ4+8uOGAyI+uZqOuymU
CxPv0cKIgqUj2Cto/IhJPojyrZhtpw28A3/lLwPu+4CHMJaHawZaRh+gE9TpUekQ
OqPjeicnR/GuLjuijoIp39nGHnBLrLMpKFjDtVifdM9H3MRT78x8TVGrdJbvaXYv
zy4fdRjIkFL4feaqHNHcxF02rRZrdKMwl8JIkFrQ2weoF+jFKYQQ8z2Cy5OtXetr
DVg5JytTrDa99IKWAatTs/mLBYVj18nXN+S1rq2UA9e678zgfHAuCrVd8xqAPqNP
L8eHvBv32ASEej/P3oRdBDo6MG7PaeAJQrySUvOsAe76yIE2kbo=
=tzMI
-----END PGP SIGNATURE-----

--m7za4vanxjulrryw--
