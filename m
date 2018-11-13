Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75207C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCD0223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF2c8DuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCD0223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeKNFPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:15:15 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46247 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:15:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so21467130qkf.13;
        Tue, 13 Nov 2018 11:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eyXKSAXrFcy6Gbu9uPgpFrVw8htCHZwhRAvOnXKlGxo=;
        b=NF2c8DuAFMhsUJo4vRyAtcKqhdtevrIoq7zi49LyZsdhsPttWtPZ7yM1WIHiZ1GIUm
         p3LcwyMMiaaVAsqD1+82mvnWgaM0K0IBlqjtFTHQ6ZkGPxWvkFo+fWuTdUSftLSlNR2W
         EcFRpsm5XRwPdBUYSefvTH6RWmG/q+bNvIQlQ3uETbMRaLh/RA6GfjPBTQ/j0VF5zge9
         dEPXLQKuzi1BuRSt/QwLSTvdolVpzbQInw4sLAIMir1tfMOvCBHx92TiyPDbGOTHG/lU
         SjrwCnpA9EzH/VJ/5vViJAQtxjOuQvCqcArwIpk4kwZXgQQ2tTBE9OlOIFnPRZEPSLJF
         dX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eyXKSAXrFcy6Gbu9uPgpFrVw8htCHZwhRAvOnXKlGxo=;
        b=aDpUVU0vwcZxNvmCNTLF2yiplpZvg1OkXjFDOwd4Io9e0Qs3LkAaR8m7SMa+wYbBh5
         EoUGsTzdcH9rspmTz8PAV9AyU3Lmb3Z2asuzK4RBgTKzrhnFWIN55MApTudwLON8ZJNV
         i197bgg6QcNHJXjHqdvF4zVjJpaeSSFH+I90qcpjxYfwXgKXn7nv162fjNCEZeIDhYmm
         tgmQELzpnE/Yyzklxb70EqvlVgPN6dxTnzyaGY6U9FJlEYd2IgYElbAJvT3PCvHYgmKt
         tB0xLsqR0PvAzHHeRbgIqxzTovZG20yGRPU1HqpRTQZUzaC7xjqce2/lMsc7CuKXn6/I
         uCbA==
X-Gm-Message-State: AGRZ1gLtIZIvtKI/w4haw13LBClgIayd5iKcbeZjpRUYnrNE0GlXQENh
        YI/DrQ41B/pV3/ItRY9dRKkr7eYs
X-Google-Smtp-Source: AJdET5f3EIUllGTQ+RohG9l5sCS+oaWiOb9IQmi6/TPFbbhdh4Q4vBkV8j2OevNHBpXWeRXsYlFLoA==
X-Received: by 2002:aed:2151:: with SMTP id 75mr6442961qtc.24.1542136545023;
        Tue, 13 Nov 2018 11:15:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id l30sm3749116qte.44.2018.11.13.11.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:15:44 -0800 (PST)
Date:   Tue, 13 Nov 2018 11:15:41 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Message-ID: <20181113191541.GM2509588@devbig004.ftw2.facebook.com>
References: <20181112230422.5911-1-guro@fb.com>
 <20181112230422.5911-5-guro@fb.com>
 <20181113020817.GE2509588@devbig004.ftw2.facebook.com>
 <20181113184751.GB21629@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113184751.GB21629@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Roman.

On Tue, Nov 13, 2018 at 06:47:55PM +0000, Roman Gushchin wrote:
> > > +	/* Should the cgroup and its descendants be frozen. */
> > > +	bool freeze;
> > 
> > Why not have this in freezer too?
> 
> I thought that this variable is just the state of the cgroup.freeze knob,
> where the freezer field contains the internal state of the freezer, and
> can in theory be allocated dynamically.
> 
> Not a strong preference, I can move it there too, if you prefer to.

Yeah, let's just put it together.

> > > +void cgroup_freezer_enter(void);
> > > +void cgroup_freezer_leave(void);
> > 
> > So, if we use freeze, freezing, frozen instead, the aboves can be
> > cgroup_frozen_enter() and cgroup_frozen_leave() (or begin/end).
> 
> Idk, maybe cgroup_enter_frozen()/cgroup_leave_frozen() ?

