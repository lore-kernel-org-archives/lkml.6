Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5DEC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA2020896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CT3WBpwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA2020896
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936478AbeFOXPn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:15:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35815 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936462AbeFOXPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:15:41 -0400
Received: by mail-pg0-f65.google.com with SMTP id 15-v6so5042422pge.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=O4zJOhXzYF9psfJspK5RetV9CVo1SI2yJD3/s3bce88=;
        b=CT3WBpwvdlLj0BlIQeXZOXq0eHVODaxTZi7N//PqoEtVMbBMFndeRaYa/M3jeHlZH3
         Eu6/cxIbeLEOI1kyVAR2UsaTWgJ5I2ezTGzxC0/NjglHUy0QRKU0/+cnua/huYob22fn
         aBndkyj50k2R8CZhIT6Pml295Sq4EVWEpzhBA9xh8i3CD7uTc0eiOcFJzGCMXAPTO83q
         gmFIwhlPPoJZn5cJOA5SlYU9m5So32vEl8diazH1DIV0BbQv885aq6vCWfE8mOMvPHDj
         2lGZ/3c3mJDUeKbv5US8KdHpkMsZSiwRXxW5nsnDDRcwrT5ijD1NXOh0BEr4QQRF+qzY
         dpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=O4zJOhXzYF9psfJspK5RetV9CVo1SI2yJD3/s3bce88=;
        b=YJA+L5bfUmRfahr+50oS6/43+Y2R1FldxtJJ8grr8nqFidp2VRKQJZdebaann5DDCo
         WEl4e79lZpZ1xf2cIzIEqySI1wjk29qmR3ufa4EOc98pKdXaEi8nejJuxrHUj860ZrMm
         i44pwdRzLLnG0ec/5zQupdTQi7N/A+jxjnf6sdQI4Bui4i1kur6NP3N0qiSJOJSSvOfW
         FpXFlDnIS5hyJkhf5p8wX2tf1+Rj6H9poFTOpYNtCl5prXwAZThKM2HQtLvcd7nIH2CI
         32mBbBwskbsHlmsEY63aHb5lAju5sWkWgvzgoZSEL6LDeO0f5ik2a1qxx3et4yt42wcF
         a2VQ==
X-Gm-Message-State: APt69E0RMnIEsFi2m04yrz7vFdlV4EFNmqerY+I7a4L7FkO7M0rye5uS
        ggvGueq/i9qLHGa347xCZsqq8pot468=
X-Google-Smtp-Source: ADUXVKL5vP5+ixPCwwQpR6xgCmErYFjkADTsv6+DJ4+48jQIYxk3rauSRNl0FofRlQKnY30x3Ictkw==
X-Received: by 2002:a63:b305:: with SMTP id i5-v6mr3340720pgf.370.1529104541010;
        Fri, 15 Jun 2018 16:15:41 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m11-v6sm19790221pfk.42.2018.06.15.16.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 16:15:40 -0700 (PDT)
Date:   Fri, 15 Jun 2018 16:15:39 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <20180615065541.GA24039@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1806151559360.49038@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com> <alpine.DEB.2.21.1806141339580.4543@chino.kir.corp.google.com> <20180615065541.GA24039@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Michal Hocko wrote:

> > Signed-off-by: David Rientjes <rientjes@google.com>
> 
> Nacked-by: Michal Hocko <mhocko@suse.com>
> as already explained elsewhere in this email thread.
> 

I don't find this to be surprising, but I'm not sure that it actually 
matters if you won't fix a regression that you introduced.  Tetsuo 
initially found this issue and presented a similar solution, so I think 
his feedback on this is more important since it would fix a problem for 
him as well.

> > ---
> >  Note: I understand there is an objection based on timeout based delays.
> >  This is currently the only possible way to avoid oom killing important
> >  processes completely unnecessarily.  If the oom reaper can someday free
> >  all memory, including mlocked memory and those mm's with blockable mmu
> >  notifiers, and is guaranteed to always be able to grab mm->mmap_sem,
> >  this can be removed.  I do not believe any such guarantee is possible
> >  and consider the massive killing of additional processes unnecessarily
> >  to be a regression introduced by the oom reaper and its very quick
> >  setting of MMF_OOM_SKIP to allow additional processes to be oom killed.
> 
> If you find oom reaper more harmful than useful I would be willing to
> ack a comman line option to disable it. Especially when you keep
> claiming that the lockups are not really happening in your environment.
> 

There's no need to disable it, we simply need to ensure that it doesn't 
set MMF_OOM_SKIP too early, which my patch does.  We also need to avoid 
setting MMF_OOM_SKIP in exit_mmap() until after all memory has been freed, 
i.e. after free_pgtables().

I'd be happy to make the this timeout configurable, however, and default 
it to perhaps one second as the blockable mmu notifier timeout in your own 
code does.  I find it somewhat sad that we'd need a sysctl for this, but 
if that will appease you and it will help to move this into -mm then we 
can do that.

> Other than that I've already pointed to a more robust solution. If you
> are reluctant to try it out I will do, but introducing a timeout is just
> papering over the real problem. Maybe we will not reach the state that
> _all_ the memory is reapable but we definitely should try to make as
> much as possible to be reapable and I do not see any fundamental
> problems in that direction.

You introduced the timeout already, I'm sure you realized yourself that 
the oom reaper sets MMF_OOM_SKIP much too early.  Trying to grab 
mm->mmap_sem 10 times in a row with HZ/10 sleeps in between is a timeout.  
If there are blockable mmu notifiers, your code puts the oom reaper to 
sleep for HZ before setting MMF_OOM_SKIP, which is a timeout.  This patch 
moves the timeout to reaching exit_mmap() where we actually free all 
memory possible and still allow for additional oom killing if there is a 
very rare oom livelock.

You haven't provided any data that suggests oom livelocking isn't a very 
rare event and that we need to respond immediately by randomly killing 
more and more processes rather than wait a bounded period of time to allow 
for forward progress to be made.  I have constantly provided data showing 
oom livelock in our fleet is extremely rare, less than 0.04% of the time.  
Yet your solution is to kill many processes so this 0.04% is fast.

The reproducer on powerpc is very simple.  Do an mmap() and mlock() the 
length.  Fork one 120MB process that does that and two 60MB processes that 
do that in a 128MB memcg.

[  402.064375] Killed process 17024 (a.out) total-vm:134080kB, anon-rss:122032kB, file-rss:1600kB
[  402.107521] Killed process 17026 (a.out) total-vm:64448kB, anon-rss:44736kB, file-rss:1600kB

Completely reproducible and completely unnecessary.  Killing two processes 
pointlessly when the first oom kill would have been successful.

Killing processes is important, optimizing for 0.04% of cases of true oom 
livelock by insisting everybody tolerate excessive oom killing is not.  If 
you have data to suggest the 0.04% is higher, please present it.  I'd be 
interested in any data you have that suggests its higher and has even 
1/1,000,000th oom occurrence rate that I have shown.

It's inappropriate to merge code that oom kills many processes 
unnecessarily when one happens to be mlocked or have blockable mmu 
notifiers or when mm->mmap_sem can't be grabbed fast enough but forward 
progress is actually being made.  It's a regression, and it impacts real 
users.  Insisting that we fix the problem you introduced by making all mmu 
notifiers unblockable and mlocked memory can always be reaped and 
mm->mmap_sem can always be grabbed within a second is irresponsible.
