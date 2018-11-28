Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757E2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1128020832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVgcPh9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1128020832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeK1V0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:26:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46581 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeK1V0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:26:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so21565712edt.13;
        Wed, 28 Nov 2018 02:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k4H7Xm0CTNlwqyRSfRV5M6UF/vdgF3CYaGdBnwOOsfk=;
        b=jVgcPh9mH2xA5XELOJ9FE4NosF225ut6n7fOD7CgEtaBBFhDGy3VrgNdxpriP07sno
         wWQMrsDMSjLe7UbmZajP+6+dxlkB8WzeEASD3ZVSCzb19CXl2UaoyHmoCKut2k0zBsGB
         kKda1HMSL/1UQ0KDogoShp9By82X5Ok8mjGR6YhqBSp+GpSKFkA/Mg1s5osxMbcMr33D
         ETIBt45djo4tX9X8EwyoS9Tq5A9AQaO4IrfgBk8t8sCB3H2gK/+v50TP77Q6FSF+FHOE
         96iYEvb8eoIta3wfBAzrAX+8t8XnCZbkZZ+tf0toLjRfDy7BKReFFAL/OzCH08z/VUx/
         4FRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k4H7Xm0CTNlwqyRSfRV5M6UF/vdgF3CYaGdBnwOOsfk=;
        b=Ponp3NSIQjZRkmNFb/QeJPbXGB5W3njb1OMzFgdz7BoJ2nxytHRb9Vp/a0iR0cmCal
         J2jh0aaYjpQwqf+FluZ1EqDcGbZ9QebVbfPS9MvV+SCLtTCREZz4936fL+erHPHyMF9v
         VLBFunYjVBa7BPfwiTlA7jUKksICbd3CjGAfjrCh86WM7z2VK6D3MzwVSw2YuZqU5nwf
         Hx8tyhnYNpl11jQmL1TId9UzY45IAHug1AWYM81RqcUCPn4tEOIqkqqIvosMQimeIwj6
         4fSFn98SpDdNijFGJD2Ps24d0lY9Jml3Wr6cZAIuT8c1Ri1U27mJK3nUGVWY56iU7NUi
         CGoQ==
X-Gm-Message-State: AA+aEWaLOoTIf0yAeFRi9UXz0RX8QjIHjZRFuoOH7Z0Pb2sYsR/B96YH
        PWiYPBwXfFObu6ndY7q7BZE=
X-Google-Smtp-Source: AFSGD/UvHUb9sJosBRyUm/pNITd8Z8JUIx3ZNOdKkoUgxtdvHrOt5ksGh49tCCsLt2NEZSpGbYOg0Q==
X-Received: by 2002:a50:b85d:: with SMTP id k29mr29975444ede.86.1543400721982;
        Wed, 28 Nov 2018 02:25:21 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s27-v6sm999967ejm.14.2018.11.28.02.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:25:21 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:25:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] thermal: tegra: parse sensor id before sensor
 register
Message-ID: <20181128102520.GC20723@ulmo>
References: <1543383877-20555-1-git-send-email-wni@nvidia.com>
 <1543383877-20555-4-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <1543383877-20555-4-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 01:44:37PM +0800, Wei Ni wrote:
