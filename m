Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF0FC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834F520851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mqBP98E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834F520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbeLMUWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:22:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeLMUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lATmiD54zaGiCNJvHMHCxwMrMhP+1Ph5WForTo8SHb0=; b=mqBP98E7LiLv/9XyBtIGaO0R5
        xbSHbhTFGaRbXgOLIgrnTC+rD2zoNGE0usX9M+NZo4CHNRJP/WVeBV13QuK94WxNVeqqIO/qOEArQ
        rySS9qDtRVLWecThsIEi6vFmCr10uaj5eUH9/R5NttBEUfGMpvAw9+QZRnPDUrzYpx6x26wSP2oWw
        naD9/PeT5A910EzPgpmbEYPcK2pvPhNzS9IOE80TaNcthWuwBHsuw7hLC1yjrH8m5aS53eeOvGUj4
        C63UzVRMXQJe17FzYE8Mj8kCNKbqxtEtM6wLEinApCrgYOTNoRJK9r12d4nnlDd3Zg3qdUjWFRC6R
        n0DvJhwiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXXVR-0002kx-CF; Thu, 13 Dec 2018 20:22:49 +0000
Date:   Thu, 13 Dec 2018 12:22:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181213202249.GA3797@infradead.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212202609.GA193967@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:26:10PM -0800, Eric Biggers wrote:
> > As this apparently got merged despite no proper reviews from VFS
> > level persons:
> 
> fs-verity has been out for review since August, and Cc'ed to all relevant
> mailing lists including linux-fsdevel, linux-ext4, linux-f2fs-devel,
> linux-fscrypt, linux-integrity, and linux-kernel.  There are tests,
> documentation (since v2), and a userspace tool.  It's also been presented at
> multiple conferences, and has been covered by LWN multiple times.  If more
> people want to review it, then they should do so; there's nothing stopping them.

But you did not got a review from someone like Al, Linus, Andrew or me,
did you?

> Can you elaborate on the actual problems you think the current solution has, and
> exactly what solution you'd prefer instead?  Keep in mind that (1) for large
> files the Merkle tree can be gigabytes long, (2) Linux doesn't have an API for
> file streams, and (3) when fs-verity is combined with fscrypt, it's important
> that the hashes be encrypted, so as to not leak information about the plaintext.

Given that you alread use an ioctl as the interface what is the problem
of passing this data through the ioctl?
