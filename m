Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2771A20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="omir/kKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2771A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407809AbeKWIxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:53:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34647 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392442AbeKWIxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:53:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so9182810otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 14:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNVnkyBUgZpbeX/f5pQRJIGAzpoNCBSjXqfSggAVv+M=;
        b=omir/kKqp8lVsm1YFAAUz21lrBURJ+0TKhphM8TkmZn2lLLU6lY/00mMO6sJJlXHHv
         iHtRKitba3yf6vebDMwRLghhkMgwQetUccYvXnviYnJSNuTOZVrSEW1/M475lO7ulrxH
         Ss1DeKUi/i6d7QrkyT0Xunvl8/iJw02Z46BtA4A37Y1i3xxTvIX6GRm9OFf3Y3FvZ5/d
         0YbZ6XK14m0YuLe012YAXWbNZL+9+1YTttTWpswFfExysN7bEWnl07WdGpfVey25ZW+3
         BVy+ZYm18loEK6B90LLiy3v/F//FyF9s5zvSPqxx0HGCcv7/qp3cTpoHwn7R5I6zISjx
         BpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNVnkyBUgZpbeX/f5pQRJIGAzpoNCBSjXqfSggAVv+M=;
        b=qnKpRd2D2fLXg6cnCTYcMNci1Sv+rebMMjbiz9+eUW5vkBOu5qZVJ6nBWscjJrbqMN
         WpmhDkms/+f9XUwQp7t3XfDNNtWr1fE/OVkK7piFTiAujHEK7ayXeyCyDEfUD/YLorLZ
         cQECdZED3DRBIGhbRIZgNIM1RhEMUyTq/ycTGH+rtKnRL4YHyyTXC3InUErggK38bMJB
         MVA0meXxhwuCtMF1GYVocVVOSzc8p5bBRjwMdvnG2fQKhusHVfVeWXI0u/iFHprf7zHc
         8Xz3e39c/oBgjLxuMd9iqPMmoq4tf93HWysaKyt6HfLJglTFgcfcuIegvg3cHZXEA02W
         qoXg==
X-Gm-Message-State: AA+aEWYUzqxeuJ+j/SGiLCj5A02P+cwC9MrnXXh6yezwaqN5lSRyKCJX
        jatsZv0SRu6N/Ak4Wvc3tN4qlMaR9FhE97y25EkGVB+x
X-Google-Smtp-Source: AFSGD/XcHuxtDnZt8HJRKzh8OEN+lPAiGk42do+OXMkXyLjWTMsL1OplP4MRmWC0cS65qYNSNwQ9x2kNI2kcxfl4ZFA=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr7573525otj.148.1542924750797;
 Thu, 22 Nov 2018 14:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20181115224657.14736-1-martin.blumenstingl@googlemail.com> <5ff1a888-cce2-8fd8-a98e-14c3d7c33acf@linaro.org>
In-Reply-To: <5ff1a888-cce2-8fd8-a98e-14c3d7c33acf@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 22 Nov 2018 23:12:08 +0100
Message-ID: <CAFBinCDSLEAzJVVgFxKhN3LCUwgC3Rrr=4ZhtHCdvqEPBLWbJA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] clocksource/meson6_timer: implement ARM delay timer
To:     daniel.lezcano@linaro.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sun, Nov 18, 2018 at 2:27 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 15/11/2018 23:46, Martin Blumenstingl wrote:
> > While trying to add support for the ARM TWD Timer and the ARM Global
> > Timer on Meson8, Meson8b and Meson8m2 (ARM Cortex-A5 and Cortex-A9 SoCs)
> > I did a review of the existing driver.
> > Unfortunately I found it hard to review because the pre-processor
> > #defines did not match the names from the public S805 datasheet. Thus
> > patch #1 adjusts these. No functional changes here, this is just
> > preparation work for patch #2.
> >
> > Using the ARM Global Timer (drivers/clocksource/arm_global_timer.c)
> > would have given us a timer-based delay implementation (so udelay() and
> > friends would use the timer instead of using a loop-based delay
> > implementation). Unfortunately we can't use the ARM Global Timer yet
> > because it's input clock is derived from the CPU clock (which can change
> > once we enable CPU frequency scaling on these SoCs, for which I will be
> > sending patches in the near future).
> > Amlogic's 3.10 kernel uses Timer E as delay timer which (with the
> > current configuration) has a resolution of 1us. So patch #2 uses
> > register_current_timer_delay() to register Timer E as ARM delay timer
> > (which will be especially useful as we have to use udelay() when
> > changing the CPU clocks during DVFS).
> >
> >
> > Changes since v1 at [0]:
> > - convert the enums for the input clock (meson6_timera_input_clock and
> >   meson6_timere_input_clock) to simple #defines as these are register
> >   values and not something driver-internal. All other register values
> >   are #defines so it makes sense that these are #defines as well.
> >
> >
> > [0] https://patchwork.kernel.org/cover/10658591/
> >
> >
> > Martin Blumenstingl (2):
> >   clocksource: meson6_timer: use register names from the datasheet
> >   clocksource: meson6_timer: implement ARM delay timer
> >
> >  drivers/clocksource/meson6_timer.c | 128 +++++++++++++++++++----------
> >  1 file changed, 85 insertions(+), 43 deletions(-)
>
> Both applied, thanks!
thank you for taking my patches

I have one question more: can you please push these patches to a
repository/branch which is included in -next?
I'm asking because I'd like to send patches that enable CPU frequency
scaling on Meson8, Meson8b and Meson8m2. The code to change the CPU
clock calls udelay(), which (in this special case) needs a delay timer
to work properly (we can't use jiffies as we're using udelay() *while*
changing the CPU clock).


Regards
Martin
