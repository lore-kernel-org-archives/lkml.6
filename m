Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A97DC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FC0218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LjhvsJkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbeLUQem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:34:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLUQem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=krbbnlb6aVpMQ0gn3zlurEu/lpfGp4O1sxU7b/D6AB4=; b=LjhvsJkDRbPj2LmvmPvTqWyu8
        8oHP2oq7tBxsqV5tzX4rGbYu60eiuULOO6D04V9rfgGOFf5ls9wYGkXmAnfZ8xsSu/gfv5+fqoxGN
        Cn1HrI7CKvcYj9eZ+NxFBkGB7wUYXB2lNpWTIEIMj4PSyScBd1dEJtqt73xNM8Jnim8Rn+sGKA0uB
        H2DH+jycEt32k98weJclKFJLvsCeZklAO27XvQo0xW/V5hQoDzDoVdCKfaYzvgTqiAcDKJ0aClNJD
        D4vq8m+YhLpLHYYkWPEKpKcDfjOZqZ5aPt4nOPoEBk9UyZlApTz7zG4N4WzwzsTANcXs9coDc12Ea
        guKcQBJEQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaNl0-0002tb-U0; Fri, 21 Dec 2018 16:34:38 +0000
Date:   Fri, 21 Dec 2018 08:34:38 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181221163438.GE10600@bombadil.infradead.org>
References: <20181219071420.GC2628@infradead.org>
 <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu>
 <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu>
 <20181221070447.GA21687@infradead.org>
 <20181221154714.GA26547@mit.edu>
 <20181221155354.GC10600@bombadil.infradead.org>
 <20181221162813.GB26547@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221162813.GB26547@mit.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:28:13AM -0500, Theodore Y. Ts'o wrote:
> On Fri, Dec 21, 2018 at 07:53:54AM -0800, Matthew Wilcox wrote:
> > In contrast to "we'll just fix it up later" (which usually applies
> > to in-kernel interfaces), we have a policy of not breaking userspace,
> > so accepting this interface means setting it in stone.  We should get
> > it right.
> 
> I'm not convinced it's a "fix", but my point is that if later on you
> want to add extra complexity transforming
> 
>      ioctl(fd, FS_IOC_ENABLE_VERITY);
> 
> so it does the equivalent of
> 
>      ioctl(fd, FS_IOC_ENABLE_VERITY_NOW_WITH_EXTRA_USELESS_COMPLEXITY,
> 	   fd, sizeof_data, sizeof_verity_data);

I disagree with your EXTRA_USELESS_COMPLEXITY appendage.  The interface
you designed reflects the implementation you did in ext4, so I understand
why it seems simple from your point of view.  From the user point of view,
it looks completely weird.  You write a file, being a series of bytes,
then all of a sudden have to know that it's composed of blocks, seek
to the next block, write a header, then this Merkle data structure,
then write a footer which isn't allowed to cross a block boundary
for some unknowable reason.  It seems much more logical to have the
header+Merkle+footer as a separate data stream which the filesystem can
then layout according to its own rules.
