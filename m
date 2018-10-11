Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDEEC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236292085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWl7G1xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236292085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeJLBSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:18:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46000 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeJLBSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:18:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so10647124wrw.12;
        Thu, 11 Oct 2018 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:references:user-agent:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=X8k+9hmOEM9KuOoIZQ1aVRkb/fL0iA/UzPYpYISdSew=;
        b=bWl7G1xgeKrljaaDwWZ/RcrbnyrARqROd4tM9RUdP8HUkCRUbPnuXK3eyLcU0ZYS2J
         CqJTc7LmQ9K6BItn6efV1mSFYoTlQzwl7qVRIzvpG/iQpKek2qgZlVcvUvuwcQ7IUQrx
         bZ1XB6t5NW1VcNTstm+PdDZPfDloL8EhmwilK5aGuhsYaaA5wh/zlVO9eiLMwxafkPyc
         0pdCQgHDCU3/yKN+0JsLWOyoS34mLigjXJvdlaJFygqF0VMDwJYbhaUEDALpnUfyy0VM
         E0eB/PhO0LUSjBguQL+xTwoZelZAMXPpRbLB7seMuVjkNw/4YfvQaSgYzGHJfvuii8v2
         a8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:user-agent:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=X8k+9hmOEM9KuOoIZQ1aVRkb/fL0iA/UzPYpYISdSew=;
        b=VORoDk91GrMZsV1UkDouWtdYe/7XPnsQebjoAHrE2eP2XQIlHyVSXZyXNc4peqQBKm
         bjx/YFJPO/HLA3HHhJTAoyc5ch1cvrj4l4ayOeSXG84Yb8xUbn4XPGnybr7uxPiWiIXx
         46yFs5BG2Z5essl5sefhRP3AKPkW5fp2CZ8aYoW4x8GeWRgi8oD7bo2G3P2THEn4zokC
         NnHOjS+jOA4mjA0q3Q3jpMBHYrwTATxF+NepggzQcWyfl/5rMZRH5H6WYoG0V8xi/fHO
         wKUQnSlLSFSkUEZh4T4AGlYgNB9gpzaQc6RjT9WGFnO6sF44YTokixasZf1g2ecVOVGk
         en0w==
X-Gm-Message-State: ABuFfogOdmBu2ab1GC4ngkvjGEERgy5mFKBXm1rxvPkuMbnwVlNugmUU
        zFXxGMGhbpB0E3wwdyQgOyI=
X-Google-Smtp-Source: ACcGV62LmhSRTczzH8pMOhEWURMvgk9ctXIjrY6vk/KDCVvs0mqFYuGQ86bpS/MA93PmSQwVf2Ubkg==
X-Received: by 2002:a5d:6490:: with SMTP id r16-v6mr2301161wru.99.1539280229947;
        Thu, 11 Oct 2018 10:50:29 -0700 (PDT)
Received: from ptitpuce.local (val06-1-88-182-161-34.fbx.proxad.net. [88.182.161.34])
        by smtp.gmail.com with ESMTPSA id 195-v6sm27065073wmx.21.2018.10.11.10.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 10:50:28 -0700 (PDT)
From:   Christophe de Dinechin <christophe.de.dinechin@gmail.com>
X-Google-Original-From: Christophe de Dinechin <christophe@dinechin.org>
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-9-bigeasy@linutronix.de>
User-agent: mu4e 1.0; emacs 25.2.1
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 08/11] x86/fpu: Always store the registers in copy_fpstate_to_sigframe()
In-reply-to: <20181004140547.13014-9-bigeasy@linutronix.de>
Date:   Thu, 11 Oct 2018 19:50:23 +0200
Message-ID: <m1lg7474ps.fsf@dinechin.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sebastian Andrzej Siewior writes:

> From: Rik van Riel <riel@surriel.com>
>
> copy_fpstate_to_sigframe() has two callers and both invoke the function only if
> fpu->initialized is set.

One of the callers is in a different file.
Not sure if that warrants some kind of check that
fpu->initialized is set?

> So the check in the function for ->initialized makes
> no sense. It might be a relict from the lazy-FPU time: If the FPU
> registers

s/relict/relic/

> were "loaded" then we could save them directly. Otherwise (the FPU
> registers are not up to date) they are saved in the FPU struct and
> it could be used for memcpy().

>
> Since the registers always loaded at this point, save them and copy
> later.

register [are] always loaded

> This code is extracted from an earlier version of the patchset while
> there still was lazy-FPU on x86. This is a preparation for loading the
> FPU registers on return to userland.

