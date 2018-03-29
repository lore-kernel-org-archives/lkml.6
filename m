Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeC2Fct (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:32:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeC2Fcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:32:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C9F76081A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vinmenon@codeaurora.org
Subject: Re: [PATCHv2 08/14] mm/page_ext: Drop definition of unused
 PAGE_EXT_DEBUG_POISON
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
 <20180328165540.648-9-kirill.shutemov@linux.intel.com>
From: Vinayak Menon <vinmenon@codeaurora.org>
Message-ID: <765cf3b4-a2dd-39d4-6bf6-0096a9b6e818@codeaurora.org>
Date: Thu, 29 Mar 2018 11:02:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328165540.648-9-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/2018 10:25 PM, Kirill A. Shutemov wrote:
> After bd33ef368135 ("mm: enable page poisoning early at boot")
> PAGE_EXT_DEBUG_POISON is not longer used. Remove it.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vinayak Menon <vinmenon@codeaurora.org>
> ---
>  include/linux/page_ext.h | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index ca5461efae2f..bbec618a614b 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -16,18 +16,7 @@ struct page_ext_operations {
>  
>  #ifdef CONFIG_PAGE_EXTENSION
>  
> -/*
> - * page_ext->flags bits:
> - *
> - * PAGE_EXT_DEBUG_POISON is set for poisoned pages. This is used to
> - * implement generic debug pagealloc feature. The pages are filled with
> - * poison patterns and set this flag after free_pages(). The poisoned
> - * pages are verified whether the patterns are not corrupted and clear
> - * the flag before alloc_pages().
> - */
> -
>  enum page_ext_flags {
> -	PAGE_EXT_DEBUG_POISON,		/* Page is poisoned */
>  	PAGE_EXT_DEBUG_GUARD,
>  	PAGE_EXT_OWNER,
>  #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)

Reviewed-by: Vinayak Menon <vinmenon@codeaurora.org>
