Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbeE3EY5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:24:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:43799 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeE3EYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:24:55 -0400
Subject: Re: [PATCH 1/8] xen/grant-table: Make set/clear page private code
 shared
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180525153331.31188-1-andr2000@gmail.com>
 <20180525153331.31188-2-andr2000@gmail.com>
From: Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a43d9dd4-c826-1dab-e397-d60796de3a76@suse.com>
Date: Wed, 30 May 2018 06:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525153331.31188-2-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/18 17:33, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Make set/clear page private code shared and accessible to
> other kernel modules which can re-use these instead of open-coding.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/xen/grant-table.c | 54 +++++++++++++++++++++++++--------------
>  include/xen/grant_table.h |  3 +++
>  2 files changed, 38 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index 27be107d6480..d7488226e1f2 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -769,29 +769,18 @@ void gnttab_free_auto_xlat_frames(void)
>  }
>  EXPORT_SYMBOL_GPL(gnttab_free_auto_xlat_frames);
>  
> -/**
> - * gnttab_alloc_pages - alloc pages suitable for grant mapping into
> - * @nr_pages: number of pages to alloc
> - * @pages: returns the pages
> - */
> -int gnttab_alloc_pages(int nr_pages, struct page **pages)
> +int gnttab_pages_set_private(int nr_pages, struct page **pages)
>  {
>  	int i;
> -	int ret;
> -
> -	ret = alloc_xenballooned_pages(nr_pages, pages);
> -	if (ret < 0)
> -		return ret;
>  
>  	for (i = 0; i < nr_pages; i++) {
>  #if BITS_PER_LONG < 64
>  		struct xen_page_foreign *foreign;
>  
>  		foreign = kzalloc(sizeof(*foreign), GFP_KERNEL);
> -		if (!foreign) {
> -			gnttab_free_pages(nr_pages, pages);
> +		if (!foreign)
>  			return -ENOMEM;
> -		}
> +
>  		set_page_private(pages[i], (unsigned long)foreign);
>  #endif
>  		SetPagePrivate(pages[i]);
> @@ -799,14 +788,30 @@ int gnttab_alloc_pages(int nr_pages, struct page **pages)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(gnttab_alloc_pages);
> +EXPORT_SYMBOL(gnttab_pages_set_private);

EXPORT_SYMBOL_GPL()

>  
>  /**
> - * gnttab_free_pages - free pages allocated by gnttab_alloc_pages()
> - * @nr_pages; number of pages to free
> - * @pages: the pages
> + * gnttab_alloc_pages - alloc pages suitable for grant mapping into
> + * @nr_pages: number of pages to alloc
> + * @pages: returns the pages
>   */
> -void gnttab_free_pages(int nr_pages, struct page **pages)
> +int gnttab_alloc_pages(int nr_pages, struct page **pages)
> +{
> +	int ret;
> +
> +	ret = alloc_xenballooned_pages(nr_pages, pages);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = gnttab_pages_set_private(nr_pages, pages);
> +	if (ret < 0)
> +		gnttab_free_pages(nr_pages, pages);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(gnttab_alloc_pages);
> +
> +void gnttab_pages_clear_private(int nr_pages, struct page **pages)
>  {
>  	int i;
>  
> @@ -818,6 +823,17 @@ void gnttab_free_pages(int nr_pages, struct page **pages)
>  			ClearPagePrivate(pages[i]);
>  		}
>  	}
> +}
> +EXPORT_SYMBOL(gnttab_pages_clear_private);

EXPORT_SYMBOL_GPL()


Juergen
