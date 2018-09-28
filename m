Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440DBC64E93
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3082073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3082073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeI2DHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:07:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46738 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeI2DHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:07:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id k64-v6so6515446oia.13;
        Fri, 28 Sep 2018 13:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QazDEMp1DUrObDqQ8G9xdW3UlS9WHz9291NmeVJyp4=;
        b=oyEu0Q/tQFPHR4rpO7+pngJCtV0TChxy2avadDc/ReMn0UW4UNemxAfwGd2TjdvwI1
         dCNpUj8sWqCY8J3s+J9PF6wqA3Ns59g8FppAWUQS0hCYYhuFQxYEuZRjgnoax1voC6Mw
         dh+pWiMzMZblnyRonxqGQ6TBwQA6K45DNrz7YeA757Q2Lcz2KkHdU1p1OrW4ReDuGwRi
         uMw/LTZso7lzL5c3dLwiyAU3iwzuqcUhsM2oIMUedrdFmISBGfkPVFxG1L5Zgok3jyEy
         zU8rXdojq8lLAQf6bd9GeZgLJA4ocX01UbxIByE7euoUM7kSWI5Q5krUNrcf4N2iKYO2
         NOHQ==
X-Gm-Message-State: ABuFfogccqJOxhqvZC09Te3Tpqy18+iRcv5yo/SaE01OjNvE1gn4FBXm
        0uR1IHjVjDqZ93cyJlT8cVUXl1AnudM=
X-Google-Smtp-Source: ACcGV60b7rZU8BB8uG9e6t1PdBpTvG2osRsuuGhj2uBdiiOPQH7Jl6aHr4Q0nFJY07H7txiM19dMsQ==
X-Received: by 2002:aca:ef0a:: with SMTP id n10-v6mr178247oih.326.1538167291902;
        Fri, 28 Sep 2018 13:41:31 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id k18-v6sm1958851oib.38.2018.09.28.13.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 13:41:30 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id e18-v6so7278300oti.8;
        Fri, 28 Sep 2018 13:41:30 -0700 (PDT)
X-Received: by 2002:a9d:42f1:: with SMTP id c46-v6mr174273otj.331.1538167290021;
 Fri, 28 Sep 2018 13:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com> <1537747741-6245-6-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1537747741-6245-6-git-send-email-vabhav.sharma@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 28 Sep 2018 15:41:18 -0500
X-Gmail-Original-Message-ID: <CADRPPNT7Fcv=gkN4iB+7QYUpFqi5wJWmXKRnK893eBa6GWi1dw@mail.gmail.com>
Message-ID: <CADRPPNT7Fcv=gkN4iB+7QYUpFqi5wJWmXKRnK893eBa6GWi1dw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] arm64: dts: add QorIQ LX2160A SoC support
To:     vabhav.sharma@nxp.com
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Scott Wood <oss@buserror.net>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        yamada.masahiro@socionext.com, yogeshnarayan.gaur@nxp.com,
        udit.kumar@nxp.com, Priyanka Jain <priyanka.jain@nxp.com>,
        Ying Zhang <ying.zhang22455@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Ramneek Mehresh <ramneek.mehresh@nxp.com>, V.Sethi@nxp.com,
        nipun.gupta@nxp.com, Sriram Dash <sriram.dash@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 7:47 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.
>
> LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor cores
> in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8 I2C
> controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011 SBSA
> UARTs etc.
>
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 693 +++++++++++++++++++++++++
>  1 file changed, 693 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> new file mode 100644
> index 0000000..46eea16
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -0,0 +1,693 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree Include file for Layerscape-LX2160A family SoC.
> +//
> +// Copyright 2018 NXP
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>

You included the header file, but you didn't use the MACROs in most of
the interrupts property below.  It is recommended to use them for
better readibity.

