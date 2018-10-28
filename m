Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A53C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BD520664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bi9ZjGk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BD520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJ2D7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 23:59:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJ2D7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 23:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9almIVtmuTpoSpTb2Xrp91SXmrqqP3LnUl0GBajhnes=; b=bi9ZjGk32B1psJXHmU4R16FBr
        Bx/Vs+n/CYAIJPuSXg+4ntPOVgaHwm0ARABz/gv7tFqMg+46vEcOH0Z2ddqYBxFtYa6tQ5i8kqHrX
        /PBAqTRxXu4bM1Ayxc8Wnkj0kGS3kHBUs53fLKgpS5vEzYuuErdxT3zhBxm2mH4NgTtMY/BezprGm
        z28uo/a/kM4uTpRyS5ODyqU8S70vfZJQaWpRrO64AXeNkmMXAvCiPY1F4USBSHTzV2XJtg8ZUZuGO
        S0SZtKJVOH8XZAqALUzT4oIg2W6NUBeQ7fh/Ru2sD/ELaQzvYZAsOFVJlKGdHBD81oG6qMcKNLXbR
        u0RMupA8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGqVO-0002dW-1B; Sun, 28 Oct 2018 19:13:46 +0000
Date:   Sun, 28 Oct 2018 12:13:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] XArray for 4.20
Message-ID: <20181028191345.GA28520@bombadil.infradead.org>
References: <20181023200825.GA25444@bombadil.infradead.org>
 <CAHk-=whquhQQY38WRKYsi-_a2vD=_22EPEnfVj4+APEjZPAkMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whquhQQY38WRKYsi-_a2vD=_22EPEnfVj4+APEjZPAkMw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 11:50:19AM -0700, Linus Torvalds wrote:
> On Tue, Oct 23, 2018 at 1:08 PM Matthew Wilcox <willy@infradead.org> wrote:
> <
> > Please consider pulling the XArray patch set.
> 
> Pulled.

Thanks!

> I took the more recent version of yours, because by the time I
> actually had time to review this thing for pulling, even the recent
> version had been in linux-next for a week.
> 
> Of course, I don't think linux-next has been updated, so it's all
> moot, but the point is that I didn't get the feeling that it was all
> some very recent code.
> 
> I do like how the conversions look, with the code in some cases
> notably simpler. And it looks like at least one of the conflicts
> (fs/dax.c) was due to a bug-fix to the old code where your simpler
> xarray replacement didn't have the problem.

Yes, that's right.  It turned out to be a problem for any multiorder
radix tree user, and that was a consequence of how the radix tree API
worked for multiorder entries.  The XArray API just works better for
multiorder entries.

> NOTE! I did get some conflicts with other stuff, and while the
> conflict resolution all looked pretty straightforward, this does want
> looking at.
> 
> Particularly the mm/workingset.c code.

I've been rebasing the xarray-conv branch on your tree pretty regularly
this week, so I have a fairly good idea how I think it should look.
I'll check to see if you & I have the same thoughts when you push it out.

> It's still undergoing my build tests to verify my merge, but that
> should be completed soon. I'll do a basic boot test too due to the
> core nature of these changes, but assuming it all passes I'll push
> this out within the next 30 minutes and would appreciate people giving
> it a second look for verification.

Thank you.
