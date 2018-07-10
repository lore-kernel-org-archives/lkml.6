Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E7EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66FA20881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vk3VU34b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66FA20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933468AbeGJQ5u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:57:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37194 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754280AbeGJQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:57:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id x10-v6so6635551pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8PV/RswBVqqk3wyxX7HBEZHFlzepdAnLP5yAvq+00ts=;
        b=Vk3VU34bdoGqh4R+YHo+31XCQRqbfQOcK+j+QFKws0XVducoAVkoG8G+CYi6PQ8N98
         xhCv1nT1v5xLRaxhe9WxWa5NDd4v6Clmr0J146V+ckAwMMuCJPmLrmVsJ1j/IxUKD2Js
         R4mjqcIc/cWJEkRpiZysu3MM2asWnkZUES01apwwXpt7cF3aVd6xA2eifczHDE1Bf94L
         XJbLLq314rRFlEZb822BRBiimttuYQJysq3rltoaPy/UbW5QssyiQESGcEH9vlGNedq6
         wc2WFwwtLTu0jGpGTmDTtq2IgbYT1riY7f3YcqgXE+7r+n9b+EXvjWry9QwcRqbEKWOf
         2UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8PV/RswBVqqk3wyxX7HBEZHFlzepdAnLP5yAvq+00ts=;
        b=Lh/AnEg+YLqU4AgV6dktF0Zm3tPKU2rWRw0sPFFp9lfRdeOmJqhgp9/FkwbF5Sd7kY
         AFF97MQaBZh6wPTp0kJ07p1ZTf1nOS5VXhI5H7RpecjyGOEjl3ClnrK126gwrjcS9PD0
         Wo3BhHy/rOJ4rBuE7WF932rdbVnro50jh0FbXQRv2tDGg3uUFzusmQGQztLDwLSlNL/5
         NR2BCrdOH1JaXzEd9IWdpJZcy8WkJ78YUQoIWqUYl6eJi4VVOttL/jxgGeuDw648xWuP
         R8bUXi0oYr1HnSrjy4IybYQzIobtHFjNoxvJ5ulk+sN1pSBdN1lXBDxB1mc8WchWrlKU
         fOEw==
X-Gm-Message-State: APt69E1QoE1xBh6uiG2blZiGIKT6odCDIVxrAnTWnWt0NhzD1P9F/oR5
        NRP/1oORI0DetncqZk5e+IOQqQ==
X-Google-Smtp-Source: AAOMgpfjUxlMD2VWIeLez7g+VV+8CXEX02qnMD158oLxMAi76numq1pb+RVvyf2F+VjvKQJdAQUd7A==
X-Received: by 2002:a62:1314:: with SMTP id b20-v6mr1637800pfj.230.1531241865727;
        Tue, 10 Jul 2018 09:57:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id h132-v6sm28583772pfc.100.2018.07.10.09.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 09:57:44 -0700 (PDT)
Date:   Tue, 10 Jul 2018 09:57:44 -0700
From:   Joel Fernandes <joelaf@google.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, fengc@google.com
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Message-ID: <20180710165744.GA99146@joelaf.mtv.corp.google.com>
References: <20180707015616.25988-1-dancol@google.com>
 <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
 <20180707203340.GA74719@joelaf.mtv.corp.google.com>
 <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180710051347.GA180724@joelaf.mtv.corp.google.com>
 <20180710164212.GY3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710164212.GY3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 09:42:12AM -0700, Paul E. McKenney wrote:
