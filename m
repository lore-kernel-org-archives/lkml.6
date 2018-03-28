Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753563AbeC1Ogj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:36:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39815 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeC1Ogi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:36:38 -0400
X-Google-Smtp-Source: AIpwx4+aP89nwISa5Z2OZprgeA+85kYYOv4kxtsI3q4x5PgkQaXjHg9PyZMFLxpvCXs/6GXPyNFq8A==
Subject: Re: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alexander Dahl <ada@thorsis.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
 <9761072.pX2B0LJlSJ@ada> <989df8a3-462a-c645-87f1-9f956e1b22c9@linaro.org>
 <4073350.0MmxRoANOi@ada> <6d43177a-bbea-6a01-5fa5-1c7891e18412@linaro.org>
 <20180328141645.GF13942@piout.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <75e5917b-a9ba-c67e-e964-3f002681f9bb@linaro.org>
Date: Wed, 28 Mar 2018 16:36:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328141645.GF13942@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2018 16:16, Alexandre Belloni wrote:
> On 28/03/2018 at 15:03:11 +0200, Daniel Lezcano wrote:
>> On 28/03/2018 12:29, Alexander Dahl wrote:
>>> Hello Daniel,
>>>
>>> Am Dienstag, 27. März 2018, 13:30:22 CEST schrieb Daniel Lezcano:
>>>> Can you can give a rough amount for the irq rate on the timer ?
>>>
>>> I used itop [1] now to get a rough estimate. First with kernel v4.14.29-rt25 
>>> (fully preempt RT):
>>>
>>> INT                NAME          RATE             MAX
>>>  19 [ vel     tc_clkevt]   397 Ints/s     (max:   432)
>>>  26 [      vel     eth0]     4 Ints/s     (max:    38)
>>>
>>> Next test with kernel v4.15.13 gives (slightly slower, but non-RT):
>>>
>>> INT                NAME          RATE             MAX
>>>  19 [ vel     tc_clkevt]   248 Ints/s     (max:   273)
>>>  26 [      vel     eth0]     4 Ints/s     (max:    11)
>>>
>>> With kernel v4.16-rc7 plus this patch series and tcb as clocksource:
>>>
>>> INT                NAME          RATE             MAX
>>>  17 [vel     timer@fffa]  2164 Ints/s     (max:  2183)
>>>  26 [      vel     eth0]     5 Ints/s     (max:    10)
>>>
>>> Is this the information you wanted? If not, could you point me on how to get 
>>> the requested irq rate?
>>
>> It is perfect. Thanks!
>>
>> It confirms what I was worried about: the clocksource wraps up too
>> quickly thus raising an interrupt every 400us. That is why I asked
>> Alexande about a prescalar register.
>>
> 
> The code should behave exactly the same between the previous and the new
> driver. The interrupt is not coming from the clocksource but from the
> clockevent and it is already on the slowest clock, the 32kHz one.

Do you have an explanation of why the rate is much higher ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
