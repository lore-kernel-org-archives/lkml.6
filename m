Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCEEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518512083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sDx2/PGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518512083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbeFRRPP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:15:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933501AbeFRRPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+GzKGK88Q7ih6jr8ch0HGQCCsnGq9gxgHzNl/seHBFI=; b=sDx2/PGZdXOJwe9zZeP2nUQcb
        ApxJCiHh99HHwxEA2/4ePGeNNtg9/bOdd8K4YvNheQj4rJUQVQ9Yf8HoutKEgsY48dmGBCMSEXTxK
        23McgauTvUGtZfotdsJH+Xgc1yDsVT60PLUCdq60wxpxn57EhJt/XF8YXADypZwTZO8LoVtPw6DEg
        1UzhtrHGCBLcCXoYcuUAaGcblnEidCI7BJlNIiz5yE0EguHFmvYD+0DQ46M9/TT49Ip1Tin5hHWHt
        eQWQ+kdXKHoPjXuNX8Wphmvza7a/iusK0LYtpgTfXsr7mMyfJml/pndosaAQbS21RNs68D99TACD1
        CQysWhtMA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUxkH-0006Qr-81; Mon, 18 Jun 2018 17:15:13 +0000
Subject: Re: [PATCH 05/11] docs/mm: bootmem: add overview documentation
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1529341199-17682-6-git-send-email-rppt@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fb7be5ca-1c39-0ba1-cf17-92dabee947ad@infradead.org>
Date:   Mon, 18 Jun 2018 10:15:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529341199-17682-6-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/18/2018 09:59 AM, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  mm/bootmem.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/mm/bootmem.c b/mm/bootmem.c
> index 76fc17e..423cb5f 100644
> --- a/mm/bootmem.c
> +++ b/mm/bootmem.c
> @@ -21,6 +21,53 @@
>  
>  #include "internal.h"
>  
> +/**
> + * DOC: bootmem overview
> + *
> + * Bootmem is a boot-time physical memory allocator and configurator.
> + *
> + * It is used early in the boot process before the page allocator is
> + * set up.
> + *
> + * The bootmem is based on the most basic of allocators, a First Fit

    * Bootmem is based on
or
    * The bootmem allocator is based on

> + * allocator which uses a bitmap to represent memory. If a bit is 1,
> + * the page is allocated and 0 if unallocated. To satisfy allocations
> + * of sizes smaller than a page, the allocator records the Page Frame
> + * Number (PFN) of the last allocation and the offset the allocation
> + * ended at. Subsequent small allocations are merged together and
> + * stored on the same page.


-- 
~Randy
