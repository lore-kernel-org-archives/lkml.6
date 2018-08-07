Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC60EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF37219DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I26pjw5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF37219DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeHHAvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:51:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44426 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeHHAvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:51:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so96708pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7uFWkrPEYepwRsZTpZ2ZfcbtcOmdzkneDblSQ8wSZE4=;
        b=I26pjw5dSwUa/Hrn/Jt+KkYh47o8wVNs4FQw75rodF5Hmkeokx7NzFT8T68kxu71VS
         wqlfWGJTN6YQNXrad7xwAUo2LGvJ56aaqYJ3dJgnbhJN7xL9w3ZNC+xEb55Vp+o6Vj1F
         +N3yhW5hhdQv5DdEJpGbM0ObUV9PYv3WxgKfe8V4iQZO80dmPZstMLF0EH0XPGAH0V1d
         boq5I0tvuJrYZbdKVUpEIjojFlD+cqnwSMQ5WvMfJFnNlPO4B25yMoi4QH5r+c7B0YvZ
         BY4Doc5PMfJ/gFWJWigAMxr2m3a4qKviqXy3UrTqH75EVH3knjX2oVT2bWDzvt/89A9U
         isJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7uFWkrPEYepwRsZTpZ2ZfcbtcOmdzkneDblSQ8wSZE4=;
        b=gVrozLmDNwKCbE8POwBoWqFmIDkkzUyJaGSjbQLq0HQYtbQJSplKvWCsA3AjMf4QFg
         nVEx945EIq4zF9zDIOCqO1bwO8l9Dws+H2RQdc8201nIRBAVR/DjIQopzZBXjega/Gk+
         90wn0ueQFkbS12JjEqbVZBbw+4SHF2RSUN843/EhWOWxUEVCI9gMRd+cmqOM4BdJULdH
         hnuAxGqFwORgn/vxL8vlhrC2QQRSrVsF0GVrRg/bET+D7yvnRkgly2DIJEqUANwmyEep
         bZeiM8wscvaX7VtS6X1zJTejCdUuOqrLXbszXmNMThDHU1WNfYd7AyBY0gCgoOy3a/3F
         5trA==
X-Gm-Message-State: AOUpUlF0lHETeuyfs8SqRNLF7Fqo5eWG8EroFgzhfeY4XYJDbqYmQ5R7
        dfd0xaD/3YrRRD32usQUlO/54A==
X-Google-Smtp-Source: AA+uWPyT8k6F1KmFoTMffFhmMHPzrIi8bRAYv0eKP9CMA3zP/0qVyBDWAEGT4c6DAbGHq0o3OB+s9A==
X-Received: by 2002:a65:5a49:: with SMTP id z9-v6mr217785pgs.244.1533681300088;
        Tue, 07 Aug 2018 15:35:00 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c131-v6sm2607743pga.69.2018.08.07.15.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 15:34:59 -0700 (PDT)
Date:   Tue, 7 Aug 2018 15:34:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Roman Gushchin <guro@fb.com>
cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] introduce memory.oom.group
In-Reply-To: <20180807003020.GA21483@castle.DHCP.thefacebook.com>
Message-ID: <alpine.DEB.2.21.1808071519030.237317@chino.kir.corp.google.com>
References: <20180730180100.25079-1-guro@fb.com> <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com> <20180731235135.GA23436@castle.DHCP.thefacebook.com> <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
 <20180801224706.GA32269@castle.DHCP.thefacebook.com> <alpine.DEB.2.21.1808061405100.43071@chino.kir.corp.google.com> <20180807003020.GA21483@castle.DHCP.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2018, Roman Gushchin wrote:

> > In a cgroup-aware oom killer world, yes, we need the ability to specify 
> > that the usage of the entire subtree should be compared as a single 
> > entity with other cgroups.  That is necessary for user subtrees but may 
> > not be necessary for top-level cgroups depending on how you structure your 
> > unified cgroup hierarchy.  So it needs to be configurable, as you suggest, 
> > and you are correct it can be different than oom.group.
> > 
> > That's not the only thing we need though, as I'm sure you were expecting 
> > me to say :)
> > 
> > We need the ability to preserve existing behavior, i.e. process based and 
> > not cgroup aware, for subtrees so that our users who have clear 
> > expectations and tune their oom_score_adj accordingly based on how the oom 
> > killer has always chosen processes for oom kill do not suddenly regress.
> 
> Isn't the combination of oom.group=0 and oom.evaluate_together=1 describing
> this case? This basically means that if memcg is selected as target,
> the process inside will be selected using traditional per-process approach.
> 

