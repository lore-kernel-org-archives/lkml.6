Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5164BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80BB21840
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="FIlSW1pu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80BB21840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeHUUmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:42:01 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46296 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeHUUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:42:00 -0400
Received: by mail-yw1-f65.google.com with SMTP id j131-v6so2634475ywc.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1cwZlKpeAS5YM2rsLA7B0QOciT7iRlPf9f33zXq2+AA=;
        b=FIlSW1puFoQpkQc8KUpYwRxnzfrIbEzogrYaKNCSyxngfshTqturTgGMRYp230ScBX
         fApZNC4ExOA0hLmX+eQo65cTVI8hDL5LCYYCGYdwZAq9XyBimyWzWG8EYHaSC81ZTQs6
         r+yVjZrHL4mjSHeuetYqLtNZsIwIjgt6O2sIGOVs2UTfdJtmp1Ladsl5zKLIRas0CM2j
         0NAKDzPp3pOd/j6QwSahfu1GaM/8EGqHAMzqWnapuQaOAyS1Eqgdmonn/ik3sLK7tLlN
         zJXfS9JGO7G0n+mdq6YBqygMljKwm3aA9QrAU/Uyh0n6VMoqSZwpz0JDz1Ud87OwARLr
         0dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1cwZlKpeAS5YM2rsLA7B0QOciT7iRlPf9f33zXq2+AA=;
        b=X3iGd3mtCkBpnfLkdGOJPQQWguMZDAhZVuUC15eD4ngwIiFZuQ1BGZZyRsWwXsTAak
         TI14wr2+OtaTs0sNWZe+WMstC3Zeer92EtFLIdBKodYkw3kpsKPgxMdiGf+Ac2J8pDcm
         eNRglOWHBTD9V+4qjnRuBnqPf67VJGncH7DFc6obQQMvNITIgW0R4xMhrDwd/uin5FnE
         /bg0szZVumn8G8YbfBnSd1djCIsuZ1XVIx4zEcR2ETef7tD5XzsPNNMXw8jNjDfPcUBl
         Zm7SzbwLgGuNZ5FRTtqggFU4GdcPWi71PrbQxWYRotunAPa7/rpDNUVO0wvLF/lafiEU
         eotQ==
X-Gm-Message-State: AOUpUlE7MYPQzTar1GJRl1tYZYMhAFgEfIUee5xw6e3eqI/uRsTKY0NU
        2YDk1PxBBzufwGnftsayWcKdnA==
X-Google-Smtp-Source: AA+uWPw8EJnAicm3WRvID7fFNN4mRhJMPQYLbQJiKmik/IiOg6sI10ko6i2hHqyvKdJVWw0Qnd2OQQ==
X-Received: by 2002:a81:e203:: with SMTP id p3-v6mr26807783ywl.271.1534872057933;
        Tue, 21 Aug 2018 10:20:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:17a0])
        by smtp.gmail.com with ESMTPSA id s206-v6sm5974726ywc.55.2018.08.21.10.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 10:20:56 -0700 (PDT)
Date:   Tue, 21 Aug 2018 13:20:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] memcg, oom: emit oom report when there is no
 eligible task
Message-ID: <20180821172055.GA23516@cmpxchg.org>
References: <20180808064414.GA27972@dhcp22.suse.cz>
 <20180808071301.12478-1-mhocko@kernel.org>
 <20180808071301.12478-3-mhocko@kernel.org>
 <20180808144515.GA9276@cmpxchg.org>
 <20180808161737.GQ27972@dhcp22.suse.cz>
 <20180821140612.GD16611@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821140612.GD16611@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sent them in a separate thread. Thanks.

