Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631F8C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016D921476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRWtEbWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016D921476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeJSCbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:31:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45383 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeJSCbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:31:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id e10-v6so35409026qtq.12;
        Thu, 18 Oct 2018 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=50dcMLKlkU90BQA+rVvYe793i9INHkOMeOzjPtD0YG0=;
        b=aRWtEbWIU7DukOI8a6nDsQcTJuKr7jT6TqDUbRsqfhdBgm7CJAPcje1TJHXGf3CHB6
         W/Nb9cpPOfXdi8mBAOtoCYQmZHQ10RyHwaGKv+Qc60fzdBZ2BryoiDx8HigIcKPuyHvI
         mGIf6wK+Foy8J0vk94jMKtSkgM9E+3cPJJLhuZ3qqj5g9XCoLWZdbR/dK8ApJ9yy2Xrh
         lz/FpDfJryktub8mY2VLbLnAHev9rChNL2GzeoCHtbUD7kMNNOAYES6c30dL/S39HCnV
         PWKHKSFPDDOEpe+NH9gnFQ5cpfh5W+kpPN5moLAgXEwoyxhDYtai7ksI9Rzokw+bGHQx
         B4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=50dcMLKlkU90BQA+rVvYe793i9INHkOMeOzjPtD0YG0=;
        b=GflFyw0hi7BlJ8Er4NrTlCLe1XAZtQVpM3eBfVkpEND3YwlQgGRdNNN4vYohkZv1YQ
         qlcdriTtWxkxNcrYa4joX/ObOWDa6jJGc/wHHISL1lh4BVprRUwloB2YMuhiuYS2L5eA
         VEjOAUexLb9r9/m8KQo0vPYFUCiaqT23Eur+e1PKxFIqCIiincnGDqehDEFZcA8EZdmh
         GOxLX45IKwCJ1019VxuU7TRvEH96KpvMwhVFH3kIoSFGthTc4LPZxb4AoTqeLpWijeGq
         5QibAGl8pJoKJyu89t1f4EszYk6XtMlp8CV3GIQ4+4HGWov/yPNw48Ne0GG9znD5gSOU
         Cyfg==
X-Gm-Message-State: ABuFfog6LQUKPjW1nv94LkalHPasjUO6hNB0ffUJtN1nTFFpinh23cbW
        enOh8m/s+2jdqjylSYT2j/4=
X-Google-Smtp-Source: ACcGV62Ah5QnFMUNV5giZkHJ+fkgwzuj3VsdUk1R6dLS/qxWtvnAP2laAhlKLnQU/fX9k6Yl45fIlQ==
X-Received: by 2002:ac8:246:: with SMTP id o6-v6mr28976845qtg.0.1539887356642;
        Thu, 18 Oct 2018 11:29:16 -0700 (PDT)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i190-v6sm892051qkc.59.2018.10.18.11.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 11:29:16 -0700 (PDT)
Subject: Re: [mm PATCH v4 1/6] mm: Use mm_zero_struct_page from SPARC on all
 64b architectures
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, davem@davemloft.net,
        yi.z.zhang@linux.intel.com, khalid.aziz@oracle.com,
        rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
References: <20181017235043.17213.92459.stgit@localhost.localdomain>
 <20181017235408.17213.38641.stgit@localhost.localdomain>
From:   Pavel Tatashin <pasha.tatashin@gmail.com>
Message-ID: <04e89c12-a05b-bda3-716f-10f885fc5bf0@gmail.com>
Date:   Thu, 18 Oct 2018 14:29:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017235408.17213.38641.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/18 7:54 PM, Alexander Duyck wrote:
> This change makes it so that we use the same approach that was already in
> use on Sparc on all the archtectures that support a 64b long.
> 
> This is mostly motivated by the fact that 7 to 10 store/move instructions
> are likely always going to be faster than having to call into a function
> that is not specialized for handling page init.
> 
> An added advantage to doing it this way is that the compiler can get away
> with combining writes in the __init_single_page call. As a result the
> memset call will be reduced to only about 4 write operations, or at least
> that is what I am seeing with GCC 6.2 as the flags, LRU poitners, and
> count/mapcount seem to be cancelling out at least 4 of the 8 assignments on
> my system.
> 
> One change I had to make to the function was to reduce the minimum page
> size to 56 to support some powerpc64 configurations.
> 
> This change should introduce no change on SPARC since it already had this
> code. In the case of x86_64 I saw a reduction from 3.75s to 2.80s when
> initializing 384GB of RAM per node. Pavel Tatashin tested on a system with
> Broadcom's Stingray CPU and 48GB of RAM and found that __init_single_page()
> takes 19.30ns / 64-byte struct page before this patch and with this patch
> it takes 17.33ns / 64-byte struct page. Mike Rapoport ran a similar test on
> a OpenPower (S812LC 8348-21C) with Power8 processor and 128GB or RAM. His
> results per 64-byte struct page were 4.68ns before, and 4.59ns after this
> patch.

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>

> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  arch/sparc/include/asm/pgtable_64.h |   30 --------------------------
>  include/linux/mm.h                  |   41 ++++++++++++++++++++++++++++++++---
>  2 files changed, 38 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 1393a8ac596b..22500c3be7a9 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -231,36 +231,6 @@
>  extern struct page *mem_map_zero;
>  #define ZERO_PAGE(vaddr)	(mem_map_zero)
>  
> -/* This macro must be updated when the size of struct page grows above 80
> - * or reduces below 64.
> - * The idea that compiler optimizes out switch() statement, and only
> - * leaves clrx instructions
> - */
> -#define	mm_zero_struct_page(pp) do {					\
> -	unsigned long *_pp = (void *)(pp);				\
> -									\
> -	 /* Check that struct page is either 64, 72, or 80 bytes */	\
> -	BUILD_BUG_ON(sizeof(struct page) & 7);				\
> -	BUILD_BUG_ON(sizeof(struct page) < 64);				\
> -	BUILD_BUG_ON(sizeof(struct page) > 80);				\
> -									\
> -	switch (sizeof(struct page)) {					\
> -	case 80:							\
> -		_pp[9] = 0;	/* fallthrough */			\
> -	case 72:							\
> -		_pp[8] = 0;	/* fallthrough */			\
> -	default:							\
> -		_pp[7] = 0;						\
> -		_pp[6] = 0;						\
> -		_pp[5] = 0;						\
> -		_pp[4] = 0;						\
> -		_pp[3] = 0;						\
> -		_pp[2] = 0;						\
> -		_pp[1] = 0;						\
> -		_pp[0] = 0;						\
> -	}								\
> -} while (0)
> -
>  /* PFNs are real physical page numbers.  However, mem_map only begins to record
>   * per-page information starting at pfn_base.  This is to handle systems where
>   * the first physical page in the machine is at some huge physical address,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fcf9cc9d535f..6e2c9631af05 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -98,10 +98,45 @@ static inline void set_max_mapnr(unsigned long limit) { }
>  
>  /*
>   * On some architectures it is expensive to call memset() for small sizes.
> - * Those architectures should provide their own implementation of "struct page"
> - * zeroing by defining this macro in <asm/pgtable.h>.
> + * If an architecture decides to implement their own version of
> + * mm_zero_struct_page they should wrap the defines below in a #ifndef and
> + * define their own version of this macro in <asm/pgtable.h>
>   */
> -#ifndef mm_zero_struct_page
> +#if BITS_PER_LONG == 64
> +/* This function must be updated when the size of struct page grows above 80
> + * or reduces below 56. The idea that compiler optimizes out switch()
> + * statement, and only leaves move/store instructions. Also the compiler can
> + * combine write statments if they are both assignments and can be reordered,
> + * this can result in several of the writes here being dropped.
> + */
> +#define	mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
> +static inline void __mm_zero_struct_page(struct page *page)
> +{
> +	unsigned long *_pp = (void *)page;
> +
> +	 /* Check that struct page is either 56, 64, 72, or 80 bytes */
> +	BUILD_BUG_ON(sizeof(struct page) & 7);
> +	BUILD_BUG_ON(sizeof(struct page) < 56);
> +	BUILD_BUG_ON(sizeof(struct page) > 80);
> +
> +	switch (sizeof(struct page)) {
> +	case 80:
> +		_pp[9] = 0;	/* fallthrough */
> +	case 72:
> +		_pp[8] = 0;	/* fallthrough */
> +	case 64:
> +		_pp[7] = 0;	/* fallthrough */
> +	case 56:
> +		_pp[6] = 0;
> +		_pp[5] = 0;
> +		_pp[4] = 0;
> +		_pp[3] = 0;
> +		_pp[2] = 0;
> +		_pp[1] = 0;
> +		_pp[0] = 0;
> +	}
> +}
> +#else
>  #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
>  #endif
>  
> 
