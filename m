Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF10C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624FC21A61
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pF56GvQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624FC21A61
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbeHFT7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:59:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41307 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732994AbeHFT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:59:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id y10-v6so7215733pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xGBBRuO4Az4XOP88JUEmza0ZAmRRe18j30BmsSCVyn0=;
        b=pF56GvQ31KVDbGqYFbDoIbhjkMlQHxp8x5J9qX4Gh1pDvF/WXsaiQkNwGvL6+0ygLu
         M1nwGQCBC4k6JdxMq8Fgk9FR2a3RK0N/ipRp4MOD5IfE9ElkcOdCZjPnPQ8wyBuoooks
         BmnK0M5IlN/sjejbcxWA3t0hT/W/YkwN+8jqzGWt/qxbTxLyU/isvTLhF3Mzh3OHc56h
         IucjTm9ejTlz/czitWSkS18rxLB80RBSmK0sfAW6t/+N2oJhsCwnfas1O4tH3TdY/krj
         AnP2Afm0RftLGXna17rdKjZ8B0SXHaeKiPDQ8VdFSBLx6pu+s8Mn1C2ofbwoJziAgIeH
         24oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xGBBRuO4Az4XOP88JUEmza0ZAmRRe18j30BmsSCVyn0=;
        b=ulMnI0oZ9Slo1CNMT2d7qFsHGsy/+lbPUo75SUPie6FooCrLhaELuu06QhVxtQwUbR
         crrhpIZe75L1L6tXROgf0Galp4vpkRAD2FD4SsmnADooeThYl9+xXsKGQE1qq60Kxl84
         W8oWD+zsP1vwo3QJUyI5Icoy5SoOU+8iqvvx86ZFevAmwUjiPd5OI0ScyE0mPwIMdgDG
         u036uQHtbt5Aw5dbgccPvSTbDiLncq5JoPxwbp3/InEuzKx6/aQC3yfM1CM27mPFnrB7
         ZMWaZxumBhKYzDHXP9zDa66HhXyp8oB7Y770Wqu6XS6W6sErIjjI9aGbunMtVOaiSFAP
         YiMQ==
X-Gm-Message-State: AOUpUlE80m7zswFL2NmHg0QA7PgV0xARAgg8t0HVsWUzIj1Msj2Ksolj
        Wj6Dwfgbn3LfX5L1fh9aZlTrgL0XRKUMXp5z9xYxJA==
X-Google-Smtp-Source: AAOMgpcudmPn0sHcgwi6eYkYUBeRFxtQt0Bje3z8OjPobWqUe/Eu7KzzhbMdQXMisNudhjtf3CzooWZzMbhP+VyUR/E=
X-Received: by 2002:a62:3184:: with SMTP id x126-v6mr18305702pfx.49.1533577777348;
 Mon, 06 Aug 2018 10:49:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 6 Aug 2018 10:49:16
 -0700 (PDT)
In-Reply-To: <20180806174410.GB10003@dhcp22.suse.cz>
References: <fc6e173e-8bda-269f-d44f-1c5f5215beac@I-love.SAKURA.ne.jp>
 <0000000000006350880572c61e62@google.com> <20180806174410.GB10003@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Aug 2018 19:49:16 +0200
