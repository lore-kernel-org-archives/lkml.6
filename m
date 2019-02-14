Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C62C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A3821B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="wHOYGZfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfBNWDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:03:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40817 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfBNWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:03:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so3772546pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B89OifDmmp6xVyW6sHnZGToh8z4DfG522kiUz4LT+IY=;
        b=wHOYGZfLYrHh706qxUK+u/Qgi3hm+soGvSPpvLI3zjfI17r3Ezi+4FD6L42KbcOgTQ
         +hgmKjZtgh9F2oZBB9hyUj+0o1ATKJNzx99AuaLf9SLDdRu+EjQJv4K4gk4jpDEsHC6+
         L0ZX7bBvMpmtxGng/gGAJKDcKfXb0Guc+wBzwVQGfX2u3cKntwQY2EF5mCGQwQeV+mlS
         sWfcLgI4VW5vKz6IsUhzZPQfbKOjDOhRj2OdTmoUIzyVTbxDONSMHZaiNN5CiLDrUk/E
         kOj4HZ0OOowVT7h7SnnoE297qX3lp6Nm4AgFMF9stmeWrJgeuar3+B5xsb5J9P3jz+Rz
         FBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B89OifDmmp6xVyW6sHnZGToh8z4DfG522kiUz4LT+IY=;
        b=ogbXiSl6YmhA5OJNz2Q8qwo5EHo9NDPcyyhWYTCy2HVamC6fAS1m7btnck4IMA/rbn
         a3CzDCw+S8LrgIqPzYMggOC1U3QKJymjGDQ1vowhihAaUX2biMr4g+QTHacanT3SlFa1
         BglCX/WvcrsUjk2bj2MZSLff2NeqknVR98Zzb4uQTuMpNxSew3kDUbmOkVStXfEGOsvX
         EC1wRruJxFbE7z/YqmQBj9r1PRuip2rrE7iRrUrPem6EUW958jcGu+koLpFjm8Z4pZrb
         Qqgxyhj41UVlTHroF6IxOm8isJA2TPtbaFxndlO1GmrHWt7g9bVkJoqcvva9Ku7HE7qu
         pKkg==
X-Gm-Message-State: AHQUAuYh4pIzDc6MGd2Bdji9fnfNz5oqy8JI6EVF2G7LgVW2xP8/Gdx6
        PsO43twjgoK5C0qJMIT3KjA5Gg==
X-Google-Smtp-Source: AHgI3IZv4s7H7az1cNaAQWVnMBosbkqWNfvx8fpOuwryswf4XSaTnoFKzyS2LbUg3kE6lIEN+KUgig==
X-Received: by 2002:a63:d842:: with SMTP id k2mr2019324pgj.8.1550181829465;
        Thu, 14 Feb 2019 14:03:49 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id w185sm5843014pfb.135.2019.02.14.14.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 14:03:48 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id ECB693008A8; Fri, 15 Feb 2019 01:03:44 +0300 (+03)
Date:   Fri, 15 Feb 2019 01:03:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190214220344.2ovvzwcfuxxehzzt@kshutemo-mobl1>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
 <20190214205331.GD12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214205331.GD12668@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:53:31PM -0800, Matthew Wilcox wrote:
> On Thu, Feb 14, 2019 at 04:30:04PM +0300, Kirill A. Shutemov wrote:
> >  - page_cache_delete_batch() will blow up on
> > 
> > 			VM_BUG_ON_PAGE(page->index + HPAGE_PMD_NR - tail_pages
> > 					!= pvec->pages[i]->index, page);
> 
> Quite right.  I decided to rewrite page_cache_delete_batch.  What do you
> (and Jan!) think to this?  Compile-tested only.
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 0d71b1acf811..facaa6913ffa 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -279,11 +279,11 @@ EXPORT_SYMBOL(delete_from_page_cache);
>   * @pvec: pagevec with pages to delete
>   *
>   * The function walks over mapping->i_pages and removes pages passed in @pvec
> - * from the mapping. The function expects @pvec to be sorted by page index.
> + * from the mapping. The function expects @pvec to be sorted by page index
> + * and is optimised for it to be dense.
>   * It tolerates holes in @pvec (mapping entries at those indices are not
>   * modified). The function expects only THP head pages to be present in the
> - * @pvec and takes care to delete all corresponding tail pages from the
> - * mapping as well.
> + * @pvec.
>   *
>   * The function expects the i_pages lock to be held.
>   */
> @@ -292,40 +292,36 @@ static void page_cache_delete_batch(struct address_space *mapping,
>  {
>  	XA_STATE(xas, &mapping->i_pages, pvec->pages[0]->index);
>  	int total_pages = 0;
> -	int i = 0, tail_pages = 0;
> +	int i = 0;
>  	struct page *page;
>  
>  	mapping_set_update(&xas, mapping);
>  	xas_for_each(&xas, page, ULONG_MAX) {
> -		if (i >= pagevec_count(pvec) && !tail_pages)
> +		if (i >= pagevec_count(pvec))
>  			break;
> +
> +		/* A swap/dax/shadow entry got inserted? Skip it. */
>  		if (xa_is_value(page))
>  			continue;
> -		if (!tail_pages) {
> -			/*
> -			 * Some page got inserted in our range? Skip it. We
> -			 * have our pages locked so they are protected from
> -			 * being removed.
> -			 */
> -			if (page != pvec->pages[i]) {
> -				VM_BUG_ON_PAGE(page->index >
> -						pvec->pages[i]->index, page);
> -				continue;
> -			}
> -			WARN_ON_ONCE(!PageLocked(page));
> -			if (PageTransHuge(page) && !PageHuge(page))
> -				tail_pages = HPAGE_PMD_NR - 1;
> +		/*
> +		 * A page got inserted in our range? Skip it. We have our
> +		 * pages locked so they are protected from being removed.
> +		 */
> +		if (page != pvec->pages[i]) {

Maybe a comment for the VM_BUG while you're there?

> +			VM_BUG_ON_PAGE(page->index > pvec->pages[i]->index,
> +					page);
> +			continue;
> +		}
> +
> +		WARN_ON_ONCE(!PageLocked(page));
> +
> +		if (page->index == xas.xa_index)
>  			page->mapping = NULL;
> -			/*
> -			 * Leave page->index set: truncation lookup relies
> -			 * upon it
> -			 */
> +		/* Leave page->index set: truncation lookup relies on it */
> +
> +		if (page->index + (1UL << compound_order(page)) - 1 ==
> +				xas.xa_index)

It's 1am here and I'm slow, but it took me few minutes to understand how
it works. Please add a comment.

>  			i++;
> -		} else {
> -			VM_BUG_ON_PAGE(page->index + HPAGE_PMD_NR - tail_pages
> -					!= pvec->pages[i]->index, page);
> -			tail_pages--;
> -		}
>  		xas_store(&xas, NULL);
>  		total_pages++;
>  	}

-- 
 Kirill A. Shutemov
