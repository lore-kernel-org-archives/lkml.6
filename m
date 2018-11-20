Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059C0C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B9F20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B9F20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeKUKIm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:08:42 -0500
Received: from hermes.aosc.io ([199.195.250.187]:44848 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbeKUKIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:08:42 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 0B298A3063;
        Tue, 20 Nov 2018 23:36:51 +0000 (UTC)
Date:   Wed, 21 Nov 2018 07:36:38 +0800
In-Reply-To: <20181120084245.bnjdaf647e6tdlku@flea>
References: <cover.1542546735.git.mesihkilinc@gmail.com> <8f07fac854eaaea63e199fe0e80cf20004dffbdf.1542546735.git.mesihkilinc@gmail.com> <20181120084245.bnjdaf647e6tdlku@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC PATCH v2 03/14] ARM: sunxi: add Allwinner ARMv5 SoCs
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mesih Kilinc <mesihkilinc@gmail.com>
CC:     devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Julian Calaby <julian.calaby@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-clk@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <464C921F-1AA7-4475-9085-25D03D21AFE2@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年11月20日 GMT+08:00 下午4:42:45, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Sun, Nov 18, 2018 at 05:17:02PM +0300, Mesih Kilinc wrote:
>> Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
>> used for many new F-series products, including F1C100A, F1C100s,
>F1C200s,
>> F1C500, F1C600).
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
>> ---
>>  arch/arm/mach-sunxi/Kconfig    | 14 +++++++++++++-
>>  arch/arm/mach-sunxi/Makefile   |  1 +
>>  arch/arm/mach-sunxi/sunxi_v5.c | 22 ++++++++++++++++++++++
>>  3 files changed, 36 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/mach-sunxi/sunxi_v5.c
>> 
>> diff --git a/arch/arm/mach-sunxi/Kconfig
>b/arch/arm/mach-sunxi/Kconfig
>> index 5db17ec..066644c 100644
>> --- a/arch/arm/mach-sunxi/Kconfig
>> +++ b/arch/arm/mach-sunxi/Kconfig
>> @@ -1,6 +1,6 @@
>>  menuconfig ARCH_SUNXI
>>  	bool "Allwinner SoCs"
>> -	depends on ARCH_MULTI_V7
>> +	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
>>  	select ARCH_HAS_RESET_CONTROLLER
>>  	select CLKSRC_MMIO
>>  	select GENERIC_IRQ_CHIP
>> @@ -64,4 +64,16 @@ config ARCH_SUNXI_MC_SMP
>>  
>>  endif
>>  
>> +if ARCH_MULTI_V5
>> +
>> +config ARCH_SUNXI_V5
>> +	bool
>> +	select SUN4I_TIMER
>
>If SUN4I_TIMER is needed both by the armv5 and armv7 cores, why did we
>need to move it out of ARCH_SUNXI?
>
>> +config MACH_SUNIV
>> +	bool "Allwinner new F-series (suniv) SoCs support"
>
>I would drop the "new" here.

Sorry, but old F-series SoCs are not suniv. They are sunii or sun3i.

>
>> +++ b/arch/arm/mach-sunxi/sunxi_v5.c
>> @@ -0,0 +1,22 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device Tree support for Allwinner F series SoCs
>> + *
>> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>> + * Copyright (C) 2018 Mesih Kilinc <mesihkilinc@gmail.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <asm/mach/arch.h>
>> +
>> +static const char * const suniv_board_dt_compat[] = {
>> +	"allwinner,suniv-f1c100s",
>> +	NULL,
>> +};
>> +
>> +DT_MACHINE_START(SUNXI_DT, "Allwinner suniv Family")
>> +	.dt_compat	= suniv_board_dt_compat,
>> +MACHINE_END
>
>Do we really need a separate file for that?
>
>Maxime
