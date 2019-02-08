Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A950C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A5620857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ylk+KSgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfBHMqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:46:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45756 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBHMqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:46:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so5509236ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oacHkyZc6vgry81ANwoeRHGP9onV0XPaiJsq8X42m0Y=;
        b=Ylk+KSgpWUJV4Sx7KwKWC/N1SV23sMnxSLJfj87lGJkusrKjTL5kr9T0tBWszq8qSE
         cKStBIFiPW2V5OpUnxk92uEj5hCmaOY6me52rbbcFcZhud4t3Fg/qYqObRvFyFVezqwr
         1oe5B0ivAxEPRbP0Xr2IQrQ1uoBg8NnSoQH0W86jcHlHfpPWdu7G2QAK9ZVgXaMlRTZO
         J9gnKD0XA1PJueFdzsuz5aFWp3fJgtYSYTcUnoLR96fgZgCfdRtPv79HRy53eA3R5vOn
         +me+q9ttp4rdt05lGFEpFJXdbWcF23qPMbzC9r3UU/AlsEIjlgr+pvWa/cbAd/STQaHB
         pXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oacHkyZc6vgry81ANwoeRHGP9onV0XPaiJsq8X42m0Y=;
        b=qd1/BBp+Z007DDGC7FfKcjJZLb8yE16SROmNDSZfd7DOwevUT59mAW1rMe5Iq7d2Iu
         1yDkqHJzjGwP0CWxVEZVVOCdYqYlsdAqoH7QMVy4ynHRpI+Mn3oRHaBnxY+HRNztjP2q
         jholcX+62qEnXXsxARI/MosbRCONHeOYFYGAC0EwxxhHPYF6XVfd1FydQ3dyFbUsAnz/
         2FbrAONp0AgDgaiJWkEeRRtI3gOsiuMJ+lAUNj45Wn2JJDougEhxNXWE/fl9VUjjJHXk
         rJIM1dnOb485zcPbcXRzb4zifCrgbvBpGXjKz6Q/zWBxnVlFmm+XZj5nDW0kfe0qoRGY
         eSbQ==
X-Gm-Message-State: AHQUAubJ3lQWPr7H/YxYaKU6k2oXclVZaCG1n0z8YIwDsG2GVSIewat+
        LRHhEpWhVNtA2qqUMWuXg9B87fel1y7LSG4imsKfvQ==
X-Google-Smtp-Source: AHgI3Ia0RexaYBngZUDdyze/3SoScszyVi8pGd+DHoKd1jJ4G0BWeHyKNjYY+FDqxTUsOP8ToOcaZ9NMLeGvL6sEi+4=
X-Received: by 2002:a05:6830:10c1:: with SMTP id z1mr6036003oto.252.1549629999170;
 Fri, 08 Feb 2019 04:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20190204171757.32073-1-brgl@bgdev.pl> <20190204171757.32073-7-brgl@bgdev.pl>
 <3e80e485-10f0-1bf6-72eb-69d69a571cb6@ti.com>
In-Reply-To: <3e80e485-10f0-1bf6-72eb-69d69a571cb6@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 8 Feb 2019 13:46:28 +0100
Message-ID: <CAMpxmJUutUx5z0rdCziLbseZ6hmceJ0FZazJ0mYMu3pwAKuxRw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] ARM: davinci: da830: switch to using the
 clocksource driver
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 lut 2019 o 13:23 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 04/02/19 10:47 PM, Bartosz Golaszewski wrote:
> > -/*
> > - * T0_BOT: Timer 0, bottom           : Used for clock_event & clocksou=
rce
> > - * T0_TOP: Timer 0, top                      : Used by DSP
> > - * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
>
> Aren't we changing this usage model for DA830 now, leaving no clock for
> use by DSP? It seems to me that after these patches clockevent is always
> T0_BOT and clocksource is always T0_TOP.
>
> Thanks,
> Sekhar

No it's still the same. I added some comments to the driver's header in v2.

Bart