Message-ID: <CACT4Y+YDTvOTrSWBU-cZ-yFAbsJP=J9Nhp9w1F2cGG7hw4P81Q@mail.gmail.com>
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 7:44 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 06-08-18 08:42:02, syzbot wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch but the reproducer still triggered
>> crash:
>> WARNING in try_charge
>>
>> Killed process 6410 (syz-executor5) total-vm:37708kB, anon-rss:2128kB,
>> file-rss:0kB, shmem-rss:0kB
>> oom_reaper: reaped process 6410 (syz-executor5), now anon-rss:0kB,
>> file-rss:0kB, shmem-rss:0kB
>> task=syz-executor5 pid=6410 invoked memcg oom killer. oom_victim=1
>
> Thank you. This is useful. The full oom picture is this
> : [   65.363983] task=syz-executor5 pid=6415 invoked memcg oom killer. oom_victim=0
> [...]
> : [   65.920355] Task in /ile0 killed as a result of limit of /ile0
> : [   65.926389] memory: usage 0kB, limit 0kB, failcnt 20
> : [   65.931518] memory+swap: usage 0kB, limit 9007199254740988kB, failcnt 0
> : [   65.938296] kmem: usage 0kB, limit 9007199254740988kB, failcnt 0
> : [   65.944467] Memory cgroup stats for /ile0: cache:0KB rss:0KB rss_huge:0KB shmem:0KB mapped_file:0KB dirty:0KB writeback:0KB swap:0KB inactive_anon:0KB active_anon:0KB inactive_file:0KB active_file:0KB unevictable:0KB
> : [   65.963878] Tasks state (memory values in pages):
> : [   65.968743] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> : [   65.977615] [   6410]     0  6410     9427      532    61440        0             0 syz-executor5
> : [   65.986647] Memory cgroup out of memory: Kill process 6410 (syz-executor5) score 547000 or sacrifice child
> : [   65.996474] Killed process 6410 (syz-executor5) total-vm:37708kB, anon-rss:2128kB, file-rss:0kB, shmem-rss:0kB
> : [   66.007471] oom_reaper: reaped process 6410 (syz-executor5), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> : [   66.017652] task=syz-executor5 pid=6410 invoked memcg oom killer. oom_victim=1
> : [   66.025137] ------------[ cut here ]------------
> : [   66.029927] Memory cgroup charge failed because of no reclaimable memory! This looks like a misconfiguration or a kernel bug.
> : [   66.030061] WARNING: CPU: 1 PID: 6410 at mm/memcontrol.c:1707 try_charge+0x734/0x1680
>
> So we have only a single task in the memcg and it is this task which
> triggers the OOM. It gets killed and oom_reaped. This means that
> out_of_memory should return with true and so we should retry and force
> the charge as I've already mentioned. For some reason this task has
> triggered the oom killer path again and then we haven't found any
> eligible task and resulted in the warning. This shouldn't happen.
>
> I will stare to the code some more to see how the heck we get there
> without passing
>         if (unlikely(tsk_is_oom_victim(current) ||
>                      fatal_signal_pending(current) ||
>                      current->flags & PF_EXITING))
>                 goto force;


This is the syzkaller reproducer if it will give you any hints:

mkdir(&(0x7f0000000340)='./file0\x00', 0x0)
mount(&(0x7f00000000c0)='./file0//ile0\x00',
&(0x7f0000000080)='./file0\x00', &(0x7f0000000200)='cgroup2\x00', 0x0,
0x0)
r0 = open(&(0x7f0000000040)='./file0//ile0\x00', 0x0, 0x0)
r1 = openat$cgroup_procs(r0, &(0x7f00000001c0)='cgroup.procs\x00', 0x2, 0x0)
write$cgroup_pid(r1, &(0x7f0000000100), 0x12)
syz_mount_image$xfs(&(0x7f0000000280)='xfs\x00',
&(0x7f00000002c0)='./file0//ile0\x00', 0x0, 0x0, &(0x7f0000000740),
0x0, &(0x7f0000000800))
getsockopt$sock_cred(r0, 0x1, 0x11, &(0x7f0000000180), &(0x7f0000000240)=0xc)
r2 = open(&(0x7f0000000040)='./file0//ile0\x00', 0x0, 0x0)
write$FUSE_STATFS(r2, &(0x7f0000000280)={0x60, 0xfffffffffffffffe,
0x7, {{0x401, 0x7, 0x7d, 0x1c, 0xd8, 0xb7, 0x2, 0x3}}}, 0x60)
r3 = openat$cgroup_int(r2, &(0x7f00000001c0)='memory.max\x00', 0x2, 0x0)
write$cgroup_int(r3, &(0x7f00000000c0), 0x12)
