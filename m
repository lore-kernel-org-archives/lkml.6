Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225FAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D594A2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eWwVwzy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D594A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeLDQBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:01:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49648 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeLDQBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:01:52 -0500
Received: from zn.tnic (p200300EC2BC7BF00BC61940C2B6F1886.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:bf00:bc61:940c:2b6f:1886])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F16F1EC0229;
        Tue,  4 Dec 2018 17:01:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543939310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gp6cjwxBy7EYDhDhF+JUrl/ImlJ4usANKUTRqPLA9Nc=;
        b=eWwVwzy6AD+eVcqhvXI9JLwF0JLq+4Q0v3RPouHe7Nojq+etUQsVea4sAmLuLgXzLJSmyX
        XEXSWDXGwq5us0SzY0HMKLZM7og5FNXLrLRD8bw/53DE5KgBJX+So0ZsVe9zKPeTNsI7Hx
        kqIwrj71EJF3OR1k4Put87LhOjrCgEY=
Date:   Tue, 4 Dec 2018 17:01:45 +0100
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
Subject: Re: [RFC PATCH v6 04/26] x86/fpu/xstate: Introduce XSAVES system
 states
Message-ID: <20181204160144.GG11803@zn.tnic>
References: <20181119214809.6086-1-yu-cheng.yu@intel.com>
 <20181119214809.6086-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119214809.6086-5-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:47:47PM -0800, Yu-cheng Yu wrote:
> Control-flow Enforcement (CET) MSR contents are XSAVES system states.
> To support CET, introduce XSAVES system states first.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/fpu/internal.h |  3 +-
>  arch/x86/include/asm/fpu/xstate.h   |  4 +-
>  arch/x86/kernel/fpu/core.c          |  6 +-
>  arch/x86/kernel/fpu/init.c          | 10 ---
>  arch/x86/kernel/fpu/xstate.c        | 94 +++++++++++++++++++----------
>  5 files changed, 69 insertions(+), 48 deletions(-)

...

> @@ -704,6 +710,7 @@ static int init_xstate_size(void)
>   */
>  static void fpu__init_disable_system_xstate(void)
>  {
> +	xfeatures_mask_all = 0;
>  	xfeatures_mask_user = 0;
>  	cr4_clear_bits(X86_CR4_OSXSAVE);
>  	fpu__xstate_clear_all_cpu_caps();
> @@ -717,6 +724,8 @@ void __init fpu__init_system_xstate(void)
>  {
>  	unsigned int eax, ebx, ecx, edx;
>  	static int on_boot_cpu __initdata = 1;
> +	u64 cpu_system_xfeatures_mask;
> +	u64 cpu_user_xfeatures_mask;

So what I had in mind is to not have those local vars but use
xfeatures_mask_user and xfeatures_mask_system here directly...

>  	int err;
>  	int i;
>  
> @@ -739,10 +748,23 @@ void __init fpu__init_system_xstate(void)
>  		return;
>  	}
>  
> +	/*
> +	 * Find user states supported by the processor.
> +	 * Only these bits can be set in XCR0.
> +	 */
>  	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
> -	xfeatures_mask_user = eax + ((u64)edx << 32);
> +	cpu_user_xfeatures_mask = eax + ((u64)edx << 32);
>  
> -	if ((xfeatures_mask_user & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
> +	/*
> +	 * Find system states supported by the processor.
> +	 * Only these bits can be set in IA32_XSS MSR.
> +	 */
> +	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
> +	cpu_system_xfeatures_mask = ecx + ((u64)edx << 32);
> +
> +	xfeatures_mask_all = cpu_user_xfeatures_mask | cpu_system_xfeatures_mask;

... and not introduce xfeatures_mask_all at all but everywhere you need
all features, to do:

	(xfeatures_mask_user | xfeatures_mask_system)

and work with that.

...

> @@ -1178,7 +1208,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
>  	 * The state that came in from userspace was user-state only.
>  	 * Mask all the user states out of 'xfeatures':
>  	 */
> -	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
> +	xsave->header.xfeatures &= (xfeatures_mask_all & ~xfeatures_mask_user);

... and this would be

	xsave->header.xfeatures &= xfeatures_mask_system;

>  
>  	/*
>  	 * Add back in the features that came in from userspace:
> @@ -1234,7 +1264,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
>  	 * The state that came in from userspace was user-state only.
>  	 * Mask all the user states out of 'xfeatures':
>  	 */
> -	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
> +	xsave->header.xfeatures &= (xfeatures_mask_all & ~xfeatures_mask_user);

Ditto here.

This way you have *two* mask variables and code queries them only.

Hmmm?

Or am I missing something?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
