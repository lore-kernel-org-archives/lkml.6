Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7hnlJhZ5G1vGDQAAmS7hNA
	; Sat, 09 Jun 2018 06:52:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 97FA7607E7; Sat,  9 Jun 2018 06:52:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gau4wp36"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1C3C3600D0;
	Sat,  9 Jun 2018 06:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C3C3600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeFIGwO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:52:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753169AbeFIGwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TFb6NinyNHyqjMqzgi6MGVRaVNY/1U90UhS3xbXqdtk=; b=gau4wp36f4sXvNBYVQwqVQct0
        vZbMe9QasknT5MzAbiWLtTpaGkFSl0HSoAtDKtTH4DQm07ryw2ep6GhFON6yvyWGGJqcFXbfO6ucp
        hmcVWUE92Wbzn5B4eddOw8H40hCBdlWkqewlKsvT1qe5dReL56P+W8NYFNu5uSyDBZ3afIfEceYBb
        jI1ZTe54X9j3XlAhvbqYCsm8eBldBl/F1Rb3urXpJXbCHO2J3wgy0og/CgRl5sIjK81uSa9zZjnB6
        o/4IgUnznRUaeVA9Qyw1t5+4lSeAMcOnsjbOHlMCF7izV77ZQCQ2HdHxAwsjXkJvce+8I8jwpOc9G
        bvM79PcgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRXjN-0008S4-7V; Sat, 09 Jun 2018 06:52:09 +0000
Date: Fri, 8 Jun 2018 23:52:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@infradead.org
Subject: Re: [GIT PULL] overlayfs update for 4.18
Message-ID: <20180609065208.GA31572@infradead.org>
References: <20180608121330.GG23785@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608121330.GG23785@veci.piliscsaba.redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:13:30PM +0200, Miklos Szeredi wrote:
> Hi Linus,
> 
> Please pull from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-4.18
> 
> This contains two new features:
> 
>  1) Stack file operations: this allows removal of several hacks from the
>     VFS, proper interaction of read-only open files with copy-up,
>     possibility to implement fs modifying ioctls properly, and others.

Which includews all kinds of NAKed or at least non-acked VFS changes.

Please get these through Als tree after proper review first.
