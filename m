Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCB6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1636020854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1636020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbeGVXJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52584 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387926AbeGVXJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 035FD26BA64
Date:   Mon, 23 Jul 2018 00:11:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] power: supply: mark expected switch fall-throughs
Message-ID: <20180722221136.47vme5v3o4lvibeq@earth.universe>
References: <20180717212846.GA13179@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ce5nri3u7rvt6hh6"
Content-Disposition: inline
In-Reply-To: <20180717212846.GA13179@embeddedor.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ce5nri3u7rvt6hh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 17, 2018 at 04:28:46PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Addresses-Coverity-ID: 1394724 ("Missing break in switch")
> Addresses-Coverity-ID: 114958 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Thanks, queued into power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/axp20x_usb_power.c   | 1 +
>  drivers/power/supply/cros_usbpd-charger.c | 1 +
>  drivers/power/supply/wm8350_power.c       | 3 ++-
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 44f70dc..42001df 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -222,6 +222,7 @@ static int axp20x_usb_power_set_current_max(struct ax=
p20x_usb_power *power,
>  	case 100000:
>  		if (power->axp20x_id =3D=3D AXP221_ID)
>  			return -EINVAL;
> +		/* fall through */
>  	case 500000:
>  	case 900000:
>  		val =3D (900000 - intval) / 400000;
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index 3a0c96f..688a16b 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -325,6 +325,7 @@ static int cros_usbpd_charger_get_prop(struct power_s=
upply *psy,
>  		 */
>  		if (ec_device->mkbp_event_supported || port->psy_online)
>  			break;
> +		/* fall through */
>  	case POWER_SUPPLY_PROP_CURRENT_MAX:
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/w=
m8350_power.c
> index a2740cf..15c0ca1 100644
> --- a/drivers/power/supply/wm8350_power.c
> +++ b/drivers/power/supply/wm8350_power.c
> @@ -230,7 +230,8 @@ static irqreturn_t wm8350_charger_handler(int irq, vo=
id *data)
>  	case WM8350_IRQ_EXT_USB_FB:
>  	case WM8350_IRQ_EXT_WALL_FB:
>  		wm8350_charger_config(wm8350, policy);
> -	case WM8350_IRQ_EXT_BAT_FB:   /* Fall through */
> +		/* Fall through */
> +	case WM8350_IRQ_EXT_BAT_FB:
>  		power_supply_changed(power->battery);
>  		power_supply_changed(power->usb);
>  		power_supply_changed(power->ac);
> --=20
> 2.7.4
>=20

--ce5nri3u7rvt6hh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltVARgACgkQ2O7X88g7
+pr9Mg/5AVlLy21NMHQS7ky144rxMyzQmgfH64rWs14c0ycUewCuuqC1BzOWaRFO
WbWNWb4BD5MUOznyhlTsEyhOj2beF46Rt5VCP/p76Hv5WQoG8HmxpjYaVHaf2Vtz
hr2mVSy9w0SHUnHzZZqqYoWe3Py6/mXuSouxaPE9poSpl+TAgJJuJ8Mmf5EK8R6Z
Nk8HOFpRn8VVA3LKs96+npI/7Fbq4M/3lkaCx6LDnICB2Qk+BTruJAEc2xrlgNag
eMfiy+Km5DbK+DgdrFgHDkBH26fSeUIkqppuduwqk1aCU3kcCd5Dtt6uwf8whKMW
9fUBsRnT6iVyrXI1uxJi6c6C18e/T2e3Gcv+yuKJlll5m/qG2w6a9xOZiBZy+47W
P1SZOiLOjbXeC9X6AKG0IhutSuGUNN1XKbGQLi4G96rJtvSOdCPJmnH5NSU40c4G
2P+AOdSm2Q/3/asGvgX6Lt0XS9gvHpXRKd1nCMD9EVXEiRFTprgaS61kcWpJXfnZ
CeE87wuDt5f4LsItc3uN6uMXbX6dQlVXfvSgKkAUF0Tj8cw1VR1LBor99BqTl6x/
gATE32Pdu0KtSXfdYPjxLcjsBv3ceUbaCQ8hVLdX125ul2TMcODpcWe+9WiZ4K4u
+bWDGMs6suNmEwzNQJZwwJ/zdt3YZRYa1bep46XjnKXFZ7+JKMQ=
=qD6s
-----END PGP SIGNATURE-----

--ce5nri3u7rvt6hh6--