> Since different platforms may not support all 4
> sensors, so the sensor registration may be failed.
> Add codes to parse dt to find sensor id which
> need to be registered. So that the registration
> can be successful on all platform.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 46 ++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index 375cadbc24cd..79e4628224d7 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -1224,6 +1224,44 @@ static void soctherm_init(struct platform_device *=
pdev)
>  	tegra_soctherm_throttle(&pdev->dev);
>  }
> =20
> +static bool tegra_soctherm_find_sensor_id(int sensor_id)
> +{
> +	int id;

You might want to make this and the sensor_id parameter unsigned int to
match the signedness of the ID in the specifier arguments and the sensor
groups.

Thierry

> +	bool ret =3D false;
> +	struct of_phandle_args sensor_specs;
> +	struct device_node *np, *sensor_np;
> +
> +	np =3D of_find_node_by_name(NULL, "thermal-zones");
> +	if (!np)
> +		return ret;
> +
> +	sensor_np =3D of_get_next_child(np, NULL);
> +	for_each_available_child_of_node(np, sensor_np) {

Aren't we leaking np here? I think we need of_node_put() after
of_get_next_child() to make sure the reference to the "thermal-zones"
node is properly released.

> +		if (of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> +						 "#thermal-sensor-cells",
> +						 0, &sensor_specs))
> +			continue;
> +
> +		if (sensor_specs.args_count !=3D 1) {
> +			WARN(sensor_specs.args_count > 1,
> +			     "%s: wrong cells in sensor specifier %d\n",
> +			     sensor_specs.np->name, sensor_specs.args_count);
> +			continue;

This is odd. You check for args_count !=3D 1 but then WARN on args_count >
1. Shouldn't both of these conditions be the same?

> +		} else {

Also, since the above has "continue;", we don't really need the else
block.

> +			id =3D sensor_specs.args[0];
> +			if (sensor_id =3D=3D id) {

It might not be worth to store the ID in a separate variable, we could
just do:

	if (sensor_specs.args[0] =3D=3D sensor_id)

Thierry
> +				ret =3D true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	of_node_put(np);
> +	of_node_put(sensor_np);
> +
> +	return ret;
> +}
> +
>  static const struct of_device_id tegra_soctherm_of_match[] =3D {
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  	{
> @@ -1365,13 +1403,15 @@ static int tegra_soctherm_probe(struct platform_d=
evice *pdev)
>  		zone->sg =3D soc->ttgs[i];
>  		zone->ts =3D tegra;
> =20
> +		if (!tegra_soctherm_find_sensor_id(soc->ttgs[i]->id))
> +			continue;
>  		z =3D devm_thermal_zone_of_sensor_register(&pdev->dev,

I'd would prefer a blank line after the if block for readability.

>  							 soc->ttgs[i]->id, zone,
>  							 &tegra_of_thermal_ops);
>  		if (IS_ERR(z)) {
>  			err =3D PTR_ERR(z);
> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
> -				err);
> +			dev_err(&pdev->dev, "failed to register sensor %s: %d\n",
> +				soc->ttgs[i]->name, err);
>  			goto disable_clocks;
>  		}
> =20
> @@ -1434,6 +1474,8 @@ static int __maybe_unused soctherm_resume(struct de=
vice *dev)
>  		struct thermal_zone_device *tz;
> =20
>  		tz =3D tegra->thermctl_tzs[soc->ttgs[i]->id];
> +		if (!tz)
> +			continue;
>  		err =3D tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);

Same here:

		if (!tz)
			continue;

		err =3D ...

Thierry

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+bQ0ACgkQ3SOs138+
s6F/cQ//Vf8Nl9UGrETe7X0iojhxbFD3lElHpm9N8PLev8elRoyKjTDs5ixDFsry
Qv4+/5MpR/rsOGyAQ2t1ACR9Sy7n3juoqIisAZTXYTbxA8n9/j/Zq5zesL5Z2I4p
2HeRLtaFl186YNU9yQtcJsg6TwW+o3SwDRm+49XkQ0xopbcB+3p0dm8J55dOhnMz
F4bYrs3qoG+49i1EhL8oYhk5APdPxIg8TtWePXdEkZgVZ+v/VTuBoXHn/9HnCcOk
RAozYT8AB5wr3elLoXaQN/ijKZOEBPRmQoZ/BmbUVAwJd2G4tmEEy3WlSibU4C1d
VQgUW0JUr6/+v6Q1ohs/H2m9bnq/x9VbjoAI40IlJoPhvv2TZMGIWc2uj1vdJD6k
NuD87kmI+WgiiFOOE9ZpMy4RT7MTepBLpJICruz2ekY+RAbry/yK7/jfclTXWTtK
Ck+CaTm/cja/CEW3OfJ3dJvbgGFN52N6wOy/DUntlOsIWqtmFamvRbK0SgmyVV0q
3axq+c2dCZ3uHqWE8UKsobmDCXGue73j9vqCb+3o4hVfqKNQcw60J7EnzXN6FUhS
Lcc5MuvHidcBbOlbgQMxx3QEYhTKY/HnzO4p+omifourqHOxbEjf1QV5EoyW40DU
H+ozEkLZcB7igniaCR2QqBcgMdWjnDg2KAKxPP0b6IiSsUO/nwQ=
=w2OA
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
