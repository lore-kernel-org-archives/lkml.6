Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED739C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00FD23685
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544793478;
	bh=MCpYMuSme3tyzlzxVQvpdub+TdtnV8NMApqOjQnCuzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WAo2oV+mEQLrSqmTnewq3mwZbmIl1+Adl9paAKVBllzuTpWvTrp8pLbx19zew8Kwa
	 N0g5bu8UAVASZze+h5TGm1f7sYAd4/7fvV00yzd9wCSR7wCMPZrrvLvvaDaihSt/CT
	 oA8M0k5I4+/HnwYY0zxE2vG7Y7T715EK5K9u/j+0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00FD23685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbeLNNR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729706AbeLNNR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:17:57 -0500
Received: from earth.universe (host-091-097-030-218.ewe-ip-backbone.de [91.97.30.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE1A22846;
        Fri, 14 Dec 2018 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544793475;
        bh=MCpYMuSme3tyzlzxVQvpdub+TdtnV8NMApqOjQnCuzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWvOx8oL5J0oO1ZD2roI3aTINmmq5lB9Xe4Tilq+4iUNi/yOi7SsLLl0Vftrc24qa
         U2jl9q4m2Uxo1biuiM4++y1FF2rIxct/9P6Y+JyV5Qe+Mq3Y0+pcpRVGqVwWmzF6SB
         zu3xvEYTIHmuOPuo99rVo7PaDQe7k8Sd+L0sVv3s=
Received: by earth.universe (Postfix, from userid 1000)
        id AFE6A3C08A4; Fri, 14 Dec 2018 14:17:52 +0100 (CET)
Date:   Fri, 14 Dec 2018 14:17:52 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, linux-rtc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
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
        Gr eg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Message-ID: <20181214131752.3qfdbxk6z3hkp7cp@earth.universe>
References: <20181214114858.21231-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgqwv4ykv6pafxpf"
Content-Disposition: inline
In-Reply-To: <20181214114858.21231-1-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgqwv4ykv6pafxpf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 14, 2018 at 12:48:58PM +0100, Enric Balletbo i Serra wrote:
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for iio parts.
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>=20
> Changes in v3:
> - Add collected acks
> - Use a cros[-_]ec pattern instead of list all the files.
> - Add Guenter as a reviewer.
>=20
> Changes in v2:
> - Fix typo in Benson email address.
>=20
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7260191301b..437e036435d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3629,6 +3629,14 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platf=
orm.git
>  F:	drivers/platform/chrome/
> =20
> +CHROMEOS EC SUBDRIVERS
> +M:	Benson Leung <bleung@chromium.org>
> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +R:	Guenter Roeck <groeck@chromium.org>
> +S:	Maintained
> +N:	cros[-_]ec
> +F:	drivers/power/supply/cros_usbpd-charger.c
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:	Brian Austin <brian.austin@cirrus.com>
>  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
> --=20
> 2.19.2
>=20
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--lgqwv4ykv6pafxpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwTrX0ACgkQ2O7X88g7
+pp/yxAAgDkNnwL/12ET+OUIaYGlUvknCfQAjrIMeEQkOj/cNanVPk5rHbr+xsSt
ssO7WNBlyl45qUtUsQtGew2iSCIrn5LwWUb9rxiGpdEpLwx0nna1ZRIcN+lY/VOp
OtcoXftkfJq/b5b8Dc553TqbpHCRSTjJQmnbDaWwSLQwOGjezAa6Bu3BllnaRKEl
3XYwTmIy2Xfic/ONL7dHJT0+RSBbjrkVqNLg+4/Dtg9Nq5wfsik/XwGeDjc8ilYC
urGFnqAQF61nU53KCbekcAYhtGxBdMqGqZxnd63pFCgqzQwWpRHDtCkFj4aEVaJJ
kM1c8nVshjs/1+/6Ptlbej/2iTWK5dc5exkHFjin9UDhdXT0ypx8HnBQpVb5qOzA
kW5t+BJA+yQG4TEKOrCbJRkYF5Zxg2XIjkJf2nl0jo+TAmQRrG+RS8nh3/3S/x0F
ahjSjdNFIRoqsTwS82tNJ+r/Y8RkVaPNcFG7v4zBuZ0xmXYWaqhFnVyHmbeOv9ot
jFQNT0MhLYA56t76YWfJheElTKwi1BkJwPsduXfYsl144zsWTJkQzKTG+r/R0BSG
UZ6M2axDAosv4XFG3Zc43yRkrxaBMVIo2q3P703B2cdAQIxkSdCpPAQZU1q1DZcF
AuoH4VcsHpCcomhjpoa2RWLKNMokC5vMiCuLLdgDJhXafuZdbLk=
=7DkH
-----END PGP SIGNATURE-----

--lgqwv4ykv6pafxpf--
