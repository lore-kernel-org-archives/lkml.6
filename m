Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA17C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB11C20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BBjxKl+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbeLNPFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:05:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37226 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbeLNPFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:05:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id t33so3741160qtt.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=01Rr7o8gfIjmeNToKMPqIG72s20V5VWyTkW8ormrDIg=;
        b=BBjxKl+r7EvW9i1tUhRH57AtvN5nTvemfMV8xaNr+HmUAFxQsby8G1IBqs7NSlFgIS
         CostJlttru90zGAepUpGZpnJE1fTGgSd6ZXNC/tvlJgUdb0LrqlNzu2hPbiO0d8wWdah
         /n/V2gA27ToSjFHfBn805SN73a02U7NqbhjqDJVEZwD8Ee32uvaE0iodLiteD27VNwU6
         4yRIyEpjQZ4hd5/V5u+CKMFAn2ZFPCZdAF1EYOHxMdAevjAs5828YRd9sJnPEhzvwqXr
         eWVZykJEh30V5T0mQfAev3EPIi1SnJhgF+hKcLyMOt0eGp6fh3G+KBKN+J7MXvpTvXBY
         GIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=01Rr7o8gfIjmeNToKMPqIG72s20V5VWyTkW8ormrDIg=;
        b=X90IQ1xDdh4pAsy7c2dchTD3eWFxkYPo2ZYYz90FR7ydy4Akr7r0wuZ8TpIsKv/lbq
         GPGHjQ1RIAR/RSPKMMjfrqAPrpB2A7Q95lX+1jbRTg6x2BaHNNcdU6twA/hoR/Flfepm
         dQeGTvxyUA/OWrTeBvYkzqXh/JeFm0glA6BQ7RBKNbVaVatdjKodqVDh9N1586LL3QsB
         dR2Q/h9qw+tkWA+p+nP8iXWLh8DW4GKncyKBy8a4nH7xF/7Kr6gmWfM1I4zqNxaHwbOs
         sh9S24QAu/mc1xNd1o4yqdGyDzJnjGzdbTkB/R2f9HF7l7hw33/2FYkUEo64DJ2u2A2C
         CQ+w==
X-Gm-Message-State: AA+aEWZY2z7s+HwQQ7Ct2s5S3nDVjvAj4xCmC/46Ub0oko+8Y1rYLRuS
        3WTM0HpSIl+MgfVQKBnN4vBMzNZRA/E=
X-Google-Smtp-Source: AFSGD/UThxAHkwR9bjXgacyOfCmn4upnIX2OBa/NekgIqiqb7B5rXLEhKyfdiUZm6PIaQQML52wWpw==
X-Received: by 2002:ac8:3810:: with SMTP id q16mr2944662qtb.91.1544799910327;
        Fri, 14 Dec 2018 07:05:10 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q15sm3166712qkl.81.2018.12.14.07.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 07:05:09 -0800 (PST)
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, mark.rutland@arm.com,
        marc.zyngier@arm.com, daniel.lezcano@linaro.org, mingo@kernel.org,
        longman@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
 <20181210135228.49751-1-cai@lca.pw>
 <20181210140703.GM5289@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1812102229480.1667@nanos.tec.linutronix.de>
From:   Qian Cai <cai@lca.pw>
Message-ID: <15e4006c-2ec0-c572-55e0-acbb75625eb4@lca.pw>
Date:   Fri, 14 Dec 2018 10:05:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812102229480.1667@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/18 4:31 PM, Thomas Gleixner wrote:
> On Mon, 10 Dec 2018, Peter Zijlstra wrote:
>> On Mon, Dec 10, 2018 at 08:52:28AM -0500, Qian Cai wrote:
>>> Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
>>> warning.
>>>
>>> [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
>>> [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
>>> [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
>>> [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
>>> [    0.000000]  acpi_table_parse+0x1ac/0x218
>>> [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
>>> [    0.000000]  timer_probe+0x1bc/0x254
>>> [    0.000000]  time_init+0x44/0x98
>>> [    0.000000]  start_kernel+0x4ec/0x7d4
>>
>> It seems to me we want something like:
>>
>> ---
>>  kernel/cpu.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 91d5c38eb7e5..e1ee8caf28b5 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -313,6 +313,8 @@ void cpus_write_unlock(void)
>>  
>>  void lockdep_assert_cpus_held(void)
>>  {
>> +	if (system_state < SYSTEM_RUNNING)
>> +		return;
>>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>>  }
>  
> Hmm, no. SYSTEM_SCHEDULING is what you want because RUNNING is set way too
> late.

SYSTEM_SCHEDULING works well here too.
