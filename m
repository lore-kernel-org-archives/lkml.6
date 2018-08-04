Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E9DC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9BB217B4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tb1tdpra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9BB217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbeHDCeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:34:23 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42308 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732001AbeHDCeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:34:23 -0400
Received: by mail-pl0-f66.google.com with SMTP id z7-v6so3233737plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=g7X3cKu34tOyFTefJm03lB53dNWMeqpZBHrCyd3cCTE=;
        b=tb1tdpraMGh6Z2jk3pXVf1JCC192B5tTf1xFZHZXzsVREga6/WDM9W7JR6y2kD4nw6
         KvjOKL+592JoGp7nvrkqL0y/l8F7Hn09DdPNV3XphymklBJY1MN38//1rRpWNk6juRPB
         kCcezto3knOlZ2MxnBelF4deVtUwhV1Do0gd7CZlAIPoxBmUbFrN02W7xfhwKVOp4YVM
         payz/bF14PVkXZzWenW5o1orMjkarntxLyibbT5qANAKf4qjlVQZev+3dC7TTlLlhZ1+
         wycUIkRaotC0xsy9woF/bYiLbe0PQ8+L5umiq7PBFIAmlMnckPXzdWCTW2nVOC5wzXFd
         hrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=g7X3cKu34tOyFTefJm03lB53dNWMeqpZBHrCyd3cCTE=;
        b=nsMCNvHC7y6eHDHmBgn+SdgM92kfxzxdUz7eWq+Cmf64y7OWP8aTRPOfDiHCIsBwBk
         UHng7fpqslJhd/lE4e1e141hRocfCq+8nRy8asOykY0/mcQ6QV2vy3P3tGuv4qEG0ntr
         q68I4djtVchYBoP6UbTbjG1w04M/zTp5EhmTsP1ZFCfPeengkGA28FUCSvqk+ynKIpez
         rvFI39aFPdvHmc4N8zitD547lE7sD3XTJU0XKTMTmfaT2R/mQxxhs8Jmf8cdsoC6mUCH
         zNLQBlA08aD3p/kSw3uMubDI/U5sJ5xYRDxT6OW0hzDsrtrUiWKvpKIcD2ZaeLhtwsZs
         W49Q==
X-Gm-Message-State: AOUpUlFKtJaP75RPn8lonh2GBtgwGJJ8B2jc1GAjIA/kcJDJ6gAFe1er
        acm6DHBX8rO0RLOexEIjlGmU3HGLt00=
X-Google-Smtp-Source: AAOMgpe5XXU5NHrw5dVpEWzuNQTq3uboN55x5tTM8dl4EPAnqhUYobgDgUNhTxfub3jXL4jlWtw0fA==
X-Received: by 2002:a17:902:e088:: with SMTP id cb8-v6mr5482929plb.189.1533342947450;
        Fri, 03 Aug 2018 17:35:47 -0700 (PDT)
Received: from [100.112.67.156] ([104.133.9.108])
        by smtp.gmail.com with ESMTPSA id d19-v6sm13505109pfe.42.2018.08.03.17.35.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Aug 2018 17:35:46 -0700 (PDT)
Date:   Fri, 3 Aug 2018 17:35:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 5/7] x86/mm/init: remove freed kernel image areas from
 alias mapping
In-Reply-To: <20180802225831.5F6A2BFC@viggo.jf.intel.com>
Message-ID: <alpine.LSU.2.11.1808031719120.4436@eggly.anvils>
References: <20180802225823.4711C55B@viggo.jf.intel.com> <20180802225831.5F6A2BFC@viggo.jf.intel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The kernel image is mapped into two places in the virtual address
> space (addresses without KASLR, of course):
> 
> 	1. The kernel direct map (0xffff880000000000)
> 	2. The "high kernel map" (0xffffffff81000000)
> 
> We actually execute out of #2.  If we get the address of a kernel
> symbol, it points to #2, but almost all physical-to-virtual
> translations point to #1.
> 
> Parts of the "high kernel map" alias are mapped in the userspace
> page tables with the Global bit for performance reasons.  The
> parts that we map to userspace do not (er, should not) have
> secrets.

If respun, I think it would be worth reminding us here that with PTI,
the Global bit is not usually set on the high kernel map at all: it's
just used to compensate for poor performance when PCIDs not available.

