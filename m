Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9F8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB5B20874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 14:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="zEs7vtz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbeL1O1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 09:27:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42512 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730890AbeL1O1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 09:27:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so17645817edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 06:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a65lxr5qZnunN4dcKCO2AG3b6OF6WAlKdTCyaY25kKg=;
        b=zEs7vtz/hTHpxbCeVr/yobk/vFyaa6DAdqWNRINY5UXVbAYKbFvswl39h7Ws71wOhK
         VhxS/ZDUU1YnjFnKI4AjSiJe8AklKzBhczLLFDFqoAoUfriOL+Jp3dFcayIT5GBLXZ0n
         fxRexYXEi6Z1S9Gt9aQ2shtuyXHFXUOQVtAm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a65lxr5qZnunN4dcKCO2AG3b6OF6WAlKdTCyaY25kKg=;
        b=OfRH0kqH/+VsqdPXUn7BbaJyO9frW2INrmYGn7jgVZU4TN+seEq9mBEuqVijRO1Opk
         JU498Xm39grRNAKDihCSBF+DNtF/W+nmxI1wxUN7cLhagvTnwOMfeD/wFvO2p7NmcnT+
         7jdDRhksDUsycYyH/Ge1VGWuY85BGxlB+rAM3s/IPwabtVEQP+aczITYk6yUghVHfdm3
         YM4aWNUoMSCFNQ378UYB5UE3kPQcUsTMS7vP3H/TnUd+2GCzQ81JKLNvIEq8chzRLPZP
         cLeqyJCbHKQsajbhsMplNS6AUjuM4516g/vAL9uKoL6YoN1ABiRwjsF8xAex7Y0c5adZ
         8ptQ==
X-Gm-Message-State: AA+aEWad2aBFkVObQTdHHFSgQKDC2lzJc7IiQgzLq0gxQzutUVnpAtk5
        pDZD7jNjIZK9bFTh7QgteqUShc4KAooS5WrOWqUwVw==
X-Google-Smtp-Source: AFSGD/XY7lo1ve1j/KHDAeRX7/s1HRQKLi4I53sH31R92hr1QDWBr/Lgys4HgC5qYI2LU8AP4t0+Eu2zn/H89CDodGo=
X-Received: by 2002:a50:903c:: with SMTP id b57mr23114128eda.161.1546007253851;
 Fri, 28 Dec 2018 06:27:33 -0800 (PST)
MIME-Version: 1.0
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org> <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
 <20181228011524.GF2509588@devbig004.ftw2.facebook.com> <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
 <20181228015352.GG2509588@devbig004.ftw2.facebook.com> <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
 <CAKfTPtA5WBKQ1FMyGqGjn1DdeDbSwT=bTQjD=oW7WMz6iKiS7A@mail.gmail.com>
In-Reply-To: <CAKfTPtA5WBKQ1FMyGqGjn1DdeDbSwT=bTQjD=oW7WMz6iKiS7A@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 28 Dec 2018 09:26:57 -0500
Message-ID: <CAMp4zn-h9Q8nHu=u7x5TwFSQAB+y9T3k1-VK_uxJy-vu3sREZg@mail.gmail.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> But the lock should not be released during the build of a branch and
> tmp_alone_branch must always points to rq->leaf_cfs_rq_list at the end
> and before the lock is released
>
> I think that there is a bigger problem with commit a9e7f6544b9c and
> cfs_rq throttling:
> Let take the example of the following topology TG2 --> TG1 --> root
> 1-The 1st time a task is enqueued, we will add TG2 cfs_rq then TG1
> cfs_rq to leaf_cfs_rq_list and we are sure to do the whole branch in
> one path because it has never been used and can't be throttled so
> tmp_alone_branch will point to leaf_cfs_rq_list at the end.
> 2-Then TG1 is throttled
> 3-and we add TG3 as a new child of TG1.
> 4-The 1st enqueue of a task on TG3 will add TG3 cfs_rq just before TG1
> cfs_rq and tmp_alone_branch will stay  on rq->leaf_cfs_rq_list.
>
> With commit a9e7f6544b9c, we can del a cfs_rq from
> rq->leaf_cfs_rq_list. So if the load of TG1 cfs_rq becomes null before
> step 2 above, TG1 cfs_rq is removed from the list.
> Then at step 4, TG3 cfs_rq is added at the beg of rq->leaf_cfs_rq_list
> but tmp_alone_branch still points to TG3 cfs_rq  because its throttled
> parent can't be enqueued when the lock is released
> tmp_alone_branch doesn't point to rq->leaf_cfs_rq_list whereas it should.
>
> so if TG3 cfs_rq is removed or destroyed before tmp_alone_branch
> points on another TG cfs_rq, the next TG cfs_rq that will be added,
> will be linked  outside rq->leaf_cfs_rq_list
>
> In addition, we can break the ordering of the cfs_rq in
> rq->leaf_cfs_rq_list but this ordering is used to update  and
> propagate the update from leaf down to root.
>
> >
> > So, something like the following.  Xie, can you see whether the
> > following patch resolves the problem?
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d1907506318a..88b9118b5191 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7698,7 +7698,8 @@ static void update_blocked_averages(int cpu)
> >                  * There can be a lot of idle CPU cgroups.  Don't let fully
> >                  * decayed cfs_rqs linger on the list.
> >                  */
> > -               if (cfs_rq_is_decayed(cfs_rq))
> > +               if (cfs_rq_is_decayed(cfs_rq) &&
> > +                   rq->tmp_alone_branch == &rq->leaf_cfs_rq_list)
> >                         list_del_leaf_cfs_rq(cfs_rq);
>
> This patch reduces the cases but I don't thinks it's enough because it
> doesn't cover the case of unregister_fair_sched_group()
> And we can still break the ordering of the cfs_rq
>
> >
> >                 /* Don't need periodic decay once load/util_avg are null */

