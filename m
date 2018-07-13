Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB03CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23212124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyrexauJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23212124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeGMGmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:42:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40399 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeGMGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:42:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so23896003wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u7BbULpMVX5iKrKpE2eO5ybur4MTVhXqjTY4w8qdeCs=;
        b=pyrexauJUeS/SzG3FMH6jsSbRBE3VtUoSTI9GnLG4B7Er9QNzRYPrdc4rbrAcSm8DZ
         fczXPR/tg2Fy1AXcEtvZw5oVI/9QJabz/JHLLMK8V9Mq8JSIGPGZnzJOwhdflYw+c74b
         UK21KmuDGKhG3U+/4dDqvRLDpFNpy3XMsydYp9Ck47v7XUyDSNAjmjcr+QpBmR0gPqxg
         6VMMt+ccZ01s7f/1vav/21oTx+hxqiBAq9fMmO5ShYQptFumbIvuJ41LzLD/67Oo2uA3
         gheJZTJMSsIIUW+kCEB6S18Z3CEd7SwKVgIrjmolznxlnljpuaauva4CNidnDEV0FrI8
         vFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u7BbULpMVX5iKrKpE2eO5ybur4MTVhXqjTY4w8qdeCs=;
        b=FyK4dVBwGoTmJ9+af2ywPdTPIGFDQXeAAYr5ExcJNVc//WTAQS+UVE2DW/L57MnHIY
         zvPij0qePJ062xQZ/MrQer2L7cxjGJmmkbGB5k8F8aqPVwtOJIbi61TtFT230NZ0heR5
         5nC1yVQxT+LgmmXvFoXdmqe/g3U07TDvDNWtbFPj9AsmG06tst4j9yM1yhcNLvc4qLlL
         oYSeWHWh0L6VqHC1v9+ufZY3jFG/BAoj2TWzaPWlssg8CVefPGE3rN/k8McZwzeK4dcS
         w62ROn+hO2mqhfHHuihECaJxG7jKBMFrWwnOL4+cebvOgcERK8+WjsybyM+kBqJaONbu
         CBqg==
X-Gm-Message-State: AOUpUlE2n5c9C7Q5WmWyc1H8pj0JjDF4Bavs7Al70zO5j9blnquNvFg5
        9/LR5EQg8A8774xgR2jYfrBTzXIqHbhGl6QYHzA=
X-Google-Smtp-Source: AAOMgpdw2sEyUoE2Ptvv6Lc3DuVb150ppghJ+5l/CY6GhSbrQF/K+skC+OdtIom5b/e0gFnp4Q2bTtGKYuPMO42rQSE=
X-Received: by 2002:a5d:4c4c:: with SMTP id n12-v6mr3654072wrt.71.1531463369814;
 Thu, 12 Jul 2018 23:29:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:61c1:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 23:29:29
 -0700 (PDT)
In-Reply-To: <20180712071536.GA15506@lst.de>
References: <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709121956.20200-1-m.szyprowski@samsung.com> <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
 <CAAmzW4PPNYhUj_MeZox+ddq8MjXqnJs_AJ3xkayf710udD1pSg@mail.gmail.com>
 <20180710095056.GE14284@dhcp22.suse.cz> <CAAmzW4P1m_T77DfQzDD6ysGaOF46++-0gwRaOajmo6ef=VYp=A@mail.gmail.com>
 <20180711085407.GB20050@dhcp22.suse.cz> <CAAmzW4M3KADCZD9+B2h7=WsYksGtg-GzYRCJjbqK5Scceynrrg@mail.gmail.com>
 <20180712071536.GA15506@lst.de>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 13 Jul 2018 15:29:29 +0900
Message-ID: <CAAmzW4MNuZOZRP1fHt7E42Mm6+-CLkYYA1Ju2Cfe0ik4Ynb4Lw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from cma_alloc()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-12 16:15 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> On Thu, Jul 12, 2018 at 11:48:47AM +0900, Joonsoo Kim wrote:
>> One of existing user is general DMA layer and it takes gfp flags that is
>> provided by user. I don't check all the DMA allocation sites but how do
>> you convince that none of them try to use anything other
>> than GFP_KERNEL [|__GFP_NOWARN]?
>
> They use a few others things still like __GFP_COMP, __GPF_DMA or
> GFP_HUGEPAGE.  But all these are bogus as we have various implementations
> that can't respect them.  I plan to get rid of the gfp_t argument
> in the dma_map_ops alloc method in a few merge windows because of that,
> but it needs further implementation consolidation first.

Okay. If those flags are all, this change would be okay.

For the remind of this gfp flag introduction in cma_alloc(), see the
following link.

https://marc.info/?l=linux-mm&m=148431452118407

Thanks.
