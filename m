Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F05C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DA321A38
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8RdcgcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DA321A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbeHFQX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:23:57 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45566 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeHFQX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:23:56 -0400
Received: by mail-yb0-f196.google.com with SMTP id h127-v6so5318063ybg.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=adwqSUIV9AXhWIM3DwYWzpU9kAgWAroKPgJKcAG8VZk=;
        b=P8RdcgcMwcVeWUfcYA/1WmsIew3FS95aPdZP6qEu01EMbHGF+q407ozYNdbDC4aVcm
         DdpYcjAslGPGGeQoGK0VjusVNQmT9BCDEXJX8KwUgfAciKDPna8HM09Bq3UdZeKtd9Pu
         CAhWWXMNWKible3wMDpMd4ClahcbDmQGxCuV8f/Au5D6agkBf/fhwcnkKIe0XFNTRORl
         KJ/47RAUTscBVjBjuesQHXe5xsi8kVyA5TR7E2dY22wRlykM+lRnbY+/SrdP++wQWWtd
         8vb4h3t8LA29QcZNe4zZgGneMTX9nCTo98SDNdY2H8zO2UfoerZSlSLAjWb3qr/BKTDU
         wDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=adwqSUIV9AXhWIM3DwYWzpU9kAgWAroKPgJKcAG8VZk=;
        b=tTjJa8Qy0jjhQZN81MEu0aED8lMb7Mv0pwwU2F0QZ0NCmszV9rcCkQ/ctbTe9x7Isu
         OC5ZPFMkMaHPUjmFY82YwozOMNkOn+md5h5WGy861ZPSf33vasBW36POWZxWnrg1x9iV
         F4P7wWZaybgSzs9rzS0j+RAQyReHRt7VO0bzB9PjrGnXvtg8lWo0Ets2nTUmWjCGOsNP
         wYWedYCSX49pvBLEDZvDLuoKzTgpRsPPJ62383UUU00lCXBAqn+weAAxGNg09ZuH7u2K
         HWX8AMTrEbgfCoHkdzGpq8ePEqoxagZFj70lB8jDqw45keYDeB9tvf2ZJ7pPOtQEghbK
         LN5Q==
X-Gm-Message-State: AOUpUlFgP0bEYunC/xrO3Bj1O2eg9Xa4VWtPU5P9s8GZp+onMbOAC7x/
        3QpWgVl1cdkOtQ7GOebhP41Fr559z9PFFT/rqrQvqw==
X-Google-Smtp-Source: AAOMgpcKE2+2mZDyZWNnOixj3ou8J6TKTEpZAZR8jNM5kJvHoJ8YZZl2/48pUL9N0hJu4BnO/OPSuASl3BkCKnLYeQM=
X-Received: by 2002:a25:b94c:: with SMTP id s12-v6mr7521090ybm.91.1533564876220;
 Mon, 06 Aug 2018 07:14:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 07:14:35 -0700 (PDT)
In-Reply-To: <20180806230536.ef217b2c2c008838606bedc3@kernel.org>
References: <20180806034049.67949-1-joel@joelfernandes.org> <20180806230536.ef217b2c2c008838606bedc3@kernel.org>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 6 Aug 2018 07:14:35 -0700
Message-ID: <CAJWu+orzTpcjAcWRmgE8bLtK6BfzfQ_SW1WMho5Y-nsiACTCyQ@mail.gmail.com>
Subject: Re: [PATCH ftrace/core] tracing: irqsoff: Account for additional preempt_disable
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 7:05 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Sun,  5 Aug 2018 20:40:49 -0700
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
>
>> Recently we tried to make the preemptirqsoff tracer to use irqsoff
>> tracepoint probes. However this causes issues as reported by Masami:
>>
>> [2.271078] Testing tracer preemptirqsoff: .. no entries found ..FAILED!
>> [2.381015] WARNING: CPU: 0 PID: 1 at /home/mhiramat/ksrc/linux/kernel/
>> trace/trace.c:1512 run_tracer_selftest+0xf3/0x154
>>
>> This is due to the tracepoint code increasing the preempt nesting count
>> by calling an additional preempt_disable before calling into the
>> preemptoff tracer which messes up the preempt_count() check in
>> tracer_hardirqs_off.
>>
>> To fix this, make the irqsoff tracer probes balance the additional outer
>> preempt_disable with a preempt_enable_notrace.
>
> I've tested it and ensured this fixes the problem.
>
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

>> The other way to fix this is to just use SRCU for all tracepoints.
>> However we can't do that because we can't use NMIs from RCU context.
>>
>> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints
>>                       and unify their usage")
>> Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
>> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>  kernel/trace/trace_irqsoff.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
>> index 770cd30cda40..ffbf1505d5bc 100644
>> --- a/kernel/trace/trace_irqsoff.c
>> +++ b/kernel/trace/trace_irqsoff.c
>> @@ -603,14 +603,40 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
>>   */
>>  static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
>>  {
>
> To ensure this function must not be preempted even if we increment preempt
> count, I think you should check irq_disabled() whole this process, put below
> here.
>
>         if (unlikely(!irq_disabled()))
>                 return;
>
> Since irq_disabled() will be checked in irq_trace() anyway, so no problem
> to return here when !irq_disabled().

IRQs can never be enabled here. The trace hooks are called only after
disabling interrupts, or before enabling them. Right?

thanks,

- Joel
