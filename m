Return-Path: <kernel-hardening-return-12153-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtVyW4WruB4bFs7NZqtG8dWGwf1bwfzW/G6uWk22ROb4JY4I96LOQbXevTGqjJrHXyJxjoH
ARC-Seal: i=1; a=rsa-sha256; t=1520356409; cv=none;
        d=google.com; s=arc-20160816;
        b=B1+pl3wgEPCgofTVJ9/ffrN1BrqjDXblw3SXBlJQKw7EuO2gNrUKl1OLK7Rmcc4hGk
         EuaJO4I/HQkGo732sDWaiQfbzsURs6DXGNM9UD6XeGPdmtXACcesQomvzuLbkpTRBhKo
         xa5om7x+4Mb3D3IdvSrLp3b6hFx6qeg3LXouZ8fuIsJe7qiVH1XIgWVQt5LCE3aofH0V
         eKURKcgxiIF3HxFHRA+q7Q00AKqae3zfs5MLlPPMZOU17tdBxi1SdNS5Mi5r2nUEkOAP
         JD1Q2ysCH2HKXeTDD1IgW8hF5QOGfIsFNKv4wqO8vnLdhzYwGc/jKAHSGVAVZ1ccCMyX
         VI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=82Fr6/99iGoZje5i3+4kAM/5TsIyNTcs9QAFNGuBaJc=;
        b=EMHkGXzg+Aj/q+PnQKroo6SCS2atZo9ahKe4nYS17pzgjbB/Ch3csUvyxTxiber7gy
         pDIjTPC/sKPoZaTWfGD0vz+JArHezVwsXd1E5VGPJ80P5aoi2/Dh5ggLsEgVPDwOZoS/
         6SUNQ7yClGpVLhXRLhwmYNGFSaDj9SzedSmU3RrQN4cvLgE9J/IqUoiPNH49Ah+Hdtso
         jKZ9avqhVRAUrp0Ya5W7goKrSMjn6C64mIoE3b0uvL/poYTL5N13VeawdMXoTSw9ZZcP
         4AiwCKYf+0ZNMEwEZCO77t3TsuSNGrNQPqoBIXZ9caq7AT3Iu+Dkt6GTwS8AnZAV9/L8
         8jwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K9q0aUwa;
       spf=pass (google.com: domain of kernel-hardening-return-12153-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12153-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K9q0aUwa;
       spf=pass (google.com: domain of kernel-hardening-return-12153-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12153-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 5/7] Pmalloc selftest
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
 willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-6-igor.stoppa@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <b2c4f714-7276-7f1d-436c-7a31c6019345@gmail.com>
Date: Tue, 6 Mar 2018 09:13:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228200620.30026-6-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676835059580824?=
X-GMAIL-MSGID: =?utf-8?q?1594209242730483480?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Looks good, and a bit more thorough test than last iteration.

Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>


On 2/28/18 12:06 PM, Igor Stoppa wrote:
> Add basic self-test functionality for pmalloc.
>
> The testing is introduced as early as possible, right after the main
> dependency, genalloc, has passed successfully, so that it can help
> diagnosing failures in pmalloc users.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> ---
>   include/linux/test_pmalloc.h |  24 +++++++++++
>   init/main.c                  |   2 +
>   mm/Kconfig                   |  10 +++++
>   mm/Makefile                  |   1 +
>   mm/test_pmalloc.c            | 100 +++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 137 insertions(+)
>   create mode 100644 include/linux/test_pmalloc.h
>   create mode 100644 mm/test_pmalloc.c
>
> diff --git a/include/linux/test_pmalloc.h b/include/linux/test_pmalloc.h
> new file mode 100644
> index 000000000000..c7e2e451c17c
> --- /dev/null
> +++ b/include/linux/test_pmalloc.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * test_pmalloc.h
> + *
> + * (C) Copyright 2018 Huawei Technologies Co. Ltd.
> + * Author: Igor Stoppa <igor.stoppa@huawei.com>
> + */
> +
> +
> +#ifndef __LINUX_TEST_PMALLOC_H
> +#define __LINUX_TEST_PMALLOC_H
> +
> +
> +#ifdef CONFIG_TEST_PROTECTABLE_MEMORY
> +
> +void test_pmalloc(void);
> +
> +#else
> +
> +static inline void test_pmalloc(void){};
> +
> +#endif
> +
> +#endif
> diff --git a/init/main.c b/init/main.c
> index 2bf1312fd2fe..ea44c940070a 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -91,6 +91,7 @@
>   #include <linux/rodata_test.h>
>   #include <linux/jump_label.h>
>   #include <linux/test_genalloc.h>
> +#include <linux/test_pmalloc.h>
>   
>   #include <asm/io.h>
>   #include <asm/bugs.h>
> @@ -663,6 +664,7 @@ asmlinkage __visible void __init start_kernel(void)
>   	mem_encrypt_init();
>   
>   	test_genalloc();
> +	test_pmalloc();
>   #ifdef CONFIG_BLK_DEV_INITRD
>   	if (initrd_start && !initrd_below_start_ok &&
>   	    page_to_pfn(virt_to_page((void *)initrd_start)) < min_low_pfn) {
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 016d29b9400b..47b0843b02d2 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -767,3 +767,13 @@ config PROTECTABLE_MEMORY
>       depends on ARCH_HAS_SET_MEMORY
>       select GENERIC_ALLOCATOR
>       default y
> +
> +config TEST_PROTECTABLE_MEMORY
> +	bool "Run self test for pmalloc memory allocator"
> +        depends on MMU
> +	depends on ARCH_HAS_SET_MEMORY
> +	select PROTECTABLE_MEMORY
> +	default n
> +	help
> +	  Tries to verify that pmalloc works correctly and that the memory
> +	  is effectively protected.
> diff --git a/mm/Makefile b/mm/Makefile
> index 959fdbdac118..1de4be5fd0bc 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
>   obj-$(CONFIG_SLOB) += slob.o
>   obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
>   obj-$(CONFIG_PROTECTABLE_MEMORY) += pmalloc.o
> +obj-$(CONFIG_TEST_PROTECTABLE_MEMORY) += test_pmalloc.o
>   obj-$(CONFIG_KSM) += ksm.o
>   obj-$(CONFIG_PAGE_POISONING) += page_poison.o
>   obj-$(CONFIG_SLAB) += slab.o
> diff --git a/mm/test_pmalloc.c b/mm/test_pmalloc.c
> new file mode 100644
> index 000000000000..df7ecc91c6a4
> --- /dev/null
> +++ b/mm/test_pmalloc.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * test_pmalloc.c
> + *
> + * (C) Copyright 2018 Huawei Technologies Co. Ltd.
> + * Author: Igor Stoppa <igor.stoppa@huawei.com>
> + */
> +
> +#include <linux/pmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/test_pmalloc.h>
> +#include <linux/bug.h>
> +
> +#define SIZE_1 (PAGE_SIZE * 3)
> +#define SIZE_2 1000
> +
> +static inline bool validate_alloc(bool expected, void *addr,
> +				  unsigned long size)
> +{
> +	bool test;
> +
> +	test = is_pmalloc_object(addr, size) > 0;
> +	pr_notice("must be %s: %s",
> +		  expected ? "ok" : "no", test ? "ok" : "no");
> +	return test == expected;
> +}
> +
> +#define is_alloc_ok(variable, size)	\
> +	validate_alloc(true, variable, size)
> +
> +#define is_alloc_no(variable, size)	\
> +	validate_alloc(false, variable, size)
> +
> +void test_pmalloc(void)
> +{
> +	struct gen_pool *pool_unprot;
> +	struct gen_pool *pool_prot;
> +	void *var_prot, *var_unprot, *var_vmall;
> +
> +	pr_notice("pmalloc-selftest");
> +	pool_unprot = pmalloc_create_pool("unprotected", 0);
> +	if (unlikely(!pool_unprot))
> +		goto error;
> +	pool_prot = pmalloc_create_pool("protected", 0);
> +	if (unlikely(!(pool_prot)))
> +		goto error_release;
> +
> +	pr_notice("Testing allocation capability");
> +	var_unprot = pmalloc(pool_unprot,  SIZE_1 - 1, GFP_KERNEL);
> +	var_prot = pmalloc(pool_prot,  SIZE_1, GFP_KERNEL);
> +	*(int *)var_prot = 0;
> +	var_vmall = vmalloc(SIZE_2);
> +
> +
> +	pr_notice("Test correctness of is_pmalloc_object()");
> +	WARN_ON(unlikely(!is_alloc_ok(var_unprot, 10)));
> +	WARN_ON(unlikely(!is_alloc_ok(var_unprot, SIZE_1)));
> +	WARN_ON(unlikely(!is_alloc_ok(var_unprot, PAGE_SIZE)));
> +	WARN_ON(unlikely(!is_alloc_no(var_unprot, SIZE_1 + 1)));
> +	WARN_ON(unlikely(!is_alloc_no(var_vmall, 10)));
> +
> +
> +	pfree(pool_unprot, var_unprot);
> +	vfree(var_vmall);
> +
> +	pmalloc_protect_pool(pool_prot);
> +
> +	/*
> +	 * This will intentionally trigger a WARN, because the pool being
> +	 * allocated from is already protected.
> +	 */
> +	pr_notice("Test allocation from a protected pool."
> +		  "Expect WARN in pmalloc");
> +	if (unlikely(pmalloc(pool_prot, 10, GFP_KERNEL)))
> +		WARN(true, "no memory from a protected pool");
> +
> +	/*
> +	 * This will intentionally trigger a WARN because the pool being
> +	 * destroyed is not protected, which is unusual and should happen
> +	 * on error paths only, where probably other warnings are already
> +	 * displayed.
> +	 */
> +	pr_notice("pmalloc-selftest:"
> +		  " Expect WARN in pmalloc_pool_set_protection below.");
> +	pmalloc_destroy_pool(pool_unprot);
> +	pr_notice("pmalloc-selftest:"
> +		  "Critical point for expected WARN passed.");
> +
> +	/* This must not cause WARNings */
> +	pr_notice("pmalloc-selftest:"
> +		  "Expect no WARN below.");
> +	pmalloc_destroy_pool(pool_prot);
> +	pr_notice("pmalloc-selftest:"
> +		  "Critical point for unexpected WARN passed.");
> +	return;
> +error_release:
> +	pmalloc_destroy_pool(pool_unprot);
> +error:
> +	WARN(true, "Unable to allocate memory for pmalloc selftest.");
> +}
