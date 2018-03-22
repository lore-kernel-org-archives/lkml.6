Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeCVQCM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:02:12 -0400
Received: from foss.arm.com ([217.140.101.70]:39552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbeCVQCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:02:09 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 08/22] mm: Introduce __GFP_ENCRYPT
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
        <20180305162610.37510-9-kirill.shutemov@linux.intel.com>
Date: Thu, 22 Mar 2018 16:02:06 +0000
In-Reply-To: <20180305162610.37510-9-kirill.shutemov@linux.intel.com> (Kirill
        A. Shutemov's message of "Mon, 5 Mar 2018 19:25:56 +0300")
Message-ID: <87sh8s14ld.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> The patch adds new gfp flag to indicate that we're allocating encrypted
> page.
>
> Architectural code may need to do special preparation for encrypted
> pages such as flushing cache to avoid aliasing.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/gfp.h            | 12 ++++++++++++
>  include/linux/mm.h             |  2 ++
>  include/trace/events/mmflags.h |  1 +
>  mm/Kconfig                     |  3 +++
>  mm/page_alloc.c                |  3 +++
>  tools/perf/builtin-kmem.c      |  1 +
>  6 files changed, 22 insertions(+)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 1a4582b44d32..43a93ca11c3c 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -24,6 +24,11 @@ struct vm_area_struct;
>  #define ___GFP_HIGH		0x20u
>  #define ___GFP_IO		0x40u
>  #define ___GFP_FS		0x80u
> +#ifdef CONFIG_ARCH_WANTS_GFP_ENCRYPT
> +#define ___GFP_ENCYPT		0x100u
> +#else
> +#define ___GFP_ENCYPT		0

s/___GFP_ENCYPT/___GFP_ENCRYPT?

Thanks,
Punit

[...]
