Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2152363-1523980571-2-6481247779748706756
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523980570; b=KA4c0F4U5SMVHYXmJqGaZvBFBOz9G7D/Ited17ghoyzfRizBkp
    DdSfBI8iu8z70RtntdVnqxGM6oYe3c7+UNfbS04PMQzONmRhxJCOheXYlWWFHUWm
    Fye3O6zn/jdEc94b+Y5JWULeuu1FGK/cO2Y50gqmSayu0taCYFRncoaZ4UtRqzKf
    D9mhBSCSLGIAPXQmnMBxHTjQ0fHlCt+dRV1jvf7xe8xnDM9tCU97M2DhGkAF2paT
    xGGO4NCKaVPCHhsJmeWQPaR24Z/uRWTJxG4ECZTDTYziSSG2CILorZnWBAceiwdx
    G6DbA3cbagNfY7fT5TRXVpI1YEIc6wjFHe1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523980570; bh=OcGND4GTPN1+It/7yn4Td+3MAYPAKO
    AXfJGWET4zkaU=; b=GL+EJf5OXdtTd8vTrFBbSVjG1WpFvbmK5K5lBSeKbN03qc
    N65chSk7N3rKwRpbNA5HDALs3ZgYUgHh0IL+SbOP0x4QeeipzTyHYj3iZ7+IzLgW
    dDybJxAw7Y+RQj6MmLODxaDh+QVyIXny9HPzV7IeBjwRw0FRZo/iZfgPLKaM85Ju
    Uxbk2Qp1f0ugnbKzs6pUw11xhhrJBZDoKlsClBPfGg5FmOsRpgsqD40OOrHuN0fn
    w0wBFid/Su7LEfynJzZlwzcTqd6Crh9fFZysM8mBpcSFj/cM7FZffybenfnuk6AB
    2+4LDWEgZeApQWSruubAqtpmNnCJCyfmYWIfs9xw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBCsvoy09VC12CQxcUt+b8etQVKwOW5LnmsAycuuvxwUyZ0PxcIO6tlwxim2VOIN4q27GOsHUDvtztftGwd13fEAhHqFKsCmeupU6yszAmFtzoeyfa07
    u7nKVtsT28gVoJq0l8XdoGt/HACiWcTD2Jy58QbpNYR0xl3rOGaIPvdlx3JQKDdxNdMaRIasQkgckyzxJxJVFGE7of5G2A+7XQcL8WeL1H/HTPrZ7QyWDvBn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=iox4zFpeAAAA:8 a=LnxICZl57cgcFHVXWBMA:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeDQPzy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 11:55:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36059 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbeDQPzw (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 11:55:52 -0400
Date: Tue, 17 Apr 2018 17:55:49 +0200
From: Jan Kara <jack@suse.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180417155549.6lxmoiwnlwtwdgld@quack2.suse.cz>
References: <20180416113629.2474ae74@gandalf.local.home>
 <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home>
 <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home>
 <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd>
 <20180416172327.GK2341@sasha-vm>
 <20180417114144.ov27khlig5thqvyo@quack2.suse.cz>
 <20180417133149.GR2341@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417133149.GR2341@sasha-vm>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 17-04-18 13:31:51, Sasha Levin wrote:
> On Tue, Apr 17, 2018 at 01:41:44PM +0200, Jan Kara wrote:
> >On Mon 16-04-18 17:23:30, Sasha Levin wrote:
> >> On Mon, Apr 16, 2018 at 07:06:04PM +0200, Pavel Machek wrote:
> >> >On Mon 2018-04-16 16:37:56, Sasha Levin wrote:
> >> >> On Mon, Apr 16, 2018 at 12:30:19PM -0400, Steven Rostedt wrote:
> >> >> >On Mon, 16 Apr 2018 16:19:14 +0000
> >> >> >Sasha Levin <Alexander.Levin@microsoft.com> wrote:
> >> >> >
> >> >> >> >Wait! What does that mean? What's the purpose of stable if it is as
> >> >> >> >broken as mainline?
> >> >> >>
> >> >> >> This just means that if there is a fix that went in mainline, and the
> >> >> >> fix is broken somehow, we'd rather take the broken fix than not.
> >> >> >>
> >> >> >> In this scenario, *something* will be broken, it's just a matter of
> >> >> >> what. We'd rather have the same thing broken between mainline and
> >> >> >> stable.
> >> >> >
> >> >> >Honestly, I think that removes all value of the stable series. I
> >> >> >remember when the stable series were first created. People were saying
> >> >> >that it wouldn't even get to more than 5 versions, because the bar for
> >> >> >backporting was suppose to be very high. Today it's just a fork of the
> >> >> >kernel at a given version. No more features, but we will be OK with
> >> >> >regressions. I'm struggling to see what the benefit of it is suppose to
> >> >> >be?
> >> >>
> >> >> It's not "OK with regressions".
> >> >>
> >> >> Let's look at a hypothetical example: You have a 4.15.1 kernel that has
> >> >> a broken printf() behaviour so that when you:
> >> >>
> >> >> 	pr_err("%d", 5)
> >> >>
> >> >> Would print:
> >> >>
> >> >> 	"Microsoft Rulez"
> >> >>
> >> >> Bad, right? So you went ahead and fixed it, and now it prints "5" as you
> >> >> might expect. But alas, with your patch, running:
> >> >>
> >> >> 	pr_err("%s", "hi!")
> >> >>
> >> >> Would show a cat picture for 5 seconds.
> >> >>
> >> >> Should we take your patch in -stable or not? If we don't, we're stuck
> >> >> with the original issue while the mainline kernel will behave
> >> >> differently, but if we do - we introduce a new regression.
> >> >
> >> >Of course not.
> >> >
> >> >- It must be obviously correct and tested.
> >> >
> >> >If it introduces new bug, it is not correct, and certainly not
> >> >obviously correct.
> >>
> >> As you might have noticed, we don't strictly follow the rules.
> >>
> >> Take a look at the whole PTI story as an example. It's way more than 100
> >> lines, it's not obviously corrent, it fixed more than 1 thing, and so
> >> on, and yet it went in -stable!
> >>
> >> Would you argue we shouldn't have backported PTI to -stable?
> >
> >So I agree with that being backported. But I think this nicely demostrates
> >a point some people are trying to make in this thread. We do take fixes
> >with high risk or regression if they fix serious enough issue. Also we do
> >take fixes to non-serious stuff (such as addition of device ID) if the
> >chances of regression are really low.
> >
> >So IMHO the metric for including the fix is not solely "how annoying to
> >user this can be" but rather something like:
> >
> >score = (how annoying the bug is) * ((1 / (chance of regression due to
> >	including this)) - 1)^3
> >
> >(constants are somewhat arbitrary subject to tuning ;). Now both 'annoying'
> >and 'regression chance' parts are subjective and sometimes difficult to
> >estimate so don't take the formula too seriously but it demonstrates the
> >point. I think we all agree we want to fix annoying stuff and we don't want
> >regressions. But you need to somehow weight this over your expected
> >userbase - and this is where your argument "but someone might be annoyed by
> >LEDs not working so let's include it" has problems - it should rather be
> >"is the annoyance of non-working leds over expected user base high enough
> >to risk a regression due to this patch for someone in the expected user
> >base"? The answer to this second question is not clear at all to a casual
> >reviewer and that's why we IMHO have CC stable tag as maintainer is
> >supposed to have at least a bit better clue.
> 
> We may be able to guesstimate the 'regression chance', but there's no
> way we can guess the 'annoyance' once. There are so many different use
> cases that we just can't even guess how many people would get "annoyed"
> by something.

As a maintainer, I hope I have reasonable idea what are common use cases
for my subsystem. Those I cater to when estimating 'annoyance'. Sure I don't
know all of the use cases so people doing unusual stuff hit more bugs and
have to report them to get fixes included in -stable. But for me this is a
preferable tradeoff over the risk of regression so this is the rule I use
when tagging for stable. Now I'm not a -stable maintainer and I fully agree
with "those who do the work decide" principle so pick whatever patches you
think are appropriate, I just wanted explain why I don't think more patches
in stable are necessarily good. 

> Even regression chance is tricky, look at the commits I've linked
> earlier in the thread. Even the most trivial looking commits that end up
> in stable have a chance for regression.

Sure, you can never be certain and I think people (including me)
underestimate the chance of regressions for "trivial" patches. But you just
estimate a chance, you may be lucky, you may not...

> >Another point I wanted to make is that if chance a patch causes a
> >regression is about 2% as you said somewhere else in a thread, then by
> >adding 20 patches that "may fix a bug that is annoying for someone" you've
> >just increased a chance there's a regression in the release by 34%. And
> 
> So I've said that the rejection rate is less than 2%. This includes
> all commits that I have proposed for -stable, but didn't end up being
> included in -stable.
> 
> This includes commits that the author/maintainers NACKed, commits that
> didn't do anything on older kernels, commits that were buggy but were
> caught before the kernel was released, commits that failed to build on
> an arch I didn't test it on originally and so on.
> 
> After thousands of merged AUTOSEL patches I can count the number of
> times a commit has caused a regression and had to be removed on one
> hand.
> 
> >this is not just a math game, this also roughly matches a real experience
> >with maintaining our enterprise kernels. Do 20 "maybe" fixes outweight such
> >regression chance? And I also note that for a regression to get reported so
> >that it gets included into your 2% estimate of a patch regression rate,
> >someone must be bothered enough by it to triage it and send an email
> >somewhere so that already falls into a category of "serious" stuff to me.
> 
> It is indeed a numbers game, but the regression rate isn't 2%, it's
> closer to 0.05%.

Honestly, I think 0.05% is too optimististic :) Quick grepping of 4.14
stable tree suggests some 13 commits were reverted from stable due to bugs.
That's some 0.4% and that doesn't count fixes that were applied to
fix other regressions.

But the actual numbers don't really matter that much, in principle the more
patches you add the higher is the chance of regression. You can't change
that so you better have a good reason to include a patch...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
