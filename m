Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1DCC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D75A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvZw8zG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D75A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeKUCIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:08:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39133 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKUCIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:08:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so2306015edt.6;
        Tue, 20 Nov 2018 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4CkKGnCggiihM41OdlZ/ssZOHgdRJWyUZ5YWiGRK8HU=;
        b=KvZw8zG+Ea69tGy0mLudgTra8PqVwZvign1XYOqaTiHv2hDz4pKIesqlRLHfk5K9QH
         E8LKXBqgeKvBOnDArtffYonegU4sIrUh3SPKxgHMPZysdP6Txpv/2TbbVTR7nnHMpZ2n
         xABSIed0ZLBtr9bhB4DYQdTKDLOrWhaxyZmAFBNFL6nJ3dAFxU4dEFySyXP/mw7eHkD1
         Y4RdRQON3qG9hz3L2oonkQZGI7QThGq1jEFBsNmLU7LAR7AVDyYN/S4ERxxBU0wyZ1lK
         7pwc21UndVoLjkDNQR9POSnXabeOebyvBgoCJnkAOIihOyaWaRBWWtafNAIiH/TReahg
         km9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4CkKGnCggiihM41OdlZ/ssZOHgdRJWyUZ5YWiGRK8HU=;
        b=Yjvr3aeSUHTZXKFhUSxVlHueWmwRlFv/zdKHe4ZwrpVBWceIQICYYJiUfS7Va+HEVz
         WT+kDokhsPhuB7URYLaLZtunagflIV+irPy2tyRq4nvbYxlPlfQPWx+uIigDKWpNuob1
         9qmxU2qEtKW66JDzYSZVY3cZLST1L32reECA0ll6BNd4/ZJWd/jgJdy15kTC5bQCPAw0
         JRfF920i8th/HHTRm6NF6bs9/Z+GAQtD09x8pGP7qMZdWyRStyNt7By0tJZpjDjoK2V0
         pDSpoS+L7qRMqDNt9AJ71CCYT90x2+Wt64687tIM5IyMYJoZTEoVXxOPESH2/k3nIbWz
         UUPA==
X-Gm-Message-State: AGRZ1gLWP9NYaDEv+JWVXiM5zRidTOQoHupZimvm7FL8lxGR57It+v/g
        x9fEXlRuNQOE3zLWqHRTij9w3XPi
X-Google-Smtp-Source: AJdET5euoub/rnb8C43MWiHTz6/f1LCoB1DTDuekqXZTYnPYxAS45M0es07StAT1j/f0CXehsN5nsQ==
X-Received: by 2002:a17:906:4e82:: with SMTP id v2-v6mr2301797eju.149.1542728315499;
        Tue, 20 Nov 2018 07:38:35 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id r8-v6sm7297619ejb.52.2018.11.20.07.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 07:38:34 -0800 (PST)
Date:   Tue, 20 Nov 2018 16:38:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: tegra: add get_trend ops
Message-ID: <20181120153833.GB28796@ulmo>
References: <1542705077-29697-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <1542705077-29697-1-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2018 at 05:11:17PM +0800, Wei Ni wrote:
> Add support for get_trend ops that allows soctherm
> sensors to be used with the step-wise governor.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index ed28110a3535..d2951fbe2b7c 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -488,9 +488,43 @@ static int tegra_thermctl_set_trip_temp(void *data, =
int trip, int temp)
>  	return 0;
>  }
> =20
> +static int tegra_thermctl_get_trend(void *data, int trip,
> +				    enum thermal_trend *trend)
> +{
> +	struct tegra_thermctl_zone *zone =3D data;
> +	struct thermal_zone_device *tz =3D zone->tz;
> +	int trip_temp, temp, last_temp, ret;
> +
> +	if (!tz)
> +		return -EINVAL;
> +
> +	ret =3D tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&tz->lock);
> +	temp =3D tz->temperature;
> +	last_temp =3D tz->last_temperature;
> +	mutex_unlock(&tz->lock);
> +
> +	if (temp > trip_temp) {
> +		if (temp >=3D last_temp)
> +			*trend =3D THERMAL_TREND_RAISING;
> +		else
> +			*trend =3D THERMAL_TREND_STABLE;
> +	} else if (temp < trip_temp) {
> +		*trend =3D THERMAL_TREND_DROPPING;
> +	} else {
> +		*trend =3D THERMAL_TREND_STABLE;
> +	}
> +
> +	return 0;
> +}

This looks like a reimplementation of the get_tz_trend() helper. Is
seems like that helper already has everything we need. Perhaps this
isn't working because of-thermal installs of_thermal_get_trend(), a
function that returns -EINVAL if the driver doesn't implement the
->get_trend() callback.

Perhaps a better way would be to do something like this in
thermal_zone_of_add_sensor():

	if (ops->get_trend)
		tzd->ops->get_trend =3D of_thermal_get_trend;

That's similar to how ->set_trips() and ->set_emul_temp() are set up
and should make sure that get_tz_trend() will do the right thing for
all drivers that don't implement a special ->get_trend().

Thierry

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv0KnkACgkQ3SOs138+
s6FoDw//UG4y7JbUCh7i9E6+FBy3aReerfGVH6JVQUw3M7bi0oIlfXumecDdq8Mn
BcP781sws3DgLFXl4wJ1pFhPLWpxuV8ArNS0cRL+Cw53oTQ5WeUXipVTKaC6+wRb
j7aGgABz3FfWdCJpFlSrNHbfd3S+FS2Gq+Uo96cUKDGiLCtOx/Bzt5HC8MuQBl4p
T+Q4wdzNy+Zfha4kdGFtGvuuVU8sZsJgEFoRhA1AyD/cOSNnfq0KghTGZZ+SWiol
rZPuNcWivE7UsrW+f9RNGOJG1yWKb/XS3OArUDo1nIRv94HUxODA/2isIO2HOT7A
pRUpynXJ++Wjo46pwdCJYMkF1nrzyHlfY02VDIWopVf5dsfBuhYz979RF5S3bmQT
+nXP8EIZU8l3chdGwHPTQCfE8yRHhcNSEvrTqqLKEdJ7xCkpXQZCaLnanlfO5K3D
xq/o9Uh1PNTGKEcXypeK93o9HRE3BrcxXXV7Bp4vjnz1MNa4R0NDU12+/IPC6uCC
WnykaKgFI+OqCdTqhV70mUKg3YN3BvGtX9oi0oKKdc9OV8dtOfSKMh1uJJuJi0SS
Py6k3ZUI8BsMxCvdr9sY946byCLej6oNkMD0WbzpqHY+clDCZp3uBL4Z9K9jffRI
+URAjV9fVZAVrdLWr8O+hbSCmO9hPryuJRRI85s8kQ05BHwqjWQ=
=JRWz
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
