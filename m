Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBIPyn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:54:43 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36023 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeBIPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:54:42 -0500
X-Google-Smtp-Source: AH8x225UURbInJbwKGBmdQvIqekJi4USOqdg4wm3V/KTMQf9FojrM7rioLSc+SReNJQSHzBqF55JbA==
Date: Fri, 09 Feb 2018 07:54:35 -0800
In-Reply-To: <ba5fb474-4e45-8d8d-ee5d-9f1a211090e3@arm.com>
References: <20180209021031.20631-1-jaedon.shin@gmail.com> <ba5fb474-4e45-8d8d-ee5d-9f1a211090e3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] irqchip: Use %px to print pointer value
To: Marc Zyngier <marc.zyngier@arm.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC: Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <45424653-235D-4C4B-8908-417943F5283C@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w19FslS5030593

On February 9, 2018 12:51:33 AM PST, Marc Zyngier <marc.zyngier@arm.com> wrote:
>On 09/02/18 02:10, Jaedon Shin wrote:
>> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
>> pointers printed with %p are hashed. Use %px instead of %p to print
>> pointer value.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>>  drivers/irqchip/irq-bcm7038-l1.c | 2 +-
>>  drivers/irqchip/irq-bcm7120-l2.c | 2 +-
>>  drivers/irqchip/irq-brcmstb-l2.c | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-bcm7038-l1.c
>b/drivers/irqchip/irq-bcm7038-l1.c
>> index 55cfb986225b..f604c1d89b3b 100644
>> --- a/drivers/irqchip/irq-bcm7038-l1.c
>> +++ b/drivers/irqchip/irq-bcm7038-l1.c
>> @@ -339,7 +339,7 @@ int __init bcm7038_l1_of_init(struct device_node
>*dn,
>>  		goto out_unmap;
>>  	}
>>  
>> -	pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
>> +	pr_info("registered BCM7038 L1 intc (mem: 0x%px, IRQs: %d)\n",
>>  		intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
>>  
>>  	return 0;
>> diff --git a/drivers/irqchip/irq-bcm7120-l2.c
>b/drivers/irqchip/irq-bcm7120-l2.c
>> index 983640eba418..1cc4dd1d584a 100644
>> --- a/drivers/irqchip/irq-bcm7120-l2.c
>> +++ b/drivers/irqchip/irq-bcm7120-l2.c
>> @@ -318,7 +318,7 @@ static int __init bcm7120_l2_intc_probe(struct
>device_node *dn,
>>  		}
>>  	}
>>  
>> -	pr_info("registered %s intc (mem: 0x%p, parent IRQ(s): %d)\n",
>> +	pr_info("registered %s intc (mem: 0x%px, parent IRQ(s): %d)\n",
>>  			intc_name, data->map_base[0], data->num_parent_irqs);
>>  
>>  	return 0;
>> diff --git a/drivers/irqchip/irq-brcmstb-l2.c
>b/drivers/irqchip/irq-brcmstb-l2.c
>> index 691d20eb0bec..6760edeeb666 100644
>> --- a/drivers/irqchip/irq-brcmstb-l2.c
>> +++ b/drivers/irqchip/irq-brcmstb-l2.c
>> @@ -262,7 +262,7 @@ static int __init brcmstb_l2_intc_of_init(struct
>device_node *np,
>>  		ct->chip.irq_set_wake = irq_gc_set_wake;
>>  	}
>>  
>> -	pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
>> +	pr_info("registered L2 intc (mem: 0x%px, parent irq: %d)\n",
>>  			base, parent_irq);
>>  
>>  	return 0;
>> 
>
>Why is that something useful to do? This just tells you where the
>device
>is mapped in the VA space, and I doubt that's a useful information,
>hashed pointers or not. Am I missing something obvious?

No you are right there is not much value in printing the register virtual address (sometimes there is e.g: on MIPS) either we fix the prints to show the physical address of the base register or we could possibly drop the prints entirely.

-- 
Florian
