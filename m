Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D03C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC12921850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aH+dHuuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeLSHTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:19:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLSHTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=evqe5dPHDIt+SHYPo3T6MulYSyrCpjE82y/Hm+ivgNI=; b=aH+dHuuCtnfTgHx5FCXFTmdoc
        ZsoHqEK1stmdr1SvDj+HeA6rvliXeUp1qkSbM2vjXUv7IcItpOTNY66/VayMovSOznP7KiTHt+AKY
        EW1hEmKH0+oVoMuAjQV3q81zVW1ShFrPenvg6/lpXMclEwKacW/xClpgLrezRvN46PJw4s0arrjrM
        HCZVnho39z5ONFgZpagvPR0hoj8gp/aVi+Ng078gT3nmfjiSFKmI0oe0xXrLo5bh+cGpOH052AoEz
        mHPaPmnFuVB3WUIyE30D3/rRQr0ET6+ve4Oks3rKB7rc4061ONG9cfyupcWfoWlfq3HKuSe2Qkegy
        vj4VLiyuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZW8Q-0004v9-7e; Wed, 19 Dec 2018 07:19:14 +0000
Date:   Tue, 18 Dec 2018 23:19:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, ebiggers@kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181219071914.GA18852@infradead.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214044802.GA681@sol.localdomain>
 <20181217200039.GD8111@magnolia>
 <20181219071149.GB2628@infradead.org>
 <CAHk-=wiB8vGbje+NgNkMZupHsZ_cqg6YEBV+ZXSF4wnywFLRHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiB8vGbje+NgNkMZupHsZ_cqg6YEBV+ZXSF4wnywFLRHQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:16:08PM -0800, Linus Torvalds wrote:
> On Tue, Dec 18, 2018, 23:11 Christoph Hellwig <hch@infradead.org wrote:
> 
> >
> > I think the fd would have to be on the same fs for this interface to
> > make sense. But it could be an O_TMPFILE one.  And given that ext4
> > already supports a variant of swapext this interface should also work
> > with the existing ext4 on disk format.
> >
> 
> Why is the merkle tree not just an xattr of the file?

Because it is too large for our awkward xattrs interface..
