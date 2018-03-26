Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeCZOHP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:07:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39449 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeCZOHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:07:13 -0400
Date: Mon, 26 Mar 2018 06:54:56 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/3] drivers/irqchip: update supports_deactivate static
 key to modern api
Message-ID: <20180326135456.a6z6tvbx2kdqbopr@linux-n805>
References: <20180325191056.24598-1-dave@stgolabs.net>
 <20180325191056.24598-3-dave@stgolabs.net>
 <671202a1-4080-0104-abd8-4718c53dd61e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <671202a1-4080-0104-abd8-4718c53dd61e@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018, Marc Zyngier wrote:

>>  static struct gic_chip_data gic_data __read_mostly;
>> -static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
>> +DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>
>When you combine this...
>
>[...]
>
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index ac2e62d613d1..9b7630cee56c 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -121,7 +121,7 @@ static DEFINE_RAW_SPINLOCK(cpu_map_lock);
>>  #define NR_GIC_CPU_IF 8
>>  static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
>>
>> -static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
>> +DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>
>...with that, bad things happen:
>
>drivers/irqchip/irq-gic-v3.o:(.data+0x278): multiple definition of `supports_deactivate_key'
>drivers/irqchip/irq-gic.o:(.data+0x18): first defined here
>Makefile:1032: recipe for target 'vmlinux' failed
>make: *** [vmlinux] Error 1

Hmm both were (cross) compile tested, I'll have a look.

Thanks,
Davidlohr
