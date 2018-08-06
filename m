Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3596BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74DC21A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s31OAPyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74DC21A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbeHFMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:43:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41569 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeHFMnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:43:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so6039280pgu.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EOvO6ky/dS/nmCHrL9ZkqthUZTkIuPHfdA3nBASzyOU=;
        b=s31OAPyz69cMIGyF2Uo4w4fHhn65+lQFQXqZ71S5PEYn1fCDqLX7nQgdUlNuhk6S/S
         L3B3O4q1LVY4Fbfx+8cV1gPRVAoMp9hHydP+eRC1bFqSyaepkvJz3j8eoXmZOKz0u97g
         LlRa78CxpvDX0An1Zgd8Vg6nvq9kaSO1bCNnIhqw8wxR/fB5/FhTk7Ap7NX5/Ln1SEDs
         AOJdLIKYlqYlEpSJVk1RmhyhJ+pZ2bjsh7bevDuorZeNZWoT04u/Lax2PfAEHZp+OQkJ
         ILVl3GEi87Aaq5Yp1CeYgX9MejgdF6UATPMVhYfjQjo0ZBMQ9URKCMsg4iSSZ50pNxeh
         ucAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EOvO6ky/dS/nmCHrL9ZkqthUZTkIuPHfdA3nBASzyOU=;
        b=fjRdjSnV8JiwGvu6lvJ1BvDjfdUC2hs3T3BPjUMv7VE5loirLgWHG0n2duK1YDy5km
         rRc4OJjgAcV4ytzm0utH8mr+xya7JIefcJdmGMUsHvwidbPRRRrctGYOKr+tnQq6VWi+
         CkWDgrFT5XzWXs6Y5CZh/1J3BQiO5MBbPyK8QeE1yF+zUhFhOdm+6IwuEO/E+Kjoa3DF
         mtME3UECk2x1n7OYHebxtsly0jEMO0kkxHkGRJ8bs4WIp+Kt22n6w9TSsPAWGL77r5Rm
         pbrITPJNJJG86BxLeU/ixSfOqn1cqzBJkFoBxg4rno6Jtp9ObTDJ9RJ0pUt+KyrQHNsU
         JURQ==
X-Gm-Message-State: AOUpUlGAI58MRbB20mITq632S80caIMLCaq2Tq/BXJwjaM1Qmt5gDDWR
        PjjmwWGh4j2KZXLAcCdxiABbCauG58I1Fp1v8Rme+Q==
X-Google-Smtp-Source: AAOMgpeUq07SJiOqE3cBnnyuci9T4gn/A4daZY9rf3NYqys02OUVgo4WUCkow/UvIiYsiaPM7OtGYx7caIExzH4OdS4=
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr14273656pgp.334.1533551690533;
 Mon, 06 Aug 2018 03:34:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 6 Aug 2018 03:34:30
 -0700 (PDT)
In-Reply-To: <20180806094827.GH19540@dhcp22.suse.cz>
References: <0000000000005e979605729c1564@google.com> <20180806091552.GE19540@dhcp22.suse.cz>
 <CACT4Y+Ystnwv4M6Uh+HBKbdADAnJ6otfR0GoA20crzqV+b2onQ@mail.gmail.com> <20180806094827.GH19540@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Aug 2018 12:34:30 +0200
Message-ID: <CACT4Y+ZJsDo1gjzHvbFVqHcrL=tFJXTAAWLs9mAJSv3+LiCdmA@mail.gmail.com>
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 11:48 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 06-08-18 11:30:37, Dmitry Vyukov wrote:
>> On Mon, Aug 6, 2018 at 11:15 AM, Michal Hocko <mhocko@kernel.org> wrote:
> [...]
>> > More interesting stuff is higher in the kernel log
>> > : [  366.435015] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/ile0,task_memcg=/ile0,task=syz-executor3,pid=23766,uid=0
>> > : [  366.449416] memory: usage 112kB, limit 0kB, failcnt 1605
>> >
>> > Are you sure you want to have hard limit set to 0?
>>
>> syzkaller really does not mind to have it.
>
> So what do you use it for? What do you actually test by this setting?

syzkaller is kernel fuzzer, it finds kernel bugs by doing whatever is
doable from user-space. Some of that may not make sense, but it does
not matter because kernel should still stand still.

> [...]
>> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> > index 4603ad75c9a9..852cd3dbdcd9 100644
>> > --- a/mm/memcontrol.c
>> > +++ b/mm/memcontrol.c
>> > @@ -1388,6 +1388,8 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>> >         bool ret;
>> >
>> >         mutex_lock(&oom_lock);
>> > +       pr_info("task=%s pid=%d invoked memcg oom killer. oom_victim=%d\n",
>> > +                       current->comm, current->pid, tsk_is_oom_victim(current));
>> >         ret = out_of_memory(&oc);
>> >         mutex_unlock(&oom_lock);
>> >         return ret;
>> >
>> > Anyway your memcg setup is indeed misconfigured. Memcg with 0 hard limit
>> > and basically no memory charged by existing tasks is not going to fly
>> > and the warning is exactly to call that out.
>>
>>
>> Please-please-please do not mix kernel bugs and notices to user into
>> the same bucket:
>
> Well, WARN_ON used to be a standard way to make user aware of a
> misbehavior. In this case it warns about a pottential runaway when memcg
> is misconfigured. I do not insist on using WARN_ON here of course. If
> there is a general agreement that such a condition is better handled by
> pr_err then I am fine with it. Users tend to be more sensitive on
> WARN_ONs though.

The docs change was acked by Greg, and Andrew took it into mm, Linus
was CCed too. It missed the release because I guess it's comments only
change, but otherwise it should reach upstream tree on the next merge
window.

WARN is _not_ a common way to notify users today. syzbot reports _all_
WARN occurrences and you can see there are not many of them now
(probably 1 another now, +dtor for that one):
https://syzkaller.appspot.com#upstream
There is probably some long tail that we need to fix. We really do
want systematic testing capability. You do not want every of 2 billion
linux users to come to you with this kernel splat, just so that you
can explain to them that it's some programs of their machines doing
something wrong, right?

WARN is really a bad way to inform a user about something. Consider a
non-kernel developer, perhaps even non-programmer. What they see is
"WARNING: CPU: 1 PID: 23767 at mm/memcontrol.c:1710
try_charge+0x734/0x1680" followed by some obscure things and hex
numbers. File:line reference is pointless, they don't what what/where
it is. This one is slightly better because it prints "Memory cgroup
charge failed because of no reclaimable memory! This looks like a
misconfiguration or a kernel bug." before the warning. But still it
says "or a kernel bug", which means that they will come to you. A much
friendlier for user way to say this would be print a message at the
point of misconfiguration saying what exactly is wrong, e.g. "pid $PID
misconfigures cgroup /cgroup/path with mem.limit=0" without a stack
trace (does not give any useful info for user). And return EINVAL if
it can't fly at all? And then leave the "or a kernel bug" part for the
WARNING each occurrence of which we do want to be reported to kernel
developers.
