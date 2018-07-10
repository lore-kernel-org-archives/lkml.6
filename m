Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CC5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658952098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8YmPLSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658952098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbeGJXyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:54:25 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:44754 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbeGJXyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:54:25 -0400
Received: by mail-pf0-f169.google.com with SMTP id j3-v6so17128782pfh.11;
        Tue, 10 Jul 2018 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=izjazoO16D2s11bs3Q5ibeRzxGdBC8FGZVlQ8tXHzuY=;
        b=C8YmPLSebEB/7CmrGUPWsn6YlyMp05R3A3dx4+d/kNQ3+Osn9314giiqlUeb+pUIGg
         LJaNKIjPTvgZgJfMb4oh9ydTnW1GGnrrAmgRsShBuQ/4CkLygPJ3wvsXINgzs3EJaW0L
         97QOdbSXicmYJQOiq9g84Pj3vk0ZSCn4Kqmop/eu3qT8ANem9UVXfL4dtUGf1q6V9DJ8
         9tSFXvw1xIzmsohA0b8EoQh2CViqy9lD3x+AMjrpX2nd5AzJlkCPIGXIlieosSRYfw+v
         BqMlC8Vg28cl3MXTRHM4gIpDAQqo6a/U4R9cXCii5iAQH1wRM+bbKjYX0E7IQb9FGzFc
         1IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=izjazoO16D2s11bs3Q5ibeRzxGdBC8FGZVlQ8tXHzuY=;
        b=kKSl7VSxDmz3wpbEYksgMmUBBEreSvVH3dmyKcGmHrLxQDmD0IBmOyY6ybHGboZhzX
         LV8M565i86pzvXPvlFr/O/+LztzasBFuGylavH5moBVVPC98Jx+toKYbnmxjgcM/9lwG
         BJPf5B3B7HzXGEjiurn5VMA2v+FZUFjZIzjJZ4KXWmLExCajPNc+yMM0AJVcv9x1zVRl
         0b+p4VqSLaW/VRuHSXQZYXl9dPsVzrA4SPVX4EhwUQBbcLQaCvMAU1L/H2pkqdrgl6GM
         AkLLSNcjybdIwRAOS0V+fJp6vWVxP6FSqx96dH0soVqSP95gQrURI8i2mQTkDSM18LFy
         AURg==
X-Gm-Message-State: APt69E3u7n4PwyLCz+QCMWjmO+Z4XVMhlO05fTdDO2RnTbdjTVsjBozQ
        dOXZ6nbzh9VO0iV9/lbN7IEjLvNI
X-Google-Smtp-Source: AAOMgpcfTWzyRCYyRQFvJPi+gccbYN9nUA8c2xqHZ8YTv5GP9riN1Ag5jfKqYMtsJjwZz90wYJvQMA==
X-Received: by 2002:a63:195e:: with SMTP id 30-v6mr22130619pgz.192.1531266776314;
        Tue, 10 Jul 2018 16:52:56 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::7:26ef])
        by smtp.gmail.com with ESMTPSA id 16-v6sm6391723pfp.6.2018.07.10.16.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 16:52:55 -0700 (PDT)
Date:   Tue, 10 Jul 2018 16:52:53 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Chenbo Feng <fengc@google.com>
Cc:     Daniel Colascione <dancol@google.com>,
        mathieu.desnoyers@efficios.com, Joel Fernandes <joelaf@google.com>,
        Alexei Starovoitov <ast@fb.com>, linux-kernel@vger.kernel.org,
        timmurray@google.com, Daniel Borkmann <daniel@iogearbox.net>,
        netdev@vger.kernel.org, Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Message-ID: <20180710235252.mioihpgtu4n3syaq@ast-mbp.dhcp.thefacebook.com>
