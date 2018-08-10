Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CBEC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BBF22402
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cw4qYfN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BBF22402
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeHJPb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:31:26 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41059 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeHJPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:31:25 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so8483362ywg.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tusA5xAlIzxwgbYzfV50sQn1WpDTr2pLF3kNCqXNVeI=;
        b=Cw4qYfN4VPXuIl9eHN07+sYdlySSwxxAtoNnZozAQ2KOlS2k+3AwnJbagSnIsXQlra
         OpdxxNdvvGVQH+2xZGLq1qUHLP9x5/rGKJ2DrOhWRKBZlijezNHB6vFt/KquuN9++G0Z
         kgoH+cr0QHCn6afIFJUC3FXIHPc89LQuOKrWFS5LLWiRv9/ysU49WqEtPDq8Z11X7Cmg
         Cm3LueGDByR4GRz34op0ikeREBzVXP4CZzDkuzm1zA1H/fr8YubUE8SiCLOdZpvPhRAU
         0v0alwA55D/UYgw1Fbxb+0lraZKA4iXuTlXFGkY1ibnIyB2PShqeSlR/R8IdVuxZ/ewy
         eOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tusA5xAlIzxwgbYzfV50sQn1WpDTr2pLF3kNCqXNVeI=;
        b=Dl1cU03hMm4HHnVmZnnzxpQQl+YraewoY9ll2APxtV2eUUeorSlHj/Gs1zpF5Y6NqL
         jF7O41rQaRms1nxhz0BVwE2ik9B7782IYrnnNW19dExcYxS2nvwsIFz/EfwkgwEzEr/+
         Ncr78QKcIaYKfv6XlXSfXfkg1/oOuPQ9m0l2/d9PekmsmgFf3mUEUb870Ua+3sKdDFoN
         UiItqOwqMre9MzPOt5NP/LJ6WThumQh3PlEy0SBrBx4ll4hD/bnmo3KsKaWhkokBbjTd
         VkS6w2LDr4fLCIFRGpTiugx+GRddNHY0qGlc5geeKkjmU1usAubJJNS5hk+W1nDw0Tq/
         eNIA==
X-Gm-Message-State: AOUpUlGsPVf4AU6aN/m99+kL1iylxwnom6REZ8WK81GRY2ioINh5C92q
        /pw0ijyXUtucGKeBxAaYGty7ajZZkL8EtsVhAYUdzA==
X-Google-Smtp-Source: AA+uWPxEei3/HxAMSh9Mmuj6SVdLCbADrGPZWa5xbgMAOv+qqtdJjtvNnM6jAhaM0wd2kHznY0cYasLfttDAGL1WqM4=
X-Received: by 2002:a5b:607:: with SMTP id d7-v6mr3609527ybq.281.1533906095111;
 Fri, 10 Aug 2018 06:01:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3995:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 06:01:34
 -0700 (PDT)
In-Reply-To: <20180810215511.60d5882c8efd271c01043881@kernel.org>
References: <20180806034049.67949-1-joel@joelfernandes.org>
 <20180806230536.ef217b2c2c008838606bedc3@kernel.org> <CAJWu+orzTpcjAcWRmgE8bLtK6BfzfQ_SW1WMho5Y-nsiACTCyQ@mail.gmail.com>
 <20180810215511.60d5882c8efd271c01043881@kernel.org>
From:   Joel Fernandes <joelaf@google.com>
Date:   Fri, 10 Aug 2018 06:01:34 -0700
Message-ID: <CAJWu+opTKi5+LFRea1oim9-pPci13kH-Af65hQ+SjKtcazu+Bw@mail.gmail.com>
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

On Fri, Aug 10, 2018 at 5:55 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
[..]
>>
>> >> The other way to fix this is to just use SRCU for all tracepoints.
>> >> However we can't do that because we can't use NMIs from RCU context.
>> >>
>> >> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints
>> >>                       and unify their usage")
>> >> Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
>> >> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
>> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> >> ---
>> >>  kernel/trace/trace_irqsoff.c | 26 ++++++++++++++++++++++++++
>> >>  1 file changed, 26 insertions(+)
>> >>
>> >> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
>> >> index 770cd30cda40..ffbf1505d5bc 100644
>> >> --- a/kernel/trace/trace_irqsoff.c
>> >> +++ b/kernel/trace/trace_irqsoff.c
>> >> @@ -603,14 +603,40 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
>> >>   */
>> >>  static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
>> >>  {
>> >
>> > To ensure this function must not be preempted even if we increment preempt
>> > count, I think you should check irq_disabled() whole this process, put below
>> > here.
>> >
>> >         if (unlikely(!irq_disabled()))
>> >                 return;
>> >
>> > Since irq_disabled() will be checked in irq_trace() anyway, so no problem
>> > to return here when !irq_disabled().
>>
>> IRQs can never be enabled here. The trace hooks are called only after
>> disabling interrupts, or before enabling them. Right?
>>
>
> Even though, it should be verified or atleast commented on the function header.

Ok.  ftrace/core has been fixed since since so this patch is outdated
and isn't needed any more, but I agree a separate patch doc comment
would help make it clear about this fact. Both IRQ and preempt
tracepoints work this way, they fire only within their critical
section.
