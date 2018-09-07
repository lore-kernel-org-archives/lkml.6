Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB29C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A00E2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3btTpU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A00E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeIGRKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:10:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36487 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeIGRKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:10:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so14543786wmj.1;
        Fri, 07 Sep 2018 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hj9hDeoAyx2DettVhYAtXW1O0YpXPBAq8foc5JkxhNU=;
        b=F3btTpU1hA6GCaARUQyaP3QO9EH/+fUdopbsMgFkQKSC4FS3hadWYUJD4WST1cPL17
         qqn0DDiOPSdYZ8zyh9NRqhcrYwPqxeAvRwEG3+EjVAevYtI7pL1df1hbbzCqsJELLssl
         Yi0S9/vA/g6WEZP5NYn16cf+LUEGxJOfHOiPhP9obs/xtZvDatMcqAzhqiqIDklwtIzN
         xq+nNKaLxO9cb/PiVSBTDiGvDgHcEUV1X6fOhe4IbBfYPrAlbWA8rT5AuPsmahV9X+bk
         3Wl7xApWHGVgg+qqHWXW/LWbVadjH/iAfHxtfAt1FRr6Zo3ndR4j3unmIPYpbUCeXGXv
         /F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hj9hDeoAyx2DettVhYAtXW1O0YpXPBAq8foc5JkxhNU=;
        b=oG7sfV3LiTlcVOlEDOBT2F6njhFLpEHFjqSmRo9cLHRwDsrH5Cyc6Zmi+21hIonazu
         9ReKuocXvlRWYLBoHSnEhJMAxxwUdQ+w1cddSVHH2QMqMOlDkc0gtBmvmhefwh6IIvbw
         2WE+AUBs4Zzujjg9drEi76F6m/h+r2qjcExzSF0Qc9tSQcimU0Nusa0/Kq8OdjhXeIFJ
         NMU+L6m4hL3GGwC4Hef6qDD9xWbjWrdqpFyJAy0JQkIVDxplrBOBX86sO0oA6dck7Vdn
         aHkVrmCH+ZqONpHdqbEuMhmViqMV5XKAqG7E7N4+7FL4eaC4jWerTNgRpQV5kpQCkxWJ
         ieXw==
X-Gm-Message-State: APzg51BCmPXHq3gyZ/8wE5Fnbfzdke8MBxf4mWK90FDGPbJhgvmN4i+A
        8MY1rNS60+e/whFUobX7IU5xzHS9
X-Google-Smtp-Source: ANB0VdZbNoCvrAiOwKbPurq+CesTkDOvTfCrupFYOw/HtPlp9hDxBNZd2pe2HiM9Eibcx0dgV7i/WA==
X-Received: by 2002:a1c:2905:: with SMTP id p5-v6mr4916795wmp.1.1536323371122;
        Fri, 07 Sep 2018 05:29:31 -0700 (PDT)
Received: from localhost (p2E5BE549.dip0.t-ipconnect.de. [46.91.229.73])
        by smtp.gmail.com with ESMTPSA id 185-v6sm7101161wmy.38.2018.09.07.05.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 05:29:30 -0700 (PDT)
Date:   Fri, 7 Sep 2018 14:29:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 3/4] of: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180907122928.GA5821@ulmo>
References: <20180828155254.10709-1-robh@kernel.org>
 <20180828155254.10709-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20180828155254.10709-4-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2018 at 10:52:53AM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>=20
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/device.c   |  4 ++--
>  drivers/of/of_mdio.c  | 12 ++++++------
>  drivers/of/of_numa.c  |  4 ++--
>  drivers/of/overlay.c  |  4 ++--
>  drivers/of/platform.c |  8 ++++----
>  drivers/of/unittest.c | 12 ++++++------
>  6 files changed, 22 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 5957cd4fa262..daa075d87317 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -219,7 +219,7 @@ static ssize_t of_device_get_modalias(struct device *=
dev, char *str, ssize_t len
>  		return -ENODEV;
> =20
>  	/* Name & Type */
> -	csize =3D snprintf(str, len, "of:N%sT%s", dev->of_node->name,
> +	csize =3D snprintf(str, len, "of:N%pOFnT%s", dev->of_node,
>  			 dev->of_node->type);
>  	tsize =3D csize;
>  	len -=3D csize;

This seems to cause the modalias to be improperly constructed. As a
consequence, automatic module loading at boot time is now broken. I
think the reason why this fails is because vsnprintf() will skip all
alpha-numeric characters after a call to pointer(). Presumably this
is meant to be a generic way of skipping whatever specifiers we throw
at it.

Unfortunately for the case of OF modaliases, this means that the 'T'
character gets eaten, so we end up with something like this:

	# udevadm info /sys/bus/platform/devices/54200000.dc
	[...]
	E: MODALIAS=3Dof:Ndc<NULL>Cnvidia,tegra124-dc
	[...]

instead of this:

	# udevadm info /sys/bus/platform/devices/54200000.dc
	[...]
	E: MODALIAS=3Dof:NdcT<NULL>Cnvidia,tegra124-dc
	[...]

Everything is back to normal if I revert this patch. However, since
that's obviously not what we want, I think perhaps what we need is a
way for pointer() (and its implementations) to report back how many
characters in the format string it consumed so that we can support
these kinds of back-to-back strings.

If nobody else has the time I can look into coding up a fix, but in the
meantime it might be best to back this one out until we can handle the
OF modalias format string.

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluSbyUACgkQ3SOs138+
s6ELBBAAi8cbuJZHQabJPhB7Y0fsJZet4soXDZWmrJsfMNd+AuT3LXjV5HtR2rC7
M5ltpxZhbFx0+JhtQI0dK6l/2NvJQhE/X0tN1V6k2VT+hni6FcyWHxEQQJpUpLLl
VAEt3Mcp7vLBC0fqgu7ASFW05lO0FMXLiSChrw6lbvvVNh5ITd8Q2YKxP6LmmQ9S
6YF1hN5QOnR7wkypqf2KvFuemMtuKv3YYXPIdVesOBayOnUMTneIlWt3SZv8U+m/
qy3LR6m43n76RB6lAMcaMTZfBTP8kiM0r5/jZsDlHqu3svgp174Ft8TtRBHcstN+
rOoFz1Bddd4PtXlJtum9YZyN0n+SBs6lTe7NZlJC0VmQz29yloz8MDaOJwjoanxo
Tyr5D84eHTfMh1lpNbyMZqnqcQD3t6EboZZCrZ/Q1Gd2zfUohiWV1In9UolmeQvJ
Ij1eE0u7DeLizIzYtUpKMfRxcL1NlaAWw7VmtDJnZ5TPN0ASNCO2vvz+ev45i3fq
2enBq2DlNDzlnGdFdZNqx3RlHH6APsGUjTXYlafF/dQG/jVTteQ0M7jj4nvOUZiN
q51Rk9l30a6hUDt4LZliOt0Vt7TnK1FLyKAXgPxhHmEEZRUFJuan2afefPendC+K
VYHwXZAJCfHdeFxDbmyoegiqiLoXo8PS0Kb5L+7KtqnFMTm8Iic=
=E/Bc
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
