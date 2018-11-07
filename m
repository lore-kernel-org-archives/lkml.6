Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520A620818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjbHuOZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520A620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeKHGRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:17:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44851 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeKHGRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:17:37 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so2496307lfe.11;
        Wed, 07 Nov 2018 12:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o+OFHaukpQ4TOypFplNf8fU9NsL+rRWAbnuGecC3CfQ=;
        b=CjbHuOZwqC0QbQvkbDPKoE71O6rMEQJ3u1vzTgTzmeqP1AxW7c2fy0PV9tIAyh8apE
         NF3mS9DqWdQmU2yShyJwNCAjv++7DA9i4VQAwBFZ0M/8+uGYgOV3FvYuKrRrd9W0BKFC
         9RoTkA5XRn/8hW56PrCbUYpycKy3sstl6P9AY0hOH6TAzjuAIgIbXiS+pMGnrNXQwesC
         oYirQVXDtQv2XA+VOWh/LrZL8xHn0s6Zu26XDvspYxKmDDBnDOdtwG2pmzE94+gdLF3N
         S0wX0KCLWwr8FdyxIKNfAlwu9kNgidVMz/44cCcdxt+F9BO0GlflzJGJBnjSuRzCjikr
         BuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o+OFHaukpQ4TOypFplNf8fU9NsL+rRWAbnuGecC3CfQ=;
        b=ZF8T8BLN1Lj1sJgXrpDxXgpwiKE6F4pW9J1dn+6NFAab75W0jDgiEoqSlKSQK/C4EU
         Q9y3FdV2dzEyFNg6AfqYkcSPDeQY72WsW3kwKksm7pUNMsU47ZcWShAOJOibPmJxQaf+
         2I2LrYvGg4j4kvf89DdMz8bTnbTbtUK7t0fn3dQy7P3K1pGAX1dP88CrNG9Zu8ZD0YEP
         ATZJUHlI3eXQMdd836dLtYk7PHZ664iFhnaVieSJ47Q/sopLSCjWmwnAvsdwQpiSxnE7
         q9xf3V274gZdXCw/KlCnrBxPxnG2whuspiP6C04IcVoeQ8fPMcjl9gQJ3NtdxXkjv9XH
         Ilkw==
X-Gm-Message-State: AGRZ1gJm01IOV1z9zgfPJtKNEM76IupCIGDD4o9tTupSyidwjQ2eFOv/
        FgdOfikZzvQXEXJU2JgThIR0d0Bd114HfQ==
X-Google-Smtp-Source: AJdET5dMql5n3ZlMQqSoP5d4wBt7WFqqPPym5ApHZsOXz12TFdvWzp3iqzfyvkwzVhyIfubAFXTLcQ==
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr1014087lfd.90.1541623530172;
        Wed, 07 Nov 2018 12:45:30 -0800 (PST)
Received: from [192.168.1.18] (dnl153.neoplus.adsl.tpnet.pl. [83.24.93.153])
        by smtp.gmail.com with ESMTPSA id d15-v6sm290369lja.38.2018.11.07.12.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:45:29 -0800 (PST)
Subject: Re: [PATCH] leds: trigger: Fix sleeping function called from invalid
 context
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Mark Brown <broonie@kernel.org>, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5f1cfb9c87f591b12efa2e7a0063f15532649634.1541563908.git.baolin.wang@linaro.org>
 <CAMuHMdVUnH7ubtLOHAt1uLFOqqeAy60LvoWaWLiJx0gf8PWhSg@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <3233e3af-bd33-e719-7252-59d92a8da2b1@gmail.com>
Date:   Wed, 7 Nov 2018 21:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVUnH7ubtLOHAt1uLFOqqeAy60LvoWaWLiJx0gf8PWhSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin and Geert,

Geert - thanks for the heads-up.

Baolin - thanks for the quick fix.

Applied to the fixes-for-4.20-rc2 branch of linux-leds.git

Best regards,
Jacek Anaszewski

On 11/07/2018 08:59 AM, Geert Uytterhoeven wrote:
> Hi Baolin,
> 
> On Wed, Nov 7, 2018 at 6:43 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>> We will meet below issue due to mutex_lock() is called in interrupt context.
>> The mutex lock is used to protect the pattern trigger data, but before changing
>> new pattern trigger data (pattern values or repeat value) by users, we always
>> cancel the timer firstly to clear previous patterns' performance. That means
>> there is no race in pattern_trig_timer_function(), so we can drop the mutex
>> lock in pattern_trig_timer_function() to avoid this issue.
>>
>> Moreover we can move the timer cancelling into mutex protection, since there
>> is no deadlock risk if we remove the mutex lock in pattern_trig_timer_function().
>>
>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:254
>> in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/1
>> CPU: 1 PID: 0 Comm: swapper/1 Not tainted
>> 4.20.0-rc1-koelsch-00841-ga338c8181013c1a9 #171
>> Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>> [<c020f19c>] (unwind_backtrace) from [<c020aecc>] (show_stack+0x10/0x14)
>> [<c020aecc>] (show_stack) from [<c07affb8>] (dump_stack+0x7c/0x9c)
>> [<c07affb8>] (dump_stack) from [<c02417d4>] (___might_sleep+0xf4/0x158)
>> [<c02417d4>] (___might_sleep) from [<c07c92c4>] (mutex_lock+0x18/0x60)
>> [<c07c92c4>] (mutex_lock) from [<c067b28c>] (pattern_trig_timer_function+0x1c/0x11c)
>> [<c067b28c>] (pattern_trig_timer_function) from [<c027f6fc>] (call_timer_fn+0x1c/0x90)
>> [<c027f6fc>] (call_timer_fn) from [<c027f944>] (expire_timers+0x94/0xa4)
>> [<c027f944>] (expire_timers) from [<c027fc98>] (run_timer_softirq+0x108/0x15c)
>> [<c027fc98>] (run_timer_softirq) from [<c02021cc>] (__do_softirq+0x1d4/0x258)
>> [<c02021cc>] (__do_softirq) from [<c0224d24>] (irq_exit+0x64/0xc4)
>> [<c0224d24>] (irq_exit) from [<c0268dd0>] (__handle_domain_irq+0x80/0xb4)
>> [<c0268dd0>] (__handle_domain_irq) from [<c045e1b0>] (gic_handle_irq+0x58/0x90)
>> [<c045e1b0>] (gic_handle_irq) from [<c02019f8>] (__irq_svc+0x58/0x74)
>> Exception stack(0xeb483f60 to 0xeb483fa8)
>> 3f60: 00000000 00000000 eb9afaa0 c0217e80 00000000 ffffe000 00000000 c0e06408
>> 3f80: 00000002 c0e0647c c0c6a5f0 00000000 c0e04900 eb483fb0 c0207ea8 c0207e98
>> 3fa0: 60020013 ffffffff
>> [<c02019f8>] (__irq_svc) from [<c0207e98>] (arch_cpu_idle+0x1c/0x38)
>> [<c0207e98>] (arch_cpu_idle) from [<c0247ca8>] (do_idle+0x138/0x268)
>> [<c0247ca8>] (do_idle) from [<c0248050>] (cpu_startup_entry+0x18/0x1c)
>> [<c0248050>] (cpu_startup_entry) from [<402022ec>] (0x402022ec)
>>
>> Fixes: 5fd752b6b3a2 ("leds: core: Introduce LED pattern trigger")
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> 
> Thanks!
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

