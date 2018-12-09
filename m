Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E96C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1B020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPrxOGwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1B020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeLITtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:49:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeLITtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vsGG+R0kO7ff448jh21ku/E9vIBr1FkEb+q72lWks7w=; b=gPrxOGwmWR7y/Fv9+lrrYjK8v
        rTaN9xO4a3IA1CCjSatGsO5xTL7v0p8E9aL5c2ZCY3bXERszCI3e7LeAzO3FprBEGfy+cncm1osW5
        hjEenaLmmv9Z6+g6GxKjpUBOJrlrpAwoE1t8sqqCJvpnKJzaBCcetOC19w3Oqtg6kzrlgW5EyfHXq
        N9bsb3CZYf6R5Hxg9F1nRFIhNBhFvJnKZs0xfkOaKwJ4HwnhcEr3ojo1waQTIMKDqDgmd5hWDdpPh
        pJApc39sW3KTTNcmQG+jeF305AMbcIsxIXmc96Lkp1d24W+nl6/+laXtOznTzHWfrFgIa8YPyX59+
        jKTM5p1eA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gW55G-0004mo-E8; Sun, 09 Dec 2018 19:49:46 +0000
Date:   Sun, 9 Dec 2018 11:49:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>
Subject: Re: [GIT PULL] dax fixes for 4.20-rc6
Message-ID: <20181209194946.GA6830@bombadil.infradead.org>
References: <6be0835bf256755375f3b5822bf70d74538d1d6e.camel@intel.com>
 <CAHk-=wgAONwr6pMn+D2OsMZjAB5zNaMWSW5KdTM+L72gGnhV2Q@mail.gmail.com>
 <CAPcyv4jznHRB=BCsm8Y3d-uqDy_OWHSgTsPZoPK-L80FiQftFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jznHRB=BCsm8Y3d-uqDy_OWHSgTsPZoPK-L80FiQftFg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 10:26:54AM -0800, Dan Williams wrote:
> [ add Willy and Jan ]
> 
> On Sun, Dec 9, 2018 at 10:02 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sat, Dec 8, 2018 at 10:26 PM Williams, Dan J
> > <dan.j.williams@intel.com> wrote:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-4.20-rc6
> >
> > What's going on with the odd non-exclusive exclusive wait?
> >
> >         prepare_to_wait_exclusive(wq, &ewait.wait, TASK_UNINTERRUPTIBLE);
> >         ...
> >         /*
> >          * Entry lock waits are exclusive. Wake up the next waiter since
> >          * we aren't sure we will acquire the entry lock and thus wake
> >          * the next waiter up on unlock.
> >          */
> >         if (waitqueue_active(wq))
> >                 __wake_up(wq, TASK_NORMAL, 1, &ewait.key);
> >
> > that seems to make little or no sense.
> >
> > Why isn't that prepare_to_wait_exclusive() just a regular
> > prepare_to_wait(), and then the whole "let's wake up anybody else" can
> > be removed?
> >
> > I've pulled it, but am awaiting explanation of what looks like some
> > pretty crazy code. I *suspect* it's a copy-and-paste situation where
> > you took the exclusive wait from somewhere else.
> 
> Yes, I believe that's true. In the other instances of waiting for an
> entry to be in unlocked there is a guarantee that the waiter will
> attain the lock and perform an unlock + wakeup. In the dax_lock_page()
> path there is the possibility that the inode dies before the lock is
> attained and a subsequent unlock sequence is not guaranteed. So, I
> believe the intent, Willy correct me if I am wrong, was to keep all
> waits "exclusive" for some sense of symmetry, but this one can and
> should be a non-exclusive wait.

I did indeed just copy it from elsewhere.  As I said at the time,

"This is the best I've come up with.  Could we do better by not using
the _exclusive form of prepare_to_wait()?  I'm not familiar with all the
things that need to be considered when using this family of interfaces."

but nobody suggested what the right way to use these interfaces was.

https://lists.01.org/pipermail/linux-nvdimm/2018-November/018892.html
