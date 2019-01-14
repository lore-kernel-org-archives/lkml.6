Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91234C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AAD20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="E6Wfx6Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfANWbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:31:13 -0500
Received: from mail.efficios.com ([167.114.142.138]:32784 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfANWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:31:13 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 88EDEB2BD7;
        Mon, 14 Jan 2019 17:31:10 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 4Htcg3GwskeB; Mon, 14 Jan 2019 17:31:10 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 11E4BB2BD3;
        Mon, 14 Jan 2019 17:31:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 11E4BB2BD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547505070;
        bh=G2qVxhGO64VNrQrfuf9Qqdb6DerovaM5n5Wh9eoTeGw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=E6Wfx6OhGnKyDrwd4CG4SuoCuMo3/OAgl+6srl5H7jqhLo4v0st405oO8KKlNhf0J
         3VlkPGdH+oAai6hYrrpNZaPOBkf3mmAxE+OFEO64JDPoxnQvdJlIC7woqsTYo2akZv
         T6JWnTmJ+34EmBDbjS+WES1tZwgcbqvliWF00q30hUiZksQJxx7B10sQT5g6iJZyom
         8jsIm/s2nYUlk3q2/0Or51kVMxq3fsfzpORksxO2UwYTT+iaJ5RT1AgX0LfDYUD9E+
         inlm7NzHSbFj+2TPXhQZxmdbqGerH0/xWrPvkB4hdZmRKybfxmuSmRnZuK8LjvnTeq
         w+f178stBGnPQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id TGS9_FrHKJZN; Mon, 14 Jan 2019 17:31:10 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id EFF01B2BC8;
        Mon, 14 Jan 2019 17:31:09 -0500 (EST)
Date:   Mon, 14 Jan 2019 17:31:09 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1546659617.746.1547505069810.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190114170403.344f7247@gandalf.local.home>
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com> <1884815641.993.1547138653377.JavaMail.zimbra@efficios.com> <600900741.1177.1547140315581.JavaMail.zimbra@efficios.com> <1083900143.1198.1547141113001.JavaMail.zimbra@efficios.com> <1706586119.1203.1547142327142.JavaMail.zimbra@efficios.com> <20190114130957.GA10486@hirez.programming.kicks-ass.net> <615183542.671.1547501819850.JavaMail.zimbra@efficios.com> <20190114170403.344f7247@gandalf.local.home>
Subject: Re: Perf: event wakeup discards sched_waking events
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: Perf: event wakeup discards sched_waking events
Thread-Index: HptYZ68rLd/49HaO/Av+8ti7H3ZRmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Jan 14, 2019, at 5:04 PM, rostedt rostedt@goodmis.org wrote:

> On Mon, 14 Jan 2019 16:36:59 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Can ftrace end up in the same situation through rb_wake_up_waiters() ? I suspect
>> the tail recursion would be hard to trigger if the wakeup only happens once per
>> page though, unless the events generated end up filling up a page.
> 
> And only events from the irq work that was caused by the ftrace wakeup,
> which is highly unlikely.
> 
> Note, the lastest kernel only wakes up after half the buffer is full
> (by default, but that can be changed), as I found that it gives the
> best performance to keeping up with traces. I can actually trace small
> loads and get all events now. Before, the waking of the tracer would
> cause its own events to fill up the buffer and not be able to keep up
> even on simple loads.
> 
>> 
>> FWIW, LTTng avoids this entire issue by using a timer-based polling mechanism
>> to ensure the tracing code does not call into the scheduler wakeup.
> 
> Does your timer stop if the system is idle and tracing is enabled?

LTTng exposes three functions for integration with CONFIG_NO_HZ:

lib_ring_buffer_tick_nohz_flush()
lib_ring_buffer_tick_nohz_stop()
lib_ring_buffer_tick_nohz_restart()

Unfortunately, last time I checked, the Linux kernel did not expose any
modules API to register nohz notifiers to call those functions when going
to idle and getting out of idle. Therefore, the plumbing is there
in LTTng (it has been done when I implemented libringbuffer about 6 years
ago intending to contribute it to the Linux kernel), but this code has
never been reachable within lttng-modules due to lack of kernel support.

Thomas Gleixner expressed strong feelings against introducing tick nohz
notifiers for kernel modules in the past, so I never pushed in that
direction.

Perhaps there is now a way to properly wire this up that I've missed ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
