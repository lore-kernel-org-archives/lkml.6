Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EFEECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E982081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E982081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbeKEH1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 02:27:32 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:64366 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729223AbeKEH1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 02:27:32 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 05 Nov 2018 08:41:02 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gJQbk-0004qB-Lf; Mon, 05 Nov 2018 09:11:00 +1100
Date:   Mon, 5 Nov 2018 09:11:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     djwong@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [GIT PULL] vfs: fix many problems in vfs clone/dedupe
 implementation
Message-ID: <20181104221100.GI19305@dastard>
References: <20181102051459.GS6311@dastard>
 <CAHk-=whrpyMSWM4wxYE+E4fSbpkD3yBATjLnzvvAKBfhGwUaAw@mail.gmail.com>
 <20181102233651.GH19305@dastard>
 <CAHk-=wiJdzKEq2RsQCe5R1X2W0AEiOYOt8womcyTfkD=mgQAug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJdzKEq2RsQCe5R1X2W0AEiOYOt8womcyTfkD=mgQAug@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 10:13:37AM -0700, Linus Torvalds wrote:
> On Fri, Nov 2, 2018 at 4:36 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Nov 02, 2018 at 09:35:23AM -0700, Linus Torvalds wrote:
> > >
> > > I don't love the timing of this at the end of the merge window, but pulled,
> >
> > When would have been a better time? It's too big for a late -rc, and
> > it contains stuff that needs fixing pretty urgently. So if the merge
> > window is not appropriate, what should we have done here?
> 
> No, I think that with the timing of the problem finding, it was
> probably the only thing to do, but generally I like these kinds of
> somewhat scary and disruptive patches (just because it touches
> multiple filesystems) _early_ in the merge window if at all possible,
> and showing that the development was done before and not some rushed
> thing..

Fair enough. That was partly my fault - I forgot to add sob's to the
commits when I pulled the final version in for testing in the middle
of the first week of the merge window. I didn't realise that until
after I'd soak and stress tested it and was getting ready to push it
out to linux-next a week later. So I had to rewrite all the commits
and so they would have looked an awful lot more recent than they
really were. I should have mentioned this in the pull request...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
