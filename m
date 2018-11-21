Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CDCC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92405213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaMIRV2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92405213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeKUMCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:02:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35947 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeKUMCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 07:02:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id y6-v6so2950873plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tv1PBSaTO817C7DUqdqrU7oWmYyiru0DklUnyfmhnpQ=;
        b=XaMIRV2Ii1COOsd6yyGdgAEmQ6Jbro6rGrKRVeAgCFk728Q3cV8yYvM9ROegtXJrgN
         mHh2V/bFhmei49XYn6jaiOjdpxnMWRLrLGduSL7eJPL3i/5nj5taZSorUOhucD6Tzw1e
         NcFBz2IIfwdRbCphtgqHncm9jARJy4evekCyJPS6azufIpGYmjwTaRu9sjVORqlHKv2p
         Xxi/w49pvJXPDqzCJQx5nBvHD6s+netOcmNJ73vvwFYLu+lZxiaFtiv69emlP/wbhIec
         6RkUSneAkbzIB6NmzABksBozbLqhQxt414winWXUSNJc6/5/yJ9XhjMmHgdIVMatq6RS
         NdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tv1PBSaTO817C7DUqdqrU7oWmYyiru0DklUnyfmhnpQ=;
        b=CfEJGDawuUUvZOimJ2yo5IjhYSOSJf920CemGitkLjdO4e1eO5oVgWCOBvurdHmn6E
         0UMk1/sboGZT8ybck6GAODnL9qGk4ePj3XhEkX7CGAUJVyipeV09jD/6Kt180A6RuemC
         9igqdYJ70yIkVHf6Sc5PNwaZElDu9dDV7NU216vGVDy4gpMaiMR+nrdwFj3oSgA5Z+0O
         WurAypkwm+9uzFSpzgMYpktd/Q36prOqw+ixOaLA/aRKX+tvH9qIeDFAnhirhrFaqXEC
         Io8D2IF5Bz2LjiQxiP3MVrqrhBzuQGKFCuTcb92qZ7q29QxengOOizOYhgy32/OOVlrz
         ovUQ==
X-Gm-Message-State: AGRZ1gLJTVIgbA0L6Bpc4cMEkgZN40W6NVkebQ5yL30cWdRYLmnJai9r
        ZkFn67kX5DR48UbXlfSRJdM=
X-Google-Smtp-Source: AJdET5cNk4+QfAHry4PGbQFbiUl3erd64lJL6GSCO9LmmqZo0gro5sghwWIKNNy3Z6IFeWIXTeBYiA==
X-Received: by 2002:a62:682:: with SMTP id 124-v6mr4655489pfg.161.1542763816419;
        Tue, 20 Nov 2018 17:30:16 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 85sm60480617pfw.17.2018.11.20.17.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 17:30:15 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:30:12 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20181121013011.GA5663@Asurada-Nvidia.nvidia.com>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com>
 <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
 <20181102063542.GA17073@lst.de>
 <20181105224050.GA10411@Asurada-Nvidia.nvidia.com>
 <20181120092010.GA7270@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120092010.GA7270@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:20:10AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 05, 2018 at 02:40:51PM -0800, Nicolin Chen wrote:
> > > > In general, this seems to make sense to me. It does represent a theoretical 
> > > > change in behaviour for devices which have their own CMA area somewhere 
> > > > other than kernel memory, and only ever make non-atomic allocations, but 
> > > > I'm not sure whether that's a realistic or common enough case to really 
> > > > worry about.
> > > 
> > > Yes, I think we should make the decision in dma_alloc_from_contiguous
> > > based on having a per-dev CMA area or not.  There is a lot of cruft in
> > 
> > It seems that cma_alloc() already has a CMA area check? Would it
> > be duplicated to have a similar one in dma_alloc_from_contiguous?
> 
> It isn't duplicate if it serves a different purpose.
> 
> > > this area that should be cleaned up while we're at it, like always
> > > falling back to the normal page allocator if there is no CMA area or
> > > nothing suitable found in dma_alloc_from_contiguous instead of
> > > having to duplicate all that in the caller.
> > 
> > Am I supposed to clean up things that's mentioned above by moving
> > the fallback allocator into dma_alloc_from_contiguous, or to just
> > move my change (the count check) into dma_alloc_from_contiguous?
> > 
> > I understand that'd be great to have a cleanup, yet feel it could
> > be done separately as this patch isn't really a cleanup change.
> 
> I can take care of any cleanups.  I've been trying to dust up that
> area anyway.

Thanks for the reply. It looks like it'd be better for me to wait
for the cleanup being done? I feel odd merely adding a size check
in the dma_alloc_from_contiguous().
