Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1860028-1522226510-2-15920169204047963811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='il',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522226509; b=wqdRlfErDyIPIf8n9KATHsfrh48EMiwGoem1jy3JR9Nyr0j
    u9TP/+lPePCdwFuTxyet/69X+JYioV8mb/xjeEtvi3y27hgNEEDbOvCj1NvK0h0y
    l3/8oWgD3GySmFk6fpcEUvk2yNmjTd9a3pTF83v6dTS78Yc5Bv7Gr3jmHsx2CPBP
    G5v8I/XLx3dc+7axIN+U3Vsa2OY22YtlKNqD8rl4y/JUBgN3rx4V4piGmlMME1TC
    kuUC7yQ2Bci4ImsDMeg2msvcThLs0C4Hr3BiKLlOsBKXp81V5wKvirOoFfMB33JF
    RGxG54b2hCQu70mzoqV5CAqRVztfqVYDM2NXv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522226509; bh=nPGczTuF//zVwVvxcm2xIRLSuH
    obLPvQ048htJ3niBE=; b=fIHaNoApB0Y1A2XtKnEGHVI4TCW/DLKbc7/KVXJBxl
    2TXf51rfAx+4CQw7PDnakeX9wFi7oATEH10CfxuznQ/3e0vyGPDtfO6rRskHOcVI
    rpST5YCj1R6XqNXqxfoSBfPa+UuK/0oIHAvXqW2WbFr7amrFlqzV/R/sxX+XmKXL
    zeLvWE8XLqnA9UF9HHCy7EXm7gJb4BgXZNlDA/hGQgHPyOWQFq4docPA1MaYGDyu
    MQyJW1QeoUDHyqeRfq9qCWccu3OkNz2Px/CQQqP5v3+WknSqIX3E1iPHTH65cFNa
    epiVjNZsOqmFCLLbQ3aqVdouliZ5jba04Csj5ijfoDwA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tkos.co.il;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tkos.co.il header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tkos.co.il;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tkos.co.il header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHSuw0JQCw/B8JpmLpr1q/zsI4j73DwZA+RmmLQpUVwM1IJvmvPsIj5Hnci2UgA/EOgsnahBPjnnoyFV5IAfujdrjmZ3cUe0TvDQ9gfLkTcsdiN7tvEi
    YbANy1w+72NZg5Ad+4YXQ/dy5Y8ZXvVmBu6Wx+dOC8w02gPtcXcSRPWeSWsjjdNsdGTqOI4okMzp7hYftHsWkCEGzrA3ol4aEddZ8rBlFxkiac7zW571NHLn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=nAebDoNsAAAA:8 a=BSOUEd0VAAAA:8 a=8BssofvPAAAA:8
    a=nANqx8ztcBhn2Kp1JpIA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=ego-_vB8GfJOOuXVi8J-:22 a=KSv3kpLQGTKx0cs4RsKb:22 a=RgDPMvqbaRTRgf5V6SLc:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeC1Ils (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 04:41:48 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:57164 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbeC1Ilq (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 04:41:46 -0400
Date: Wed, 28 Mar 2018 11:41:41 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Huacai Chen <chenhc@lemote.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mm@kvack.org,
        stable@vger.kernel.org, James Hogan <james.hogan@mips.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4] ZBOOT: fix stack protector in compressed boot phase
Message-ID: <20180328084141.vseuroknkrxhraps@sapphire.tkos.co.il>
References: <1522226296-3091-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522226296-3091-1-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Huacai,

On Wed, Mar 28, 2018 at 04:38:16PM +0800, Huacai Chen wrote:
> Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> stack checking always fails for decompress_kernel() itself. So remove
> __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> call decompress_kernel().
> 
> Original code comes from ARM but also used for MIPS and SH, so fix them
> together. If without this fix, compressed booting of these archs will
> fail because stack checking is enabled by default (>=4.16).
> 
> V1 -> V2: Fix build on ARM.
> V2 -> V3: Fix build on SuperH.
> V3 -> V4: Initialize __stack_chk_guard in C code as a constant.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/arm/boot/compressed/head.S        | 4 ++++
>  arch/arm/boot/compressed/misc.c        | 7 -------
>  arch/mips/boot/compressed/decompress.c | 7 -------
>  arch/mips/boot/compressed/head.S       | 4 ++++
>  arch/sh/boot/compressed/head_32.S      | 8 ++++++++
>  arch/sh/boot/compressed/head_64.S      | 4 ++++
>  arch/sh/boot/compressed/misc.c         | 7 -------
>  7 files changed, 20 insertions(+), 21 deletions(-)

This diffstat doesn't match the patch below. The patch touches no .S file.

baruch

> 
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index 16a8a80..e8fe51f 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -128,12 +128,7 @@ asmlinkage void __div0(void)
>  	error("Attempting division by 0!");
>  }
>  
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> +const unsigned long __stack_chk_guard = 0x000a0dff;
>  
>  void __stack_chk_fail(void)
>  {
> @@ -150,8 +145,6 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
>  {
>  	int ret;
>  
> -	__stack_chk_guard_setup();
> -
>  	output_data		= (unsigned char *)output_start;
>  	free_mem_ptr		= free_mem_ptr_p;
>  	free_mem_end_ptr	= free_mem_ptr_end_p;
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index fdf99e9..81df904 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -76,12 +76,7 @@ void error(char *x)
>  #include "../../../../lib/decompress_unxz.c"
>  #endif
>  
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> +const unsigned long __stack_chk_guard = 0x000a0dff;
>  
>  void __stack_chk_fail(void)
>  {
> @@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>  {
>  	unsigned long zimage_start, zimage_size;
>  
> -	__stack_chk_guard_setup();
> -
>  	zimage_start = (unsigned long)(&__image_begin);
>  	zimage_size = (unsigned long)(&__image_end) -
>  	    (unsigned long)(&__image_begin);
> diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
> index 627ce8e..c15cac9 100644
> --- a/arch/sh/boot/compressed/misc.c
> +++ b/arch/sh/boot/compressed/misc.c
> @@ -104,12 +104,7 @@ static void error(char *x)
>  	while(1);	/* Halt */
>  }
>  
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> +const unsigned long __stack_chk_guard = 0x000a0dff;
>  
>  void __stack_chk_fail(void)
>  {
> @@ -130,8 +125,6 @@ void decompress_kernel(void)
>  {
>  	unsigned long output_addr;
>  
> -	__stack_chk_guard_setup();
> -
>  #ifdef CONFIG_SUPERH64
>  	output_addr = (CONFIG_MEMORY_START + 0x2000);
>  #else

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
