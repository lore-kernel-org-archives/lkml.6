Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C99FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E05421741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548685704;
	bh=hWp7o3RVVl3ZK/vSWf3bJ9nYc44PenZ1McFBVduAoa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lb7Ra0rU0l2H8Gm8lzsCUGc2Rj5HqkFUoXokSBlR3uuwz6lfUMJSXxw1QEufM6wun
	 g6CgVY/sdpx9//42caFcq7jz5lLw4zZ0LKQkX93FlHz61p9ParLNbMSyjWz9i4QGG7
	 iXstRho6V3o3szOWVGPoe8zdR4uQxnpFDnfHOHw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfA1O2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:28:22 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36628 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1O2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:28:22 -0500
Received: by mail-yb1-f194.google.com with SMTP id 64so2231774ybf.3;
        Mon, 28 Jan 2019 06:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=16iA2KhpGFaktyfkAkUeDivlPZNfQCdHzHmJAlMfvm0=;
        b=OH9BmxAMpI2dn5E0OCOkDxyBFiuKIzG84TuAPLbsaHFD8Y4tP9t6UOgwYDLk0SqVJ+
         rzNq4skU4+AoEyiSlUqHzLlGst9c7xkw0Y0CmKGKRy/PDltLoNyyp6NP9H7DbLDIgLLl
         ooA2hHi2wDoPsq5RGy9/kHshGlGlPbFv7UC+4PgqPmcimos7sshWy5k7tzbolHoIbGWA
         OkirYa+jyvJNqEbA1TyZ0BdTZxyM0Tb4H0zH+RE6jiXiAOfiCAEfggYon3kBS4Rqm9gk
         uh7Ofnetke+CLAiD+Pi3juRT6eSFijXtCTiFKPwl2pFbgKwasbvGf2jX0YSyCZ7kXQ2Q
         YI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=16iA2KhpGFaktyfkAkUeDivlPZNfQCdHzHmJAlMfvm0=;
        b=Cqvh7QjO1LDm9u+zDvRQOF20efVsl9j3CiV/GPWYkiZfN8HwgZzuiV/U1oEsHlmzYC
         yVcc7oNgIx6DOLO2Z+0mjhHsee4Vx7qI8B6woszQWbvUXkSTHuFl34ontZOz+6yPlVOG
         jCLuga/hQxZ/fGIhEuxaxhuqH/MwknfGH7mKQ/0UnQzHGmLXpLN1A3FahOo2XDzBhChl
         jMkvUnUR9ocwydjchHnxEyeHLxO8rUk0l79FgBwBhb7ei222ARwVJzQF7YIQ6q72VRiK
         Lgw927yNXLM1iPHve7RSVM/P62elUoQVaYRb6KWXuTd7MRSh9xdW9R1cVSX7Dhdp0J9Z
         vBRQ==
X-Gm-Message-State: AJcUukdXguS8PYmatWYFduUmdJk0UBKt7g0WxnD3uiO90OLikRcuD7lc
        lXUa0UOBNze3klduZX3a5Aw=
X-Google-Smtp-Source: ALg8bN6b97yjXesS3JpAR8TAdlO5u95HsT4J9nFbMu1NOwpOEfvBCc0iVD42Xa1Q948agPUfNW8g4g==
X-Received: by 2002:a25:2447:: with SMTP id k68mr11281571ybk.249.1548685700851;
        Mon, 28 Jan 2019 06:28:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:a62a])
        by smtp.gmail.com with ESMTPSA id o124sm11998848ywe.75.2019.01.28.06.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:28:19 -0800 (PST)
Date:   Mon, 28 Jan 2019 06:28:16 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128142816.GM50184@devbig004.ftw2.facebook.com>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128125151.GI18811@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Mon, Jan 28, 2019 at 01:51:51PM +0100, Michal Hocko wrote:
> > For example, a workload manager watching over a subtree for a job with
> > nested memory limits set by the job itself.  It wants to take action
> > (reporting and possibly other remediative actions) when something goes
> > wrong in the delegated subtree but isn't involved in how the subtree
> > is configured inside.
> 
> Yes, I understand this part, but it is not clear to me, _how_ to report
> anything sensible without knowing _what_ has caused the event. You can
> walk the cgroup hierarchy and compare cached results with new ones but
> this is a) racy and b) clumsy.

All .events files generate aggregated stateful notifications.  For
anyone to do anything, they'd have to remember the previous state to
identify what actually happened.  Being hierarchical, it'd of course
need to walk down when an event triggers.

> > That sure is an option for use cases like above but it has the
> > downside of carrying over the confusing interface into the indefinite
> > future.
> 
> I actually believe that this is not such a big deal. For one thing the
> current events are actually helpful to watch the reclaim/setup behavior.

Sure, it isn't something critical.  It's just confusing and I think
it'd be better to improve.

> I do not really think you can go back. You cannot simply change semantic
> back and forth because you just break new users.
> 
> Really, I do not see the semantic changing after more than 3 years of
> production ready interface. If you really believe we need a hierarchical
> notification mechanism for the reclaim activity then add a new one.

I don't see it as black and white as you do.  Let's agree to disagree.
I'll ack the patch and note the disagreement.

Thanks.

-- 
tejun
