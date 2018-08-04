Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF63C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB695217B4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsqdYAuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB695217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbeHDCRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:17:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37084 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbeHDCRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:17:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so3556226pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WYOnGShmWr6NRRmGR1szM9TKY6HIitXMNSCRABLNWZc=;
        b=QsqdYAuz0xFYy3dtG8sPdbZEgJXMSEueN08xS7642cUwnCKLPRO30oUVzQ6R4Ve1LJ
         +Zkn1buMKvjpHSI3a+9fgOu9yPzcE8At8kFz5ZSeKtwZ/hTvMlEhd8onGvLmI1tff1O1
         1FbcAtfusxyKFN3e5WDkqEubEQ1tgVcXqkmlBHEXiUXSn2nIi+HfzltPMuyfv8WR/WqL
         CNQjFTmMfO94A7lEAQb6Mo7im2DSPGQzsowfaQ2SAR1yT4BifX/usHW2Zn6FsFGG1Hmd
         poBpR2Nlfv0nd64XmZzpa3jkcxXkYnaZW60Nqn6gA4JD4YeYPeyjBZ4RqkvMZkDcJDyc
         kwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WYOnGShmWr6NRRmGR1szM9TKY6HIitXMNSCRABLNWZc=;
        b=OJ1fNmLmns3Zf6snzUMYmn5La3pq/pZkTy9hEcBrQc608s4tnTuuYFZ5HZN6htprN0
         gxL8sxtJR7BELUCYXxe+MeISBZsKHvtgKkL8Op9IJkE4lzVCydM4rXbICC6eBtuw4/Rj
         MyFI+9dBeXkDmlHMhawb/8XleENhzQIiMVAG6ZJvYLsKqEIuzlghiJjRY5wB67V95GD3
         jRwPAF/6pgrLbxHHK/DtF9hyb9Eu0dYOwQPUu8wKHU0az05pi7QYX7wDY61gvK2e0qZ6
         s5Ljx2v/Z20/Nd6iWCie8fwDmKzTYYXZDOK+5EVhDOFFVYC598cRNuWznaqjuR7beXjo
         dKyA==
X-Gm-Message-State: AOUpUlE97GGMIaFiYUTPlCAnEMH0HF678D/7Y8u+xtZ0uVVTbNmuDAj8
        qyf7XwFIDrSMz9D9+IN2u4zs+w==
X-Google-Smtp-Source: AAOMgpexU0Rc0MBODEYH1AkFumsOdWuJDV63LDKjZmzfzpV6HLGVr32M9JpnhihMVTRhUZlFuTznvw==
X-Received: by 2002:a62:f208:: with SMTP id m8-v6mr6722053pfh.171.1533341939530;
        Fri, 03 Aug 2018 17:18:59 -0700 (PDT)
Received: from [100.112.67.156] ([104.133.9.108])
        by smtp.gmail.com with ESMTPSA id o27-v6sm9003989pfj.35.2018.08.03.17.18.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Aug 2018 17:18:58 -0700 (PDT)
Date:   Fri, 3 Aug 2018 17:18:50 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 3/7] x86/mm/init: pass unconverted symbol addresses to
 free_init_pages()
In-Reply-To: <20180802225828.89B2D0E2@viggo.jf.intel.com>
Message-ID: <alpine.LSU.2.11.1808031650050.4436@eggly.anvils>
References: <20180802225823.4711C55B@viggo.jf.intel.com> <20180802225828.89B2D0E2@viggo.jf.intel.com>
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
> The x86 code has several places where it frees parts of kernel image:
> 
>  1. Unused SMP alternative
>  2. __init code
>  3. The hole between text and rodata
>  4. The hole between rodata and data
> 
> We call free_init_pages() to do this.  Strangely, we convert the
> symbol addresses to kernel direct map addresses in some cases
> (#3, #4) but not others (#1, #2).
> 
> The virt_to_page() and the other code in free_reserved_area() now
> works fine for for symbol addresses on x86, so don't bother
> converting the addresses to direct map addresses before freeing
> them.
> 

Thanks Dave, this series works for me.

But in trying to review it, I am feeling very stupid about this 3/7
(and/or the 2/7 before it: though I don't think that it's wrong).

I simply do not understand how this change works, and how #1 and #2
work. I thought that virt_to_page() only works on virtual addresses
in the direct map: the __va(__pa_symbol()) you remove below was a
good conversion from high kernel mapping to direct map. Without it,
how does virt_to_page() then find the right page?

Is it that there's a guaranteed common alignment between the direct
map and the high kernel mapping, and the ffffffff8....... addresses
pass through the arithmetic in such a way that virt_to_page() comes
up with the right answer; and that is well-known and relied upon by
x86 developers? Or are you now adding a dependency on a coincidence?
Or does it not work at all, and the pages are actually not freed?

Hugh

p.s. if there were to be a respin (I hope not), I notice that in
both 1/7 and 2/7 commit comments, you've said " no " for " not ";
which always makes us pause and wonder if you meant " now ".

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
>  b/arch/x86/mm/init_64.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff -puN arch/x86/mm/init_64.c~x86-init-do-not-convert-symbol-addresses arch/x86/mm/init_64.c
> --- a/arch/x86/mm/init_64.c~x86-init-do-not-convert-symbol-addresses	2018-08-02 14:14:48.380483277 -0700
> +++ b/arch/x86/mm/init_64.c	2018-08-02 14:14:48.383483277 -0700
> @@ -1283,12 +1283,8 @@ void mark_rodata_ro(void)
>  	set_memory_ro(start, (end-start) >> PAGE_SHIFT);
>  #endif
>  
> -	free_init_pages("unused kernel",
> -			(unsigned long) __va(__pa_symbol(text_end)),
> -			(unsigned long) __va(__pa_symbol(rodata_start)));
> -	free_init_pages("unused kernel",
> -			(unsigned long) __va(__pa_symbol(rodata_end)),
> -			(unsigned long) __va(__pa_symbol(_sdata)));
> +	free_init_pages("unused kernel", text_end, rodata_start);
> +	free_init_pages("unused kernel", rodata_end, _sdata);
>  
>  	debug_checkwx();
>  
> _
