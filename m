Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB02BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9143A20871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QLJd7yXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9143A20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389762AbeGKQpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:45:30 -0400
Received: from mail.efficios.com ([167.114.142.138]:52712 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbeGKQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:45:29 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2646222F596;
        Wed, 11 Jul 2018 12:40:20 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id HzLPm_x9K5cA; Wed, 11 Jul 2018 12:40:19 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9F7E522F590;
        Wed, 11 Jul 2018 12:40:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9F7E522F590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531327219;
        bh=+cBKhXzsfRXxoU5kRdAUhpnNn168f41p//TagJZNI+4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QLJd7yXDVOn+/uYwGnqbx40RTfxF9hQLvlSf/1sIslz4Mp1HfZtgB4pNW++2fIt0U
         RB4FB2e7x1Ilp7auJZKBCTvo+WRF8bjmSSZj15+rIXLEb/WvxqWEF4ZdgMVUnoCol8
         X+ig+8mWWu6WWtclcuKVAystG3mu2HK5rjUIl/WjZ9d+0Vm/heR+f2qtVMPP1/NUcF
         AAM18mQX3vqvpv0EU5p709rUpgLA0C9Uepmnipdduf5XF8qjUDjrbDCOi0wEOGW1HV
         8lCnNZ3K4QPFxVKIlKT3kMZZs5Ne/GRoeZXK0MIzuPHk2kYNVV6rVMlJJDfNFsuLwi
         U/WaZhKBKG+Iw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id JG_CzDGBuopO; Wed, 11 Jul 2018 12:40:19 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 8946422F58A;
        Wed, 11 Jul 2018 12:40:19 -0400 (EDT)
Date:   Wed, 11 Jul 2018 12:40:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Message-ID: <1447856878.4127.1531327219355.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180711151751.GI2476@hirez.programming.kicks-ass.net>
References: <20180628182149.226164-1-joel@joelfernandes.org> <20180628182149.226164-5-joel@joelfernandes.org> <20180711125647.GG2476@hirez.programming.kicks-ass.net> <20180711090649.68af40f9@gandalf.local.home> <20180711151751.GI2476@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use
 SRCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: tracepoint: Make rcuidle tracepoint callers use SRCU
Thread-Index: ILWgSY2udbNb/YjbSwAj6wHvbsKD5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 11, 2018, at 11:17 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Jul 11, 2018 at 09:06:49AM -0400, Steven Rostedt wrote:
>> On Wed, 11 Jul 2018 14:56:47 +0200
>> Peter Zijlstra <peterz@infradead.org> wrote:
>> 
>> > On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:
>> > >  static inline void tracepoint_synchronize_unregister(void)
>> > >  {
>> > > +	synchronize_srcu(&tracepoint_srcu);
>> > >  	synchronize_sched();
>> > >  }
>> > 
>> > Given you below do call_rcu_sched() and then call_srcu(), isn't the
>> > above the wrong way around?
>> 
>> Good catch!
>> 
>> 	release_probes()
>> 		call_rcu_sched()
>> 			---> rcu_free_old_probes() queued
>> 
>> 	tracepoint_synchronize_unregister()
>> 		synchronize_srcu(&tracepoint_srcu);
>> 			< finishes right away >
>> 		synchronize_sched()
>> 			--> rcu_free_old_probes()
>> 				--> srcu_free_old_probes() queued
>> 	
>> Here tracepoint_synchronize_unregister() returned before the srcu
>> portion ran.
> 
> I just read the comment that goes with that function; the order doesn't
> matter. All we want to ensure is that the unregistration is visible to
> either sched or srcu tracepoint users.

Exactly, the order does not matter here.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
