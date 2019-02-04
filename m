Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC21C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009F4214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJU4oZnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfBDH22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:28:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43970 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfBDH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:28:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so1510047wrv.10;
        Sun, 03 Feb 2019 23:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a/5ExtRoOJUGfM/9nExYxGCoEZBLuiCGfMLJSck9800=;
        b=dJU4oZnIjNNnytTvFLEsaZCwK/3pkxvRsbuQuqprszYECmgXub4B3PoAbQ6uQ+1Rob
         2EPdEejSxikdMknvvFitrYxeks531y8nj19D52lsZ8YAv3KCRwRl4xBsNXSDkHftYXmp
         5L/SqJqh3GwmTeJz9BIDQ2qSVALW+drcZYQgAXj/3b3eMqmVR5BoZ5k6QFKKVCru8zGa
         uCe9pmDIrb5AJkB4zcPo2EE2Eqkyl85HEfrs4O2WYEpvwTiK9r1Dp2d4o+IgCl6S/Tln
         XBnzJbg/9Q7CV2Wt+bvhcfHnxi4oG8ccE9TEXOnMEfBnROjtY7/9LjJpQfzcoUgxyL/r
         +9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a/5ExtRoOJUGfM/9nExYxGCoEZBLuiCGfMLJSck9800=;
        b=bB5GSoTBfF/2O2aLTaPfYRCzltMLGayDAyH6+lFkuRL7d5ImAqzKUfFs30f/XYNomS
         obzDb1MhXow8o1A5h9+RX/YJpdZYGiJChlwsuv+R0gZtHCQCOVKWP46wunb4T3SYAGUx
         IIgY5ioDUxyt4K/WJ3O6SO1bYd+PmNgut7RbRv+SKLSo2Vj2b0kdjspRf2V3NFAAuKlS
         xV8zC2NuzyA+BoUrTfm1ONnk9Bo0+Z5MbZcz/wpvKXW0pqQOfo+EypHYuuy4DRZ8/qNn
         UvdeqP1ILZ8sCJ0sDke+cFhEC0X3JUhE1vyh/9Z7gbuQJsLO9L4DVwcTM3eUwvPgwcOu
         70wQ==
X-Gm-Message-State: AHQUAuYeYgq/HMJ+BEwbGMht6EB+6Ib/pqIvg0YPmCdo6U/Tox2CDElL
        KrbxKx80sFbwamHMRO1PBDzW+b87kz8=
X-Google-Smtp-Source: AHgI3IZBxaI5F43BKA+aVLpUJiKg51dFpoRRoRJmf4zfMZ3Hn0iJ1Qb3uG/LWOwYXnT/V1syb8qi4Q==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr771982wrs.212.1549265306183;
        Sun, 03 Feb 2019 23:28:26 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id j3sm6722164wmb.39.2019.02.03.23.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 23:28:25 -0800 (PST)
Date:   Mon, 4 Feb 2019 08:28:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra124: add missing of_node_put()
Message-ID: <20190204072823.GA16448@ulmo>
References: <20190204063501.1348-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20190204063501.1348-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 01:35:01AM -0500, Yangtao Li wrote:
> of_cpu_device_node_get() will increase the refcount of device_node,
> it is necessary to call of_node_put() at the end to release the
> refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra12=
4-cpufreq.c
> index 43530254201a..140a9266b64a 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platform_dev=
ice *pdev)
>  		goto out_put_pllx_clk;
>  	}
> =20
> +	of_node_put(np);
> +
>  	ret =3D tegra124_cpu_switch_to_dfll(priv);
>  	if (ret)
>  		goto out_put_pllp_clk;

I think this needs to move to the very end of the function, for example
after the call to platform_set_drvdata(), to avoid releasing it twice in
error paths.

Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX6ZMACgkQ3SOs138+
s6FTthAAmzju9J/g7xZvUNuFeSub4rVfmwSvbqHS3TrDQA41Mh9Iib5kKF2Aybpu
Q79IB0v1vx90FdVtOMOrEdWEZv5hNhXfgfRpnu1RJaF5kRB/gblG7OUoDKpRSNBS
zRSfArj188UICNpJdC2Bd3U6UAc/IFsO3fnsR4GJCYv0yQKyh455tiaWZ1ZJGbfO
ZlqTXADiMLKEHlEUNyoieYU/O0yVEQm5zynJ7+Q5U0G56bfbzVguo5SWrfMwFp/1
UScRWd+J00zEMkNodIO9wvKzjwKsSizGRwC9zfsPC9PVsIC3y+ecNj1a16vpbjFp
//FWB+cKVtCcIWlj7EmhZuiyoo3DvYt72x1TemVEdj7HqRntkiyuc6zjq1vgh2Pr
h7HDtDTKzsB9Frzjt86ez3zEgvf825dBb/zFlVN16r7xsDpgHdVQw6vWSZb8FXMX
zqDIzeSpQGvND+/XqlPRFEKgvt67fHT62yRbJ8WBbNuz2ANCFuFWFJDCNF1O3XrC
1T4r/0FYD/ALRZjOYPKarttC6Htf2ChBPpeCid2c+kQiheBByPafmCWAKaqMEs2g
Xv8UWCGY/bEOxt/qi0oeWq/VSVdGGBLvH0A4n/3G47YW83u7uKkoYXRiOgJkG8B9
NQa+ap0GhieIFiu3QrQQcF61uQ/1g3DZgTv4GQyzUNNqFDsdk78=
=0N1v
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
