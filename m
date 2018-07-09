Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B083C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1919320878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIW6FChH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1919320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbeGIVJu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:09:50 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34570 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933003AbeGIVJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:09:48 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so6577499plo.1;
        Mon, 09 Jul 2018 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n9qxbVFd0QRRMX33mYtgl+AqJd8G5AzB6jdGvLcLpaw=;
        b=uIW6FChHtgtZGuV3ZWOztsTQV4iTCSYXV3l2ZyEnVwHSNp6bX+0+6d+hZgA1UFOKBc
         e4Xaxro/E3klrlx1MgdROnfI+mP5Bsoz28V8kzeFkRyeJHILH2gPOqMHrw4qPpIeJx2x
         MRVPlr9CezKzc5DlPg4lV5qd3iroRS1+IAZLZ0NybQ8Vd1cd4xE96ZgUytcGZNFYbCyj
         WGT+2kWrNuA1XYRxkWDQ8r2VF06KerJjsn0eH6ukb4KIGtcMEBV41D7r0R1zHJj+3M5n
         x5MOYQzgj9kwOVhzCFxkf3a0wFXiC5PmyaFSe5RuZnxk61ERnBnjpTs131beLWqrkzDE
         +Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n9qxbVFd0QRRMX33mYtgl+AqJd8G5AzB6jdGvLcLpaw=;
        b=ETeYMzyspdlCmb+QWc1OUbnNzFuT1Jmgvjf5fR+4VCfJTSiu+ouXvHDNGZZd3m9vPS
         9lRq7y6SM0EC/EY5YDb5R9hffQPQUfGencl8ctvlxp99OvQgDVMBDO95t9Cgt8OgNWkm
         Kla5/gK7uCjEsa51BONedl3hv3V6Mo0RcozhocHTI3QxVFEiXwHr1kjGi1W0yvtiObZI
         ui+UZW/v4awGwPQNbrHXWGGsi+xNOawnKF7YJKuswZJkf+GvLsx2uWeEdDhQo5OOZYGV
         zhnyIYN57qy3FnbLHP0PXLCwmxtbRF3hOgDnFKiq+DZKtkD1A2pUcpZofJQnz2qhPkC/
         boGQ==
X-Gm-Message-State: APt69E3RTIiE010gbWkuFfGIfHl+mqtt8LGxk9U1mjlwbC96jBhGPJ/O
        772VNRL3GamnXp+2coatipU=
X-Google-Smtp-Source: AAOMgpdCuJXt+UDQu5nqf5XIZTVbvLgxvaQr97RAU5k6LKzANviBlEjTMAILgvNmCpw5m9VVY+UQqw==
X-Received: by 2002:a17:902:22e:: with SMTP id 43-v6mr22408604plc.82.1531170588247;
        Mon, 09 Jul 2018 14:09:48 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::7:7b66])
        by smtp.gmail.com with ESMTPSA id c19-v6sm24998689pfn.182.2018.07.09.14.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 14:09:47 -0700 (PDT)
Date:   Mon, 9 Jul 2018 14:09:46 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        Daniel Colascione <dancol@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, fengc@google.com
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Message-ID: <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
References: <20180707015616.25988-1-dancol@google.com>
 <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
 <20180707203340.GA74719@joelaf.mtv.corp.google.com>
 <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 04:54:38PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 7, 2018, at 4:33 PM, Joel Fernandes joelaf@google.com wrote:
