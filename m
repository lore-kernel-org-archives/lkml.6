Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC93C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC23208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC23208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeH1A4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:56:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:29212 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbeH1A4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:56:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 14:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,296,1531810800"; 
   d="scan'208";a="252363698"
Received: from ray.jf.intel.com (HELO [10.54.74.168]) ([10.54.74.168])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2018 14:07:54 -0700
Subject: Re: [PATCH v13 07/13] x86/sgx: Add data structures for tracking the
 EPC pages
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
Cc:     sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Serge Ayoun <serge.ayoun@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <4666cae8-c711-8dd5-cbce-3d97cc19a9e5@intel.com>
Date:   Mon, 27 Aug 2018 14:07:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 11:53 AM, Jarkko Sakkinen wrote:
> Add data structures to track Enclave Page Cache (EPC) pages.  EPC is
> divided into multiple banks (1-N) of which addresses and sizes can be
> enumerated with CPUID by the OS.
> 
> On NUMA systems a node can have at most bank. A bank can be at most part of
> two nodes. SGX supports both nodes with a single memory controller and also
> sub-cluster nodes with severals memory controllers on a single die.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Co-developed-by: Serge Ayoun <serge.ayoun@intel.com>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Serge Ayoun <serge.ayoun@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/sgx.h      |  60 ++++++++++++++++++
>  arch/x86/kernel/cpu/intel_sgx.c | 106 +++++++++++++++++++++++++++++++-
>  2 files changed, 164 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> index 2130e639ab49..17b7b3aa66bf 100644
> --- a/arch/x86/include/asm/sgx.h
> +++ b/arch/x86/include/asm/sgx.h
> @@ -4,9 +4,69 @@
>  #ifndef _ASM_X86_SGX_H
>  #define _ASM_X86_SGX_H
>  
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/rwsem.h>
>  #include <linux/types.h>
> +#include <asm/sgx_arch.h>
> +#include <asm/asm.h>
> +
> +#define SGX_MAX_EPC_BANKS 8

This is _still_ missing a meaningful description of what a bank is and
whether it is a hardware or software structure.

It would also help us to determine whether your bit packing below is
really required.

> +struct sgx_epc_page {
> +	unsigned long desc;
> +	struct list_head list;
> +};
> +
> +struct sgx_epc_bank {
> +	unsigned long pa;
> +	void *va;
> +	unsigned long size;

Please add units.  size could be bytes or pages, or who knows what.  I
can't tell you how many bugs I've tripped over in the past from simple
unit conversions

> +	struct sgx_epc_page *pages_data;
> +	struct sgx_epc_page **pages;
> +	unsigned long free_cnt;
> +	spinlock_t lock;
> +};
>  
>  extern bool sgx_enabled;
>  extern bool sgx_lc_enabled;
> +extern struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
> +
> +/*
> + * enum sgx_epc_page_desc - defines bits and masks for an EPC page's desc

Why are you bothering packing these bits?  This seems a rather
convoluted way to store two integers.

> +static __init int sgx_init_epc_bank(u64 addr, u64 size, unsigned long index,
> +				    struct sgx_epc_bank *bank)
> +{
> +	unsigned long nr_pages = size >> PAGE_SHIFT;
> +	struct sgx_epc_page *pages_data;
> +	unsigned long i;
> +	void *va;
> +
> +	va = ioremap_cache(addr, size);
> +	if (!va)
> +		return -ENOMEM;
> +
> +	pages_data = kcalloc(nr_pages, sizeof(struct sgx_epc_page), GFP_KERNEL);
> +	if (!pages_data)
> +		goto out_iomap;

This looks like you're roughly limited by the page allocator to a bank
size of ~1.4GB which seems kinda small.  Is this really OK?

> +	bank->pages = kcalloc(nr_pages, sizeof(struct sgx_epc_page *),
> +			      GFP_KERNEL);
> +	if (!bank->pages)
> +		goto out_pdata;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		bank->pages[i] = &pages_data[i];
> +		bank->pages[i]->desc = (addr + (i << PAGE_SHIFT)) | index;
> +	}
> +
> +	bank->pa = addr;
> +	bank->size = size;
> +	bank->va = va;
> +	bank->free_cnt = nr_pages;
> +	bank->pages_data = pages_data;
> +	spin_lock_init(&bank->lock);
> +	return 0;
> +out_pdata:
> +	kfree(pages_data);
> +out_iomap:
> +	iounmap(va);
> +	return -ENOMEM;
> +}
> +
> +static __init void sgx_page_cache_teardown(void)
> +{
> +	struct sgx_epc_bank *bank;
> +	int i;
> +
> +	for (i = 0; i < sgx_nr_epc_banks; i++) {
> +		bank = &sgx_epc_banks[i];
> +		iounmap((void *)bank->va);
> +		kfree(bank->pages);
> +		kfree(bank->pages_data);
> +	}
> +}
> +
> +static inline u64 sgx_combine_bank_regs(u64 low, u64 high)
> +{
> +	return (low & 0xFFFFF000) + ((high & 0xFFFFF) << 32);
> +}

-ENOCOMMENT for a rather weird looking calculation

> +static __init int sgx_page_cache_init(void)
> +{
> +	u32 eax, ebx, ecx, edx;
> +	u64 pa, size;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < SGX_MAX_EPC_BANKS; i++) {
> +		cpuid_count(SGX_CPUID, 2 + i, &eax, &ebx, &ecx, &edx);
> +		if (!(eax & 0xF))
> +			break;

So, we have random data coming out of a random CPUID leaf being called
'eax' and then being tested against a random hard-coded mask.  This
seems rather unfortunate for someone trying to understand the code.  Can
we do better?

> +		pa = sgx_combine_bank_regs(eax, ebx);
> +		size = sgx_combine_bank_regs(ecx, edx);
> +		pr_info("EPC bank 0x%llx-0x%llx\n", pa, pa + size - 1);
> +		ret = sgx_init_epc_bank(pa, size, i, &sgx_epc_banks[i]);
> +		if (ret) {
> +			sgx_page_cache_teardown();
> +			return ret;
> +		}

So if one bank fails, we tear down all banks, yet leave sgx_nr_epc_banks
incremented?  That sounds troublesome.

> +		sgx_nr_epc_banks++;
> +	}
> +
> +	if (!sgx_nr_epc_banks) {
> +		pr_err("There are zero EPC banks.\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

Does this support hot-addition of a bank?  If not, why not?
