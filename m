Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38861C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51195206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcvkmG30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeLNOaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:30:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36610 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbeLNOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:30:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id a18so6020456wmj.1;
        Fri, 14 Dec 2018 06:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wabwYK5lgcEzvyRKKkaYGZl1Q4WfbQXmFNqDcqZxRdY=;
        b=vcvkmG30OXIQZlGMLg/H8dWAAwrpuSlJCiiNvkjolaIL+cIEEY3r/CZjtxvIAIw5eY
         1EyA+mnj7MP2UuxYpQSxr5RIVJsCsAWOP4mTyRuj0XZzWsTUS9f1rTcoSc7TewSip5Lh
         qFuNh9bQh/eiH0DRNOKzxl8wgACfp/fO77q7NMj5qb5qCtshkCGFHlr65ebcRGSdFzbT
         Q2/pBGH/d47lt4S0RjGwI/NdqLvXXVRPryecYKkKVAvRgKXDPoltCrOsRZm00sCouBuq
         nJOZsIqODl5pTzRHkBLgj6x/cuauS6p4sj6oS/qH62IMWIRXQa3DLR+2BRrIWfxQsy4y
         RvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wabwYK5lgcEzvyRKKkaYGZl1Q4WfbQXmFNqDcqZxRdY=;
        b=aaw9zUsgA+DzAuifuSLm7w6OE4JE1oyn94EboyuqDTn+wlvq6VW7tL5A8Ne237rJnM
         bT8HP9KDjXdIUyZy5NvzszarednBf2c9u1+zTPZCUwn3h35xOivRJPNgjQhnQGtbHKZo
         hOrxDIPMSG+K+Bc1SvJiReQSVUZvbRLoeJYziiBHjLpFXTjFHe4ExcsIqyZ1a6mrlP7f
         zSSkGROZMh+HoxIKc01JeLKOBGBZvXihIjSvp91AfQ5gQPdehsiIpxXWoBgi68uIsRgJ
         1VQ/z314fRiEHVJFUuqp0sBFHCWs9onKipcJ8EUyeat6FpcyCW0cJzV1FktI+Ix1PFrN
         XHKw==
X-Gm-Message-State: AA+aEWb7qnd3ATSCEei8X4uFUY+VPSkUQYhCLxYV7/CZ8pvScRT+5Fyi
        9EsPHQ182WHMT2xrB2R1ePtKnqn4
X-Google-Smtp-Source: AFSGD/WqR2JzX35ioQ77Rlc9NFG1zlPZ18ZQA/cXC+OisGNzb7PstrMBV8pET1p8j2C3lw+4vXuIog==
X-Received: by 2002:a1c:cf0d:: with SMTP id f13mr3349766wmg.70.1544797798628;
        Fri, 14 Dec 2018 06:29:58 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t76sm7268890wme.33.2018.12.14.06.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 06:29:57 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:29:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com, srikars@nvidia.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] of: add nvidia,thermtrips property
Message-ID: <20181214142956.GF23379@ulmo>
References: <1544177407-20203-1-git-send-email-wni@nvidia.com>
 <1544177407-20203-2-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
In-Reply-To: <1544177407-20203-2-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 06:10:05PM +0800, Wei Ni wrote:
> Add optional property "nvidia,thermtrips".
> If present, these trips will be used as HW shutdown trips,
> and critical trips will be used as SW shutdown trips.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  .../bindings/thermal/nvidia,tegra124-soctherm.txt    | 20 ++++++++++++++=
+++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

This seems like an odd exception. Why not extend the list of trip point
types with a "shutdown" or "emergency" type that can be used for this?
This doesn't seem like NVIDIA specific functionality, so adding an
NVIDIA specific property doesn't seem right.

Also, please always Cc devicetree@vger.kernel.org and the device tree
bindings maintainers when sending updates for a binding. They need to
ack these kinds of patches and they can't do that if they don't get a
copy of the patch.

Cc'ing them now and quoting the full patch for reference.

Thierry

>=20
> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-so=
ctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soct=
herm.txt
> index b6c0ae53d4dc..ab66d6feab4b 100644
> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.=
txt
> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.=
txt
> @@ -55,10 +55,21 @@ Required properties :
>        - #cooling-cells: Should be 1. This cooling device only support on=
/off state.
>          See ./thermal.txt for a description of this property.
> =20
> +Optional properties:
> +- nvidia,thermtrips : When present, this property specifies the temperat=
ure at
> +  which the soctherm hardware will assert the thermal trigger signal to =
the
> +  Power Management IC, which can be configured to reset or shutdown the =
device.
> +  It is an array of pairs where each pair represents a tsensor id follow=
ed by a
> +  temperature in milli Celcius. In the absence of this property the crit=
ical
> +  trip point will be used for thermtrip temperature.
> +
>  Note:
> -- the "critical" type trip points will be set to SOC_THERM hardware as t=
he
> -shut down temperature. Once the temperature of this thermal zone is high=
er
> -than it, the system will be shutdown or reset by hardware.
> +- the "critical" type trip points will be used to set the temperature at=
 which
> +the SOC_THERM hardware will assert a thermal trigger if the "nvidia,ther=
mtrips"
> +property is missing. When the thermtrips property is present, the breach=
 of a
> +critical trip point is reported back to the thermal framework to impleme=
nt
> +software shutdown.
> +
>  - the "hot" type trip points will be set to SOC_THERM hardware as the th=
rottle
>  temperature. Once the the temperature of this thermal zone is higher
>  than it, it will trigger the HW throttle event.
> @@ -79,6 +90,9 @@ Example :
> =20
>  		#thermal-sensor-cells =3D <1>;
> =20
> +		nvidia,thermtrips =3D <TEGRA124_SOCTHERM_SENSOR_CPU 102500
> +				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
> +
>  		throttle-cfgs {
>  			/*
>  			 * When the "heavy" cooling device triggered,
> --=20
> 2.7.4
>=20

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwTvmEACgkQ3SOs138+
s6E3ERAAjLeML4kt1YycCG18gnwlUvlQOn3vbq2z03HMtv3tzh9Zm3sJFfaiUKYj
Ccxp1Nu93UGZut3TqodEP795mSiCD7lyJ4O2TdTXsfQpUmMiGjPLqVyQBpkNH/+i
DQrIA03TIgaITeBy0nAgk6HmqRW/FKO/XMzslOiNVIF5BmbLjGrdMY38gA3Pfr7+
bGupH2lhT5Imjrp+GcRwLlQrUVar0p0KD6NXneqg7t4KAeqrEgzd1nDVWIBhtSDh
YSl+FTggAv2g3VmqPucaBlPBFVKE93lRO5n+74IXL2smXESXMpud/HNhiJag1d3+
xGJE56VmJumoXRkKJLMNkhq2xvViiPDNrCjZ5qmbDqccJtXwozHvRX/nInL+aS+z
CDG69jo/qt6AawVsdxQ76ajMCuYbynCcDyQg4rSUFbTuQlc5Yr0WKJ26uS/kK2kG
ZUJlqzuvI5DjfbXYHErLYfExsTXedsvLd6xujD6brNkCpQfUUpy/wXj8Ar7gNCkg
aif/t+jDruNj/1IGagYg4poO1cooBgequQleVRwf23GkfFmNiAsfHy60JVac1NKh
GgBxm0Ykqb9KqApoQbOkW05aizg4+G8aIPxXEg0g5bDFa6trTUGPvieOYoPw6eeK
tVu+nLAJee9cyDxWyqKolMvveL80BnHgmWwBn+UkPH0ceQPdC8E=
=giga
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--
