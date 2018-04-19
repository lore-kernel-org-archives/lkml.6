Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3458146-1524153455-2-2947087531592103241
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524153455; b=crSJTss0hQzHTLeNHAmKOzYnMByvQuSosn6rC7oCs13NcpfhhO
    nn1gJx3dlGsfOpLzDlkT0B4KvxgLnkUex9+Oh7Eu3stS44NLRc1VikuU9m+NHN6s
    xFqSwg9LVkx99xvjEHJ1hcyPQsExmZ/a77npo8X53N3ZmJWKHAj3Y+VnrcNsp98K
    0uwyDRPXlLM86MRwpNCXOlQcZWdYzFgIgThdOyyhhUvW1HHIQU9fNKsGNTzcQS3T
    IwRQbCPBPGIJyLnIXenp1OXcL2AmZn4Q2nZjgKyt6HeDxHfGtdOlgTmXByJRnlIG
    517YD+0mwaImrxs1G9DLRoYWt5lyHpTv0Oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524153455; bh=6Ow11Mbd1TcWC0zUTkHfxP8Pm+H1T1
    sdLcCicPbgAgI=; b=dtqqNrPSijmKLDlHxd8hLWxc4WXA7c1V70twIDLGp7Sbyg
    TPUsQWZr8kYQfYav1JV4djJEM6HHkBn3ujk2WmXh3FgzGVejjkjqpcqO00y1JuxV
    TCXVDjrppJTxaoIhW5DFLpILBfOtbLAqiP2l8wTqcZaO7Ptz02OnNyBhBCC1uiBO
    gS9Aei3hkW7QNseyuBuI5RpozSLSghojV2hDMmIGpjjrJp7oH1PQJz2uMbn0H6lU
    JEd5LIc6UgAwJ765ji8SCr05ei6exmgOyZo2KL3pNbl5nNGC/ct+qGCOnkqbE9dr
    aLUxTqZttXs7jzLGGmuNdf18zSpYYgGIOc1HFjzg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDXZjUKyTSSUF0MFsSW8R6DNcO2x2V3qs2UOGFPVO4unFYDW52vBMVthhnAQJP5p25JjW96AIEhe3x5h5Nf9Vz6cmY9XSSMxKkMkMa6/dbpBGKkZ7jSe
    Wdx1aehA9mzEaIjchqu6uPMRVP38VIw7JGD+1YvUYsBT6DyRLBrZqj7vXD4j7D092QtAPCpK2mWayB3U1As6oFPStjBZ5zJDBrfHeOluKTkFy5yQKonFK7LP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=YT0Z7DDfX0aXFNZ5k_kA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeDSP5d (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:57:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeDSP5d (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 11:57:33 -0400
Date: Thu, 19 Apr 2018 17:57:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Backlund <tmb@mageia.org>
Cc: Jan Kara <jack@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
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
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180419155725.GA26978@kroah.com>
References: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home>
 <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home>
 <20180416161911.GA2341@sasha-vm>
 <7d5de770-aee7-ef71-3582-5354c38fc176@mageia.org>
 <20180419135943.GC16862@kroah.com>
 <20180419140545.7hzpnyhiscgapkx4@quack2.suse.cz>
 <20180419142222.GA29648@kroah.com>
 <276636c0-a62d-40b1-08d7-2ddf7b962044@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276636c0-a62d-40b1-08d7-2ddf7b962044@mageia.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 06:16:26PM +0300, Thomas Backlund wrote:
> Den 19.04.2018 kl. 17:22, skrev Greg KH:
> > On Thu, Apr 19, 2018 at 04:05:45PM +0200, Jan Kara wrote:
> > > On Thu 19-04-18 15:59:43, Greg KH wrote:
> > > > On Thu, Apr 19, 2018 at 02:41:33PM +0300, Thomas Backlund wrote:
> > > > > Den 16-04-2018 kl. 19:19, skrev Sasha Levin:
> > > > > > On Mon, Apr 16, 2018 at 12:12:24PM -0400, Steven Rostedt wrote:
> > > > > > > On Mon, 16 Apr 2018 16:02:03 +0000
> > > > > > > Sasha Levin <Alexander.Levin@microsoft.com> wrote:
> > > > > > > 
> > > > > > > > One of the things Greg is pushing strongly for is "bug compatibility":
> > > > > > > > we want the kernel to behave the same way between mainline and stable.
> > > > > > > > If the code is broken, it should be broken in the same way.
> > > > > > > 
> > > > > > > Wait! What does that mean? What's the purpose of stable if it is as
> > > > > > > broken as mainline?
> > > > > > 
> > > > > > This just means that if there is a fix that went in mainline, and the
> > > > > > fix is broken somehow, we'd rather take the broken fix than not.
> > > > > > 
> > > > > > In this scenario, *something* will be broken, it's just a matter of
> > > > > > what. We'd rather have the same thing broken between mainline and
> > > > > > stable.
> > > > > > 
> > > > > 
> > > > > Yeah, but _intentionally_ breaking existing setups to stay "bug compatible"
> > > > > _is_ a _regression_ you _really_ _dont_ want in a stable
> > > > > supported distro. Because end-users dont care about upstream breaking
> > > > > stuff... its the distro that takes the heat for that...
> > > > > 
> > > > > Something "already broken" is not a regression...
> > > > > 
> > > > > As distro maintainer that means one now have to review _every_ patch that
> > > > > carries "AUTOSEL", follow all the mail threads that comes up about it, then
> > > > > track if it landed in -stable queue, and read every response and possible
> > > > > objection to all patches in the -stable queue a second time around... then
> > > > > check if it still got included in final stable point relase and then either
> > > > > revert them in distro kernel or go track down all the follow-up fixes
> > > > > needed...
> > > > > 
> > > > > Just to avoid being "bug compatible with master"
> > > > 
> > > > I've done this "bug compatible" "breakage" more than the AUTOSEL stuff
> > > > has in the past, so you had better also be reviewing all of my normal
> > > > commits as well :)
> > > > 
> > > > Anyway, we are trying not to do this, but it does, and will,
> > > > occasionally happen.
> > > 
> > > Sure, that's understood. So this was just misunderstanding. Sasha's
> > > original comment really sounded like "bug compatibility" with current
> > > master is desirable and that made me go "Are you serious?" as well...
> > 
> > As I said before in this thread, yes, sometimes I do this on purpose.
> > 
> 
> And I guess this is the one that gets people the feeling that
> "stable is not as stable as it used to be" ...

It's always been this way, it's just that no one noticed :)

> > As an specific example, see a recent bluetooth patch that caused a
> > regression on some chromebook devices.  The chromeos developers
> > rightfully complainied, and I left the commit in there to provide the
> > needed "leverage" on the upstream developers to fix this properly.
> > Otherwise if I had reverted the stable patch, when people move to a
> > newer kernel version, things break, and no one remembers why.
> 
> I do understand what you are trying to do...
> 
> But from my distro hat on I have to treat things differently (and I dont
> think I'm alone doing it this way...)
> 
> Known breakages gets reverted even before it hits QA, so endusers wont see
> the issue at all...
> 
> So the only ones to see the issue are those building with latest upstream
> without own patches applied...
> 
> > 
> > I also wrote a long response as to _why_ I do this, and even though it
> > does happen, why it still is worth taking the stable updates.  Please
> > see the archives for the full details.  I don't want to duplicate this
> > again here.
> 
> And we do use latest stable (with some delay as I dont want to overload QA &
> endusers with a new kernel every week :))

You need to automate your QA :)

> We just revert known broken (or add known fixes) before releasing them to
> our users

That's great, and is what you should be doing, nothing wrong there.

thanks,

greg k-h
