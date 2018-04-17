Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2367869-1523987880-2-238131407077975043
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
    1523987880; b=TjvvyXS30K5Zuu2WsZYkFH7sVsP+IvbBKbxuhmG0CZpqAyM2mv
    bTPunJBd0bQsMV1loxHzcV4f5yAcO+IkhhUECH0qKGYsa/HdO/I0Omdne3XIFdX6
    i1XwDWLR/s/1maOKVA7VjDuACeTlw6KiTaHPi4QUZghMWLv5cYrYBWF4iEQZxY1o
    NsYrRpLw6S0iVUkibEFecPFTwZQHvrV3yNVlU5uZqwjxqOOiKRTbsngPWN6rhN3Z
    rvOSKkKv9WTawsGqBNvxqX1uKwLhWhN1tUkWswjmi9jRBW5OTNtL1PlAn4+1azBg
    nGA6AvDZ30i35Y7XKXzRpGjJ2gCi2VyQIO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523987880; bh=YrZDBgc2JScvK+0jaQ0wD6cZ26Sii/
    H8X2IALEUakR8=; b=ojtloxhrmwCj0jocVwFZ6ksYkSGGvvozAP4jNFjivAkI60
    yE5bgD6GP3ilW4in1XZlR6Aul6yT9wi2NLYIxyi+ayeB0Mj0tnv7ghLxyzFYOIBf
    FBt9YgykbOaNeHBqLbRmIByiU7ot8Bj3Wo1+h+p8w0O8yi7fge5bNR+Re4n5FPWV
    VaP5+N2ZRBdk0n0vpz4KnlB0w+crDsQXyyCCY0eGm/EJrdiksu3pxFHrkGVf2Doz
    Y2S73S8Yyzg02hsOy5ov5Dkh4pgQVevvuqScgIaejAlF1qX28w1JP+Ojg2nNVZLL
    qvUwrCzR14ae78QUfn8zvgN3YA7AW59muoYnoRXQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNrVz7UeoW47nATvT/udGOyqZrtW9RtDmJQBLsxaukYNwYvGbLmctaHAACmBDOruD5MFuRgjlXq8l7s3Ac1TJYVVpYJVlSLwwog5rtMcT0mCnYItxxdr
    G9bh+G2vAXV2Ba8CXiIYNwZX4CSnjq33rrEkukL/2JlvJ0zMBDio6QuMmFDsV6YW84VGpqgY+tabKpnL8Zces7QekBjw0YR4/u2NNtobca+z240+/xCUK3Rg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=LMTXSBL2nEhDjP3w_TUA:9 a=yHaVwEXce5QjczI8:21
    a=SH_ZYxc7nYVWg4My:21 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeDQR56 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 13:57:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:45557 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeDQR55 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 13:57:57 -0400
Date: Tue, 17 Apr 2018 19:57:54 +0200
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
Message-ID: <20180417175754.w4slhmwtf46hq3hm@quack2.suse.cz>
References: <20180416121224.2138b806@gandalf.local.home>
 <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home>
 <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd>
 <20180416172327.GK2341@sasha-vm>
 <20180417114144.ov27khlig5thqvyo@quack2.suse.cz>
 <20180417133149.GR2341@sasha-vm>
 <20180417155549.6lxmoiwnlwtwdgld@quack2.suse.cz>
 <20180417161933.GY2341@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417161933.GY2341@sasha-vm>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 17-04-18 16:19:35, Sasha Levin wrote:
> On Tue, Apr 17, 2018 at 05:55:49PM +0200, Jan Kara wrote:
> >> Even regression chance is tricky, look at the commits I've linked
> >> earlier in the thread. Even the most trivial looking commits that end up
> >> in stable have a chance for regression.
> >
> >Sure, you can never be certain and I think people (including me)
> >underestimate the chance of regressions for "trivial" patches. But you just
> >estimate a chance, you may be lucky, you may not...
> >
> >> >Another point I wanted to make is that if chance a patch causes a
> >> >regression is about 2% as you said somewhere else in a thread, then by
> >> >adding 20 patches that "may fix a bug that is annoying for someone" you've
> >> >just increased a chance there's a regression in the release by 34%. And
> >>
> >> So I've said that the rejection rate is less than 2%. This includes
> >> all commits that I have proposed for -stable, but didn't end up being
> >> included in -stable.
> >>
> >> This includes commits that the author/maintainers NACKed, commits that
> >> didn't do anything on older kernels, commits that were buggy but were
> >> caught before the kernel was released, commits that failed to build on
> >> an arch I didn't test it on originally and so on.
> >>
> >> After thousands of merged AUTOSEL patches I can count the number of
> >> times a commit has caused a regression and had to be removed on one
> >> hand.
> >>
> >> >this is not just a math game, this also roughly matches a real experience
> >> >with maintaining our enterprise kernels. Do 20 "maybe" fixes outweight such
> >> >regression chance? And I also note that for a regression to get reported so
> >> >that it gets included into your 2% estimate of a patch regression rate,
> >> >someone must be bothered enough by it to triage it and send an email
> >> >somewhere so that already falls into a category of "serious" stuff to me.
> >>
> >> It is indeed a numbers game, but the regression rate isn't 2%, it's
> >> closer to 0.05%.
> >
> >Honestly, I think 0.05% is too optimististic :) Quick grepping of 4.14
> >stable tree suggests some 13 commits were reverted from stable due to bugs.
> >That's some 0.4% and that doesn't count fixes that were applied to
> >fix other regressions.
> 
> 0.05% is for commits that were merged in stable but later fixed or
> reverted because they introduced a regression. By grepping for reverts
> you also include things such as:
> 
>  - Reverts of commits that were in the corresponding mainline tree
>  - Reverts of commits that didn't introduce regressions

Actually I was careful enough to include only commits that got merged as
part of the stable process into 4.14.x but got later reverted in 4.14.y.
That's where the 0.4% number came from. So I believe all of those cases
(13 in absolute numbers) were user visible regressions during the stable
process.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
