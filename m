Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78994C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1F20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vilk9vjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfBFNcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:32:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42143 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfBFNcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:32:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so11769820otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F/qt4tOu4YYqybfv4UJoo2T+jbR7jAA87z2QlXzOjEY=;
        b=vilk9vjq3CaKNA0t5v0tVaQIWqd+0mB0FyJ7aXmtUiYau1b505mxBJJ7OD1zv5ISL2
         tN5PmWoubR+CpNu8b8BZijbdTiU9dGCDJw8zvkM2Xf9nMqp4HkxUuxNszOIFQJ58BHKr
         FwJNjQ4MBI2XuOQVlmnN/mQTvS1NFceogSoZgMDBXDQPh1pyOcAa30FUabK0CsR/Wuax
         TS5Ot7oa2EmUE9VPCdw+vMcXehUjqP0bUxN0rnGKyrUsoQi+PHuf/t8rxCFBRmJ1XEar
         cdsRlNeHBVzsTaAIzaEufGu03+SC0uEBWfzlWaby8p5pBcKG3XCMDGMBzvOW/4TlSwuk
         ZTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F/qt4tOu4YYqybfv4UJoo2T+jbR7jAA87z2QlXzOjEY=;
        b=LTweKXALjRTcO8cvvje9gytXQOIF26CvkdvGJzY9m4FtbQv1XMayH8K9iro9lClM53
         kwyzS1geW5KNCwRhjjmRVM8Uv/3zYZ8aMopsx2bKO93yo8LckWbPd7af5D6PiuW334cb
         yEzYg1D0tFr+gETO5ccLCPWYM0i5aukGfa9kgx+hWeNfwie//l+G6JXgWXIaAEm5d+Ty
         lTzSIi+Dkxb/EXuZfsYS8sCbjlMbSwsV65Yui5UTirQklPRqq1aqz49KElyccSMLyTX+
         TFTV42ab1Hry/3jye7AisM4adgoiyfimqJ1ZdMOzTcHMsHNa9LF4LCxWfzlG/0ayLfBI
         n+2g==
X-Gm-Message-State: AHQUAubaZFal+jZvL55fuvthMO9TOv2SU+MaeJMjOfOMcgbqCS7vVd14
        WiBKBPUXU5pbVImG4cXtJg5MrUSbaDVtPKnVJLn9+w==
X-Google-Smtp-Source: AHgI3IbELqlgQEcvURTaUnmH+k0qZfJuVHtSyOwrKIQqn3FIutEeDXXaO0TGgC61gV/1FYiQqNNIaZEjcRnYg+0h2Oc=
X-Received: by 2002:aca:b6c3:: with SMTP id g186mr5663822oif.289.1549459937405;
 Wed, 06 Feb 2019 05:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl> <20190131133928.17985-6-brgl@bgdev.pl>
 <3038ba79-f411-9aa1-00ec-689060ed13d4@lechnology.com> <21c3d8cd-f767-04bc-f4d8-3001405ffd1d@ti.com>
