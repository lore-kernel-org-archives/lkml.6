Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FA2ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD54214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD54214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJQShK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:37:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45772 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbeJQShK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:37:10 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ijdcz5t17VPH; Wed, 17 Oct 2018 12:41:44 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC91B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:1b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D1C21EC0104;
        Wed, 17 Oct 2018 12:41:44 +0200 (CEST)
Date:   Wed, 17 Oct 2018 12:41:37 +0200
From:   Borislav Petkov <bp@alien8.de>
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
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v5 03/27] x86/fpu/xstate: Introduce XSAVES system states
Message-ID: <20181017104137.GE22535@zn.tnic>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181011151523.27101-4-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:14:59AM -0700, Yu-cheng Yu wrote:
> Control Flow Enforcement (CET) MSRs are XSAVES system states.

That sentence needs massaging. MSRs are system states?!?!

> To support CET, we introduce XSAVES system states first.

Pls drop the "we" in all commit messages and convert the tone to
impartial and passive.

Also, this commit message needs to explain *why* you're doing this - it
is too laconic.

> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/fpu/internal.h |  3 +-
>  arch/x86/include/asm/fpu/xstate.h   |  4 +-
>  arch/x86/kernel/fpu/core.c          |  6 +-
>  arch/x86/kernel/fpu/init.c          | 10 ----
>  arch/x86/kernel/fpu/xstate.c        | 86 ++++++++++++++++++-----------
>  5 files changed, 62 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 02c4296478c8..9a5db5a63f60 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -45,7 +45,6 @@ extern void fpu__init_cpu_xstate(void);
>  extern void fpu__init_system(struct cpuinfo_x86 *c);
>  extern void fpu__init_check_bugs(void);
>  extern void fpu__resume_cpu(void);
> -extern u64 fpu__get_supported_xfeatures_mask(void);
>  
>  /*
>   * Debugging facility:
> @@ -93,7 +92,7 @@ static inline void fpstate_init_xstate(struct xregs_state *xsave)
>  	 * XRSTORS requires these bits set in xcomp_bv, or it will
>  	 * trigger #GP:
>  	 */
> -	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_user;
> +	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
>  }
>  
>  static inline void fpstate_init_fxstate(struct fxregs_state *fx)
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 76f83d2ac10e..d8e2ec99f635 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -19,9 +19,6 @@
>  #define XSAVE_YMM_SIZE	    256
>  #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
>  
> -/* Supervisor features */
> -#define XFEATURE_MASK_SUPERVISOR (XFEATURE_MASK_PT)
> -
>  /* All currently supported features */
>  #define SUPPORTED_XFEATURES_MASK (XFEATURE_MASK_FP | \
>  				  XFEATURE_MASK_SSE | \
> @@ -40,6 +37,7 @@
>  #endif
>  
>  extern u64 xfeatures_mask_user;
> +extern u64 xfeatures_mask_all;

You have a bunch of places where you generate the system mask by doing
~xfeatures_mask_user.

Why not define

	xfeatures_mask_system

instead and generate the _all mask at the places you need it by doing

	xfeatures_mask_user | xfeatures_mask_system

?

We are differentiating user and system states now so it is only logical
to have that mirrored in the variables, right?

You even do that in fpu__init_system_xstate().

...

> @@ -225,20 +230,19 @@ void fpu__init_cpu_xstate(void)
>  	 * set here.
>  	 */
>  
> -	xfeatures_mask_user &= ~XFEATURE_MASK_SUPERVISOR;
> -
>  	cr4_set_bits(X86_CR4_OSXSAVE);
>  	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user);

<---- newline here.

> +	/*
> +	 * MSR_IA32_XSS sets which XSAVES system states to be managed by

Improve:

"MSR_IA32_XSS controls which system (not user) states are going to be
managed by XSAVES."

> @@ -702,6 +703,7 @@ static int init_xstate_size(void)
>   */
>  static void fpu__init_disable_system_xstate(void)
>  {
> +	xfeatures_mask_all = 0;
>  	xfeatures_mask_user = 0;
>  	cr4_clear_bits(X86_CR4_OSXSAVE);
>  	fpu__xstate_clear_all_cpu_caps();
> @@ -717,6 +719,8 @@ void __init fpu__init_system_xstate(void)
>  	static int on_boot_cpu __initdata = 1;
>  	int err;
>  	int i;
> +	u64 cpu_user_xfeatures_mask;
> +	u64 cpu_system_xfeatures_mask;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type> longest_variable_name;
	<type> shorter_var_name;
	<type> even_shorter;
	<type> i;

>  
>  	WARN_ON_FPU(!on_boot_cpu);
>  	on_boot_cpu = 0;

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
