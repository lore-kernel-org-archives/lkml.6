Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5F5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB579206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fJnEZOwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbeLQQwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:52:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388298AbeLQQwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OYL9WFygQ+hDPFIACis4Z/GLLsWAtobhaqY1c5uZH0Q=; b=fJnEZOwAVYuYbtbbBez3FOgQ0
        VEyOl6gk/BCWvhmDyVgLNvS2Wt56lArUKiVT+Z/2K1ALfTjSnVaTWmx1FDdOj7S9HY81xrocwBf2/
        cU1hdhSXN8eOQqCXhT82CMNpJAz55SLwH03VNmIMAgUZVa49OPctOUkx/nib3QmyxG0nP+rULuhZZ
        d/zsO2IcXXcJScSHay9YmurdV/x51rTdRP+YGl1X3f+duZxxXyHpWqaRsNpsWc5wxPnutodbbCcIf
        DK8Cu8IO5zGFFf0+oxjsEc9FQ4HTabnkl/MoJRqEKtFNfSh8PgT/+E6XKx2Wi4iW9sjb99pwq//uo
        AnCttPnFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYw87-0007cy-GW; Mon, 17 Dec 2018 16:52:31 +0000
Date:   Mon, 17 Dec 2018 08:52:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181217165231.GB18626@infradead.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214051722.GF20880@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214051722.GF20880@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[FYI, your mail never made it to my inbox, although I found the copy
in linux-fsdevel now]

On Fri, Dec 14, 2018 at 12:17:22AM -0500, Theodore Y. Ts'o wrote:
> I don't consider fs-verity to be part of core VFS, but rather a
> library that happens to be used by ext4 and f2fs.  This is much like
> fscrypt, which was originally an ext4-only thing, but the code was
> always set up so it could be used by other file systems, and when f2fs
> was interested in using it, we moved it to fs/crypto.  As such the
> fscrypto code never got a review from Al, Andrew, or you, and when I
> pushed it to Linus, he accepted the pull request.

And as a result we are stuck with a pretty bad interface, so this is
a very good example for how to not do thing!  Just because a user
interface is only implemented by one or two file systems doesn't mean
it should skip the userspace ABI review, because we tend to generalize
them unless they are deeply specific to fs internals.

> P.S.  And if you've purchased a Pixel 3 device, it's already using the
> fsverity code, so it's quite well tested (and yes, we have xfstests).

And all kinds of other code that would never pass review, so that isn't
really a good argument unfortunately :(  Note that I would want to buy
a piece of hardware coming with google spyware preinstalled.
