Return-Path: <mhocko@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2397738-1523988631-2-12334428935821206492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_MED -2.3, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='195.135.220.15', Host='mx2.suse.de', Country='DE', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: mhocko@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523988630; b=oAHlZ3oWo629VW7xz2051sioY5V3hFp64ARRLMxa1fNwo8WfMb
    G3t23pOqv59m4YCz8YnKEDCFiIyMzp8wjd5Eg7BUKAy8RCNGe4qUaQqCAOlelZ4t
    EnggRf7+Vah2+nzbHXvHrTrrN6/ZNizeGttnP4ya7ffTK9dtuQA51lzZH8iAsuDn
    0m5AEwREm/yvrf0VuwYVHao1KN4mUwMCcwfgaZ9DqwlN6bYYvQFmXOaN8VoKktb5
    9NkXFmF1cboAHzDdhPPWuqFmEnz+JAv9elte4gU6QPQfND5ylM7LHTkh+GmapF+5
    NLblgxAbdFdn1VBVYQD9Rzs3Ci2nZRTc4Ung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1523988630; bh=9cSqNvgYePexJZMsQHxpCPpb2mb6/nYxvjUemtwGdWw=; b=T
    AN+xuBzgopMXDKhhLPAZMRBd+g5mLfRTY1nq06pBVU+XJSoUvuagEozjoseZI8k6
    9p2YPJxH77+oou8ahksfvDZb3JmhcE9U5QJ/JbGSHw5msZ3BhZ5VwjdOTxzZIWxg
    B40+AqJn3c/Gz/8ahbKcuMXPkdzmdeD7PHE31hirhsWu6DbBEGL/gDCNADUO3fRq
    R5/9R0V9hPH3E0fH1vRQU3qlR378IGSbhZzzfuKE0fXdfR4AkI0JjFc3u9X+uYfK
    2Ff+6UNLQALZ9Idg6uEPV4EXg+ZQGNIyeifHDLHGqeXf8SpbPI8sq47BxeaGCyci
    euSJs3GakYnushF+S7MOw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=none smtp.mailfrom=mhocko@kernel.org smtp.helo=mx2.suse.de;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=none smtp.mailfrom=mhocko@kernel.org smtp.helo=mx2.suse.de;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKzudsT9fKCyCuBFkUJVWun1sTV52zsOCF9fUQk2qEr8fUbG0I8Va1HTZIKaju4BEnlvGJpuBaQTK5MALyXJXvAgA3yBJoVXOO0mqaaueqUMEaQVHELJ
    tDUbpu30/vpej637T6zgeLzpL1UlhyAKC/3tkai8RDVg6DaLb6/li3Vj3njYxM5F7Ov85sskJiQVrw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=uEuDQZVrWKuLCe7byFjfVg==:117
    a=uEuDQZVrWKuLCe7byFjfVg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=D19gQVrFAAAA:8 a=xKbrcJ0dfxSLyEou3xwA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Date: Tue, 17 Apr 2018 20:10:25 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Petr Mladek <pmladek@suse.com>, Greg KH <greg@kroah.com>,
	Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180417181025.GJ17484@dhcp22.suse.cz>
References: <20180416163107.GC2341@sasha-vm>
 <20180416124711.048f1858@gandalf.local.home>
 <20180416165258.GH2341@sasha-vm>
 <20180416170010.GA11034@amd>
 <20180417104637.GD8445@kroah.com>
 <20180417122454.rwkwpsfvyhpzvvx3@pathway.suse.cz>
 <20180417124924.GE17484@dhcp22.suse.cz>
 <20180417133931.GS2341@sasha-vm>
 <20180417142246.GH17484@dhcp22.suse.cz>
 <20180417143641.GV2341@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417143641.GV2341@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 17-04-18 14:36:44, Sasha Levin wrote:
> On Tue, Apr 17, 2018 at 04:22:46PM +0200, Michal Hocko wrote:
> >On Tue 17-04-18 13:39:33, Sasha Levin wrote:
> >[...]
> >> But mm/ commits don't come only from these people. Here's a concrete
> >> example we can discuss:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c61611f70958d86f659bca25c02ae69413747a8d
> >
> >I would be really careful. Because that reqiures to audit all callers to
> >be compliant with the change. This is just _too_ easy to backport
> >without noticing a failure. Now consider the other side. Is there any
> >real bug report backing this? This behavior was like that for quite some
> >time but I do not remember any actual bug report and the changelog
> >doesn't mention one either. It is about theoretical problem.
> 
> https://lkml.org/lkml/2018/3/19/430
> 
> There's even a fun little reproducer that allowed me to confirm it's an
> issue (at least) on 4.15.
> 
> Heck, it might even qualify as a CVE.
> 
> >So if this was to be merged to stable then the changelog should contain
> >a big fat warning about the existing users and how they should be
> >checked.
> 
> So what I'm asking is why *wasn't* it sent to stable? Yes, it requires
> additional work backporting this, but what I'm saying is that this
> didn't happen at all.

Do not ask me. I wasn't involved. But I would _guess_ that the original
bug is not all that serious because it requires some specific privileges
and it is quite unlikely that somebody privileged would want to shoot
its feet. But this is just my wild guess.

Anyway, I am pretty sure that if the triggering BUG was serious enough
then it would be much safer to remove it for stable backports.
-- 
Michal Hocko
SUSE Labs
