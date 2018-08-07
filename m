Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5827EC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE642178F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRnVC1JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE642178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbeHGNcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:32:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44602 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387428AbeHGNcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:32:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so8425050pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xEunR8h7kTAri2czS2wEqwwhBlxTZ1FSjtq+lR7omZY=;
        b=YRnVC1JPiomjmU6jtaNzztItsyGMVgDHNM1b8aVxVn8s3893Qin2hkjqzn6omTusMC
         EJhC3fmDFL/y7FIcWzFSIG22KGEFov3q2aV11VpoBbty5kl9Htm25n31WsJi2h8N+G+H
         7UJfYM3Ay7CT0V6iKvqKF89zx8grMSzoyspyc0mVdN8qjqcu1rdSrTsqIqohNzZxNMfy
         6P17AU3g7oMUjacL2Oq8MlkMvMDyVlbHTjTzTuWjjg5+bMmrXCDa0RK6NPBn+b//9sNl
         RTS22I0qONuimA7QzcY3wID8H2YE7g2bzuSxXLGeEsIRL3ScgZ/KnJYL17uEIRnXNYHs
         6fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xEunR8h7kTAri2czS2wEqwwhBlxTZ1FSjtq+lR7omZY=;
        b=UytkiKl/InsQeU/CzlSpqG/JpYEc0fYNbaQJKhCN3GlZhydw394cb4p1WSyBtwXClB
         Dx4i+3x0i/P9XGa3xu8rHccyoPFDPTM1xOjrH8/GRRXsxh215eI3IunNiol39ABgY/N9
         SgwoUt/vOZuMrc12win3UdHiXY2QfQIuy89GYW3lAWDh/u39btBTJfxGlyHMTq3AdbER
         UmYP6yCM4irPEoEdxvrzHvsYc7L294GkS8roAzpNFIf88ys2u1/sniPovZ8eLlsFpYap
         qbb2ZqtWIXy/dSKH0WPON2HWi1y136rA6+D2WfnbgHPkOZcx5BJygxCCr9ha/GhgvbJb
         GyOA==
X-Gm-Message-State: AOUpUlHQMuXLo+WjYXYg1xzOGxH/DMAYVb2rkZxIAyeFPrBVDwZQLk4d
        EzN6KWcbSC2H3xxA/tXjTpxD8d8g1wBVb424p6kHB0yq
X-Google-Smtp-Source: AAOMgpd2l9SGr2HkLpoptKsY98gFLynLs3u2HyrKTmyNapMmNYMZLnFLFNKF0aCygvHAM5z2wYmolv8jT65EuOS3ZaQ=
X-Received: by 2002:a62:3184:: with SMTP id x126-v6mr21587302pfx.49.1533640701621;
 Tue, 07 Aug 2018 04:18:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 7 Aug 2018 04:18:00
 -0700 (PDT)
In-Reply-To: <20180806185554.GG10003@dhcp22.suse.cz>
References: <20180806181339.GD10003@dhcp22.suse.cz> <0000000000002ec4580572c85e46@google.com>
 <20180806185554.GG10003@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Aug 2018 13:18:00 +0200
Message-ID: <CACT4Y+Zg3DhAnKWBAyJ-Y-3XVL+jCQy1U2iWR8mdraX6w23X_Q@mail.gmail.com>
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

