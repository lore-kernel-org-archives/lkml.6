Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeC1RPF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:15:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:55144 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752694AbeC1RPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:15:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,372,1517904000";
   d="scan'208";a="38896429"
Subject: Re: [PATCHv2 06/14] mm/page_alloc: Propagate encryption KeyID through
 page allocator
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
 <20180328165540.648-7-kirill.shutemov@linux.intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <5d334638-2139-07a1-c999-36a1729173fb@intel.com>
Date: Wed, 28 Mar 2018 10:15:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328165540.648-7-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/2018 09:55 AM, Kirill A. Shutemov wrote:
> @@ -51,7 +51,7 @@ static inline struct page *new_page_nodemask(struct page *page,
>  	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
>  		gfp_mask |= __GFP_HIGHMEM;
>  
> -	new_page = __alloc_pages_nodemask(gfp_mask, order,
> +	new_page = __alloc_pages_nodemask(gfp_mask, order, page_keyid(page),
>  				preferred_nid, nodemask);

You're not going to like this suggestion.

Am I looking at this too superficially, or does every single site into
which you pass keyid also take a node and gfpmask and often an order?  I
think you need to run this by the keepers of page_alloc.c and see if
they'd rather do something more drastic.
