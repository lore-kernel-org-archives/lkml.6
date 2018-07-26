Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9880CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A98C2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HpCWFq0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A98C2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbeGZUuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:50:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbeGZUuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yt4kpoukY38rdIpGr/GPy991LMUHvz5VJETbDc5y/RU=; b=HpCWFq0OHMmSVECucmTjEBCun
        6iUUZtLOghbbhUN7Pt02eO3xQudojShuL1CM90R3F8kSDugice7zbnKP9USmDci4g3A2Bto77vsKw
        S84fM91pq7NKKnW4IzUDP8nLsMJQnpYcrj5dkPQSfRmpyx2gJ2B2FIJO1DrY2+xWSGtIqay8a8Zk5
        D+OpC3IRdTpSOKjYZXYgI5MoQFSGpuj8Zn9D9G+7uevrgM8tERP49wQdJ5TnTiyzqCDp09ba8gVAf
        RflE9xNPwH2vANjOwpX9rvTYD7sGRXJTvJvDmx390HvAvQOTCNzLR4FJWmYqnRQi8R2zAYD0hqgtQ
        thQeDWJKQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1filzX-0002H3-7o; Thu, 26 Jul 2018 19:32:03 +0000
Date:   Thu, 26 Jul 2018 12:32:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
Message-ID: <20180726193203.GA12992@bombadil.infradead.org>
References: <alpine.LSU.2.11.1807221856350.5536@eggly.anvils>
 <20180723140150.GA31843@bombadil.infradead.org>
 <alpine.LSU.2.11.1807231111310.1698@eggly.anvils>
 <20180723203628.GA18236@bombadil.infradead.org>
 <alpine.LSU.2.11.1807231531240.2545@eggly.anvils>
 <20180723225454.GC18236@bombadil.infradead.org>
 <alpine.LSU.2.11.1807240121590.1105@eggly.anvils>
 <alpine.LSU.2.11.1807252334420.1212@eggly.anvils>
 <20180726143353.GA27612@bombadil.infradead.org>
 <alpine.LSU.2.11.1807260936040.1101@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1807260936040.1101@eggly.anvils>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 09:40:20AM -0700, Hugh Dickins wrote:
> On Thu, 26 Jul 2018, Matthew Wilcox wrote:
> > On Wed, Jul 25, 2018 at 11:53:15PM -0700, Hugh Dickins wrote:
> > 
> > and fixing the bug differently ;-)  But many thanks for spotting it!
> 
> I thought you might :)

The xas_* functions are all _expected_ to behave the same way when
passed an XA_STATE containing an error -- do nothing.  xas_create_range()
behaved that way initially, then I fixed a bug and broke that invariant.
Now the test suite checks it so I won't break it again.

> > I'll look into the next bug you reported ...
> 
> No need: that idea now works a lot better when I use the initialized
> "start", instead of the uninitialized "index".

Ugh.  xas_create_range() is _supposed_ to return with xas pointing to
the first index in the range.  I wonder what I messed up.  I've had a
go at producing a test-case for this and haven't provoked a bug yet.

Still, I don't want to keep xas_create_range() around long-term.
I want to transition all the places that currently use it to use
multi-index entries.  So I'm going to put your workaround in and then
work on deleting xas_create_range() altogether.

Thanks so much for all your work on this!

