Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A591C65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 06:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5752088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 06:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mthVg0Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5752088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJGNJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 09:09:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40989 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeJGNJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 09:09:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id e18-v6so16611743oti.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 23:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRJ3PazCHSkxn35xfNFADflNjJc3n/OYiCeEej6jyvo=;
        b=mthVg0WifB2dvpR8hFXLX4Jy8VZ03oD//zwNk6LOjivBv7d7qlv1Z/WEjX7UMeOC3W
         rFj+hjzpiy+Dkp0jG1mzpGysy7EDmdYkWyPGeBJEJLFPDEOmZwiCr+rUyJAzmuE9joQR
         Hgq4J2fby822q9Upn1WcG3zZParpjZINnKK7wxL00DGeShNUwsKU6kOWV+e8WqAi/CWA
         KEfAY9O3qKy8zaj8l4kHsp3BBFQ6JDioiWqkG+t2YnqqjrNcJGCD2HSMpGB8vOmJtBmT
         vJ3nEPZAKgDHbykgPEbvrCKuY2l6lScLFO7oo1Gc1xzXuijTvCst45TmpIwrLbzmKzgb
         JX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRJ3PazCHSkxn35xfNFADflNjJc3n/OYiCeEej6jyvo=;
        b=tpfogRKObP7+L5L67b3rSoa/COkmD/YJM0tWmJUJpFD39ubQ82nD8jYjh8nOHdA+1g
         HEypma6HqL9pSczBp5aS9RabqNQ6ZRvg4IUygvt0aMSq2MMBlENKCcdSQ67TUyRaGi5Y
         9aBHWRrpWTE1Gey6taRu+jGkAZBKTt+9BlJoK9Jf9v0dRGjaDo+k03+UJxe6K+woZjVf
         /TbZOAjfapVvafn6XMx6Uu8o/o/zESvYFteHhDXV+wxGOByXKdaR1bzVzNGvkcByLaCs
         eKqRAUG+WodzdzcsfR4UGHnzk5zTGboCFuWYtSeRcMKRtVXFQxJBFgoShbZVBDmFRxbl
         x2Zw==
X-Gm-Message-State: ABuFfoiYzmcbuy7iiFLron9AQPqaUls3pit+jevo177oi35Ugruyglrw
        xZ7XYfNsWHPzjcti43C25nsTHwf3UhFsq0BddptT4A==
X-Google-Smtp-Source: ACcGV61ckH+dqM8SnsjadxQIDRrxQDvoAFTfCqyn4qBU+lQbEh3g8jAD0jpFmpPDtsnYBQJS3FnfP1F6cFt4APJXs6E=
X-Received: by 2002:a9d:4d0a:: with SMTP id n10mr9982711otf.95.1538892182028;
 Sat, 06 Oct 2018 23:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <153884891237.3128209.14619968108312095820.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153884891237.3128209.14619968108312095820.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 6 Oct 2018 23:02:50 -0700
Message-ID: <CAPcyv4hcF-tbv4OBZ4NAs00PmRAH6mE3nzSpe5=AwNORyHnLWw@mail.gmail.com>
Subject: Re: [PATCH] filesystem-dax: Fix dax_layout_busy_page() livelock
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        zwisler@kernel.org, Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 11:14 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> In the presence of multi-order entries the typical
> pagevec_lookup_entries() pattern may loop forever:
>
>         while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
>                                 min(end - index, (pgoff_t)PAGEVEC_SIZE),
>                                 indices)) {
>                 ...
>                 for (i = 0; i < pagevec_count(&pvec); i++) {
>                         index = indices[i];
>                         ...
>                 }
>                 index++; /* BUG */
>         }
>
> The loop updates 'index' for each index found and then increments to the
> next possible page to continue the lookup. However, if the last entry in
> the pagevec is multi-order then the next possible page index is more
> than 1 page away. Fix this locally for the filesystem-dax case by
> checking for dax-multi-order entries. Going forward new users of
> multi-order entries need to be similarly careful, or we need a generic
> way to report the page increment in the radix iterator.
>
> Fixes: 5fac7408d828 ("mm, fs, dax: handle layout changes to pinned dax...")
> Cc: <stable@vger.kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/dax.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 4becbf168b7f..c1472eede1f7 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -666,6 +666,8 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>         while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
>                                 min(end - index, (pgoff_t)PAGEVEC_SIZE),
>                                 indices)) {
> +               pgoff_t nr_pages = 1;
> +
>                 for (i = 0; i < pagevec_count(&pvec); i++) {
>                         struct page *pvec_ent = pvec.pages[i];
>                         void *entry;
> @@ -680,8 +682,11 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>
>                         xa_lock_irq(&mapping->i_pages);
>                         entry = get_unlocked_mapping_entry(mapping, index, NULL);
> -                       if (entry)
> +                       if (entry) {
>                                 page = dax_busy_page(entry);
> +                               /* account for multi-order entries */
> +                               nr_pages = 1UL << dax_radix_order(entry);
> +                       }

Thinking about this a bit further the next index will be at least
nr_pages away, but we don't want to accidentally skip over entries as
this patch might do. So nr_pages should only be adjusted by the entry
size if it is the last entry.
