Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA946C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53642208B2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duSx2EBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53642208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbeHAXjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:39:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33247 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbeHAXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:39:18 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so56661plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jaiYN2nq/R4X6SQlAiHW/fz8SIOOLoZDLRie+m/efFE=;
        b=duSx2EBo0hJkgjv7iTTr5QuD/I/0CpUSI39Cl8nMrCHgIz3Dqn6FhuEHnQr0UqEu6T
         Rxwr1JFjuUCZgMkAOHihSgc7BZ1lzobG88V66gt8/LUCwIowJxUxgRAhOCqijgq/nhfN
         ZB98zH7bsl8P5N21S0I9c9QFuzcC8Dc/01yXBTTUJBXeSjvfS0+iNDJkf87Z5AbwF0vQ
         L8dAKLO81E5g1ONzwU8Be0U+15c/reFWqORJjs+8EDHaIQnApN+xf8fywL8g4bKyz9p1
         AqKexnhxIQ5yV+SCTtgM3h9kRD/4tLY2acImXpnxrTOew9OPv2DU29uPLpw0lxlzjlRz
         bmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jaiYN2nq/R4X6SQlAiHW/fz8SIOOLoZDLRie+m/efFE=;
        b=FxEMowNi5ZZm464ucA3nwdqfiwhKWBipzNuAzHmHav6DH57lhrYXIwKCJUv5SrSCe0
         7zMQsp2ttBXNpiCMleuVYEy2OQrpM2ewGPLLD5xHrMvSEL5JEevbiBscpbPQlzroxpG+
         Z1ZDmI6WohjjoPUrcIgkarhiygASBOsN/EXsVkJv9qgcCp+DAba1plVVs04wWAqumjAe
         oLlvlHNCfJrnkc+uPcj+h33+Gd3D8Wbx05rqnccfZdZS7VKGKCpzoFZzlRpcWouTKThH
         OGExFSMiOQduMPHhMtbVwF+XKi6ElRfptVABkqySbXLXJP6T5tNUoTrD0mhRBv1YpLOe
         qVDA==
X-Gm-Message-State: AOUpUlGH9b0hkOchQg4wI6zwywj6RE5Vcodhk3wcpR2vreDlTl24dARP
        3zi/cWlNAGiRDmEWamNir9crYA==
X-Google-Smtp-Source: AAOMgpds4Ul19/z1y5UbHK4RwXNquF/M0Nc7j9KVOv1BHuVtioktykaToS850s4enGy3R34p4QrBaw==
X-Received: by 2002:a17:902:bb0d:: with SMTP id l13-v6mr81344pls.5.1533160286914;
        Wed, 01 Aug 2018 14:51:26 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 16-v6sm53394pfo.164.2018.08.01.14.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 14:51:26 -0700 (PDT)
Date:   Wed, 1 Aug 2018 14:51:25 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Roman Gushchin <guro@fb.com>
cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] introduce memory.oom.group
In-Reply-To: <20180731235135.GA23436@castle.DHCP.thefacebook.com>
Message-ID: <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
References: <20180730180100.25079-1-guro@fb.com> <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com> <20180731235135.GA23436@castle.DHCP.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018, Roman Gushchin wrote:

> > What's the plan with the cgroup aware oom killer?  It has been sitting in 
> > the -mm tree for ages with no clear path to being merged.
> 
> It's because your nack, isn't it?
> Everybody else seem to be fine with it.
> 

If they are fine with it, I'm not sure they have tested it :)  Killing 
entire cgroups needlessly for mempolicy oom kills that will not free 
memory on target nodes is the first regression they may notice.  It also 
unnecessarily uses oom_score_adj settings only when attached to the root 
mem cgroup.  That may be fine in very specialized usecases but your bash 
shell being considered equal to a 96GB cgroup isn't very useful.  These 
are all fixed in my follow-up patch series which you say you have reviewed 
later in this email.

> > Are you planning on reviewing the patchset to fix the cgroup aware oom 
> > killer at https://marc.info/?l=linux-kernel&m=153152325411865 which has 
> > been waiting for feedback since March?
> > 
> 
> I already did.
> As I said, I find the proposed oom_policy interface confusing.
> I'm not sure I understand why some memcg OOMs should be handled
> by memcg-aware OOMs, while other by the traditional per-process
> logic; and why this should be set on the OOMing memcg.
> IMO this adds nothing but confusion.
> 

If your entire review was the email to a single patch, I misinterpreted 
that as the entire review not being done, sorry.  I volunteered to 
separate out the logic to determine if a cgroup should be considered on 
its own (kill the largest cgroup on the system) or whether to consider 
subtree usage as well into its own tunable.  I haven't received an 
answer, yet, but it's a trivial patch on top of my series if you prefer.  
Just let me know so we can make progress.

> it doesn't look nice to me (neither I'm fan of the mount option).
> If you need an option to evaluate a cgroup as a whole, but kill
> only one task inside (the ability we've discussed before),
> let's make it clear. It's possible with the new memory.oom.group.
> 

The purpose is for subtrees delegated to users so that they can continue 
to expect the same process being oom killed, with oom_score_adj 
respected, even though the ancestor oom policy is for cgroup aware 
targeting.  It is perfectly legitimate, and necessary, for a user who 
controls their own subtree to prefer killing of the single largest process 
as it has always been done.  Secondary to that is their ability to 
influence the decision with oom_score_adj, which they lose without my 
patches.

> Patches which adjust root memory cgroup accounting and NUMA
> handling should be handled separately, they are really not
> about the interface. I've nothing against them.
> 

That's good to know, it would be helpful if you would ack the patches that 
you are not objecting to.  Your feedback about the overloading of "cgroup" 
and "tree" is well received and I can easily separate that into a tunable 
as I said.  I do not know of any user that would want to specify "tree" 
without having cgroup aware behavior, however.  If you would prefer this, 
please let me know!

> Anyway, at this point I really think that this patch (memory.oom.group)
> is a reasonable way forward. It implements a useful and complete feature,
> doesn't block any further development and has a clean interface.
> So, you can build memory.oom.policy on top of it.
> Does this sound good?
> 

I have no objection to this series, of course.  The functionality of group 
oom was unchanged in my series.  I'd very much appreciate a review of my 
patchset, though, so the cgroup-aware policy can be merged as well.
