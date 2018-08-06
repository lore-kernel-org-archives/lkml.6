Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BD4C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1369721A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9++obN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1369721A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeHFMr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:47:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41762 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeHFMr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:47:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so6676411pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3YXuO62zqnigkAN0aa5Es4B/dz6ofYWKyyPaB8qwyBg=;
        b=p9++obN7bsuMznBuY9mt+9yKa53K0fh+f6X2nNEhsxuJDbj6Vlz3z0cgSvaqKAbpZu
         Dz3RUBTvI/EGw052s6VJtCIgIX8PbGY0PnxrH4BzaruFXW+eLzT9r13Du1ALrJUiJe8q
         utYw9DCvPX2EGGCppcazaAOTNJ/QFrA+m3D/LvGhy1FI2ybImn5V6VvdvqQ1G7GbMBqp
         BxK3kviY8Avh7FSs8HOWSGd4/S6Twv3O2PsvH/5mcpXfRQ7GnAc4DUzwYvJB9b9Hyu/p
         Gs00JnDoSQlMaAzjyg5A63glE5wXypda2D35Xq2Yjpjqt1N9sFLj6gL4j7u8r33nT9QG
         hEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3YXuO62zqnigkAN0aa5Es4B/dz6ofYWKyyPaB8qwyBg=;
        b=o0v00nVsZp955yevPskffMgT+cLp4eBFN6LMgEKh+7wiOGXCpN5Sw5L4wvoRoivE6P
         Nh8syuxyVPZlI3UxeeRtxZ+965i9qoz1yvx/hfdp/kS2xfb+gimQDq60+JKPCGoNydTG
         Q4cWEc6xNN+t+rcwSAVznaT3A1o1k+ndcIvOv5elqAkeEE+Zi9qW3mH+FB74apmGvLTk
         I+qfTB9tcXzV6guNkEkwyn/8BWtH7xlLbhsza3TTEj7K+fockoDVqFm9/l8tT/9GqFMj
         BnSMk9iQNM7v44ywvO2rH3Flc2rnKCH7QMW4qHYqF6jZStlEO+rAI45TZln552vnR7nG
         NYBQ==
X-Gm-Message-State: AOUpUlHjrbghr6Z42GCezN0wnkOJYYqSJ/V9NimYL3FeyFaOVelpSp6E
        Cb6nHHpN3tu/KV2xGfC6PSjp1bxJFgK3xAcKBmNlqA==
X-Google-Smtp-Source: AAOMgpddfn5uLe4c1YtYkwCv5jhmxUOtJiIxP6dN9wfjG9xPhMQPPTxeI4+ULhcY6PoY9BTnfa/4Uwzi8mFV68ulr/w=
X-Received: by 2002:a63:1f20:: with SMTP id f32-v6mr13528736pgf.84.1533551970972;
 Mon, 06 Aug 2018 03:39:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 6 Aug 2018 03:39:09
 -0700 (PDT)
In-Reply-To: <20180806094827.GH19540@dhcp22.suse.cz>
References: <0000000000005e979605729c1564@google.com> <20180806091552.GE19540@dhcp22.suse.cz>
 <CACT4Y+Ystnwv4M6Uh+HBKbdADAnJ6otfR0GoA20crzqV+b2onQ@mail.gmail.com> <20180806094827.GH19540@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Aug 2018 12:39:09 +0200
Message-ID: <CACT4Y+ZEAoPWxEJ2yAf6b5cSjAm+MPx1yrk70BWHRrnDYdyb_A@mail.gmail.com>
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000007a019c0572c1e4c7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007a019c0572c1e4c7
Content-Type: text/plain; charset="UTF-8"

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
>
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
>
> Btw. running with the above diff on top might help us to ideantify
> whether this is a pre-mature warning or a valid one. Still useful to
> find out.

The bug report has a reproducer, so you can run it with the patch. Or
ask syzbot to test your patch:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
Which basically boils down to saying:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

Note that a text patch without a base tree/commit can be useless, I
used torvalds/linux.git but I don't know if it will apply there or
not. Let's see.

--0000000000007a019c0572c1e4c7
Content-Type: text/x-patch; charset="US-ASCII"; name="cgroup.patch"
Content-Disposition: attachment; filename="cgroup.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jki54m7q0

ZGlmZiAtLWdpdCBhL21tL21lbWNvbnRyb2wuYyBiL21tL21lbWNvbnRyb2wuYwppbmRleCA0NjAz
YWQ3NWM5YTkuLjg1MmNkM2RiZGNkOSAxMDA2NDQKLS0tIGEvbW0vbWVtY29udHJvbC5jCisrKyBi
L21tL21lbWNvbnRyb2wuYwpAQCAtMTM4OCw2ICsxMzg4LDggQEAgc3RhdGljIGJvb2wgbWVtX2Nn
cm91cF9vdXRfb2ZfbWVtb3J5KHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZywgZ2ZwX3QgZ2ZwX21h
c2ssCiAJYm9vbCByZXQ7CiAKIAltdXRleF9sb2NrKCZvb21fbG9jayk7CisJcHJfaW5mbygidGFz
az0lcyBwaWQ9JWQgaW52b2tlZCBtZW1jZyBvb20ga2lsbGVyLiBvb21fdmljdGltPSVkXG4iLAor
CQkJY3VycmVudC0+Y29tbSwgY3VycmVudC0+cGlkLCB0c2tfaXNfb29tX3ZpY3RpbShjdXJyZW50
KSk7CiAJcmV0ID0gb3V0X29mX21lbW9yeSgmb2MpOwogCW11dGV4X3VubG9jaygmb29tX2xvY2sp
OwogCXJldHVybiByZXQ7Cgo=
--0000000000007a019c0572c1e4c7--
