Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530CCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067E320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tgR+6ooY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfANVhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:37:02 -0500
Received: from mail.efficios.com ([167.114.142.138]:51634 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfANVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:37:02 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7B2D7B206C;
        Mon, 14 Jan 2019 16:37:00 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LC7Fl2mfkz5e; Mon, 14 Jan 2019 16:37:00 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0BDC2B2060;
        Mon, 14 Jan 2019 16:37:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0BDC2B2060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547501820;
        bh=3ipZZWZs4PupDWApqOEhL18977OXkYtR9t6x4s107eE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tgR+6ooYxVCZel/1d+J39FgeNcUELS6lG+hsB/RG/uz5/dGJHVANOEyY9Byliu71z
         P2hXJO8bT4gelYXcs1CiYg1QnWhyxhqG/7kabQNB+KLTkyslUmq4pG29UmN+R64I84
         Xdglcu0x+amxh3Y6Q8dMEabWuOv7EN/XQwQgZuRA54mf50I4g89ErgtdCQvK/AgHnj
         Fw/GcyW4UhVcWs0M/HMg0LCPj2DctR3OmOU23jd17NOlSnEt53thAiujyq//OW8ic9
         +gvxOXk4/MvL1YYn2bpfiEQJzGQsBYIn+X66srN9qgY3FyETrthvzaKNn6KK/wo6S5
         qFdJIKaPiYtAg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id d85GMKgPlPyk; Mon, 14 Jan 2019 16:36:59 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id EA5C0B205A;
        Mon, 14 Jan 2019 16:36:59 -0500 (EST)
Date:   Mon, 14 Jan 2019 16:36:59 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <615183542.671.1547501819850.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190114130957.GA10486@hirez.programming.kicks-ass.net>
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com> <20190110110839.7daeef3d@gandalf.local.home> <1884815641.993.1547138653377.JavaMail.zimbra@efficios.com> <600900741.1177.1547140315581.JavaMail.zimbra@efficios.com> <1083900143.1198.1547141113001.JavaMail.zimbra@efficios.com> <1706586119.1203.1547142327142.JavaMail.zimbra@efficios.com> <20190114130957.GA10486@hirez.programming.kicks-ass.net>
Subject: Re: Perf: event wakeup discards sched_waking events
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: Perf: event wakeup discards sched_waking events
Thread-Index: PWIh8pUvQb0AP4H6utnbPhWO532PMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 14, 2019, at 8:09 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Jan 10, 2019 at 12:45:27PM -0500, Mathieu Desnoyers wrote:
> 
>> static void perf_pending_event(struct irq_work *entry)
>> {
>>         struct perf_event *event = container_of(entry,
>>                         struct perf_event, pending);
>>         int rctx;
>> 
>>         rctx = perf_swevent_get_recursion_context();
>>         /*
>>          * If we 'fail' here, that's OK, it means recursion is already disabled
>>          * and we won't recurse 'further'.
>>          */
>> 
>>         if (event->pending_disable) {
>>                 event->pending_disable = 0;
>>                 perf_event_disable_local(event);
>>         }
>> 
>>         if (event->pending_wakeup) {
>>                 event->pending_wakeup = 0;
>>                 perf_event_wakeup(event);
>>         }
>> 
>>         if (rctx >= 0)
>>                 perf_swevent_put_recursion_context(rctx);
>> }
>> 
>> One side-effect of perf_event_wakeup() is to generate a sched_waking
>> event. But I suspect it won't be traced by perf because it is invoked before
>> putting the recursion context.
>> 
>> Is there a reason why the wakeup is done before putting the recursion
>> context ?
> 
> d525211f9d1b ("perf: Fix irq_work 'tail' recursion")
> 
> If we were to allow perf_event_wakeup() to generate its tracepoint, we'd
> be back to square #1, no?

Considering that perf tracing code has side-effects that generate additional
events, it's indeed best not to trace them, otherwise you indeed end up with
tail recursion.

Can ftrace end up in the same situation through rb_wake_up_waiters() ? I suspect
the tail recursion would be hard to trigger if the wakeup only happens once per
page though, unless the events generated end up filling up a page.

FWIW, LTTng avoids this entire issue by using a timer-based polling mechanism
to ensure the tracing code does not call into the scheduler wakeup.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
