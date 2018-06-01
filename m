Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2321724-1527820232-2-9866895311203669031
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527820231; b=HJ0lJMdGoU1Yuqh/0S3NU4JB4AcCZfUDHDPwlLfOsbldMhG/Dl
    NSDfQIH+G6bg/dLSP/bY/PFf1nJwN6QpPsLyIQtICe1NnIY8BmWc7VHqi8chBA/Z
    l3BthLtm2L997ir+7Bf7sYgf1Z3yGWxLli42PE8hASTGqjKHPKzVF4RD2aTEYa6H
    9yfd1JVnobxHL/Xc8fGY4vqeZu9BhTqbcMLfnjrSRa4Fm3pQ4heaP3C7Od94cNP2
    j8hmtjoO9P93GvOM+BiHUvTOoOIqK6NZhoF6t7JwnwFeAmRlWJVRvSOWin6F2iIl
    JKl2nY9zaqPqxHr3oqrkBZV0dMhh/aqWUaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527820231; bh=oL1OchHkpq77l+sCzi7IFvlOxJpBOP
    dtQyD39bY/Amo=; b=heg1yrkBlRC3S5GQqEh4HB3P2vDV8/zxcrSu39WoDh6hGN
    Q4wfsnhhVezdzHaP13i82lWmf0ZjIzwceLn7arn7pWB/ZYAfNGUulNrCajhoKZUv
    Z/ytIuOdnZrqPmNCHlelCjCxyZ5nU3ctRfWwpANsAezjLYqkR24gDy5Sjn/ahbQu
    phQifXz0aMIMAYhwGSfseT5cI1eq0t8JvBYZI98c0JrrRjwbOGr6hESzwETK77RR
    pMihM1jS1Sv8Ys4q8ut22anRRJEZEGu24cOPwMoYkWSt1AfO9iiGpx+Cfstt2+T+
    TwgO2QDxgOW+lq2KsJmt9ZKH5zEHmcjYQEd+Kc/g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=fromorbit.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=fromorbit.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN9gcwwwLTvyEcu7F/R1NUJS8KexfapI3GGw9FQLGOmzLLqQ4LbgI/8LIXB+ucLmksCzdgzSpa0hawGuNjB0YepdAPPtjPn3skIvTdqBPEBZL3HVRS2N
    Yek0Gy+mLbPIj70cVeOdHNNUElpmZSBc77djlUeJdv2rKozk1TKcwvWcWkPVuejtasqLi8cM8O4IUPCrOYGADONO7AL8nVjgPqO1CUZ0ub8oX/E4SVAixnnP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=edf1wS77AAAA:8 a=7-415B0cAAAA:8 a=P4K4W6Fyn4NAIot7mhgA:9 a=CjuIK1q_8ugA:10
    a=DcSpbTIhAlouE1Uv7lRv:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeFACaQ (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 22:30:16 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:18615 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750990AbeFACaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 May 2018 22:30:13 -0400
Date: Fri, 1 Jun 2018 12:30:02 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: general protection fault in wb_workfn (2)
Message-ID: <20180601023002.GA10972@dastard>
References: <000000000000cbd959056d1851ca@google.com>
 <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
 <20180528133503.awomzj6djozbo5bv@quack2.suse.cz>
 <2dda7a11-3f6b-bdba-a68a-7c0694806cc4@I-love.SAKURA.ne.jp>
 <20180531114228.6zx27xxurmz27pke@quack2.suse.cz>
 <c0fc1c47-0efb-5ded-7f6c-79074ad4deac@i-love.sakura.ne.jp>
 <20180531134212.oo4ra4ypuruab3xp@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531134212.oo4ra4ypuruab3xp@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 31, 2018 at 03:42:12PM +0200, Jan Kara wrote:
> On Thu 31-05-18 22:19:44, Tetsuo Handa wrote:
> > On 2018/05/31 20:42, Jan Kara wrote:
> > > On Thu 31-05-18 01:00:08, Tetsuo Handa wrote:
> > >> So, we have no idea what is happening...
> > >> Then, what about starting from temporary debug printk() patch shown below?
> > >>
> > >> >From 4f70f72ad3c9ae6ce1678024ef740aca4958e5b0 Mon Sep 17 00:00:00 2001
> > >> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > >> Date: Wed, 30 May 2018 09:57:10 +0900
> > >> Subject: [PATCH] bdi: Add temporary config for debugging wb_workfn() versus
> > >>  bdi_unregister() race bug.
> > >>
> > >> syzbot is hitting NULL pointer dereference at wb_workfn() [1]. But due to
> > >> limitations that syzbot cannot find reproducer for this bug (frequency is
> > >> once or twice per a day) nor we can't capture vmcore in the environment
> > >> which syzbot is using, for now we need to rely on printk() debugging.
> > >>
> > >> [1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206
> > >>
> > >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > 
> > > Hum a bit ugly solution but if others are fine with this, I can live with
> > > it for a while as well. Or would it be possible for syzkaller to just test
> > > some git tree where this patch is included? Then we would not even have to
> > > have the extra config option...
> > 
> > If syzbot can reproduce this bug that way. While it is possible to add/remove
> > git trees syzbot tests, frequently adding/removing trees is bothering.
> > 
> > syzbot can enable extra config option. Maybe the config name should be
> > something like CONFIG_DEBUG_FOR_SYZBOT rather than individual topic.
> > 
> > I think that syzbot is using many VM instances. I don't know how many
> > instances will be needed for reproducing this bug within reasonable period.
> > More git trees syzbot tests, (I assume that) longer period will be needed
> > for reproducing this bug. The most reliable way is to use the shared part
> > of all trees (i.e. linux.git).
> 
> I understand this, I'd be just a bit reluctant to merge temporary debug
> patches like this to Linus' tree only to revert them later just because
> syzkaller... What do others think?

Don't commit temporary debug crap to the mainline kernel. Enable
syzkaller to run against a user supplied git tree specification if
it needs special debug to track down a problem.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
