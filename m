Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5D1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224E32184C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545074154;
	bh=ipw6pMGhfZ10FRBMGcEI9WjPDkqY+T48T7fTF8qSQ1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yPzZ3pjSqAjx/3Gu2wlZPknyVvLW/cpMGA7K3Yb+5IUDc5iZDFLfGZhI1JLL9xMYv
	 BkxoUQ19vDiNQz6uc7oTVHxz+rBM+witE0YSIVMgFA2JmSHVEQCw7AwfHQxm4k+ITG
	 80f0CZLC9vKKGdw7SeYPWL9ubkX3uVvqTMx2LfnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbeLQTPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:15:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbeLQTPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:15:52 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 775C4206A2;
        Mon, 17 Dec 2018 19:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545074151;
        bh=ipw6pMGhfZ10FRBMGcEI9WjPDkqY+T48T7fTF8qSQ1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ge/+p+eVDXqvaGgs6z3iLICRc8xXnpqCZdWBFGWKHhc3qBbhvexrFq+ztHsb73IdR
         WKsKyGYrK1/qiLchXLAjj58LWXgaNY+BboMuXOM01dTnq+5uvb3zEl8nHML2WdXe0h
         dz5iv2BqtzMbsUtVgG9nQXQ+3B1fL/ntYXdaSQJ8=
Date:   Mon, 17 Dec 2018 11:15:50 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181217191549.GB141684@gmail.com>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214051722.GF20880@thunk.org>
 <20181217165231.GB18626@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217165231.GB18626@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Dec 17, 2018 at 08:52:31AM -0800, Christoph Hellwig wrote:
> [FYI, your mail never made it to my inbox, although I found the copy
> in linux-fsdevel now]
> 
> On Fri, Dec 14, 2018 at 12:17:22AM -0500, Theodore Y. Ts'o wrote:
> > I don't consider fs-verity to be part of core VFS, but rather a
> > library that happens to be used by ext4 and f2fs.  This is much like
> > fscrypt, which was originally an ext4-only thing, but the code was
> > always set up so it could be used by other file systems, and when f2fs
> > was interested in using it, we moved it to fs/crypto.  As such the
> > fscrypto code never got a review from Al, Andrew, or you, and when I
> > pushed it to Linus, he accepted the pull request.
> 
> And as a result we are stuck with a pretty bad interface, so this is
> a very good example for how to not do thing!  Just because a user
> interface is only implemented by one or two file systems doesn't mean
> it should skip the userspace ABI review, because we tend to generalize
> them unless they are deeply specific to fs internals.
> 

While I do have some improvements planned for the fscrypt interface,
specifically how encryption keys are managed [1], the issues are subtle enough
that I don't think there's any chance they could have been gotten "right" the
first time around, even if lots more people had reviewed it.  It took me over a
year working with fscrypt to put together my proposal for how to improve things,
and it was only really possible because I was able to consider all the people
actually using fscrypt and what problems they are having, if any.

Even so, the current fscrypt interface is actually good enough that there still
hasn't been much real interest in getting my proposed improvements merged yet.
(Not surprisingly, they've also been completely ignored by all the "VFS people"
you say should be reviewing this stuff...)

So for fscrypt I personally don't think that waiting would have changed much in
practice, besides ensuring that users wouldn't have any solution at all.

[1] https://lwn.net/Articles/737274/

- Eric
