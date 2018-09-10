Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F492C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B2920854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAMVaE7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B2920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeIJLES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:04:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52341 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeIJLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:04:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id y139-v6so20043323wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASe+7aPSALyJ1urFwSG4W5RbcgnSurf38LZO4NvJtIo=;
        b=rAMVaE7CeSzOfbN8DXX2y9MKCa6T90jBhIdKkc7YcXeHvmYuW8ZeecZAPlB8/+5txm
         AYRIz6Q4zW/li6oMqdos+qww715SrPMeFIBhtI3QlZ3exZKMu9yrmEMuOTPMUz6xTO8H
         cCiNgJ3rowfCjAgbNmkOa6MPeIMKPhMNJJWxfC9IJw5gSGPHlmAiJYM8+7/k80/p+sZY
         qw38xWrwx8rVhW5V6FW8w+6Hb/V8UKLyjpb3/JU+2SE7qU7bjlxngnvvsqSOv+Gnhk7R
         NTxotDjigX+XlZCZEwGvoZyvQsMYQOA18V6JP+1lUIe3yq6/WTNgxcYHZ9QJum6xU6bb
         NZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASe+7aPSALyJ1urFwSG4W5RbcgnSurf38LZO4NvJtIo=;
        b=AvbeefcLOgdML6AyNx51g4dnbKgCvFdnfrpq9kj89npqczXuTpjv5dll31QL7GgAtv
         5SJCsU6wahp4jr1CSuKR/M9OnVawmrMSihEFt7xYj/9Z61VhqqoQmtmkU/Py/TAYGvbL
         ZSI73cmDG2Ns+1RDQwD+dBbSfyV0DBt+ULYo9UooDGt34mj5XsYOCM0AodWGYsB0XXrM
         G+SswpP3dZjh2FTBjejW5MGkE7FoAMkC2LvybxgqK3IkzYcPUH9pwUB6F882Pma8uwxK
         21VjaLN1R/X8gcwyyHSllg+vt+E8mTuH+1ovi9V643BEPsnAhx3jl7PglvOYyQue9hJ3
         CcDQ==
X-Gm-Message-State: APzg51DgospBHnAf79fPXNrWzvgk0x2itXyIljp7Lp0pnkoHY0+KJJ9u
        KRhoBr+2iLBkrFRylEDj1Qw=
X-Google-Smtp-Source: ANB0Vdal6CPGfj3xHPBLAXO7vFGXehUtAzQxFVtS7NabX47n57S0aOIohuKJ87Nd/4KsWO7Wrw/9IA==
X-Received: by 2002:a1c:1f50:: with SMTP id f77-v6mr12866941wmf.52.1536559913905;
        Sun, 09 Sep 2018 23:11:53 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a37-v6sm33103378wrc.21.2018.09.09.23.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 23:11:53 -0700 (PDT)
Date:   Mon, 10 Sep 2018 08:11:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/3] x86/mm/KASLR: Calculate the actual size of
 vmemmap region
Message-ID: <20180910061151.GA85199@gmail.com>
References: <20180909124946.17988-1-bhe@redhat.com>
 <20180909124946.17988-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909124946.17988-2-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> Vmemmap region has different maximum size depending on paging mode.
> Now its size is hardcoded as 1TB in memory KASLR, this is not
> right for 5-level paging mode. It will cause overflow if vmemmap
> region is randomized to be adjacent to cpu_entry_area region and
> its actual size is bigger than 1TB.
> 
> So here calculate how many TB by the actual size of vmemmap region
> and align up to 1TB boundary.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/kaslr.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 0988971069c9..1db8e166455e 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -51,7 +51,7 @@ static __initdata struct kaslr_memory_region {
>  } kaslr_regions[] = {
>  	{ &page_offset_base, 0 },
>  	{ &vmalloc_base, 0 },
> -	{ &vmemmap_base, 1 },
> +	{ &vmemmap_base, 0 },
>  };
>  
>  /* Get size in bytes used by the memory region */
> @@ -77,6 +77,7 @@ void __init kernel_randomize_memory(void)
>  	unsigned long rand, memory_tb;
>  	struct rnd_state rand_state;
>  	unsigned long remain_entropy;
> +	unsigned long vmemmap_size;
>  
>  	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
>  	vaddr = vaddr_start;
> @@ -108,6 +109,14 @@ void __init kernel_randomize_memory(void)
>  	if (memory_tb < kaslr_regions[0].size_tb)
>  		kaslr_regions[0].size_tb = memory_tb;
>  
> +	/*
> +	 * Calculate how many TB vmemmap region needs, and align to
> +	 * 1TB boundary.
> +	 * */

Yeah, so that's not the standard comment style ...

> +	vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
> +		sizeof(struct page);
> +	kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);

So I tried to review what all this code does, and the comments aren't too great to explain the 
concepts.

For example:

/*
 * Memory regions randomized by KASLR (except modules that use a separate logic
 * earlier during boot). The list is ordered based on virtual addresses. This
 * order is kept after randomization.
 */
static __initdata struct kaslr_memory_region {
        unsigned long *base;
        unsigned long size_tb;
} kaslr_regions[] = {
        { &page_offset_base, 0 },
        { &vmalloc_base, 0 },
        { &vmemmap_base, 1 },
};

So I get the part where the 'base' pointer is essentially pointers to various global variables 
used by the MM to get the virtual base address of the kernel, vmalloc and vmemmap areas from, 
which base addresses can thus be modified by the very early KASLR code to dynamically shape the 
virtual memory layout of these kernel memory areas on a per bootup basis.

(BTW., that would be a great piece of information to add for the uninitiated. It's not like 
it's obvious!)

But what does 'size_tb' do? Nothing explains it and your patch doesn't make it clearer either. 
Also, get_padding() looks like an unnecessary layer of obfuscation:

/* Get size in bytes used by the memory region */
static inline unsigned long get_padding(struct kaslr_memory_region *region)
{
        return (region->size_tb << TB_SHIFT);
}

It's used only twice and we do bit shifts in the parent function anyway so it's not like it's 
hiding some uninteresting detail. (The style ugliness of the return statement makes it annoying 
as well.)

So could we please first clean up this code, explain it properly, name the fields properly, 
etc., before modifying it? Because it still looks unnecessarily hard to review. I.e. this early 
boot code needs improvements of quality and neither the base code nor your patches give me the 
impression of carefully created, easy to maintain code.

Thanks,

	Ingo
