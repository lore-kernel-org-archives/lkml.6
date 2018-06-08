Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8R/BKa3JGlvhVQAAmS7hNA
	; Fri, 08 Jun 2018 18:24:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 36D39607A4; Fri,  8 Jun 2018 18:24:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2BB7B6074D;
	Fri,  8 Jun 2018 18:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BB7B6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeFHSYO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:24:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:49107 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752604AbeFHSYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:24:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 11:24:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="62983258"
Received: from ray.jf.intel.com (HELO [10.7.201.145]) ([10.7.201.145])
  by orsmga001.jf.intel.com with ESMTP; 08 Jun 2018 11:24:12 -0700
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page cache
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
Cc: sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <3c1b04d6-6e93-efaa-1890-101b7fd9784c@intel.com>
Date: Fri, 8 Jun 2018 11:24:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> SGX has a set of data structures to maintain information about the enclaves
> and their security properties. BIOS reserves a fixed size region of
> physical memory for these structures by setting Processor Reserved Memory
> Range Registers (PRMRR). This memory area is called Enclave Page Cache
> (EPC).
> 
> This commit implements the basic routines to allocate and free pages from
> different EPC banks. There is also a swapper thread ksgxswapd for EPC pages
> that gets woken up by sgx_alloc_page() when we run below the low watermark.
> The swapper thread continues swapping pages up until it reaches the high
> watermark.

Yay!  A new memory manager in arch-specific code.

> Each subsystem that uses SGX must provide a set of callbacks for EPC
> pages that are used to reclaim, block and write an EPC page. Kernel
> takes the responsibility of maintaining LRU cache for them.

What does a "subsystem that uses SGX" mean?  Do we have one of those
already?

...
> +struct sgx_secs {
> +	uint64_t size;
> +	uint64_t base;
> +	uint32_t ssaframesize;
> +	uint32_t miscselect;
> +	uint8_t reserved1[SGX_SECS_RESERVED1_SIZE];
> +	uint64_t attributes;
> +	uint64_t xfrm;
> +	uint32_t mrenclave[8];
> +	uint8_t reserved2[SGX_SECS_RESERVED2_SIZE];
> +	uint32_t mrsigner[8];
> +	uint8_t	reserved3[SGX_SECS_RESERVED3_SIZE];
> +	uint16_t isvvprodid;
> +	uint16_t isvsvn;
> +	uint8_t reserved4[SGX_SECS_RESERVED4_SIZE];
> +};

This is a hardware structure, right?  Doesn't it need to be packed?

> +enum sgx_tcs_flags {
> +	SGX_TCS_DBGOPTIN	= 0x01, /* cleared on EADD */
> +};
> +
> +#define SGX_TCS_RESERVED_MASK 0xFFFFFFFFFFFFFFFEL

Would it be possible to separate out the SGX software structures from
SGX hardware?  It's hard to tell them apart.

> +#define SGX_NR_TO_SCAN	16
> +#define SGX_NR_LOW_PAGES 32
> +#define SGX_NR_HIGH_PAGES 64
> +
>  bool sgx_enabled __ro_after_init = false;
>  EXPORT_SYMBOL(sgx_enabled);
> +bool sgx_lc_enabled __ro_after_init;
> +EXPORT_SYMBOL(sgx_lc_enabled);
> +atomic_t sgx_nr_free_pages = ATOMIC_INIT(0);

Hmmm, global atomic.  Doesn't sound very scalable.

> +struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
> +EXPORT_SYMBOL(sgx_epc_banks);
> +int sgx_nr_epc_banks;
> +EXPORT_SYMBOL(sgx_nr_epc_banks);
> +LIST_HEAD(sgx_active_page_list);
> +EXPORT_SYMBOL(sgx_active_page_list);
> +DEFINE_SPINLOCK(sgx_active_page_list_lock);
> +EXPORT_SYMBOL(sgx_active_page_list_lock);

