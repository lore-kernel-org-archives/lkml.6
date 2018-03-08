Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755010AbeCHEAx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:00:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeCHEAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:00:52 -0500
Date: Wed, 7 Mar 2018 20:00:16 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bp@suse.de, catalin.marinas@arm.com,
        guohanjun@huawei.com, will.deacon@arm.com, wxf.wang@hisilicon.com,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
Message-ID: <20180308040016.GB9082@bombadil.infradead.org>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
 <20180307183227.17983-2-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307183227.17983-2-toshi.kani@hpe.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 11:32:26AM -0700, Toshi Kani wrote:
> +/**
> + * pud_free_pmd_page - clear pud entry and free pmd page
> + *
> + * Returns 1 on success and 0 on failure (pud not cleared).
> + */
> +int pud_free_pmd_page(pud_t *pud)
> +{
> +	return pud_none(*pud);
> +}

Wouldn't it be clearer if you returned 'bool' instead of 'int' here?

Also you didn't document the pud parameter, nor use the approved form
for documenting the return type, nor the calling context.  So I would
have written it out like this:

/**
 * pud_free_pmd_page - Clear pud entry and free pmd page.
 * @pud: Pointer to a PUD.
 *
 * Context: Caller should hold mmap_sem write-locked.
 * Return: %true if clearing the entry succeeded.
 */
