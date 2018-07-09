Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78051C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2010E20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPoaTI5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2010E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933460AbeGIVgl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:36:41 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37649 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933112AbeGIVgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:36:39 -0400
Received: by mail-it0-f68.google.com with SMTP id p17-v6so28466740itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EdZictenZ9m+h0d05uTUqasjig6fE75LLsimlYKcZeA=;
        b=aPoaTI5ptC6uAhfKmAeZTLId6ndzYNs89oUDXS8G66xBBDBvo613t2hHJperOhaw90
         Ai2U4xR2oJXN9dZ+hXzVVbVV7Lb00AZGR9N/LkTK/hUSvW8oXy3SbpWnu2kxR18sJgiO
         IwzWir2QMZRJZkSNS2bB3oCIiXBQhp5bgfLyUwhlLgz7VW2F8jlxZZgJVq99NUMlH7IO
         4547fJitMMxjJ5aGJ/nOVfF0Z1M1d+WMu7g73xP1WQJ3MTzq078MWhTP5LYBqueP7IZ8
         d1iJNq5TwSPGiibaYQzlMv3URkTIxXu6W1jiaVfby3Egp7YWi0Qh8VNwZ3UeAkMJfoW8
         MXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EdZictenZ9m+h0d05uTUqasjig6fE75LLsimlYKcZeA=;
        b=qK7E9T6afWoqOrSao98X4zoPFtBl2oxsME78ZCN57uarw5u0LrciKs1px4LWJyU4uX
         QQcG2clOCrMM9JbX+UEGa4/dRh3RlmNzCK4jYwhetuUHd5GmPzzieS2VrJHBx7hf4+Zn
         1PjpPqErApUOfaXpkcl2X/bb0LgS6rBnffQ+xZHU7vAi9fkg18P9Vt7RpFfkJvr94Lq6
         r40O6L5I3ZZBM+fw3HYApA4rhQXejmJsYBk5+Gz1WOsJpMRXgJl2iFSYmKbP7FZrwOF1
         RorGPNQy+WHRVglKHdmrfyJRvlseAdWm+mVgsp5WTdqsi9X/eA0XHlWXI3jZ3I6bz5Mf
         gSpg==
X-Gm-Message-State: APt69E0rx+DUlJDgVIh81pTib4r9155EntCtR1BGwX49BOL6MW4/GBIo
        XMUGbDuHt1UuWoY7HVkZ6Sn3Gd1lfPk7gihLJWmsPA==
X-Google-Smtp-Source: AAOMgpfKZlitCmGXldauFYV6CgZzTxJr46M8KpPmLPnGEuufC6ymkv0WD/u2Ce+7w11j2ZXSHYJM6IfDROKAIL8SCLQ=
X-Received: by 2002:a02:4442:: with SMTP id o63-v6mr18866401jaa.75.1531172198381;
 Mon, 09 Jul 2018 14:36:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:ba01:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 14:36:37 -0700 (PDT)
In-Reply-To: <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
References: <20180707015616.25988-1-dancol@google.com> <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
 <20180707203340.GA74719@joelaf.mtv.corp.google.com> <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 9 Jul 2018 14:36:37 -0700
Message-ID: <CAKOZuet+pjqM8zghmXYdA9f10bsYOzMuSQhSYXG5wbrNmFEqpQ@mail.gmail.com>
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

On Mon, Jul 9, 2018 at 2:09 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
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
>> >> >          BPF_BTF_LOAD,
>> >> >          BPF_BTF_GET_FD_BY_ID,
>> >> >          BPF_TASK_FD_QUERY,
>> >> > +        BPF_SYNCHRONIZE,
>> >> >  };
>> >> >
>> >> >  enum bpf_map_type {
>> >> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> >> > index d10ecd78105f..60ec7811846e 100644
>> >> > --- a/kernel/bpf/syscall.c
>> >> > +++ b/kernel/bpf/syscall.c
>> >> > @@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *,
>> >> > uattr, unsigned int, siz
>> >> >          if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
>> >> >                  return -EPERM;
>> >> >
>> >> > +        if (cmd == BPF_SYNCHRONIZE) {
>> >> > +                if (uattr != NULL || size != 0)
>> >> > +                        return -EINVAL;
>> >> > +                err = security_bpf(cmd, NULL, 0);
>> >> > +                if (err < 0)
>> >> > +                        return err;
>> >> > +                /* BPF programs are run with preempt disabled, so
>> >> > +                 * synchronize_sched is sufficient even with
>> >> > +                 * RCU_PREEMPT.
>> >> > +                 */
>> >> > +                synchronize_sched();
>> >> > +                return 0;
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

I'm not sure what you're proposing. In the case the commit message
describes, a user-space program that wants to "drain" a map needs to
be confident that the map won't change under it, even across multiple
bpf system calls on that map. One way of doing that is to ensure that
nothing that could possibly hold a reference to that map is still
running. Are you proposing some kind of refcount-draining approach?
Simple locking won't work, since BPF programs can't block, and I don't
see right now how a simple barrier would help.

> Also should such sys_bpf command be root only?
> I'm not sure whether dos attack can be made by spamming synchronize_rcu()
> and synchronize_sched() for that matter.

membarrier being globally available seems not to have caused any kind
of DoS catastrophe.
