Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C443C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A38A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A38A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeHOVrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:47:06 -0400
Received: from fieldses.org ([173.255.197.46]:60768 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeHOVrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:47:05 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 6E0B41CE7; Wed, 15 Aug 2018 14:53:45 -0400 (EDT)
Date:   Wed, 15 Aug 2018 14:53:45 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com>,
        jlayton@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: general protection fault in send_sigurg_to_task
Message-ID: <20180815185345.GB29569@fieldses.org>
References: <0000000000007f59610573509684@google.com>
 <000000000000f4136d0573512103@google.com>
 <20180814191129.GN7906@fieldses.org>
 <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
 <20180815101120.019f069e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815101120.019f069e@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 10:11:20AM +1000, Stephen Rothwell wrote:
> Hi Bruce,
> 
> On Tue, 14 Aug 2018 13:50:20 -0700 Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, Aug 14, 2018 at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > On Mon, Aug 13, 2018 at 06:33:02AM -0700, syzbot wrote:  
> > >> syzbot has found a reproducer for the following crash on:
> > >>
> > >> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
> > >> git tree:       linux-next  
> > >
> > > I fetched linux-next but don't have 5ed5da74de9e.  
> > 
> > +Stephen for the disappeared linux-next commit.
> 
> That is just the HEAD commit on linux-next that day.  If you fetched
> linux-next after I released next-20180814 yesterday, then it would have
> a different HEAD commit.  If you check out the tag next-20180813, you
> will get the above HEAD commit.
> 
> > On the dashboard link you can see that it also happened on a more
> > recent commit 4e8b38549b50459a22573d756dd1f4e1963c2a8d that I do see
> > now in linux-next.
> 
> Which is just the HEAD commit of next-20180814.
> 
> Linux-next is rebuilt every day based on Linus' tree of the day,
> followed by merging all the other branches, so its HEAD is different
> every day.

I new it was rebuilt every day, but for some reason I expected git to
fetch all new tags.  But that's wrong, it just fetches whatever
branch(es) you request and then only tags that happen to reference stuff
on that branch; from git-fetch(1): "By default, any tag that points into
the histories being fetched is also fetched; the effect is to fetch tags
that point at branches that you are interested in. This default behavior
can be changed by using the --tags or --no-tags options or by
configuring remote.<name>.tagOpt.  By using a refspec that fetches tags
explicitly, you can fetch tags that do not point into branches you are
interested in as well."

Sorry for the confusion!

--b.
