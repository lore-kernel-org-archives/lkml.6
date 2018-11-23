Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA462C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F1720824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JFPrnCGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F1720824
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441444AbeKXG0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:26:19 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42327 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbeKXG0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:26:19 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so10758599oiw.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWBNvleb3we7zdiN1V8Y2BZlY6+9lbqF6lapJLt55fw=;
        b=JFPrnCGCZBAtfW+1m2bRpDs2eAmBM4zdcFoPZgoU0YwbhlOeQ+8/a/cRqMMy4977gX
         a4TseXwAOZ30m/u1tMLWtYjiPl2Sk0I0yNXXF3vsfTM/XY+/hgUBazzMZfxjIEB3L9fZ
         PiuiRlWCX6y++PXAS424nXddun2VOeTNSppRkm4VN7Q7k5bqMpWkINHSOK4KA96uCKSU
         yfZeZPyN+4tD3kEhOo2/wZYEJxWTFwLgZhenjFiq+Jzaks5GxG7YNJSgk70UhfPWLJGO
         XmLcsSmXVyn3e2+rYiNnWohw5LYO/94CRx2q6Csp7G3kLmFuqSL7JfOEcbgQo2K76dn4
         M1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWBNvleb3we7zdiN1V8Y2BZlY6+9lbqF6lapJLt55fw=;
        b=i7cayj8Y3qRvJCrVxsPQGUMk+qW4PCVGw+YWbj8SX3b+BhCYzbdJv51pnnOoxDiAm8
         0bOBWDPDBHtupTd8zZTPKGS273Jg2fLXdhHBFl9JpoLLQO3hYkEJSYFt09crUg+Nii8o
         lMaZZg88WBNi6asoCChzSM4LJmMqeFS1d7GW5IROb1rxoJrow1T9QkT1HPWvlzsQQIO7
         fdcBhsSa6sP25++6zLVXVRWPeELQnS7q4hTZmOujxx2ALNWJRV2+g6iOYHZVEaaGlmDg
         KpTA39teT3rODXiIG6UoU7JgaxwWLiFHM2IELjm51wg0JQCfd02H46BGgYPFepvyZWV3
         5fKw==
X-Gm-Message-State: AGRZ1gKk9RcZ+cP2MUBrIWOrA/mgVWj53Sg9HiyXtg2V/s/MStHqkdIF
        GN7WIyiunj9/Ct9K29XoWzaI6Qtvg15r3R0OJUM=
X-Google-Smtp-Source: AJdET5ebJ6Rl1C5zn1O7m3kYScllQsRV1519kxVZnhMxKSNjfE0rGg9FhDAcoWFmrOPYnZfelXoBXXQKwmLnm3Vc/C0=
X-Received: by 2002:aca:f0f:: with SMTP id 15mr9802459oip.47.1543002039560;
 Fri, 23 Nov 2018 11:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20181115224657.14736-1-martin.blumenstingl@googlemail.com>
 <5ff1a888-cce2-8fd8-a98e-14c3d7c33acf@linaro.org> <CAFBinCDSLEAzJVVgFxKhN3LCUwgC3Rrr=4ZhtHCdvqEPBLWbJA@mail.gmail.com>
 <a83b92fb-5950-01b8-521d-7b05939dce3a@linaro.org>
In-Reply-To: <a83b92fb-5950-01b8-521d-7b05939dce3a@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 23 Nov 2018 20:40:28 +0100
Message-ID: <CAFBinCA+htBGeT3SfTdCivmKpq3bBF7vAvR-OWqnwO-rgXx22w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] clocksource/meson6_timer: implement ARM delay timer
To:     daniel.lezcano@linaro.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 7:15 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/11/2018 23:12, Martin Blumenstingl wrote:
> > Hi Daniel,
> >
> > On Sun, Nov 18, 2018 at 2:27 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 15/11/2018 23:46, Martin Blumenstingl wrote:
> >>> While trying to add support for the ARM TWD Timer and the ARM Global
> >>> Timer on Meson8, Meson8b and Meson8m2 (ARM Cortex-A5 and Cortex-A9 SoCs)
> >>> I did a review of the existing driver.
> >>> Unfortunately I found it hard to review because the pre-processor
> >>> #defines did not match the names from the public S805 datasheet. Thus
> >>> patch #1 adjusts these. No functional changes here, this is just
> >>> preparation work for patch #2.
> >>>
> >>> Using the ARM Global Timer (drivers/clocksource/arm_global_timer.c)
> >>> would have given us a timer-based delay implementation (so udelay() and
> >>> friends would use the timer instead of using a loop-based delay
> >>> implementation). Unfortunately we can't use the ARM Global Timer yet
> >>> because it's input clock is derived from the CPU clock (which can change
> >>> once we enable CPU frequency scaling on these SoCs, for which I will be
> >>> sending patches in the near future).
> >>> Amlogic's 3.10 kernel uses Timer E as delay timer which (with the
> >>> current configuration) has a resolution of 1us. So patch #2 uses
> >>> register_current_timer_delay() to register Timer E as ARM delay timer
> >>> (which will be especially useful as we have to use udelay() when
> >>> changing the CPU clocks during DVFS).
> >>>
> >>>
> >>> Changes since v1 at [0]:
> >>> - convert the enums for the input clock (meson6_timera_input_clock and
> >>>   meson6_timere_input_clock) to simple #defines as these are register
> >>>   values and not something driver-internal. All other register values
> >>>   are #defines so it makes sense that these are #defines as well.
> >>>
> >>>
> >>> [0] https://patchwork.kernel.org/cover/10658591/
> >>>
> >>>
> >>> Martin Blumenstingl (2):
> >>>   clocksource: meson6_timer: use register names from the datasheet
> >>>   clocksource: meson6_timer: implement ARM delay timer
> >>>
> >>>  drivers/clocksource/meson6_timer.c | 128 +++++++++++++++++++----------
> >>>  1 file changed, 85 insertions(+), 43 deletions(-)
> >>
> >> Both applied, thanks!
> > thank you for taking my patches
> >
> > I have one question more: can you please push these patches to a
> > repository/branch which is included in -next?
> > I'm asking because I'd like to send patches that enable CPU frequency
> > scaling on Meson8, Meson8b and Meson8m2. The code to change the CPU
> > clock calls udelay(), which (in this special case) needs a delay timer
> > to work properly (we can't use jiffies as we're using udelay() *while*
> > changing the CPU clock).
>
> branch pushed [1], should appear in linux-next very soon.
awesome, thank you!


Regards
Martin