> 
> This is fine, except that some areas in the kernel image that
> are adjacent to the non-secret-containing areas are unused holes.
> We free these holes back into the normal page allocator and
> reuse them as normal kernel memory.  The memory will, of course,
> get *used* via the normal map, but the alias mapping is kept.
> 
> This otherwise unused alias mapping of the holes will, by default
> keep the Global bit, be mapped out to userspace, and be
> vulnerable to Meltdown.
> 
> Remove the alias mapping of these pages entirely.  This is likely
> to fracture the 2M page mapping the kernel image near these areas,
> but this should affect a minority of the area.
> 
> The pageattr code changes *all* aliases mapping the physical pages
> that it operates on (by default).  We only want to modify a single
> alias, so we need to tweak its behavior.
> 
> This unmapping behavior is currently dependent on PTI being in
> place.  Going forward, we should at least consider doing this for
> all configurations.  Having an extra read-write alias for memory
> is not exactly ideal for debugging things like random memory
> corruption and this does undercut features like DEBUG_PAGEALLOC
> or future work like eXclusive Page Frame Ownership (XPFO).
> 
> Before this patch:
> 
> current_kernel:---[ High Kernel Mapping ]---
> current_kernel-0xffffffff80000000-0xffffffff81000000          16M                               pmd
> current_kernel-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
> current_kernel-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
> current_kernel-0xffffffff81e11000-0xffffffff82000000        1980K     RW                     NX pte
> current_kernel-0xffffffff82000000-0xffffffff82600000           6M     ro         PSE     GLB NX pmd
> current_kernel-0xffffffff82600000-0xffffffff82c00000           6M     RW         PSE         NX pmd
> current_kernel-0xffffffff82c00000-0xffffffff82e00000           2M     RW                     NX pte
> current_kernel-0xffffffff82e00000-0xffffffff83200000           4M     RW         PSE         NX pmd
> current_kernel-0xffffffff83200000-0xffffffffa0000000         462M                               pmd
> 
>   current_user:---[ High Kernel Mapping ]---
>   current_user-0xffffffff80000000-0xffffffff81000000          16M                               pmd
>   current_user-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
>   current_user-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
>   current_user-0xffffffff81e11000-0xffffffff82000000        1980K     RW                     NX pte
>   current_user-0xffffffff82000000-0xffffffff82600000           6M     ro         PSE     GLB NX pmd
>   current_user-0xffffffff82600000-0xffffffffa0000000         474M                               pmd
> 
> 
> After this patch:
> 
> current_kernel:---[ High Kernel Mapping ]---
> current_kernel-0xffffffff80000000-0xffffffff81000000          16M                               pmd
> current_kernel-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
> current_kernel-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
> current_kernel-0xffffffff81e11000-0xffffffff82000000        1980K                               pte
> current_kernel-0xffffffff82000000-0xffffffff82400000           4M     ro         PSE     GLB NX pmd
> current_kernel-0xffffffff82400000-0xffffffff82488000         544K     ro                     NX pte
> current_kernel-0xffffffff82488000-0xffffffff82600000        1504K                               pte
> current_kernel-0xffffffff82600000-0xffffffff82c00000           6M     RW         PSE         NX pmd
> current_kernel-0xffffffff82c00000-0xffffffff82c0d000          52K     RW                     NX pte
> current_kernel-0xffffffff82c0d000-0xffffffff82dc0000        1740K                               pte
> 
>   current_user:---[ High Kernel Mapping ]---
>   current_user-0xffffffff80000000-0xffffffff81000000          16M                               pmd
>   current_user-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
>   current_user-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
>   current_user-0xffffffff81e11000-0xffffffff82000000        1980K                               pte
>   current_user-0xffffffff82000000-0xffffffff82400000           4M     ro         PSE     GLB NX pmd
>   current_user-0xffffffff82400000-0xffffffff82488000         544K     ro                     NX pte

That entry correctly matches the current-kernel entry, but I would expect
both of them to be marked "GLB".  Probably of very little importance, but
it might indicate that something (my brain, perhaps) is not working quite
as you would hope.

Hugh

