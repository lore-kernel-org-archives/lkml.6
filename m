Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA6BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585DA214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vJyVVF8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfAJQoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:44:15 -0500
Received: from mail.efficios.com ([167.114.142.138]:56126 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfAJQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:44:15 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 52A31B0C22;
        Thu, 10 Jan 2019 11:44:14 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id YhAEWLt2O1qr; Thu, 10 Jan 2019 11:44:13 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 80DB4B0C1A;
        Thu, 10 Jan 2019 11:44:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 80DB4B0C1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547138653;
        bh=R+/w+GpaYvNjUejptQ7QWdzxvClF5SHCTfgBGBJCpqg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=vJyVVF8Ytv2VwOqQ8lVXbRDcQQWkqmR4BQt5nmLmj4MDS3FJMXfM46dsO87bNabDf
         TZYYVm212K6Cpn6OdrwYl9f5ifpkTWlcCTLvHBiFCEkOh7VoiuvM5xy9uh+Wp0VPmD
         YfFN72S7lJzZRywCM2gL+qMaqWVR4Icv03aToa0VRJF9ywyZmUnIFYqyg4rWUEb7zT
         HHQ1nrbl+FDcFBuhJppq2LWfarKs7FpLLxWhIAd/TFRnm5l2Iqup7AG0IdpQ255jn/
         NM9Yc3sdbWIrILLWI3EjMfr8HUzEc3L5sBTR+FiZb30RsXotasdtAJGlU1J8p+RppQ
         ldbXNMZCsdipQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id myrIqjdvBf_T; Thu, 10 Jan 2019 11:44:13 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 6CBC8B0C14;
        Thu, 10 Jan 2019 11:44:13 -0500 (EST)
Date:   Thu, 10 Jan 2019 11:44:13 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1884815641.993.1547138653377.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190110110839.7daeef3d@gandalf.local.home>
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com> <20190110110839.7daeef3d@gandalf.local.home>
Subject: Re: Possible use of RCU while in extended QS: idle vs RCU read-side
 in interrupt vs rcu_eqs_exit
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: Possible use of RCU while in extended QS: idle vs RCU read-side in interrupt vs rcu_eqs_exit
Thread-Index: 27wp/p4E6gUF7FLK8PORZvci3aR5Zw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 10, 2019, at 8:08 AM, rostedt rostedt@goodmis.org wrote:

> On Wed, 9 Jan 2019 20:38:51 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Hi Paul,
>> 
>> I've had a user report that trace_sched_waking() appears to be
>> invoked while !rcu_is_watching() in some situation, so I started
>> digging into the scheduler idle code.
> 
> I'm wondering if this isn't a bug. Do you have the backtrace for where
> trace_sched_waking() was called without rcu watching?

I strongly suspect a bug as well. I'm awaiting a reproducer from the
user whom reported this issue so I can add a WARN_ON_ONCE(!rcu_is_watching())
in the scheduler code near trace_sched_waking() and gather a backtrace.

It still has to be confirmed, but I suspect this have been triggered
within a HyperV guest. It may therefore be related to a virtualized environment.

I'll try to ask more specifically on which environment this was encountered.

Thanks,

Mathieu

> 
> -- Steve
> 
>> 
>> It appears that interrupts are re-enabled before rcu_eqs_exit() is
>> invoked when exiting idle code from the scheduler.
>> 
>> I wonder what happens if an interrupt handler (including scheduler code)
>> happens to issue a RCU read-side critical section before rcu_eqs_exit()
>> is called ? Is there some code on interrupt entry that ensures rcu eqs
>> state is exited in such scenario ?
>> 
>> Thanks,
>> 
>> Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
