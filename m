Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B442C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8692073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8692073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIEMX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:23:28 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37695 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeIEMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:23:28 -0400
Received: by mail-ua1-f68.google.com with SMTP id y10-v6so5068302uao.4;
        Wed, 05 Sep 2018 00:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ad/qRrnN4bLcopeN3HdSw1TMV2koQ9WNay3tso3QlhU=;
        b=r13MSDlQY0WY8e64BbA24lmv/TyGnHtOtyfFvHqbN3HSz/Un1jnP/Onpq0rCvbia1Q
         bJJMizR2Pa0RFC0qDouLQ5OoKTVg/0lDSDorSLPRF5dYyW+jxk89GXpabwywss9C3wAC
         fLDKcAtcHDKMkBNtO4Z/QotyIdG/SJ/9JzjeozWiXC1HzgpGGkt9Vc4tmVqTVriA1fxW
         muOTUSUoSaalgy/YHioYxRJcMP+oB4l9Jauj8Jj85iBcQiiZfS0nkiaDUx35GbHqkSYF
         +KxR6QMBeiUN2p+EJwHF4G4EGwIZ+p/nCvXBz8I05CuhmfeBYbFod0LsP2rAQqMnkVpa
         R8hg==
X-Gm-Message-State: APzg51CC9y3rOlWgnSvSUzncgW2bUzkaWZ4nAAikUmG99DOOUOCtslXK
        XzhfvhAdS+pfEj+7jcyr8aAsKTWcV/1imYfqisw=
X-Google-Smtp-Source: ANB0VdbAsD3h0aj8HvD1SpZQlJH9QVI9XTox2Bmva4EHL91FNE1tbNZPJc/Fy7VD20Yy/ip0An/cRQVyyrIJddZ0l6M=
X-Received: by 2002:a67:33cc:: with SMTP id z195-v6mr12319765vsz.40.1536134070170;
 Wed, 05 Sep 2018 00:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180808090944.861-1-simon.k.r.goldschmidt@gmail.com>
 <f27a5e90-9783-761e-a87b-9b8a2d46d2a4@denx.de> <CAAh8qsyHxMjwBtBa5pYejkOxwFRbbFbt+myC4ynQQonK8MAo-w@mail.gmail.com>
 <ba66504e-c002-7dc6-daed-633fee896131@denx.de>
In-Reply-To: <ba66504e-c002-7dc6-daed-633fee896131@denx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Sep 2018 09:54:18 +0200
Message-ID: <CAMuHMdUMaggMHmPWRh081UD8AFgq58Rfsdz22xpt9fHUTyx92g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: socfpga: use stdout-path for chosen node
To:     Marek Vasut <marex@denx.de>
Cc:     simon.k.r.goldschmidt@gmail.com, Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 2:11 PM Marek Vasut <marex@denx.de> wrote:
> On 08/08/2018 02:02 PM, Simon Goldschmidt wrote:
> > On Wed, Aug 8, 2018 at 1:32 PM Marek Vasut <marex@denx.de> wrote:
> >> On 08/08/2018 11:09 AM, Simon Goldschmidt wrote:
> >>> Use stdout-path dts property for kernel console.
> >>>
> >>> There were two socfpga boards left not using stdout-path:
> >>> socrates and vining. Make sure they match the other boards.
> >>>
> >>> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> >>> ---
> >>>  arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    | 3 ++-
> >>>  arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 3 ++-
> >>>  2 files changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
> >>> index 53bf99eef66d..6f5255a7d192 100644
> >>> --- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
> >>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
> >>> @@ -22,7 +22,8 @@
> >>>       compatible = "ebv,socrates", "altr,socfpga-cyclone5", "altr,socfpga";
> >>>
> >>>       chosen {
> >>> -             bootargs = "console=ttyS0,115200";
> >>> +             bootargs = "earlyprintk";
> >>> +             stdout-path = "serial0:115200n8";
> >>>       };
> >>>
> >>>       memory@0 {
> >>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> >>> index f50b19447de6..e61efe16e79c 100644
> >>> --- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> >>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> >>> @@ -54,7 +54,8 @@
> >>>       compatible = "samtec,vining", "altr,socfpga-cyclone5", "altr,socfpga";
> >>>
> >>>       chosen {
> >>> -             bootargs = "console=ttyS0,115200";
> >>> +             bootargs = "earlyprintk";
> >>
> >> Why this earlyprintk ?
> >
> > The reason is Dinh added that to all socfpga boards in his commit [1]
> > and I wanted the remaining two boards to be the same.
>
> Isn't earlyprintk mostly a debugging aid ?

Indeed.

And the modern way is "earlycon", not "earlyprintk".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