Hmmm, global spinlock protecting a page allocator linked list.  Sounds
even worse than at atomic.

Why is this OK?

> +static struct task_struct *ksgxswapd_tsk;
> +static DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
> +
> +/*
> + * Writing the LE hash MSRs is extraordinarily expensive, e.g.
> + * 3-4x slower than normal MSRs, so we use a per-cpu cache to
> + * track the last known value of the MSRs to avoid unnecessarily
> + * writing the MSRs with the current value.  Because most Linux
> + * kernels will use an LE that is signed with a non-Intel key,
> + * i.e. the first EINIT will need to write the MSRs regardless
> + * of the cache, the cache is intentionally left uninitialized
> + * during boot as initializing the cache would be pure overhead
> + * for the majority of systems.  Furthermore, the MSRs are per-cpu
> + * and the boot-time values aren't guaranteed to be identical
> + * across cpus, so we'd have to run code all all cpus to properly
> + * init the cache.  All in all, the complexity and overhead of
> + * initializing the cache is not justified.
> + */
> +static DEFINE_PER_CPU(u64 [4], sgx_le_pubkey_hash_cache);

Justifying the design decisions is great for changelogs, not so great
for comments.  Also, looking at this, I have no idea what this has to do
with the "enclave page cache".

> +static void sgx_swap_cluster(void)
> +{
> +	struct sgx_epc_page *cluster[SGX_NR_TO_SCAN + 1];
> +	struct sgx_epc_page *epc_page;
> +	int i;
> +	int j;

This is rather free of comments or explanation of what this is doing,
how it is related to swapping as everyone else knows it

> +	memset(cluster, 0, sizeof(cluster));
> +
> +	for (i = 0, j = 0; i < SGX_NR_TO_SCAN; i++) {
> +		spin_lock(&sgx_active_page_list_lock);
> +		if (list_empty(&sgx_active_page_list)) {
> +			spin_unlock(&sgx_active_page_list_lock);
> +			break;
> +		}
> +		epc_page = list_first_entry(&sgx_active_page_list,
> +					    struct sgx_epc_page, list);
> +		if (!epc_page->impl->ops->get(epc_page)) {
> +			list_move_tail(&epc_page->list, &sgx_active_page_list);
> +			spin_unlock(&sgx_active_page_list_lock);
> +			continue;
> +		}
> +		list_del(&epc_page->list);
> +		spin_unlock(&sgx_active_page_list_lock);
>  
> -static __init bool sgx_is_enabled(void)
> +		if (epc_page->impl->ops->reclaim(epc_page)) {
> +			cluster[j++] = epc_page;
> +		} else {
> +			spin_lock(&sgx_active_page_list_lock);
> +			list_add_tail(&epc_page->list, &sgx_active_page_list);
> +			spin_unlock(&sgx_active_page_list_lock);
> +			epc_page->impl->ops->put(epc_page);
> +		}
> +	}
> +
> +	for (i = 0; cluster[i]; i++) {
> +		epc_page = cluster[i];
> +		epc_page->impl->ops->block(epc_page);
> +	}
> +
> +	for (i = 0; cluster[i]; i++) {
> +		epc_page = cluster[i];
> +		epc_page->impl->ops->write(epc_page);
> +		epc_page->impl->ops->put(epc_page);
> +		sgx_free_page(epc_page);
> +	}
> +}

This is also gloriously free of any superfluous comments.  Could you fix
that?

