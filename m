Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A900FC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637C22098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3LSaQn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637C22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeJQCxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:53:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32986 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeJQCxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:53:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id q40-v6so27093846qte.0;
        Tue, 16 Oct 2018 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZWIxmPpg9hK+qOL6Ph/hRnh2DJyJ/jHZDmS/ynORmVU=;
        b=X3LSaQn7XhgfTynJ02A0RLUnk3y23jw3aVIc2nNSeShQL+lxlecAA+gKDuvRThVsNt
         pqE9ri/3C/YE1Vd7Z2/u4W3b7ztevaPGwj5RAnzyO5nMyNRAJJUHmZO2hOD7G1UbDnLu
         /aeZZlG7cDEysbRwfqNyi1070JYThkeN3Yf53DA96KOzd66e/7xE/OxkPmiEFZvuka7x
         j2nyW8UnJ/UdMV1P2CRp3r8HbzeqjF7HnsTKzzGCIj1hS/9lZL7dyZurb1lbKek1xqiJ
         b5s94KZAG9St9W64QEUwVBI6zlkVpAf1X2RZ4/GIJuwquYrdO80Uw7mdZmk/NWhKtQFv
         IMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZWIxmPpg9hK+qOL6Ph/hRnh2DJyJ/jHZDmS/ynORmVU=;
        b=EG/Rbb8iX6N8AkFfizxKc4Iq7Es5MUykDauoCAzDGA1Tgn/CHiUroFtM3fhtMHY+wO
         GgXH8UaHDK15ajQ6LJ0KGCqARselpmIqIOeYcEc4tTfdNXv/Bj/ApLLyMADj1eCh3w7t
         uCi/64GdKrcupQTu+8fMwou226sPRkGkNjE62gkGMjGLAZY2dqgkALeym5PGG4gdNztn
         X2vwp1WYP3Zx3L1R0RFyQhnjFrVCsEPhOGPgEIFUbKtlEsczgwbej9t9RvtNfJzqGB91
         AmBEctgk1Vu8asO5qcXVA2sCKMTh1BbQ0jA1h3/bL8/8o+R9GWtsHoLPsYglAj3LhfW8
         cxPA==
X-Gm-Message-State: ABuFfogiKOV0YFmsFKJ3lfzX3nyKkCytPZ+aJM0bYk9prEklPnxSxIHx
        afelH4FDvZupN/DpbkCir7g=
X-Google-Smtp-Source: ACcGV608BMPVx+2RZSTS1J/ditvK9JrCxBhD6/hNhKTjwRjAHzEVYxzcIGbDcXYlSEuXWLU8Kxeitw==
X-Received: by 2002:a0c:bd15:: with SMTP id m21mr23201614qvg.77.1539716473335;
        Tue, 16 Oct 2018 12:01:13 -0700 (PDT)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m13-v6sm8098187qtm.20.2018.10.16.12.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 12:01:12 -0700 (PDT)
Subject: Re: [mm PATCH v3 1/6] mm: Use mm_zero_struct_page from SPARC on all
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
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202656.2171.92963.stgit@localhost.localdomain>
From:   Pavel Tatashin <pasha.tatashin@gmail.com>
Message-ID: <57c559f6-4858-7a52-7fbb-979caa08f240@gmail.com>
Date:   Tue, 16 Oct 2018 15:01:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181015202656.2171.92963.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/18 4:26 PM, Alexander Duyck wrote:
> This change makes it so that we use the same approach that was already in
> use on Sparc on all the archtectures that support a 64b long.
> 
> This is mostly motivated by the fact that 8 to 10 store/move instructions
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
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>


I have tested on Broadcom's Stingray cpu with 48G RAM:
__init_single_page() takes 19.30ns / 64-byte struct page
Wit the change it takes 17.33ns / 64-byte struct page

Please add this data and also the data from Intel to the description.

Thank you,
Pavel

> ---
>  arch/sparc/include/asm/pgtable_64.h |   30 ------------------------------
>  include/linux/mm.h                  |   34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 30 deletions(-)
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
> index bb0de406f8e7..ec6e57a0c14e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -102,8 +102,42 @@ static inline void set_max_mapnr(unsigned long limit) { }
>   * zeroing by defining this macro in <asm/pgtable.h>.
>   */

The comment above becomes outdated. Please change, we use optimized
mm_zero_struct_page on every 64-bit platform.

>  #ifndef mm_zero_struct_page
> +#if BITS_PER_LONG == 64
> +/* This function must be updated when the size of struct page grows above 80
> + * or reduces below 64. The idea that compiler optimizes out switch()
> + * statement, and only leaves move/store instructions
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
> +	default:
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
> +#endif
>  
>  /*
>   * Default maximum number of active map areas, this limits the number of vmas
> 
