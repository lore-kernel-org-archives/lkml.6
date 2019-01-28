Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E370CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE2E20882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkF4vZ+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfA1HVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:21:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46961 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1HVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:21:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so13244376ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HX9DrjaX6jIlcMNKOK6cpFkCuRAnrM2CggdxTNRpSqA=;
        b=MkF4vZ+5NAnPAXDOCONNUA0Co9mOXxXPysO0CcNiMaRoKg/O9+PiI3dcL+ohWUUldX
         gm5t0Blg4glGlu75zgtrhwe5jVZa0e0XZ6HEmtWNWrzx03U1/zVh0uM1wRe1/Pv5DXqz
         bNvlmUw8p8Ake+sZc3bCfOOMQfrEDpSJFpagJaKOfGWFC2nm718iEXCOOf/bfzR2ebS9
         C7cnlWA9zbPQzTyG7rtpwowUqJFiNyj6aukxwIWEHTXsiMMqvaPIaDn/8R4/6LuLHVyg
         FURZrMoLKzKE3ABa4PVpXaGBkR6upf8PKq/MCU0ImEexBmchxTKLrEsgWiHmoLKBZjtn
         UokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HX9DrjaX6jIlcMNKOK6cpFkCuRAnrM2CggdxTNRpSqA=;
        b=DL1wBIqm5dhRSVB1vS/8Y5j16y48Q+Hou9XJkAXeQuQnMeVjc8223Z/J09cacspTKu
         51oRG6kpznumJE5IgqBdGT25/fyCJsus325MVhnpqeYOlJHA3q5WCQ36Is2nhhjMJ7TK
         xxyg9IJXKRKeNOH4QSHOPN3P1epXk/i7lrzqGk3S+zzNDQNV0ClUhc4gtdp6+JH2rfIx
         j3F52ZVTy28fNicPgzoX+ufVxJHXg1SNfGrXeIN68awfbwtFRHWzf/kz9KTo0VVJ1eoH
         QFGHxVpEGmzX+pElBMUOlSQPRvZHBzsHu9KwnKOvuKSgKzxITVeGL0gkZvb9hRWyNywa
         CUpQ==
X-Gm-Message-State: AJcUukeVKjW2AmP2g+TNdBUjBGOjrHTu+U87tQafc3xRrTV0abyC9Aby
        /QWsrrIiVEz3ZrsEpMbaA12vc5ibKk1oit0RcdQ=
X-Google-Smtp-Source: ALg8bN60uTRCwfcOm+3bckq9p8Ju8XytbC1MMXtAW6zXzejd6DF2sPPaZTC5R5gIhRMLmMgBjsTb9H7ddoc1YdeOS3Q=
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr16101004ljb.11.1548660077825;
 Sun, 27 Jan 2019 23:21:17 -0800 (PST)
MIME-Version: 1.0
References: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com>
 <3680160f-a439-02a3-3d40-56de18096c4b@linux.alibaba.com> <CAHCio2iYoKOSgxJWFX6KcRcn7GK=aEJP7Sz0vU6SwXK2C56mew@mail.gmail.com>
 <6625b261-d199-6b37-de65-1b576dcbad5b@linux.alibaba.com>
In-Reply-To: <6625b261-d199-6b37-de65-1b576dcbad5b@linux.alibaba.com>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Mon, 28 Jan 2019 15:21:06 +0800
Message-ID: <CAHCio2jP7mZpE6sAb_Rewbc2nx4s0NY3sOYmsF69EqE4Ysbo=w@mail.gmail.com>
Subject: Re: [PATCH] sched/debug: Show intergroup and hierarchy sum wait time
 of a task group
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Wind Yu <yuzhoujian@didichuxing.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael
> Task competition inside a cgroup won't be considered as cgroup's
> competition, please try create another cgroup with dead loop on
> each CPU

Yes, you are right, but I don't think we just need to account for
cgroup's competition,
because this factor does not reflect cgroup internal conditions. We
still need a proper
method to evaluate CPU competition inside a cgroup.


> Running tasks doesn't means no competition, only if that cgroup occupied
> the CPU exclusively at that moment.

I care much about CPU competiton inside a cgroup. I can only read
'/proc/$pid/schedstat'
thousands of times to get every task's wait_sum time without cgroup
hierarchy wait_sum,
and it definitely tasks a real long time(40ms for 8000 tasks in a container).


> No offense but I'm afraid you misunderstand the problem we try to solve
> by wait_sum, if your purpose is to have a way to tell whether there are
> sufficient CPU inside a container, please try lxcfs + top, if there are
> almost no idle and load is high, then the CPU resource is not sufficient.

emmmm... Maybe I didn't make it clear.  We need to dynamically adjust the
number of CPUs for a container based on the running state of tasks inside
the container. If we find tasks' wait_sum are really high, we will add more
CPU cores to this container, or else we will decline some CPU to this container.
In a word, we want to ensure 'co-scheduling' for high priority containers.


>Frankly speaking this sounds like a supplement rather than a missing piece,
>although we don't rely on lxcfs and modify the kernel ourselves to support
>container environment, I still don't think such kind of solutions should be
>in kernel.

I don't care if this value is considered as a supplement or a missing piece. I
only care about how can I assess the running state inside a container. I think
lxcfs is really a good solution to improve the visibility of container
resources,
but it is not good enough at the moment.

/proc/cpuinfo
/proc/diskstats
/proc/meminfo
/proc/stat
/proc/swaps
/proc/uptime

we can read this procfs file inside a container,but this file still
cannot reflect
real-time information. Please think about the following scenario: a
'rabbit' process
will generate 2000 tasks in every 30ms, and these children tasks just run 1~5ms
and then exit. How can we detect this thrashing workload without
hierarchy wait_sum?

Thanks,
Yuzhoujian
