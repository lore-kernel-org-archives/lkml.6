Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4758C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEBB21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UD6FWFUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeLSHOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:14:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLSHOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=knPnMMXpf0ccihEAuHMUzyJcsINc2FB3WvYP+8OIfQQ=; b=UD6FWFUqUNJryPQ/kJ+pY0Ahl
        KpZDfZkzDjcJhJR9WD2WHXMkjU1c6bW3jPzkOivtyXOlkAOl14+m8dyKRxmJ2A/FF9zq/mTHm2siu
        /c9u/OlCJDf3PxXeYdXbKFwndXlyOFGgMWTKzJHgFcDyq75amnHD8g5Rq1u/biLUWHfVHvLu6qD94
        Q02/EztzX1HLWodQjvy6c8VKnk0aTEK0bLMiICXvN4Idu6CzhfE0CGGgZnf6eA7rPYdI2Z4Gvf25U
        XsgQD+VwoRAN/M+mhFf4q5z0axnAjVgPQFLnnnB3N93KDaOr1NJWuTbMXBUihyvUktZsIVJIrEs88
        Wrq4ocd7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZW3g-0003Ei-PA; Wed, 19 Dec 2018 07:14:20 +0000
Date:   Tue, 18 Dec 2018 23:14:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181219071420.GC2628@infradead.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214044802.GA681@sol.localdomain>
 <20181217200039.GD8111@magnolia>
 <20181219001603.GD25775@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219001603.GD25775@mit.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 07:16:03PM -0500, Theodore Y. Ts'o wrote:
> Sure, but what would be the benefit of doing different things on the
> back end?  I think this is a really more of a philophical objection
> than anything else.  With both fsverity and fscrypt, well over 95% of
> the implementation is shared between ext4 and f2fs.  And from a
> cryptographic design, that's something I consider a feature, not a
> bug.  Cryptographic code is subtle in very different ways compared to
> file system code.  So it's a good thing to having it done once and
> audited by crypto specialists, as opposed to having each file system
> doing it differently / independently.

Where the data is located on disk should not matter for the crypto
details.  If it does you have severe implementation issues.

> Right, the current interface makes it somewhat more awkward to do
> these other things --- but the question is *why* would you want to in
> the first place?  Why add the extra complexity?  I'm a big believer of
> the KISS principle, and if there was a reason why a file system would
> want to store the Merkle tree somewhere else, we could talk about it,
> but I see only downside, and no upside.

Filesystems already use blocks beyond EOF for preallocation, either
speculative by the file system itself, or explicitly by the user with
fallocate.  I bet you will run into bugs with your creative abuse
sooner or later.  Indepnd of that the interface simply is gross, which
is enough of a reason not to merge it.
