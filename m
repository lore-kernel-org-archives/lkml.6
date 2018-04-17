Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1716434-1523967902-2-2925763975468967143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523967901; b=hh6YB+SKetRRQ51ofXCR/woi0SPz4aIE8AMrZF978zZyEu31X+
    IE4XB1t+x0kauBz4h5RLvAZfPxAXrIPf0AJNwM+LYAxhJkJtNr/dZdJAdXoOGTOE
    mfF4TvpmWukNIrL3++N6CfdndVyX4LimfOpRrfwZThS65W0Eqduf0ucBcB7dDwl8
    X7NCtsAHoySD0YZzFPTh4ENZRft7wUCZENPeSnSyLkcj2IK9p/IMB2EBQ3hP37Jd
    zmC49fjAg1X+GTxQ4s7nE5bPDvmYtFURo7NAMSosikDzwQcvu6eVNvUaLiVTd4Ty
    5HYhOKI951FxCNDsiBdBspQFdsek5WfKNapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523967901; bh=QNbd+eNrADlxgtV8NBkylfxHSYPXTR
    sjgxNosvnlYQo=; b=k2xAcA6TesV5ADXlFSz5Ueg4jW7FKBNTvG15vrss4npOgJ
    1pSrBNeuYEaN5/YW/hFUuGRBEFCN4Y4WNbREuyHieEQ9rJk0UM60LUjnfMyfybDt
    bTBoKy0fQxMaZAKZYPlJomUN+XIg41WAyLYYyM6BFmXfoQP4s+2hc29pRZt1aAQD
    9ImuiVJDWUf2mTMdKAEuakGtnrXr3Rbtk0ajpyzofS8p1zXlyy996eBhlQwOe4tU
    Z1OXzNT7cIHc5i4KqdHQdns4cZdhYUuLnHJAgYA19rCPhQgnoHdoRsxlcO3RAAR+
    JhMqpDRLVprF3JVj7XWd/wj+VvkTgU8nBdj9YFGw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB5hxlvsstnydXSsxni43Q2Kp/wqeBSSygkBGES6ILAENGDsRMwWmqgJmtu9c0PQPIzD0ysFsYKOmivROJ+cS+e7ZAA54I5OldfV13vEC8YSPnbQqnBy
    zvRVwBFjJMHMlnZ3MSaS5rXMB7odq+px/w1pckdwqlkZKqqmV2v6daXvWD4hDmeE8+TL3TKrvD1KFsZ2xP1tRzaOjQzmhDUQnVNdFJTtcUgX3kO6QpYN8HTI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=JdNLi9D1yxpcJktNDmMA:9
    a=T_7aERi61UENQ_CM:21 a=UGXRVjrbRyw7EdGr:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeDQMZA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 08:25:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752087AbeDQMY7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 08:24:59 -0400
Date: Tue, 17 Apr 2018 14:24:54 +0200
From: Petr Mladek <pmladek@suse.com>
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180417122454.rwkwpsfvyhpzvvx3@pathway.suse.cz>
References: <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
 <20180416122244.146aec48@gandalf.local.home>
 <20180416163107.GC2341@sasha-vm>
 <20180416124711.048f1858@gandalf.local.home>
 <20180416165258.GH2341@sasha-vm>
 <20180416170010.GA11034@amd>
 <20180417104637.GD8445@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417104637.GD8445@kroah.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 2018-04-17 12:46:37, Greg KH wrote:
> Oh, I know why, suddenly subsystems that never were taking the time to
> mark patches for stable are getting patches backported and are getting
> nervous.

Yes, I am getting nervous because of this. The number of printk fixes
nominated for stable is increasing exponentially (just my feeling)
during last few months.

The problem is that I want to be responsible and think about possible
regressions. Sometimes it requires checking the state of the
particular kernel release. The older code base the more complicated
the decision is.

You might argue that backporting the fixes helps to get the same code
in all supported code bases. But it is not true. It never will be
the same.


Anyway, in the past the "automatically" nominated printk fixes
were trivial. They did not cause harm. But they also were not
worth it, IMHO. They fixed corner cases that were there for ages.
Most of these fixes were found by code review when working on
a feature. They were not backed by bug reports.


Last week, autosel nominated pretty non-trivial patch (started
this thread). It partly solved a problem we tried to fix last few
years.

On one side, this was an annoying problem that motivated several
people spend a lot of time on it. This might be a motivation
for a backport.

On the other hand, it took many years to come somewhere. The main
problem was the fear of regressions. We fixed/improved many things
in the mean time. It shows that the problem really is not trivial.
The same is true for the fix. We did our best to avoid regressions.
But it does not mean that there are none. Also it does not mean
that it will really give better results in all situations.

I really do not see a reason to hurry and backport this to
the older kernel releases. It means to spread the fix but also
eventual problems. It is easy to miss a dependant patch.
The less trivial fix, the more possible problems are there.



Back to the trend. Last week I got autosel mails even for
patches that were still being discussed, had issues, and
were far from upstream:

https://lkml.kernel.org/r/DM5PR2101MB1032AB19B489D46B717B50D4FBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com
https://lkml.kernel.org/r/DM5PR2101MB10327FA0A7E0D2C901E33B79FBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com

It might be a good idea if the mail asked to add Fixes: tag
or stable mailing list. But the mail suggested to add the
unfinished patch into stable branch directly (even before
upstreaming?).


Now, there are only hand full of printk patches in each
release, so it is still doable. I just do not understand
how other maintainers, from much more busy subsystems,
could cope with this trend.

By other words. If you want to automatize patch nomination,
you might need to automatize also patch review. Or you need
to keep the patch rate low. This might mean to nominate
only important and rather trivial fixes.


Best Regards,
Petr