> On Mon, Jul 09, 2018 at 10:13:47PM -0700, Joel Fernandes wrote:
> > On Sun, Jul 08, 2018 at 04:54:38PM -0400, Mathieu Desnoyers wrote:
> > > ----- On Jul 7, 2018, at 4:33 PM, Joel Fernandes joelaf@google.com wrote:
> > > 
> > > > On Fri, Jul 06, 2018 at 07:54:28PM -0700, Alexei Starovoitov wrote:
> > > >> On Fri, Jul 06, 2018 at 06:56:16PM -0700, Daniel Colascione wrote:
> > > >> > BPF_SYNCHRONIZE waits for any BPF programs active at the time of
> > > >> > BPF_SYNCHRONIZE to complete, allowing userspace to ensure atomicity of
> > > >> > RCU data structure operations with respect to active programs. For
> > > >> > example, userspace can update a map->map entry to point to a new map,
> > > >> > use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
> > > >> > complete, and then drain the old map without fear that BPF programs
> > > >> > may still be updating it.
> > > >> > 
> > > >> > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > >> > ---
> > > >> >  include/uapi/linux/bpf.h |  1 +
> > > >> >  kernel/bpf/syscall.c     | 14 ++++++++++++++
> > > >> >  2 files changed, 15 insertions(+)
> > > >> > 
> > > >> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > >> > index b7db3261c62d..4365c50e8055 100644
> > > >> > --- a/include/uapi/linux/bpf.h
> > > >> > +++ b/include/uapi/linux/bpf.h
> > > >> > @@ -98,6 +98,7 @@ enum bpf_cmd {
> > > >> >  	BPF_BTF_LOAD,
> > > >> >  	BPF_BTF_GET_FD_BY_ID,
> > > >> >  	BPF_TASK_FD_QUERY,
> > > >> > +	BPF_SYNCHRONIZE,
> > > >> >  };
> > > >> >  
> > > >> >  enum bpf_map_type {
> > > >> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > >> > index d10ecd78105f..60ec7811846e 100644
> > > >> > --- a/kernel/bpf/syscall.c
> > > >> > +++ b/kernel/bpf/syscall.c
> > > >> > @@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *,
> > > >> > uattr, unsigned int, siz
> > > >> >  	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
> > > >> >  		return -EPERM;
> > > >> >  
> > > >> > +	if (cmd == BPF_SYNCHRONIZE) {
> > > >> > +		if (uattr != NULL || size != 0)
> > > >> > +			return -EINVAL;
> > > >> > +		err = security_bpf(cmd, NULL, 0);
> > > >> > +		if (err < 0)
> > > >> > +			return err;
> > > >> > +		/* BPF programs are run with preempt disabled, so
> > > >> > +		 * synchronize_sched is sufficient even with
> > > >> > +		 * RCU_PREEMPT.
> > > >> > +		 */
> > > >> > +		synchronize_sched();
> > > >> > +		return 0;
> > > >> 
> > > >> I don't think it's necessary. sys_membarrier() can do this already
> > > >> and some folks use it exactly for this use case.
> > > > 
> > > > Alexei, the use of sys_membarrier for this purpose seems kind of weird to me
> > > > though. No where does the manpage say membarrier should be implemented this
> > > > way so what happens if the implementation changes?
> > > > 
> > > > Further, membarrier manpage says that a memory barrier should be matched with
> > > > a matching barrier. In this use case there is no matching barrier, so it
> > > > makes it weirder.
> > > > 
> > > > Lastly, sys_membarrier seems will not work on nohz-full systems, so its a bit
> > > > fragile to depend on it for this?
> > > > 
> > > >        case MEMBARRIER_CMD_GLOBAL:
> > > >                /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_full. */
> > > >                if (tick_nohz_full_enabled())
> > > >                        return -EINVAL;
> > > >                if (num_online_cpus() > 1)
> > > >                        synchronize_sched();
> > > >                return 0;
> > > > 
> > > > 
> > > > Adding Mathieu as well who I believe is author/maintainer of membarrier.
> > > 
> > > See commit 907565337
> > > "Fix: Disable sys_membarrier when nohz_full is enabled"
> > > 
> > > "Userspace applications should be allowed to expect the membarrier system
> > > call with MEMBARRIER_CMD_SHARED command to issue memory barriers on
> > > nohz_full CPUs, but synchronize_sched() does not take those into
> > > account."
> > > 
> > > So AFAIU you'd want to re-use membarrier to issue synchronize_sched, and you
> > > only care about kernel preempt off critical sections.
> > 
> > Mathieu, Thanks a lot for your reply. I understand what you said and agree
> > with you. Slight OT, but I tried to go back to first principles and
> > understand how membarrier() uses synchronize_sched() for the "slow path" and
> > it didn't make immediate sense to me. Let me clarify my dillema..
> > 
> > My understanding is membarrier's MEMBARRIER_CMD_GLOBAL will employ
> > synchronize_sched to make sure all other CPUs aren't executing anymore in an
> > section of usercode that happen to be accessing memory that was written to
> > before the membarrier call was made. To do this, the system call will use
> > synchronize_sched to try to guarantee that all user-mode execution that
> > started before the membarrier call would be completed when the membarrier
> > call returns. This guarantees that without using a real memory barrier on the
> > "fast path", things work just fine and everyone wins.
> > 
> > But, going through RCU code, I see that a "RCU-sched quiecent state" on a CPU
> > may be reached when the CPU receives a timer tick while executing in user
> > mode:
> > 
> > void rcu_check_callbacks(int user)
> > {
> > 	trace_rcu_utilization(TPS("Start scheduler-tick"));
> > 	increment_cpu_stall_ticks();
> > 	if (user || rcu_is_cpu_rrupt_from_idle()) {
> > [...]
> > 		rcu_sched_qs();
> > 		rcu_bh_qs();
> > 
> > The problem I see is the CPU could be executing usermode code at the time of
> > the RCU sched-QS. This IMO is enough reason for synchronize_sched() to
> > return, because the CPU in question just reported a QS (assuming all other
> > CPUs also happen to do so if they needed to).
> 
> This scenario will have inserted the needed smp_mb() into the userspace
> instruction execution stream, as is required by the sys_membarrier
> use cases.

Oh ok, that makes sense!

> > Then I am wondering how does the membarrier call even work, the tick could
> > very well have interrupted the CPU while it was executing usermode code in
> > the middle of a set of instructions performing memory accesses. Reporting a
> > quiescent state at such an inopportune time would cause the membarrier call
> > to prematurely return, no? Sorry if I missed something.
> 
> One way to think of sys_membarrier() is as something that promotes a
> barrier() to an smp_mb().  This barrier then separates the target CPU's
> accesses that the caller saw before the sys_membarrier() from that same
> CPU's accesses that the caller will see after the sys_membarrier().

Got it!

> > The other question I have is about the whole "nohz-full doesn't work" thing.
> > I didn't fully understand why. RCU is already tracking the state of nohz-full
> > CPUs because the rcu dynticks code in (kernel/rcu/tree.c) monitors
> > transitions to and from usermode even if the timer tick is turned off. So why
> > would it not work?
> 
> In the nohz_full case, there is no need for sys_membarrier()'s call to
> synchronize_sched() to interact directly with the nohz_full CPU.  It
> can instead look at the target CPU's dyntick-idle state, and that state
> would potentially have been set in the dim distant past, thus having
> no effect on the target CPU's current execution.

In nohz-idle case though, there's nothing to promote the barrier() to
smp_mb() if you were to purely look at the dynticks-idle state on the
nohz-full CPU executing in user mode?

So then it makes sense to me now that nohz-full needs something to IPI that
CPU inorder to enforce the needed memory barrier and pure synchronize_sched()
wouldn't work. So then makes me think the expedited versions of
synchronize_sched should be able to do the job but I could off on a different
track..

Thanks a lot,

-Joel


