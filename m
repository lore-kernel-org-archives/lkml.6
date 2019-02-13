Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EBBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61E5222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUxkLdnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfBMMhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:37:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36024 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfBMMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:37:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so2259831wmj.1;
        Wed, 13 Feb 2019 04:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jvc0DPJeZC4x80fYz5SDp6GhltWn2bjfuEN2w5fshSY=;
        b=TUxkLdnAe1zAT/X4CfyiJxmFc8ForKs82JE9QJz9qNgs6NHvVX/J6cnm4eq+CkbT6t
         3OyvWsm+oilT+GD69lMjocKcnRPPZsICRTxNHFVX1Dm2hMHbH+U8CjcU7UouxBNQE23J
         zFIoHEVhkSGhQuxALKbCgrBYRQY8pvNsTScN9SGOjnZHsaniyesGZzWTwJr/6c9QEkd9
         j7FlR2YpQvsfuSXSg9JDmk+G8wUVmQdX3wCChZgeqzPDfkJJVkh1hZhgi40cEso+zfnQ
         f1jkZg1IJRSfBq18Ws8fPYRf5EkyNgKWzJxK020TqtspjlyV3ZOA1biixJU0dokyndkt
         1EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jvc0DPJeZC4x80fYz5SDp6GhltWn2bjfuEN2w5fshSY=;
        b=enLqRRPbD5V8J/9xbgnGJ/rm7NBnODteIYqIU81KqxNsbAuI0B0TYuCS9SQW+aVRyr
         RuzaEe/ve/dB+Y/wVcCcJvyhIOJd+G6hC2FPxhsUeNYAhesnwzIwNYOX+2fr99Dqx81l
         GaCC0s3XuG9wUcJxnS3LZmfsyQrpH6dMr3ET6pCXK/w0qojUCM50zxNB8AwgvZA2W/WO
         J4cmep6BvaCTnl7SwbjNaNvIzkPj26jidqO1hFJYZJI6Q3dA3orAOeHzG3JCX6KtRL7I
         V1xvBbsW8y8Fs5IVsSQA8/UWRKOaiJ2+tyawGoDjNZZdAidvGZxGfX/j4xY5KrmB/9uI
         YMRQ==
X-Gm-Message-State: AHQUAubob+Es9oVXTPRItJqv21oz/GPhgS9ByGtgdcTq+GQDWy8vhTxX
        l4mbMwfCrtH0cmDleDsfjTe0CYyx
X-Google-Smtp-Source: AHgI3IYprqT3ZersU5tdbD1oKTYH8pVnsPae64xazF5UiexuBJW+cShQAZXFQyds6K8kNfRTUkajZg==
X-Received: by 2002:a1c:c208:: with SMTP id s8mr146501wmf.75.1550061425078;
        Wed, 13 Feb 2019 04:37:05 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id b2sm12814914wrp.94.2019.02.13.04.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 04:37:04 -0800 (PST)
Date:   Wed, 13 Feb 2019 13:37:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Yash Shah <yash.shah@sifive.com>, palmer@sifive.com,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190213123703.GE647@ulmo>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
 <20190207101657.rfzcq6xdv6ocvubg@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline
In-Reply-To: <20190207101657.rfzcq6xdv6ocvubg@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 11:16:57AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
[...]
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
[...]
> > +	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm * SIZE_PWMCM=
P);
> > +
> > +	val &=3D ~(1 << PWM_SIFIVE_PWMCFG_DEGLITCH);
> > +	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +	pwm_sifive_get_state(chip, dev, state);
>=20
> Thierry: This changes the pwm_state. Is this how this should be done?

Yes, I think that's fine. The PWM state should always reflect the
current hardware state. If the configuration that we program does not
reflect the state that was requested, that should be reflected in the
PWM state.

Thierry

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxkD24ACgkQ3SOs138+
s6EJYQ/+PKXGl1Os9kb2ygrrqtwNAdMUKWPznwwYxi0Nba1r8Z1Yt3XBPDh8m3lO
JTqBUX6Cc6ePyQRlyMoMzrD41+OEWW2ueUG6i1VfFZJ3Yx1FyV+qGOjyh1ajfc+b
s4+8fPXzQ6VHrryvA0bYn8QHk2+DKeQgXTwd8i0FOxazVJ5eaE97aTiqoL5TSW7e
WpCmTuBj53sRoMO3qnYAJtKi/XElp/so+6gOz6zzz92SKnFVxlb7LskyRO4xVJt0
csGSkj2GVDnbTRGAfge8u5o/fTLzTI61TpNZSZfufGnpt5YjMG6y9T3lNUh7WSyz
E8PhNHH3WnFeegmUpj6zu8h+p2gJBa8H8wh6YjipVuUhhVBZVq/5AqYbavtrLlAb
FLxUcCltLcAaClAoAx9aLYyuq2fvkUjBd9ghNvASrxq9F28fYNCOz38vACpGCExq
s5rLgsClYTjTOPipRKUj+8vUJoQnjtGV+miQTeD4+MkUJLrOvCvimaVfda+68Phe
zq3huhk0+etRLAwkKY2MmRi6nJTneESXq8gE0pb+QtMzlWs71Pqa/lqC/MPsAo5E
IZoh6keN0VBUpxltE8UoGMu6QJXaxTtVtmfOS8dZjT4xKvef40boBdl0jVt6KGMt
d3RRmQQDGiYwusML2HCpJUY9RcipWOn2oEYbtGxGHm2SM9dg6M4=
=UK4T
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
