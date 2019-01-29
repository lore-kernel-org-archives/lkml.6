Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8F7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51B120857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dUHmtBY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfA2JQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:16:57 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19725 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfA2JQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:16:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5019eb0000>; Tue, 29 Jan 2019 01:16:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 01:16:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 29 Jan 2019 01:16:54 -0800
Received: from [10.26.11.53] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:16:51 +0000
Subject: Re: [PATCH V2 2/6] clocksource: tegra: add Tegra210 timer driver
To:     Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190128091815.7040-1-josephl@nvidia.com>
 <20190128091815.7040-3-josephl@nvidia.com> <20190128150908.GB31317@ulmo>
 <3607f32b-c20a-e00f-3dc1-630169342392@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8c0bc716-4461-883d-aa75-0ccba8132be5@nvidia.com>
Date:   Tue, 29 Jan 2019 09:16:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3607f32b-c20a-e00f-3dc1-630169342392@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548753387; bh=G1HWuQKwLpOl945tbIUvx4/kP/d2d/s4Fd41Ag91FFk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dUHmtBY0M6IwJQQGpXEwm5agSefkPr6UZZPVUlRQxcJ8Ivkx24hypr3CTnEax6zpA
         WIaEzMxnCKXhQCYpHa3qAIRi6QvGNDFQBrKMYuEgfQXUz8sqxfkCrZj9uVCAkBp7WA
         bhbUK9KaAEcKV/Rp9swyjU6WBMKWDvPzA+00FeCCLNE44MK7s6LKDbBfRki7Z2TO0W
         4Whb5FUkYqlM9ybtQ/AudFavRWnZTbpq7foljFj9lMq3fhbV/PMYnyOZZeO61VIYOM
         D72xXtneJ1vlshjO/i/ARuLpTB9Xgmsq0HfgOVELYD3i1C8U0xok5jKTKCMoU+5CM3
         U0XlN3t97V6kg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/01/2019 03:35, Joseph Lo wrote:
