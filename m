Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4048CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E152075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E152075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936893AbeFRVMz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:12:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935854AbeFRVMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:12:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FBA981663D5;
        Mon, 18 Jun 2018 21:12:53 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57E332156880;
        Mon, 18 Jun 2018 21:12:53 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5ILCr8w016278;
        Mon, 18 Jun 2018 17:12:53 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5ILCra6016274;
        Mon, 18 Jun 2018 17:12:53 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 18 Jun 2018 17:12:53 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Kees Cook <keescook@chromium.org>
cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <msnitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH] dm: writecache: Use 2-factor allocator arguments
In-Reply-To: <20180618175033.GA2627@beast>
Message-ID: <alpine.LRH.2.02.1806181708060.15433@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180618175033.GA2627@beast>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 18 Jun 2018 21:12:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 18 Jun 2018 21:12:53 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Jun 2018, Kees Cook wrote:

> This adjusts the allocator calls to use the 2-factor argument style, as
> already done treewide for better defense against allocator overflows.
> Additionally adjusts style nit to avoid assignments in test expressions.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/md/dm-writecache.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 5961c7794ef3..7773f4c75701 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -259,7 +259,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>  	if (da != p) {
>  		long i;
>  		wc->memory_map = NULL;
> -		pages = kvmalloc(p * sizeof(struct page *), GFP_KERNEL);
> +		pages = kvmalloc_array(p, sizeof(struct page *), GFP_KERNEL);
>  		if (!pages) {
>  			r = -ENOMEM;
>  			goto err2;
> @@ -859,7 +859,8 @@ static int writecache_alloc_entries(struct dm_writecache *wc)
>  
>  	if (wc->entries)
>  		return 0;
> -	wc->entries = vmalloc(sizeof(struct wc_entry) * wc->n_blocks);
> +	wc->entries = vmalloc(array_size(sizeof(struct wc_entry),
> +					 wc->n_blocks));
>  	if (!wc->entries)
>  		return -ENOMEM;
>  	for (b = 0; b < wc->n_blocks; b++) {
> @@ -1480,10 +1481,13 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
>  		bio_set_dev(&wb->bio, wc->dev->bdev);
>  		wb->bio.bi_iter.bi_sector = read_original_sector(wc, e);
>  		wb->page_offset = PAGE_SIZE;
> -		if (max_pages <= WB_LIST_INLINE ||
> -		    unlikely(!(wb->wc_list = kmalloc(max_pages * sizeof(struct wc_entry *),
> -						     GFP_NOIO | __GFP_NORETRY |
> -						     __GFP_NOMEMALLOC | __GFP_NOWARN)))) {
> +		if (max_pages > WB_LIST_INLINE)
> +			wb->wc_list = kmalloc_array(max_pages,
> +						    sizeof(struct wc_entry *),
> +						    GFP_NOIO | __GFP_NORETRY |
> +						    __GFP_NOMEMALLOC |
> +						    __GFP_NOWARN);
> +		if (max_pages <= WB_LIST_INLINE || !wb->wc_list) {

The rest of patch is OK - but you shouldn't duplicate the comparison 
against WB_LIST_INLINE.

Mikulas

>  			wb->wc_list = wb->wc_list_inline;
>  			max_pages = WB_LIST_INLINE;
>  		}
> -- 
> 2.17.0
> 
> 
> -- 
> Kees Cook
> Pixel Security
> 