It looks like you're right. This patch, in our cluster, overnight
showed failures, but at least DEBUG_LIST caught them.

[10226.131822] ------------[ cut here ]------------
[10226.133094] kernel BUG at lib/list_debug.c:25!
[10226.134328] invalid opcode: 0000 [#1] SMP PTI
[10226.135540] CPU: 43 PID: 2005156 Comm: java Kdump: loaded Not
tainted 4.19.12netflix-46014-g794c368-dirty #13
[10226.138125] Hardware name: Amazon EC2 r5.24xlarge/, BIOS 1.0 10/16/2017
[10226.139894] RIP: 0010:__list_add_valid+0x38/0x90
[10226.141174] Code: 75 19 48 8b 32 48 39 f0 75 2e 48 39 fa 74 4c 48
39 f8 74 47 b8 01 00 00 00 5d c3 48 89 c1 48 c7 c7 00 b8 cc b9 e8 4b
13 b0 ff <0f> 0b 48 c7 c7 b0 f2 02 ba e8 aa d8 06 00 48 89 d1 48 c7 c7
58 b8
[10226.146855] RSP: 0018:ffffa944a4e83b50 EFLAGS: 00010082
[10226.149231] RAX: 0000000000000075 RBX: ffff8e7d9a133a00 RCX: 0000000000000000
[10226.152077] RDX: 0000000000000000 RSI: ffff8e7db76d6858 RDI: ffff8e7db76d6858
[10226.154922] RBP: ffffa944a4e83b50 R08: 0000000000000000 R09: 0000000000000000
[10226.157786] R10: 0000000000000000 R11: ffff8e7d670a1f00 R12: ffff8e7db7723f40
[10226.160630] R13: ffff8e7673ea6180 R14: ffff8e7d9a133b80 R15: ffff8e79f6693580
[10226.163502] FS:  00007f534e3d3700(0000) GS:ffff8e7db76c0000(0000)
knlGS:0000000000000000
[10226.167523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10226.170000] CR2: 00007f5cd803bb08 CR3: 0000005ba351e005 CR4: 00000000003606e0
[10226.172811] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[10226.175656] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[10226.178503] Call Trace:
[10226.180170]  enqueue_entity+0x217/0x7e0
[10226.182202]  ? trace_hardirqs_off+0x22/0xe0
[10226.184307]  enqueue_task_fair+0x99/0x7b0
[10226.186376]  activate_task+0x33/0xa0
[10226.188322]  ttwu_do_activate+0x4b/0xb0
[10226.190346]  try_to_wake_up+0x281/0x8b0
[10226.192364]  ? find_held_lock+0x2e/0xb0
[10226.194376]  wake_up_q+0x32/0x80
[10226.196253]  futex_wake+0x15a/0x190
[10226.198178]  do_futex+0x34c/0xec0
[10226.200074]  ? lockdep_hardirqs_on+0x146/0x1e0
[10226.202236]  ? _raw_spin_unlock_irq+0x2c/0x40
[10226.204359]  ? trace_hardirqs_on+0x3f/0xe0
[10226.206453]  ? _raw_spin_unlock_irq+0x2c/0x40
[10226.208598]  ? finish_task_switch+0x8c/0x2b0
[10226.215629]  ? finish_task_switch+0x5f/0x2b0
[10226.217793]  ? __schedule+0x3dc/0xbe0
[10226.219760]  __x64_sys_futex+0x8b/0x180
[10226.221825]  ? trace_hardirqs_off_caller+0x22/0xe0
[10226.224102]  ? lockdep_hardirqs_on+0x146/0x1e0
[10226.226280]  ? do_syscall_64+0x19/0x1e0
[10226.228281]  do_syscall_64+0x67/0x1e0
[10226.230254]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[10226.232522] RIP: 0033:0x7f536705ebb1
[10226.234458] Code: 0f 05 48 3d 00 f0 ff ff 0f 87 12 02 00 00 45 84
c9 74 2d 4a 8d 7c ab 28 45 31 d2 ba 01 00 00 00 4c 89 f6 b8 ca 00 00
00 0f 05 <48> 3d 00 f0 ff ff 76 0e 83 f8 ea 74 09 83 f8 f2 0f 85 ae 00
00 00
[10226.242010] RSP: 002b:00007f534e3d2b60 EFLAGS: 00000246 ORIG_RAX:
00000000000000ca
[10226.245872] RAX: ffffffffffffffda RBX: 00007f536008ec50 RCX: 00007f536705ebb1
[10226.248707] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 00007f536008ec78
[10226.251521] RBP: 00007f536008ec78 R08: 00007f536008ec70 R09: 0000000000000001
[10226.254301] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f536008ec64
[10226.257108] R13: 0000000000000000 R14: 0000000000000081 R15: 00007f536008ec50
[10226.259937] Modules linked in: veth sch_fq_codel ipvlan ipt_REJECT
nf_reject_ipv4 xt_tcpudp xt_owner act_mirred cls_matchall sch_ingress
cls_bpf sch_htb ifb iptable_filter ip_tables xt_conntrack x_tables
nf_nat bridge stp llc nf_conntrack_netlink nfnetlink nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo overlay binfmt_misc
nfit xfs input_leds intel_rapl_perf parport_pc i2c_piix4 parport
serio_raw tcp_bbr sunrpc autofs4 btrfs raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 multipath linear crct10dif_pclmul
crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64
crypto_simd cryptd glue_helper intel_agp intel_gtt ena agpgart