> 
> > On Fri, Jul 06, 2018 at 07:54:28PM -0700, Alexei Starovoitov wrote:
> >> On Fri, Jul 06, 2018 at 06:56:16PM -0700, Daniel Colascione wrote:
> >> > BPF_SYNCHRONIZE waits for any BPF programs active at the time of
> >> > BPF_SYNCHRONIZE to complete, allowing userspace to ensure atomicity of
> >> > RCU data structure operations with respect to active programs. For
> >> > example, userspace can update a map->map entry to point to a new map,
> >> > use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
> >> > complete, and then drain the old map without fear that BPF programs
> >> > may still be updating it.
> >> > 
> >> > Signed-off-by: Daniel Colascione <dancol@google.com>
> >> > ---
> >> >  include/uapi/linux/bpf.h |  1 +
> >> >  kernel/bpf/syscall.c     | 14 ++++++++++++++
> >> >  2 files changed, 15 insertions(+)
> >> > 
> >> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> > index b7db3261c62d..4365c50e8055 100644
> >> > --- a/include/uapi/linux/bpf.h
> >> > +++ b/include/uapi/linux/bpf.h
> >> > @@ -98,6 +98,7 @@ enum bpf_cmd {
> >> >  	BPF_BTF_LOAD,
> >> >  	BPF_BTF_GET_FD_BY_ID,
> >> >  	BPF_TASK_FD_QUERY,
> >> > +	BPF_SYNCHRONIZE,
> >> >  };
> >> >  
> >> >  enum bpf_map_type {
> >> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> > index d10ecd78105f..60ec7811846e 100644
> >> > --- a/kernel/bpf/syscall.c
> >> > +++ b/kernel/bpf/syscall.c
> >> > @@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *,
> >> > uattr, unsigned int, siz
> >> >  	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
> >> >  		return -EPERM;
> >> >  
> >> > +	if (cmd == BPF_SYNCHRONIZE) {
> >> > +		if (uattr != NULL || size != 0)
> >> > +			return -EINVAL;
> >> > +		err = security_bpf(cmd, NULL, 0);
> >> > +		if (err < 0)
> >> > +			return err;
> >> > +		/* BPF programs are run with preempt disabled, so
> >> > +		 * synchronize_sched is sufficient even with
> >> > +		 * RCU_PREEMPT.
> >> > +		 */
> >> > +		synchronize_sched();
> >> > +		return 0;
> >> 
> >> I don't think it's necessary. sys_membarrier() can do this already
> >> and some folks use it exactly for this use case.
> > 
> > Alexei, the use of sys_membarrier for this purpose seems kind of weird to me
> > though. No where does the manpage say membarrier should be implemented this
> > way so what happens if the implementation changes?
> > 
> > Further, membarrier manpage says that a memory barrier should be matched with
> > a matching barrier. In this use case there is no matching barrier, so it
> > makes it weirder.
> > 
> > Lastly, sys_membarrier seems will not work on nohz-full systems, so its a bit
> > fragile to depend on it for this?
> > 
> >        case MEMBARRIER_CMD_GLOBAL:
> >                /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_full. */
> >                if (tick_nohz_full_enabled())
> >                        return -EINVAL;
> >                if (num_online_cpus() > 1)
> >                        synchronize_sched();
> >                return 0;
> > 
> > 
> > Adding Mathieu as well who I believe is author/maintainer of membarrier.
> 
> See commit 907565337
> "Fix: Disable sys_membarrier when nohz_full is enabled"
> 
> "Userspace applications should be allowed to expect the membarrier system
> call with MEMBARRIER_CMD_SHARED command to issue memory barriers on
> nohz_full CPUs, but synchronize_sched() does not take those into
> account."
> 
> So AFAIU you'd want to re-use membarrier to issue synchronize_sched, and you
> only care about kernel preempt off critical sections.
> 
> Clearly bpf code does not run in user-space, so it would "work".
> 
> But the guarantees provided by membarrier are not to synchronize against
> preempt off per se. It's just that the current implementation happens to
> do that. The point of membarrier is to turn user-space memory barriers
> into compiler barriers.
> 
> If what you need is to wait for a RCU grace period for whatever RCU flavor
> ebpf is using, I would against using membarrier for this. I would rather
> recommend adding a dedicated BPF_SYNCHRONIZE so you won't leak
> implementation details to user-space, *and* you can eventually change you
> RCU implementation for e.g. SRCU in the future if needed.

The point about future changes to underlying bpf mechanisms is valid.
There is work already on the way to reduce the scope of preempt_off+rcu_lock
that currently lasts the whole prog. We will have new prog types that won't
have such wrappers and will do rcu_lock/unlock and preempt on/off only
when necessary.
So something like BPF_SYNCHRONIZE will break soon, since the kernel cannot have
guarantees on when programs finish. Calling this command BPF_SYNCHRONIZE_PROG
also won't make sense for the same reason.
What we can do it instead is to define synchronization barrier for
programs accessing maps. May be call it something like:
BPF_SYNC_MAP_ACCESS ?
uapi/bpf.h would need to have extensive comment what this barrier is doing.
Implementation should probably call synchronize_rcu() and not play games
with synchronize_sched(), since that's going too much into implementation.
Also should such sys_bpf command be root only?
I'm not sure whether dos attack can be made by spamming synchronize_rcu()
and synchronize_sched() for that matter.

