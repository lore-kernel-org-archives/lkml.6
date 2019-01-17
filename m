Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAFD205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfAQB0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:26:51 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:5204 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbfAQB0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:26:50 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 17 Jan 2019 11:56:47 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gjwSD-0003Je-SS; Thu, 17 Jan 2019 12:26:45 +1100
Date:   Thu, 17 Jan 2019 12:26:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jiri Kosina <jikos@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190117012645.GU4205@dastard>
References: <20190110122442.GA21216@nautica>
 <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <20190111020340.GM27534@dastard>
 <CAHk-=wgLgAzs42=W0tPrTVpu7H7fQ=BP5gXKnoNxMxh9=9uXag@mail.gmail.com>
 <20190111040434.GN27534@dastard>
 <CAHk-=wh-kegfnPC_dmw0A72Sdk4B9tvce-cOR=jEfHDU1-4Eew@mail.gmail.com>
 <20190111073606.GP27534@dastard>
 <CAHk-=wj+xyz_GKjgKpU6SF3qeqouGmRoR8uFxzg_c1VpeGEJMw@mail.gmail.com>
 <20190115234510.GA6173@dastard>
 <CAHk-=wjc2inOae8+9-DK4jFK78-7ZpNR=TEyZg0Dj57SYwP-ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjc2inOae8+9-DK4jFK78-7ZpNR=TEyZg0Dj57SYwP-ng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:54:49PM +1200, Linus Torvalds wrote:
> On Wed, Jan 16, 2019 at 11:45 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > I'm assuming that you can invalidate the page cache reliably by a
> > means that does not repeated require probing to detect invalidation
> > has occurred. I've mentioned one method in this discussion
> > already...
> 
> Yes. And it was made clear to you that it was a bug in xfs dio and
> what the right thing to do was.
> 
> And you ignored that, and claimed it was a feature.

Linus, either you aren't listening or you're being intentionally
provocative.

So, for the *third* time this thread: we can probably remove this
code but first we need to be sure it doesn't cause unexpected
regressions before we commit such a change. We are not cowboys who
test userspace behavioural changes on users without review or
discussion.

Indeed, I wrote a patch to remove the invalidation /several days
ago/ and put it into my test trees, and it's been there since. Just
because you don't see immediate changes doesn't mean it isn't
happening.

> Either you care or you don't. If you don't care (and so far everything
> you said seems to imply you don't),

Linus, this is just a personal attack and IMO a violation of the
CoC.  It's straight out wrong, insulting, totally unprofessional and
completely uncalled for.

This is most definitely not a useful technical response to the
issues I raised. i.e you cut out all the context of my response
about whether "no probing necessary" page cache invalidation attacks
are something we need to care about in the future. We don't need you
to shout about existing "no probing necessary" page cache
invalidation attacks that are already being addressed, we need to
determine if it's going to be a recurring problem in future because
that directly affects the mitigation strategies we can implement.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
