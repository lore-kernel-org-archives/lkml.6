Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2A1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E47322427
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E47322427
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeGCOU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:20:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:54962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753036AbeGCOU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:20:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95FA6B055;
        Tue,  3 Jul 2018 14:20:56 +0000 (UTC)
Date:   Tue, 3 Jul 2018 16:20:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] m68k/page_no.h: force __va argument to be unsigned
 long
Message-ID: <20180703142054.GL16767@dhcp22.suse.cz>
References: <1530613795-6956-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530613795-6956-3-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530613795-6956-3-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-07-18 13:29:54, Mike Rapoport wrote:
> Add explicit casting to unsigned long to the __va() parameter

Why is this needed?

> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  arch/m68k/include/asm/page_no.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
> index e644c4d..6bbe520 100644
> --- a/arch/m68k/include/asm/page_no.h
> +++ b/arch/m68k/include/asm/page_no.h
> @@ -18,7 +18,7 @@ extern unsigned long memory_end;
>  #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
>  
>  #define __pa(vaddr)		((unsigned long)(vaddr))
> -#define __va(paddr)		((void *)(paddr))
> +#define __va(paddr)		((void *)((unsigned long)(paddr)))
>  
>  #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
>  #define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
