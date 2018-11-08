Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD139C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9207C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrZscYjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9207C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeKHV6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:58:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50887 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHV6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:58:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id 124-v6so1069642wmw.0;
        Thu, 08 Nov 2018 04:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZYX67YTI6j8hRUtLd5zLaRaBJREaLkkxXUkd22eJic=;
        b=ZrZscYjAMvHYqzSg6ia9E1M9tqM90IPwkJmqJSmH4A9Y/lPxaMiBXtcTXxDOGASnBO
         1J28+ZLmuzMcMu5ZVpgukRzxqZUHSGTbtA9E7JdPU3kGCgqsYh6TwigXbMxoUBiLYRkP
         0Q4MJ0gR8qWbLFTRywZwq6Vupq56AO9ZuWYWuhA59zT9Wk80NBh8nks/bnnaAxI4D+AR
         WwQ2gT4tvRtzM5cfeEAQftghmTrpVv5R6JC/FgS7Lo0MHR5CPyvEPOZvOHUhmoBDLrHb
         DXg1bUsWFpiUv03EKY6eAKR/toAag5ERNdQVgc4AODTp2VcIVUTMD4GrxKyHrzQvi8il
         g1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZYX67YTI6j8hRUtLd5zLaRaBJREaLkkxXUkd22eJic=;
        b=apJgMxKS1qII0uyWP1X5PuKNlLgo0Ti4X7TiCpFvHy15sdfLvQgDzJ9s6lMByP0DPV
         fRFGExmByU9J2p/ZoFW16QvwAC9moLXt/DivWLdSG9Ssb0l8vj5epOWqCwKRnLm9GC2v
         gT5uynSsLKpsA70ZkDZr15wPFV2dSyzBKmmX3mn6NvFTKTrtT0ASTOXV23/IbMyrK8Uc
         UN28y6GZtyWdxYuERNMLXLQI0IBsqDhvBWLQ578PNSobbFrn4rZgrJFTKoFP/x2OEJ8y
         EZpXMZMTcAK4fpZnaIK4v2vYsnFPqKbHKg8NlYjFNeRP6ilGuNDnVFkiIPCW2YjKBwiu
         0Q5g==
X-Gm-Message-State: AGRZ1gJfpRqc/G6nDevhLHK7BJ598BquUi2ji55cEc2EjLlwqmjdTd2z
        EOiKrgowZTWr1tqj0we4FCATmS8S
X-Google-Smtp-Source: AJdET5fgDJ4/A+prrSWNxJ/FuLqABCTik94D1TGOHJwT82Mv+BgswsO9quryRtOHgYGur+KlWCRI5Q==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12-v6mr1084994wmh.39.1541679768556;
        Thu, 08 Nov 2018 04:22:48 -0800 (PST)
Received: from localhost (p200300E41F201D007494A3C25E2F6EAF.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:7494:a3c2:5e2f:6eaf])
        by smtp.gmail.com with ESMTPSA id r198-v6sm1869080wmg.0.2018.11.08.04.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 04:22:47 -0800 (PST)
Date:   Thu, 8 Nov 2018 13:22:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        u.kleine-koenig@pengutronix.de,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
Message-ID: <20181108122246.GB1340@ulmo>
References: <20181107093613.26734-1-peron.clem@gmail.com>
 <20181107161247.sesu2comhes2d4kx@pengutronix.de>
 <dbd99d36-4ff2-8e14-cc54-0896459fdb0e@broadcom.com>
 <CAJiuCccuFKaht93QPvT+taaT8g7CHGS9uP9Ekr0VWASp+ZGZmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <CAJiuCccuFKaht93QPvT+taaT8g7CHGS9uP9Ekr0VWASp+ZGZmA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 11:47:53AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> Hi Uwe, Scott,
>=20
> On Wed, 7 Nov 2018 at 17:48, Scott Branden <scott.branden@broadcom.com> w=
rote:
> >
> >
> > On 2018-11-07 8:12 a.m., Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Nov 07, 2018 at 10:36:12AM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > >> The Cygnus architecture use a Kona PWM. This is already present
> > >> in the device tree but can't be built actually. Hence, allow the
> > >> Kona PWM to be built for Cygnus arch.
> > >>
> > >> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > >> ---
> > >>   drivers/pwm/Kconfig | 3 ++-
> > >>   1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > >> index 763ee50ea57d..76d56fc8b1b7 100644
> > >> --- a/drivers/pwm/Kconfig
> > >> +++ b/drivers/pwm/Kconfig
> > >> @@ -88,7 +88,8 @@ config PWM_BCM_IPROC
> > >>
> > >>   config PWM_BCM_KONA
> > >>      tristate "Kona PWM support"
> > >> -    depends on ARCH_BCM_MOBILE
> > >> +    depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
> > >> +    default ARCH_BCM_CYGNUS
> > > Is it possible to build this driver also on other arches? Then you mi=
ght
> > > want to consider
> > >
> > >       depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
> > good idea to add the COMPILE_TEST just to increase compile coverage
>=20
> Will Do.

This is known to potentially break builds on things like UM where we
have !HAS_IOMEM. Please make sure you thoroughly build-test before you
switch on COMPILE_TEST.

Thierry

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvkKpYACgkQ3SOs138+
s6F7oA/9EjJkBQQRIgfAYs0biyk/VGIMo9UkStI+h7X7tYOvLBx0AMnpBLftJVuZ
e4/kZj3mrFA1ertrfo68AYqzxGY63p0xHVZVpiuJYx7k4GhpHBLhnLk5NzhOfYrC
Y1we4u0d4BjmSq0E4CxkHmN+vy8IYh70AFZ1OF+Bh0l5FasYkdrYqMTX2FKHzTIj
hyLLjFHH7lTYK7m/XOwU2ObKm3O6FA8BhlWysOfi+OlG9YmGkUE0OFN8CGwRe5Md
QNsIxXed6cS9gxic1bEqXocikJDujW6T5AJEOY/hAhtAR2hAaIYJy5pX32rarA5A
MfY7ER2SCCnna50VyT+D/LKoUa4H51elJkNOPGAhrhOgF7gYcQ8vJ3ZrWMt6PY8K
58f9VInywUEvr4c5XpuHO9669CKP1LxnwaxEDcwXJyh9eB93la3mp7yXImMzMm0Z
k2ZU7jZhpUUDhTmQRsRuBFM7Li9zmf9QDu2Tna2LfhjFJBBIT/zwZTkerFp8ghTn
gOBQKlcxiTp7lqDxIk+LwKlObvlYDunqI3vCIZIq9Phrdm9Z0ft7QPiRHgMTIGO2
/khnxh+Y0pe9WJJiuDYRcs7mCvaCgphPvooMD2xFTO7RAvxo2+3d3HQGZDeMcJ7d
G8EfyuB7xF9zVSy11WgEhuXvV8VcpVWic+o4vHuE/AetGaOG0wA=
=MiXc
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
