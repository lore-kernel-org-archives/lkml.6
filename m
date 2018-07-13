Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72176ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010D8208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Efte97/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010D8208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbeGMWQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:16:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46873 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeGMWQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:16:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so23326182pfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+DENwK4lkCnJMvCIXw6fud1Fyp78X4KXSPKJLfYtvXc=;
        b=Efte97/gBjn/+D4ZQhrjfhi2NLUL/U5RfkolzZ/7+WnVX/zuZmP4EgSbySZUmrqDRT
         nzfp2ENl37woS+lcz+AZhQIhbazCWe80pMSzWzD/TR8sMnbTq0l1jSbeYyRkSd/+0FZH
         P4aBaxbQ4/qOJts7P9mWQi87Z6A7mhzGBzFm9MC3dB9taU7JAtwTWQ/Mi8ZtfjNTr2jq
         WzH5iPW1jIRq7co5dRQPjjS+PBOAtoVZ7Y0Zi9n+d23CgtRY+qfKX6u6lgvR4YDT0iry
         nT7jiZonn1NmRrCIodch0pID+Zb4Z6yigMpPDoQ0vHTbLW0CeUta7sdNFHkBOpzxrNxh
         RbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+DENwK4lkCnJMvCIXw6fud1Fyp78X4KXSPKJLfYtvXc=;
        b=M0ti1uLH3yvAUKaehWFwxF79YEkyxrtWkCd2+IxXOeeKh/LiX3TaezZmXB0UgLdeZb
         lxjpzV1uYU7ausl/8K8FkdyXT8pDNR5I34TZwkma7wvchu/612Jhl48EbVF/BFKjNMqR
         d58f2mUepJuX6ZAPNGNu3d9C9eNmY/wi2ZELMOKrQPrQLRifEdswZqJ9amUbLI0cxHe5
         6W6I2pxsWYhd5J4H7eyll48SmRYizBcZalV1nNGjqq8NpAIRnA1OVyarkyffIKs6yjq+
         InQvD+1V9/MTCu1fX88qsHCzVsfGPXllrXL6I0fKa1h71W3OQN48dOmO6D3XOsXBtHVl
         lebg==
X-Gm-Message-State: AOUpUlF92CzIFE6/qT4HekN8a4It7rF/I8+fepCtXjO0p9ku/dlcoWOZ
        4KKUJIV1Pq3tuGIjIvvxNCElgst1rMa3WOD3F9QYRVJrWOz48XRxhhBZ72MSADdseBXsSqGJamU
        ZXt/Nr/rO1vRFwRI=
X-Google-Smtp-Source: AAOMgpexxCfrTRthYRVhVdqr69GRrevH699iSoNH3coiGjWHWBki+FllLFOlhjJgrpexgNh//W9ZKw==
X-Received: by 2002:a63:a5c:: with SMTP id z28-v6mr7541682pgk.209.1531519201081;
        Fri, 13 Jul 2018 15:00:01 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z4-v6sm30494987pfl.11.2018.07.13.14.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 15:00:00 -0700 (PDT)
Date:   Fri, 13 Jul 2018 14:59:59 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Roman Gushchin <guro@fb.com>, linux-mm@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 0/7] cgroup-aware OOM killer
In-Reply-To: <20180605114729.GB19202@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1807131438380.194789@chino.kir.corp.google.com>
References: <20171130152824.1591-1-guro@fb.com> <20180605114729.GB19202@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018, Michal Hocko wrote:

> 1) comparision root with tail memcgs during the OOM killer is not fair
> because we are comparing tasks with memcgs.
> 
> This is true, but I do not think this matters much for workloads which
> are going to use the feature. Why? Because the main consumers of the new
> feature seem to be containers which really need some fairness when
> comparing _workloads_ rather than processes. Those are unlikely to
> contain any significant memory consumers in the root memcg. That would
> be mostly common infrastructure.
> 

There are users (us) who want to use the feature and not all processes are 
attached to leaf mem cgroups.  The functionality can be provided in a 
generally useful way that doesn't require any specific hierarchy, and I 
implemented this in my patch series at 
https://marc.info/?l=linux-mm&m=152175563004458&w=2.  That proposal to fix 
*all* of my concerns with the cgroup-aware oom killer as it sits in -mm, 
in it's entirety, only extends it so it is generally useful and does not 
remove any functionality.  I'm not sure why we are discussing ways of 
moving forward when that patchset has been waiting for review for almost 
four months and, to date, I haven't seen an objection to.

