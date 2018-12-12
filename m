Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E33EC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B64220851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfSe19RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B64220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeLLSVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:21:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42065 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeLLSVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:21:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so9246906pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TfLMIUPsQ/Tgdv+Bv726oQuQKjEmkzwS3S5+Q0SXy0w=;
        b=IfSe19RVaymu1st2qL9C6diCoHQYYPVSiCLwNqTUfeCPRZyZcTDZ1f45hw4kJxi8cU
         pFIJtplnxzPq7VfBNSPX1bUPSGUBYMrDZIM4aCT24MyDy3F3LXCMMy2zq6+m+Gj/JM2o
         5IL64FI5M/shFeiE9/blOuLcyFACwxVMhDA9IgpDen0PNWeXp8URDe3Lya2hlWwBhmzT
         Q8URhtGnKR/YX+POsHNb1lmOBQsLMsvVnrtOkWmjJ5NK8T8Vnxsp9wIaxch36tYtzIqt
         RfATu6tf52UMNROK0Z9qpeg5n3tz1/KTfnpz2NVpYctGRy5XcJZBfdLU03Pk7Ur/801x
         hSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TfLMIUPsQ/Tgdv+Bv726oQuQKjEmkzwS3S5+Q0SXy0w=;
        b=cfq/RRTVzK8KZ9leSB7NK1MdDKVffqThy7mqTiV0p4hiTreXs1KcCizgETmEdCtq5a
         rgNlW7b8CULtsM+C9x8sJzOae3vOxpMmXIzCQrzJnTLh7+I+76DNJG46xyXNcWVAH8v5
         6i0jlCCbQ5cP3L6wXI4aohjSPh44UvRPNiNx1sxDxkb0uQpP2i6/nUtO04NrIpQHOQh5
         F5yiSAptDm07kvMsic2ItFmbd0tnZwXbXFjUzUQr2bWFODfv+UhQ4q9qCvmMM3MdiGCV
         HT4zk5oNA5ZnONq3qTq0LeXlSwzEjaKBJrPohhp6MShfOP/GNTOGX/YOKMsS9eOfO4Dp
         iKBQ==
X-Gm-Message-State: AA+aEWbXGeqaOoExmYcxGhAeXe+3KdtLxbmnGgT4fVBrh/sebZyVZ8lA
        +FoO0JjOwG7kA+MvnxNDD5aAvmXIEgVxGPNV
X-Google-Smtp-Source: AFSGD/UpjeUUSYdhb5PJESFeg0in8R362Dy6KcFRoaER8BUwAT+yZ/4aTS2l/jkkjQ+kWvArZJpwAQ==
X-Received: by 2002:a63:fb10:: with SMTP id o16mr19077222pgh.211.1544638889697;
        Wed, 12 Dec 2018 10:21:29 -0800 (PST)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id b2sm25738206pgg.87.2018.12.12.10.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 10:21:28 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:21:26 -0800
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, linux-rtc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Message-ID: <20181212182126.GA32052@google.com>
References: <20181211190953.13626-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20181211190953.13626-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 08:09:52PM +0100, Enric Balletbo i Serra wrote:
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Signed-off-by: Benson Leung <bleung@chromium.org>

Thanks for sending this, Enric.

> ---
>=20
> Changes in v2:
> - Fix typo in Benson email address.
>=20
>  MAINTAINERS | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a24129b0b043..bbe7180e2851 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3625,6 +3625,30 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platf=
orm.git
>  F:	drivers/platform/chrome/
> =20
> +CHROMEOS EC SUBDRIVERS
> +M:	Benson Leung <bleung@chromium.org>
> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> +F:	Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> +F:	Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> +F:	Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
> +F:	Documentation/devicetree/bindings/mfd/cros-ec.txt
> +F:	Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> +F:	drivers/extcon/extcon-usbc-cros-ec.c
> +F:	drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +F:	drivers/iio/accel/cros_ec*
> +F:	drivers/iio/common/cros_ec_sensors/
> +F:	drivers/iio/light/cros_ec*
> +F:	drivers/iio/pressure/cros_ec*
> +F:	drivers/input/keyboard/cros_ec*
> +F:	drivers/mfd/cros_ec*
> +F:	drivers/power/supply/cros_usbpd-charger.c
> +F:	drivers/pwm/pwm-cros-ec.c
> +F:	drivers/rtc/rtc-cros-ec.c
> +F:	include/linux/iio/common/cros_ec_sensors_core.h
> +F:	include/linux/mfd/cros_ec*
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:	Brian Austin <brian.austin@cirrus.com>
>  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
> --=20
> 2.19.2
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlwRUaYACgkQHwn1ewov
5ljVzA/+LrEt1Rm2OOw/34K53k7jK/9/Y8LDf9Wp9RZ/BeOeZScECxRYkfKN9XL6
LUzgBp+z/BgBOy4BYOjAeH5rknXpVieJkH/3I8AIi33oEpeWC0KxkyyNJIWjj7D1
fq5Cz+DI9GKF4a/onTVsMYRoYftRLYTm+L/z3hJzLAYkqcwShs9ak15M/qDeFlZ8
KF/Im4yeInCBHg6giScg72tMV7zh40pBOTopcMbzXAHch56OzXE4i0PueJJFhhCb
BHesObxRHQEe+2TiijJRE1aoXKqKCwLwhz2uqo7qhnX+OItMUI2FQLkO0H8GrvZh
+9ZrENqy1rpLjYRWF92nHfv1FSXRhYHbidXHh045nSMdOElQqSQXDYa1JX9MNAZ5
IU1LXMkNRwOz717JgSe2SszlkOw9fQK2mHhxkbqhwzvxh50TX2QHIfcSDW3wiSQT
BW4sxqv8+DWKsOO2yPnq2wsG/AmaKDBSCUTif1U7e12G33etvychk1eN+4Dv8Fni
fGu416RC9xcUe8vqXi8fDfFEpgqu5NyIiVnZQ/MTnoyFjV7u1nut38FQQmfRbOUM
NMKLgGirJrY+ar4P/uyZvuakHpXEb0rZ7QGlWDcdtuoqMLlvSM8m35y9XTzhsVC3
B0NfMIoxmuw7FQiGK7tI8eCdF8/+aCPxmpcM49SQWF9SUu+tmPk=
=WY6c
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
