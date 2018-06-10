Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AR2HBS5mHVsPXwAAmS7hNA
	; Sun, 10 Jun 2018 17:55:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EA7D46074D; Sun, 10 Jun 2018 17:55:57 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=email.wm.edu header.i=@email.wm.edu header.b="Twbx3fU9"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2DF7B604D4;
	Sun, 10 Jun 2018 17:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DF7B604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=email.wm.edu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeFJRzz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 13:55:55 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35210 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeFJRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 13:55:53 -0400
Received: by mail-vk0-f66.google.com with SMTP id o17-v6so11024481vka.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=email.wm.edu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DllK9ZE8Kob8mwG9MYBif+StDcgH/xD0r4TKk6/akMQ=;
        b=Twbx3fU9ggSOAaHKAqRHEonFDIuzZDAmV2ofOZsKrQPIAV45WA/gaUQnDRRyeF1cIY
         Mx2AGnH+Eo6J0x2marhjpjD+d0lH10eoSiXGaXoFUCKP0G01z47tMAvZUFl1LWae1NPC
         F4+A1Zu4B3treVfQxK19CdT9UI+SkWqvXm9gSlhWe77qR4Spz+z9K/3+Rh802nwV9eph
         2duiV8t5fR9K2Cp7azL1CtctBwNbH8XepOiFXpOsqtI/Yz8+A7DEcNnkfWheTPjpYbKB
         MEO8opLk+t8BO2nABdDoL1hdHX3WP9pFyLhDaMPQSdk+5pp9w80PWN8n3OQEcTfzqteY
         0JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DllK9ZE8Kob8mwG9MYBif+StDcgH/xD0r4TKk6/akMQ=;
        b=X8t4I0aUAODPqcpv4CSH4OinkeP3TbLGp20z0YonTm7+AKt/AIMkNAfFHuxnD4gg0R
         8/7Ca9EAT04LyZrjpHx4SywuCxjlTW/yafBNHYCPv6G0SenmbY8w62SSzIeTX1filErB
         m08we2ed3Qtb2Dl2FH2C3dkwbKyzqmosQq/YJ8w+mfKajgOmI8JU1jd9MqKBZFhWOJVP
         A6ia6UbZqflrk/Aad1hh9JViDyoSb7FuC37FEQ1HOiVq5uzftENC3x9LQgJVRtxesO0g
         GDeefuFxHAmcSq9/1hApKDZ+0CHaEDFE+OMXvx+7jzNb7rrTvlW8hSd4sba4bwrtbm9k
         BUpw==
X-Gm-Message-State: APt69E3qr5YDIJcabP+7usS/AVZ8jiiuTEWqfdWrDh2oNzdXn20oJ1pm
        Zblyevfr6xHCyHK1vaG620I5AoU3zRwDB7CLu188Dw==
X-Google-Smtp-Source: ADUXVKK+4xER1im6fGo9p2M7TI950ic2zjMf6KGSvuq23BGJNJHIWzoT2RnoTc85KLJ87chgtw7QFA68m5Yiz33v5TQ=
X-Received: by 2002:a1f:2282:: with SMTP id i124-v6mr9043609vki.48.1528653351960;
 Sun, 10 Jun 2018 10:55:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f47:0:0:0:0:0 with HTTP; Sun, 10 Jun 2018 10:55:11
 -0700 (PDT)
In-Reply-To: <20180525144927.GE22082@lerouge>
References: <CAC-KJC3d8aba4UMHPUE8SdM++cQXgXS_U0EvGC_aSJ3ybhbWAw@mail.gmail.com>
 <20180517143852.GD24274@krava> <20180525144927.GE22082@lerouge>
From: Probir Roy <proy@email.wm.edu>
Date: Sun, 10 Jun 2018 13:55:11 -0400
Message-ID: <CAC-KJC00=9YLpLu-7voGp0oZ_WC4cyWnrf7Mr1-NLvvGiZQoDw@mail.gmail.com>
Subject: Re: Perf record of mem event on kernel data address causing freeze
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        Andrew Lutomirski <amluto@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the extreme delay for this reply.

If the expectation was to resolve the issue, the new patch failed to do so.

If this information helps, the system hung when WP tried to monitor an
address(0xffff88021f51a768) which was originally sampled by PEBS
inside rcu_nmi_exit.


