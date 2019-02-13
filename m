Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0C7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457D222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Mup1evu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391288AbfBMJJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:09:02 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7104 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391162AbfBMJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:09:01 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c63dea90000>; Wed, 13 Feb 2019 01:08:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Feb 2019 01:08:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Feb 2019 01:08:55 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Feb
 2019 09:08:53 +0000
Subject: Re: [PATCH V6 2/7] clocksource: tegra: add Tegra210 timer support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
References: <20190201161654.18315-1-josephl@nvidia.com>
 <20190201161654.18315-3-josephl@nvidia.com>
 <30d2a97c-c08f-f67c-706a-16288cf63dc8@nvidia.com>
 <94a6e53f-8997-4088-fa50-8b889eb81bc1@linaro.org>
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <4e2c44a9-1935-2d1a-152b-04551f43b71f@nvidia.com>
Date:   Wed, 13 Feb 2019 17:08:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <94a6e53f-8997-4088-fa50-8b889eb81bc1@linaro.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550048937; bh=QB+uy7OnSaFsBRz2yxalbBmMtATMU1InMRuVhQkwTRs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Mup1evu60umVex5aOWXQk9/DeYNh3JUcAcUuJoIioU/97nKe8/sEvC3bJgQ3i7B7Q
         3CmRXZluWSuxzQEppxfcdP1vsS35xUo3HRG6ilnbfXLvdO12+6vZ3DftbX+cELwADQ
         K59SJyhbCpGBcKbIyWbDvzo/MEIZrwzx6BxiCyBaGMeHQHvoKZVOYtEa8y4L3xn2et
         7MrofsFQOnyM0o7Ua6hpooM56cl4rVrbNT78o3KekRfUfjqauMdPejwzY040glM0KU
         O93SPmbnC2oVsuLc4c/CG3t5aizIRWEbKhZQlSZPFwr62COdE3GpEYic7wxHD+Plfj
         lo3L7MCy1Q5Vw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 4:55 PM, Daniel Lezcano wrote:
> On 08/02/2019 14:23, Joseph Lo wrote:
>> Hi Daniel & Thomas,
>>
>> Do we have the chance to get this patch merged for K5.1?
>=20
> Hi Jospeh,
>=20
> sorry for the delay, I was overbooked these past two weeks.
>=20
> Overall it looks ok but give me a couple of days to review the driver
> more deeply.

No problem, thanks.

