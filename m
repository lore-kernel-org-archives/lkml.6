Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeC2MHj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:07:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37858 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbeC2MHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:07:37 -0400
X-Google-Smtp-Source: AIpwx48RYosQovJRkSQyBwiFpQtG5AYUzonNgnQ+eTNHrzeblV9eg35PMsYpP6a0/BiQX93SXud9Ig==
Subject: Re: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexander Dahl <ada@thorsis.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
 <3478710.yJBBt3uoRT@ada> <20180329104542.GK13942@piout.net>
 <3103570.fW0XyqvKVi@ada> <20180329114255.GL13942@piout.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e3235587-8362-e1fc-a813-39f790a1c8b4@linaro.org>
Date: Thu, 29 Mar 2018 14:07:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329114255.GL13942@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2018 13:42, Alexandre Belloni wrote:
> On 29/03/2018 at 13:31:18 +0200, Alexander Dahl wrote:
>> Pretty sure. I rebuilt the whole BSP and added another line to the kernel 
>> source to see if the tree I applied the patches to, was actually built:
>>
>>
>> diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
>> index 7fde9cfbf203..f85affc74a86 100644
>> --- a/drivers/clocksource/timer-atmel-tcb.c
>> +++ b/drivers/clocksource/timer-atmel-tcb.c
>> @@ -222,7 +222,8 @@ static int __init tc_clkevt_register(struct device_node *node,
>>                 goto err_slow;
>>         clk_disable(tce.clk);
>>  
>> -       clockevents_config_and_register(&tce.clkevt, 32768, 1, bits - 1);
>> +       pr_info( "*** bits: 0x%x, BIT(bits): 0x%lx\n", bits, BIT(bits) );
>> +       clockevents_config_and_register(&tce.clkevt, 32768, 1, BIT(bits) - 1);
>>  
>>         ret = request_irq(tce.irq, tc_clkevt2_irq, IRQF_TIMER | IRQF_SHARED,
>>                           tce.clkevt.name, &tce);
>>
>>
> 
> I've just tested on a g20, old driver:
> INT                NAME          RATE             MAX
>  16 [vel     at91_tick,]   175 Ints/s     (max:   231)
>  19 [ vel     tc_clkevt]   129 Ints/s     (max:   129)
> 
> 
> new driver:
> INT                NAME          RATE             MAX
>  17 [vel     timer@fffa]   129 Ints/s     (max:   129)
>  18 [     vel     ttyS0]   175 Ints/s     (max:   231)

Can you give in both platforms how fast the clocksource wraps up ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
