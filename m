Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1561244-1523962258-2-12204246484460462025
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
    1523962257; b=b2YBDxk3xSaP5VA+YhJaJa3EyYiZ5hhwutzyCkAKuaLLegaP6F
    3E/ZBDijP4qJATMSrxy9+BvxcdOs9GVCQ6Aqff9VBB5lZOlxhBjHEh7yLs/ksvv5
    ERvyA98ysH+kFlKT+/B7vWAK0USj9pO9K/He380J0lC6Y92WXdtWOhTn7quXGTg5
    wGBve3GjmUsjskPjoM9ahFWgYuIh5J9yHOOTyTXgf2K5Cn4O9n4j9MnySIMrlynR
    K/ZljV6kn7zJMRhEoP1Ou318Zp/pKOJJIaY4YSufNzZr71kN+pA1pS+2pomYqQhl
    HVt0fQNgku2bXa5+elpqjGEcbvb0r/c6im9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523962257; bh=4CSHzo0Yl1yUt6mJ5+V97/h8SKVm4a
    B/czyjSpX+ank=; b=bxlIRNfTcNwlmErTSqC3nTX/94nYKzGQPJjBjswn88OlRr
    Ky6ILzpfsxXo1IItlF1JetDPYGgHSnSBCycH5XB3j8PNMJ3ZGlIrYOoo6/g4jfB4
    CERl1BxOXaG2nUqOkAcC4JR9Ojq/8BoCnmTVMaUJx6vAYDkI94qyhlzvu3THWGKA
    t5TOBV90SIwPVuzZ0tNTeoUsvjmEx/XZpJFegtdQxDYXMi6mDbau1hLNc+rOpzyf
    BjUm2xu75iuEt1sIoAzHwLUh4/mJHwBttlgavD0ITV6fYzXMgVx6XuiaFrZv6mSw
    d9m0iI2C+zii0gEa0rGo7dhda9iKjqsDuu4zALkA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwUAjTXe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwUAjTXe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBzaU5J2ldY6ijtAez0U71PfXYaXZDINNffimW+j0QNT89bD2rNpDmwCAJfbtltjANdXkUG5qLafO4g1j3qc81welHZPjvb9guO6T0kmV7zXCPgC3rUo
    3PObDN7XklIVd8fFGeGggmb4n4lQvzgpH71ktrwOcd6myHq9XbrKlWYRoTcbojOYD4RqZf4SQxhMrZlGveotF2IQr/TiSxJvdH7DHwHWzKM4wTclQ+dmomV7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=dm4jBFFMhhvwdG5pN5MA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeDQKu4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 06:50:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46943 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751927AbeDQKuz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 06:50:55 -0400
X-ME-Sender: <xms:jtHVWkbbVURJud_OeKZHiTBq3ckTpIuYenkJcA4WriXHEF1e0zouTQ>
Date: Tue, 17 Apr 2018 12:50:49 +0200
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
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
Message-ID: <20180417105049.GE8445@kroah.com>
References: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
 <20180416162850.GA7553@amd>
 <20180416163917.GE2341@sasha-vm>
 <20180416164230.GA9807@amd>
 <20180416164514.GG2341@sasha-vm>
 <20180416165451.GB9807@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416165451.GB9807@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 06:54:51PM +0200, Pavel Machek wrote:
> On Mon 2018-04-16 16:45:16, Sasha Levin wrote:
> > On Mon, Apr 16, 2018 at 06:42:30PM +0200, Pavel Machek wrote:
> > >On Mon 2018-04-16 16:39:20, Sasha Levin wrote:
> > >> On Mon, Apr 16, 2018 at 06:28:50PM +0200, Pavel Machek wrote:
> > >> >
> > >> >> >> Is there a reason not to take LED fixes if they fix a bug and don't
> > >> >> >> cause a regression? Sure, we can draw some arbitrary line, maybe
> > >> >> >> designate some subsystems that are more "important" than others, but
> > >> >> >> what's the point?
> > >> >> >
> > >> >> >There's a tradeoff.
> > >> >> >
> > >> >> >You want to fix serious bugs in stable, and you really don't want
> > >> >> >regressions in stable. And ... stable not having 1000s of patches
> > >> >> >would be nice, too.
> > >> >>
> > >> >> I don't think we should use a number cap here, but rather look at the
> > >> >> regression rate: how many patches broke something?
> > >> >>
> > >> >> Since the rate we're seeing now with AUTOSEL is similar to what we were
> > >> >> seeing before AUTOSEL, what's the problem it's causing?
> > >> >
> > >> >Regression rate should not be the only criteria.
> > >> >
> > >> >More patches mean bigger chance customer's patches will have a
> > >> >conflict with something in -stable, for example.
> > >>
> > >> Out of tree patches can't be a consideration here. There are no
> > >> guarantees for out of tree code, ever.
> > >
> > >Out of tree code is not consideration for mainline, agreed. Stable
> > >should be different.
> > 
> > This is a discussion we could have with in right forum, but FYI stable
> > doesn't even guarantee KABI compatibility between minor versions at this
> > point.
> 
> Stable should be useful base for distributions. They carry out of tree
> patches, and yes, you should try to make their lives easy.

How do you know I already don't do that?

But no, in the end, it's not my job to make their life easier if they
are off in their own corner never providing me feedback or help.  For
those companies/distros/SoCs that do provide that feedback, I am glad to
work with them.

As proof of that, there are at least 3 "major" SoC vendors that have
been merging every one of the stable releases into their internal trees
for the past 6+ months now.  I get reports when they do the merge and
test, and so far, we have only had 1 regression.  And that regression
was because that SoC vendor forgot to upstream a patch that they had in
their internal tree (i.e. they fixed it a while ago but forgot to tell
anyone else, nothing we can do about that.)

So if you are a distro/company/whatever that takes stable releases, and
have run into problems, please let me know, and I will be glad to work
with you.

If you are not that, then please don't attempt to speak for them...

thanks,

greg k-h