On Mon, Aug 6, 2018 at 8:55 PM, Michal Hocko <mhocko@kernel.org> wrote:
> The debugging patch was wrong but I guess I see it finally.
> It's a race
>
> : [   72.901666] Memory cgroup out of memory: Kill process 6584 (syz-executor1) score 550000 or sacrifice child
> : [   72.917037] Killed process 6584 (syz-executor1) total-vm:37704kB, anon-rss:2140kB, file-rss:0kB, shmem-rss:0kB
> : [   72.927256] task=syz-executor5 pid=6581 charge bypass
> : [   72.928046] oom_reaper: reaped process 6584 (syz-executor1), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> : [   72.932818] task=syz-executor6 pid=6576 invoked memcg oom killer. oom_victim=1
> : [   72.942790] task=syz-executor5 pid=6581 charge for nr_pages=1
> : [   72.949769] syz-executor6 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
> : [   72.955606] task=syz-executor5 pid=6581 charge bypass
> : [   72.967394] syz-executor6 cpuset=/ mems_allowed=0
> : [   72.973175] task=syz-executor5 pid=6581 charge for nr_pages=1
> : [...]
> : [   73.534865] Task in /ile0 killed as a result of limit of /ile0
> : [   73.540865] memory: usage 76kB, limit 0kB, failcnt 260
> : [   73.546142] memory+swap: usage 0kB, limit 9007199254740988kB, failcnt 0
> : [   73.552898] kmem: usage 0kB, limit 9007199254740988kB, failcnt 0
> : [   73.559051] Memory cgroup stats for /ile0: cache:0KB rss:0KB rss_huge:0KB shmem:0KB mapped_file:0KB dirty:0KB writeback:0KB swap:0KB inactive_anon:0KB active_anon:0KB inactive_file:0KB active_file:0KB unevictable:0KB
> : [   73.578533] Tasks state (memory values in pages):
> : [   73.583404] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> : [   73.592277] [   6569]     0  6562     9427        1    53248        0             0 syz-executor0
> : [   73.601299] [   6576]     0  6576     9426        0    61440        0             0 syz-executor6
> : [   73.610333] [   6578]     0  6578     9426      534    61440        0             0 syz-executor4
> : [   73.619381] [   6579]     0  6579     9426        0    57344        0             0 syz-executor5
> : [   73.628414] [   6582]     0  6582     9426        0    61440        0             0 syz-executor7
> : [   73.637441] [   6584]     0  6584     9426        0    57344        0             0 syz-executor1
> : [   73.646464] Memory cgroup out of memory: Kill process 6578 (syz-executor4) score 549000 or sacrifice child
> : [   73.656295] task=syz-executor6 pid=6576 is oom victim now
>
> This should be 6578 but we at least know that we are running in 6576
> context so the we are setting the state from a remote context which
> itself has been killed already
>
> : [   73.661841] Killed process 6578 (syz-executor4) total-vm:37704kB, anon-rss:2136kB, file-rss:0kB, shmem-rss:0kB
> : [   73.672035] task=syz-executor6 pid=6576 charge bypass
> : [   73.672801] oom_reaper: reaped process 6578 (syz-executor4), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> : [   73.678829] task=syz-executor4 pid=6578 invoked memcg oom killer. oom_victim=1
>
> and here the victim finally reached the oom path finally.
>
> : [   73.687453] task=syz-executor6 pid=6576 charge for nr_pages=1
> : [   73.694534] ------------[ cut here ]------------
> : [   73.700424] task=syz-executor6 pid=6576 charge bypass
> : [   73.705175] Memory cgroup charge failed because of no reclaimable memory! This looks like a misconfiguration or a kernel bug.
> : [   73.705321] WARNING: CPU: 1 PID: 6578 at mm/memcontrol.c:1707 try_charge+0xafa/0x1710
>
> But there is nobody killable. So the oom kill happened _after_ our force
> charge path. Therefore we should do the following regardless whether we
> make tis warn or pr_$foo

Great we are making progress here!

So if it's something to fix in kernel we just leave WARN alone. It
served its intended purpose of notifying kernel developers about
something to fix in kernel. And as you noted 0 is not actually special
in this context anyway. I misunderstood how exactly misconfiguration
is involved here.


> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 116b181bb646afedd770985de20a68721bdb2648
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4603ad75c9a9..1b6eed1bc404 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1703,7 +1703,8 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>                 return OOM_ASYNC;
>         }
>
> -       if (mem_cgroup_out_of_memory(memcg, mask, order))
> +       if (mem_cgroup_out_of_memory(memcg, mask, order) ||
> +                       tsk_is_oom_victim(current))
>                 return OOM_SUCCESS;
>
>         WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
> --
> Michal Hocko
> SUSE Labs