maybe "only on return"?

>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h | 45 ----------------------------
>  arch/x86/kernel/fpu/signal.c        | 46 +++++++----------------------
>  2 files changed, 11 insertions(+), 80 deletions(-)
>
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 4ecaf4d22954e..df8816be3efdd 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -126,22 +126,6 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
>  		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
>  		     : output : input)
>
> -static inline int copy_fregs_to_user(struct fregs_state __user *fx)
> -{
> -	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
> -}
> -
> -static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
> -{
> -	if (IS_ENABLED(CONFIG_X86_32))
> -		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
> -	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
> -		return user_insn(fxsaveq %[fx], [fx] "=m" (*fx), "m" (*fx));
> -
> -	/* See comment in copy_fxregs_to_kernel() below. */
> -	return user_insn(rex64/fxsave (%[fx]), "=m" (*fx), [fx] "R" (fx));
> -}
> -
>  static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
>  {
>  	if (IS_ENABLED(CONFIG_X86_32)) {
> @@ -352,35 +336,6 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
>  	XSTATE_XRESTORE(xstate, lmask, hmask);
>  }
>
> -/*
> - * Save xstate to user space xsave area.
> - *
> - * We don't use modified optimization because xrstor/xrstors might track
> - * a different application.
> - *
> - * We don't use compacted format xsave area for
> - * backward compatibility for old applications which don't understand
> - * compacted format of xsave area.
> - */
> -static inline int copy_xregs_to_user(struct xregs_state __user *buf)
> -{
> -	int err;
> -
> -	/*
> -	 * Clear the xsave header first, so that reserved fields are
> -	 * initialized to zero.
> -	 */
> -	err = __clear_user(&buf->header, sizeof(buf->header));
> -	if (unlikely(err))
> -		return -EFAULT;
> -
> -	stac();
> -	XSTATE_OP(XSAVE, buf, -1, -1, err);
> -	clac();
> -
> -	return err;
> -}
> -
>  /*
>   * Restore xstate from user space xsave area.
>   */
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 23f1691670b66..c8f5ff58578ed 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -117,23 +117,6 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
>
>  	return err;
>  }
> -
> -static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
> -{
> -	int err;
> -
> -	if (use_xsave())
> -		err = copy_xregs_to_user(buf);
> -	else if (use_fxsr())
> -		err = copy_fxregs_to_user((struct fxregs_state __user *) buf);
> -	else
> -		err = copy_fregs_to_user((struct fregs_state __user *) buf);
> -
> -	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
> -		err = -EFAULT;
> -	return err;
> -}
> -
>  /*
>   * Save the fpu, extended register state to the user signal frame.
>   *

I would modify the function comment to add the new expectation that
fpu->initialized must be set on entry.

> @@ -172,27 +155,20 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
>  			sizeof(struct user_i387_ia32_struct), NULL,
>  			(struct _fpstate_32 __user *) buf) ? -1 : 1;
>
> -	if (fpu->initialized || using_compacted_format()) {
> -		/* Save the live register state to the user directly. */
> -		if (copy_fpregs_to_sigframe(buf_fx))
> -			return -1;
> -		/* Update the thread's fxstate to save the fsave header. */
> -		if (ia32_fxstate)
> -			copy_fxregs_to_kernel(fpu);
> +	/* Update the thread's fxstate to save the fsave header. */
> +	if (ia32_fxstate) {
> +		copy_fxregs_to_kernel(fpu);
>  	} else {
> -		/*
> -		 * It is a *bug* if kernel uses compacted-format for xsave
> -		 * area and we copy it out directly to a signal frame. It
> -		 * should have been handled above by saving the registers
> -		 * directly.
> -		 */
> -		if (boot_cpu_has(X86_FEATURE_XSAVES)) {
> -			WARN_ONCE(1, "x86/fpu: saving compacted-format xsave area to a signal frame!\n");
> -			return -1;
> -		}
> +		copy_fpregs_to_fpstate(fpu);
> +		fpregs_deactivate(fpu);
> +	}
>
> +	if (using_compacted_format()) {
> +		copy_xstate_to_user(buf_fx, xsave, 0, size);
> +	} else {
>  		fpstate_sanitize_xstate(fpu);
> -		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
> +		size = fpu_user_xstate_size;
> +		if (__copy_to_user(buf_fx, xsave, size))
>  			return -1;
>  	}


--
Cheers,
Christophe de Dinechin (IRC c3d)
