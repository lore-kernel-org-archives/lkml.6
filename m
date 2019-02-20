Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1DAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291EF2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpwfPpyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfBTCht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:37:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39389 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfBTChk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:37:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so37722509otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 18:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFzS5b0xWIVmksUnz9sX1T+QW942tq/m/9lMG+5dmn0=;
        b=vpwfPpynmJcxBMsmstIQGEgVtykgaCMhH2uKhYbbLU88FhzFNESulgslXSaQCGQkvT
         gee0XZOyKXEYbsxgRrnQYQEWilm2ZjKUtGe1MoPgYmIbE8CVmGjBx0s+xbUgNkLbkEQw
         RcbyXdbG1qkQge+3yuigLEge/aA8zp+KMP6Ii5RbrWM2as0HbCQswmmTFDuwK51/eQg5
         iqdRFqQeSo7eb9pAyo4k4c5f8rm8IathWkiTlgWZKWQb6kKEddXiT9UOGoyXJDGHiOHV
         dusMx20PQuzo/puulRwuJ1E0OUbTt26aJ1a/+iuxvlJrrqjWo6EDlcVmQd6oxnja5X/I
         tnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFzS5b0xWIVmksUnz9sX1T+QW942tq/m/9lMG+5dmn0=;
        b=r+50hAOAv4k4NaCUFnjwtCMZIQDjpKNMgKhw3NxT20c6iscVX1XyE5FuF9bt1byVG9
         rjQQ0CPsc29hwIpQyYPx75oD7q8bHlTTecuvvEBDCswIWmygBiju1gV4Uo5F+MFr/kQr
         6+RMysm6Z+mEi5duA37IIsCvARu9YnMu02lG3hB3kfb++jm8QCqewXjZWk7IEsurmREw
         LptdSKZjL0Sd1lig9gb2fesW+thvsz0pki3MZbulYbbD/K/VgBV+ZcYFWuPGAJ/b/su1
         EPv01wkskVj4JF5hOBFCO+2FwbAyG4to/Mqgs6Kz/fGQ7pxRuD8SRKt4KmjRE+fx/7+j
         kgHA==
X-Gm-Message-State: AHQUAuaDt5hGYjb1wtjSBBw7tYu/vEeoIoSNL7fvxhfoV+BtEXGEHcIg
        y9NyD4z8P56P9nyk5gwXI+HBil5qq2tNQS4ZqOtYXA==
X-Google-Smtp-Source: AHgI3IaNO1zFO9qyR4NpJrv+A0JZ303RSaXeshdUFEIQH1hD+477Xr7Kt6/JYcwVnKPUiAg9mQMMyKCmV1tpnKqFH1U=
X-Received: by 2002:aca:d607:: with SMTP id n7mr4392950oig.3.1550630259430;
 Tue, 19 Feb 2019 18:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20190220005449.GA25243@beast>
In-Reply-To: <20190220005449.GA25243@beast>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Feb 2019 03:37:12 +0100
Message-ID: <CAG48ez3Kbt7oyH7wyw+d1vwNRD_b5Y+tiCOLofkxyqxcNWs8vw@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Pin sensitive CR4 bits
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 1:55 AM Kees Cook <keescook@chromium.org> wrote:
> Several recent exploits have used direct calls to the native_write_cr4()
> function to disable SMEP and SMAP before then continuing their exploits
> using userspace memory access. This pins bits of cr4 so that they cannot
> be changed through a common function. This is not intended to be general
> ROP protection (which would require CFI to defend against properly), but
> rather a way to avoid trivial direct function calling (or CFI bypassing
> via a matching function prototype) as seen in:
>
> https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html
> (https://github.com/xairy/kernel-exploits/tree/master/CVE-2017-7308)
>
> The goals of this change:
>  - pin specific bits (SMEP, SMAP, and UMIP) when writing cr4.
>  - avoid setting the bits too early (they must become pinned only after
>    first being used).
>  - pinning mask needs to be read-only during normal runtime.
>  - pinning needs to be rechecked after set to avoid jumps into the middle
>    of the function.
>
> Using __ro_after_init on the mask is done so it can't be first disabled
> with a malicious write. And since it becomes read-only, we must avoid
> writing to it later (hence the check for bits already having been set
> instead of unconditionally writing to the mask).
>
> The use of volatile is done to force the compiler to perform a full reload
> of the mask after setting cr4 (to protect against just jumping into the
> function past where the masking happens; we must check that the mask was
> applied after we do the set). Due to how this function can be built by the
> compiler (especially due to the removal of frame pointers), jumping into
> the middle of the function frequently doesn't require stack manipulation
> to construct a stack frame (there may only a retq without pops, which is
> sufficient for use with exploits like timer overwrites mentioned above).
>
> For example, without the recheck, the function may appear as:
>
>    native_write_cr4:
>       mov [pin], %rbx
>       or  %rbx, %rdi
>    1: mov %rdi, %cr4
>       retq
>
> The masking "or" could be trivially bypassed by just calling to label "1"
> instead of "native_write_cr4". (CFI will force calls to only be able to
> call into native_write_cr4, but CFI and CET are uncommon currently.)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
[...]
>  static inline void native_write_cr4(unsigned long val)
>  {
> +again:
> +       val |= cr4_pin;
>         asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
> +       /*
> +        * If the MOV above was used directly as a ROP gadget we can
> +        * notice the lack of pinned bits in "val" and start the function
> +        * from the beginning to gain the cr4_pin bits for sure.
> +        */
> +       if (WARN_ONCE(cr4_pin && (val & cr4_pin) == 0,

Don't you mean `cr4_pin && (val & cr4_pin) != cr4_pin)`?

> +                     "cr4 pin bypass attempt?!\n"))
> +               goto again;
>  }
