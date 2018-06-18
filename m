Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E37C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4512083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4512083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755364AbeFRUHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:07:39 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:56318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754256AbeFRUHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:07:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4EE7A182CF66E;
        Mon, 18 Jun 2018 20:07:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spoon92_421665bdf380f
X-Filterd-Recvd-Size: 5705
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Jun 2018 20:07:34 +0000 (UTC)
Message-ID: <8268db75d4698a4fba9aa11de7e8f6d6f20a0515.camel@perches.com>
Subject: Re: [PATCH] ARC: dts: Remove leading 0x from node unit addresses
From:   Joe Perches <joe@perches.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Jun 2018 13:07:32 -0700
In-Reply-To: <20180618191645.15247-1-krzk@kernel.org>
References: <20180618191645.15247-1-krzk@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 21:16 +0200, Krzysztof Kozlowski wrote:
> Remove leading 0x from all node unit addresses with a sed command:
> 
>     sed -E -i -e "s/@0x([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" arch/arc/boot/dts/*.dts*
> 
> This fixes DTC warnings like:
> 
>     Warning (unit_address_format): /cpu_card/dw-apb-gpio@0x2000: unit name should not have leading "0x"

Do all of these need fixing?

Aren't there dozens of these in arch/arm and elsewhere too?

$ git grep -i -P "@0x([0-9a-f]+)\s*\{" -- "*.dt*"|cat
arch/arc/boot/dts/abilis_tb10x.dtsi:		spi0: spi@0xFE010000 {
arch/arc/boot/dts/abilis_tb10x.dtsi:		spi1: spi@0xFE011000 {
arch/arc/boot/dts/axc001.dtsi:		dw-apb-gpio@0x2000 {
arch/arc/boot/dts/axc001.dtsi:		debug_uart: dw-apb-uart@0x5000 {
arch/arc/boot/dts/axc001.dtsi:	mb_intc: dw-apb-ictl@0xe0012000 {
arch/arc/boot/dts/axc003.dtsi:		dw-apb-gpio@0x2000 {
arch/arc/boot/dts/axc003.dtsi:		debug_uart: dw-apb-uart@0x5000 {
arch/arc/boot/dts/axc003.dtsi:	mb_intc: dw-apb-ictl@0xe0012000 {
arch/arc/boot/dts/axc003_idu.dtsi:		dw-apb-gpio@0x2000 {
arch/arc/boot/dts/axc003_idu.dtsi:		debug_uart: dw-apb-uart@0x5000 {
arch/arc/boot/dts/axc003_idu.dtsi:	mb_intc: dw-apb-ictl@0xe0012000 {
arch/arc/boot/dts/axs10x_mb.dtsi:		ethernet@0x18000 {
arch/arc/boot/dts/axs10x_mb.dtsi:		ehci@0x40000 {
arch/arc/boot/dts/axs10x_mb.dtsi:		ohci@0x60000 {
arch/arc/boot/dts/axs10x_mb.dtsi:		mmc@0x15000 {
arch/arc/boot/dts/axs10x_mb.dtsi:		uart@0x20000 {
arch/arc/boot/dts/axs10x_mb.dtsi:		uart@0x21000 {
arch/arc/boot/dts/axs10x_mb.dtsi:		uart@0x22000 {
arch/arc/boot/dts/axs10x_mb.dtsi:		i2c@0x1d000 {
arch/arc/boot/dts/axs10x_mb.dtsi:		i2c@0x1f000 {
arch/arc/boot/dts/axs10x_mb.dtsi:			eeprom@0x54{
arch/arc/boot/dts/axs10x_mb.dtsi:			eeprom@0x57{
arch/arc/boot/dts/vdk_axc003.dtsi:		debug_uart: dw-apb-uart@0x5000 {
arch/arc/boot/dts/vdk_axc003.dtsi:	mb_intc: dw-apb-ictl@0xe0012000 {
arch/arc/boot/dts/vdk_axc003_idu.dtsi:		debug_uart: dw-apb-uart@0x5000 {
arch/arc/boot/dts/vdk_axc003_idu.dtsi:	mb_intc: dw-apb-ictl@0xe0012000 {
arch/arc/boot/dts/vdk_axs10x_mb.dtsi:		ethernet@0x18000 {
arch/arc/boot/dts/vdk_axs10x_mb.dtsi:		ehci@0x40000 {
arch/arc/boot/dts/vdk_axs10x_mb.dtsi:		uart@0x20000 {
arch/arc/boot/dts/vdk_axs10x_mb.dtsi:		uart@0x21000 {
arch/arc/boot/dts/vdk_axs10x_mb.dtsi:		uart@0x22000 {
arch/arc/boot/dts/vdk_axs10x_mb.dtsi:		mmc@0x15000 {
arch/arc/boot/dts/vdk_axs10x_mb.dtsi:	uio_ev: uio@0xD0000000 {
arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts:						bootloaderenv@0x100000 {
arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts:						bootloaderenvred@0x140000 {
arch/arm/boot/dts/atlas7.dtsi:			pmipc@0x13240000 {
arch/arm/boot/dts/atlas7.dtsi:			gnssmfw@0x18100000 {
arch/arm/boot/dts/atlas7.dtsi:			gpum@0x13000000 {
arch/arm/boot/dts/atlas7.dtsi:			sdr@0x13010000 {
arch/arm/boot/dts/atlas7.dtsi:			memory-controller@0x10800000 {
arch/arm/boot/dts/atlas7.dtsi:			retain@0x188D0000 {
arch/arm/boot/dts/dm8148-evm.dts:		partition@0x80000 {
arch/arm/boot/dts/dm8148-evm.dts:		partition@0x1c0000 {
arch/arm/boot/dts/dm8148-evm.dts:		partition@0x280000 {
arch/arm/boot/dts/dm8148-evm.dts:		partition@0x780000 {
arch/arm/boot/dts/dm8168-evm.dts:		partition@0x80000 {
arch/arm/boot/dts/dm8168-evm.dts:		partition@0x1c0000 {
arch/arm/boot/dts/dm8168-evm.dts:		partition@0x280000 {
arch/arm/boot/dts/dm8168-evm.dts:		partition@0x780000 {
arch/arm/boot/dts/keystone-k2e-netcp.dtsi:		pdsp0@0x2a10000 {
arch/arm/boot/dts/keystone-k2hk-netcp.dtsi:		pdsp0@0x2a10000 {
arch/arm/boot/dts/keystone-k2l-netcp.dtsi:		pdsp0@0x2a10000 {
arch/arm/boot/dts/socfpga.dtsi:		l3regs@0xff800000 {
arch/arm/boot/dts/spear300.dtsi:		shirq: interrupt-controller@0x50000000 {
arch/arm/boot/dts/spear310.dtsi:		shirq: interrupt-controller@0xb4000000 {
arch/arm/boot/dts/spear320.dtsi:		shirq: interrupt-controller@0xb3000000 {
arch/arm64/boot/dts/exynos/exynos5433.dtsi:		sysmmu_scaler_0: sysmmu@0x15040000 {
arch/arm64/boot/dts/exynos/exynos5433.dtsi:		sysmmu_scaler_1: sysmmu@0x15050000 {
arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi:			partition@0x0 {
arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi:			partition@0x6000000 {
arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi:			partition@0x6800000 {
arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi:			partition@0x7fe0000 {
arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi:			partition@0x0 {
arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi:			partition@0x400000 {
arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi:			partition@0xa00000 {
arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi:			partition@0xfe0000 {
arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi:			partition@0x0 {
arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi:			partition@0x3f0000 {

