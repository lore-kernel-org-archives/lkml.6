Return-Path: <kernel-hardening-return-13157-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrMtJQJvWNEL4ONBLQTay9wXF8nLv2eBnr92j2SmrKL1f3yBdMIttZr7JV5sy+MQ3DcfqER
ARC-Seal: i=1; a=rsa-sha256; t=1524973003; cv=none;
        d=google.com; s=arc-20160816;
        b=dsKNLTiOkBiMXUvaI4SdQmMjD1Y2KWWlP47vk5WXxwCyxzUiWPDnvUUp1r4XkNdJuL
         GFFpF4PnGY4Ge1muafI+SyT31RYK2sjsnOTkyMyWDNb3JgvliIFuXyZTRlFJiGfvMKS6
         kaTCq73VkzsB4CBP3BgiU1bDljBDOHIUOHy0t/Xbv/bh/7p7PZWKAssPJ+HrT/2GitG0
         +nRcXJvo0Vl+3ifDf5YlA1NRA1Ou83xFJAZoAR/bU6bIXBpJZuNUk5LvVK9aC9Bp03uf
         HnU/imR/Q1ojXkJkpUDv5o4Yj1ak6yVoJaMPQ8pNTfnk/h84VmzknP9M3Y7A6AZI9hT7
         /+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=61kSoN+Paf5d0KHNJAyHOpeRJvG7gNhfDGgtbR7lV3k=;
        b=Pc81aukcS1whWwBoME2FHOx25ZHCWUKcEKRDvamVAykWKHEbHkJzGUmvocPaaS8LOa
         Klh4E1bXiGUMuV5pjBsdLyZdUBQpuAZ6YZ9Nz4M2vPPTcGlArme+C8I4dH5J6TD6DwZV
         3nS+P4x00uj8ESGqrQvOFMMglFzbWcBiB+xTW+pOo1dA9PjuIMDi489ABzO3X0V9GaEJ
         6r3nCUIIskdCd+we16dasy6PrOjWknX5f96O/A06m5iHTkzshjfsbIzzcD+BmGRf3qVX
         PeVesOVo1LdyBAH754kIPsKo3yE5RaWCVW3KAmM4S+aIdGvGZLACoDZ1EoV97VINgXwr
         pVPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=h10krZd7;
       spf=pass (google.com: domain of kernel-hardening-return-13157-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13157-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=h10krZd7;
       spf=pass (google.com: domain of kernel-hardening-return-13157-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13157-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/3] genalloc: selftest
To: Igor Stoppa <igor.stoppa@gmail.com>, mhocko@kernel.org,
 akpm@linux-foundation.org, keescook@chromium.org, linux-mm@kvack.org,
 kernel-hardening@lists.openwall.com, linux-security-module@vger.kernel.org
Cc: willy@infradead.org, labbott@redhat.com, linux-kernel@vger.kernel.org,
 igor.stoppa@huawei.com
References: <20180429024542.19475-1-igor.stoppa@huawei.com>
 <20180429024542.19475-4-igor.stoppa@huawei.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <01ec5680-b1de-5473-f32b-89729d9fcc70@infradead.org>
Date: Sat, 28 Apr 2018 20:36:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180429024542.19475-4-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599046957115635253?=
X-GMAIL-MSGID: =?utf-8?q?1599050091835162548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/28/2018 07:45 PM, Igor Stoppa wrote:
> Introduce a set of macros for writing concise test cases for genalloc.
> 
> The test cases are meant to provide regression testing, when working on
> new functionality for genalloc.
> 
> Primarily they are meant to confirm that the various allocation strategy
> will continue to work as expected.
> 
> The execution of the self testing is controlled through a Kconfig option.
> 
> The testing takes place in the very early stages of main.c, to ensure
> that failures in genalloc are caught before they can cause unexplained
> erratic behavior in any of genalloc users.
> 
> Therefore, it would not be advisable to implement it as module.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

Hi,

> ---
>  init/main.c         |   2 +
>  lib/Kconfig         |  15 ++
>  lib/Makefile        |   1 +
>  lib/test_genalloc.c | 410 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 428 insertions(+)
>  create mode 100644 lib/test_genalloc.c
> 
> diff --git a/init/main.c b/init/main.c
> index b795aa341a3a..b3b319d91b0e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -91,6 +91,7 @@
>  #include <linux/cache.h>
>  #include <linux/rodata_test.h>
>  #include <linux/jump_label.h>
> +#include <linux/test_genalloc.h>
>  
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -679,6 +680,7 @@ asmlinkage __visible void __init start_kernel(void)
>  	 */
>  	mem_encrypt_init();
>  
> +	test_genalloc();

Is there a stub for test_genalloc() when its config option is not enabled?
I don't see it.

>  #ifdef CONFIG_BLK_DEV_INITRD
>  	if (initrd_start && !initrd_below_start_ok &&
>  	    page_to_pfn(virt_to_page((void *)initrd_start)) < min_low_pfn) {
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 09565d779324..2bf89af50728 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -303,6 +303,21 @@ config DECOMPRESS_LZ4
>  config GENERIC_ALLOCATOR
>  	bool
>  

These TEST_ kconfig symbols should be in lib/Kconfig.debug, not lib/Kconfig.


> +config TEST_GENERIC_ALLOCATOR
> +	bool "genalloc tester"
> +	default n
> +	select GENERIC_ALLOCATOR

This should depend on GENERIC_ALLOCATOR, not select it.

See TEST_PARMAN, TEST_BPF, TEST_FIRMWARE, TEST_SYSCTL, TEST_DEBUG_VIRTUAL
in lib/Kconfig.debug.


> +	help
> +	  Enable automated testing of the generic allocator.
> +	  The testing is primarily for the tracking of allocated space.
> +
> +config TEST_GENERIC_ALLOCATOR_VERBOSE
> +	bool "make the genalloc tester more verbose"
> +	default n
> +	select TEST_GENERIC_ALLOCATOR

	depends on TEST_GENERIC_ALLOCATOR

> +	help
> +	  More information will be displayed during the self-testing.
> +
>  #
>  # reed solomon support is select'ed if needed
>  #

> diff --git a/lib/test_genalloc.c b/lib/test_genalloc.c
> new file mode 100644
> index 000000000000..ab9984861517
> --- /dev/null
> +++ b/lib/test_genalloc.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * test_genalloc.c
> + *
> + * (C) Copyright 2017 Huawei Technologies Co. Ltd.
> + * Author: Igor Stoppa <igor.stoppa@...wei.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/init.h>
> +#include <linux/vmalloc.h>
> +#include <linux/string.h>
> +#include <linux/debugfs.h>
> +#include <linux/atomic.h>
> +#include <linux/genalloc.h>
> +
> +#include <linux/test_genalloc.h>
> +
> +
> +/*
> + * In case of failure of any of these tests, memory corruption is almost
> + * guarranteed; allowing the boot to continue means risking to corrupt

      guaranteed;

> + * also any filesystem/block device accessed write mode.
> + * Therefore, BUG_ON() is used, when testing.
> + */


-- 
~Randy