No, that would overload the policy and mechanism.  We want the ability to 
consider user-controlled subtrees as a single entity for comparison with 
other user subtrees to select which subtree to target.  This does not 
imply that users want their entire subtree oom killed.

> > So we need to define the policy for a subtree that is oom, and I suggest 
> > we do that as a characteristic of the cgroup that is oom ("process" vs 
> > "cgroup", and process would be the default to preserve what currently 
> > happens in a user subtree).
> 
> I'm not entirely convinced here.
> I do agree, that some sub-tree may have a well tuned oom_score_adj,
> and it's preferable to keep the current behavior.
> 
> At the same time I don't like the idea to look at the policy of the OOMing
> cgroup. Why exceeding of one limit should be handled different to exceeding
> of another? This seems to be a property of workload, not a limit.
> 

The limit is the property of the mem cgroup, so it's logical that the 
policy when reaching that limit is a property of the same mem cgroup.
Using the user-controlled subtree example, if we have /david and /roman, 
we can define our own policies on oom, we are not restricted to cgroup 
aware selection on the entire hierarchy.  /david/oom.policy can be 
"process" so that I haven't regressed with earlier kernels, and 
/roman/oom.policy can be "cgroup" to target the largest cgroup in your 
subtree.

Something needs to be oom killed when a mem cgroup at any level in the 
hierarchy is reached and reclaim has failed.  What to do when that limit 
is reached is a property of that cgroup.

> > Now, as users who rely on process selection are well aware, we have 
> > oom_score_adj to influence the decision of which process to oom kill.  If 
> > our oom subtree is cgroup aware, we should have the ability to likewise 
> > influence that decision.  For example, we have high priority applications 
> > that run at the top-level that use a lot of memory and strictly oom 
> > killing them in all scenarios because they use a lot of memory isn't 
> > appropriate.  We need to be able to adjust the comparison of a cgroup (or 
> > subtree) when compared to other cgroups.
> > 
> > I've also suggested, but did not implement in my patchset because I was 
> > trying to define the API and find common ground first, that we have a need 
> > for priority based selection.  In other words, define the priority of a 
> > subtree regardless of cgroup usage.
> > 
> > So with these four things, we have
> > 
> >  - an "oom.policy" tunable to define "cgroup" or "process" for that 
> >    subtree (and plans for "priority" in the future),
> > 
> >  - your "oom.evaluate_as_group" tunable to account the usage of the
> >    subtree as the cgroup's own usage for comparison with others,
> > 
> >  - an "oom.adj" to adjust the usage of the cgroup (local or subtree)
> >    to protect important applications and bias against unimportant
> >    applications.
> > 
> > This adds several tunables, which I didn't like, so I tried to overload 
> > oom.policy and oom.evaluate_as_group.  When I referred to separating out 
> > the subtree usage accounting into a separate tunable, that is what I have 
> > referenced above.
> 
> IMO, merging multiple tunables into one doesn't make it saner.
> The real question how to make a reasonable interface with fever tunables.
> 
> The reason behind introducing all these knobs is to provide
> a generic solution to define OOM handling rules, but then the
> question raises if the kernel is the best place for it.
> 
> I really doubt that an interface with so many knobs has any chances
> to be merged.
> 

This is why I attempted to overload oom.policy and oom.evaluate_as_group: 
I could not think of a reasonable usecase where a subtree would be used to 
account for cgroup usage but not use a cgroup aware policy itself.  You've 
objected to that, where memory.oom_policy == "tree" implied cgroup 
awareness in my patchset, so I've separated that out.

> IMO, there should be a compromise between the simplicity (basically,
> the number of tunables and possible values) and functionality
> of the interface. You nacked my previous version, and unfortunately
> I don't have anything better so far.
> 

If you do not agree with the overloading and have a preference for single 
value tunables, then all three tunables are needed.  This functionality 
could be represented as two or one tunable if they are not single value, 
but from the oom.group discussion you preferred single values.

I assume you'd also object to adding and removing files based on 
oom.policy since oom.evaluate_as_group and oom.adj is only needed for 
oom.policy of "cgroup" or "priority", and they do not need to exist for 
the default oom.policy of "process".
