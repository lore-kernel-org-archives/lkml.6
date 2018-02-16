Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758044AbeBPOyW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:54:22 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53526 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755589AbeBPOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:54:20 -0500
X-Google-Smtp-Source: AH8x226R1tcBdaHfq4umfpWIIcVLrvzuxsAo7WuETd2dPPGkydt90CtZHf8bZdFUGtQ+gmXfdMT3zA==
Subject: Re: CONFIG_IRQ_TIMINGS?
To: Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
References: <8ae9d59b-7499-87cd-702f-c722b9a77939@infradead.org>
 <alpine.DEB.2.21.1802161515020.1294@nanos.tec.linutronix.de>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fc5ade5c-dc68-a85e-6a1f-db8ece573fac@linaro.org>
Date: Fri, 16 Feb 2018 15:54:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802161515020.1294@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2018 15:16, Thomas Gleixner wrote:
> On Thu, 15 Feb 2018, Randy Dunlap wrote:
> 
>> Hi,
>>
>> Is this a dead kconfig symbol?  I don't see any Kconfig file that
>> sets/enables it.
>>
>> ./kernel/irq/Makefile:4:obj-$(CONFIG_IRQ_TIMINGS) += timings.o
>> ./kernel/irq/internals.h:#ifdef CONFIG_IRQ_TIMINGS
>> ./kernel/irq/internals.h:#endif /* CONFIG_IRQ_TIMINGS */
>> ./include/linux/interrupt.h:#ifdef CONFIG_IRQ_TIMINGS

This feature is not supposed to be selected by the user but by a
subsystem depending on it. This subsystems is not yet ready, this is why
the option is not selectable for now.

The algorithm using these timings appears to be too heavy for the
kernel, it needs some rework.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
