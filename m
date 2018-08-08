Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44D5C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8395E20834
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmdEMI7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8395E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeHHEaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:30:52 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42211 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeHHEav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:30:51 -0400
Received: by mail-yw1-f65.google.com with SMTP id y203-v6so462950ywd.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 19:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kmipV8+ifV8XjxfY9m6itWBHn4rWguGOVLGERE0Bl04=;
        b=KmdEMI7wFqOA8vj22HtlazQ33FMBcgDwJyT8qlgMDNRdoSdAnMpk4ElEendwVWim4z
         G5cmG2fietz0NMnMTmpiXl+ei9EXS83MC8XtyWZx3YEYwJujV+ZV3q+rNuwOb/rjWXgV
         PkwrDAWewFwgWndiq4Z56K9TXJM9cKIMBqEUbMbK7KxvyPb6RJKLlGKVql3ROWm7Vqur
         cWSqX/4qDRLEnXwf4uvPdJEruZ9tKHBAcGlS3mmDUdu6T3mWB2s/zw0YS2WjcX6cH3q0
         1VkQXx09g1DrtrFzcZFXjg2xSSjrOXXlYSl+TIdadvWW3dfgG6IripqOvuAiBjg0XcVH
         bQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kmipV8+ifV8XjxfY9m6itWBHn4rWguGOVLGERE0Bl04=;
        b=mg8D72VZqUZVK4jdpCE7mj2ZNl55Hyakz5vy560Ia62Itnlj8sHt/MUrUW8r94tDZ1
         8J2MmvL/g+fYgkQjmxlxWVZ/v6YEF86g0+X5TLMkXndbqdYYZlTAVBRsyySRs+Paizub
         t9DJf6tbTbpFBS0u5aFkoIlqNXVcYVJIKI/yShXRZPo91GEBdpesh9Dc3eJ+0vkrCNpA
         BQ8aLBMvpj0RWVGI197GMD6V/z3sG3neqIne/Y3rlKgeunjvBvAmRDZHsj+QuJS+uHXi
         9V3OGPrynE49+awjQARsyEKgxIGKOhQoY1R8YuifFmhIYI4QayjBsEyVh2BCdc0ItvDI
         ANpA==
X-Gm-Message-State: AOUpUlFs1jlJ8J0kWdmumyNpREEED+r8GPc8IQ0vntZHBw0oG3H9pXXX
        VOPaKzSPky7PwMh2UIswLJKWARKzhM99WPa8hAYIHRG7a7U=
X-Google-Smtp-Source: AA+uWPyvOEKK/3FhJFisQbme3HXEEvX1RQAajjgx+yPzXQ4e8ZuaC5OvNIZa+G7biA4j9OQgaOr0HumKpUhOe1QB/mM=
X-Received: by 2002:a25:b94c:: with SMTP id s12-v6mr433240ybm.91.1533694413660;
 Tue, 07 Aug 2018 19:13:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 19:13:32 -0700 (PDT)
In-Reply-To: <20180807215522.04114097@vmware.local.home>
References: <20180730222423.196630-1-joel@joelfernandes.org>
 <20180730222423.196630-4-joel@joelfernandes.org> <20180806155058.5ee875f4@gandalf.local.home>
 <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
 <20180806214300.13e63523@gandalf.local.home> <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com>
 <20180807094954.5137972d@gandalf.local.home> <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com>
 <20180807103410.4fe203cb@gandalf.local.home> <C1CB990F-8232-4168-89A8-E8C13B660B0B@google.com>
 <20180807110906.3a1b0ac4@gandalf.local.home> <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
 <20180807194515.4e549c1a@gandalf.local.home> <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
 <20180807204820.50b83c6d@vmware.local.home> <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
 <20180807215522.04114097@vmware.local.home>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 7 Aug 2018 19:13:32 -0700
Message-ID: <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 6:55 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 7 Aug 2018 18:17:42 -0700
> Joel Fernandes <joelaf@google.com> wrote:
>
>> From 6986af946ceb04fc9ddc6d5b45fc559b6807e465 Mon Sep 17 00:00:00 2001
>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>> Date: Sun, 5 Aug 2018 20:17:41 -0700
>> Subject: [PATCH] tracepoint: Run tracepoints even after CPU is offline
>>
>> Commit f37755490fe9 ("tracepoints: Do not trace when cpu is offline")
>> causes a problem for lockdep using tracepoint code. Once a CPU is
>> offline, tracepoints donot get called, however this causes a big problem
>> for lockdep probes that need to run so that IRQ annotations are marked
>> correctly.
>>
>> A race is possible where while the CPU is going offline, an interrupt
>> can come in and then a lockdep assert causes an annotation warning:
>>
>> [  106.551354] IRQs not enabled as expected
>> [  106.551785] WARNING: CPU: 1 PID: 0 at kernel/time/tick-sched.c:982
>>                                          tick_nohz_idle_enter+0x99/0xb0
>> [  106.552964] Modules linked in:
>> [  106.553299] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
>>
>> We need tracepoints to run as late as possible. This commit fixes the
>> issue by removing the cpu_online check in tracepoint code that was
>> introduced in the mentioned commit, however we now switch to using SRCU
>> for all tracepoints and special handle calling tracepoints from NMI so
>> that we don't run into issues that result from using sched-RCU when the
>> CPUs are marked to be offline.
>>
>> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and
>>                       unify their usage")
>> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
>
> The above change log doesn't look like it matches the NMI patch.
>
> Can you resend with just the NMI changes? I already handled the cpu
> offline ones.

Ok, sent with "cpu offline" changes dropped, here it is:
https://lore.kernel.org/patchwork/patch/972657/

If you could add your Reported-by to it, that would be great as well.

>
> But I may still have concerns with this patch.

Ok let me know what you think.

Thanks!

 - Joel
