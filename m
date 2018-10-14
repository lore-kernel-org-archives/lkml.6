Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD88C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F65820835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F65820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeJOAIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 20:08:41 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33912 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbeJOAIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 20:08:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437339|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.D1zG7XD_1539534392;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D1zG7XD_1539534392)
          by smtp.aliyun-inc.com(10.147.41.187);
          Mon, 15 Oct 2018 00:26:32 +0800
Date:   Mon, 15 Oct 2018 00:26:31 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com,
        jhogan@kernel.org, paul.burton@mips.com, peterz@infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V12 0/8] C-SKY(csky) Linux Kernel Driver
Message-ID: <20181014162631.GA13374@guoren-Inspiron-7460>
References: <cover.1539315341.git.ren_guo@c-sky.com>
 <dfe56d38-cfa5-2be1-114e-c6721d6c92a3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe56d38-cfa5-2be1-114e-c6721d6c92a3@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thx for reply and review.

On Sat, Oct 13, 2018 at 10:50:34PM +0200, Daniel Lezcano wrote:
> On 12/10/2018 14:02, Guo Ren wrote:
> > This is about 12th patchset for C-SKY linux drivers and it should pair
> > with 8th kernel patchset.
> 
> Guo,
> 
> I'm willing to take your timer related patches but you have to put a
> proper description.

Ok, I've improved all my comment for the drivers. Here is my modification:

commit 6b465856936cb8f7eda31b20eb59fb5c8a19d468
Author: Guo Ren <ren_guo@c-sky.com>
Date:   Tue Oct 2 16:43:18 2018 +0800

    clocksource: add gx6605s SOC system timer
    
    The driver is for gx6605s SOC system timer and there are two
    same timers in gx6605s. We use one for clkevt and another one for
    clksrc.
    
    The timer is mmio map to access, so we need give mmio address in dts.
    
    The counter at 0x0  offset is clock event.
    The counter at 0x40 offset is clock source.
    
    Changelog:
     - pass checkpatch.pl
     - Add COMIPLE_TEST in Kconfig
     - no cast is needed for "struct clock_event_device *ce = dev"
     - remove: extra space after (u64)
     - Add License and Copyright
     - Use timer-of framework
     - Change name with upstream feedback
     - Use clksource_mmio framework
    
    Signed-off-by: Guo Ren <ren_guo@c-sky.com>
    Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

commit d89522b23ff8f2d5b6f33200db110c758d28ecc1
Author: Guo Ren <ren_guo@c-sky.com>
Date:   Wed Sep 5 14:25:24 2018 +0800

    clocksource: add C-SKY SMP timer
    
    The driver is for C-SKY SMP timer. It only support oneshot event
    and 32bit overflow for clocksource. Per cpu core has one timer and
    all timers share one clock-counter-input the same clocksource.
    
    This use mfcr&mtcr instructions to access the regs.
    
    Changelog:
     - Add COMPILE_TEST
     - Fixup smp boot error, cpuhp_setup_state must after timer_of_init()
     - Add rollback for timer_of_cleanup.
     - Use request_percpu_irq separate from time_of.
     - Remove #define CPUHP_AP_CSKY_TIMER_STARTING.
     - Add CPUHP_AP_CSKY_TIMER_STARTING in cpuhotplug.h.
     - Support csky mp timer alpha version.
     - Just use low-counter with 32bit width as clocksource.
     - Coding convention with upstream feed-back.
    
    Signed-off-by: Guo Ren <ren_guo@c-sky.com>
    Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

===> It's interrupt controller comment, perhaps you won't care. <===

commit 65f4acd1df08c1c5ad1b0e8f46822b114c539f11
Author: Guo Ren <ren_guo@c-sky.com>
Date:   Sun Sep 16 15:57:14 2018 +0800

    irqchip: add C-SKY APB bus interrupt controller
    
    The driver is for C-SKY APB bus interrupt controller. It's a simple
    interrupt controller which use pending reg to detect the irq and use
    enable/disable reg to mask/unmask interrupt sources.
    
    A lot of SOCs based on C-SKY CPU use the interrupt controller as root
    controller.
    
    Changelog:
     - pass checkpatch.pl.
     - use "bool ret" instead of "int ret"
     - add support-pulse-signal in irq-csky-apb-intc.c
     - change name with upstream feed-back
     - add INTC_IFR to clear irq-pending
     - remove CSKY_VECIRQ_LEGENCY
     - change to generic irq chip framework
     - add License and Copyright
     - use irq_domain_add_linear instead of leagcy
    
    Signed-off-by: Guo Ren <ren_guo@c-sky.com>
    Cc: Mark Rutland <mark.rutland@arm.com>

commit ef790431a885d37766200c7968d47370ed8be251
Author: Guo Ren <ren_guo@c-sky.com>
Date:   Sun Sep 16 15:57:14 2018 +0800

    irqchip: add C-SKY SMP interrupt controller
    
    The driver is for C-SKY SMP interrupt controller. It support 16
    soft-irqs, 16 private-irqs, and 992 max external-irqs, a total of
    1024 interrupts.
    
    C-SKY CPU 807/810/860 SMP/non-SMP could use it.
    
    Changelog:
     - Remove set_ipi_irq_mapping.
     - Convert the cpumask to an interrupt-controller specific representation
       in driver's code, and not the SMP code's.
     - pass checkpatch.pl
     - Move IPI_IRQ into the driver
     - Remove irq_set_default_host() and use set_ipi_irq_mapping()
     - Change name with upstream feed-back
     - Change irq map, reserve soft_irq & private_irq space
     - Add License and Copyright
     - Support set_affinity for irq balance in SMP
    
    Signed-off-by: Guo Ren <ren_guo@c-sky.com>
    Cc: Marc Zyngier <marc.zyngier@arm.com>

Best Regards
 Guo Ren
