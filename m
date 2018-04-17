Return-Path: <mhocko@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1970493-1523974974-2-2050220582847176367
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
    1523974974; b=NRxnlfYuMWwRaz7mUwvM0twcYgEztUrCZCBraIkjXYPUsUjR4r
    Tvj6bDxsYRYJSG9GgFSglqq3UncCOAfv68Mk9GWbzMqJrUVOmD27RpMbMTlip7la
    bn0q/hN+x0A6J1uUjyDXaB98u8XgbswCWN3/GHGhrmvOGed6icyNeNKRa87ZqJ/M
    b/TVWQe1pfbNulVCi91+S0CwWrpV+HlBXQz/FHaHvLI3w/PdEtuv2CiCQcsF9Z0Y
    R7kADxr1eQxgHSwI94K/F74lBDrBcEuNFc9ZLSOAvzxd6/prTPcUJw3sFN/B8uFu
    ttucXtDXqiwchXo9gMXNU6Rs6+GdSbZh1YqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1523974974; bh=UJtgYIOooRtTO+CF3HdSkcwoP2ZwQnfAyY6YJ3g19j8=; b=f
    /IVQpEJDJr9xNWgUy7y0d9AMAXTSlMNCA24SNCEKup5giX1OREDaUnyJe1UglhWK
    yaHHvjLH+YO21qbj4e6O4g+otSTl04avkxjl2GOKoKOqmvmpwuCWEhFG/04pcC7c
    a6Cl9I/PZjvQ7UVuBOsnwVuraQ/JRWwRzjG1L1BW52UXMYDkE1RvQYKg2YLLfvVc
    Q+2yDbQAYrnfmdyLHWx3q3xFri3qym8km2BOOPMR2GdeTc0qol5/85XdMH8LAcLr
    Eoim2gdtsW8znwmR5WCCc5RhnfMQhuDmHAvEHDQMooUoTceb5e01yKO2QTzsYqyQ
    jsbi0c+XiBtrNjvMspbXg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfNbEBv30cxMEuby+ql6i2nXnMGK7TBV3HU5sRycfcW6BlqS4FDB9GhxU5rzqa9t/uQ2dBXks9e1le6lVbnKwa+aaAR9TMm7WWPfjSeXENnGGoq6cyc92
    I2ZEhUxTq9ENmMgQVA94rmGPYg5dP8D7QYmWPDWEwiptGyIAi0f7vv7VyaER6ed0fKMwwnAqqSHk0Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=uEuDQZVrWKuLCe7byFjfVg==:117
    a=uEuDQZVrWKuLCe7byFjfVg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=QaCT7-2CfV7RJu2TnXwA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Date: Tue, 17 Apr 2018 16:22:46 +0200
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
Message-ID: <20180417142246.GH17484@dhcp22.suse.cz>
References: <20180416161412.GZ2341@sasha-vm>
 <20180416122244.146aec48@gandalf.local.home>
 <20180416163107.GC2341@sasha-vm>
 <20180416124711.048f1858@gandalf.local.home>
 <20180416165258.GH2341@sasha-vm>
 <20180416170010.GA11034@amd>
 <20180417104637.GD8445@kroah.com>
 <20180417122454.rwkwpsfvyhpzvvx3@pathway.suse.cz>
 <20180417124924.GE17484@dhcp22.suse.cz>
 <20180417133931.GS2341@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417133931.GS2341@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 17-04-18 13:39:33, Sasha Levin wrote:
[...]
> But mm/ commits don't come only from these people. Here's a concrete
> example we can discuss:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c61611f70958d86f659bca25c02ae69413747a8d

I would be really careful. Because that reqiures to audit all callers to
be compliant with the change. This is just _too_ easy to backport
without noticing a failure. Now consider the other side. Is there any
real bug report backing this? This behavior was like that for quite some
time but I do not remember any actual bug report and the changelog
doesn't mention one either. It is about theoretical problem. 

So if this was to be merged to stable then the changelog should contain
a big fat warning about the existing users and how they should be
checked.

Besides that I can see Reviewed-by: akpm and Andrew is usually very
careful about stable backports so there probably _was_ a reson to
exclude stable.
-- 
Michal Hocko
SUSE Labs
