Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D84C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37A02184E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeL1XkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:40:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeL1XkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:40:01 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B5B4DB49;
        Fri, 28 Dec 2018 23:39:59 +0000 (UTC)
Date:   Fri, 28 Dec 2018 15:39:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Huang Shijie <sjhuang@iluvatar.ai>, linux@armlinux.org.uk,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        sfr@canb.auug.org.au, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        shijie8@gmail.com
Subject: Re: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to
 gen_pool_has_addr
Message-Id: <20181228153958.40cfb7a9b446225d73c585cd@linux-foundation.org>
In-Reply-To: <20181228084834.GA8658@lst.de>
References: <20181228083950.20398-1-sjhuang@iluvatar.ai>
        <20181228084834.GA8658@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 09:48:34 +0100 Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Dec 28, 2018 at 04:39:50PM +0800, Huang Shijie wrote:
> > Follow the kernel conventions, rename addr_in_gen_pool to
> > gen_pool_has_addr.
> 
> Which convention?

That symbols from subsystem foo should be called foo_*.  Not uniformly
observed by any means, but it is a thing.

> The old name certainly looks more sensible to me.

It does read better, but it's rather a standout in this case:

q:/usr/src/25> grep EXPORT_SYMBOL lib/genalloc.c
EXPORT_SYMBOL(gen_pool_create);
EXPORT_SYMBOL(gen_pool_add_virt);
EXPORT_SYMBOL(gen_pool_virt_to_phys);
EXPORT_SYMBOL(gen_pool_destroy);
EXPORT_SYMBOL(gen_pool_alloc);
EXPORT_SYMBOL(gen_pool_alloc_algo);
EXPORT_SYMBOL(gen_pool_dma_alloc);
EXPORT_SYMBOL(gen_pool_free);
EXPORT_SYMBOL(gen_pool_for_each_chunk);
EXPORT_SYMBOL(addr_in_gen_pool);
EXPORT_SYMBOL_GPL(gen_pool_avail);
EXPORT_SYMBOL_GPL(gen_pool_size);
EXPORT_SYMBOL(gen_pool_set_algo);
EXPORT_SYMBOL(gen_pool_first_fit);
EXPORT_SYMBOL(gen_pool_first_fit_align);
EXPORT_SYMBOL(gen_pool_fixed_alloc);
EXPORT_SYMBOL(gen_pool_first_fit_order_align);
EXPORT_SYMBOL(gen_pool_best_fit);
EXPORT_SYMBOL_GPL(gen_pool_get);
EXPORT_SYMBOL(devm_gen_pool_create);
EXPORT_SYMBOL_GPL(of_gen_pool_get);

