Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BC4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFA72075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFA72075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbeGRX7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:59:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:54335 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbeGRX7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:59:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 16:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,371,1526367600"; 
   d="scan'208";a="73931641"
Received: from ray.jf.intel.com (HELO [10.7.201.15]) ([10.7.201.15])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2018 16:19:12 -0700
Subject: Re: [PATCHv5 08/19] x86/mm: Introduce variables to store number,
 shift and mask of KeyIDs
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-9-kirill.shutemov@linux.intel.com>
Cc:     Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <1edc05b0-8371-807e-7cfa-6e8f61ee9b70@intel.com>
Date:   Wed, 18 Jul 2018 16:19:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717112029.42378-9-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> mktme_nr_keyids holds number of KeyIDs available for MKTME, excluding
> KeyID zero which used by TME. MKTME KeyIDs start from 1.
> 
> mktme_keyid_shift holds shift of KeyID within physical address.

I know what all these words mean, but the combination of them makes no
sense to me.  I still don't know what the variable does after reading this.

Is this the lowest bit in the physical address which is used for the
KeyID?  How many bits you must shift up a KeyID to get to the location
at which it can be masked into the physical address?

> mktme_keyid_mask holds mask to extract KeyID from physical address.

Good descriptions, wrong place.  Please put these in the code.

Also, the grammar constantly needs some work.  "holds mask" needs to be
"holds the mask".

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/mktme.h | 16 ++++++++++++++++
>  arch/x86/kernel/cpu/intel.c  | 12 ++++++++----
>  arch/x86/mm/Makefile         |  2 ++
>  arch/x86/mm/mktme.c          |  5 +++++
>  4 files changed, 31 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/include/asm/mktme.h
>  create mode 100644 arch/x86/mm/mktme.c
> 
> diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
> new file mode 100644
> index 000000000000..df31876ec48c
> --- /dev/null
> +++ b/arch/x86/include/asm/mktme.h
> @@ -0,0 +1,16 @@
> +#ifndef	_ASM_X86_MKTME_H
> +#define	_ASM_X86_MKTME_H
> +
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_X86_INTEL_MKTME
> +extern phys_addr_t mktme_keyid_mask;
> +extern int mktme_nr_keyids;
> +extern int mktme_keyid_shift;
> +#else
> +#define mktme_keyid_mask	((phys_addr_t)0)
> +#define mktme_nr_keyids		0
> +#define mktme_keyid_shift	0
> +#endif
> +
> +#endif
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index bf2caf9d52dd..efc9e9fc47d4 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -573,6 +573,9 @@ static void detect_tme(struct cpuinfo_x86 *c)
>  
>  #ifdef CONFIG_X86_INTEL_MKTME
>  	if (mktme_status == MKTME_ENABLED && nr_keyids) {
> +		mktme_nr_keyids = nr_keyids;
> +		mktme_keyid_shift = c->x86_phys_bits - keyid_bits;
> +
>  		/*
>  		 * Mask out bits claimed from KeyID from physical address mask.
>  		 *
> @@ -580,10 +583,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
>  		 * and number of bits claimed for KeyID is 6, bits 51:46 of
>  		 * physical address is unusable.
>  		 */
> -		phys_addr_t keyid_mask;
> -
> -		keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, c->x86_phys_bits - keyid_bits);
> -		physical_mask &= ~keyid_mask;
> +		mktme_keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, mktme_keyid_shift);
> +		physical_mask &= ~mktme_keyid_mask;

Seems a bit silly that we introduce keyid_mask only to make it global a
few patches later.

>  	} else {
>  		/*
>  		 * Reset __PHYSICAL_MASK.
> @@ -591,6 +592,9 @@ static void detect_tme(struct cpuinfo_x86 *c)
>  		 * between CPUs.
>  		 */
>  		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> +		mktme_keyid_mask = 0;
> +		mktme_keyid_shift = 0;
> +		mktme_nr_keyids = 0;
>  	}

Should be unnecessary.  These are zeroed by the compiler.

> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index 4b101dd6e52f..4ebee899c363 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -53,3 +53,5 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
> +
> +obj-$(CONFIG_X86_INTEL_MKTME)	+= mktme.o
> diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
> new file mode 100644
> index 000000000000..467f1b26c737
> --- /dev/null
> +++ b/arch/x86/mm/mktme.c
> @@ -0,0 +1,5 @@
> +#include <asm/mktme.h>
> +
> +phys_addr_t mktme_keyid_mask;
> +int mktme_nr_keyids;
> +int mktme_keyid_shift;

Descriptions should be here, please, not in the changelog.