>=20
>=20
>> On 2/2/19 12:16 AM, Joseph Lo wrote:
>>> Add support for the Tegra210 timer that runs at oscillator clock
>>> (TMR10-TMR13). We need these timers to work as clock event device and t=
o
>>> replace the ARMv8 architected timer due to it can't survive across the
>>> power cycle of the CPU core or CPUPORESET signal. So it can't be a
>>> wake-up
>>> source when CPU suspends in power down state.
>>>
>>> Also convert the original driver to use timer-of API.
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>>> ---
>>> v6:
>>>  =C2=A0 * refine the timer defines
>>>  =C2=A0 * add ack tag from Jon.
>>> v5:
>>>  =C2=A0 * add ack tag from Thierry
>>> v4:
>>>  =C2=A0 * merge timer-tegra210.c in previous version into timer-tegra20=
.c
>>> v3:
>>>  =C2=A0 * use timer-of API
>>> v2:
>>>  =C2=A0 * add error clean-up code
>>> ---
>>>  =C2=A0 drivers/clocksource/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>  =C2=A0 drivers/clocksource/timer-tegra20.c | 371 ++++++++++++++++++++-=
-------
>>>  =C2=A0 include/linux/cpuhotplug.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>  =C2=A0 3 files changed, 270 insertions(+), 104 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index a9e26f6a81a1..6af78534a285 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -131,7 +131,7 @@ config SUN5I_HSTIMER
>>>  =C2=A0 config TEGRA_TIMER
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Tegra timer driver" if COMPILE_TE=
ST
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CLKSRC_MMIO
>>> -=C2=A0=C2=A0=C2=A0 depends on ARM
>>> +=C2=A0=C2=A0=C2=A0 select TIMER_OF
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enables support for the Teg=
ra driver.
>>>  =C2=A0 diff --git a/drivers/clocksource/timer-tegra20.c
>>> b/drivers/clocksource/timer-tegra20.c
>>> index 4293943f4e2b..f66edd63d7f4 100644
>>> --- a/drivers/clocksource/timer-tegra20.c
>>> +++ b/drivers/clocksource/timer-tegra20.c
>>> @@ -15,21 +15,24 @@
>>>  =C2=A0=C2=A0 *
>>>  =C2=A0=C2=A0 */
>>>  =C2=A0 -#include <linux/init.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/clockchips.h>
>>> +#include <linux/cpu.h>
>>> +#include <linux/cpumask.h>
>>> +#include <linux/delay.h>
>>>  =C2=A0 #include <linux/err.h>
>>> -#include <linux/time.h>
>>>  =C2=A0 #include <linux/interrupt.h>
>>> -#include <linux/irq.h>
>>> -#include <linux/clockchips.h>
>>> -#include <linux/clocksource.h>
>>> -#include <linux/clk.h>
>>> -#include <linux/io.h>
>>>  =C2=A0 #include <linux/of_address.h>
>>>  =C2=A0 #include <linux/of_irq.h>
>>> -#include <linux/sched_clock.h>
>>> -#include <linux/delay.h>
>>> +#include <linux/percpu.h>
>>> +#include <linux/syscore_ops.h>
>>> +#include <linux/time.h>
>>> +
>>> +#include "timer-of.h"
>>>  =C2=A0 +#ifdef CONFIG_ARM
>>>  =C2=A0 #include <asm/mach/time.h>
>>> +#endif
>>>  =C2=A0 =C2=A0 #define RTC_SECONDS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x08
>>>  =C2=A0 #define RTC_SHADOW_SECONDS=C2=A0=C2=A0=C2=A0=C2=A0 0x0c
>>> @@ -39,74 +42,145 @@
>>>  =C2=A0 #define TIMERUS_USEC_CFG 0x14
>>>  =C2=A0 #define TIMERUS_CNTR_FREEZE 0x4c
>>>  =C2=A0 -#define TIMER1_BASE 0x0
>>> -#define TIMER2_BASE 0x8
>>> -#define TIMER3_BASE 0x50
>>> -#define TIMER4_BASE 0x58
>>> -
>>> -#define TIMER_PTV 0x0
>>> -#define TIMER_PCR 0x4
>>> -
>>> +#define TIMER_PTV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0
>>> +#define TIMER_PTV_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(31)
>>> +#define TIMER_PTV_PER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(30=
)
>>> +#define TIMER_PCR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x4
>>> +#define TIMER_PCR_INTR_CLR=C2=A0=C2=A0=C2=A0 BIT(30)
>>> +
>>> +#ifdef CONFIG_ARM
>>> +#define TIMER_CPU0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x50 /* T=
IMER3 */
>>> +#else
>>> +#define TIMER_CPU0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x90 /* T=
IMER10 */
>>> +#define TIMER10_IRQ_IDX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10
>>> +#define IRQ_IDX_FOR_CPU(cpu)=C2=A0=C2=A0=C2=A0 (TIMER10_IRQ_IDX + cpu)
>>> +#endif
>>> +#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
>>> +
>>> +static u32 usec_config;
>>>  =C2=A0 static void __iomem *timer_reg_base;
>>> +#ifdef CONFIG_ARM
>>>  =C2=A0 static void __iomem *rtc_base;
>>> -
>>>  =C2=A0 static struct timespec64 persistent_ts;
>>>  =C2=A0 static u64 persistent_ms, last_persistent_ms;
>>> -
>>>  =C2=A0 static struct delay_timer tegra_delay_timer;
>>> -
>>> -#define timer_writel(value, reg) \
>>> -=C2=A0=C2=A0=C2=A0 writel_relaxed(value, timer_reg_base + (reg))
>>> -#define timer_readl(reg) \
>>> -=C2=A0=C2=A0=C2=A0 readl_relaxed(timer_reg_base + (reg))
>>> +#endif
>>>  =C2=A0 =C2=A0 static int tegra_timer_set_next_event(unsigned long cycl=
es,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cloc=
k_event_device *evt)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 u32 reg;
>>> +=C2=A0=C2=A0=C2=A0 void __iomem *reg_base =3D timer_of_base(to_timer_o=
f(evt));
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 reg =3D 0x80000000 | ((cycles > 1) ? (cycle=
s-1) : 0);
>>> -=C2=A0=C2=A0=C2=A0 timer_writel(reg, TIMER3_BASE + TIMER_PTV);
>>> +=C2=A0=C2=A0=C2=A0 writel(TIMER_PTV_EN |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((cycles =
> 1) ? (cycles - 1) : 0), /* n+1 scheme */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_base =
+ TIMER_PTV);
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0 }
>>>  =C2=A0 -static inline void timer_shutdown(struct clock_event_device *e=
vt)
>>> +static int tegra_timer_shutdown(struct clock_event_device *evt)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 timer_writel(0, TIMER3_BASE + TIMER_PTV);
>>> +=C2=A0=C2=A0=C2=A0 void __iomem *reg_base =3D timer_of_base(to_timer_o=
f(evt));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 writel(0, reg_base + TIMER_PTV);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0 }
>>>  =C2=A0 -static int tegra_timer_shutdown(struct clock_event_device *evt=
)
>>> +static int tegra_timer_set_periodic(struct clock_event_device *evt)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 timer_shutdown(evt);
>>> +=C2=A0=C2=A0=C2=A0 void __iomem *reg_base =3D timer_of_base(to_timer_o=
f(evt));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 writel(TIMER_PTV_EN | TIMER_PTV_PER |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((timer_o=
f_rate(to_timer_of(evt)) / HZ) - 1),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_base =
+ TIMER_PTV);
>>> +
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0 }
>>>  =C2=A0 -static int tegra_timer_set_periodic(struct clock_event_device =
*evt)
>>> +static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 u32 reg =3D 0xC0000000 | ((1000000 / HZ) - 1);
>>> +=C2=A0=C2=A0=C2=A0 struct clock_event_device *evt =3D (struct clock_ev=
ent_device
>>> *)dev_id;
>>> +=C2=A0=C2=A0=C2=A0 void __iomem *reg_base =3D timer_of_base(to_timer_o=
f(evt));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
>>> +=C2=A0=C2=A0=C2=A0 evt->event_handler(evt);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;
>>> +}
>>> +
>>> +#ifdef CONFIG_ARM64
>>> +static DEFINE_PER_CPU(struct timer_of, tegra_to) =3D {
>>> +=C2=A0=C2=A0=C2=A0 .flags =3D TIMER_OF_CLOCK | TIMER_OF_BASE,
>>> +
>>> +=C2=A0=C2=A0=C2=A0 .clkevt =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "tegra_timer",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rating =3D 460,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features =3D CLOCK_EVT_FEA=
T_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_next_event =3D tegra_t=
imer_set_next_event,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_state_shutdown =3D teg=
ra_timer_shutdown,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_state_periodic =3D teg=
ra_timer_set_periodic,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_state_oneshot =3D tegr=
a_timer_shutdown,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .tick_resume =3D tegra_time=
r_shutdown,
>>> +=C2=A0=C2=A0=C2=A0 },
>>> +};
>>> +
>>> +static int tegra_timer_setup(unsigned int cpu)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct timer_of *to =3D per_cpu_ptr(&tegra_to, cpu)=
;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 irq_force_affinity(to->clkevt.irq, cpumask_of(cpu))=
;
>>> +=C2=A0=C2=A0=C2=A0 enable_irq(to->clkevt.irq);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 clockevents_config_and_register(&to->clkevt, timer_=
of_rate(to),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1, /* min */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1fffffff); /* 29 bits */
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 timer_shutdown(evt);
>>> -=C2=A0=C2=A0=C2=A0 timer_writel(reg, TIMER3_BASE + TIMER_PTV);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0 }
>>>  =C2=A0 -static struct clock_event_device tegra_clockevent =3D {
>>> -=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D "timer0",
>>> -=C2=A0=C2=A0=C2=A0 .rating=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D 300,
>>> -=C2=A0=C2=A0=C2=A0 .features=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D CLOCK_EVT_FEAT_ONESHOT |
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLOCK_EVT_FEAT_PERIODIC |
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLOCK_EVT_FEAT_DYNIRQ,
>>> -=C2=A0=C2=A0=C2=A0 .set_next_event=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D tegra_timer_set_next_event,
>>> -=C2=A0=C2=A0=C2=A0 .set_state_shutdown=C2=A0=C2=A0=C2=A0 =3D tegra_tim=
er_shutdown,
>>> -=C2=A0=C2=A0=C2=A0 .set_state_periodic=C2=A0=C2=A0=C2=A0 =3D tegra_tim=
er_set_periodic,
>>> -=C2=A0=C2=A0=C2=A0 .set_state_oneshot=C2=A0=C2=A0=C2=A0 =3D tegra_time=
r_shutdown,
>>> -=C2=A0=C2=A0=C2=A0 .tick_resume=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D tegra_timer_shutdown,
>>> +static int tegra_timer_stop(unsigned int cpu)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct timer_of *to =3D per_cpu_ptr(&tegra_to, cpu)=
;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 to->clkevt.set_state_shutdown(&to->clkevt);
>>> +=C2=A0=C2=A0=C2=A0 disable_irq_nosync(to->clkevt.irq);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +#else /* CONFIG_ARM */
>>> +static struct timer_of tegra_to =3D {
>>> +=C2=A0=C2=A0=C2=A0 .flags =3D TIMER_OF_CLOCK | TIMER_OF_BASE | TIMER_O=
F_IRQ,
>>> +
>>> +=C2=A0=C2=A0=C2=A0 .clkevt =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "tegra_timer",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rating=C2=A0=C2=A0=C2=A0 =
=3D 300,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features =3D CLOCK_EVT_FEA=
T_ONESHOT |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 CLOCK_EVT_FEAT_PERIODIC |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 CLOCK_EVT_FEAT_DYNIRQ,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_next_event=C2=A0=C2=A0=
=C2=A0 =3D tegra_timer_set_next_event,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_state_shutdown =3D teg=
ra_timer_shutdown,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_state_periodic =3D teg=
ra_timer_set_periodic,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_state_oneshot =3D tegr=
a_timer_shutdown,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .tick_resume =3D tegra_time=
r_shutdown,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cpumask =3D cpu_possible_m=
ask,
>>> +=C2=A0=C2=A0=C2=A0 },
>>> +
>>> +=C2=A0=C2=A0=C2=A0 .of_irq =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .index =3D 2,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .flags =3D IRQF_TIMER | IRQ=
F_TRIGGER_HIGH,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .handler =3D tegra_timer_is=
r,
>>> +=C2=A0=C2=A0=C2=A0 },
>>>  =C2=A0 };
>>>  =C2=A0 =C2=A0 static u64 notrace tegra_read_sched_clock(void)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 return timer_readl(TIMERUS_CNTR_1US);
>>> +=C2=A0=C2=A0=C2=A0 return readl(timer_reg_base + TIMERUS_CNTR_1US);
>>> +}
>>> +
>>> +static unsigned long tegra_delay_timer_read_counter_long(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return readl(timer_reg_base + TIMERUS_CNTR_1US);
>>>  =C2=A0 }
>>>  =C2=A0 =C2=A0 /*
>>> @@ -143,98 +217,188 @@ static void
>>> tegra_read_persistent_clock64(struct timespec64 *ts)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timespec64_add_ns(&persistent_ts, delta=
 * NSEC_PER_MSEC);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ts =3D persistent_ts;
>>>  =C2=A0 }
>>> +#endif
>>>  =C2=A0 -static unsigned long tegra_delay_timer_read_counter_long(void)
>>> +static int tegra_timer_suspend(void)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 return readl(timer_reg_base + TIMERUS_CNTR_1US);
>>> +#ifdef CONFIG_ARM64
>>> +=C2=A0=C2=A0=C2=A0 int cpu;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for_each_possible_cpu(cpu) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct timer_of *to =3D per=
_cpu_ptr(&tegra_to, cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __iomem *reg_base =3D =
timer_of_base(to);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(TIMER_PCR_INTR_CLR, =
reg_base + TIMER_PCR);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +#else
>>> +=C2=A0=C2=A0=C2=A0 void __iomem *reg_base =3D timer_of_base(&tegra_to)=
;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
>>> +#endif
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0 }
>>>  =C2=A0 -static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id=
)
>>> +static void tegra_timer_resume(void)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 struct clock_event_device *evt =3D (struct clock_ev=
ent_device
>>> *)dev_id;
>>> -=C2=A0=C2=A0=C2=A0 timer_writel(1<<30, TIMER3_BASE + TIMER_PCR);
>>> -=C2=A0=C2=A0=C2=A0 evt->event_handler(evt);
>>> -=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;
>>> +=C2=A0=C2=A0=C2=A0 writel(usec_config, timer_reg_base + TIMERUS_USEC_C=
FG);
>>>  =C2=A0 }
>>>  =C2=A0 -static struct irqaction tegra_timer_irq =3D {
>>> -=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 "timer0",
>>> -=C2=A0=C2=A0=C2=A0 .flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D IRQF_TIMER | IRQF_TRIGGER_HIGH,
>>> -=C2=A0=C2=A0=C2=A0 .handler=C2=A0=C2=A0=C2=A0 =3D tegra_timer_interrup=
t,
>>> -=C2=A0=C2=A0=C2=A0 .dev_id=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D &tegra_clockevent,
>>> +static struct syscore_ops tegra_timer_syscore_ops =3D {
>>> +=C2=A0=C2=A0=C2=A0 .suspend =3D tegra_timer_suspend,
>>> +=C2=A0=C2=A0=C2=A0 .resume =3D tegra_timer_resume,
>>>  =C2=A0 };
>>>  =C2=A0 -static int __init tegra20_init_timer(struct device_node *np)
>>> +static int tegra_timer_init(struct device_node *np, struct timer_of *t=
o)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 struct clk *clk;
>>> -=C2=A0=C2=A0=C2=A0 unsigned long rate;
>>> -=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 timer_reg_base =3D of_iomap(np, 0);
>>> -=C2=A0=C2=A0=C2=A0 if (!timer_reg_base) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Can't map timer reg=
isters\n");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENXIO;
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 ret =3D timer_of_init(np, to);
>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 tegra_timer_irq.irq =3D irq_of_parse_and_ma=
p(np, 2);
>>> -=C2=A0=C2=A0=C2=A0 if (tegra_timer_irq.irq <=3D 0) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Failed to map timer=
 IRQ\n");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 timer_reg_base =3D timer_of_base(to);
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 clk =3D of_clk_get(np, 0);
>>> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(clk)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("Unable to get time=
r clock. Assuming 12Mhz input
>>> clock.\n");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rate =3D 12000000;
>>> -=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_prepare_enable(clk);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rate =3D clk_get_rate(clk);
>>> -=C2=A0=C2=A0=C2=A0 }
>>> -
>>> -=C2=A0=C2=A0=C2=A0 switch (rate) {
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Configure microsecond timers to have 1MHz c=
lock
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Config register is 0xqqww, where qq is "div=
idend", ww is
>>> "divisor"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Uses n+1 scheme
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 switch (timer_of_rate(to)) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 12000000:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_writel(0x000b, TIMERU=
S_USEC_CFG);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usec_config =3D 0x000b; /* =
(11+1)/(0+1) */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case 12800000:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usec_config =3D 0x043f; /* =
(63+1)/(4+1) */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 13000000:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_writel(0x000c, TIMERU=
S_USEC_CFG);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usec_config =3D 0x000c; /* =
(12+1)/(0+1) */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case 16800000:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usec_config =3D 0x0453; /* =
(83+1)/(4+1) */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 19200000:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_writel(0x045f, TIMERU=
S_USEC_CFG);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usec_config =3D 0x045f; /* =
(95+1)/(4+1) */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 26000000:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_writel(0x0019, TIMERU=
S_USEC_CFG);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usec_config =3D 0x0019; /* =
(25+1)/(0+1) */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case 38400000:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usec_config =3D 0x04bf; /* =
(191+1)/(4+1) */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case 48000000:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usec_config =3D 0x002f; /* =
(47+1)/(0+1) */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN(1, "Unknown clock rate=
");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 writel(usec_config, timer_of_base(to) + TIMERUS_USE=
C_CFG);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 register_syscore_ops(&tegra_timer_syscore_ops);
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +
>>> +#ifdef CONFIG_ARM64
>>> +static int __init tegra210_timer_init(struct device_node *np)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int cpu, ret =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 struct timer_of *to;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 to =3D this_cpu_ptr(&tegra_to);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_timer_init(np, to);
>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for_each_possible_cpu(cpu) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct timer_of *cpu_to;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to =3D per_cpu_ptr(&teg=
ra_to, cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to->of_base.base =3D ti=
mer_reg_base + TIMER_BASE_FOR_CPU(cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to->of_clk.rate =3D tim=
er_of_rate(to);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to->clkevt.cpumask =3D =
cpumask_of(cpu);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to->clkevt.irq =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq=
_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpu_to->clkevt.irq) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_=
err("%s: can't map IRQ for CPU%d\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_set_status_flags(cpu_to=
->clkevt.irq, IRQ_NOAUTOEN);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D request_irq(cpu_to-=
>clkevt.irq, tegra_timer_isr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TIMER | IRQF_NOBALANCING,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to->clkevt.name, &cpu_to->clkevt);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_=
err("%s: cannot setup irq %d for CPU%d\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 __func__, cpu_to->clkevt.irq, cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out_irq;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 tegra_timer_stop);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +
>>> +out_irq:
>>> +=C2=A0=C2=A0=C2=A0 for_each_possible_cpu(cpu) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct timer_of *cpu_to;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to =3D per_cpu_ptr(&teg=
ra_to, cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu_to->clkevt.irq) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fre=
e_irq(cpu_to->clkevt.irq, &cpu_to->clkevt);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq=
_dispose_mapping(cpu_to->clkevt.irq);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0 timer_of_cleanup(to);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer",
>>> tegra210_timer_init);
>>> +#else /* CONFIG_ARM */
>>> +static int __init tegra20_init_timer(struct device_node *np)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_timer_init(np, &tegra_to);
>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 sched_clock_register(tegra_read_sched_clock=
, 32, 1000000);
>>> +=C2=A0=C2=A0=C2=A0 tegra_to.of_base.base =3D timer_reg_base + TIMER_BA=
SE_FOR_CPU(0);
>>> +=C2=A0=C2=A0=C2=A0 tegra_to.of_clk.rate =3D 1000000; /* microsecond ti=
mer */
>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 sched_clock_register(tegra_read_sched_clock=
, 32,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_of_rate(&tegra_to));
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clocksource_mmio_init(timer_reg=
_base + TIMERUS_CNTR_1US,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "timer_us", 1000000, 300, 32,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocksource_mmio_readl_up);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "timer_us", timer_of_rate(&te=
gra_to),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 300, 32, clocksource_mmio_rea=
dl_up);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Failed =
to register clocksource\n");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_delay_timer.read_current_t=
imer =3D
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 tegra_delay_timer_read_counter_long;
>>> -=C2=A0=C2=A0=C2=A0 tegra_delay_timer.freq =3D 1000000;
>>> +=C2=A0=C2=A0=C2=A0 tegra_delay_timer.freq =3D timer_of_rate(&tegra_to)=
;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 register_current_timer_delay(&tegra_del=
ay_timer);
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 ret =3D setup_irq(tegra_timer_irq.irq, &teg=
ra_timer_irq);
>>> -=C2=A0=C2=A0=C2=A0 if (ret) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Failed to register =
timer IRQ: %d\n", ret);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 clockevents_config_and_register(&tegra_to.clkevt,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_of_rate(&tegra_to),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1fffffff);
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 tegra_clockevent.cpumask =3D cpu_possible_m=
ask;
>>> -=C2=A0=C2=A0=C2=A0 tegra_clockevent.irq =3D tegra_timer_irq.irq;
>>> -=C2=A0=C2=A0=C2=A0 clockevents_config_and_register(&tegra_clockevent, =
1000000,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1, 0x1fffffff);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0 timer_of_cleanup(&tegra_to);
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 return 0;
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>  =C2=A0 }
>>>  =C2=A0 TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer",
>>> tegra20_init_timer);
>>>  =C2=A0 @@ -261,3 +425,4 @@ static int __init tegra20_init_rtc(struct
>>> device_node *np)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return register_persistent_clock(tegra_=
read_persistent_clock64);
>>>  =C2=A0 }
>>>  =C2=A0 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_ini=
t_rtc);
>>> +#endif
>>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>>> index fd586d0301e7..e78281d07b70 100644
>>> --- a/include/linux/cpuhotplug.h
>>> +++ b/include/linux/cpuhotplug.h
>>> @@ -121,6 +121,7 @@ enum cpuhp_state {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUHP_AP_ARM_TWD_STARTING,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUHP_AP_QCOM_TIMER_STARTING,
>>> +=C2=A0=C2=A0=C2=A0 CPUHP_AP_TEGRA_TIMER_STARTING,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUHP_AP_ARMADA_TIMER_STARTING,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUHP_AP_MARCO_TIMER_STARTING,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUHP_AP_MIPS_GIC_TIMER_STARTING,
>>>
>=20
>=20
