Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE34C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726D221848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5OdNA/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfA3GIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:08:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39717 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfA3GIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:08:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so19640568ljh.6;
        Tue, 29 Jan 2019 22:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tK9mSywMDOVGyM/DNFGFSATJj9vh7JMH2LOwZoMxCSU=;
        b=C5OdNA/dZVLi++NRbdwbRb/GMtJvl/Xicn6gxjRWYNRcF3TmontlmU1lTiQEmkwqoB
         BhTTgGNx1w7iLP3IdZFH1owU2nUGy9gHn8zJo8hlPydipnQxMkhYFrwRLqRWJv8agl5+
         krCF7oMQHMd4FSwPyuMQzmwT5jyyuPPDnyaM1IO1UTp1zqdyQZ0RZrqdrqR7xX5YsCeK
         kgHcAS7wC11OFPgUsjaE/XYl1xwrzjRn9V4ETMdTtSt/e8gvJ0tVgykOTsXTjb9xZQyA
         G7LUQ4BJh4vRXV/j7hgb+/N9PvFzZQhImxtWIHw1VUkAgPTkJ9Jj/fXlOvlvCdhM26RR
         RdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tK9mSywMDOVGyM/DNFGFSATJj9vh7JMH2LOwZoMxCSU=;
        b=ImiNU2wG4DfpG+v8Vx7oWAwKuOOEh/4iyur/E5kzU3/I57UTlLsAVDX7c9n4p9ikNC
         y/Bimo5OsYwWAh3Zp3rRJP0VzW0DDMSPGXou2RWlkwwHUQJdPAGJ3xJ0abL9EIZZNiX3
         sEVevW2M3yAHk0NWP4jMWt3Qh2ei3TZk+venBtBNQ+PQ2g1pdOXqguK+EPEIVu1Pz9v7
         Huhq0t37agAM60lWnGUl1bAqPnFpeD9caDbWSdkPLFhLDknH7yVT9uejI160NJRUOc+R
         joeqKxFqlTQt2Yc7QmiZLojV1mAzyuCkNYLp2sgqiunpalMO5J9U4Hq0DTB5LVvsESz1
         KLJQ==
X-Gm-Message-State: AJcUukdxMId7GXtdO+0EiA//0ybIbn+xMvqjJZdP3KjjL1/ZGKSthSu/
        P18IPte0ZCV53QHQ0bbtlQ1YEEsfd9OgRCLxa/I=
X-Google-Smtp-Source: ALg8bN7iYMwPXszwp3vtyKv8V/4Hnn2sE0fNEzApNWxJGKodCBxAAidMGvxSKGF41DyvRdXfoPvYYDgtGnKnLob34/4=
X-Received: by 2002:a2e:9c87:: with SMTP id x7-v6mr22035012lji.196.1548828522133;
 Tue, 29 Jan 2019 22:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20190129200858.19773-1-goldsimon@gmx.de> <CANk1AXTcbqgoCYkTY-ssMvpAbdoncrkOxyRfu-piLE2tQ15a2g@mail.gmail.com>
In-Reply-To: <CANk1AXTcbqgoCYkTY-ssMvpAbdoncrkOxyRfu-piLE2tQ15a2g@mail.gmail.com>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Wed, 30 Jan 2019 07:08:30 +0100
Message-ID: <CAAh8qsz9g-20ZOZpT2Fh5003ZkH=HQ9sUBVHWqooB2Pt-OXA4Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
To:     Alan Tull <atull@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:31 PM Alan Tull <atull@kernel.org> wrote:
>
> On Tue, Jan 29, 2019 at 2:09 PM Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com> wrote:
>
> Hi Simon,
>
> Thanks for submitting.   A couple of things...
>
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index f365003f0..8f6c1a5d6 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -788,9 +788,9 @@
> >                         reg = <0xfffec000 0x100>;
> >                 };
> >
> > -               sdr: sdr@ffc25000 {
> > +               sdr: sdr@ffc20000 {
> >                         compatible = "altr,sdr-ctl", "syscon";
> > -                       reg = <0xffc25000 0x1000>;
> > +                       reg = <0xffc20000 0x6000>;
>
> The binding doc will also need this change (in a separate patch)
> Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt

Right. I didn't realise there is an actual address in that file as it says
"Example"...

But I'll make sure to change that if this patch is accepted.

>
> > diff --git a/arch/arm/mach-socfpga/self-refresh.S b/arch/arm/mach-socfpga/self-refresh.S
> > index f2d7f883e..bd7759357 100644
> > --- a/arch/arm/mach-socfpga/self-refresh.S
> > +++ b/arch/arm/mach-socfpga/self-refresh.S
> > @@ -19,8 +19,8 @@
> >  #define MAX_LOOP_COUNT         1000
> >
> >  /* Register offset */
> > -#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x54
> > -#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x58
> > +#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x5054
> > +#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x5058
>
> These offsets are used for ldr/sdr and are limited to 12 bits.  This
> won't build if CONFIG_SOCFPGA_SUSPEND is enabled.
>
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:
> Assembler messages:
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:65:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:67:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:72:
> Error: bad immediate value for offset (20568)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:101:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:103:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:108:
> Error: bad immediate value for offset (20568)
> /home/atull/repos/linux-socfpga/scripts/Makefile.build:367: recipe for
> target 'arch/arm/mach-socfpga/self-refresh.o' failed

Oops, you're right. Sorry for that. I just saw now that socfpga_defconfig
leaves CONFIG_SOCFPGA_SUSPEND inactive. I'll make sure to test that if it
comes to v2 (depending on the discussion).

Thanks,
Simon
