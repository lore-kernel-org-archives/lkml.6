Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF92C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52A62082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AqgDzdyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52A62082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbeJ2ENV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 00:13:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeJ2ENV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 00:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kcf+epc01FsJ7ik9BrpaOVR6hkeV2SyXaQYgsF4iQ+A=; b=AqgDzdynAYLDFN9qlE6Wp8Bpq
        HxPSalrveOgLAi4IMkm3mFj3kH8yPYTLIdga8KK6JHo0sqkRTqk74tMJmqrLOv9kbkGRByKq/SoSo
        P6KG9BCKjMdXMxoTuRoaP5pRrIWdrmDsz3ax/P6qHTs9ShRJ0kPoRcwd7lzbZFMxwsmGS57BicOjE
        gWtw9VpuOvszNRpDsFjYr/sYu+AnKmGb+/MsztsrSBrGusNuQcY1dhAtqy15fyRzTTXVnxM/lBkJM
        d5pKzd7vXclXndJzBsDCsAjvubVOfrrLYwDC7sFISGGxyIkX7oMIljMuRUJbf/+DZmTSKCJByt5b4
        6A1M2cu6A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGqiu-0008TK-Jm; Sun, 28 Oct 2018 19:27:44 +0000
Date:   Sun, 28 Oct 2018 12:27:44 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] XArray for 4.20
Message-ID: <20181028192744.GB28520@bombadil.infradead.org>
References: <20181023200825.GA25444@bombadil.infradead.org>
 <CAHk-=whquhQQY38WRKYsi-_a2vD=_22EPEnfVj4+APEjZPAkMw@mail.gmail.com>
 <20181028191345.GA28520@bombadil.infradead.org>
 <CAHk-=whygsqzudQZMNdYuYCcOaM-04f-O7ir73weF9g5Fzh33w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whygsqzudQZMNdYuYCcOaM-04f-O7ir73weF9g5Fzh33w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 12:21:19PM -0700, Linus Torvalds wrote:
> On Sun, Oct 28, 2018 at 12:13 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Oct 28, 2018 at 11:50:19AM -0700, Linus Torvalds wrote:
> >
> > > NOTE! I did get some conflicts with other stuff, and while the
> > > conflict resolution all looked pretty straightforward, this does want
> > > looking at.
> > >
> > > Particularly the mm/workingset.c code.
> >
> > I've been rebasing the xarray-conv branch on your tree pretty regularly
> > this week, so I have a fairly good idea how I think it should look.
> > I'll check to see if you & I have the same thoughts when you push it out.
> 
> It's pushed out now. I'm running the kernel now, but have done only
> basic boot testing (in addition to my usual build tests), no real
> stress-tests.

Yep, no differences in how we resolved the conflicts.
