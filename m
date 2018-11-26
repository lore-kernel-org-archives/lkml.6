Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393A9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF6920865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wAnp+c3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF6920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeK0Gee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeK0Ged (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:34:33 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E07720817;
        Mon, 26 Nov 2018 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543261164;
        bh=Ga50hgFCoYmiXP42HJ1CJuK/i4gWMYGAI8RPXANvWEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wAnp+c3c9OPDIDlJxuiHr8cQxMcYRjLDZ3SCX7BSgAHp3M46jm6JzQgowLzEA4bFu
         W2n9pd6GpzVPzKa9C93zWEZyG0B8cyQunwKxPIfNHluHpreKpZAD9p3eT6GbL0S+TF
         I4UxBFZztx90uc0oWoLDMlfrYy9FkbCBCNv++8To=
Received: by mail-qt1-f179.google.com with SMTP id v11so19010720qtc.2;
        Mon, 26 Nov 2018 11:39:24 -0800 (PST)
X-Gm-Message-State: AGRZ1gIaw1+leznSaCebikeyywoLoZXRqAyqGod9LbiA9hJJfoQs19vf
        Lqbxeozsx1mio+fjRzxsH11lUt0JIdpYJAbDJA==
X-Google-Smtp-Source: AJdET5e62A3CJlTPL1VduoEJ+FPIwMZxj/Tx4JnWtEMBTqlPiKWU3hTsQ/JliNTSH0Pzqd9HDCZH99UFWIuQ7vB2ziI=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr27947849qtf.26.1543261163841;
 Mon, 26 Nov 2018 11:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20181114125432.16044-1-tom@aussec.com> <20181114125432.16044-2-tom@aussec.com>
 <20181116224919.GA18008@bogus> <20181117213522.12672utznrvpbn56@www.aussec.com>
 <CAL_JsqKZHg5_8ghMmU4qO4CVZibcHOvtVJH669zod_6GLGakRg@mail.gmail.com> <20181118113502.55634v85ybgkt586@www.aussec.com>
In-Reply-To: <20181118113502.55634v85ybgkt586@www.aussec.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Nov 2018 13:39:12 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+_Fb8mRDf_g=qDVsw-KPnrdZunLksYrgBFvhehzVNX+g@mail.gmail.com>
Message-ID: <CAL_Jsq+_Fb8mRDf_g=qDVsw-KPnrdZunLksYrgBFvhehzVNX+g@mail.gmail.com>
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

On Sat, Nov 17, 2018 at 6:35 PM tom burkart <tom@aussec.com> wrote:
>
> Quoting Rob Herring <robh@kernel.org>:
>
> > On Sat, Nov 17, 2018 at 4:35 AM tom burkart <tom@aussec.com> wrote:
> >>
> >> Quoting Rob Herring <robh@kernel.org>:
> >>
> >> > On Wed, Nov 14, 2018 at 11:54:29PM +1100, Tom Burkart wrote:
> >> >> This patch changes the devicetree bindings for the pps-gpio driver
> >> >> from the integer based ABI to the descriptor based ABI.
> >> > ? That has nothing to do with DT.
> >>
> >> I believe it does, as the change in ABI forces a rename in the DT
> >> naming convention.
> >> This is due to the descriptor based ABI appending "-gpio" or "-gpios" (see
> >> Documentation/gpio/base.txt.)
> >> Admittedly, I may have called it by the wrong name due to ignorance,
> >> my apologies.
> >
> > If what you say is correct, then you can't change this driver. You'll
> > break compatibility with any existing DT.
> >
> > Changing the binding reasoning should purely be that this is the
> > preferred form. Bindings must be independent from changing kernel
> > APIs.
>
> See comments from Philip Zabel.  I misread the documentation and this
> has now been corrected in v8 of the patch.  I hope that eliminates all
> comments made above.
>
> >> >>  It also adds
> >> >> documentation for the device tree capture-clear option.  The legacy
> >> >> device tree entry for the GPIO pin is supported.
> >> >>
> >> >> Signed-off-by: Tom Burkart <tom@aussec.com>
> >> >> ---
> >> >>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 8 ++++++--
> >> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> index 3683874832ae..6c9fc0998d94 100644
> >> >> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> @@ -5,19 +5,23 @@ a GPIO pin.
> >> >>
> >> >>  Required properties:
> >> >>  - compatible: should be "pps-gpio"
> >> >> -- gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> >> >> +- pps-gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> >> >> +Alternatively (DEPRECATED), instead of pps-gpios above, it may have:
> >> >> +- gpios: one PPS GPIO as above
> >> >>
> >> >>  Optional properties:
> >> >>  - assert-falling-edge: when present, assert is indicated by a
> >> falling edge
> >> >>                         (instead of by a rising edge)
> >> >> +- capture-clear: when present, also capture the PPS clear event
> >> >
> >> > Is this a h/w thing? or driver configuration?
> >>
> >> Driver configuration.  Most of the code was present in the driver, yet
> >> it was not documented, or usable due to a two line (code) omission
> >> (the value was not being fetched from DT).
> >
> > So what determines how you want to configure this? If the user will
> > want to change it, then it should be a sysfs attr and exposed to
> > userspace. If it depends on h/w config for a board then it can be in
> > DT.
>
> Sorry, I misled you somewhat.  If the PPS pulse active transition from
> the hardware is on the falling edge, this flag is required to get the
> OS to use that as the active transition.  This would not change at the
> user's whim but rather it is dependent on connected hardware.

This description sounds more like 'assert-falling-edge' than 'capture-clear'.

I'm still not clear on what 'capture-clear' is.

Rob