> +/**
> + * sgx_try_alloc_page - try to allocate an EPC page
> + * @impl:	implementation for the struct sgx_epc_page
> + *
> + * Try to grab a page from the free EPC page list. If there is a free page
> + * available, it is returned to the caller.
> + *
> + * Return:
> + *   a &struct sgx_epc_page instace,
> + *   NULL otherwise
> + */
> +struct sgx_epc_page *sgx_try_alloc_page(struct sgx_epc_page_impl *impl)
> +{
> +	struct sgx_epc_bank *bank;
> +	struct sgx_epc_page *page = NULL;
> +	int i;
> +
> +	for (i = 0; i < sgx_nr_epc_banks; i++) {
> +		bank = &sgx_epc_banks[i];

What's a bank?  How many banks does a system have?

> +		down_write(&bank->lock);
> +
> +		if (atomic_read(&bank->free_cnt))
> +			page = bank->pages[atomic_dec_return(&bank->free_cnt)];

Why is a semaphore getting used here?  I don't see any sleeping or
anything happening under this lock.

> +		up_write(&bank->lock);
> +
> +		if (page)
> +			break;
> +	}
> +
> +	if (page) {
> +		atomic_dec(&sgx_nr_free_pages);
> +		page->impl = impl;
> +	}
> +
> +	return page;
> +}
> +EXPORT_SYMBOL(sgx_try_alloc_page);
> +
> +/**
> + * sgx_alloc_page - allocate an EPC page
> + * @flags:	allocation flags
> + * @impl:	implementation for the struct sgx_epc_page
> + *
> + * Try to grab a page from the free EPC page list. If there is a free page
> + * available, it is returned to the caller. If called with SGX_ALLOC_ATOMIC,
> + * the function will return immediately if the list is empty. Otherwise, it
> + * will swap pages up until there is a free page available. Upon returning the
> + * low watermark is checked and ksgxswapd is waken up if we are below it.
> + *
> + * Return:
> + *   a &struct sgx_epc_page instace,
> + *   -ENOMEM if all pages are unreclaimable,
> + *   -EBUSY when called with SGX_ALLOC_ATOMIC and out of free pages
> + */
> +struct sgx_epc_page *sgx_alloc_page(struct sgx_epc_page_impl *impl,
> +				    unsigned int flags)
> +{
> +	struct sgx_epc_page *entry;
> +
> +	for ( ; ; ) {
> +		entry = sgx_try_alloc_page(impl);
> +		if (entry)
> +			break;
> +
> +		if (list_empty(&sgx_active_page_list))
> +			return ERR_PTR(-ENOMEM);

"active" pages in the VM are allocated/in-use pages.  This doesn't look
to be using the same terminology.

> +		if (flags & SGX_ALLOC_ATOMIC) {
> +			entry = ERR_PTR(-EBUSY);
> +			break;
> +		}
> +
> +		if (signal_pending(current)) {
> +			entry = ERR_PTR(-ERESTARTSYS);
> +			break;
> +		}
> +
> +		sgx_swap_cluster();
> +		schedule();

What's the schedule trying to do?  Is this the equivalent of "direct
reclaim"?  Why do we need this in addition to the ksgxswapd?

> +	}
> +
> +	if (atomic_read(&sgx_nr_free_pages) < SGX_NR_LOW_PAGES)
> +		wake_up(&ksgxswapd_waitq);
> +
> +	return entry;
> +}
> +EXPORT_SYMBOL(sgx_alloc_page);

Why aren't these _GPL exports?

> +/**
> + * sgx_free_page - free an EPC page
> + *
> + * @page:	any EPC page
> + *
> + * Remove an EPC page and insert it back to the list of free pages.
> + *
> + * Return: SGX error code
> + */
> +int sgx_free_page(struct sgx_epc_page *page)
> +{
> +	struct sgx_epc_bank *bank = SGX_EPC_BANK(page);
> +	int ret;
> +
> +	ret = sgx_eremove(page);
> +	if (ret) {
> +		pr_debug("EREMOVE returned %d\n", ret);
> +		return ret;
> +	}
> +
> +	down_read(&bank->lock);
> +	bank->pages[atomic_inc_return(&bank->free_cnt) - 1] = page;
> +	atomic_inc(&sgx_nr_free_pages);
> +	up_read(&bank->lock);
> +
> +	return 0;
> +}