On Fri, May 25, 2018 at 10:49 AM, Frederic Weisbecker
<frederic@kernel.org> wrote:
> On Thu, May 17, 2018 at 04:38:52PM +0200, Jiri Olsa wrote:
>> On Fri, May 11, 2018 at 02:23:14PM -0400, Probir Roy wrote:
>> > I am using perf-tool to record memory access to some kernel addresses.
>> > For some kernel addresses it freezes/lockup the system.
>> >
>> > I am using kernel version 4.15.0 on x86_64 arch. I am running on an
>> > Intel Broadwell machine.
>> >
>> > I am using Intel's PEBS to sample kernel memory access while running a
>> > micro-benchmark (performs repeated file operation) using following
>> > command.
>> >
>> > $ sudo perf mem -t store record
>> >
>> > This records memory references. After that I run a script to set HW
>> > breakpoint at the reference addresses.
>> >
>> > $ sudo timeout 1s perf record -e mem:<0xaddress>:rw
>> >
>> > It causes system hang at some address (for many address perf reports
>> > correctly). Nothing is written in kern.log
>> >
>> >
>> > I have reported it on bugzilla with detail system information:
>> > https://bugzilla.kernel.org/show_bug.cgi?id=199697
>>
>> I managed to reproduce.. in my case it's caused by having rw
>> breakpoint on data which is touched within do_debug routine,
>> and after few nested do_debug I get double fault
>>
>> for example I can reproduce it immediately when setting breakpoint
>> on rdtp->dynticks_nmi_nesting, which is checked in rcu_nmi_enter
>>
>> I have some ugly patch so far that disables breakpoints during
>> do_debug processing.. it seems to fix it on my server, could you
>> try that?
>>
>> thanks,
>> jirka
>>
>>
>> ---
>> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
>> index 03f3d7695dac..14d41d59abeb 100644
>> --- a/arch/x86/kernel/traps.c
>> +++ b/arch/x86/kernel/traps.c
>> @@ -721,9 +721,12 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
>>  {
>>       struct task_struct *tsk = current;
>>       int user_icebp = 0;
>> -     unsigned long dr6;
>> +     unsigned long dr6, dr7;
>>       int si_code;
>>
>> +     get_debugreg(dr7, 7);
>> +     set_debugreg(0, 7);
>> +
>>       ist_enter(regs);
>>
>>       get_debugreg(dr6, 6);
>> @@ -818,6 +821,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
>>
>>  exit:
>>       ist_exit(regs);
>> +     set_debugreg(dr7, 7);
>>  }
>>  NOKPROBE_SYMBOL(do_debug);
>
> I'm not sure how much we touch dr7 while in the do_debug() trap, so we may be leaking
> some modifications on exit.
>
> I think about a simple do_debug() recursion protection. The problem is where we store
> that recursion flag/counter. Ideally I would prefer to have the recursion protection
> before ist_enter() which already touches many key memory data (preempt_mask, rcu_data).
> But if we set that before ist_enter(), we need the recursion flag to be per task because
> preemption is disabled on ist_enter() only, although the comments  suggest it's unsafe
> to schedule before anyway. So it could be a TIF_FLAG. But better yet, if we want to be
> able to set breakpoint on thread flags, we could add a new field in thread info.
>
> Anyway here is a very dumb version below. Can you test it Probir, to see if that's
> at least the right direction?
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 03f3d76..873383b 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -693,6 +693,8 @@ static bool is_sysenter_singlestep(struct pt_regs *regs)
>  #endif
>  }
>
> +static DEFINE_PER_CPU(int, do_debug_recursion);
> +
>  /*
>   * Our handling of the processor debug registers is non-trivial.
>   * We do not clear them on entry and exit from the kernel. Therefore
> @@ -725,6 +727,10 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
>         int si_code;
>
>         ist_enter(regs);
> +       if (__this_cpu_read(do_debug_recursion))
> +               goto exit;
> +
> +       __this_cpu_write(do_debug_recursion, 1);
>
>         get_debugreg(dr6, 6);
>         /*
> @@ -817,6 +823,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
>         debug_stack_usage_dec();
>
>  exit:
> +       __this_cpu_write(do_debug_recursion, 0);
>         ist_exit(regs);
>  }
>  NOKPROBE_SYMBOL(do_debug);



-- 
Probir Roy
PhD Student
College of William and Mary
Phone: 7577531428
