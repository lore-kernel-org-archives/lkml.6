Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED96C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A4F20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAvtNYJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A4F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754594AbeGIWVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:21:47 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37340 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbeGIWVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:21:45 -0400
Received: by mail-io0-f193.google.com with SMTP id z19-v6so18521474ioh.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LWBEBiGOlmP8dmnWrO3I43Vydm/Aztc56w1QrTLg2DM=;
        b=CAvtNYJKf4VfezkDoGxecJmFD09xXBOHmnE91YeeDOhyZXVRvkbHPHA+9kFXR5VGRA
         X5LxjKckSDr+TBEH+rWUiEhK8Sc5z63EhzOxRSybjlP75IV8xM52N5opwZC51x+H6rS8
         7B936HmC90COxYMtEObaxsVEzzJ8L6wCWEwKG5ynmhZjC2LFYfHsxXlz9urGN2oglyyW
         dGyeVO9IQxIyw7IaDZSS2BBkpOQ/wAcH01yCIwHcAA6v+Q/b3G5TYg/obZ1CnNxklXgv
         pKXOfZVw0Ol5UzMmxTtnUV5wWlDkxsHGwct6eSjyMski/1p55tZGWYW1ePT8mM+r27Oc
         fR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LWBEBiGOlmP8dmnWrO3I43Vydm/Aztc56w1QrTLg2DM=;
        b=U5wB7YgYU1lwg21V115OtyKjYr4Ezf3uN0c6eNCd0ASgrKWCpNOKr3a9SOZ14wH4yU
         hpwfdoIFgjEivKxKz6tQAx9LEimjIcMnwAG/fIYRSHTtoERwulZluTguwEyH7AJNm8H6
         bRfyG5cQaE+ryDZrXY4doBTTozAliqdrAgKi8xzXoUFjRwii/V4ZXxC+f3W2LXO7duz/
         liaE+ZatPVUaulQpCsIPowMzKQu86F7JrIeu/ukL1bAW/IdchBfut1hdPkaERIkVGldu
         5Y7aGRIvdkr1suBShvMpaTxCSax8k4OMdNeOxIwwTu08f6s9/m5Yvcy0DFO2MsTyBKIG
         11gw==
X-Gm-Message-State: APt69E1eFnAVl9SqX03ejO3L88cLlzidUeMw0JtBLUUpazcMUv5y+Hvm
        8Ez3bnFCnRuZS5O1Pz5Y+X12oftlEuaMi5I3sOBc6zPVUrA=
X-Google-Smtp-Source: AAOMgpfi8L2pRKTe/6Mi5vQLHJ323NHNvQZlffLfKqUcTmQu5O944Nd5yWI+g7ZvsCrmcQJzqrdUEWCOedGZysScSr4=
X-Received: by 2002:a6b:b010:: with SMTP id z16-v6mr18533578ioe.206.1531174903828;
 Mon, 09 Jul 2018 15:21:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:ba01:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 15:21:43 -0700 (PDT)
In-Reply-To: <20180709221005.sintsjkle4xpkcyk@ast-mbp.dhcp.thefacebook.com>
References: <20180707015616.25988-1-dancol@google.com> <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
 <20180707203340.GA74719@joelaf.mtv.corp.google.com> <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuet+pjqM8zghmXYdA9f10bsYOzMuSQhSYXG5wbrNmFEqpQ@mail.gmail.com> <20180709221005.sintsjkle4xpkcyk@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 9 Jul 2018 15:21:43 -0700
