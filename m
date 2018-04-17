Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1633352-1523965314-2-14152936620274915986
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
    1523965313; b=VKaRW8bGSVh06+QG0yyPi5jGCQal6Yrrh8iISVpXZ8BbaTxfXz
    YSGtKFjRSvGDegcqSygKAcTdYSAZzWai/Z6sWcBLe0fpwz0ncAGc0YgM5EGT+5Bk
    kIubck1rjrCIygIN239LKWjme5OE74V5yWUh7CepV17hYW5SX1Bc/ICXvYAe+fjE
    TXCo6bwReLNaY5HGCXKQl7W8SYkoQZxWFwPJDQmHuQgz26JuCiSuc566ZPDr1DRw
    SJ1jmvrWv/sW+V27BECriNs/zXNGRA6j708hUd9BPseTAgs9YX7pClBdHoLIJlRA
    tLge0M/FvQkAVAeM8bGhC+hhUfteafxmPVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523965313; bh=kCcu+pwsSkAvzJcb6mRFbdpe1oidMI
    EsYE66IjXHiT8=; b=dizPEOfTV+ciEOlylE0DRlqfWLltn8fTOYC7tJ2KaHPmnI
    jg1qDAfv/RDBdCTyLQRbUYO0bWivTu6lzO8kfZTRNm0BkMXH6h8Vla4mKz9WaJge
    dfT86FgvT3OllrMVuWvPSLALJPiDlhrPHNy+RgUHRzUgB0EtL/q4XIzHqLquEeep
    fw/iKr4E84ZrdUsZvDvr3TdwtpaMJTffhUQiuEuolguF9WeShQjUOJocdzvwN8iX
    T5zOcBgLPgrCFXd18ZfKc+TyZDo2BpMYC9NmWxjqPTHbHuAGMFy2eZbVX1N3kNK5
    hc4F7SLPpIZvNk1Z/Bxzlci+KosBARaAt4AdGGsQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfK0FyrVNqrr1yvhuhWQv/7VrILcK4C27agbfutTaddbUTvvB3F9EJK9E4yHRzfVBv8Chmt+6ZgixUN5wQATdyKgmaZcBeBwzTrte7wX4W8biPOEeKky3
    3qb+C9RycAEVZOVgOoCodUA0nc8Fjj8+Te56QumSt1fLJfhd1VMza5mlsctpfbib/nZbTyUYWeC5fk5HtnLwrMCxeRyvW7iQ1WdPVUV6KTv9Kv4QIm1GfC8l
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=iox4zFpeAAAA:8 a=QHZ8SBt88U-UDAk1SHQA:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeDQLlu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 07:41:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752643AbeDQLlt (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 07:41:49 -0400
Date: Tue, 17 Apr 2018 13:41:44 +0200
From: Jan Kara <jack@suse.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
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
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180417114144.ov27khlig5thqvyo@quack2.suse.cz>
References: <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home>
 <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home>
 <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home>
 <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd>
 <20180416172327.GK2341@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416172327.GK2341@sasha-vm>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 16-04-18 17:23:30, Sasha Levin wrote:
> On Mon, Apr 16, 2018 at 07:06:04PM +0200, Pavel Machek wrote:
> >On Mon 2018-04-16 16:37:56, Sasha Levin wrote:
> >> On Mon, Apr 16, 2018 at 12:30:19PM -0400, Steven Rostedt wrote:
> >> >On Mon, 16 Apr 2018 16:19:14 +0000
> >> >Sasha Levin <Alexander.Levin@microsoft.com> wrote:
> >> >
> >> >> >Wait! What does that mean? What's the purpose of stable if it is as
> >> >> >broken as mainline?
> >> >>
> >> >> This just means that if there is a fix that went in mainline, and the
> >> >> fix is broken somehow, we'd rather take the broken fix than not.
> >> >>
> >> >> In this scenario, *something* will be broken, it's just a matter of
> >> >> what. We'd rather have the same thing broken between mainline and
> >> >> stable.
> >> >
> >> >Honestly, I think that removes all value of the stable series. I
> >> >remember when the stable series were first created. People were saying
> >> >that it wouldn't even get to more than 5 versions, because the bar for
> >> >backporting was suppose to be very high. Today it's just a fork of the
> >> >kernel at a given version. No more features, but we will be OK with
> >> >regressions. I'm struggling to see what the benefit of it is suppose to
> >> >be?
> >>
> >> It's not "OK with regressions".
> >>
> >> Let's look at a hypothetical example: You have a 4.15.1 kernel that has
> >> a broken printf() behaviour so that when you:
> >>
> >> 	pr_err("%d", 5)
> >>
> >> Would print:
> >>
> >> 	"Microsoft Rulez"
> >>
> >> Bad, right? So you went ahead and fixed it, and now it prints "5" as you
> >> might expect. But alas, with your patch, running:
> >>
> >> 	pr_err("%s", "hi!")
> >>
> >> Would show a cat picture for 5 seconds.
> >>
> >> Should we take your patch in -stable or not? If we don't, we're stuck
> >> with the original issue while the mainline kernel will behave
> >> differently, but if we do - we introduce a new regression.
> >
> >Of course not.
> >
> >- It must be obviously correct and tested.
> >
> >If it introduces new bug, it is not correct, and certainly not
> >obviously correct.
> 
> As you might have noticed, we don't strictly follow the rules.
> 
> Take a look at the whole PTI story as an example. It's way more than 100
> lines, it's not obviously corrent, it fixed more than 1 thing, and so
> on, and yet it went in -stable!
> 
> Would you argue we shouldn't have backported PTI to -stable?

So I agree with that being backported. But I think this nicely demostrates
a point some people are trying to make in this thread. We do take fixes
with high risk or regression if they fix serious enough issue. Also we do
take fixes to non-serious stuff (such as addition of device ID) if the
chances of regression are really low.

So IMHO the metric for including the fix is not solely "how annoying to
user this can be" but rather something like:

score = (how annoying the bug is) * ((1 / (chance of regression due to
	including this)) - 1)^3

(constants are somewhat arbitrary subject to tuning ;). Now both 'annoying'
and 'regression chance' parts are subjective and sometimes difficult to
estimate so don't take the formula too seriously but it demonstrates the
point. I think we all agree we want to fix annoying stuff and we don't want
regressions. But you need to somehow weight this over your expected
userbase - and this is where your argument "but someone might be annoyed by
LEDs not working so let's include it" has problems - it should rather be
"is the annoyance of non-working leds over expected user base high enough
to risk a regression due to this patch for someone in the expected user
base"? The answer to this second question is not clear at all to a casual
reviewer and that's why we IMHO have CC stable tag as maintainer is
supposed to have at least a bit better clue.

Another point I wanted to make is that if chance a patch causes a
regression is about 2% as you said somewhere else in a thread, then by
adding 20 patches that "may fix a bug that is annoying for someone" you've
just increased a chance there's a regression in the release by 34%. And
this is not just a math game, this also roughly matches a real experience
with maintaining our enterprise kernels. Do 20 "maybe" fixes outweight such
regression chance? And I also note that for a regression to get reported so
that it gets included into your 2% estimate of a patch regression rate,
someone must be bothered enough by it to triage it and send an email
somewhere so that already falls into a category of "serious" stuff to me.

So these are the reasons why I think that merging tons of patches into
stable isn't actually very good. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