bank->lock confuses me.  This seems to be writing to a bank, but only
needs a read lock.  Why?

> +/**
> + * sgx_get_page - pin an EPC page
> + * @page:	an EPC page
> + *
> + * Return: a pointer to the pinned EPC page
> + */
> +void *sgx_get_page(struct sgx_epc_page *page)
> +{
> +	struct sgx_epc_bank *bank = SGX_EPC_BANK(page);
> +
> +	if (IS_ENABLED(CONFIG_X86_64))
> +		return (void *)(bank->va + SGX_EPC_ADDR(page) - bank->pa);
> +
> +	return kmap_atomic_pfn(SGX_EPC_PFN(page));
> +}
> +EXPORT_SYMBOL(sgx_get_page);

This is odd.  Do you really want to detect 64-bit, or CONFIG_HIGHMEM?

> +struct page *sgx_get_backing(struct file *file, pgoff_t index)
> +{
> +	struct inode *inode = file->f_path.dentry->d_inode;
> +	struct address_space *mapping = inode->i_mapping;
> +	gfp_t gfpmask = mapping_gfp_mask(mapping);
> +
> +	return shmem_read_mapping_page_gfp(mapping, index, gfpmask);
> +}
> +EXPORT_SYMBOL(sgx_get_backing);

What does shmem have to do with all this?

> +void sgx_put_backing(struct page *backing_page, bool write)
> +{
> +	if (write)
> +		set_page_dirty(backing_page);
> +
> +	put_page(backing_page);
> +}
> +EXPORT_SYMBOL(sgx_put_backing);

I'm not a big fan of stuff getting added with no apparent user and no
explaination of what it is doing.  There's no way for me to assess
whether this is sane or not.

> +static __init int sgx_page_cache_init(void)
> +{
> +	struct task_struct *tsk;
> +	unsigned long size;
> +	unsigned int eax;
> +	unsigned int ebx;
> +	unsigned int ecx;
> +	unsigned int edx;
> +	unsigned long pa;
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < SGX_MAX_EPC_BANKS; i++) {
> +		cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC_BANKS, &eax, &ebx,
> +			    &ecx, &edx);
> +		if (!(eax & 0xf))
> +			break;
> +
> +		pa   = ((u64)(ebx & 0xfffff) << 32) + (u64)(eax & 0xfffff000);
> +		size = ((u64)(edx & 0xfffff) << 32) + (u64)(ecx & 0xfffff000);

Please align these like I did ^

> +		pr_info("EPC bank 0x%lx-0x%lx\n", pa, pa + size);
> +
> +		ret = sgx_init_epc_bank(pa, size, i, &sgx_epc_banks[i]);
> +		if (ret) {
> +			sgx_page_cache_teardown();
> +			return ret;
> +		}
> +
> +		sgx_nr_epc_banks++;
> +	}

This is also rather sparsely commented.

> +static __init bool sgx_is_enabled(bool *lc_enabled)
>  {
>  	unsigned long fc;
>  
> @@ -41,12 +466,26 @@ static __init bool sgx_is_enabled(void)
>  	if (!(fc & FEATURE_CONTROL_SGX_ENABLE))
>  		return false;
>  
> +	*lc_enabled = !!(fc & FEATURE_CONTROL_SGX_LE_WR);
> +
>  	return true;
>  }

I'm baffled why lc_enabled is connected to the enclave page cache.

>  static __init int sgx_init(void)
>  {
> -	sgx_enabled = sgx_is_enabled();
> +	bool lc_enabled;
> +	int ret;
> +
> +	if (!sgx_is_enabled(&lc_enabled))
> +		return 0;
> +
> +	ret = sgx_page_cache_init();
> +	if (ret)
> +		return ret;
> +
> +	sgx_enabled = true;
> +	sgx_lc_enabled = lc_enabled;
> +
>  	return 0;
>  }
>  
> 
