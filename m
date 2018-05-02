Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeEBK5P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:57:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBK5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:57:14 -0400
Date: Wed, 2 May 2018 12:57:10 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v3 2/3] power: supply: add cros-ec USBPD charger driver.
Message-ID: <20180502105710.bi3tztsjkpcby2ui@earth.universe>
References: <20180502095343.17092-1-enric.balletbo@collabora.com>
 <20180502095343.17092-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bpphou4g7zrvae6a"
Content-Disposition: inline
In-Reply-To: <20180502095343.17092-3-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bpphou4g7zrvae6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I found one more issue, otherwise the driver looks fine to me.

On Wed, May 02, 2018 at 11:53:42AM +0200, Enric Balletbo i Serra wrote:
> This driver gets various bits of information about what is connected to
> USB PD ports from the EC and converts that into power_supply properties.
>=20
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
[...]
> +static int cros_usbpd_charger_probe(struct platform_device *pd)
> +{
[...]
> +	for (i =3D 0; i < charger->num_charger_ports; i++) {
[...]
> +		psy =3D devm_power_supply_register_no_ws(dev, psy_desc,
> +						       &psy_cfg);
[...]
> +		ec_device->charger =3D psy;
> + }
[...]
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index f36125ee9245..a1eb39344231 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -19,6 +19,7 @@
>  #include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/notifier.h>
> +#include <linux/power_supply.h>
>  #include <linux/mfd/cros_ec_commands.h>
>  #include <linux/mutex.h>
> =20
> @@ -143,6 +144,7 @@ struct cros_ec_device {
>  			struct cros_ec_command *msg);
>  	int (*pkt_xfer)(struct cros_ec_device *ec,
>  			struct cros_ec_command *msg);
> +	struct power_supply *charger;
>  	struct mutex lock;
>  	bool mkbp_event_supported;
>  	struct blocking_notifier_head event_notifier;

I think cros_ec_device->charger can be dropped:

 * It is not cleared on power-supply removal
 * It randomly points to the last registered power-supply
 * It is only set, but never used

-- Sebastian

--bpphou4g7zrvae6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrpmYQACgkQ2O7X88g7
+pp8VRAAov4dApOUowd/wjGbnPgMOFLtozyvPmVzIGdna41WaSDyTQnmJiRP3k7a
clfrtXP+m5IdKEyxMYOH9AQoDYzb79Tr5dBxl8FOxnBrAmoVp0GHqScv5EhvG9s5
Lde4KEixA1AKkqeam6ada5bflvE0REU/D9NJ8aZObm/FaBo1qOt9oeVHn6a4ZnRM
KZ4XhJb2yCE5ml1GtgL0tDz6xh1RSCWBNiMhXHI/yL0h0p6sdSYuOz2gkr/cS7Ac
tASarNt0Tw3q1udC92ItJd+j8F69lQmRAoXvbkP/MAckVBr5ZOgamYAGXZyTgROX
R7jZC//0548MA9EGkRv1EShzFRaEPmVolXp9dc2Po2TkfzxMgH27/2C/6L5MxG19
gwll5RneHPS4J5/5OXUqBMtio4/v1Ku6D0+0gctAmDERPJKAaNmbAuB5T1hMhnZg
PfOj0ChRH2BG4wRkaRQ/cyy3qM4zsbfo3l1e+iNhsPt2+WTfZiWoZ+6iL/+K0UU9
p/rvprKY98dL4ya+iNr+f61ZCAfY6eudUj28t32BWQar0aSPkDpmuJNU53bghSj2
TbCaQXQX/06xCLnKWmzDC9JtjMGcbRWBSPH/BQ/dt5epXfTMt8Yqr/KGKMPJd1cp
FbhNaKC9JbcDIRIHSvX2654Q0eadVYNdGWvYkGI7dzpRfSJ70Yo=
=TJlz
-----END PGP SIGNATURE-----

--bpphou4g7zrvae6a--
