Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA900C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B402146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f4u4kDio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbeLQQtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:49:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbeLQQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ephnP2uxD3sfoSBpzxuLZ8x02KLkYXH7Ai7y7SaggtY=; b=f4u4kDio0JIz3bvbsoUJCa6nQ
        HOpB6ttUsWyNrEIVlpEX7UvM7c8QtGoB4BdVYR5VePVWT+JTpHcSq4D2ShUtbCkvD0Im9iiAJHpW7
        19GbNOjycSJ7HoO7OwQgbmJk3t5KssTkz9d2WDN/rugP6f9Rjn/UI6XECRT8L73uXeNLrYJMCR8W/
        P486JPm/PD3YG1xIR+MTdTwtN5DYYsFxhnoDrseiWX4X31DRhHpHjZKv/xkxpmBo0hBH4sjWkkrLT
        9lQC4bHWi6+8LukkGNouisCqPafVsrUlNNIUlnyCcStr6SlICYx9/3aqof0Syto+wRnmYkA+Q7KJs
        c9wuvrpag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYw5V-0005Sr-NK; Mon, 17 Dec 2018 16:49:49 +0000
Date:   Mon, 17 Dec 2018 08:49:49 -0800
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
Message-ID: <20181217164949.GA18626@infradead.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214044802.GA681@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214044802.GA681@sol.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:48:03PM -0800, Eric Biggers wrote:
> Sure, those specific people (modulo you just now) haven't responded to the
> fs-verity patches yet.  But again, the patches have been out for review for
> months.  Of course, we always prefer more reviews over fewer, and we strongly
> encourage anyone interested to review fs-verity!  (The Documentation/ file may
> be a good place to start.)  But ultimately we cannot force reviews, and as you
> know kernel reviews can be very hard to come by.  Yet, people still need
> fs-verity anyway; it isn't just some toy.  And we're committed to maintaining
> it, similar to fscrypt.  The ext4 and f2fs maintainers are also satisfied with
> the current approach to storing the verity metadata past EOF; in fact it was
> even originally Ted's idea, I think.

But you also can't force inclusion.  And Linus just recently complained
about merging common code patches through trees for a specific fs
without proper VFS ACKs.  And that was a for a case without userspace
ABI implications, so we really need a much better review here.

Including a VFS person ACK, CC to linux-abi and man pages for the
interface.

> > Given that you alread use an ioctl as the interface what is the problem
> > of passing this data through the ioctl?
> 
> Do you mean pass the verity metadata in a buffer?  That cannot work in general,
> because it may be too large to fit into memory.

Have a pointer in the ioctl and do get_user_pages on it.
