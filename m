Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936626AbeE2PEF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:04:05 -0400
Received: from 8bytes.org ([81.169.241.247]:57046 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934896AbeE2Ook (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:40 -0400
Date: Tue, 29 May 2018 16:44:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: mingo@redhat.com, tglx@linutronix.de, Toshi Kani <toshi.kani@hpe.com>
Cc: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, cpandya@codeaurora.org,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] x86/mm: add TLB purge to free pmd/pte page
 interfaces
Message-ID: <20180529144438.GM18595@8bytes.org>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <20180516233207.1580-4-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516233207.1580-4-toshi.kani@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 05:32:07PM -0600, Toshi Kani wrote:
>  	pmd = (pmd_t *)pud_page_vaddr(*pud);
> +	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
> +	if (!pmd_sv)
> +		return 0;

So your code still needs to allocate a full page where a simple
list_head on the stack would do the same job.

Ingo, Thomas, can you please just revert the original broken patch for
now until there is proper fix?

Thanks,

	Joerg
