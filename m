Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3655839-1518125476-2-897267720550794167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518125475; b=U0ESouv5XGd32V+OKH0OpIE5CvV9g3qzFwEsX2On16T0G+j
    iaq2dV5+ecLQNSji8I2JGDiq9Twou2MSWejnehxFyzvNQrdhfFCD/XkX+Q9fYcGF
    DHgYhp4WiaFXeilsgukz4O6SeJ2G6/d4jgRZt4uUsaDty2xqk3LwK6mnRVe+HII9
    Eg/u62kWIB/9IM/GwtxlMxph+Ke93UTW7XS5wzP7PcKHUcgfrdNel59YA2xCVRku
    bMr1VJimqndJ8r2EY/2zNbbVym4FwvHKy4V4BSwBeMYL4TvEC/w+URWAh930FUhP
    4qyX5CHJ37ZA3OtkS/Arvn6fMxaBIIowiU/bJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518125475; bh=ifDie9aJh87nKTapjOlAQ/AfAv
    7OhOzSoxYJu12ObsU=; b=NlfOWn/3+qDOM7p+kZWLs8IIDYB6GdDbFTwDpJghYa
    4mYf6XzbSg3VJ6B4a9EOt6lhyerN7XpZJgV6W5xooUTn8TQ6NylXcWGO4iyzSTJR
    /0rvXsLY3JYWeSQLlUXp19Tku6IBF8z1nAC85xEq9HtUvtswrP5RwfMXzyvNuZET
    12Cew0WtfBezb5EVBYv5R05BH1m+VIv3pXbmfMo9Srt72SUmQ8Y0a3ZTA/k6/Yq9
    YyaKByRQyrQuFmCGhzVhznO6hVuvIrdQVe92reSzYiGQIrQERYshFCd1tYi5maMu
    RyyagPSgpT22CjlGUXLakKT5bYjR8SFOG3DVYtBElihw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBHVa7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 16:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751700AbeBHVa6 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 8 Feb 2018 16:30:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FFC21796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Thu, 8 Feb 2018 22:30:54 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Yueyao Zhu <yueyao.zhu@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v4 5/7] power: supply: Add 'connected_type' property and
 supporting code