Message-ID: <CAKOZuetaKNaJVWcu10ZcsiXiK4X+-2z3eFaz1pF8DSxdQ_mEnQ@mail.gmail.com>
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, Chenbo Feng <fengc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 3:10 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Mon, Jul 09, 2018 at 02:36:37PM -0700, Daniel Colascione wrote:
>> On Mon, Jul 9, 2018 at 2:09 PM, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> > On Sun, Jul 08, 2018 at 04:54:38PM -0400, Mathieu Desnoyers wrote:
>> >> ----- On Jul 7, 2018, at 4:33 PM, Joel Fernandes joelaf@google.com wrote:
>> >>
>> >> > On Fri, Jul 06, 2018 at 07:54:28PM -0700, Alexei Starovoitov wrote:
>> >> >> On Fri, Jul 06, 2018 at 06:56:16PM -0700, Daniel Colascione wrote:
>> >> >> > BPF_SYNCHRONIZE waits for any BPF programs active at the time of
>> >> >> > BPF_SYNCHRONIZE to complete, allowing userspace to ensure atomicity of
>> >> >> > RCU data structure operations with respect to active programs. For
>> >> >> > example, userspace can update a map->map entry to point to a new map,
>> >> >> > use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
>> >> >> > complete, and then drain the old map without fear that BPF programs
>> >> >> > may still be updating it.
>> >> >> >
>> >> >> > Signed-off-by: Daniel Colascione <dancol@google.com>
>> >> >> > ---
>> >> >> >  include/uapi/linux/bpf.h |  1 +
>> >> >> >  kernel/bpf/syscall.c     | 14 ++++++++++++++
>> >> >> >  2 files changed, 15 insertions(+)
>> >> >> >
>> >> >> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> >> >> > index b7db3261c62d..4365c50e8055 100644
>> >> >> > --- a/include/uapi/linux/bpf.h
>> >> >> > +++ b/include/uapi/linux/bpf.h
>> >> >> > @@ -98,6 +98,7 @@ enum bpf_cmd {
>> >> >> >          BPF_BTF_LOAD,
>> >> >> >          BPF_BTF_GET_FD_BY_ID,
>> >> >> >          BPF_TASK_FD_QUERY,
>> >> >> > +        BPF_SYNCHRONIZE,
>> >> >> >  };
>> >> >> >
>> >> >> >  enum bpf_map_type {
>> >> >> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> >> >> > index d10ecd78105f..60ec7811846e 100644
>> >> >> > --- a/kernel/bpf/syscall.c
>> >> >> > +++ b/kernel/bpf/syscall.c
>> >> >> > @@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *,
>> >> >> > uattr, unsigned int, siz
>> >> >> >          if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
>> >> >> >                  return -EPERM;
>> >> >> >
>> >> >> > +        if (cmd == BPF_SYNCHRONIZE) {
>> >> >> > +                if (uattr != NULL || size != 0)
>> >> >> > +                        return -EINVAL;
>> >> >> > +                err = security_bpf(cmd, NULL, 0);
>> >> >> > +                if (err < 0)
>> >> >> > +                        return err;
>> >> >> > +                /* BPF programs are run with preempt disabled, so
>> >> >> > +                 * synchronize_sched is sufficient even with
>> >> >> > +                 * RCU_PREEMPT.
>> >> >> > +                 */
>> >> >> > +                synchronize_sched();
>> >> >> > +                return 0;
>> >> >>
>> >> >> I don't think it's necessary. sys_membarrier() can do this already
>> >> >> and some folks use it exactly for this use case.
>> >> >
>> >> > Alexei, the use of sys_membarrier for this purpose seems kind of weird to me
>> >> > though. No where does the manpage say membarrier should be implemented this
>> >> > way so what happens if the implementation changes?
>> >> >
>> >> > Further, membarrier manpage says that a memory barrier should be matched with
>> >> > a matching barrier. In this use case there is no matching barrier, so it
>> >> > makes it weirder.
>> >> >
>> >> > Lastly, sys_membarrier seems will not work on nohz-full systems, so its a bit
>> >> > fragile to depend on it for this?
>> >> >
>> >> >        case MEMBARRIER_CMD_GLOBAL:
>> >> >                /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_full. */
>> >> >                if (tick_nohz_full_enabled())
>> >> >                        return -EINVAL;
>> >> >                if (num_online_cpus() > 1)
>> >> >                        synchronize_sched();
>> >> >                return 0;
>> >> >
>> >> >
>> >> > Adding Mathieu as well who I believe is author/maintainer of membarrier.
>> >>
>> >> See commit 907565337
>> >> "Fix: Disable sys_membarrier when nohz_full is enabled"
>> >>
>> >> "Userspace applications should be allowed to expect the membarrier system
>> >> call with MEMBARRIER_CMD_SHARED command to issue memory barriers on
>> >> nohz_full CPUs, but synchronize_sched() does not take those into
>> >> account."
>> >>
>> >> So AFAIU you'd want to re-use membarrier to issue synchronize_sched, and you
>> >> only care about kernel preempt off critical sections.
>> >>
>> >> Clearly bpf code does not run in user-space, so it would "work".
>> >>
>> >> But the guarantees provided by membarrier are not to synchronize against
>> >> preempt off per se. It's just that the current implementation happens to
>> >> do that. The point of membarrier is to turn user-space memory barriers
>> >> into compiler barriers.
>> >>
>> >> If what you need is to wait for a RCU grace period for whatever RCU flavor
>> >> ebpf is using, I would against using membarrier for this. I would rather
>> >> recommend adding a dedicated BPF_SYNCHRONIZE so you won't leak
>> >> implementation details to user-space, *and* you can eventually change you
>> >> RCU implementation for e.g. SRCU in the future if needed.
>> >
>> > The point about future changes to underlying bpf mechanisms is valid.
>> > There is work already on the way to reduce the scope of preempt_off+rcu_lock
>> > that currently lasts the whole prog. We will have new prog types that won't
>> > have such wrappers and will do rcu_lock/unlock and preempt on/off only
>> > when necessary.
>> > So something like BPF_SYNCHRONIZE will break soon, since the kernel cannot have
>> > guarantees on when programs finish. Calling this command BPF_SYNCHRONIZE_PROG
>> > also won't make sense for the same reason.
>> > What we can do it instead is to define synchronization barrier for
>> > programs accessing maps. May be call it something like:
>> > BPF_SYNC_MAP_ACCESS ?
>>
>> I'm not sure what you're proposing. In the case the commit message
>> describes, a user-space program that wants to "drain" a map needs to
>> be confident that the map won't change under it, even across multiple
>> bpf system calls on that map. One way of doing that is to ensure that
>> nothing that could possibly hold a reference to that map is still
>> running. Are you proposing some kind of refcount-draining approach?
>> Simple locking won't work, since BPF programs can't block, and I don't
>> see right now how a simple barrier would help.
>
> I'm proposing few changes for your patch:
> s/BPF_SYNCHRONIZE/BPF_SYNC_MAP_ACCESS/
> and s/synchronize_sched/synchronize_rcu/
> with detailed comment in uapi/bpf.h that has an example why folks
> would want to use this new cmd.

Thanks for clarifying.

> I think the bpf maps will be rcu protected for foreseeable future
> even when rcu_read_lock/unlock will be done by the programs instead of
> kernel wrappers.

Can we guarantee that we always obtain a map reference and dispose of
that reference inside the same critical section? If so, can BPF
programs then disable preemption for as long as they'd like?
