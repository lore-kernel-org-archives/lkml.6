Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA0C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7559E20840
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7559E20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeKASiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:38:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39361 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeKASiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:38:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5-v6so16011288eds.6;
        Thu, 01 Nov 2018 02:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srELMBaZoJTOEpN9bgRZ18NOQGrVhsf7voENzP1bhZI=;
        b=oThfNM4PaFitYXQO2RTMEduai6JPphuNt/T5Y53rMejV6yo4YnNY2LnhQx3zvCE8SL
         tGJ5kKH8rRKmEu9kP516xXIXdD1qnB4Thpc2/OUngcvnO/zwQGRuKvM58t3KJNMK+kYs
         r+rL1FfL/bd1y5TR8b19m1xYzNWwpX/jJxHgWcUoFAW2RAD+wVvBg8ImZ12s+sZTvV3H
         er3iPOVb7YqhruqjlemVLutLVq9pl6yb6YfBJdfLlzAOnIL22/J1eV6J0tvJvfmZZ62L
         3YwuCbUsJEPr1vPync53RbQqzvslTni22hm3gBnQdTd5WGJgPeOnoHO3PmH8telVvp23
         4OgQ==
X-Gm-Message-State: AGRZ1gJ7AEH2MWXmykmQCIBRi+UqT6OhuNYrp3a4/+MI20lsLOYiiXcr
        vBWA+UCSzAtAsjRM6HckFtPlwbBkVsY=
X-Google-Smtp-Source: AJdET5euoayh76uRYVtjcOwYZnckM8OmpGb18HTTpnoEWZvJSAWFbhl0nuph2hUqqi1arFaKZE2xDg==
X-Received: by 2002:a17:906:4d2:: with SMTP id g18-v6mr324579eja.182.1541064967453;
        Thu, 01 Nov 2018 02:36:07 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id i17-v6sm4306642edq.75.2018.11.01.02.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 02:36:06 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id h2-v6so805707wmb.0;
        Thu, 01 Nov 2018 02:36:06 -0700 (PDT)
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr4865329wme.8.1541064965729;
 Thu, 01 Nov 2018 02:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-5-jagan@amarulasolutions.com> <CAGb2v64fnpCh_rCy-9m8xgXmAZQGab1==f7cr332QfgueyuRNw@mail.gmail.com>
 <CAMty3ZAW5KndyJj81obK49MKczdbk4SoUncmiiE_OhH1g7qFUA@mail.gmail.com>
 <CAGb2v67WZmG7qPqf_UoR4v=Zm2AbS8pcOQsWJPRVHr-i2NvRPA@mail.gmail.com> <CAMty3ZBJiDrr0hqgzMMQ76R7=+agsHyjYQGTrebH=_q5Ax2xXA@mail.gmail.com>