Sure.

> > > +	/* task is in the cgroup freezer loop */
> > 
> > The above comment isn't strictly true, right?
> 
> Why so?
> 
> It actually means that the task is looping somewhere in the signal delivery loop
> after entering cgroup_freezer_enter() and before cgroup_freezer_leave().
> 
> Maybe simple "task is frozen by the cgroup freezer"?

Yeah, sounds good.

> > > @@ -5642,6 +5700,23 @@ void cgroup_post_fork(struct task_struct *child)
> > >  			cset->nr_tasks++;
> > >  			css_set_move_task(child, NULL, cset, false);
> > >  		}
> > > +
> > > +		if (unlikely(cgroup_frozen(child) &&
> > > +			     (child->flags & ~PF_KTHREAD))) {
> > 
> > I don't think we need explicit PF_KTHREAD test here.  We don't allow
> > kthreads in non-root cgroups anyway and if we wanna change that there
> > are a bunch of other things which need updating anyway.
> 
> Don't we? I think we do. I've proposed a patch to fix this some time ago
> (https://lkml.org/lkml/2017/10/12/556), but was NAKed by Peter.

Ah, right, I thought that went in.  Oh well, let's keep the test then.

> > > +	/*
> > > +	 * Did we race with fork() or exit()? Np, everything is still frozen.
> > > +	 */
> > > +	if (frozen == test_bit(CGRP_FROZEN, &cgrp->flags))
> > > +		return;
> > > +
> > > +	if (frozen)
> > > +		set_bit(CGRP_FROZEN, &cgrp->flags);
> > > +	else
> > > +		clear_bit(CGRP_FROZEN, &cgrp->flags);
> > 
> > I'm not sure this is wrong but it feels a bit weird to tie the actual
> > state transition to notification.  Wouldn't it be more
> > straight-forward if CGRP_FROZEN bit is purely determined by whether
> > the tasks are frozen or not and the notification just checks that
> > against the last notified state and generate a notification if they're
> > different?
> 
> So, maybe cgroup_notify_frozen() is not the best name, maybe
> cgroup_propagate_frozen() better reflects what's happening here.
> We need to recalc the state of ancestor cgroups, and we have to do it
> with cgroup_mutex held, this is why we do it from the delayed work
> context (on hot paths).

Can't we protect that state with css_set_lock too?  That's what task
states are protected by and the cgroup state is a mere aggregation of
task states.

> The first pat of the function can be probably separated and called
> immediately. Is this what you're suggesting?

Pretty much.  I think separating out state transitions and
notifications would make it more straightforward.

> > So that all these state transitions are synchronous with the actual
> > freezing events and we can just queue per-cgroup work items all the
> > way to the top if the new state is different from the last one
> > cgroup-by-cgroup?
> 
> Hm, Idk. Why it's better?

So, the pieces are - 1. task states, 2. cgroup states and
3. notifications.  The current code ties together #2 and #3 together
which is weird because #2 is a mere aggregation of #1.  Also, that
way, notifications become a lot more robust because whether to
generate a notification or not can be solely determined from #2
flipping.  ie. sth like the following

	change_task_frozen_state()
	{
		update counters
		if (cgroup state needs to change) {
			change cgroup state;
			queue notification work;
			repeat for the parent;
		}
	}

where notification work always notifies should work and trivially
satisfies the requirement (there should be at least one notification
since the last state transition) without any further work.  Wouldn't
this be easier and more robust?  The current code depends on
annotating each possible transition event, which is kinda fragile.

> > > +	if (lock_task_sighand(task, &flags)) {
> > > +		if (test_bit(CGRP_FREEZE, &dst->flags))
> > > +			task->jobctl |= JOBCTL_TRAP_FREEZE;
> > > +		else
> > > +			task->jobctl &= ~JOBCTL_TRAP_FREEZE;
> > 
> > How are these flags synchronized?
> 
> Using the css_set_lock.

But other JOBCTL_TRAP bits aren't synchronized by css_set_lock, right?

Thanks.

-- 
tejun
