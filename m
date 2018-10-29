Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A56C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA2220825
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esuY80pS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA2220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbeJ2Sla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:41:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42967 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbeJ2Sla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:41:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so7906947wru.9;
        Mon, 29 Oct 2018 02:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uWvLdBJETOk9/7r2UF5bHp9KWMD+Yir1l9geJrln4XI=;
        b=esuY80pSHNzZXSIXOXJ6ZdZirMPI4lRvd8VBtUVg7ul71uvHfQiQsuTzJM9UXrIklj
         90aZCMdD5QJcI+pbu2U+QvDgE/j+2ZKybjGOw6lIMzYrHGsLN4Rz/HXqwqxV7fmb05CW
         BGb6afOyvsvi6PHli5quMB/o/kyrLXVE1DPwjE6ZwCqY+T6Gs34x75OPi+1rPxoabriJ
         QNCgkbhLGqh4RaQYQlSZQwZwdMItkyhV5qEUzt67e69Sx7fgaD/cWoN/bP9DEXXgwdNh
         M10ecLdVwYigJaOvFcn8OVVhmeJDDM7kXZ6wekXNiEONcP/kAqsP1iaOnR2edPlcZBsZ
         p+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uWvLdBJETOk9/7r2UF5bHp9KWMD+Yir1l9geJrln4XI=;
        b=FUhLGQjlR6n+UIbGujevy6iVYnK1d0Pkn4NWeqXOlgz9vkKvclZxBB5FnAtQTmDw56
         Gk8Z7lsqNCgtnSKDd3TzVdonL1y9zTCivJOI3gnFfpPoQl+h+10myjm8uwTtwmS2A2bw
         LpiJIq6QCHK+spP9nZHD69vdbj19CIWy294isk60CP5KQbO++5ZQXHaHn8uUwsiO6YLz
         d2iDB1sE9gu/T2ans1/6LSDJt9CZBh91QphTtKX95T2uT2DRzkTaqJQrB4Al7kyDfGQw
         WpzPFKKJwe4cHZI+oRHEA/7O/xYTorXuuvaUVWjXTbXBr4NR2dqmHqP37MBwXqDrO4eU
         2Elw==
X-Gm-Message-State: AGRZ1gJdk5Tonw3oy+gPH4ZricdvHwpcBsWaOzHeNByTe1oWWQJ7XqAi
        aTePi0nkPwRyowU9k0Wh18c=
X-Google-Smtp-Source: AJdET5dEdo4Awqz9QBz/KWxJq4QSCi7MJOFw8Urhy6sy5DrCOw7ist6rXW+tD8Te5A7PPbmjdDjKaw==
X-Received: by 2002:adf:9b84:: with SMTP id d4-v6mr13107651wrc.240.1540806813107;
        Mon, 29 Oct 2018 02:53:33 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id 68-v6sm2309489wmg.26.2018.10.29.02.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 02:53:32 -0700 (PDT)
Date:   Mon, 29 Oct 2018 10:53:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] mfd: tps6586x: Handle interrupts on suspend
Message-ID: <20181029095331.GA26118@ulmo>
References: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 02:22:53PM +0100, Jon Hunter wrote:
> From: Jonathan Hunter <jonathanh@nvidia.com>
>=20
> The tps6586x driver creates an irqchip that is used by its various child
> devices for managing interrupts. The tps6586x-rtc device is one of its
> children that uses the tps6586x irqchip. When using the tps6586x-rtc as
> a wake-up device from suspend, the following is seen:
>=20
>  PM: Syncing filesystems ... done.
>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>  OOM killer disabled.
>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>  Disabling non-boot CPUs ...
>  Entering suspend state LP1
>  Enabling non-boot CPUs ...
>  CPU1 is up
>  tps6586x 3-0034: failed to read interrupt status
>  tps6586x 3-0034: failed to read interrupt status
>=20
> The reason why the tps6586x interrupt status cannot be read is because
> the tps6586x interrupt is not masked during suspend and when the
> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
> seen before the i2c controller has been resumed in order to read the
> tps6586x interrupt status.
>=20
> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
> suspend, which gets propagated to the parent tps6586x interrupt.
> However, the tps6586x-rtc driver cannot disable it's interrupt during
> suspend otherwise we would never be woken up and so the tps6586x must
> disable it's interrupt instead.
>=20
> Prevent the tps6586x interrupt handler from executing on exiting suspend
> before the i2c controller has been resumed by disabling the tps6586x
> interrupt on entering suspend and re-enabling it on resuming from
> suspend.
>=20
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/mfd/tps6586x.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvW2JcACgkQ3SOs138+
s6Fcfg/9EKHW8lkLK3mjMz9SH44+nGJILn73hgwVxaklN7YndT/AYOcMgFNiW3Og
PUqWzkj3SKdMiyBzym3Yupe2J9O3qOJZt/a+wd3hW6FHBmNcXwxqF6bdxX16+BD6
84B/mNRgBxczH+7R1MALY+SWXPtd+IQfNvmMKszUKtR10z1lFXdcCsbtJzJ843+l
4N8Tl0j3qvK2hdhSPnK/0Z3y/ZYwV7ghnulSovkKZQ24aJpcWiJKYjLlXKuEsc6n
T3H3Eztryix5MyiSlIGHtaHuKjHdIEUIlJ+Sit72cHfjm+wXFVXelPQfruAA6ivN
mRKbA6W4CSrmTOG2q78hwxQx0dwZwUtgy1SofUQaHH3M90kOkEokEOwR2wQ2cL5T
1RfAk/BLMYqp9fhlWTxxQ9x/r7VZOyvE0PplFuLcE32d66RNquhGV52d3FY/B8ir
eIROIfFGtJtYx16tCzc1Sg+xjPxPX5Nau6wcomrJXstFpLj1Lzh6Uyi7KQH+KTKs
sn3a5b0HijoZ5EfM1l6gN7KL1CKXltOlx1JIWbFLeyhZh370XL7laGagoCc4ap0+
+0Epku2l4Pphi/DIPKQKN3oUGWkU+tNHWOHwtypmHGq9S3TdtJdA/jy+vcV6Hx2g
CmZFo+RkJi1CJhGmBRRBEImLsvm9Za7Cap1Mp2sFpxFVmJWSXgY=
=A/iL
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
