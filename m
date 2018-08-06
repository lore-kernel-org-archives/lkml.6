Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF804C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC73219F3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="he9gF4mN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC73219F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbeHFLjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:39:11 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38907 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbeHFLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:39:11 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so5428860plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dwo9GDNFpjq9wCc/raB1AE96I/rdXmgsICB5oxTGYIc=;
        b=he9gF4mNtCabbTXQrFmsKy3bGkaog+eOsjdX0m4JBrcRQBGbnamwIaqDhA02809h0n
         jnr1gdkAAXgwSyLl7V08Tb7nxnT7Sxij8IabJ0nTeQGezqf/2H4N9TRnOAoWB3QmVyiG
         iSpY0SqM3i5WNJ/vG6Rb91VyTYTqB1pt+8F3f1IGLImpfx5rYxKkPTFHhugBGHdDGwqd
         6MhUA12uuRV2cFyH6Dx/UTvDMI7Tm0uEnF3NBQyxlyKArNzjvD/KzSxvHrgKUZYxh7aS
         /txHGBT5JA+IuIXS259r9dvSPiMXky/yPOI4OktYu95DexsDkUzvl19rzSw8nRXYnILn
         OeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dwo9GDNFpjq9wCc/raB1AE96I/rdXmgsICB5oxTGYIc=;
        b=pkCMeI3UqQpolhi+paq5qgEpr/EAQRcHjD0LHHBBAlm0hmEfwrYrgxEFQ7LJXXAkKQ
         XU1Pr5bSYHXxqYrCr1oapdzTdzvIh/wTywZekRj5Vo7Bd691enW7dl3AhwVsxk/lEVF9
         k/jLQon3GWUyANS70ybFFBL5zAL/ytFb+bGytCd2MsTsSkh53TVLVbJ3u0tp9KI38BWp
         89WKRozrvdgpXB/dWtbeclrFOxhgFtlCgsGjKLxW+HZleCx2NJ64ree4mdGfKclfcbwi
         j9BQ2eDQe5NdqUm/bdsalU8qulbg2D47sgBvFo6+KTGQih+fw3xh5QbdJTfy5nfO2wao
         J2oQ==
X-Gm-Message-State: AOUpUlEI6bPRLUvYAuUCVWLghmSl4AheECSDjlLAvJZLBjJjVvErDQGj
        CRqSTMah+TAJ7iEvh+AQuKof8qWtKNwxEgMOhIcOLLsXqoM=
X-Google-Smtp-Source: AAOMgpecIUe6n3BhmsG4uMnAlbjKA6LVOSfXKlklM97yayq7lZPzeYSFxZcXjRNPeI5p+tI1L0DvLdTKsBwlmwKx4pk=
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr13191352pll.85.1533547858195;
 Mon, 06 Aug 2018 02:30:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 6 Aug 2018 02:30:37
 -0700 (PDT)
In-Reply-To: <20180806091552.GE19540@dhcp22.suse.cz>
References: <0000000000005e979605729c1564@google.com> <20180806091552.GE19540@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Aug 2018 11:30:37 +0200
Message-ID: <CACT4Y+Ystnwv4M6Uh+HBKbdADAnJ6otfR0GoA20crzqV+b2onQ@mail.gmail.com>
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 11:15 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Sat 04-08-18 06:33:02, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    d1e0b8e0cb7a Add linux-next specific files for 20180725
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15a1c770400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=eef3552c897e4d33
>> dashboard link: https://syzkaller.appspot.com/bug?extid=bab151e82a4e973fa325
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com
>>
>> Killed process 23767 (syz-executor2) total-vm:70472kB, anon-rss:104kB,
>> file-rss:32768kB, shmem-rss:0kB
>> oom_reaper: reaped process 23767 (syz-executor2), now anon-rss:0kB,
>> file-rss:32000kB, shmem-rss:0kB
>
> More interesting stuff is higher in the kernel log
> : [  366.435015] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/ile0,task_memcg=/ile0,task=syz-executor3,pid=23766,uid=0
> : [  366.449416] memory: usage 112kB, limit 0kB, failcnt 1605
>
> Are you sure you want to have hard limit set to 0?

syzkaller really does not mind to have it.

