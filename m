Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE3DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865BF2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YOIcLcy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865BF2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeIYWqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:46:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeIYWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zkXTXKUdzrmPZs7+5Op9fbVNhPIQJTimXSmU1iV9ZC4=; b=YOIcLcy/52k1FSI6p7jraqu+2
        9y432BDJ40c4QlgiLVWWTRh7HU0nK/RHjrVSGVLJ4NXouQZfbc8aAssX7+uyB5MlXMoyBLypx6Hjl
        j2NOOfziXY7xUuOGblXow9nJaBGfICa+QAuNkc8X+WRbNsNTq/dohcFftFPmH1gDb5vbqtdeHMH46
        WBcdb43Wpc2DkasGnRvExTpgLrjJFQYL45liiKFGPgtCOiMxBJYdZaXCsLKWzj6W6+Wujlisd2YlP
        8ETH5+3Kw4NHg0TZvvuuS8s/ZIZtHtFvOf1M/pFOwv1cVWEbsiWeVp3tES0bauTYQin8Asw4ESMza
        chQfIlQZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4qLM-0008KZ-1G; Tue, 25 Sep 2018 16:38:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0680B20289D15; Tue, 25 Sep 2018 18:37:46 +0200 (CEST)
Date:   Tue, 25 Sep 2018 18:37:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v4 02/27] x86/fpu/xstate: Change some names to
 separate XSAVES system and user states
Message-ID: <20180925163745.GC30146@hirez.programming.kicks-ass.net>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
 <20180921150351.20898-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150351.20898-3-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:03:26AM -0700, Yu-cheng Yu wrote:

> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index a38bf5a1e37a..f1f9bf91a0ab 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -93,7 +93,8 @@ static inline void fpstate_init_xstate(struct xregs_state *xsave)
>  	 * XRSTORS requires these bits set in xcomp_bv, or it will
>  	 * trigger #GP:
>  	 */
> -	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask;
> +	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT |
> +			xfeatures_mask_user;

I would be OK with that line extending to 82 characters..

>  }
>  
>  static inline void fpstate_init_fxstate(struct fxregs_state *fx)

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 87a57b7642d3..19f8df54c72a 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c

> @@ -421,7 +421,8 @@ static void __init setup_init_fpu_buf(void)
>  	print_xstate_features();
>  
>  	if (boot_cpu_has(X86_FEATURE_XSAVES))
> -		init_fpstate.xsave.header.xcomp_bv = (u64)1 << 63 | xfeatures_mask;
> +		init_fpstate.xsave.header.xcomp_bv =
> +			BIT_ULL(63) | xfeatures_mask_user;

If you do that, the if () needs { } per coding style.

>  
>  	/*
>  	 * Init all the features state with header.xfeatures being 0x0
