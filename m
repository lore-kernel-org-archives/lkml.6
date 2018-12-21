Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2272C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832CC2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TGQtRNah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbeLUPx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:53:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeLUPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OZWYW5vMbO3y1QS7CVem9lT84IXgkhi4lITeJCfOy3Q=; b=TGQtRNahHJYrs3QwGFlsq1S+S
        zWFlWZXr6ayTXiqAHLxQsRrGHAao5KtyhMauE7U3lhidbmJe/fpuTg8mSIqW04qvTCjyPxbdaPT+X
        TLy3Rmne4hfZOcwB8rw9A+xSvFdIt34gWrWEdysAnStqAYmu6jv2dkID803kIivPysGwfj5+sNv5E
        Y6tOXhSAT43wfyL6Qjq3COhQLiKTMrCJdtBaREMj5dNRwssM72z2RGVIpYqSOfLvhM4B489JZSCWS
        v6JK/zTU3e0IhfnpyTAdqI3ktFj+0M7amj0sWGNJqZZlpFl4wdtsOUREtkaygFXwc2a63YfBmxlSp
        fr7qV/zwQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaN7b-0005Kn-29; Fri, 21 Dec 2018 15:53:55 +0000
Date:   Fri, 21 Dec 2018 07:53:54 -0800
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
Message-ID: <20181221155354.GC10600@bombadil.infradead.org>
References: <20181219071420.GC2628@infradead.org>
 <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu>
 <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu>
 <20181221070447.GA21687@infradead.org>
 <20181221154714.GA26547@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221154714.GA26547@mit.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:47:14AM -0500, Theodore Y. Ts'o wrote:
> Linus --- we're going round and round, and I don't think this is
> really a technical dispute at this point, but rather an aesthetics
> one.  Will you be willing to accept my pull request for a feature
> which is being shippped on millions of Android phones, has been out
> for review for months, and for which, if we *really* need to add
> uselessly complicated interface later, we can do that?  It's always
> been the case for internal Kernel interfaces not to add code "just in
> case" it's useful, but rather when a user turns up.  I argue we should
> be doing the same thing for user-space visible interfaces.

To look at it another way, this is an aesthetic dispute in which all those
who have offered opinions from outside Google -- myself, Dave Chinner &
Christoph all really dislike this interface.  I'd be happy to discuss
alternative interfaces, particularly ones which allow for the current
internal implementation, but I think this interface is really bad.

In contrast to "we'll just fix it up later" (which usually applies
to in-kernel interfaces), we have a policy of not breaking userspace,
so accepting this interface means setting it in stone.  We should get
it right.
