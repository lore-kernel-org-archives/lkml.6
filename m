Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7CAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79824208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="th8Fmccc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79824208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeFUNIz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:08:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39116 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933110AbeFUNIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:08:53 -0400
Received: by mail-wr0-f194.google.com with SMTP id w7-v6so3137154wrn.6;
        Thu, 21 Jun 2018 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h3N8LJ5u+IdTdU+rle7Rsl7xxJ1ANrV4sMdmkC3Wul0=;
        b=th8Fmccc+Ebcu7YjGQJJR0rthkVTXJbluxS8oGBxMknHZF0SGU/YdaftfxbQBmxdFC
         H8FTvuISmVA08FrDw6wMv2RXur+c36jduyxeEnvsl5kXPIMdxu2JPrKNY4BKZ3WNoCUD
         p5tbJeNG+LgZ6rXgreA6NMdZdG1C5nHkdGjL+iC21tNmK7Vrrkm+1iqiFTEeP30zCQyC
         g+HOrwOzXYTuWOMSoI5LZxvVtmawf9Ekdj7wdmXcog9olRn7AmByW/Irb2zk1p0BJEle
         UK+xdMv45WIzYam5c+jfhGUeOAOupheDHcNJ59L9yLtc/F+80T9ibBZUvSSSzlqWpF6+
         vHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h3N8LJ5u+IdTdU+rle7Rsl7xxJ1ANrV4sMdmkC3Wul0=;
        b=h6oB+CC5OD7ntMy4ikta+ib+FCErG7Jl2c8y+ifF+a6r8cPpOTNHGhhTW6wD4AcmyM
         GjKrS3Ft7QiCbeAwm83JFUrW5MxydABP0nQYf+3exzUko2sapgffy1FyxOumsQqpCL7M
         Oj9mpX+7JLFsg1OMs4qoQmck8phb+F/i893IoAMj4zmCNC85mTd2egsiYLXb4UqrJOZp
         R1pDwQJ2Fs4YwVHivK49E2vIbIYhPRGd9eMlbjk4DWea4aNHSSYo1BtoezlfT9tBVXtf
         tn8TS2HggompQeL/CD9/kePsmPO0boABaWxK9RVLq7IwpQwiKebGfRolvrDHu0fGcBbM
         Wn0w==
X-Gm-Message-State: APt69E3Ot39dCthrvINn6V6xk7iluna9HUsI/76dulDt573JlTupJ68j
        kYgOyS9a23+PAeOkC4eOsmE=
X-Google-Smtp-Source: ADUXVKJzkDRi/2CKpLDUsv4eq09NquXUVOaMnhQ9x7f+9ZGxjQz5uImYLY0pcChdqT9YxPcJO7KMiw==
X-Received: by 2002:adf:8142:: with SMTP id 60-v6mr20916575wrm.192.1529586531788;
        Thu, 21 Jun 2018 06:08:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 84-v6sm6195131wme.16.2018.06.21.06.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 06:08:50 -0700 (PDT)
Date:   Thu, 21 Jun 2018 15:08:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Erick Reyes <erickreyes@google.com>,
        Julia Cartwright <julia@ni.com>,
        Byungchul Park <byungchul.park@lge.com>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] softirq: reorder trace_softirqs_on to prevent
 lockdep splat
Message-ID: <20180621130848.GA10037@gmail.com>
References: <20180607201143.247775-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607201143.247775-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joel Fernandes <joelaf@google.com> wrote:

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> I'm able to reproduce a lockdep splat with config options:
> CONFIG_PROVE_LOCKING=y,
> CONFIG_DEBUG_LOCK_ALLOC=y and
> CONFIG_PREEMPTIRQ_EVENTS=y
> 
> $ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable
> 
> [   26.112609] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
> [   26.112636] WARNING: CPU: 0 PID: 118 at kernel/locking/lockdep.c:3854
> [...]
> [   26.144229] Call Trace:
> [   26.144926]  <IRQ>
> [   26.145506]  lock_acquire+0x55/0x1b0
> [   26.146499]  ? __do_softirq+0x46f/0x4d9
> [   26.147571]  ? __do_softirq+0x46f/0x4d9
> [   26.148646]  trace_preempt_on+0x8f/0x240
> [   26.149744]  ? trace_preempt_on+0x4d/0x240
> [   26.150862]  ? __do_softirq+0x46f/0x4d9
> [   26.151930]  preempt_count_sub+0x18a/0x1a0
> [   26.152985]  __do_softirq+0x46f/0x4d9
> [   26.153937]  irq_exit+0x68/0xe0
> [   26.154755]  smp_apic_timer_interrupt+0x271/0x280
> [   26.156056]  apic_timer_interrupt+0xf/0x20
> [   26.157105]  </IRQ>
> 
> The issue was this:
> 
> preempt_count = 1 << SOFTIRQ_SHIFT
> 
> 	__local_bh_enable(cnt = 1 << SOFTIRQ_SHIFT) {
> 		if (softirq_count() == (cnt && SOFTIRQ_MASK)) {
> 			trace_softirqs_on() {
> 				current->softirqs_enabled = 1;
> 			}
> 		}
> 		preempt_count_sub(cnt) {
> 			trace_preempt_on() {
> 				tracepoint() {
> 					rcu_read_lock_sched() {
> 						// jumps into lockdep
> 
> Where preempt_count still has softirqs disabled, but
> current->softirqs_enabled is true, and we get a splat.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Glexiner <tglx@linutronix.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Erick Reyes <erickreyes@google.com>
> Cc: Julia Cartwright <julia@ni.com>
> Cc: Byungchul Park <byungchul.park@lge.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Fixes: d59158162e032 ("tracing: Add support for preempt and irq enable/disable events")
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/softirq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 177de3640c78..8a040bcaa033 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -139,9 +139,13 @@ static void __local_bh_enable(unsigned int cnt)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> +	if (preempt_count() == cnt)
> +		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> +
>  	if (softirq_count() == (cnt & SOFTIRQ_MASK))
>  		trace_softirqs_on(_RET_IP_);
> -	preempt_count_sub(cnt);
> +
> +	__preempt_count_sub(cnt);
>  }

Acked-by: Ingo Molnar <mingo@kernel.org>

Steve, wanna queue this up? Splat should only occur with tracing AFAICT.

Thanks,

	Ingo
