Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zFEuEDYSHlsNUwAAmS7hNA
	; Mon, 11 Jun 2018 06:09:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 261E160792; Mon, 11 Jun 2018 06:09:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kpUhuSpp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A6FDD605A5;
	Mon, 11 Jun 2018 06:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6FDD605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeFKGJ4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:09:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754072AbeFKGJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RIj7PXCAj9dsDBAa9jM3F/1sRpZg3CFEuz8FEArL5e0=; b=kpUhuSppBaXxFldGrXEKAoh4S
        nB0uaucdGFvS/XEY6UNgvKBu4pvKRRe1RHrZNPP3rB6DicnPB3Vc3xPe6eXtBXZ9awrUwd7X+0PXu
        WOdED+JI7OrPNt8YNelKr75GU7/rrYjZQxsL5K+sVYUjZXWsPUGpC7UIrsyVDHgK4AuoTkpWvoZHt
        ElXOtKpgLA1PAurFnGWMdByJ73BDdAwHPRiIKqNloN/DqtiqFY6juRap2WTXZYFBf/dXEYpnPwQcv
        IVQEc9oRnAZjc0+EslfJvxwDkr7YZY0gGXkcdEbwnR+8qx3I8qu3/mDnleE5uKdbzr2zMoQRd7U+8
        ceJDatS5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSG1W-00030B-WC; Mon, 11 Jun 2018 06:09:51 +0000
Date: Sun, 10 Jun 2018 23:09:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] overlayfs update for 4.18
Message-ID: <20180611060950.GA8048@infradead.org>
References: <20180608121330.GG23785@veci.piliscsaba.redhat.com>
 <20180609065208.GA31572@infradead.org>
 <CA+55aFxkUYXHNT+GtUFMSSdnNgYBoQu1tvxiWYNrwTJCLbi_rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxkUYXHNT+GtUFMSSdnNgYBoQu1tvxiWYNrwTJCLbi_rw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 02:42:20PM -0700, Linus Torvalds wrote:
> And Christoph's copmmentary isn't really helping the situation.
> Christoph, I haven't seen the NAK history, can you elaborate?

Most of the bits just need a bit of refinement I think, instead of
being forced through the overlayfs tree and are generally fine.

The pre_mmap hook I think is a clear no-go.  We've had this tried
multiple times and always rejected it.  Unlike previous uses the
overlayfs use isn't outright broken, but still questionalable
as it will still lead to a copyup that "leaks" if the actual mmap
wasn't successfull.  The whole discussion of how mmap happens,
how we deal with mmap_sem and failures needs a broader discussion
with all MM and VFS folks first.
