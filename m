Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05148C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5F02086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwQOGN5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5F02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeK2EPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbeK2EPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:15:50 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B622086B;
        Wed, 28 Nov 2018 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543425208;
        bh=m/j00d5/eO1GZ0ZOKqZAB9gyiMitG6wsBNb1kQywdvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SwQOGN5eppXKUKFsV4ifBAUtbinacfPX+/UjC776nHKrga3I3BpdBkYcAfZ3665Xr
         5ZWXyOE7ytcQgFPU0yH/heKVKqhNbfvpUSb9+Hfu+BSWCjupg/Lnu4/YiEUCSe83LF
         gp6KR/VmrQfsAkiXkBx3WKExnXFLzwqg+zfudn+M=
Received: by mail-qk1-f179.google.com with SMTP id m5so17203962qka.9;
        Wed, 28 Nov 2018 09:13:28 -0800 (PST)
X-Gm-Message-State: AA+aEWYC0rc7aLVKzNCJ4ABUDiZVlhkqCfkJhICNkM8jqstsNxQv5zzw
        VKsqLU4iv4Z9NUHj3edFfuDy6uH2OtVOgIIZoQ==
X-Google-Smtp-Source: AFSGD/XuA7qVAPQ9emztZRk9I9WhIgU35xm+54nkhwf0NozBclnD9F+jDxJocUG40J2RX4E93nZhfqpAFtBnFGnt7tg=
X-Received: by 2002:a37:b646:: with SMTP id g67mr34617688qkf.326.1543425207789;
 Wed, 28 Nov 2018 09:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20181114125432.16044-1-tom@aussec.com> <20181114125432.16044-2-tom@aussec.com>
 <20181116224919.GA18008@bogus> <20181117213522.12672utznrvpbn56@www.aussec.com>
 <CAL_JsqKZHg5_8ghMmU4qO4CVZibcHOvtVJH669zod_6GLGakRg@mail.gmail.com>
 <20181118113502.55634v85ybgkt586@www.aussec.com> <CAL_Jsq+_Fb8mRDf_g=qDVsw-KPnrdZunLksYrgBFvhehzVNX+g@mail.gmail.com>
 <20181127145729.128452ujmj4uhb55@aussec.com>
In-Reply-To: <20181127145729.128452ujmj4uhb55@aussec.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Nov 2018 11:13:16 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+-S2tF++VstMCeUrX4SXcB4B99Tc-SFUQ3R66KPHVf+Q@mail.gmail.com>
Message-ID: <CAL_Jsq+-S2tF++VstMCeUrX4SXcB4B99Tc-SFUQ3R66KPHVf+Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] dt-bindings: pps: descriptor-based gpio,
 capture-clear addition
To:     Tom Burkart <tom@aussec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 9:57 PM tom burkart <tom@aussec.com> wrote:
>
> Hi Rob,
>
> Quoting Rob Herring <robh@kernel.org>:
>
> > On Sat, Nov 17, 2018 at 6:35 PM tom burkart <tom@aussec.com> wrote:
> >>
> >> Quoting Rob Herring <robh@kernel.org>:
> >>
> >> > On Sat, Nov 17, 2018 at 4:35 AM tom burkart <tom@aussec.com> wrote:
> >> >>
> >> >> Quoting Rob Herring <robh@kernel.org>:
> >> >>
> >> >> > On Wed, Nov 14, 2018 at 11:54:29PM +1100, Tom Burkart wrote:
> >> >> >> This patch changes the devicetree bindings for the pps-gpio driver
> >> >> >> from the integer based ABI to the descriptor based ABI.
> >> >> > ? That has nothing to do with DT.
> >> >>
> >> >> I believe it does, as the change in ABI forces a rename in the DT
> >> >> naming convention.
> >> >> This is due to the descriptor based ABI appending "-gpio" or
> >> "-gpios" (see
> >> >> Documentation/gpio/base.txt.)
> >> >> Admittedly, I may have called it by the wrong name due to ignorance,
> >> >> my apologies.
> >> >
> >> > If what you say is correct, then you can't change this driver. You'll
> >> > break compatibility with any existing DT.
> >> >
> >> > Changing the binding reasoning should purely be that this is the
> >> > preferred form. Bindings must be independent from changing kernel
> >> > APIs.
> >>
> >> See comments from Philip Zabel.  I misread the documentation and this
> >> has now been corrected in v8 of the patch.  I hope that eliminates all
> >> comments made above.
> >>
> >> >> >>  It also adds
> >> >> >> documentation for the device tree capture-clear option.  The legacy
> >> >> >> device tree entry for the GPIO pin is supported.
> >> >> >>
> >> >> >> Signed-off-by: Tom Burkart <tom@aussec.com>
> >> >> >> ---
> >> >> >>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 8 ++++++--
> >> >> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >> >> >>
> >> >> >> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> >> b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> >> index 3683874832ae..6c9fc0998d94 100644
> >> >> >> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> >> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> >> @@ -5,19 +5,23 @@ a GPIO pin.
> >> >> >>
> >> >> >>  Required properties:
> >> >> >>  - compatible: should be "pps-gpio"
> >> >> >> -- gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> >> >> >> +- pps-gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> >> >> >> +Alternatively (DEPRECATED), instead of pps-gpios above, it may have:
> >> >> >> +- gpios: one PPS GPIO as above
> >> >> >>
> >> >> >>  Optional properties:
> >> >> >>  - assert-falling-edge: when present, assert is indicated by a
> >> >> falling edge
> >> >> >>                         (instead of by a rising edge)
> >> >> >> +- capture-clear: when present, also capture the PPS clear event
> >> >> >
> >> >> > Is this a h/w thing? or driver configuration?
> >> >>
> >> >> Driver configuration.  Most of the code was present in the driver, yet
> >> >> it was not documented, or usable due to a two line (code) omission
> >> >> (the value was not being fetched from DT).
> >> >
> >> > So what determines how you want to configure this? If the user will
> >> > want to change it, then it should be a sysfs attr and exposed to
> >> > userspace. If it depends on h/w config for a board then it can be in
> >> > DT.
> >>
> >> Sorry, I misled you somewhat.  If the PPS pulse active transition from
> >> the hardware is on the falling edge, this flag is required to get the
> >> OS to use that as the active transition.  This would not change at the
> >> user's whim but rather it is dependent on connected hardware.
> >
> > This description sounds more like 'assert-falling-edge' than 'capture-clear'.
> >
> > I'm still not clear on what 'capture-clear' is.
>
> Ignoring my patch for a minute, the pps_gpio_irq_handler will only
> report a pps PPS_CAPTURECLEAR event if 'capture-clear' is set.  As the
> current pps-gpio driver is not able to set this flag, it cannot ever
> report a PPS_CAPTURECLEAR event.
>
> My patch adds the ability to set this flag and adds the documentation
> to go with it.
> Admittedly, I do not require this functionality for what I want, but
> working with the code, I noticed the omission and decided to add it
> for someone else to use it, if they need it.
>
> I am happy to remove this out of my patch, if you feel this to be the
> best way forward.

I found this prior discussion on adding this[1]. Seems to me this
should be userspace configurable if the GPIO line can interrupt on
both edges. We shouldn't need a DT property to determine that.

Rob

[1] https://lore.kernel.org/patchwork/patch/557781/
