Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeDTR7e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:59:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:49054 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753331AbeDTR7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:59:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,302,1520924400";
   d="scan'208";a="193111717"
Date: Fri, 20 Apr 2018 20:59:28 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME
Message-ID: <20180420175928.nup3hcqxe2u4ugln@black.fi.intel.com>
References: <20180410093339.49257-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410093339.49257-1-kirill.shutemov@linux.intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 09:33:39AM +0000, Kirill A. Shutemov wrote:
> AMD SME claims one bit from physical address to indicate whether the
> page is encrypted or not. To achieve that we clear out the bit from
> __PHYSICAL_MASK.
> 
> The capability to adjust __PHYSICAL_MASK is required beyond AMD SME.
> For instance for upcoming Intel Multi-Key Total Memory Encryption.
> 
> Factor it out into a separate feature with own Kconfig handle.
> 
> It also helps with overhead of AMD SME. It saves more than 3k in .text
> on defconfig + AMD_MEM_ENCRYPT:
> 
> 	add/remove: 3/2 grow/shrink: 5/110 up/down: 189/-3753 (-3564)
> 
> We would need to return to this once we have infrastructure to patch
> constants in code. That's good candidate for it.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
> 
> Previously, I've posted the patch with MKTME patchset, but it's useful on
> its own as it reduces text size for kernel with AMD_MEM_ENCRYPT enabled.
> 
> Please consider applying.

Any feedback on this?

-- 
 Kirill A. Shutemov
