Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB5EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605AE24066
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605AE24066
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeGFIxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:53:40 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45743 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbeGFIxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:53:34 -0400
Received: by mail-vk0-f65.google.com with SMTP id l64-v6so6407353vkl.12;
        Fri, 06 Jul 2018 01:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqzwifUvKook9lHUDOy+vO0qIAkj/9wCtd7s6Y+rbpI=;
        b=S3X5yGlL3/MnHht/mOBE28vtHBOpGpt0cOXIrqcUaxf4gx0ObeRnxFLyo07B/HL/oy
         7/6UkB6M52n5PTRns5orfPPMSM8QyRBX80hNsSyq+JQv4jwHppSN2GcM/ioidbwsQlgL
         YONq1sg+PBiz0SaaVuKf71jQVhWQHEWnEYBcxylf6hH2mgQdWevKre/wdYZfda/3jT3o
         hXYtZKmLv1+3Toji7XX52vNeiYTz5KI3XhlTLaqWD6tEkm07JhXmQRWOGsslmoXogTmi
         4uVhrNnyHuWrMY+MbkUwyHg9f4E05oEfEtVJkiOVH8HY/AKQJJYuwQ8nXXNgKCGDfjW0
         tsow==
X-Gm-Message-State: APt69E3f1BtDAWjZ4V94a5/UwF88tUFinRJ1q5QU5SwNpreACkHt07zA
        xf+vn9EhFcM1ZVTZpdBM1yKCnm3oChIksQxEC3g=
X-Google-Smtp-Source: AAOMgpd6ZWQpFhKkx5HfLNaacsfmOUGqc/XRfy7zB06J8d74WxXt05nPUWX61MsRfd5t6uLxSo/xg+FkabiiLh7n8Hk=
X-Received: by 2002:a1f:f44f:: with SMTP id s76-v6mr5144440vkh.125.1530867213658;
 Fri, 06 Jul 2018 01:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <1526995765-29693-1-git-send-email-geert+renesas@glider.be>
 <20180523083746.f4nkz4uhjwfgw7yz@verge.net.au> <CAMuHMdV2VwoD3Le=T4-+Ek2E9tL+hmiR0r4cXxG9EH4GXV-uTw@mail.gmail.com>
In-Reply-To: <CAMuHMdV2VwoD3Le=T4-+Ek2E9tL+hmiR0r4cXxG9EH4GXV-uTw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Jul 2018 10:53:22 +0200
Message-ID: <CAMuHMdV8McM-V5zME1DKE0nsdtVLU25mk9QQCNwNL74V9c2Cag@mail.gmail.com>
Subject: Re: [PATCH/RFC] ARM: dts: r8a7791: Move enable-method to CPU nodes
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 10:50 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, May 23, 2018 at 10:37 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, May 22, 2018 at 03:29:25PM +0200, Geert Uytterhoeven wrote:
> >> According to Documentation/devicetree/bindings/arm/cpus.txt, the
> >> "enable-method" property should be a property of the individual CPU
> >> nodes, not of the parent "cpus" node.  However, on R-Car M2-W (and on
> >> several other arm32 SoCs), the property is tied to the "cpus" node
> >> instead.
> >>
> >> Secondary CPU bringup and CPU hot (un)plug work regardless, as
> >> arm_dt_init_cpu_maps() falls back to looking in the "cpus" node.
> >>
> >> The cpuidle code does not have such a fallback, so it does not detect
> >> the enable-method.  Note that cpuidle does not support the
> >> "renesas,apmu" enable-method yet, so for now this does not make any
> >> difference.
> >
> > Is the implication that if we keep the current binding for cpu nodes
> > then at some point we will need to update the cpuidle binding?
>
> If we keep the current binding for cpu nodes, we indeed have to update
> (common) Documentation/devicetree/bindings/arm/cpus.txt.
>
> In addition, if we want to add renesas,apmu-based cpuidle support later,
> we will have to update the common cpuidle code to look in /cpus, too.

Any comments from the DT/ARM people?
Thanks!

> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> Arm64 and powerpc do not have such a fallback, but SH has, like arm32.
> >>
> >> This is marked RFC, as the alternative is to update the DT bindings to
> >> keep the status quo.
> >> ---
> >>  arch/arm/boot/dts/r8a7791.dtsi | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> >> index d568bd22d6cbd855..b214cb8f52e47109 100644
> >> --- a/arch/arm/boot/dts/r8a7791.dtsi
> >> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> >> @@ -71,7 +71,6 @@
> >>       cpus {
> >>               #address-cells = <1>;
> >>               #size-cells = <0>;
> >> -             enable-method = "renesas,apmu";
> >>
> >>               cpu0: cpu@0 {
> >>                       device_type = "cpu";
> >> @@ -83,6 +82,7 @@
> >>                       clock-latency = <300000>; /* 300 us */
> >>                       power-domains = <&sysc R8A7791_PD_CA15_CPU0>;
> >>                       next-level-cache = <&L2_CA15>;
> >> +                     enable-method = "renesas,apmu";
> >>
> >>                       /* kHz - uV - OPPs unknown yet */
> >>                       operating-points = <1500000 1000000>,
> >> @@ -101,6 +101,7 @@
> >>                       clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
> >>                       power-domains = <&sysc R8A7791_PD_CA15_CPU1>;
> >>                       next-level-cache = <&L2_CA15>;
> >> +                     enable-method = "renesas,apmu";
> >>               };
> >>
> >>               L2_CA15: cache-controller-0 {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