> On 1/28/19 11:09 PM, Thierry Reding wrote:
>> On Mon, Jan 28, 2019 at 05:18:11PM +0800, Joseph Lo wrote:
>>> Add support for the Tegra210 timer that runs at oscillator clock
>>> (TMR10-TMR13). We need these timers to work as clock event device and t=
o
>>> replace the ARMv8 architected timer due to it can't survive across the
>>> power cycle of the CPU core or CPUPORESET signal. So it can't be a
>>> wake-up
>>> source when CPU suspends in power down state.
>>>
>>> Based on the work of Antti P Miettinen <amiettinen@nvidia.com>
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>> ---
>>> v2:
>>> =A0 * add error clean-up code
>>> ---
>>> =A0 drivers/clocksource/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 3 +
>>> =A0 drivers/clocksource/Makefile=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
>>> =A0 drivers/clocksource/timer-tegra210.c | 268 ++++++++++++++++++++++++=
+++
>>> =A0 include/linux/cpuhotplug.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 =
+
>>> =A0 4 files changed, 273 insertions(+)
>>> =A0 create mode 100644 drivers/clocksource/timer-tegra210.c
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index a9e26f6a81a1..e6e3e64b6320 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -135,6 +135,9 @@ config TEGRA_TIMER
>>> =A0=A0=A0=A0=A0 help
>>> =A0=A0=A0=A0=A0=A0=A0 Enables support for the Tegra driver.
>>> =A0 +config TEGRA210_TIMER
>>> +=A0=A0=A0 def_bool ARCH_TEGRA_210_SOC
>>> +
>>> =A0 config VT8500_TIMER
>>> =A0=A0=A0=A0=A0 bool "VT8500 timer driver" if COMPILE_TEST
>>> =A0=A0=A0=A0=A0 depends on HAS_IOMEM
>>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefil=
e
>>> index cdd210ff89ea..95de59c8a47b 100644
>>> --- a/drivers/clocksource/Makefile
>>> +++ b/drivers/clocksource/Makefile
>>> @@ -36,6 +36,7 @@ obj-$(CONFIG_SUN4I_TIMER)=A0=A0=A0 +=3D timer-sun4i.o
>>> =A0 obj-$(CONFIG_SUN5I_HSTIMER)=A0=A0=A0 +=3D timer-sun5i.o
>>> =A0 obj-$(CONFIG_MESON6_TIMER)=A0=A0=A0 +=3D timer-meson6.o
>>> =A0 obj-$(CONFIG_TEGRA_TIMER)=A0=A0=A0 +=3D timer-tegra20.o
>>> +obj-$(CONFIG_TEGRA210_TIMER)=A0=A0=A0 +=3D timer-tegra210.o
>>> =A0 obj-$(CONFIG_VT8500_TIMER)=A0=A0=A0 +=3D timer-vt8500.o
>>> =A0 obj-$(CONFIG_NSPIRE_TIMER)=A0=A0=A0 +=3D timer-zevio.o
>>> =A0 obj-$(CONFIG_BCM_KONA_TIMER)=A0=A0=A0 +=3D bcm_kona_timer.o
>>> diff --git a/drivers/clocksource/timer-tegra210.c
>>> b/drivers/clocksource/timer-tegra210.c
>>> new file mode 100644
>>> index 000000000000..477b164e540b
>>> --- /dev/null
>>> +++ b/drivers/clocksource/timer-tegra210.c
>>> @@ -0,0 +1,268 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2014-2019, NVIDIA CORPORATION.=A0 All rights reserved=
.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/clockchips.h>
>>> +#include <linux/cpu.h>
>>> +#include <linux/cpumask.h>
>>> +#include <linux/err.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/percpu.h>
>>> +#include <linux/syscore_ops.h>
>>> +
>>> +static u32 tegra210_timer_freq;
>>> +static void __iomem *tegra210_timer_reg_base;
>>> +static u32 usec_config;
>>> +
>>> +#define TIMER_PTV=A0=A0=A0=A0=A0=A0=A0 0x0
>>> +#define TIMER_PTV_EN=A0=A0=A0=A0=A0=A0=A0 BIT(31)
>>> +#define TIMER_PTV_PER=A0=A0=A0=A0=A0=A0=A0 BIT(30)
>>> +#define TIMER_PCR=A0=A0=A0=A0=A0=A0=A0 0x4
>>> +#define TIMER_PCR_INTR_CLR=A0=A0=A0 BIT(30)
>>> +#define TIMERUS_CNTR_1US=A0=A0=A0 0x10
>>> +#define TIMERUS_USEC_CFG=A0=A0=A0 0x14
>>> +
>>> +#define TIMER10_OFFSET=A0=A0=A0=A0=A0=A0=A0 0x90
>>> +#define TIMER10_IRQ_IDX=A0=A0=A0=A0=A0=A0=A0 10
>>> +
>>> +#define TIMER_FOR_CPU(cpu) (TIMER10_OFFSET + (cpu) * 8)
>>> +#define IRQ_IDX_FOR_CPU(cpu)=A0=A0=A0 (TIMER10_IRQ_IDX + cpu)
>>> +
>>> +struct tegra210_clockevent {
>>> +=A0=A0=A0 struct clock_event_device evt;
>>> +=A0=A0=A0 char name[20];
>>> +=A0=A0=A0 void __iomem *reg_base;
>>> +};
>>> +#define to_tegra_cevt(p) (container_of(p, struct
>>> tegra210_clockevent, evt))
>>> +
>>> +static struct tegra210_clockevent __percpu *tegra210_evt;
>>> +
>>> +static int tegra210_timer_set_next_event(unsigned long cycles,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct cl=
ock_event_device *evt)
>>> +{
>>> +=A0=A0=A0 struct tegra210_clockevent *tevt;
>>> +
>>> +=A0=A0=A0 tevt =3D to_tegra_cevt(evt);
>>> +=A0=A0=A0 writel(TIMER_PTV_EN |
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ((cycles > 1) ? (cycles - 1) : 0), /* n=
+1 scheme */
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tevt->reg_base + TIMER_PTV);
>>> +
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +
>>> +static inline void timer_shutdown(struct tegra210_clockevent *tevt)
>>> +{
>>> +=A0=A0=A0 writel(0, tevt->reg_base + TIMER_PTV);
>>> +}
>>> +
>>> +static int tegra210_timer_shutdown(struct clock_event_device *evt)
>>> +{
>>> +=A0=A0=A0 struct tegra210_clockevent *tevt;
>>> +
>>> +=A0=A0=A0 tevt =3D to_tegra_cevt(evt);
>>> +=A0=A0=A0 timer_shutdown(tevt);
>>> +
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +
>>> +static int tegra210_timer_set_periodic(struct clock_event_device *evt)
>>> +{
>>> +=A0=A0=A0 struct tegra210_clockevent *tevt;
>>> +
>>> +=A0=A0=A0 tevt =3D to_tegra_cevt(evt);
>>> +=A0=A0=A0 writel(TIMER_PTV_EN | TIMER_PTV_PER | ((tegra210_timer_freq =
/
>>> HZ) - 1),
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tevt->reg_base + TIMER_PTV);
>>> +
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +
>>> +static irqreturn_t tegra210_timer_isr(int irq, void *dev_id)
>>> +{
>>> +=A0=A0=A0 struct tegra210_clockevent *tevt;
>>> +
>>> +=A0=A0=A0 tevt =3D dev_id;
>>> +=A0=A0=A0 writel(TIMER_PCR_INTR_CLR, tevt->reg_base + TIMER_PCR);
>>> +=A0=A0=A0 tevt->evt.event_handler(&tevt->evt);
>>> +
>>> +=A0=A0=A0 return IRQ_HANDLED;
>>> +}
>>
>> Up to here this is a duplicate of timer-tegra20.c. And a lot of
>> tegra210_timer_init() is the same as tegra20_timer_init() as well. Can't
>> we unify the two drivers instead?
>=20
> I still prefer to remove the timer-tegra20 driver, because it didn't
> been used for Tegra 32 bit chips for quite a long time. So currently it
> just compiles OK, I also doubt the functionality still can achieve the
> same what I want to do for Tegra210.
>=20
> My personal opinion is to remove the old and unused driver and enhance
> the new one.

Although it may not be used it is still a valid clocksource and could be
used. Our preference is to keeping the existing timer driver and enhance
to support T210 (unless there is some fundamental issue that would
prevent this that I am overlooking).

Cheers
Jon

--=20
nvpublic
