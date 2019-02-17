Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04835C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA7521855
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="b/7atfhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfBQVes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:34:48 -0500
Received: from mail.efficios.com ([167.114.142.138]:59264 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 16:34:47 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 66F5FB01CF;
        Sun, 17 Feb 2019 16:34:46 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id B4i_jpg6hUkC; Sun, 17 Feb 2019 16:34:45 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A54D1B01C5;
        Sun, 17 Feb 2019 16:34:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A54D1B01C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1550439285;
        bh=T18Qw708dB0BnK7q8iTnLQdVkgK64GBo0LL8NiTO72I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=b/7atfhU18HztJLfUTJopRQmotrm/PStvUuUVz7ud/YgLnUPfBCW8hQKUtJNtqAel
         Setz0umLAT3EvKb8gIhJTk3TtzxsVnp/BuTtXnxPmbc5zjBGCvSjnqrRzUsB2HiLyI
         Sn8ZyBpxxpnQAqNBUthp4l9xzlpvulBKYRgEBjCBu4lpY6JKAEUb+zYHfrfrCJjDFM
         mgLszATJMcLSLqNRojjmMpSifKpsAec0AELcjxeFS0KAlDzbxETWhr6F+WHOcPVZ1X
         +/LX2JxY1vmfwuhpQZ5QyvQ/VbW6JiNZt3LgWQOK+2HQ5uCDRpLuZl3HdyJPrMRrEY
         4BUgwqPvDGoDw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id UCc0LLYZi81N; Sun, 17 Feb 2019 16:34:45 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 898A6B01A1;
        Sun, 17 Feb 2019 16:34:45 -0500 (EST)
Date:   Sun, 17 Feb 2019 16:34:45 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <53623603.9626.1550439285362.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190217184800.GA16118@brightrain.aerifal.cx>
References: <20190217184800.GA16118@brightrain.aerifal.cx>
Subject: Re: Regression in SYS_membarrier expedited
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3758 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: Regression in SYS_membarrier expedited
Thread-Index: br5NjTsDa2Js+yBSU/EoDUxXvbyEdw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 17, 2019, at 1:48 PM, Rich Felker dalias@libc.org wrote:

> commit a961e40917fb14614d368d8bc9782ca4d6a8cd11 made it so that the
> MEMBARRIER_CMD_PRIVATE_EXPEDITED command cannot be used without first
> registering intent to use it. However, registration is an expensive
> operation since commit 3ccfebedd8cf54e291c809c838d8ad5cc00f5688, which
> added synchronize_sched() to it; this means it's no longer possible to
> lazily register intent at first use, and it's unreasonably expensive
> to preemptively register intent for possibly extremely-short-lived
> processes that will never use it. (My usage case is in libc (musl),
> where I can't know if the process will be short- or long-lived;
> unnecessary and potentially expensive syscalls can't be made
> preemptively, only lazily at first use.)
> 
> Can we restore the functionality of MEMBARRIER_CMD_PRIVATE_EXPEDITED
> to work even without registration? The motivation of requiring
> registration seems to be:
> 
>    "Registering at this time removes the need to interrupt each and
>    every thread in that process at the first expedited
>    sys_membarrier() system call."
> 
> but interrupting every thread in the process is exactly what I expect,
> and is not a problem. What does seem like a big problem is waiting for
> synchronize_sched() to synchronize with an unboundedly large number of
> cores (vs only a few threads in the process), especially in the
> presence of full_nohz, where it seems like latency would be at least a
> few ms and possibly unbounded.
> 
> Short of a working SYS_membarrier that doesn't require expensive
> pre-registration, I'm stuck just implementing it in userspace with
> signals...

Hi Rich,

Let me try to understand the scenario first.

musl libc support for using membarrier private expedited
would require to first register membarrier private expedited for
the process at musl library init (typically after exec). At that stage, the
process is still single-threaded, right ? So there is no reason
to issue a synchronize_sched() (or now synchronize_rcu() in newer
kernels):

membarrier_register_private_expedited()

        if (!(atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)) {
                /*
                 * Ensure all future scheduler executions will observe the
                 * new thread flag state for this process.
                 */
                synchronize_rcu();
        }

So considering that pre-registration carefully done before the process
becomes multi-threaded just costs a system call (and not a synchronize_sched()),
does it make the pre-registration approach more acceptable ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
