Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A00BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5C7204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rh3K7QXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5C7204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757335AbeFSOY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:24:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757091AbeFSOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p7MwpVkwKsmt1Ix88lyfms43nPdzsoKpWGeiixGQsEw=; b=rh3K7QXS2/8fQiFSbtiwNcLRo
        7618bC9jrrecSTvxm09jClGIDSMHI8/mY0/R9GvuIuZ2lqU2yoDEL3aRwjV1p8kmfehTTK20Lzbsg
        aotudTNxCNLmz2KuyerGRCfF3gHks/b/MaSp68URpLbMGtJiI8V+SD/qHxwi5rcAhERMgevYIn4f5
        dFXll6aONK6S0huURfn3bigvBh8wZJpXcVt0+FMbuIUBi2TXybM8Wr15p2r4en3V1T3MPE49pvkal
        mG10EVj/b/sltuQpfV4ZwE3+dys2+aOO8iN9L6Nq2qDjyB5qVFq/9xA/g9a1rM3WQq1LK2X0wbEPu
        UBUZpe2ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVHYU-0004FE-9Y; Tue, 19 Jun 2018 14:24:22 +0000
Date:   Tue, 19 Jun 2018 07:24:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/39] vfs: export vfs_ioctl() to modules
Message-ID: <20180619142421.GA16151@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-8-mszeredi@redhat.com>
 <20180604084904.GF11333@infradead.org>
 <20180610045657.GM30522@ZenIV.linux.org.uk>
 <CAJfpegtGtAR25qWgpNisvL8F51h3K6s44zkWBSVVbqecut6tBQ@mail.gmail.com>
 <20180611162412.GA7574@infradead.org>
 <CAJfpegvxHs+MvC3N2Cbocp0UNrM47_GEUSV+mAx=8VVNDz7r_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvxHs+MvC3N2Cbocp0UNrM47_GEUSV+mAx=8VVNDz7r_g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:04:41PM +0200, Miklos Szeredi wrote:
> FS_IOC*
> 
> Haven't looked deeply.  For now overlayfs just implements
> FS_IOC_{GET|SET}FLAGS because some of these flags are quite generic
> and implementing them on the overlay is easy.
> 
> Yes, turning into a method makes sense.

Do you want to do this or should I send a patch?
