Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FE3C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107462086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0UvrWDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107462086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeKHUW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:22:58 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36949 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:22:58 -0500
Received: by mail-yw1-f67.google.com with SMTP id v77-v6so7825177ywc.4;
        Thu, 08 Nov 2018 02:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hsk+Q2J3Wg5Qckzl+HJrRNpuJs8lpknR+FIAmR6dFQg=;
        b=J0UvrWDc53ros8JlFf8XMm9RKlpF8E9Ib6PtxqloGElop844ed9SFIjUp/YeAJn/UA
         jJvHtk8xxYttfx6on+9pd18GtLl3U5fShRutvrqqy0TRjh7XFtDTcQ688AjcIDV3xMLC
         Cxnt/PZq+1Rt74/fArnHUaOIX9M6EULWSzzn8Mw3kCDJiK7wCZvNGB4hQElSiHu+Giiy
         3O+9HJG3j5iE3Gse4X48Vqw0puRGwYO3cfDgLvsu5iaHjMXIFBVweFMYtAaYofRyD5Gf
         BFcIxivIhiBNaC53uABu/hTTnGNM4iOjE/EAkkRJPGBsRiR3ps2aSKeo9qekjjhiYVfs
         Oemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hsk+Q2J3Wg5Qckzl+HJrRNpuJs8lpknR+FIAmR6dFQg=;
        b=TZchfltz/YUNspWZbPdvJiw/hZJ89zTbIkcI1H0omI7fGCUkl7gNRggApYzWESUVK1
         xWS4UouGk7wfGMCQ1mjDyubYqbGs3dM/1hXKt2pZWBHUPw01z7niG0sCEbbA51Y4bNfb
         shYWyHSzlnQpdTI2hTa81TVtbPUT3FJh0r0J0rVzia/hYsdTBt+dewOGMS1UuQ3EroVn
         hynRQg5sLH1zKtlrPIt9gN3v1+9aR6IrkbjyZ9OwsvbMjJQvqb04i1C3IWCJwUlQwNwV
         2IwYesV71eUrSxu7rMgUlawKdrqH/5O1H7yb5LQ2+RqJaiLn4DmS2GgQGIyTF3EHuCib
         V0gQ==
X-Gm-Message-State: AGRZ1gKtK7HJCGYEGiCevJ/D6n5/uAuU0PHh3MVs8OwA4TOlHm45hI76
        2pHtZi2w04ZYPIsKZ35OG3nXQvVwvB//oBFq38Q=
X-Google-Smtp-Source: AJdET5c9Al8bs5wB0VITyPyTlr73xz6AJy98kGL68PvXKsOmFXV/2SAB8jMc4B5fdBnayAl48OsR54uXg4DF9OhMWwM=
X-Received: by 2002:a81:9f8b:: with SMTP id w133-v6mr3615474ywg.163.1541674084296;
 Thu, 08 Nov 2018 02:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20181107093613.26734-1-peron.clem@gmail.com> <20181107161247.sesu2comhes2d4kx@pengutronix.de>
 <dbd99d36-4ff2-8e14-cc54-0896459fdb0e@broadcom.com>
In-Reply-To: <dbd99d36-4ff2-8e14-cc54-0896459fdb0e@broadcom.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 8 Nov 2018 11:47:53 +0100
Message-ID: <CAJiuCccuFKaht93QPvT+taaT8g7CHGS9uP9Ekr0VWASp+ZGZmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pwm: kconfig: enable kona pwm to be built for cygnus arch
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe, Scott,

On Wed, 7 Nov 2018 at 17:48, Scott Branden <scott.branden@broadcom.com> wro=
te:
>
>
> On 2018-11-07 8:12 a.m., Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Nov 07, 2018 at 10:36:12AM +0100, Cl=C3=A9ment P=C3=A9ron wrote=
:
> >> The Cygnus architecture use a Kona PWM. This is already present
> >> in the device tree but can't be built actually. Hence, allow the
> >> Kona PWM to be built for Cygnus arch.
> >>
> >> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >> ---
> >>   drivers/pwm/Kconfig | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index 763ee50ea57d..76d56fc8b1b7 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -88,7 +88,8 @@ config PWM_BCM_IPROC
> >>
> >>   config PWM_BCM_KONA
> >>      tristate "Kona PWM support"
> >> -    depends on ARCH_BCM_MOBILE
> >> +    depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
> >> +    default ARCH_BCM_CYGNUS
> > Is it possible to build this driver also on other arches? Then you migh=
t
> > want to consider
> >
> >       depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
> good idea to add the COMPILE_TEST just to increase compile coverage

Will Do.

Thanks,
Clement

> >
> > Best regards
> > Uwe
> >
