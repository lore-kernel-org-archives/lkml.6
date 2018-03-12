Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932798AbeCLDTM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 23:19:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932593AbeCLDTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 23:19:08 -0400
Date: Mon, 12 Mar 2018 11:18:55 +0800
From: Dave Young <dyoung@redhat.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, vgoyal@redhat.com,
        bhe@redhat.com, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 0/7] kexec_file, x86, powerpc: refactoring for other
 architecutres
Message-ID: <20180312031855.GA2136@dhcp-128-65.nay.redhat.com>
References: <20180306102303.9063-1-takahiro.akashi@linaro.org>
 <20180308010502.GA2600@dhcp-128-65.nay.redhat.com>
 <20180309060254.GA9728@dhcp-128-65.nay.redhat.com>
 <20180309064412.GA5327@dhcp-128-65.nay.redhat.com>
 <20180309071813.GE25863@linaro.org>
 <20180309074613.GA6331@dhcp-128-65.nay.redhat.com>
 <20180309075547.GA6718@dhcp-128-65.nay.redhat.com>
 <20180309093346.GF25863@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309093346.GF25863@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/18 at 06:33pm, AKASHI Takahiro wrote:

[snip]

> Oops, please apply the fix below to my first patch ("kexec_file: make
> an use of purgatory optional"). My screw-up is trivial here :)

Wow, human eyes sometimes can not catch such issue, thanks for the fix.
It works for me.

> 
> Please let me know if you think that I should repost my patch set.
> 

Because akpm takes kexec patches,  this question should be passing to
Andrew.  Andrew, do you need a repost?

> Thanks,
> -Takahiro AKASHI
> 
> ===8<===
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 6dbbb89cbbac..ab1dced677fd 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -532,7 +532,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	struct kexec_sha_region *sha_regions;
>  	struct purgatory_info *pi = &image->purgatory_info;
>  
> -	if (!IS_ENABLED(ARCH_HAS_KEXEC_PURGATORY))
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_KEXEC_PURGATORY))
>  		return 0;
>  
>  	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
> ===>8===
> 

Thanks
Dave
