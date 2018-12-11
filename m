Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D58C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95EA2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qO+cKmJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95EA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeLKN6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:58:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeLKN6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aJTJ5MIZldeJR9wlyqMgcFo7QY7iTDX7+SB9lVsga+Q=; b=qO+cKmJRBijgz/64UszLPN9J4
        wx/vwIfF4fe0nTY/K6qzxsXnJe0g31EK9JXgFPLqHf/BAh6Nd1N6k/YEvlQdDrSwo2E7y2xzl0Uaf
        uGasVCQALtxjxk7GwhsL9sivvvxpgA6ohpM6Nh76K5OAZkCbmB0wF7fz6o2/CNGLMS6nbjD/pcMZQ
        o0WzB7fdSBQoPZpFsq1/vAfhE+uMr9Mgh+NCliUyOMmevIEb8zE8WRVfL2M4CMeuYB94t0MZRPkBr
        pWi1dbxvlovoh7Bwvv7lAcnbS0HPTiryj8S3oCL7g0s1NrdJJZZCFhT7nODfKWYxxeDKguQ56OHk1
        V+tFUGGOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWiYF-0007jm-2e; Tue, 11 Dec 2018 13:58:19 +0000
Date:   Tue, 11 Dec 2018 05:58:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, david@fromorbit.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [GIT PULL] xfs: fixes for v4.20-rc6
Message-ID: <20181211135818.GA29626@infradead.org>
References: <20181208163639.GR24487@magnolia>
 <CAHk-=who9EqvvGaazise-dh7_DH6rLOULWXzysinyAPnHS4B0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=who9EqvvGaazise-dh7_DH6rLOULWXzysinyAPnHS4B0A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 11:24:48AM -0800, Linus Torvalds wrote:
> Honestly, I really wish you simply wouldn't send me "xfs" fixes that
> aren't really xfs-specific at all.
> 
> All the splice patches (and honestly, I feel some of the iomap ones
> too) that have come in through the xfs tree should have been handled
> separately as actual VFS patches. Or at least had acks from Al or
> something.

iomap came in through the XFS tree originally, and has been very much
maintained in combo, even though we now have another user with gfs.

Maybe we just need to make that official in MAINTAINERS?
