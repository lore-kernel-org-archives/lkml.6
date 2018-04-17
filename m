Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1561244-1523961593-2-17907768585898440406
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523961593; b=VNffsaTEqKXHd31dIzd0EGh9A880tF3eQXjXiB2jTBuHiS0OtL
    otcg2bg3kZiFWERQcRHt3MkGaxqvu7Rw7zLp4iYmFK+7MsfsywV482HnF7ePGfNR
    b9hs2q5K2WBd4cE9rPX9zG5m6Ah7uKUbh9Wwvr0Ikv9iqpblYAdZj42PedSTh37A
    IXH5VaJfqzWec+9oAhjhkzayfbxt4It58BY5AR//wOfuo+Er8ydw+n75KhlBb11O
    tdYv6WO360ocL0P6q6VreyUe2wOV2nXKUbKl920do87aPK32oog9VnqPl9tiCwzh
    KtXRfdmUI2HllW73NZQWwhH5tbQE5yac+Lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523961593; bh=h50jmYGNogjIiun9Q5WY2Zq1caxv3/
    JfQWDR2YR3ek4=; b=aBEV0KQCdbng8eA1Mafe2KwCW+A0KJyAUTveotHNcZDf0G
    i0csrcyCdE7iOuGzUtDOqBdHkmp3j8+dTaJc9FzjkVOQXDda69k+nMAJt8WB4Ou0
    CI5KpLfeTNswp0Yi4v70hBrT0OyWRilDMxrrjRsf71tivb5br59oLRRK5i3jl7+2
    VQaxxAd76bjEF/M5Hl4khulcd2sZo7tGTf2FMS80L6tUEcDXt+wmN53BarpMOGsZ
    ma7al072d6/xW6tSJ9og5y82Ts/HfootLkJ+Yfa9d1RiB8AiVMXOc9lqxleF4N8z
    ZIIea7FTvvh3knqooV7uESt+Uo65vct6VwE1aDRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2BKWEoc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2BKWEoc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL7TpYEYyzJPmeyMw0Lo1UrYA5CXUJfVvxvPGxGIVA4Z/t/1V4u5oq8qH3DpmuMeN2QTw1vsuaDdnFi4KevWYWErDDRMyW5VRK2yI7J1mPu8QTKqF4yC
    KplEGfxvqAYufKfaacf+nYEVBY9NbT6v1PfwQRQuV9FkGgcbzQfQF5u5rH4u/PreNNk/pd5eR9ruHwy+wC7gRKPkFByZXAxSC+5mInfIAQarvTvLefqhiCt9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=eeHpouDjRTRtngRLb44A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeDQKjq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 06:39:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47423 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751211AbeDQKjm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 06:39:42 -0400
X-ME-Sender: <xms:7s7VWuHcrlk5O-jA3h7AM7kR_l6aty33QU9QDrnTkhEvODdH16A9_w>
Date: Tue, 17 Apr 2018 12:39:36 +0200
From: Greg KH <greg@kroah.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20180417103936.GC8445@kroah.com>
References: <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
 <20180416170501.GB11034@amd>
 <20180416171607.GJ2341@sasha-vm>
 <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
 <20180416203629.GO2341@sasha-vm>
 <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
 <20180416211845.GP2341@sasha-vm>
 <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:28:44PM +0200, Jiri Kosina wrote:
> On Mon, 16 Apr 2018, Sasha Levin wrote:
> 
> > I agree that as an enterprise distro taking everything from -stable
> > isn't the best idea. Ideally you'd want to be close to the first
> > extreme you've mentioned and only take commits if customers are asking
> > you to do so.
> > 
> > I think that the rule we're trying to agree upon is the "It must fix
> > a real bug that bothers people".
> > 
> > I think that we can agree that it's impossible to expect every single
> > Linux user to go on LKML and complain about a bug he encountered, so the
> > rule quickly becomes "It must fix a real bug that can bother people".
> 
> So is there a reason why stable couldn't become some hybrid-form union of
> 
> - really critical issues (data corruption, boot issues, severe security 
>   issues) taken from bleeding edge upstream
> - [reviewed] cherry-picks of functional fixes from major distro kernels 
>   (based on that very -stable release), as that's apparently what people 
>   are hitting in the real world with that particular kernel

It already is that :)

The problem Sasha is trying to solve here is that for many subsystems,
maintainers do not mark patches for stable at all.  So real bugfixes
that do hit people are not getting to those kernels, which force the
distros to do extra work to triage a bug, dig through upstream kernels,
find and apply the patch.

By identifying the patches that should have been marked for stable,
based on the ways that the changelog text is written and the logic in
the patch itself, we circumvent that extra annoyance of users hitting
problems and complaining, or ignoring them and hoping they go away if
they reboot.

I've been doing this "by hand" for many years now, with no complaints so
far.  Sasha has taken it to the next level as I don't scale and has
started to automate it using some really nice tools.  That's all, this
isn't crazy new features being backported, it's just patches that are
obviously fixes being added to the stable tree.

Yes, sometimes those fixes need additional fixes, and that's fine,
normal stable-marked patches need that all the time.  I don't see anyone
complaining about that, right?

So nothing "new" is happening here, EXCEPT we are actually starting to
get a better kernel-wide coverage for stable fixes, which we have not
had in the past.  That's a good thing!  The number of patches applied to
stable is still a very very very tiny % compared to mainline, so nothing
new is happening here.

Oh, and if you do want to complain about huge new features being
backported, look at the mess that Spectre and Meltdown has caused in the
stable trees.  I don't see anyone complaining about those massive
changes :)

thanks,

greg k-h