In-Reply-To: <CAMty3ZBJiDrr0hqgzMMQ76R7=+agsHyjYQGTrebH=_q5Ax2xXA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 1 Nov 2018 17:35:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v64T0zEmyELmJ5X-isohV6FWb9C5N-h+w-s16vjth2dMJg@mail.gmail.com>
Message-ID: <CAGb2v64T0zEmyELmJ5X-isohV6FWb9C5N-h+w-s16vjth2dMJg@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: allwinner: h6: Add RTC node
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, Jagan Teki <jagan@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 5:02 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Nov 1, 2018 at 1:23 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Thu, Nov 1, 2018 at 3:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Thu, Nov 1, 2018 at 8:25 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > > >
> > > > On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > >
> > > > > From: Jagan Teki <jagan@openedev.com>
> > > > >
> > > > > RTC controller is similar to A31, so use the same compatible
> > > > > for H6 and update interrupt numbers as per manual.
> > > >
> > > > No. Unfortunately they are not that compatible. The A31 does not have
> > > > the RTC clock output. So everyone got it wrong. :( Plus the clock rate
> > > > of the internal RC oscillator varies between SoCs. I'm working on a
> > > > series of patches to correct this. Stay tuned.
> > >
> > > 4 bit, EXT_LOSC_EN of LOSC_CTRL_REG (0x00) seem available in H6. I can
> > > see external clock working with WIFI for A31 compatible.
> >
> > That bit turns on the external crystal, i.e. X32KIN and X32KOUT pins.
>
> This is what I confused, the same signal pins available there in A64
> schematics but no bit to enable external OSC in LOSC_CTRL_REG.
>
> But the X32KFOUT pin which is 0x60 , BIT(0) is enabled in A64, H6 w/o
> this LOSC_CTRL_REG which I don't know exactly or may be feed it by
> default not sure.
>
> >
> > I'm talking about the X32KFOUT pin, which feeds the WiFi module the
> > LPO clock in typical Allwinner designs. That is controlled by register
> > 0x60, and is not present on the A31. That is the clock you say is
> > working. You have the two confused.
> >
> > The clock tree looks like this:
> >
> > IOSC -----------------------------\
> >                                    SUN6I_LOSC_CTRL_EXT_OSC mux ---->
> > LOSC --> (to CCU)
> > 32k crystal --> EXT_LOSC_EN gate -/                              \
> >                                                                   \
> >                                                                   /
> >       (to WiFi) <-- X32KFOUT pin <-- LOSC_OUT_GATING_EN gate <---/
>
> Yes, I understand this. But for A33, A64 there is no EXT_LOSC_EN which
> is directly feed to WIFI from LOSC as per manual but from schematic
> signals X32KI and X32KO were present.

No. Read the schematic again. CAREFULLY. The pin that feeds the WiFi module
is called X32KFOUT. With an "F". The A33 datasheet says the pin is "Clock
Output of LOSC (X32KFOUT can be gating)". The A64 datasheet may not mention
the output can be gated, but the LOSC_OUT_GATING_REG register is aptly named
"LOSC Output Gating Register".

And see below about the EXT_LOSC_EN bit. You are confusing input to the RTC
module vs output from the RTC module. All crystals have an IN and an OUT
connection. It's just the way they work.

> > The bottom part does not exist in the A31. Meanwhile we've been claiming that
> > all later RTC modules that actually have that part are compatible with the A31.
> > Also the IOSC part has different clock rates for different chips.
> >
> > Do you see the problem?
>
> From external crystal point of view, between A33, A64 vs H6 I only see
> the difference in EXT_LOSC_EN external oscillator enable bit only
> available in H6 manual.

You are focusing on the wrong thing. From the driver's point of view,
we simply don't care about this bit. It is by default on. We might want
to force enable it if some broken bootloader turns it off, but that is
besides the point here. And on all the other SoCs, the absence of this
bit means that the external crystal will always be on.

Furthermore, this bit concerns the "input" from the crystal to the RTC.
What I'm concerned about, and what you should be concerned about, because
that's what you're using, is the LOSC_OUT_GATING_EN bit. As mentioned this
does not exist on the A31.

>
> Regarding, rtc-sun6i. we can manage the external clock stuff via
> "clock-output-names" with rtc->ext_losc and mentioning external
> oscillator outputs on DTSI. since A31, don't have external clock to
> wifi then we can skip those properties.
>
> What do you think?

That's not correct. On the A31, the RTC's LOSC still feeds the CCU,
so output index 0 is always valid. Output index 1 on the A31 is invalid
because it simply doesn't have this in the hardware. Furthermore, you're
still not dealing with the fact that one A23/A33 the IOSC is 600~700 kHZ,
on the A64/H3/H5/H6 it is 16 MHz, and on the V3/V3s it is 32 kHz. The
first two cases also have prescalers to divide the clock rate down to
around 32 kHz. All these hardware details need to be tied to new compatible
strings, so that the driver knows about them and can handle them if needed.
What you're describing is very fragile and pretty much a hack. We already
have enough of those.

ChenYu
