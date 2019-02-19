Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C16C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D66C21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQOXdal+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfBSJdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:33:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54566 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:33:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so1778524wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 01:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mQxIo1ZMyjW0GP38yhE3IEsI0SGeFAkz1y9D+vI6hL8=;
        b=cQOXdal+gTPLY+nk9MW6ArpleXVYPe7y5KZA5QGsKOiPUj1jMo05IvxLNBN53Xd7HW
         3gBjGD5EMoqw7fggNpZOkgOxxiipAQr2SdbDJ9u9E8Jlgqq3C+fNJfaARhqThyFF7fqm
         oPzSlW5APz1Q3pBFIBn8eV7a+b2AGfmJeqtyAet2bUpovWg0iBLlQkF/nptyPk9rP/Zo
         fuPbzrUUnGotXuYrq/lvx+bWygA+IfdSV7Wv/XyGaIEbr9On8WrpFFPmkgNNUwIJiyXm
         X7AgLCsB8eykT40OgurrwzE8rwdlZbJP3QoM7frr5PqGp3KOmEu1GI/uMKYmnoIWbVV6
         H75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQxIo1ZMyjW0GP38yhE3IEsI0SGeFAkz1y9D+vI6hL8=;
        b=hgdJPH//geeZepJK/WfRNmZiznI1kcM4SFcmJMaeTfc4OhCDYuHRpD0+2UXyKqw791
         Tg4jYwVAaLF7u62iaI7jKMkChQUs0WSHru1q2D0lFU+I4835gDCBc4IGv0M1nDKw7VQW
         +Bw44V2Y9PChsuO4xjkYbCc995ANPNqEPrlB8ZKQKGWuvS1zTb7agO052zpxz0RADIQd
         wqm0vGuoP0Lg0M8p48ya5rCe9VMQpnvUaAhhyqQ7i/hHmHD9UaXBp7FsTHy/dT+Ckwu1
         f5yfA+OKyKDvg1PrK4GiB+zkEU5p2r5Ik2oskhltc2+EilrYJBoz20d8QjLXINpKrPVF
         dBRA==
X-Gm-Message-State: AHQUAuYLrY4ZXtLhHu8sOJXd90/0/llMh4nG+25NK955rE5XN046nAEv
        OQmdasFEvBoFthB9PLUCeNfXhQ==
X-Google-Smtp-Source: AHgI3IadpDilMyX4X68EM/JSp5nV/VI8q19THA2qajSiUsSq8Yi5TagNKfYFhzyqJK5LoxChW6xjRg==
X-Received: by 2002:a1c:80d6:: with SMTP id b205mr2217949wmd.109.1550568785168;
        Tue, 19 Feb 2019 01:33:05 -0800 (PST)
Received: from [192.168.0.41] (175.247.136.77.rev.sfr.net. [77.136.247.175])
        by smtp.googlemail.com with ESMTPSA id c65sm2375871wma.24.2019.02.19.01.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 01:33:04 -0800 (PST)
Subject: Re: [PATCH V6 2/7] clocksource: tegra: add Tegra210 timer support
To:     Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
References: <20190201161654.18315-1-josephl@nvidia.com>
 <20190201161654.18315-3-josephl@nvidia.com>
 <3849a41f-ab36-d7e0-b2ce-1aa5c4e34aec@linaro.org>
 <87731d61-10f6-0842-a90f-0c78ffba9ef7@nvidia.com>
 <d2aff40c-5ec5-ad66-0d69-a76cdd6c0e9c@linaro.org>
 <a9b6e870-258d-492f-1f1d-5d6ceea24795@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0690a2a2-06e6-62ee-0a5d-dda008fb7fef@linaro.org>
Date:   Tue, 19 Feb 2019 10:33:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a9b6e870-258d-492f-1f1d-5d6ceea24795@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2019 10:00, Joseph Lo wrote:
> On 2/18/19 5:39 PM, Daniel Lezcano wrote:
>> On 18/02/2019 10:01, Joseph Lo wrote:
>>> On 2/15/19 11:14 PM, Daniel Lezcano wrote:
>>>> On 01/02/2019 17:16, Joseph Lo wrote:
>>>>> Add support for the Tegra210 timer that runs at oscillator clock
>>>>> (TMR10-TMR13). We need these timers to work as clock event device
>>>>> and to
>>>>> replace the ARMv8 architected timer due to it can't survive across the
>>>>> power cycle of the CPU core or CPUPORESET signal. So it can't be a
>>>>> wake-up
>>>>> source when CPU suspends in power down state.
>>>>>
>>>>> Also convert the original driver to use timer-of API.
>>>>>
>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>>>>> ---
>>>>> v6:
>>>>>    * refine the timer defines
>>>>>    * add ack tag from Jon.
>>>>> v5:
>>>>>    * add ack tag from Thierry
>>>>> v4:
>>>>>    * merge timer-tegra210.c in previous version into timer-tegra20.c
>>>>> v3:
>>>>>    * use timer-of API
>>>>> v2:
>>>>>    * add error clean-up code
>>>>> ---
> [snip]
>>>>> +    for_each_possible_cpu(cpu) {
>>>>> +        struct timer_of *cpu_to;
>>>>> +
>>>>> +        cpu_to = per_cpu_ptr(&tegra_to, cpu);
>>>>> +        cpu_to->of_base.base = timer_reg_base +
>>>>> TIMER_BASE_FOR_CPU(cpu);
>>>>> +        cpu_to->of_clk.rate = timer_of_rate(to);
>>>>> +        cpu_to->clkevt.cpumask = cpumask_of(cpu);
>>>>> +
>>>>> +        cpu_to->clkevt.irq =
>>>>> +            irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
>>>>> +        if (!cpu_to->clkevt.irq) {
>>>>> +            pr_err("%s: can't map IRQ for CPU%d\n",
>>>>> +                   __func__, cpu);
>>>>> +            ret = -EINVAL;
>>>>> +            goto out;
>>>>> +        }
>>>>> +
>>>>> +        irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
>>>>> +        ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr,
>>>>> +                  IRQF_TIMER | IRQF_NOBALANCING,
>>>>> +                  cpu_to->clkevt.name, &cpu_to->clkevt);
>>>>> +        if (ret) {
>>>>> +            pr_err("%s: cannot setup irq %d for CPU%d\n",
>>>>> +                __func__, cpu_to->clkevt.irq, cpu);
>>>>> +            ret = -EINVAL;
>>>>> +            goto out_irq;
>>>>> +        }
>>>>> +    }
>>>>
>>>> You should configure the timer in the tegra_timer_setup() function
>>>> instead of using this cpu loop.
>>>>
>>>
>>> I think I still need to leave 'irq_of_parse_and_map' and 'request_irq'
>>> here. Is that ok?
>>
>> Perhaps you can store the np pointer in the private data structure of
>> timer-of and let the timer_of API to retrieve the irq in the cpuhp
>> callbacks.
>>
>> irq_of_parse_and_map will be called by timer-of.
>>
>> I'm not sure irq_set_status_flags really operates on the irq because it
>> is called after request_irq.
>>
> 
> I did some experiments today. The 'irq_of_parse_and_map', 'request_irq'
> and 'setup_irq' are not able to run in the atomic section that
> tegra_timer_setup would be triggered in.

Oh ... right

> So I think I still need to leave the IRQ configuration code here in the
> loop. Should I move others to 'tegra_timer_setup' or just keep as the
> same in this patch?

For the moment, I suggest you keep it as it was initially.

A side note, not related to this comment but about the DYNIRQ flag.
Actually it is not needed because the timers are per-cpu.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