I don't know why we cannot agree on making solutions generally useful nor 
why that patchset has not been merged into -mm so that the whole feature 
can be merged.  It's baffling.  This is the first time I've encountered a 
perceived stalemate when there is a patchset sitting, unreviewed, that 
fixes all of the concerns that there are about the implementation sitting 
in -mm.

This isn't a criticism just of comparing processes attached to root 
differently than leaf mem cgroups, it's how oom_score_adj influences that 
decision.  It's trivial for a very small consumer (not "significant" 
memory consumer, as you put it) to require an oom kill from root instead 
of a leaf mem cgroup.  I show in 
https://marc.info/?l=linux-mm&m=152175564104468&w=2 that changing the 
oom_score_adj of my bash shell attached to the root mem cgroup is 
considered equal to a 95GB leaf mem cgroup with the current 
implementation.

> Is this is fixable? Yes, we would need to account in the root memcgs.
> Why are we not doing that now? Because it has some negligible
> performance overhead. Are there other ways? Yes we can approximate root
> memcg memory consumption but I would rather wait for somebody seeing
> that as a real problem rather than add hacks now without a strong
> reason.
> 

I fixed this in https://marc.info/?t=152175564500007&r=1&w=2, and from 
what I remmeber Roman actually liked it.

> 2) Evading the oom killer by attaching processes to child cgroups which
> basically means that a task can split up the workload into smaller
> memcgs to hide their real memory consumption.
> 
> Again true but not really anything new. Processes can already fork and
> split up the memory consumption. Moreover it doesn't even require any
> special privileges to do so unlike creating a sub memcg. Is this
> fixable? Yes, untrusted workloads can setup group oom evaluation at the
> delegation layer so all subgroups would be considered together.
> 

Processes being able to fork to split up memory consumption is also fixed 
by https://marc.info/?l=linux-mm&m=152175564104467 just as creating 
subcontainers to intentionally or unintentionally subverting the oom 
policy is fixed.  It solves both problems.

> 3) Userspace has zero control over oom kill selection in leaf mem
> cgroups.
> 
> Again true but this is something that needs a good evaluation to not end
> up in the fiasko we have seen with oom_score*. Current users demanding
> this feature can live without any prioritization so blocking the whole
> feature seems unreasonable.
> 

One objection here is how the oom_score_adj of a process means something 
or doesn't mean something depending on what cgroup it is attached to.  The 
cgroup-aware oom killer is cgroup aware.  oom_score_adj should play no 
part.  I fixed this with https://marc.info/?t=152175564500007&r=1&w=2.  
The other objection is that users do have cgroups that shouldn't be oom 
killed because they are important, either because they are required to 
provide a service for a smaller cgroup or because of business goals.  We 
have cgroups that use more than half of system memory and they are allowed 
to do so because they are important.  We would love to be able to bias 
against that cgroup to prefer others, or prefer cgroups for oom kill 
because they are less important.  This was done for processes with 
oom_score_adj, we need it for a cgroup aware oom killer for the same 
reason.

But notice even in https://marc.info/?l=linux-mm&m=152175563004458&w=2 
that I said priority or adjustment can be added on top of the feature 
after it's merged.  This itself is not precluding anything from being 
merged.

> 4) Future extensibility to be backward compatible.
> 
> David is wrong here IMHO. Any prioritization or oom selection policy
> controls added in future are orthogonal to the oom_group concept added
> by this patchset. Allowing memcg to be an oom entity is something that
> we really want longterm. Global CGRP_GROUP_OOM is the most restrictive
> semantic and softening it will be possible by a adding a new knob to
> tell whether a memcg/hierarchy is a workload or a set of tasks.

I've always said that the mechanism and policy in this patchset should be 
separated.  I do that exact thing in 
https://marc.info/?l=linux-mm&m=152175564304469&w=2.  I suggest that 
different subtrees will want (or the admin will require) different 
behaviors with regard to the mechanism.


I've stated the problems (and there are others wrt mempolicy selection) 
that the current implementation has and given a full solution at 
https://marc.info/?l=linux-mm&m=152175563004458&w=2 that has not been 
reviewed.  I would love feedback from anybody on this thread on that.  I'm 
not trying to preclude the cgroup-aware oom killer from being merged, I'm 
the only person actively trying to get it merged.

Thanks.
