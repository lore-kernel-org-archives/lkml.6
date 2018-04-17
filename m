Return-Path: <SRS0=ei9q=HG=goodmis.org=rostedt@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1954995-1523974509-2-9252824409540427636
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=ei9q=HG=goodmis.org=rostedt@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523974509; b=pPTe2nRtPiEiffMyMkZ6aP0WdHXsBlXwQZZfrf26gGCIL149Ve
    2VNvDaX1bvW8zQmD38cRnt+kLhhen0poCYW9HYdVWuev9P06CyoNenFwV38Q2EJ9
    /GFWfgCtxQe14Fm9HV1kU65jrxoTX9xOhAjhZdbN1oDl2lenLSgCCQnKu55PobNq
    NEreu2fY92Hv7CyeZsiI90ZCG7l+DDu7l3VmWru5ExslClMmfoh6GB7ULqZy5Rob
    /crTJLhFpy1o0RarWsjCa6aFu07Fqi7BePcYf/DNNFgWmpNJhQytK7WDGW2cZ/Q+
    9Tr6m2I7oba8cg+seavNLFc8P1zn3hfqYNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding; s=fm2; t=1523974509; bh=mHlqxicPhkta
    VHgl03yoSVPu6a/QjihA19cgvpexN4s=; b=w8g5xWTdNU8XJ99ddH4G4HO7E6J5
    /lPXqpv4DmZVani1ulhcthYtaQNR3YhQA6NXOvgSUqozRTzph3spesMjhtveohzg
    oKBGLWy/42vAeFTpCJNEjMSWvekQ/kBIC0IYNTcJPthDQe+qa/OXRkVk4k2gwfX1
    9Tun9fvJgYS0qqOyBQf7KcdRbSGXNvEf4wt5hxPPUeZrH5UPkl2cynuhAZAv4QBk
    tiOJp4sgTDACozPjYIDo5b1S4P2tpyvhFZxiXy9H+4V1EsU8gkIad5FJGX628Ter
    gUZLe4R+v8LeOu3eXbrwKe8SPOMDxjHkZcwAfhHT+oCmP0qfLcazjB7DXw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=ei9q=HG=goodmis.org=rostedt@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=ei9q=HG=goodmis.org=rostedt@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOSYrchL5YPAx3eSc9/2OmacyUrOZ/vbu3IjIOIeaTQLqQJZ2ONWzeu2+NRKjf0HcL0FCAsp1QFDZ02fJYQ8vsqJ6NpfDo+kjdb64h7EKlK88xDpsgK3
    5jnKw4vUZBihkzR2HF4YUdHnOzd/yJIn2hlZ3NBdX05BVDTwxEevyVfWZ9IMNBrmKk+WGCDAkktU2vDCF6gF+4Hvwtnnnb7OVMU=
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=fibJCoX4rjVD0cfHC4IA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50B82175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 17 Apr 2018 10:15:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Michal Hocko <mhocko@kernel.org>, Greg KH <greg@kroah.com>, Jiri Kosina
 <jikos@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linus Torvalds
 <torvalds@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Cong Wang
 <xiyou.wangcong@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka
 <vbabka@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Jan Kara
 <jack@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tetsuo
 Handa <penguin-kernel@i-love.sakura.ne.jp>, Byungchul Park
 <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180417101502.3f61d958@gandalf.local.home>
In-Reply-To: <20180417140434.GU2341@sasha-vm>
References: <20180416161412.GZ2341@sasha-vm>
	<20180416170501.GB11034@amd>
	<20180416171607.GJ2341@sasha-vm>
	<alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
	<20180416203629.GO2341@sasha-vm>
	<nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
	<20180416211845.GP2341@sasha-vm>
	<nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
	<20180417103936.GC8445@kroah.com>
	<20180417110717.GB17484@dhcp22.suse.cz>
	<20180417140434.GU2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 17 Apr 2018 14:04:36 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> The solution to this, in my opinion, is to automate the whole selection
> and review process. We do selection using AI, and we run every possible
> test that's relevant to that subsystem.
> 
> At which point, the amount of work a human needs to do to review a patch
> shrinks into something far more managable for some maintainers.

I guess the real question is, who are the stable kernels for? Is it just
a place to look at to see what distros should think about. A superset
of what distros would take. Then distros would have a nice place to
look to find what patches they should look at. But the stable tree
itself wont be used. But it's not being used today by major distros
(Red Hat and SuSE). Debian may be using it, but that's because the
stable maintainer for its kernels is also the Debian maintainer.

Who are the customers of the stable trees? They are the ones that
should be determining the "equation" for what goes into it.

Personally, I use stable as a one off from mainline. Like I mentioned
in another email. I'm currently on 4.15.x and will probably move to
4.16.x next. Unless there's some critical bug announcement, I update my
machines once a month. I originally just used mainline, but that was a
bit too unstable for my work machines ;-)

-- Steve
