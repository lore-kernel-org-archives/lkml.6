Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755881AbeEHVot (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:44:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:45971 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755433AbeEHVos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:44:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="38429320"
Date: Wed, 9 May 2018 00:44:45 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexander Potapenko <glider@google.com>
Cc: dave.hansen@linux.intel.com, mingo@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mka@chromium.org, dvyukov@google.com,
        md@google.com
Subject: Re: [PATCH v2] x86/boot/64/clang: Use fixup_pointer() to access
 '__supported_pte_mask'
Message-ID: <20180508214445.lnqbct6dgrhyxp4a@black.fi.intel.com>
References: <20180508162829.7729-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508162829.7729-1-glider@google.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 04:28:29PM +0000, Alexander Potapenko wrote:
> @@ -196,7 +204,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  
>  	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
>  	/* Filter out unsupported __PAGE_KERNEL_* bits: */
> -	pmd_entry &= __supported_pte_mask;
> +	mask_ptr = (pteval_t *)fixup_pointer(&__supported_pte_mask, physaddr);

Do we really need the cast here?

-- 
 Kirill A. Shutemov
