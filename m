Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC841C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1A4218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="S1eK1s2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfBKSWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:22:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfBKSW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:22:29 -0500
Received: from zn.tnic (p200300EC2BC7A10074DEFDFE3AD6CF32.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:a100:74de:fdfe:3ad6:cf32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5B721EC01B6;
        Mon, 11 Feb 2019 19:22:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549909348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mBrHsqt4hUkstq7VFx24ziqfy/NU+TGvc1tFvnBJ8PA=;
        b=S1eK1s2WDNc/02K3VAa86oPXXo4XoDwFmtP0wbeZYty5vAp9mprYozKcOct+xRxW15U4++
        c3/M3JS0QgDRn5peV2kEMuTIRbxVT2WR5+ldKaRyWQt5dV1T85uygPXDKqWdlXpoIgzsRL
        kYmIwrctHP4YCZkqztXDQC87SbD3/S8=
Date:   Mon, 11 Feb 2019 19:22:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 09/20] x86/kprobes: instruction pages initialization
 enhancements
Message-ID: <20190211182221.GM19618@zn.tnic>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-10-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129003422.9328-10-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only nitpicks:

> Subject: Re: [PATCH v2 09/20] x86/kprobes: instruction pages initialization enhancements

Subject needs a verb.

On Mon, Jan 28, 2019 at 04:34:11PM -0800, Rick Edgecombe wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Make kprobes instruction pages read-only (and executable) after they are
> set to prevent them from mistaken or malicious modifications.
> 
> This is a preparatory patch for a following patch that makes module
> allocated pages non-executable and sets the page as executable after
> allocation.
> 
> While at it, do some small cleanup of what appears to be unnecessary
> masking.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 4ba75afba527..fac692e36833 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -431,8 +431,20 @@ void *alloc_insn_page(void)
>  	void *page;
>  
>  	page = module_alloc(PAGE_SIZE);
> -	if (page)
> -		set_memory_ro((unsigned long)page & PAGE_MASK, 1);
> +	if (page == NULL)
> +		return NULL;

Null tests we generally do like this:

	if (! ...


like in the rest of this file.

> +
> +	/*
> +	 * First make the page read-only, and then only then make it executable

 s/then only then/only then/

ditto below.

> +	 * to prevent it from being W+X in between.
> +	 */
> +	set_memory_ro((unsigned long)page, 1);
> +
> +	/*
> +	 * TODO: Once additional kernel code protection mechanisms are set, ensure
> +	 * that the page was not maliciously altered and it is still zeroed.
> +	 */
> +	set_memory_x((unsigned long)page, 1);
>  
>  	return page;
>  }
> @@ -440,8 +452,12 @@ void *alloc_insn_page(void)
>  /* Recover page to RW mode before releasing it */
>  void free_insn_page(void *page)
>  {
> -	set_memory_nx((unsigned long)page & PAGE_MASK, 1);
> -	set_memory_rw((unsigned long)page & PAGE_MASK, 1);
> +	/*
> +	 * First make the page non-executable, and then only then make it
> +	 * writable to prevent it from being W+X in between.
> +	 */
> +	set_memory_nx((unsigned long)page, 1);
> +	set_memory_rw((unsigned long)page, 1);
>  	module_memfree(page);
>  }
>  
> -- 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
