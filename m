Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF00C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05E62083E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H7pdVNh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBNAh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:37:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40234 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfBNAhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:37:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so2064747pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pHNw059Ci1wHj7G3Kds8q+VVsU1SsIwdPhpbayBk3Jk=;
        b=H7pdVNh+4GGqUzIfWeoO9MUlkt9ktCqUjcJi68lP83Dramg4gIjVZfDfsVEuL7uD2Q
         aAg++qo3qVyPwxayHHsaMOIKBF7qm6JjD+eEoHlKze7umnRszT8T9iLO8qv6r/726kR4
         6d9WqgeMnJ1kKX+a2Zhhe+KW9pMvgzjixTBgJXAheKawxRuffWJm+8cE/q6Zh8enXggY
         4xZxRNVzGAu9E3msIH7+HFyT9sKXklacm6xt/YZhuKaawru6P+lAEQ45O3U3hz358Bt7
         chq9m7UoTuUeSojubgfTpP8uJRoEtY9IiApqmCKD47pJq0TtmN2YW8cV/txp1yovnIb1
         P1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pHNw059Ci1wHj7G3Kds8q+VVsU1SsIwdPhpbayBk3Jk=;
        b=MZtMJCT3XAMaEgytDcjI3OQCq4gihY35IaQhyJm+6leUMQcltxl3SwoimXi1HRJNjO
         WAj8TF6y/Q8Zgv00RKQbmJB6h1M8I3Y+h7CQvf0F8nN9YSvV915WpC2jf6pNA0Vf5WHz
         QHm1KwdkyQwAgR1hN/JJJFuFrJqMO8LBQ0ariUoC4PFBUqVDVihtFINCmbgPqJ1UPd5Z
         zXUbpH6mBrGizid/zh75J1X8JnGXTtPw63XEc5NG7rMqE2VMDx3+vnUUBz87J4B5/Dvk
         TZ+4m1AqPkb8T7GQ62XUtkQbJ7f34SGyKlUL+/OH0fIBtm6B1mez4kVHEmwjdCSAvdWg
         Cv/Q==
X-Gm-Message-State: AHQUAuaqW+7BEDEeVjbJ2iGNWGHMYpChxy1EkysBbl0KX+Pb6gbHywtD
        NpoEr7GJvX37KzI2DJXtepAGfg==
X-Google-Smtp-Source: AHgI3IZh1z6hIg9fDCBtbaOk7Pq+hXJIXsnzlpjVcVpq2T/Xeb+BXaYtSw4ccLvkc1Yr2GctzDiR0A==
X-Received: by 2002:a62:e50b:: with SMTP id n11mr1031760pff.212.1550104672989;
        Wed, 13 Feb 2019 16:37:52 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g2sm603568pfi.95.2019.02.13.16.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 16:37:52 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:37:52 -0800 (PST)
X-Google-Original-Date: Wed, 13 Feb 2019 16:35:45 PST (-0800)
Subject:     Re: [v4 PATCH 6/8] clocksource/drivers/riscv: Add required checks during clock source init
In-Reply-To: <7bd250fb-c896-64e1-d73b-6f3dd284e2d6@linaro.org>
CC:     atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        alankao@andestech.com, aou@eecs.berkeley.edu, schwab@suse.de,
        anup@brainfault.org, dmitriy@oss-tech.org, jason@lakedaemon.net,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, Paul Walmsley <paul.walmsley@sifive.com>,
        robh@kernel.org, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     daniel.lezcano@linaro.org
Message-ID: <mhng-82b44439-e7ff-4464-9c9f-67c7eb686ecf@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 00:48:24 PST (-0800), daniel.lezcano@linaro.org wrote:
> On 12/02/2019 12:10, Atish Patra wrote:
>> Currently, clocksource registration happens for an invalid cpu for
>> non-smp kernels. This lead to kernel panic as cpu hotplug registration
>> will fail for those cpus. Moreover, riscv_hartid_to_cpuid can return
>> errors now.
>>
>> Do not proceed if hartid or cpuid is invalid. Take this opprtunity to
>> print appropriate error strings for different failure cases.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>
> Do you want me to take it through my tree ?

Works for me.  Aside from the typo:

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

>
>
>> ---
>>  drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
>> index 43189220..e8163693 100644
>> --- a/drivers/clocksource/timer-riscv.c
>> +++ b/drivers/clocksource/timer-riscv.c
>> @@ -95,13 +95,30 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>  	struct clocksource *cs;
>>
>>  	hartid = riscv_of_processor_hartid(n);
>> +	if (hartid < 0) {
>> +		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
>> +			n, hartid);
>> +		return hartid;
>> +	}
>> +
>>  	cpuid = riscv_hartid_to_cpuid(hartid);
>> +	if (cpuid < 0) {
>> +		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
>> +		return cpuid;
>> +	}
>>
>>  	if (cpuid != smp_processor_id())
>>  		return 0;
>>
>> +	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
>> +	       __func__, cpuid, hartid);

My only comment is that we flipped back and forth on whether or not to print 
info on driver initialization.  I like it because I have to go add the prints 
in to debug things, but IIRC we removed it at some point (probably more than 
once, as I have to keep adding these sorts of things back in and forget to 
remove them).

The review stands either way :)

>>  	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
>> -	clocksource_register_hz(cs, riscv_timebase);
>> +	error = clocksource_register_hz(cs, riscv_timebase);
>> +	if (error) {
>> +		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> +		       error, cpuid);
>> +		return error;
>> +	}
>>
>>  	sched_clock_register(riscv_sched_clock,
>>  			BITS_PER_LONG, riscv_timebase);
>> @@ -110,8 +127,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>  			 "clockevents/riscv/timer:starting",
>>  			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
>>  	if (error)
>> -		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> -		       error, cpuid);
>> +		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>> +		       error);
>>  	return error;
>>  }
>>
>>
