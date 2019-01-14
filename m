Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B1CC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AB72086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kaAtUj/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfANMUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:20:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57772 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:20:47 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ECKM4e022252;
        Mon, 14 Jan 2019 06:20:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547468422;
        bh=GzkmGAiWWkPJQ7bMtad2a06xNmlSZxETzpgQ/xgJNu0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kaAtUj/lGHgCNyz+EiqdEcSwGvE1w7Fc0tfwiorBUFwtcmZLQ9YL4VB7sUE/6ozX0
         KdFnaOBfGHsU8tRPBSdF2afglCIH86vkwB6RzQ2y6Nru7UyGjYrwjXklmCvbsv+3n5
         CK62SSy3keRZQ0gdh7N2MxdH+JT2AFxB6rcv/b0M=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ECKMFV082326
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 06:20:22 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 06:20:21 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 06:20:21 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ECKIij009512;
        Mon, 14 Jan 2019 06:20:19 -0600
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-3-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <08200de1-fde5-c525-c874-c7872259067b@ti.com>
Date:   Mon, 14 Jan 2019 17:50:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111172134.30147-3-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently the clocksource and clockevent support for davinci platforms
> lives in mach-davinci. It hard-codes many things, used global variables,
> implements functionalities unused by any platform and has code fragments
> scattered across many (often unrelated) files.
> 
> Implement a new, modern and simplified timer driver and put it into
> drivers/clocksource. We still need to support legacy board files so
> export a config structure and a function that allows machine code to
> register the timer.
> 
> We don't check the return values of regmap reads and writes since with
> mmio it's only likely to fail due to programmer's errors.
> 
> We also don't bother freeing resources on errors in
> davinci_timer_register() as the system won't boot without a timer anyway.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

With this series, DA830 fails to boot. Rest of the devices are okay from
boot perspective.

DA830 is pretty unique because it uses the same timer-half for both
clocksource and clockevent. May be you can set the same configuration on
your DA850 to see the same issue? Else, I will enable low-level debug
and try to provide more debug data.

Some minor comments below from quick look:

> diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
> new file mode 100644
> index 000000000000..7282a1fda80f
> --- /dev/null
> +++ b/drivers/clocksource/timer-davinci.c
> @@ -0,0 +1,415 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * TI DaVinci clocksource driver
> + *
> + * Copyright (C) 2019 Texas Instruments
> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> + * (with some parts adopted from code by Kevin Hilman <khilman@baylibre.com>)

Did you really intend GPL v2 or later? The original code referred to
above is marked 2.0 only.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/regmap.h>
> +#include <linux/sched_clock.h>
> +
> +#include <clocksource/timer-davinci.h>
> +
> +#define DAVINCI_TIMER_REG_TIM12			0x10
> +#define DAVINCI_TIMER_REG_TIM34			0x14
> +#define DAVINCI_TIMER_REG_PRD12			0x18
> +#define DAVINCI_TIMER_REG_PRD34			0x1c
> +#define DAVINCI_TIMER_REG_TCR			0x20
> +#define DAVINCI_TIMER_REG_TGCR			0x24
> +
> +#define DAVINCI_TIMER_TIMMODE_MASK		0x0000000c
> +#define DAVINCI_TIMER_RESET_MASK		0x00000003
> +#define DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED	0x00000004
> +#define DAVINCI_TIMER_UNRESET			0x00000003

I think these are more readable if using BIT() and GENMASK()

Thanks,
Sekhar