> +
> +/memreserve/ 0x80000000 0x00010000;
> +
> +/ {
> +       compatible = "fsl,lx2160a";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               // 8 clusters having 2 Cortex-A72 cores each
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x0>;
> +                       clocks = <&clockgen 1 0>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster0_l2>;

enable-method is a required property for this and cpu below.

> +               };
> +
> +               cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x1>;
> +                       clocks = <&clockgen 1 0>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster0_l2>;
> +               };
> +
> +               cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x100>;
> +                       clocks = <&clockgen 1 1>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster1_l2>;
> +               };
> +
> +               cpu@101 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x101>;
> +                       clocks = <&clockgen 1 1>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster1_l2>;
> +               };
> +
> +               cpu@200 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x200>;
> +                       clocks = <&clockgen 1 2>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster2_l2>;
> +               };
> +
> +               cpu@201 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x201>;
> +                       clocks = <&clockgen 1 2>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster2_l2>;
> +               };
> +
> +               cpu@300 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x300>;
> +                       clocks = <&clockgen 1 3>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster3_l2>;
> +               };
> +
> +               cpu@301 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x301>;
> +                       clocks = <&clockgen 1 3>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster3_l2>;
> +               };
> +
> +               cpu@400 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x400>;
> +                       clocks = <&clockgen 1 4>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster4_l2>;
> +               };
> +
> +               cpu@401 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x401>;
> +                       clocks = <&clockgen 1 4>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster4_l2>;
> +               };
> +
> +               cpu@500 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x500>;
> +                       clocks = <&clockgen 1 5>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster5_l2>;
> +               };
> +
> +               cpu@501 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x501>;
> +                       clocks = <&clockgen 1 5>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster5_l2>;
> +               };
> +
> +               cpu@600 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x600>;
> +                       clocks = <&clockgen 1 6>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster6_l2>;
> +               };
> +
> +               cpu@601 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x601>;
> +                       clocks = <&clockgen 1 6>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster6_l2>;
> +               };
> +
> +               cpu@700 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x700>;
> +                       clocks = <&clockgen 1 7>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster7_l2>;
> +               };
> +
> +               cpu@701 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x701>;
> +                       clocks = <&clockgen 1 7>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster7_l2>;
> +               };
> +
> +               cluster0_l2: l2-cache0 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster1_l2: l2-cache1 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster2_l2: l2-cache2 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster3_l2: l2-cache3 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster4_l2: l2-cache4 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster5_l2: l2-cache5 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster6_l2: l2-cache6 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster7_l2: l2-cache7 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +       };
> +
> +       gic: interrupt-controller@6000000 {
> +               compatible = "arm,gic-v3";
> +               reg = <0x0 0x06000000 0 0x10000>, // GIC Dist
> +                       <0x0 0x06200000 0 0x200000>, // GICR (RD_base +
> +                                                    // SGI_base)
> +                       <0x0 0x0c0c0000 0 0x2000>, // GICC
> +                       <0x0 0x0c0d0000 0 0x1000>, // GICH
> +                       <0x0 0x0c0e0000 0 0x20000>; // GICV
> +               #interrupt-cells = <3>;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +               interrupt-controller;
> +               interrupts = <1 9 0x4>;
> +
> +               its: gic-its@6020000 {
> +                       compatible = "arm,gic-v3-its";
> +                       msi-controller;
> +                       reg = <0x0 0x6020000 0 0x20000>;
> +               };
> +       };
> +
> +       rstcr: syscon@1e60000 {
> +               compatible = "syscon";
> +               reg = <0x0 0x1e60000 0x0 0x4>;
> +       };

This is no use if you don't have a syscon-reboot node pointing to it.

> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <1 13 4>,
> +                            <1 14 4>,
> +                            <1 11 4>,
> +                            <1 10 4>;
> +       };
> +
> +       pmu {
> +               compatible = "arm,cortex-a72-pmu";
> +               interrupts = <1 7 0x8>; // PMU PPI, Level low type
> +       };
> +
> +       psci {
> +               compatible = "arm,psci-0.2";
> +               method = "smc";
> +       };
> +
> +       memory@80000000 {
> +               // DRAM space - 1, size : 2 GB DRAM
> +               device_type = "memory";
> +               reg = <0x00000000 0x80000000 0 0x80000000>;
> +       };
> +
> +       ddr1: memory-controller@1080000 {
> +               compatible = "fsl,qoriq-memory-controller";
> +               reg = <0x0 0x1080000 0x0 0x1000>;
> +               interrupts = <0 17 0x4>;
> +               little-endian;
> +       };
> +
> +       ddr2: memory-controller@1090000 {
> +               compatible = "fsl,qoriq-memory-controller";
> +               reg = <0x0 0x1090000 0x0 0x1000>;
> +               interrupts = <0 18 0x4>;
> +               little-endian;
> +       };
> +
> +       sysclk: sysclk {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <100000000>;
> +               clock-output-names = "sysclk";
> +       };
> +
> +       soc {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               clockgen: clocking@1300000 {
> +                       compatible = "fsl,lx2160a-clockgen";

Also update the binding to include this new compatible.

> +                       reg = <0 0x1300000 0 0xa0000>;
> +                       #clock-cells = <2>;
> +                       clocks = <&sysclk>;
> +               };
> +
> +               crypto: crypto@8000000 {
> +                       compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
> +                       fsl,sec-era = <10>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0x0 0x00 0x8000000 0x100000>;
> +                       reg = <0x00 0x8000000 0x0 0x100000>;
> +                       interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> +                       dma-coherent;
> +                       status = "disabled";
> +
> +                       sec_jr0: jr@10000 {
> +                               compatible = "fsl,sec-v5.0-job-ring",
> +                                            "fsl,sec-v4.0-job-ring";
> +                               reg        = <0x10000 0x10000>;
> +                               interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +                       };
> +
> +                       sec_jr1: jr@20000 {
> +                               compatible = "fsl,sec-v5.0-job-ring",
> +                                            "fsl,sec-v4.0-job-ring";
> +                               reg        = <0x20000 0x10000>;
> +                               interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +                       };
> +
> +                       sec_jr2: jr@30000 {
> +                               compatible = "fsl,sec-v5.0-job-ring",
> +                                            "fsl,sec-v4.0-job-ring";
> +                               reg        = <0x30000 0x10000>;
> +                               interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> +                       };
> +
> +                       sec_jr3: jr@40000 {
> +                               compatible = "fsl,sec-v5.0-job-ring",
> +                                            "fsl,sec-v4.0-job-ring";
> +                               reg        = <0x40000 0x10000>;
> +                               interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +                       };
> +               };
> +
> +               dcfg: dcfg@1e00000 {
> +                       compatible = "fsl,lx2160a-dcfg", "syscon";

Update the binding to include this new compatible.

> +                       reg = <0x0 0x1e00000 0x0 0x10000>;
> +                       little-endian;
> +               };
> +
> +               gpio0: gpio@2300000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2300000 0x0 0x10000>;
> +                       interrupts = <0 36 0x4>; // Level high type
> +                       gpio-controller;
> +                       little-endian;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               gpio1: gpio@2310000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2310000 0x0 0x10000>;
> +                       interrupts = <0 36 0x4>; // Level high type
> +                       gpio-controller;
> +                       little-endian;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               gpio2: gpio@2320000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2320000 0x0 0x10000>;
> +                       interrupts = <0 37 0x4>; // Level high type
> +                       gpio-controller;
> +                       little-endian;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               gpio3: gpio@2330000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2330000 0x0 0x10000>;
> +                       interrupts = <0 37 0x4>; // Level high type
> +                       gpio-controller;
> +                       little-endian;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +

One new line is enough.

> +               i2c0: i2c@2000000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2000000 0x0 0x10000>;
> +                       interrupts = <0 34 0x4>; // Level high type
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       fsl-scl-gpio = <&gpio2 15 0>;
> +                       status = "disabled";
> +               };
> +
> +               i2c1: i2c@2010000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2010000 0x0 0x10000>;
> +                       interrupts = <0 34 0x4>; // Level high type
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               i2c2: i2c@2020000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2020000 0x0 0x10000>;
> +                       interrupts = <0 35 0x4>; // Level high type
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               i2c3: i2c@2030000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2030000 0x0 0x10000>;
> +                       interrupts = <0 35 0x4>; // Level high type
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               i2c4: i2c@2040000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2040000 0x0 0x10000>;
> +                       interrupts = <0 74 0x4>; // Level high type
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       fsl-scl-gpio = <&gpio2 16 0>;
> +                       status = "disabled";
> +               };
> +
> +               i2c5: i2c@2050000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2050000 0x0 0x10000>;
> +                       interrupts = <0 74 0x4>; // Level high type
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               i2c6: i2c@2060000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2060000 0x0 0x10000>;
> +                       interrupts = <0 75 0x4>; // Level high type
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               i2c7: i2c@2070000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2070000 0x0 0x10000>;
> +                       interrupts = <0 75 0x4>; // Level high type
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               uart0: serial@21c0000 {
> +                       device_type = "serial";
> +                       compatible = "arm,pl011","arm,sbsa-uart";

From the sbsa_uart binding:
This UART uses a subset of the PL011 registers and consequently lives
in the PL011 driver. It's baudrate and other communication parameters
cannot be adjusted at runtime, so it lacks a clock specifier here.

So it is a more specific variant of pl011.  Put the sbsa-uart compatible first.

> +                       reg = <0x0 0x21c0000 0x0 0x1000>;
> +                       interrupts = <0 32 0x4>;        // Level high type
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               uart1: serial@21d0000 {
> +                       device_type = "serial";
> +                       compatible = "arm,pl011","arm,sbsa-uart";
> +                       reg = <0x0 0x21d0000 0x0 0x1000>;
> +                       interrupts = <0 33 0x4>;        // Level high type
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               uart2: serial@21e0000 {
> +                       device_type = "serial";
> +                       compatible = "arm,pl011","arm,sbsa-uart";
> +                       reg = <0x0 0x21e0000 0x0 0x1000>;
> +                       interrupts = <0 72 0x4>;        // Level high type
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               uart3: serial@21f0000 {
> +                       device_type = "serial";
> +                       compatible = "arm,pl011","arm,sbsa-uart";
> +                       reg = <0x0 0x21f0000 0x0 0x1000>;
> +                       interrupts = <0 73 0x4>;        // Level high type
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               smmu: iommu@5000000 {
> +                       compatible = "arm,mmu-500";
> +                       reg = <0 0x5000000 0 0x800000>;
> +                       #iommu-cells = <1>;
> +                       #global-interrupts = <14>;
> +                       interrupts = <0 13 4>, // global secure fault
> +                                    <0 14 4>, // combined secure interrupt
> +                                    <0 15 4>, // global non-secure fault
> +                                    <0 16 4>, // combined non-secure interrupt
> +                               // performance counter interrupts 0-9
> +                                    <0 211 4>, <0 212 4>,
> +                                    <0 213 4>, <0 214 4>,
> +                                    <0 215 4>, <0 216 4>,
> +                                    <0 217 4>, <0 218 4>,
> +                                    <0 219 4>, <0 220 4>,
> +                               // per context interrupt, 64 interrupts
> +                                    <0 146 4>, <0 147 4>,
> +                                    <0 148 4>, <0 149 4>,
> +                                    <0 150 4>, <0 151 4>,
> +                                    <0 152 4>, <0 153 4>,
> +                                    <0 154 4>, <0 155 4>,
> +                                    <0 156 4>, <0 157 4>,
> +                                    <0 158 4>, <0 159 4>,
> +                                    <0 160 4>, <0 161 4>,
> +                                    <0 162 4>, <0 163 4>,
> +                                    <0 164 4>, <0 165 4>,
> +                                    <0 166 4>, <0 167 4>,
> +                                    <0 168 4>, <0 169 4>,
> +                                    <0 170 4>, <0 171 4>,
> +                                    <0 172 4>, <0 173 4>,
> +                                    <0 174 4>, <0 175 4>,
> +                                    <0 176 4>, <0 177 4>,
> +                                    <0 178 4>, <0 179 4>,
> +                                    <0 180 4>, <0 181 4>,
> +                                    <0 182 4>, <0 183 4>,
> +                                    <0 184 4>, <0 185 4>,
> +                                    <0 186 4>, <0 187 4>,
> +                                    <0 188 4>, <0 189 4>,
> +                                    <0 190 4>, <0 191 4>,
> +                                    <0 192 4>, <0 193 4>,
> +                                    <0 194 4>, <0 195 4>,
> +                                    <0 196 4>, <0 197 4>,
> +                                    <0 198 4>, <0 199 4>,
> +                                    <0 200 4>, <0 201 4>,
> +                                    <0 202 4>, <0 203 4>,
> +                                    <0 204 4>, <0 205 4>,
> +                                    <0 206 4>, <0 207 4>,
> +                                    <0 208 4>, <0 209 4>;
> +                       dma-coherent;
> +               };
> +
> +               usb0: usb3@3100000 {
> +                       compatible = "snps,dwc3";
> +                       reg = <0x0 0x3100000 0x0 0x10000>;
> +                       interrupts = <0 80 0x4>; // Level high type
> +                       dr_mode = "host";
> +                       snps,quirk-frame-length-adjustment = <0x20>;
> +                       snps,dis_rxdet_inp3_quirk;
> +                       status = "disabled";
> +               };
> +
> +               usb1: usb3@3110000 {
> +                       compatible = "snps,dwc3";
> +                       reg = <0x0 0x3110000 0x0 0x10000>;
> +                       interrupts = <0 81 0x4>; // Level high type
> +                       dr_mode = "host";
> +                       snps,quirk-frame-length-adjustment = <0x20>;
> +                       snps,dis_rxdet_inp3_quirk;
> +                       status = "disabled";
> +               };
> +
> +               watchdog@23a0000 {
> +                       compatible = "arm,sbsa-gwdt";
> +                       reg = <0x0 0x23a0000 0 0x1000>,
> +                             <0x0 0x2390000 0 0x1000>;
> +                       interrupts = <0 59 4>;
> +                       timeout-sec = <30>;
> +               };
> +

No new line is needed here.

> +       };
> +};
> --
> 2.7.4
>