In-Reply-To: <21c3d8cd-f767-04bc-f4d8-3001405ffd1d@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 6 Feb 2019 14:32:06 +0100
Message-ID: <CAMpxmJWU6WRK70xNN72Ke2kXi6F-uLWrCpF+K-+qKX3DcRy7uw@mail.gmail.com>
Subject: Re: [PATCH 05/35] ARM: davinci: drop irq defines from default_priorites
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 6 lut 2019 o 14:03 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 05/02/19 3:51 AM, David Lechner wrote:
> > On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> In order to select SPARSE_IRQ we need to make the interrupt numbers
> >> dynamic (at least at build-time for the top-level controller). The
> >> interrupt numbers are used as array indexes for irq priorities.
> >>
> >> Drop the defines and just initialize the arrays in a linear manner.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >> ---
> >
> > ...
> >
> >> -static u8 dm355_default_priorities[DAVINCI_N_AINTC_IRQ] =3D {
> >> -    [IRQ_DM355_CCDC_VDINT0]        =3D 2,
> >> -    [IRQ_DM355_CCDC_VDINT1]        =3D 6,
> >> -    [IRQ_DM355_CCDC_VDINT2]        =3D 6,
> >> -    [IRQ_DM355_IPIPE_HST]        =3D 6,
> >> -    [IRQ_DM355_H3AINT]        =3D 6,
> >> -    [IRQ_DM355_IPIPE_SDR]        =3D 6,
> >> -    [IRQ_DM355_IPIPEIFINT]        =3D 6,
> >> -    [IRQ_DM355_OSDINT]        =3D 7,
> >> -    [IRQ_DM355_VENCINT]        =3D 6,
> >> -    [IRQ_ASQINT]            =3D 6,
> >> -    [IRQ_IMXINT]            =3D 6,
> >> -    [IRQ_USBINT]            =3D 4,
> >> -    [IRQ_DM355_RTOINT]        =3D 4,
> >> -    [IRQ_DM355_UARTINT2]        =3D 7,
> >> -    [IRQ_DM355_TINT6]        =3D 7,
> >> -    [IRQ_CCINT0]            =3D 5,    /* dma */
> >> -    [IRQ_CCERRINT]            =3D 5,    /* dma */
> >> -    [IRQ_TCERRINT0]            =3D 5,    /* dma */
> >> -    [IRQ_TCERRINT]            =3D 5,    /* dma */
> >> -    [IRQ_DM355_SPINT2_1]        =3D 7,
> >> -    [IRQ_DM355_TINT7]        =3D 4,
> >> -    [IRQ_DM355_SDIOINT0]        =3D 7,
> >> -    [IRQ_MBXINT]            =3D 7,
> >> -    [IRQ_MBRINT]            =3D 7,
> >> -    [IRQ_MMCINT]            =3D 7,
> >> -    [IRQ_DM355_MMCINT1]        =3D 7,
> >> -    [IRQ_DM355_PWMINT3]        =3D 7,
> >> -    [IRQ_DDRINT]            =3D 7,
> >> -    [IRQ_AEMIFINT]            =3D 7,
> >> -    [IRQ_DM355_SDIOINT1]        =3D 4,
> >> -    [IRQ_TINT0_TINT12]        =3D 2,    /* clockevent */
> >> -    [IRQ_TINT0_TINT34]        =3D 2,    /* clocksource */
> >> -    [IRQ_TINT1_TINT12]        =3D 7,    /* DSP timer */
> >> -    [IRQ_TINT1_TINT34]        =3D 7,    /* system tick */
> >> -    [IRQ_PWMINT0]            =3D 7,
> >> -    [IRQ_PWMINT1]            =3D 7,
> >> -    [IRQ_PWMINT2]            =3D 7,
> >> -    [IRQ_I2C]            =3D 3,
> >> -    [IRQ_UARTINT0]            =3D 3,
> >> -    [IRQ_UARTINT1]            =3D 3,
> >> -    [IRQ_DM355_SPINT0_0]        =3D 3,
> >> -    [IRQ_DM355_SPINT0_1]        =3D 3,
> >> -    [IRQ_DM355_GPIO0]        =3D 3,
> >> -    [IRQ_DM355_GPIO1]        =3D 7,
> >> -    [IRQ_DM355_GPIO2]        =3D 4,
> >> -    [IRQ_DM355_GPIO3]        =3D 4,
> >> -    [IRQ_DM355_GPIO4]        =3D 7,
> >> -    [IRQ_DM355_GPIO5]        =3D 7,
> >> -    [IRQ_DM355_GPIO6]        =3D 7,
> >> -    [IRQ_DM355_GPIO7]        =3D 7,
> >> -    [IRQ_DM355_GPIO8]        =3D 7,
> >> -    [IRQ_DM355_GPIO9]        =3D 7,
> >> -    [IRQ_DM355_GPIOBNK0]        =3D 7,
> >> -    [IRQ_DM355_GPIOBNK1]        =3D 7,
> >> -    [IRQ_DM355_GPIOBNK2]        =3D 7,
> >> -    [IRQ_DM355_GPIOBNK3]        =3D 7,
> >> -    [IRQ_DM355_GPIOBNK4]        =3D 7,
> >> -    [IRQ_DM355_GPIOBNK5]        =3D 7,
> >> -    [IRQ_DM355_GPIOBNK6]        =3D 7,
> >> -    [IRQ_COMMTX]            =3D 7,
> >> -    [IRQ_COMMRX]            =3D 7,
> >> -    [IRQ_EMUINT]            =3D 7,
> >> +static u8 dm355_aintc_prios[] =3D {
> >> +    2, 6, 6, 6, 6, 6, 6, 7,
> >> +    6, 6, 6, 4, 4, 7, 7, 5,
> >> +    5, 5, 5, 7, 4, 7, 7, 7,
> >> +    7, 7, 7, 7, 7, 4, 2, 2,
> >> +    7, 7, 7, 7, 7, 3, 3, 3,
> >> +    3, 3, 3, 7, 4, 4, 7, 7,
> >> +    7, 7, 7, 7, 7, 7, 7, 7,
> >> +    7, 7, 7, 7, 7, 7, 0, 0,
> >>   };
> >
> > Hmm... this makes it harder to see what is going on here.
> > You can no longer see which priority corresponds to which
> > IRQ without consulting a manual.
>
> I agree with David here. The interrupt numbers are dynamic, but the
> interrupt number offset from hardware point-of-view is fixed. So can
> these macros be re-purposed to represent the hardware offset (eventually
> you would pass them to DAVINCI_INTC_IRQ())?
>
> Thanks,
> Sekhar

Should we keep the mach/irqs.h header then? While working on patches
for supporting the multi_v5_defconfig build I noticed the mach/*
headers tend to cause build problems in certain drivers that use them.
Most machines have gotten rid of them. Should we maybe create a local
header in mach-davinci/?

Bart