On Tue, Aug 21, 2018 at 04:06:12PM +0200, Michal Hocko wrote:
> Do you plan to repost these two? They are quite deep in the email thread
> so they can easily fall through cracks.
> 
> On Wed 08-08-18 18:17:37, Michal Hocko wrote:
> > On Wed 08-08-18 10:45:15, Johannes Weiner wrote:
> [...]
> > > >From bba01122f739b05a689dbf1eeeb4f0e07affd4e7 Mon Sep 17 00:00:00 2001
> > > From: Johannes Weiner <hannes@cmpxchg.org>
> > > Date: Wed, 8 Aug 2018 09:59:40 -0400
> > > Subject: [PATCH] mm: memcontrol: print proper OOM header when no eligible
> > >  victim left
> > > 
> > > When the memcg OOM killer runs out of killable tasks, it currently
> > > prints a WARN with no further OOM context. This has caused some user
> > > confusion.
> > > 
> > > Warnings indicate a kernel problem. In a reported case, however, the
> > > situation was triggered by a non-sensical memcg configuration (hard
> > > limit set to 0). But without any VM context this wasn't obvious from
> > > the report, and it took some back and forth on the mailing list to
> > > identify what is actually a trivial issue.
> > > 
> > > Handle this OOM condition like we handle it in the global OOM killer:
> > > dump the full OOM context and tell the user we ran out of tasks.
> > > 
> > > This way the user can identify misconfigurations easily by themselves
> > > and rectify the problem - without having to go through the hassle of
> > > running into an obscure but unsettling warning, finding the
> > > appropriate kernel mailing list and waiting for a kernel developer to
> > > remote-analyze that the memcg configuration caused this.
> > > 
> > > If users cannot make sense of why the OOM killer was triggered or why
> > > it failed, they will still report it to the mailing list, we know that
> > > from experience. So in case there is an actual kernel bug causing
> > > this, kernel developers will very likely hear about it.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Yes this works as well. We would get a dump even for the race we have
> > seen but I do not think this is something to lose sleep over. And if it
> > triggers too often to be disturbing we can add
> > tsk_is_oom_victim(current) check there.
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > > ---
> > >  mm/memcontrol.c |  2 --
> > >  mm/oom_kill.c   | 13 ++++++++++---
> > >  2 files changed, 10 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 4e3c1315b1de..29d9d1a69b36 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1701,8 +1701,6 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
> > >  	if (mem_cgroup_out_of_memory(memcg, mask, order))
> > >  		return OOM_SUCCESS;
> > >  
> > > -	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
> > > -		"This looks like a misconfiguration or a kernel bug.");
> > >  	return OOM_FAILED;
> > >  }
> > >  
> > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > index 0e10b864e074..07ae222d7830 100644
> > > --- a/mm/oom_kill.c
> > > +++ b/mm/oom_kill.c
> > > @@ -1103,10 +1103,17 @@ bool out_of_memory(struct oom_control *oc)
> > >  	}
> > >  
> > >  	select_bad_process(oc);
> > > -	/* Found nothing?!?! Either we hang forever, or we panic. */
> > > -	if (!oc->chosen && !is_sysrq_oom(oc) && !is_memcg_oom(oc)) {
> > > +	/* Found nothing?!?! */
> > > +	if (!oc->chosen) {
> > >  		dump_header(oc, NULL);
> > > -		panic("Out of memory and no killable processes...\n");
> > > +		pr_warn("Out of memory and no killable processes...\n");
> > > +		/*
> > > +		 * If we got here due to an actual allocation at the
> > > +		 * system level, we cannot survive this and will enter
> > > +		 * an endless loop in the allocator. Bail out now.
> > > +		 */
> > > +		if (!is_sysrq_oom(oc) && !is_memcg_oom(oc))
> > > +			panic("System is deadlocked on memory\n");
> > >  	}
> > >  	if (oc->chosen && oc->chosen != (void *)-1UL)
> > >  		oom_kill_process(oc, !is_memcg_oom(oc) ? "Out of memory" :
> > > -- 
> > > 2.18.0
> > > 
> > 
> > -- 
> > Michal Hocko
> > SUSE Labs
> 
> -- 
> Michal Hocko
> SUSE Labs
