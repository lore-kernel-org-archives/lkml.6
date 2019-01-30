Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB29C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB24218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="fYvhg36l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbfA3Vbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:31:34 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33870 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbfA3Vbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:31:34 -0500
Received: by mail-yb1-f196.google.com with SMTP id k9so468491ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 13:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RVatRRSUNPFia0AG++8fTd3p5N3wzKww/XrSzdcFN2w=;
        b=fYvhg36lpfjQzLOnywaXIbB6MOwhCDTDShsJ97YlFhONHV9D64iJgVF/Qo4+qKyZtG
         s06VSBhlksnwMeWmQhUWbF2gwhYCyqm8itVUYONg5fTak37za93x1jU9zCgt3DDBYiga
         R7Drvqz2TH1FO9LdfsZUzDXErVeNqK3RgmNfxYGJUi36gESKyFrDcNOflwfE7q1BS3Zj
         OTEvBDliVfULwi3ZAS4r6J9Fa3zCwPqB8UXW6FF9mwGKbYud8U2qtjEk6JKry5Jg9bCx
         S1PR9p9RKI3iB9deCwgb2rqSMiI77hcvos81zfMB+DRKT2xfv8aLpkck85twPzwEhXOc
         rdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RVatRRSUNPFia0AG++8fTd3p5N3wzKww/XrSzdcFN2w=;
        b=SpYvAGfrQVJCjS4La79Y+2nzBJfohzRhK0kuSwXwQ7M0Oh9NJBmZwdcpkePF7m/lnn
         98ilnJUa/dBVfL84mYLGA/6xGOtbhacik2ERyHnTYEtHcFCKMO3ijyLRiW/ALIUYcDsS
         cjXPXFrMWBS/NzOxRkIa2Rj39kYWGTqH3KXWCdDsOn9+HD6kLG0zgSmHC9NqY1Kcb79q
         2gruCKbx9P+HKsVyWnQZEUbylTfWM7edzb2zuL8znzTnoFuq2sXkLpuMZcXjNGjNYhzu
         MHuSz6C5xPwP5qr+dOdqJVGMJanuLFIxNXlB9rwM2y4pELkzq4Alk2GDpu5TWDw4x7+K
         34JQ==
X-Gm-Message-State: AJcUukcCC2TwfaPn45MrXPV6UX6YnVx3OFVDAsu85KP75ByxteDmkUe2
        LcsQOMiDDTWa9rVl7RiJt0/7yw==
X-Google-Smtp-Source: ALg8bN5PakQ65KJYqs2R0kwAbMTN02Ox2I4T/BOIvddedAO5oBa8HNQ57YP9rY7TS8rsCotYmbwJUA==
X-Received: by 2002:a25:abb3:: with SMTP id v48mr30586634ybi.92.1548883893317;
        Wed, 30 Jan 2019 13:31:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:6c95])
        by smtp.gmail.com with ESMTPSA id g84sm2969259ywg.9.2019.01.30.13.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 13:31:32 -0800 (PST)
Date:   Wed, 30 Jan 2019 16:31:31 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190130213131.GA13142@cmpxchg.org>
References: <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
 <20190130192345.GA20957@cmpxchg.org>
 <20190130200559.GI18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130200559.GI18811@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 09:05:59PM +0100, Michal Hocko wrote:
