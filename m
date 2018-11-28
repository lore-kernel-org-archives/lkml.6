Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8C9C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E912208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E912208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeK1WT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:19:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41603 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeK1WT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:19:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id z28so21742251edi.8;
        Wed, 28 Nov 2018 03:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzxfgS9gsbjG2ZHUyJOEEkANG9BKskXeKiseFJ4pA/U=;
        b=ObBlwtB1Lk6wqGrG9J2cdkncBruAI9rHW9xiusQ9zQoU/RJHcLKAn+p01bjLiq+9e3
         Z6Ntlrg3bNHS2e4R3vhpWOM4fdPSIXcwtCZBFG2+xs3OSWJAJGWXmJ1vEqZrKpMfbvtQ
         I+cmWhvAd8z2QZhFDSIdA9DGZrmNelFak8wX3v2feqSQ8w/owEMTw7maOZ6J5xkVakT6
         8Eh6JukmWQO9ShCHOAVYK7v7r3trOFJf1yzifXFBlqZGkzg+Dq53HkjpqopLrtLLxMtc
         zwUybUJw0ALhqtKI+1dlBGzzsznXo1HGT1Nnsp7HpsXt4DSDQjXkyRfjGivBUNSEL0ee
         6eIA==
X-Gm-Message-State: AGRZ1gLVqyVb/sB+rCJ36/DsprYysD7XRqa5r4IibVH1HPyZs0Kz3qtq
        bxG3e83BDf19Ol/in6FKsv4VEMFrILE=
X-Google-Smtp-Source: AJdET5dnvcS6UWX4s/j9pTX1Q/dpbirt0LTZqsDV10C/SRO8nIJNhjLZnyA4vQ8jb0o1OwNDH/cV0Q==
X-Received: by 2002:a17:906:9154:: with SMTP id y20-v6mr26467881ejw.8.1543403918690;
        Wed, 28 Nov 2018 03:18:38 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id d5sm1752570edb.48.2018.11.28.03.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 03:18:38 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id j2so25915643wrw.1;
        Wed, 28 Nov 2018 03:18:38 -0800 (PST)
X-Received: by 2002:adf:891a:: with SMTP id s26mr30420916wrs.44.1543403917598;
 Wed, 28 Nov 2018 03:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20181128093013.24442-1-wens@csie.org> <20181128093013.24442-5-wens@csie.org>
 <20181128103219.b625lttcgoluhgz5@flea>
In-Reply-To: <20181128103219.b625lttcgoluhgz5@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 28 Nov 2018 19:18:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v67jPi-RFFkVrzHeh2XHeZV7ZN0tPCE=cOTpd6RQayH_Kg@mail.gmail.com>
Message-ID: <CAGb2v67jPi-RFFkVrzHeh2XHeZV7ZN0tPCE=cOTpd6RQayH_Kg@mail.gmail.com>
Subject: Re: [PATCH 04/15] dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 6:33 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Nov 28, 2018 at 05:30:01PM +0800, Chen-Yu Tsai wrote:
> > Experiments showed that on at least the H3/H5/A64 the RTC's internal
> > oscillator also feeds the CPUS mux in the PRCM.
> >
> > Export this clock through the device tree, instead of having to use
> > a dummy fixed-clock device node, for the PRCM to consume. This will
> > properly describe the relationship between the clocks.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> > index 78c4fb472eb7..1bd37faadecb 100644
> > --- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> > +++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> > @@ -24,7 +24,7 @@ Required properties:
> >
> >  Required properties for new device trees
> >  - clocks     : phandle to the 32kHz external oscillator
> > -- clock-output-names : names of the two clock outputs. See below.
> > +- clock-output-names : names of the three clock outputs. See below.
> >  - #clock-cells  : must be equal to 1.
> >
> >  The RTC provides the following clocks at the given indices:
> > @@ -32,6 +32,7 @@ The RTC provides the following clocks at the given indices:
> >  - 1: LOSC external output, known as X32KFOUT in the datasheet.
> >       This clock is not available on the A31 and is deprecated for old
> >       device trees still using the "allwinner,sun6i-a31-rtc" compatible.
> > +- 2: InternalOSC, or internal RC oscillator
>
> It seems to be required only for a few RTC though (H3, H5 and R40?)

IMO there's no harm in exporting it for all SoCs. I still don't know
if it's needed for the A31 either. And we don't have documents for the
PRCM stuff for any of the SoCs involved.

ChenYu
