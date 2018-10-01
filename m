Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD0EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3AA2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3AA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeJAO41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:56:27 -0400
Received: from foss.arm.com ([217.140.101.70]:44870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeJAO40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:56:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FCCD7A9;
        Mon,  1 Oct 2018 01:19:54 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185E03F5B3;
        Mon,  1 Oct 2018 01:19:51 -0700 (PDT)
Subject: Re: [RFC 5/5] MIPS: Add Realtek RTL8186 SoC support
To:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180930141510.2690-1-yasha.che3@gmail.com>
 <20180930141510.2690-6-yasha.che3@gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <a7bba9bd-dab3-4f92-465f-e05beee2b9e3@arm.com>
Date:   Mon, 1 Oct 2018 09:19:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180930141510.2690-6-yasha.che3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yasha,

On 30/09/18 15:15, Yasha Cherikovsky wrote:
> The Realtek RTL8186 SoC is a MIPS based SoC
> used in some home routers [1][2].
> 
> The hardware includes Lexra LX5280 CPU with a TLB,
> two Ethernet controllers, a WLAN controller and more.
> 
> With this patch, it is possible to successfully boot
> the kernel and load userspace on the Edimax BR-6204Wg
> router.
> Network drivers support will come in future patches.
> 
> This patch includes:
> - New MIPS rtl8186 platform
>      - Core platform setup code (mostly DT based)
>      - New Kconfig option
>      - defconfig file
>      - MIPS zboot UART support
> - RTL8186 interrupt controller driver
> - RTL8186 timer driver
> - Device tree files for the RTL8186 SoC and Edimax BR-6204Wg
>    router
> 
> [1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
> [2] https://wikidevi.com/wiki/Realtek_RTL8186
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/mips/Kbuild.platforms                    |   1 +
>   arch/mips/Kconfig                             |  17 ++
>   arch/mips/boot/compressed/uart-16550.c        |   5 +
>   arch/mips/boot/dts/Makefile                   |   1 +
>   arch/mips/boot/dts/realtek/Makefile           |   4 +
>   arch/mips/boot/dts/realtek/rtl8186.dtsi       |  86 +++++++
>   .../dts/realtek/rtl8186_edimax_br_6204wg.dts  |  45 ++++
>   arch/mips/configs/rtl8186_defconfig           | 112 +++++++++
>   arch/mips/include/asm/mach-rtl8186/rtl8186.h  |  37 +++
>   arch/mips/rtl8186/Makefile                    |   2 +
>   arch/mips/rtl8186/Platform                    |   7 +
>   arch/mips/rtl8186/irq.c                       |   8 +
>   arch/mips/rtl8186/prom.c                      |  15 ++
>   arch/mips/rtl8186/setup.c                     |  80 +++++++
>   arch/mips/rtl8186/time.c                      |  10 +
>   drivers/clocksource/Kconfig                   |   9 +
>   drivers/clocksource/Makefile                  |   1 +
>   drivers/clocksource/timer-rtl8186.c           | 220 ++++++++++++++++++
>   drivers/irqchip/Kconfig                       |   5 +
>   drivers/irqchip/Makefile                      |   1 +
>   drivers/irqchip/irq-rtl8186.c                 | 107 +++++++++

Could you please split this into at least three patches (arch code, 
clocksource, irqchip) to ease the review?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
