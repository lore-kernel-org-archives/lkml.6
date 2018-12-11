Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F10C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6197B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxtX7Ph1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6197B20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeLKK3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:29:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43399 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:28:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so12055789eds.10;
        Tue, 11 Dec 2018 02:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QSPrtZQYZXN39pKVzh92qREJOV/EYg+x0RyqoXiL8OQ=;
        b=PxtX7Ph1nHq4RVANc6gL0DxPkrwU1lLsxH5Pz3K2z9TMHOS57mYFGbSEZ0jTxF1keC
         +vNRAGuCuusFTN24EtaBKTMY8qvAWj3pKHySLRm6MaQPeDmWiczLQgAaKEbwX8V6KJ4q
         CVOzK1a+/KL3rmId7gPCGCXbBtAz1uoFeaRloeUs5euUC5HCBkyv/6IdRv+wLzH6fzzo
         UloL96HZ8KJ1rYYxHlL6+yMx2nrQa+YjuHx4o6FVSh9dXWUcIqLbUX6LXrqOrap28+Im
         +fBwpEb2kmPgUFPIrwF6xaoc0oux+l5f1i8vyrIMQOfrz8qLRq5mOfvjm/gG8GtwJPtc
         yjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QSPrtZQYZXN39pKVzh92qREJOV/EYg+x0RyqoXiL8OQ=;
        b=QbUvMctaLL5p9gMBWUXYVmO3I2+aY/fBdR/DL4BIoaAmU35RlctIz7O42NYWrI0brB
         ONSep1ch1g9GZq9XDjNoD3Ag27mAYy+Ucy2/9j8Vfku/bn7U6T0EQuReZJSIQNEE+Dud
         2ZX23FAxMBDURYtJ+svA/1PN0+lF7t26qpUiaFdOl8JxYyJ+eLWqAK4X8xXewL1x51Ou
         QGnRsBa1q5AyBC8uMf/H+fyae+AeGhra9ckdqx+eKpT1VdunH/cy9SH/hxwOvNcq7K8N
         ofeo3qUw8tXIEgjajEwLg6nzgwJvb9XUTk6EtN8FJtre8uzIDw7meH2Cy+ODpqws9UdP
         D5Ag==
X-Gm-Message-State: AA+aEWYPBn5xHHTznd9/jlouqN1Zs91GlSROWp92LsYz7RCVa81lmWkS
        HYmNyJZFf5zwfVnPBW9Lmrw=
X-Google-Smtp-Source: AFSGD/WFCFry5EVCc3sgebol5+ZtN8VHWQl8peA9+Woyc9EiYDXanZOeoch3AbHM8hIs/oFaKW77gw==
X-Received: by 2002:a50:e0cb:: with SMTP id j11mr14587211edl.195.1544524137646;
        Tue, 11 Dec 2018 02:28:57 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t15-v6sm2127812ejt.0.2018.12.11.02.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 02:28:57 -0800 (PST)
Date:   Tue, 11 Dec 2018 11:28:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm-soc <arm@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] ARM: tegra: avoid section mismatch warning
Message-ID: <20181211102856.GI14426@ulmo>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-2-arnd@arndb.de>
 <20181211100550.GD14426@ulmo>
 <CAK8P3a1zbmYMFZB8R+rs=vdJY=KNqgRPBCQNO91LcSSTR0O03Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1zbmYMFZB8R+rs=vdJY=KNqgRPBCQNO91LcSSTR0O03Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:08:53AM +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 11:05 AM Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >
> > On Mon, Dec 10, 2018 at 10:58:37PM +0100, Arnd Bergmann wrote:
> > > WARNING: vmlinux.o(.text+0x39ecc): Section mismatch in reference from=
 the function tegra114_gic_cpu_pm_registration() to the (unknown reference)=
 .init.rodata:(unknown)
> > > The function tegra114_gic_cpu_pm_registration() references
> > > the (unknown reference) __initconst (unknown).
> > > This is often because tegra114_gic_cpu_pm_registration lacks a __init=
const
> > > annotation or the annotation of (unknown) is wrong.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/arm/mach-tegra/irq.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > I'm not seeing these. Do I need to enable any special options to trigger
> > these? Or are these just so new that I haven't run into them yet?
>=20
> My guess would be that this is a result of the CONFIG_NO_AUTO_INLINE
> option that is now available in linux-next.

Okay, that would explain. It's not set in my configurations currently.

Do you want to apply this to ARM-SoC directly with my Acked-by, or
should I queue it up for v4.22?

Thierry

--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwPkWgACgkQ3SOs138+
s6HFnRAAi5OjsnSOJjvHFV0izhJIfhiufCH8ED7aqLMBkYuDJK5t5cKaiSNqeZyy
fpCTBk4mjNBx9MyrDDhZB0YyDs8wDtf6keaBI/7eE+2YOj1Va8o5vMbNWP1EJS3V
3/8O9dXwjEHOiA0aPQ6Gea854Yi4z14aEeH67OqC9UTJ1jIGzYjrYZloV1qSwIUu
o1NVD175zaSK6aFFYWUiDwvTwgA0gnJvho7Uj+zmJ3jdg5vyQxcvqRG41bAdyuZ4
gKksCTnUMT22gyJm0q/w5MHOGekoX4ZmnHJD/H5L47kcjzCqEyjz3kt4ukuRnYIa
aYSe12zAmEE8zrIDn/csSt/FJGgATFBzg3ab0rrUqLP5tLUgE/DOz8RQTeXlF/xN
OrJjrc+0JpiwUiDLcoeAFO0MEf+Z7viPWDNae0X3LQ4Vp4qqrUQW9AlvLtjphAx9
hKMfWbNjEn3w2jXabQ4611nMT8ThIn5P0Mj4y8gTPWFNBb+ruc4t1HBDrZlAKTw3
pIigbiqPp7idDXCu2ybbDe2VxoVi7QnB65L0zj9spF5GfiwkJXelI3G9IjPuwU12
2sN6KZcZ8UcHKMbyOZcyVDuYh0cZn+z9LdGc8HyO5gvwewR1XD4yJ4NeGTNSvF+1
xLcHRPsrRj2AS4g4WYk8P8FKZd8LydwGTbwI4a3uh2tt+IIFFYk=
=INA3
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--
