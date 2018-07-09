Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ECCC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9E9208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZGimXEMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9E9208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933412AbeGIVfh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:35:37 -0400
Received: from mail.efficios.com ([167.114.142.138]:39964 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeGIVfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:35:36 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 34326232AD1;
        Mon,  9 Jul 2018 17:35:35 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id fZXA1iYc0EI8; Mon,  9 Jul 2018 17:35:34 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 778AA232ACA;
        Mon,  9 Jul 2018 17:35:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 778AA232ACA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531172134;
        bh=qRun2pRhBv+s/bzI2lJZOhz8DSBjQXe+Fa5Zhn5Rz+k=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZGimXEMAdn3gDSXRqPiHS6vZ5i7AF7lasVg58ffZunAKfXWExfkcQX2fr7uoSf7ru
         d6T2ONFWINfRyeo2pvewW7t/sCr442VFvVzNio9vMVWXcNB1FHqNCG/vczSGLx8Ahg
         xZpJtJ6NXOiN1fJg1nxpx7HPHDlTmHJptjb8cxdu25hzbjv+zY1nvWf0oVa9T/YNLA
         8+cwJ7zDTXb4oavV6Xsyix4D+HktjQ+arh2wlBna3KiiPw7tyF8sT4Azozlz6lS6h/
         7wmkdnWkHDg5/V0jIEaBDVvo2fFExqMvJ64psyVf5NHPxj+wxhI6x4bX8P31V/cGWf
         l36B/pRtpWTOA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id s6V6nCzrzRRW; Mon,  9 Jul 2018 17:35:34 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 60726232AC3;
        Mon,  9 Jul 2018 17:35:34 -0400 (EDT)
Date:   Mon, 9 Jul 2018 17:35:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        Daniel Colascione <dancol@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, fengc <fengc@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <566257859.2699.1531172134285.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
References: <20180707015616.25988-1-dancol@google.com> <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com> <20180707203340.GA74719@joelaf.mtv.corp.google.com> <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com> <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Add BPF_SYNCHRONIZE bpf(2) command
Thread-Index: +KIGmNyUw1xOtPrYtR2vfnWh1xjChA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Jul 9, 2018, at 5:09 PM, Alexei Starovoitov alexei.starovoitov@gmail.com wrote:

> On Sun, Jul 08, 2018 at 04:54:38PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jul 7, 2018, at 4:33 PM, Joel Fernandes joelaf@google.com wrote:
>> 
>> > On Fri, Jul 06, 2018 at 07:54:28PM -0700, Alexei Starovoitov wrote:
>> >> On Fri, Jul 06, 2018 at 06:56:16PM -0700, Daniel Colascione wrote:
>> >> > BPF_SYNCHRONIZE waits for any BPF programs active at the time of
>> >> > BPF_SYNCHRONIZE to complete, allowing userspace to ensure atomicity of
>> >> > RCU data structure operations with respect to active programs. For
>> >> > example, userspace can update a map->map entry to point to a new map,
>> >> > use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
>> >> > complete, and then drain the old map without fear that BPF programs
>> >> > may still be updating it.
>> >> > 
>> >> > Signed-off-by: Daniel Colascione <dancol@google.com>
>> >> > ---
>> >> >  include/uapi/linux/bpf.h |  1 +
>> >> >  kernel/bpf/syscall.c     | 14 ++++++++++++++
>> >> >  2 files changed, 15 insertions(+)
>> >> > 
>> >> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> >> > index b7db3261c62d..4365c50e8055 100644
>> >> > --- a/include/uapi/linux/bpf.h
>> >> > +++ b/include/uapi/linux/bpf.h
>> >> > @@ -98,6 +98,7 @@ enum bpf_cmd {
>> >> >  	BPF_BTF_LOAD,
>> >> >  	BPF_BTF_GET_FD_BY_ID,
>> >> >  	BPF_TASK_FD_QUERY,
>> >> > +	BPF_SYNCHRONIZE,
>> >> >  };
>> >> >  
>> >> >  enum bpf_map_type {
>> >> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> >> > index d10ecd78105f..60ec7811846e 100644
>> >> > --- a/kernel/bpf/syscall.c
>> >> > +++ b/kernel/bpf/syscall.c
>> >> > @@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *,
>> >> > uattr, unsigned int, siz
>> >> >  	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
>> >> >  		return -EPERM;
>> >> >  
>> >> > +	if (cmd == BPF_SYNCHRONIZE) {
>> >> > +		if (uattr != NULL || size != 0)
>> >> > +			return -EINVAL;
>> >> > +		err = security_bpf(cmd, NULL, 0);
>> >> > +		if (err < 0)
>> >> > +			return err;
>> >> > +		/* BPF programs are run with preempt disabled, so
>> >> > +		 * synchronize_sched is sufficient even with
>> >> > +		 * RCU_PREEMPT.
>> >> > +		 */
>> >> > +		synchronize_sched();
>> >> > +		return 0;
>> >> 
>> >> I don't think it's necessary. sys_membarrier() can do this already
>> >> and some folks use it exactly for this use case.
>> > 
>> > Alexei, the use of sys_membarrier for this purpose seems kind of weird to me
>> > though. No where does the manpage say membarrier should be implemented this
>> > way so what happens if the implementation changes?
>> > 
>> > Further, membarrier manpage says that a memory barrier should be matched with
>> > a matching barrier. In this use case there is no matching barrier, so it
>> > makes it weirder.
>> > 
>> > Lastly, sys_membarrier seems will not work on nohz-full systems, so its a bit
>> > fragile to depend on it for this?
>> > 
>> >        case MEMBARRIER_CMD_GLOBAL:
>> >                /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_full. */
>> >                if (tick_nohz_full_enabled())
>> >                        return -EINVAL;
>> >                if (num_online_cpus() > 1)
>> >                        synchronize_sched();
>> >                return 0;
>> > 
>> > 
>> > Adding Mathieu as well who I believe is author/maintainer of membarrier.
>> 
>> See commit 907565337
>> "Fix: Disable sys_membarrier when nohz_full is enabled"
>> 
>> "Userspace applications should be allowed to expect the membarrier system
>> call with MEMBARRIER_CMD_SHARED command to issue memory barriers on
>> nohz_full CPUs, but synchronize_sched() does not take those into
>> account."
>> 
>> So AFAIU you'd want to re-use membarrier to issue synchronize_sched, and you
>> only care about kernel preempt off critical sections.
>> 
>> Clearly bpf code does not run in user-space, so it would "work".
>> 
>> But the guarantees provided by membarrier are not to synchronize against
>> preempt off per se. It's just that the current implementation happens to
>> do that. The point of membarrier is to turn user-space memory barriers
>> into compiler barriers.
>> 
>> If what you need is to wait for a RCU grace period for whatever RCU flavor
>> ebpf is using, I would against using membarrier for this. I would rather
>> recommend adding a dedicated BPF_SYNCHRONIZE so you won't leak
>> implementation details to user-space, *and* you can eventually change you
>> RCU implementation for e.g. SRCU in the future if needed.
> 
> The point about future changes to underlying bpf mechanisms is valid.
> There is work already on the way to reduce the scope of preempt_off+rcu_lock
> that currently lasts the whole prog. We will have new prog types that won't
> have such wrappers and will do rcu_lock/unlock and preempt on/off only
> when necessary.
> So something like BPF_SYNCHRONIZE will break soon, since the kernel cannot have
> guarantees on when programs finish. Calling this command BPF_SYNCHRONIZE_PROG
> also won't make sense for the same reason.
> What we can do it instead is to define synchronization barrier for
> programs accessing maps. May be call it something like:
> BPF_SYNC_MAP_ACCESS ?
> uapi/bpf.h would need to have extensive comment what this barrier is doing.
> Implementation should probably call synchronize_rcu() and not play games
> with synchronize_sched(), since that's going too much into implementation.
> Also should such sys_bpf command be root only?
> I'm not sure whether dos attack can be made by spamming synchronize_rcu()
> and synchronize_sched() for that matter.

Adding Paul E. McKenney in CC. He may want to share his thoughts on the matter.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
