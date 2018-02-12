Return-Path: <kernel-hardening-return-11736-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226O6NCueL8M6pfvh5O6OOwxbzZbQdoCdB4HZz7pr1pKBzcRPEHidNdibJLZuSTNGXf3ICZB
ARC-Seal: i=1; a=rsa-sha256; t=1518479056; cv=none;
        d=google.com; s=arc-20160816;
        b=ctfek5mZ/21pbqT0s4utiI5a26h7g1xcU+KNsKcQrV4bK1SWdO4v/0Bf2zmL2dWust
         T6EdRmnbyDRQVBolcSdCoKlxAC5wzsCtksiDQkxfRyXdRh52J2rrcPGWyi4V/CLPCrU+
         go+lEo8CWCbtC+JlLYRG6mzBQdQ53ga810AmyLMGqZuT22M/URzpzMRvtTM20xkbnU7l
         kwul54hCCk8qJbuz0NNifKW07yxpPdu1uh7F0xZDSOUhewTgyvjsjwyHqiG8+3Dp/rl9
         bvRrjA0DY5z1/R5vMIoU7nrSxVtnezcCy4Xz+Oa/9lDPOKr+RrfpmqO7BcFXw/hxpxMr
         6bGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=cZBEANm5weJu0+XrKLY/FxA0L5/3lyac/Tat/DpsBnQ=;
        b=0VSQ1pP/qdKaSkRvqO6tzWnEpH2/PEZm6r9xwfr59kmEzZyjI+bmMOne/qF2aXEZ05
         3FKNPdT+vKGyvR7H/0/UTUO7xgizdtcC+E164uIPRgCyDkXMqNDl05XZ315ue/UFh0Qo
         P+gfyj7Wl1xttdjVtLCgSgsHAuGscTb2q7xJGgdzstw4xfF/Vyqufm6KHDHJ5ICR+Grt
         147S3SksQAMof461L3kWFqhY5F3Sq/5bgfhfoB9qCP7kRl76am9z92l+A3fy92nqmEnO
         n9fMjEVtVhE+sTOwcynvlydXRLei5tbDaQPTEo5Xe93N8cas6otL3+vWsgKxZx19fVjV
         lXvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=tqDWMzei;
       dkim=pass header.i=@chromium.org header.s=google header.b=SLME6Utq;
       spf=pass (google.com: domain of kernel-hardening-return-11736-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11736-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=tqDWMzei;
       dkim=pass header.i=@chromium.org header.s=google header.b=SLME6Utq;
       spf=pass (google.com: domain of kernel-hardening-return-11736-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11736-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180212165301.17933-6-igor.stoppa@huawei.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com> <20180212165301.17933-6-igor.stoppa@huawei.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 15:43:56 -0800
X-Google-Sender-Auth: 5YzkZF_D1edi3hh680iL5vrjnY0
Message-ID: <CAGXu5j+ZZkgLzsxcwAYgyu=A=11Fkeuj+F_8gCUAbXDmjWFdeg@mail.gmail.com>
Subject: Re: [PATCH 5/6] Pmalloc: self-test
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592215146511084234?=
X-GMAIL-MSGID: =?utf-8?q?1592240694755025176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 8:53 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> Add basic self-test functionality for pmalloc.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> ---
>  mm/Kconfig            |  9 ++++++++
>  mm/Makefile           |  1 +
>  mm/pmalloc-selftest.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/pmalloc-selftest.h | 24 +++++++++++++++++++
>  mm/pmalloc.c          |  2 ++
>  5 files changed, 100 insertions(+)
>  create mode 100644 mm/pmalloc-selftest.c
>  create mode 100644 mm/pmalloc-selftest.h
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index be578fbdce6d..098aefef78b1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -766,3 +766,12 @@ config PROTECTABLE_MEMORY
>      depends on ARCH_HAS_SET_MEMORY
>      select GENERIC_ALLOCATOR
>      default y
> +
> +config PROTECTABLE_MEMORY_SELFTEST
> +       bool "Run self test for pmalloc memory allocator"
> +       depends on ARCH_HAS_SET_MEMORY
> +       select PROTECTABLE_MEMORY
> +       default n
> +       help
> +         Tries to verify that pmalloc works correctly and that the memory
> +         is effectively protected.
> diff --git a/mm/Makefile b/mm/Makefile
> index 959fdbdac118..f7bbbfde6967 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
>  obj-$(CONFIG_SLOB) += slob.o
>  obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
>  obj-$(CONFIG_PROTECTABLE_MEMORY) += pmalloc.o
> +obj-$(CONFIG_PROTECTABLE_MEMORY_SELFTEST) += pmalloc-selftest.o

Nit: self-test modules are traditionally named "test_$thing.o"
(outside of the tools/ directory).

>  obj-$(CONFIG_KSM) += ksm.o
>  obj-$(CONFIG_PAGE_POISONING) += page_poison.o
>  obj-$(CONFIG_SLAB) += slab.o
> diff --git a/mm/pmalloc-selftest.c b/mm/pmalloc-selftest.c
> new file mode 100644
> index 000000000000..97ba52d17f69
> --- /dev/null
> +++ b/mm/pmalloc-selftest.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pmalloc-selftest.c
> + *
> + * (C) Copyright 2018 Huawei Technologies Co. Ltd.
> + * Author: Igor Stoppa <igor.stoppa@huawei.com>
> + */
> +
> +#include <linux/pmalloc.h>
> +#include <linux/mm.h>
> +
> +#include "pmalloc-selftest.h"
> +
> +#define SIZE_1 (PAGE_SIZE * 3)
> +#define SIZE_2 1000
> +
> +#define validate_alloc(expected, variable, size)       \
> +       pr_notice("must be " expected ": %s",           \
> +                 is_pmalloc_object(variable, size) > 0 ? "ok" : "no")
> +
> +#define is_alloc_ok(variable, size)    \
> +       validate_alloc("ok", variable, size)
> +
> +#define is_alloc_no(variable, size)    \
> +       validate_alloc("no", variable, size)
> +
> +void pmalloc_selftest(void)
> +{
> +       struct gen_pool *pool_unprot;
> +       struct gen_pool *pool_prot;
> +       void *var_prot, *var_unprot, *var_vmall;
> +
> +       pr_notice("pmalloc self-test");
> +       pool_unprot = pmalloc_create_pool("unprotected", 0);
> +       pool_prot = pmalloc_create_pool("protected", 0);
> +       BUG_ON(!(pool_unprot && pool_prot));
> +
> +       var_unprot = pmalloc(pool_unprot,  SIZE_1 - 1, GFP_KERNEL);
> +       var_prot = pmalloc(pool_prot,  SIZE_1, GFP_KERNEL);
> +       *(int *)var_prot = 0;
> +       var_vmall = vmalloc(SIZE_2);
> +       is_alloc_ok(var_unprot, 10);
> +       is_alloc_ok(var_unprot, SIZE_1);
> +       is_alloc_ok(var_unprot, PAGE_SIZE);
> +       is_alloc_no(var_unprot, SIZE_1 + 1);
> +       is_alloc_no(var_vmall, 10);
> +
> +
> +       pfree(pool_unprot, var_unprot);
> +       vfree(var_vmall);
> +
> +       pmalloc_protect_pool(pool_prot);
> +
> +       /*
> +        * This will intentionally trigger a WARN because the pool being
> +        * destroyed is not protected, which is unusual and should happen
> +        * on error paths only, where probably other warnings are already
> +        * displayed.
> +        */
> +       pmalloc_destroy_pool(pool_unprot);
> +
> +       /* This must not cause WARNings */
> +       pmalloc_destroy_pool(pool_prot);
> +}

I wonder if lkdtm should grow a test too, to validate the RO-ness of
the allocations at the right time in API usage?

Otherwise, yay! Selftests!

-Kees

> diff --git a/mm/pmalloc-selftest.h b/mm/pmalloc-selftest.h
> new file mode 100644
> index 000000000000..58a5a0cbec14
> --- /dev/null
> +++ b/mm/pmalloc-selftest.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * pmalloc-selftest.h
> + *
> + * (C) Copyright 2018 Huawei Technologies Co. Ltd.
> + * Author: Igor Stoppa <igor.stoppa@huawei.com>
> + */
> +
> +
> +#ifndef __MM_PMALLOC_SELFTEST_H
> +#define __MM_PMALLOC_SELFTEST_H
> +
> +
> +#ifdef CONFIG_PROTECTABLE_MEMORY_SELFTEST
> +
> +void pmalloc_selftest(void);
> +
> +#else
> +
> +static inline void pmalloc_selftest(void){};
> +
> +#endif
> +
> +#endif
> diff --git a/mm/pmalloc.c b/mm/pmalloc.c
> index abddba90a9f6..eb445c574b19 100644
> --- a/mm/pmalloc.c
> +++ b/mm/pmalloc.c
> @@ -22,6 +22,7 @@
>  #include <asm/page.h>
>
>  #include <linux/pmalloc.h>
> +#include "pmalloc-selftest.h"
>  /*
>   * pmalloc_data contains the data specific to a pmalloc pool,
>   * in a format compatible with the design of gen_alloc.
> @@ -494,6 +495,7 @@ static int __init pmalloc_late_init(void)
>                 }
>         }
>         mutex_unlock(&pmalloc_mutex);
> +       pmalloc_selftest();
>         return 0;
>  }
>  late_initcall(pmalloc_late_init);
> --
> 2.14.1
>



-- 
Kees Cook
Pixel Security