> : [  366.454963] memory+swap: usage 0kB, limit 9007199254740988kB, failcnt 0
> : [  366.461787] kmem: usage 0kB, limit 9007199254740988kB, failcnt 0
> : [  366.467946] Memory cgroup stats for /ile0: cache:12KB rss:0KB rss_huge:0KB shmem:0KB mapped_file:0KB dirty:0KB writeback:0KB swap:0KB inactive_anon:0KB active_anon:0KB inactive_file:0KB active_file:0KB unevictable:0KB
>
> There are only 3 pages charged to this memcg!
>
> : [  366.487490] Tasks state (memory values in pages):
> : [  366.492349] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> : [  366.501237] [  23766]     0 23766    17620     8221   126976        0             0 syz-executor3
> : [  366.510367] [  23767]     0 23767    17618     8218   126976        0             0 syz-executor2
> : [  366.519409] Memory cgroup out of memory: Kill process 23766 (syz-executor3) score 8252000 or sacrifice child
> : [  366.529422] Killed process 23766 (syz-executor3) total-vm:70480kB, anon-rss:116kB, file-rss:32768kB, shmem-rss:0kB
> : [  366.540456] oom_reaper: reaped process 23766 (syz-executor3), now anon-rss:0kB, file-rss:32000kB, shmem-rss:0kB
>
> The oom reaper cannot reclaim file backed memory  from a large part. I
> assume this is are shared mappings which are living outside of memcg
> because of the counter.
>
> : [...]
> : [  367.085870] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/ile0,task_memcg=/ile0,task=syz-executor2,pid=23767,uid=0
> : [  367.100073] memory: usage 112kB, limit 0kB, failcnt 1615
> : [  367.105549] memory+swap: usage 0kB, limit 9007199254740988kB, failcnt 0
> : [  367.112428] kmem: usage 0kB, limit 9007199254740988kB, failcnt 0
> : [  367.118593] Memory cgroup stats for /ile0: cache:12KB rss:0KB rss_huge:0KB shmem:0KB mapped_file:0KB dirty:0KB writeback:0KB swap:0KB inactive_anon:0KB active_anon:0KB inactive_file:0KB active_file:0KB unevictable:0KB
> : [  367.138136] Tasks state (memory values in pages):
> : [  367.142986] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> : [  367.151889] [  23766]     0 23766    17620     8002   126976        0             0 syz-executor3
> : [  367.160946] [  23767]     0 23767    17618     8218   126976        0             0 syz-executor2
> : [  367.169994] Memory cgroup out of memory: Kill process 23767 (syz-executor2) score 8249000 or sacrifice child
> : [  367.180119] Killed process 23767 (syz-executor2) total-vm:70472kB, anon-rss:104kB, file-rss:32768kB, shmem-rss:0kB
> : [  367.192101] oom_reaper: reaped process 23767 (syz-executor2), now anon-rss:0kB, file-rss:32000kB, shmem-rss:0kB
> : [  367.202986] ------------[ cut here ]------------
> : [  367.207845] Memory cgroup charge failed because of no reclaimable memory! This looks like a misconfiguration or a kernel bug.
> : [  367.207965] WARNING: CPU: 1 PID: 23767 at mm/memcontrol.c:1710 try_charge+0x734/0x1680
> : [  367.227540] Kernel panic - not syncing: panic_on_warn set ...
>
> This is unexpected though. We have killed a task (23767) which is trying
> to charge the memory which means it should
> trigger the charge retry and that one should force the charge
>
>         /*
>          * Unlike in global OOM situations, memcg is not in a physical
>          * memory shortage.  Allow dying and OOM-killed tasks to
>          * bypass the last charges so that they can exit quickly and
>          * free their memory.
>          */
>         if (unlikely(tsk_is_oom_victim(current) ||
>                      fatal_signal_pending(current) ||
>                      current->flags & PF_EXITING))
>                 goto force;
>
> There doesn't seem to be any other sign of OOM killer invocation which
> could then indeed lead to the warning as there is no other task to kill
> (both syz-executor[23] have been killed and oom_reaped already). So I
> would be curious what happened between 367.180119 which was the last
> successful oom invocation and 367.207845. An additional printk in
> mem_cgroup_out_of_memory might tell us more.
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4603ad75c9a9..852cd3dbdcd9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1388,6 +1388,8 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>         bool ret;
>
>         mutex_lock(&oom_lock);
> +       pr_info("task=%s pid=%d invoked memcg oom killer. oom_victim=%d\n",
> +                       current->comm, current->pid, tsk_is_oom_victim(current));
>         ret = out_of_memory(&oc);
>         mutex_unlock(&oom_lock);
>         return ret;
>
> Anyway your memcg setup is indeed misconfigured. Memcg with 0 hard limit
> and basically no memory charged by existing tasks is not going to fly
> and the warning is exactly to call that out.


Please-please-please do not mix kernel bugs and notices to user into
the same bucket:

https://lore.kernel.org/patchwork/patch/949071/
