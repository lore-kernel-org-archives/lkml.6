Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8169C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED55206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="DiopmTh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED55206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeLNFR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:17:29 -0500
Received: from imap.thunk.org ([74.207.234.97]:35554 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLNFR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3xMUm4Cp+sbjnIUTU/+4CArgMYn1ieKAjLQkJp7bwZ0=; b=DiopmTh8owRmw7kxdA8e93pF8m
        vomwQWWTyJ9NlTqgSm5MQahuDgG4v4ymeuhYTpQkSXA2sHppDPmmDZ5sIeWzU+G6ogRqlnxWqoFXQ
        DDDUlngbpeFrI5WePKesd0JjWxJEY1ox638yokC924Btu2t1MpjDCWIDArlqPIrkJc9g=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gXfql-0006Gv-6h; Fri, 14 Dec 2018 05:17:23 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 869B97A4FE6; Fri, 14 Dec 2018 00:17:22 -0500 (EST)
Date:   Fri, 14 Dec 2018 00:17:22 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181214051722.GF20880@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213202249.GA3797@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 12:22:49PM -0800, Christoph Hellwig wrote:
> On Wed, Dec 12, 2018 at 12:26:10PM -0800, Eric Biggers wrote:
> > > As this apparently got merged despite no proper reviews from VFS
> > > level persons:
> > 
> > fs-verity has been out for review since August, and Cc'ed to all relevant
> > mailing lists including linux-fsdevel, linux-ext4, linux-f2fs-devel,
> > linux-fscrypt, linux-integrity, and linux-kernel.  There are tests,
> > documentation (since v2), and a userspace tool.  It's also been presented at
> > multiple conferences, and has been covered by LWN multiple times.  If more
> > people want to review it, then they should do so; there's nothing stopping them.
> 
> But you did not got a review from someone like Al, Linus, Andrew or me,
> did you?

I don't consider fs-verity to be part of core VFS, but rather a
library that happens to be used by ext4 and f2fs.  This is much like
fscrypt, which was originally an ext4-only thing, but the code was
always set up so it could be used by other file systems, and when f2fs
was interested in using it, we moved it to fs/crypto.  As such the
fscrypto code never got a review from Al, Andrew, or you, and when I
pushed it to Linus, he accepted the pull request.

The difference this time is that ext4 and f2fs are interested in using
common code from the beginning.

> > Can you elaborate on the actual problems you think the current solution has, and
> > exactly what solution you'd prefer instead?  Keep in mind that (1) for large
> > files the Merkle tree can be gigabytes long, (2) Linux doesn't have an API for
> > file streams, and (3) when fs-verity is combined with fscrypt, it's important
> > that the hashes be encrypted, so as to not leak information about the plaintext.
> 
> Given that you alread use an ioctl as the interface what is the problem
> of passing this data through the ioctl?

The size of the Merkle tree is roughly size/129.  So for a 100MB file
(and there can be Android APK files that bug), the Merkle tree could
be almost 800k.  That's not really a size that we would want to push
through an ioctl.

We could treat the ioctl as write-like interface, but using write(2)
seemed to make a lot more sense.  Also, the fscrypt common code
leveraged by f2fs and ext4 assume that the verity tree will be stored
after the data blocks.

Given that the semantics of a verity-protected file is that it is
immutable, you *could* store the Merkle tree in a separate file
stream, but it really doesn't buy you anything --- by definition, you
can't append to a fs-verity protected file.  Furthermore, it would
require extra complexity in the common fsverity code --- which looks
for the Merkle tree at the end of file data --- for no real benefit.

Cheers,

						- Ted

P.S.  And if you've purchased a Pixel 3 device, it's already using the
fsverity code, so it's quite well tested (and yes, we have xfstests).