> On Wed 30-01-19 14:23:45, Johannes Weiner wrote:
> > On Mon, Jan 28, 2019 at 01:51:51PM +0100, Michal Hocko wrote:
> > > On Fri 25-01-19 10:28:08, Tejun Heo wrote:
> > > > On Fri, Jan 25, 2019 at 06:37:13PM +0100, Michal Hocko wrote:
> > > > > Please note that I understand that this might be confusing with the rest
> > > > > of the cgroup APIs but considering that this is the first time somebody
> > > > > is actually complaining and the interface is "production ready" for more
> > > > > than three years I am not really sure the situation is all that bad.
> > > > 
> > > > cgroup2 uptake hasn't progressed that fast.  None of the major distros
> > > > or container frameworks are currently shipping with it although many
> > > > are evaluating switching.  I don't think I'm too mistaken in that we
> > > > (FB) are at the bleeding edge in terms of adopting cgroup2 and its
> > > > various new features and are hitting these corner cases and oversights
> > > > in the process.  If there are noticeable breakages arising from this
> > > > change, we sure can backpaddle but I think the better course of action
> > > > is fixing them up while we can.
> > > 
> > > I do not really think you can go back. You cannot simply change semantic
> > > back and forth because you just break new users.
> > > 
> > > Really, I do not see the semantic changing after more than 3 years of
> > > production ready interface. If you really believe we need a hierarchical
> > > notification mechanism for the reclaim activity then add a new one.
> > 
> > This discussion needs to be more nuanced.
> > 
> > We change interfaces and user-visible behavior all the time when we
> > think nobody is likely to rely on it. Sometimes we change them after
> > decades of established behavior - for example the recent OOM killer
> > change to not kill children over parents.
> 
> That is an implementation detail of a kernel internal functionality.
> Most of changes in the kernel tend to have user visible effects. This is
> not what we are discussing here. We are talking about a change of user
> visibile API semantic change. And that is a completely different story.

I think drawing such a strong line between these two is a mistake. The
critical thing is whether we change something real people rely on.

It's possible somebody relies on the child killing behavior. But it's
fairly unlikely, which is why it's okay to risk the change.

> > The argument was made that it's very unlikely that we break any
> > existing user setups relying specifically on this behavior we are
> > trying to fix. I don't see a real dispute to this, other than a
> > repetition of "we can't change it after three years".
> > 
> > I also don't see a concrete description of a plausible scenario that
> > this change might break.
> > 
> > I would like to see a solid case for why this change is a notable risk
> > to actual users (interface age is not a criterium for other changes)
> > before discussing errata solutions.
> 
> I thought I have already mentioned an example. Say you have an observer
> on the top of a delegated cgroup hierarchy and you setup limits (e.g. hard
> limit) on the root of it. If you get an OOM event then you know that the
> whole hierarchy might be underprovisioned and perform some rebalancing.
> Now you really do not care that somewhere down the delegated tree there
> was an oom. Such a spurious event would just confuse the monitoring and
> lead to wrong decisions.

You can construct a usecase like this, as per above with OOM, but it's
incredibly unlikely for something like this to exist. There is plenty
of evidence on adoption rate that supports this: we know where the big
names in containerization are; we see the things we run into that have
not been reported yet etc.

Compare this to real problems this has already caused for
us. Multi-level control and monitoring is a fundamental concept of the
cgroup design, so naturally our infrastructure doesn't monitor and log
at the individual job level (too much data, and also kind of pointless
when the jobs are identical) but at aggregate parental levels.

Because of this wart, we have missed problematic configurations when
the low, high, max events were not propagated as expected (we log oom
separately, so we still noticed those). Even once we knew about it, we
had trouble tracking these configurations down for the same reason -
the data isn't logged, and won't be logged, at this level.

Adding a separate, hierarchical file would solve this one particular
problem for us, but it wouldn't fix this pitfall for all future users
of cgroup2 (which by all available evidence is still most of them) and
would be a wart on the interface that we'd carry forever.

Adding a note in cgroup-v2.txt doesn't make up for the fact that this
behavior flies in the face of basic UX concepts that underly the
hierarchical monitoring and control idea of the cgroup2fs.

The fact that the current behavior MIGHT HAVE a valid application does
not mean that THIS FILE should be providing it. It IS NOT an argument
against this patch here, just an argument for a separate patch that
adds this functionality in a way that is consistent with the rest of
the interface (e.g. systematically adding .local files).

The current semantics have real costs to real users. You cannot
dismiss them or handwave them away with a hypothetical regression.

I would really ask you to consider the real world usage and adoption
data we have on cgroup2, rather than insist on a black and white
answer to this situation.
