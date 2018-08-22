Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC4CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2691E20BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VTlk2Hh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2691E20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeHVVtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:49:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbeHVVtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MoNPaBJSt6O7KlA2m7ZdQ4q/ZhbH0Hgg4mdyGtvFCt8=; b=VTlk2Hh6iwejG8JEGc4pLFYG0
        cbmSaDZt2YR5eI5nAc7B65cJpUleofHJYXjO/iVeF3+X/4U9u8RvM+dzpZ2ykRQtK2PcoEx+6ejXY
        8E93cU8kv3YDDWg9ID0tLJXXEIFNwP4G4QLoiFJcLjr4nRSNaeQgSI01CmkTv8TmATf0rIkGH7N67
        oN1ZcEPnRwwqixQHQRSWMb1G2Xd/2ouOEre+OT7GzSDKhV0GeFutufWZMz8pIcilJUqyjw/YkL3FA
        aDs1nRQZ/LqDNPhjTmfurQJStUTIEJLFyjK8pp4Efaye4V2BTlM2iSuPr9U/eJ/iw1I3d/cc32s5u
        e8xz/hG+w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsXn8-0007On-Gq; Wed, 22 Aug 2018 18:23:38 +0000
Date:   Wed, 22 Aug 2018 11:23:38 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] XArray for 4.19
Message-ID: <20180822182338.GA19458@bombadil.infradead.org>
References: <20180813161357.GB1199@bombadil.infradead.org>
 <CA+55aFxFjAmrFpwQmEHCthHOzgidCKnod+cNDEE+3Spu9o1s3w@mail.gmail.com>
 <20180822025040.GA12244@bombadil.infradead.org>
 <CA+55aFw+dwofadgvzrM-UCMSih+f1choCwW+xFFM3aPjoRQX_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw+dwofadgvzrM-UCMSih+f1choCwW+xFFM3aPjoRQX_g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:00:18PM -0700, Linus Torvalds wrote:
> On Tue, Aug 21, 2018 at 7:50 PM Matthew Wilcox <willy@infradead.org> wrote:
> > So, should I have based just on your tree and sent you a description of
> > what a resolved conflict should look like?
> 
> Absolutely.
> 
> Or preferably not rebasing at all, just starting from a good solid
> base for new development in the first place.

Ah, I remember now, it was more complex than a textual conflict.

Dan added an entirely new function here:

http://git.infradead.org/users/willy/linux-dax.git/commitdiff/c2a7d2a115525d3501d38e23d24875a79a07e15e

which needed to be converted to XArray.  So I should have pulled in his
branch as a merge somewhere close to the end of my series, then done a
fresh patch on top of that to convert it?

It would have been pretty ugly because he modified a function I deleted.
I might try it out just to show how bad it would have been.

