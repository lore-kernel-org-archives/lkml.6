Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DA9C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0B920874
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ocw0Uu1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0B920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441432AbeKXGZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:25:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40994 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbeKXGZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:25:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so10761456oii.8;
        Fri, 23 Nov 2018 11:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnQH26rRZD7vhICcFXLasHpY+1RYNS+iVT/vBdvo2Fo=;
        b=ocw0Uu1qAVhwQ6GOWc+96V5MADv/Ai17Opf99rIiOSATAzr1eDKvPCp0MHwUavawF9
         VZDilzpp6gx3fGU71Q11K7pMt+UKWLVqNsBCTxOKnCWVzgixoW9a4HSt+ZRYd/F2SCxF
         FJ8NPTGYsFk2Sk/FGwsvYxyUMNDCW0SGqAM0dMGdmhIFGJGDQfbysGjCYYfr2/Sg2kS0
         rFKuYrRaeL9aihUMgr5WLsjFTx9LWEmctm+wdAMMTvLT1sP0/Wr2w8MApqZ6suxw45W6
         LDs/dPlbLbr4ShkwrZWpiT7O3T4U746qDzqRWehbYKecCPIRxeRGuNjpSptXgMNlU1vr
         vW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnQH26rRZD7vhICcFXLasHpY+1RYNS+iVT/vBdvo2Fo=;
        b=aiLOA3KuGZRh4Ih6fQVDESUwYnwrZlnLDE8QYOfjPFihia42+u+vvu9mJb7qhQ0UJq
         OpWkWN5N7qmQMMC6GBEnF60rmP0PWQUrJSZvRuxXzabOTHJj+A3Y8XmauA2kCOvNNRZy
         eyPUhIw/tO1EzlP/NuTYjruKxarHglnt/JISxdHFsg71jf7z/308fR7nbtKVESEFKZFi
         HrTNcgoJS2ExGPERlEo9suvA/AKBHxPHnLscDI4YHPBjMEXgBY0arDM84UNiKrwrpX7c
         JcGftEMX2BhRpMlx9bmTwXGkBdiswLFNQmJwwG84lsJJGULmV71r/yB1yyXLhNjA5Vio
         +Pkg==
X-Gm-Message-State: AGRZ1gIL+izypFNZ4jaJq0SUsIfOquOY1TpSqNHWQuxL6GZG2wvTU6Ht
        WBZD4FBWUnGe732Of10++DNg3IxT1KOnDtLTSgc=
X-Google-Smtp-Source: AJdET5dQ4QRmzuIf3x+2hbZYaE6LRwOEPxhzvUuJVMq0cCfn5A5Z4wNNGC/PG3gBEM5GyXiU17ekgTz9jYxpfopSeRI=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr9640736oib.181.1543002017387;
 Fri, 23 Nov 2018 11:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com> <4859b354-ade4-8172-eeb5-7a4a42045589@baylibre.com>
In-Reply-To: <4859b354-ade4-8172-eeb5-7a4a42045589@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 23 Nov 2018 20:40:06 +0100
Message-ID: <CAFBinCBExC-ZpD4RfzESv41fUZCODrv-VFODTKLrwAUC1UO+5w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Meson8b: add the CPU clock post-dividers
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 3:40 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 22/11/2018 22:40, Martin Blumenstingl wrote:
> > This is the successor to my previous series "meson8b: add the CPU_DIV16
> > clock for the ARM TWD" from [0]. I decided to not send this as v2 of
> > the original series because the PERIPH clock is not the CPU_DIV16 clock.
> > It's not clear whether a CPU_DIV16 clock exists.
> >
> > With this series we get all the CPU_CLK post-dividers as listed in the
> > public S805 datasheet [1] on pages 31 and 32:
> > - ABP
> > - PERIPH (used as input for the ARM global timer and ARM TWD timer)
> > - AXI
> > - L2 DRAM
> >
> > Each of these clocks has a register called "..._CLK_DIS" which is
> > documented as a "just in case" bit:
> > "Set to 1 to manually disable the [...] clock when changing the mux
> > selection. Typically this bit is set to 0 since the clock muxes can
> > switch without glitches."
> > Since we're not supposed to touch that register we're using the new
> > read-only gate clk_ops to ensure that nothing accidentally modifies
> > these bits.
> >
> > The result of this is that we can use the PERIPH clock which clocks
> > the ARM TWD timer. I will send a separate series to add the TWD timer.
> >
> >
> > changes since v1 at [2]:
> > - added new patch 2 "clk: meson: clk-regmap: add read-only gate ops"
> > - switched from CLK_IS_CRITICAL to the new clk_regmap_gate_ro_ops
> >   so we're consistent with all other read-only clocks
> > - collected Jerome's Acked-by tags (thanks!)
> >
> >
> > [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html
> > [1] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
> > [2] https://patchwork.kernel.org/cover/10687023/
> >
> >
> > Martin Blumenstingl (4):
> >   dt-bindings: clock: meson8b: export the CPU post dividers
> >   clk: meson: clk-regmap: add read-only gate ops
> >   clk: meson: meson8b: rename cpu_div2/cpu_div3 to
> >     cpu_in_div2/cpu_in_div3
> >   clk: meson: meson8b: add the CPU clock post divider clocks
> >
> >  drivers/clk/meson/clk-regmap.c           |   5 +
> >  drivers/clk/meson/clk-regmap.h           |   1 +
> >  drivers/clk/meson/meson8b.c              | 264 ++++++++++++++++++++++-
> >  drivers/clk/meson/meson8b.h              |  17 +-
> >  include/dt-bindings/clock/meson8b-clkc.h |   4 +
> >  5 files changed, 278 insertions(+), 13 deletions(-)
>
>
> Applied, with the bindings on next/headers
awesome, thank you Neil!
you even gave Kevin a tag with only the headers included - good for me
since I can sent the corresponding .dts patches now.


Regards
Martin