Message-ID: <20180208213054.oqgoktru3lzjiyyn@earth.universe>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <3af7db87e0e6bdfa46ef3c1c9053297f711aee5a.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zwvh5ft5lvvhvzqw"
Content-Disposition: inline
In-Reply-To: <3af7db87e0e6bdfa46ef3c1c9053297f711aee5a.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: NeoMutt/20171215
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--zwvh5ft5lvvhvzqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 02, 2018 at 03:50:53PM +0000, Adam Thomson wrote:
> This commit adds the 'connected_type' property to represent supplies
> which can report a number of different types of supply based on a
> connection event.
>=20
> Examples of this already exist in drivers whereby the existing 'type'
> property is updated, based on an event, to represent what was
> connected (e.g. USB_DCP, USB_ACA, ...). Current implementations
> however don't show all supported connectable types, so this knowledge
> has to be exlicitly known for each driver that supports this.
>=20
> The 'connected_type' property is intended to fill this void and show
> users all possible types supported by a driver. The property, when
> read, shows all available types for the driver, and the one currently
> chosen is highlighted/bracketed. It is expected that the 'type'
> property would then just show the top-level type, such as 'USB', and
> this would be static.
>=20
> Currently the 'conn_type' enum contains all of the USB variant types
> that exist for the 'type' enum at this time, and in addition has
> the PPS type. In the future this can be extended further for other
> types which have multiple connected types supported. The mirroring
> is intentional so as to not impact existing usage of the 'type'
> property.
>=20
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Thanks for the patch. I think, that it's a good idea to provide the
subtype in its own property and just set the type property to "USB".
I would prefer to name this "usb_type". Otherwise

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  drivers/power/supply/power_supply_sysfs.c | 50 +++++++++++++++++++++++++=
++++++
>  include/linux/power_supply.h              | 15 ++++++++++
>  2 files changed, 65 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 5204f11..1b3b202 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -46,6 +46,11 @@
>  	"USB_PD", "USB_PD_DRP", "BrickID"
>  };
> =20
> +static const char * const power_supply_conn_type_text[] =3D {
> +	"Unknown", "USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
> +	"USB_PD", "USB_PD_DRP", "USB_PD_PPS", "BrickID"
> +};
> +
>  static const char * const power_supply_status_text[] =3D {
>  	"Unknown", "Charging", "Discharging", "Not charging", "Full"
>  };
> @@ -73,6 +78,46 @@
>  	"Unknown", "System", "Device"
>  };
> =20
> +static ssize_t power_supply_show_conn_type(struct device *dev,
> +					   enum power_supply_conn_type *conn_types,
> +					   ssize_t num_conn_types,
> +					   union power_supply_propval *value,
> +					   char *buf)
> +{
> +	enum power_supply_conn_type conn_type;
> +	ssize_t count =3D 0;
> +	bool match =3D false;
> +	int i;
> +
> +	if ((!conn_types) || (num_conn_types <=3D 0)) {
> +		dev_warn(dev, "driver has no valid connected types\n");
> +		return -ENODATA;
> +	}
> +
> +	for (i =3D 0; i < num_conn_types; ++i) {
> +		conn_type =3D conn_types[i];
> +
> +		if (value->intval =3D=3D conn_type) {
> +			count +=3D sprintf(buf + count, "[%s] ",
> +					 power_supply_conn_type_text[conn_type]);
> +			match =3D true;
> +		} else {
> +			count +=3D sprintf(buf + count, "%s ",
> +					 power_supply_conn_type_text[conn_type]);
> +		}
> +	}
> +
> +	if (!match) {
> +		dev_warn(dev, "driver reporting unsupported connected type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (count)
> +		buf[count - 1] =3D '\n';
> +
> +	return count;
> +}
> +
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf) {
> @@ -115,6 +160,10 @@ static ssize_t power_supply_show_property(struct dev=
ice *dev,
>  	else if (off =3D=3D POWER_SUPPLY_PROP_TYPE)
>  		return sprintf(buf, "%s\n",
>  			       power_supply_type_text[value.intval]);
> +	else if (off =3D=3D POWER_SUPPLY_PROP_CONNECTED_TYPE)
> +		return power_supply_show_conn_type(dev, psy->desc->conn_types,
> +						   psy->desc->num_conn_types,
> +						   &value, buf);
>  	else if (off =3D=3D POWER_SUPPLY_PROP_SCOPE)
>  		return sprintf(buf, "%s\n",
>  			       power_supply_scope_text[value.intval]);
> @@ -241,6 +290,7 @@ static ssize_t power_supply_store_property(struct dev=
ice *dev,
>  	POWER_SUPPLY_ATTR(time_to_full_now),
>  	POWER_SUPPLY_ATTR(time_to_full_avg),
>  	POWER_SUPPLY_ATTR(type),
> +	POWER_SUPPLY_ATTR(connected_type),
>  	POWER_SUPPLY_ATTR(scope),
>  	POWER_SUPPLY_ATTR(precharge_current),
>  	POWER_SUPPLY_ATTR(charge_term_current),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 79e90b3..e15a629 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -145,6 +145,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
>  	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
>  	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
> +	POWER_SUPPLY_PROP_CONNECTED_TYPE,
>  	POWER_SUPPLY_PROP_SCOPE,
>  	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
>  	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> @@ -170,6 +171,18 @@ enum power_supply_type {
>  	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  };
> =20
> +enum power_supply_conn_type {
> +	POWER_SUPPLY_CONN_TYPE_UNKNOWN =3D 0,
> +	POWER_SUPPLY_CONN_TYPE_USB_DCP,		/* Dedicated Charging Port */
> +	POWER_SUPPLY_CONN_TYPE_USB_CDP,		/* Charging Downstream Port */
> +	POWER_SUPPLY_CONN_TYPE_USB_ACA,		/* Accessory Charger Adapters */
> +	POWER_SUPPLY_CONN_TYPE_USB_TYPE_C,	/* Type C Port */
> +	POWER_SUPPLY_CONN_TYPE_USB_PD,		/* Power Delivery Port */
> +	POWER_SUPPLY_CONN_TYPE_USB_PD_DRP,	/* PD Dual Role Port */
> +	POWER_SUPPLY_CONN_TYPE_USB_PD_PPS,	/* PD Programmable Power Supply */
> +	POWER_SUPPLY_CONN_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
> +};
> +
>  enum power_supply_notifier_events {
>  	PSY_EVENT_PROP_CHANGED,
>  };
> @@ -196,6 +209,8 @@ struct power_supply_config {
>  struct power_supply_desc {
>  	const char *name;
>  	enum power_supply_type type;
> +	enum power_supply_conn_type *conn_types;
> +	size_t num_conn_types;
>  	enum power_supply_property *properties;
>  	size_t num_properties;
> =20
> --=20
> 1.9.1
>=20

--zwvh5ft5lvvhvzqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp8wYYACgkQ2O7X88g7
+pqDYRAAikXUJ4qhScEMJFmukhKFJe5iqLXOrNw4OmxhTYlRHNbenNP83CjzsxRX
b2Mv/5ZY8NxW9LHhhGxGjjzXuKaFh5g1Fopeth6kv/OTsFIBhTtdG/rZ+yJutVyH
uxOlqoAi4lrpCm96FcaIUDLImGlQsM/ARjmwsHS5vEgXiSb+roflP0Vr1LRMQz7B
CEwF/wndhQkFc3f02fKJPvZfxQL08ZRx/wcR1KQO2BbIrCcT5A+KKSlLCyio7P+U
k56/DGwNnGBIjca3X7Mn0siHbO2qj6sVE+0qu0EQ5AkKWckQkW937LTTOgZIz3vU
F+54QZs3M1pVstoyFWasJfiCp8RVeUQFSgPxTxGukNDJ46K98+umNrn8QeTUUgqQ
VQnwNa918KDZYrNvof287oJL6fDF0H6BBhuf5Dxrs5JmyZiJuiI5gShaCpZjuZ8V
OmctBm3by0CsmumU/CmEQXZgixyJN2iyHd3gLIuToeUK31XOHX6/FwJx7/S56qIj
RF0bRh6QX6qZm8vZaRRvJsOptGYXikV28PNnZt6cNOd/j5SVlSEw4oV2zyHrhSH1
5nRTR9UBJ5kjtqhDKwax4YwRDopklnYrJEhDgYpXUh1qiuquoFQLMD0sTgMok2dy
kv6RlIymBM342ybq9VLJuhBraJUEphEyRXudJG6RDnq0M6tUhvs=
=YJVv
-----END PGP SIGNATURE-----

--zwvh5ft5lvvhvzqw--