>   current_user-0xffffffff82488000-0xffffffff82600000        1504K                               pte
>   current_user-0xffffffff82600000-0xffffffffa0000000         474M                               pmd
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Kees Cook <keescook@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> ---
> 
>  b/arch/x86/include/asm/set_memory.h |    1 +
>  b/arch/x86/mm/init.c                |   25 +++++++++++++++++++++++--
>  b/arch/x86/mm/pageattr.c            |   13 +++++++++++++
>  3 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff -puN arch/x86/include/asm/set_memory.h~x86-unmap-freed-areas-from-kernel-image arch/x86/include/asm/set_memory.h
> --- a/arch/x86/include/asm/set_memory.h~x86-unmap-freed-areas-from-kernel-image	2018-08-02 14:14:49.462483274 -0700
> +++ b/arch/x86/include/asm/set_memory.h	2018-08-02 14:14:49.471483274 -0700
> @@ -46,6 +46,7 @@ int set_memory_np(unsigned long addr, in
>  int set_memory_4k(unsigned long addr, int numpages);
>  int set_memory_encrypted(unsigned long addr, int numpages);
>  int set_memory_decrypted(unsigned long addr, int numpages);
> +int set_memory_np_noalias(unsigned long addr, int numpages);
>  
>  int set_memory_array_uc(unsigned long *addr, int addrinarray);
>  int set_memory_array_wc(unsigned long *addr, int addrinarray);
> diff -puN arch/x86/mm/init.c~x86-unmap-freed-areas-from-kernel-image arch/x86/mm/init.c
> --- a/arch/x86/mm/init.c~x86-unmap-freed-areas-from-kernel-image	2018-08-02 14:14:49.463483274 -0700
> +++ b/arch/x86/mm/init.c	2018-08-02 14:14:49.471483274 -0700
> @@ -780,8 +780,29 @@ void free_init_pages(char *what, unsigne
>   */
>  void free_kernel_image_pages(void *begin, void *end)
>  {
> -	free_init_pages("unused kernel image",
> -			(unsigned long)begin, (unsigned long)end);
> +	unsigned long begin_ul = (unsigned long)begin;
> +	unsigned long end_ul = (unsigned long)end;
> +	unsigned long len_pages = (end_ul - begin_ul) >> PAGE_SHIFT;
> +
> +
> +	free_init_pages("unused kernel image", begin_ul, end_ul);
> +
> +	/*
> +	 * PTI maps some of the kernel into userspace.  For
> +	 * performance, this includes some kernel areas that
> +	 * do not contain secrets.  Those areas might be
> +	 * adjacent to the parts of the kernel image being
> +	 * freed, which may contain secrets.  Remove the
> +	 * "high kernel image mapping" for these freed areas,
> +	 * ensuring they are not even potentially vulnerable
> +	 * to Meltdown regardless of the specific optimizations
> +	 * PTI is currently using.
> +	 *
> +	 * The "noalias" prevents unmapping the direct map
> +	 * alias which is needed to access the freed pages.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_PTI))
> +		set_memory_np_noalias(begin_ul, len_pages);
>  }
>  
>  void __ref free_initmem(void)
> diff -puN arch/x86/mm/pageattr.c~x86-unmap-freed-areas-from-kernel-image arch/x86/mm/pageattr.c
> --- a/arch/x86/mm/pageattr.c~x86-unmap-freed-areas-from-kernel-image	2018-08-02 14:14:49.466483274 -0700
> +++ b/arch/x86/mm/pageattr.c	2018-08-02 14:14:49.472483274 -0700
> @@ -53,6 +53,7 @@ static DEFINE_SPINLOCK(cpa_lock);
>  #define CPA_FLUSHTLB 1
>  #define CPA_ARRAY 2
>  #define CPA_PAGES_ARRAY 4
> +#define CPA_NO_CHECK_ALIAS 8 /* Do not search for aliases */
>  
>  #ifdef CONFIG_PROC_FS
>  static unsigned long direct_pages_count[PG_LEVEL_NUM];
> @@ -1486,6 +1487,9 @@ static int change_page_attr_set_clr(unsi
>  
>  	/* No alias checking for _NX bit modifications */
>  	checkalias = (pgprot_val(mask_set) | pgprot_val(mask_clr)) != _PAGE_NX;
> +	/* Never check aliases if the caller asks for it explicitly: */
> +	if (checkalias && (in_flag & CPA_NO_CHECK_ALIAS))
> +		checkalias = 0;
>  
>  	ret = __change_page_attr_set_clr(&cpa, checkalias);
>  
> @@ -1772,6 +1776,15 @@ int set_memory_np(unsigned long addr, in
>  	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_PRESENT), 0);
>  }
>  
> +int set_memory_np_noalias(unsigned long addr, int numpages)
> +{
> +	int cpa_flags = CPA_NO_CHECK_ALIAS;
> +
> +	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
> +					__pgprot(_PAGE_PRESENT), 0,
> +					cpa_flags, NULL);
> +}
> +
>  int set_memory_4k(unsigned long addr, int numpages)
>  {
>  	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
> _
> 
