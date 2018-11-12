Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43873C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29D7214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29D7214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbeKLMXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:23:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:26638 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730261AbeKLMXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:23:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 18:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,493,1534834800"; 
   d="scan'208";a="85757725"
Received: from ukapaley-mobl.amr.corp.intel.com (HELO [10.251.20.219]) ([10.251.20.219])
  by fmsmga008.fm.intel.com with ESMTP; 11 Nov 2018 18:32:39 -0800
Subject: Re: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
To:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>
References: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <c6b674a9-4995-f391-772a-b256516daeab@intel.com>
Date:   Sun, 11 Nov 2018 18:32:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 9:16 AM, Aubrey Li wrote:
> XSAVES and its variants use init optimization to reduce the amount of
> data that they save to memory during context switch. Init optimization
> uses the state component bitmap to denote if a component is in its init
> configuration. We use this information to detect if a task contains AVX
> instructions.

I'm a little uncomfortable with changelogs like this.  Someone might
read this and think that this patch precisely detects AVX instructions.
 It would be great is we could make this more precise to say that this
patch detects if there is valid state in the AVX registers, *not* if the
task contains or uses AVX instructions.

>  arch/x86/include/asm/fpu/internal.h | 97 +++++++++++++++++++++++++++----------
>  arch/x86/include/asm/fpu/types.h    | 17 +++++++
>  2 files changed, 88 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index a38bf5a..b0519f4 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -74,6 +74,12 @@ static __always_inline __pure bool use_fxsr(void)
>  	return static_cpu_has(X86_FEATURE_FXSR);
>  }
>  
> +static __always_inline __pure bool use_xgetbv1(void)
> +{
> +	return static_cpu_has(X86_FEATURE_OSXSAVE) &&
> +		static_cpu_has(X86_FEATURE_XGETBV1);
> +}
> +
>  /*
>   * fpstate handling functions:
>   */
> @@ -103,6 +109,34 @@ static inline void fpstate_init_fxstate(struct fxregs_state *fx)
>  }
>  extern void fpstate_sanitize_xstate(struct fpu *fpu);
>  
> +/*
> + * MXCSR and XCR definitions:
> + */
> +
> +extern unsigned int mxcsr_feature_mask;
> +
> +#define	XCR_XFEATURE_ENABLED_MASK	0x00000000
> +#define	XINUSE_STATE_BITMAP_INDEX	0x00000001
> +
> +static inline u64 xgetbv(u32 index)
> +{
> +	u32 eax, edx;
> +
> +	asm volatile(".byte 0x0f,0x01,0xd0" /* xgetbv */
> +		     : "=a" (eax), "=d" (edx)
> +		     : "c" (index));
> +	return eax + ((u64)edx << 32);
> +}
> +
> +static inline void xsetbv(u32 index, u64 value)
> +{
> +	u32 eax = value;
> +	u32 edx = value >> 32;
> +
> +	asm volatile(".byte 0x0f,0x01,0xd1" /* xsetbv */
> +		     : : "a" (eax), "d" (edx), "c" (index));
> +}
> +
>  #define user_insn(insn, output, input...)				\
>  ({									\
>  	int err;							\
> @@ -275,6 +309,42 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
>  		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
>  		     : "memory")
>  
> +#define	AVX_STATE_DECAY_COUNT	3

How was this number chosen?  What does this mean?

It appears that this is saying that after 3 non-AVX-512-using context
switches, the task is not considered to be using AVX512 any more.  That
seems a bit goofy because the context switch rate is highly dependent on
HZ, and on how often the task yields.

Do we want this, or do we want something more time-based?

> +/*
> + * This function is called during context switch to update AVX component state
> + */
> +static inline void update_avx_state(struct avx_state *avx)
> +{
> +	/*
> +	 * Check if XGETBV with ECX = 1 supported. XGETBV with ECX = 1
> +	 * returns the logical-AND of XCR0 and XINUSE. XINUSE is a bitmap
> +	 * by which the processor tracks the status of various components.
> +	 */
> +	if (!use_xgetbv1()) {
> +		avx->state = 0;
> +		return;
> +	}

This is a place where we have conflated the implementation in the CPU
and the logical operation that we are performing.

In this case, it appears that we want to know whether AVX state
detection is available, but we're doing that with a function that's
apparently asking if the kernel is using XGETBV1.

I'd really like if this looked like this:

	if (!have_avx_state_detect()) {
		avx->state = 0;
		return;
	}

Then, in have_avx_state_detect(), explain what XGETBV1 does.  BTW, I
don't think we *totally* need to duplicate the SDM definitions in kernel
code for each instruction.  It's fine to just say that it set 1 for
features not in the init state.

> +	/*
> +	 * XINUSE is dynamic to track component state because VZEROUPPER
> +	 * happens on every function end and reset the bitmap to the
> +	 * initial configuration.

This is confusing to me because VZEROUPPER is not apparently involved
here.  What is this trying to say?

> +	 * State decay is introduced to solve the race condition between
> +	 * context switch and a function end. State is aggressively set
> +	 * once it's detected but need to be cleared by decay 3 context
> +	 * switches
> +	 */

I'd probably say:

	AVX512-using processes frequently set AVX512 back to the init 	
	state themselves.  Thus, this detection mechanism can miss.
	The decay ensures that false-negatives do not immediately make
	a task be considered as not using AVX512.

> +	if (xgetbv(XINUSE_STATE_BITMAP_INDEX) & XFEATURE_MASK_Hi16_ZMM) {

This is *just* an AVX512 state, right?  That isn't reflected in any
comments or naming.  Also, why just this state, and not any of the other
AVX512-related states?

This is also precisely the kind of thing that would be nice to wrap up
in a tiny helper.

	if (avx512_in_use())

is much more self-documenting, for instance.

> +		avx->state = 1;

I'm not a huge fan of this naming.  Could this be:

		avx->had_avx_512_state = true;

> +		avx->decay_count = AVX_STATE_DECAY_COUNT;
> +	} else {
> +		if (avx->decay_count)
> +			avx->decay_count--;
> +		else
> +			avx->state = 0;
> +	}
> +}

This all needs a bunch more commenting.  The state transitions are not
horribly clear.

>  /*
>   * This function is called only during boot time when x86 caps are not set
>   * up and alternative can not be used yet.
> @@ -411,6 +481,7 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
>  {
>  	if (likely(use_xsave())) {
>  		copy_xregs_to_kernel(&	);
> +		update_avx_state(&fpu->avx);
>  		return 1;
>  	}

I'm not sure why update_avx_state() goes to the trouble of calling
XGETBV1.  I believe the exact same state is captured in the 'xfeatures'
field in the XSAVE buffer after copy_xregs_to_kernel().  Why bother
calling the instruction when you can get the data from memory?

>  /*
> + * This is per task AVX state data structure that indicates
> + * whether the task uses AVX instructions.
> + */

Here's another spot that doesn't precisely capture how his detection
mechanism works.

> +struct avx_state {
> +	unsigned int			state;

Isn't state a 0/1 thing?

> +	unsigned int			decay_count;
> +};

Doesn't this max out at 3?

Seems like we're storing about three bits of data in 64 bits of space.
Not a huge deal, but I think we can do better?

Also, do we really even need 'state'?

When would its value be different than

	fpu->state.xsave.xfeatures & XFEATURE_MASK_Hi16_ZMM

> +/*
>   * Highest level per task FPU state data structure that
>   * contains the FPU register state plus various FPU
>   * state fields:
> @@ -303,6 +312,14 @@ struct fpu {
>  	unsigned char			initialized;
>  
>  	/*
> +	 * @avx_state:
> +	 *
> +	 * This data structure indicates whether this context
> +	 * contains AVX states
> +	 */

Yeah, that's precisely what fpu->state.xsave.xfeatures does. :)