References: <20180707015616.25988-1-dancol@google.com>
 <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
 <20180707203340.GA74719@joelaf.mtv.corp.google.com>
 <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuet+pjqM8zghmXYdA9f10bsYOzMuSQhSYXG5wbrNmFEqpQ@mail.gmail.com>
 <20180709221005.sintsjkle4xpkcyk@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuetaKNaJVWcu10ZcsiXiK4X+-2z3eFaz1pF8DSxdQ_mEnQ@mail.gmail.com>
 <20180709223439.uc2a6hyic35inwye@ast-mbp.dhcp.thefacebook.com>
 <CAMOXUJ=QmkjTqbWqPRxb=R7f6EpsHBkDQ4MhrSD=VPiDTj7RiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMOXUJ=QmkjTqbWqPRxb=R7f6EpsHBkDQ4MhrSD=VPiDTj7RiA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:25:04PM -0700, Chenbo Feng wrote:
> On Mon, Jul 9, 2018 at 3:34 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 09, 2018 at 03:21:43PM -0700, Daniel Colascione wrote:
> > > On Mon, Jul 9, 2018 at 3:10 PM, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Mon, Jul 09, 2018 at 02:36:37PM -0700, Daniel Colascione wrote:
> > > >> On Mon, Jul 9, 2018 at 2:09 PM, Alexei Starovoitov
> > > >> <alexei.starovoitov@gmail.com> wrote:
> > > >> > On Sun, Jul 08, 2018 at 04:54:38PM -0400, Mathieu Desnoyers wrote:
> > > >> >> ----- On Jul 7, 2018, at 4:33 PM, Joel Fernandes joelaf@google.com wrote:
> > > >> >>
> > > >> >> > On Fri, Jul 06, 2018 at 07:54:28PM -0700, Alexei Starovoitov wrote:
> > > >> >> >> On Fri, Jul 06, 2018 at 06:56:16PM -0700, Daniel Colascione wrote:
> > > >> >> >> > BPF_SYNCHRONIZE waits for any BPF programs active at the time of
> > > >> >> >> > BPF_SYNCHRONIZE to complete, allowing userspace to ensure atomicity of
> > > >> >> >> > RCU data structure operations with respect to active programs. For
> > > >> >> >> > example, userspace can update a map->map entry to point to a new map,
> > > >> >> >> > use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
> > > >> >> >> > complete, and then drain the old map without fear that BPF programs
> > > >> >> >> > may still be updating it.
> > > >> >> >> >
> > > >> >> >> > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > >> >> >> > ---
> > > >> >> >> >  include/uapi/linux/bpf.h |  1 +
> > > >> >> >> >  kernel/bpf/syscall.c     | 14 ++++++++++++++
> > > >> >> >> >  2 files changed, 15 insertions(+)
> > > >> >> >> >
> > > >> >> >> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > >> >> >> > index b7db3261c62d..4365c50e8055 100644
> > > >> >> >> > --- a/include/uapi/linux/bpf.h
> > > >> >> >> > +++ b/include/uapi/linux/bpf.h
> > > >> >> >> > @@ -98,6 +98,7 @@ enum bpf_cmd {
> > > >> >> >> >          BPF_BTF_LOAD,
> > > >> >> >> >          BPF_BTF_GET_FD_BY_ID,
> > > >> >> >> >          BPF_TASK_FD_QUERY,
> > > >> >> >> > +        BPF_SYNCHRONIZE,
> > > >> >> >> >  };
> > > >> >> >> >
> > > >> >> >> >  enum bpf_map_type {
> > > >> >> >> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > >> >> >> > index d10ecd78105f..60ec7811846e 100644
> > > >> >> >> > --- a/kernel/bpf/syscall.c
> > > >> >> >> > +++ b/kernel/bpf/syscall.c
> > > >> >> >> > @@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *,
> > > >> >> >> > uattr, unsigned int, siz
> > > >> >> >> >          if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
> > > >> >> >> >                  return -EPERM;
> > > >> >> >> >
> > > >> >> >> > +        if (cmd == BPF_SYNCHRONIZE) {
> > > >> >> >> > +                if (uattr != NULL || size != 0)
> > > >> >> >> > +                        return -EINVAL;
> > > >> >> >> > +                err = security_bpf(cmd, NULL, 0);
> > > >> >> >> > +                if (err < 0)
> > > >> >> >> > +                        return err;
> > > >> >> >> > +                /* BPF programs are run with preempt disabled, so
> > > >> >> >> > +                 * synchronize_sched is sufficient even with
> > > >> >> >> > +                 * RCU_PREEMPT.
> > > >> >> >> > +                 */
> > > >> >> >> > +                synchronize_sched();
> > > >> >> >> > +                return 0;
> > > >> >> >>
> > > >> >> >> I don't think it's necessary. sys_membarrier() can do this already
> > > >> >> >> and some folks use it exactly for this use case.
> > > >> >> >
> > > >> >> > Alexei, the use of sys_membarrier for this purpose seems kind of weird to me
> > > >> >> > though. No where does the manpage say membarrier should be implemented this
> > > >> >> > way so what happens if the implementation changes?
> > > >> >> >
> > > >> >> > Further, membarrier manpage says that a memory barrier should be matched with
> > > >> >> > a matching barrier. In this use case there is no matching barrier, so it
> > > >> >> > makes it weirder.
> > > >> >> >
> > > >> >> > Lastly, sys_membarrier seems will not work on nohz-full systems, so its a bit
> > > >> >> > fragile to depend on it for this?
> > > >> >> >
> > > >> >> >        case MEMBARRIER_CMD_GLOBAL:
> > > >> >> >                /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_full. */
> > > >> >> >                if (tick_nohz_full_enabled())
> > > >> >> >                        return -EINVAL;
> > > >> >> >                if (num_online_cpus() > 1)
> > > >> >> >                        synchronize_sched();
> > > >> >> >                return 0;
> > > >> >> >
> > > >> >> >
> > > >> >> > Adding Mathieu as well who I believe is author/maintainer of membarrier.
> > > >> >>
> > > >> >> See commit 907565337
> > > >> >> "Fix: Disable sys_membarrier when nohz_full is enabled"
> > > >> >>
> > > >> >> "Userspace applications should be allowed to expect the membarrier system
> > > >> >> call with MEMBARRIER_CMD_SHARED command to issue memory barriers on
> > > >> >> nohz_full CPUs, but synchronize_sched() does not take those into
> > > >> >> account."
> > > >> >>
> > > >> >> So AFAIU you'd want to re-use membarrier to issue synchronize_sched, and you
> > > >> >> only care about kernel preempt off critical sections.
> > > >> >>
> > > >> >> Clearly bpf code does not run in user-space, so it would "work".
> > > >> >>
> > > >> >> But the guarantees provided by membarrier are not to synchronize against
> > > >> >> preempt off per se. It's just that the current implementation happens to
> > > >> >> do that. The point of membarrier is to turn user-space memory barriers
> > > >> >> into compiler barriers.
> > > >> >>
> > > >> >> If what you need is to wait for a RCU grace period for whatever RCU flavor
> > > >> >> ebpf is using, I would against using membarrier for this. I would rather
> > > >> >> recommend adding a dedicated BPF_SYNCHRONIZE so you won't leak
> > > >> >> implementation details to user-space, *and* you can eventually change you
> > > >> >> RCU implementation for e.g. SRCU in the future if needed.
> > > >> >
> > > >> > The point about future changes to underlying bpf mechanisms is valid.
> > > >> > There is work already on the way to reduce the scope of preempt_off+rcu_lock
> > > >> > that currently lasts the whole prog. We will have new prog types that won't
> > > >> > have such wrappers and will do rcu_lock/unlock and preempt on/off only
> > > >> > when necessary.
> > > >> > So something like BPF_SYNCHRONIZE will break soon, since the kernel cannot have
> > > >> > guarantees on when programs finish. Calling this command BPF_SYNCHRONIZE_PROG
> > > >> > also won't make sense for the same reason.
> > > >> > What we can do it instead is to define synchronization barrier for
> > > >> > programs accessing maps. May be call it something like:
> > > >> > BPF_SYNC_MAP_ACCESS ?
> > > >>
> > > >> I'm not sure what you're proposing. In the case the commit message
> > > >> describes, a user-space program that wants to "drain" a map needs to
> > > >> be confident that the map won't change under it, even across multiple
> > > >> bpf system calls on that map. One way of doing that is to ensure that
> > > >> nothing that could possibly hold a reference to that map is still
> > > >> running. Are you proposing some kind of refcount-draining approach?
> > > >> Simple locking won't work, since BPF programs can't block, and I don't
> > > >> see right now how a simple barrier would help.
> > > >
> > > > I'm proposing few changes for your patch:
> > > > s/BPF_SYNCHRONIZE/BPF_SYNC_MAP_ACCESS/
> > > > and s/synchronize_sched/synchronize_rcu/
> > > > with detailed comment in uapi/bpf.h that has an example why folks
> > > > would want to use this new cmd.
> > >
> > > Thanks for clarifying.
> > >
> > > > I think the bpf maps will be rcu protected for foreseeable future
> > > > even when rcu_read_lock/unlock will be done by the programs instead of
> > > > kernel wrappers.
> > >
> > > Can we guarantee that we always obtain a map reference and dispose of
> > > that reference inside the same critical section?
> >
> > yep. the verifier will guarantee that.
> >
> > > If so, can BPF
> > > programs then disable preemption for as long as they'd like?
> >
> > you mean after the finish? no. only while running.
> > The verifier will match things like lookup/release, lock/unlock, preempt on/off
> > and will make sure there is no dangling preempt disable after program returns.
> >
> It might be a silly question but does this new bpf program type
> provide a way to customize where to hold the rcu_lock/unlock and
> enable/disable preemption when creating the program? Since the
> BPF_SYNC_MAP_ACCESS cmd sounds not very useful if it only protect each
> single map access instead of the whole program. For example, sometimes
> we have to read the same map multiple times when running a eBPF
> program and if the userspace changed the map value between two reads,
> it may cause troubles. It would be great if we can have a RCU lock on
> a block of eBPF program and in that way I think BPF_SYNC_MAP_ACCESS
> cmd should be enough in handling userspace kernel racing problems.

we need to make sure we have detailed description of BPF_SYNC_MAP_ACCESS
in uapi/bpf.h, since I feel the confusion regarding its usage is starting already.
This new cmd will only make sense for map-in-map type of maps.
Expecting that BPF_SYNC_MAP_ACCESS is somehow implies the end of
the program or doing some other map synchronization is not correct.
Commit log of this patch got it right:
"""
 For example, userspace can update a map->map entry to point to a new map,
 use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
 complete, and then drain the old map without fear that BPF programs
 may still be updating it.
"""
Now consider two cases:
1. single program does two lookups (inner and outer map) and the program is called
  twice (as trigger on two events or it was tail-called or through prog_array)
2. future single program without rcu wrappers does:
   rcu_lock + outer lookup + inner lookup + rcu_unlock + .. some other bpf stuff .. +
   rcu_lock + outer lookup + inner lookup + rcu_unlock + .. yet another bpf stuff ..
   All of the above as part of single program that is called once.
These two cases are the same from the point of view of BPF_SYNC_MAP_ACCESS
and completion of this cmd does not guarantee that program finished.
In both cases the user space will be correct to start draining the inner map
it replaced after BPF_SYNC_MAP_ACCESS is done
(assuming that implementation does synchronize_rcu I mentioned earlier)

Preemption on/off as done today by prog wrappers or in the future explicitly
by the prog code is orthogonal to this new cmd and map-in-map draining.

