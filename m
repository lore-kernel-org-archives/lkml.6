Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ABBC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2A92416F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Sc2f4D+2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sm2ZG0VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2A92416F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934495AbeGCSam (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:30:42 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39684 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934398AbeGCSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:30:40 -0400
Received: by mail-yb0-f195.google.com with SMTP id k127-v6so1106523ybk.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 11:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=A4gErQwcovPGwZT4gEAa3Li39AJAsoNTKFl4QcwkCGU=;
        b=Sc2f4D+228sbBmzq+o8EYImXL6ie5t7o8aYerTH6bZtpyaJrGnauvFm/1taIz3zJKP
         ClxnjPHS8a+AtHhhaV7OEq8VHgmYNsmjN3kPvI8wYQ0m8EOgRv6bYhAHIaxy0oKtuf8F
         b80R4fp23OUxDq9b5oM63DIACSsO0rY2Td7/h25I9vIDVetrW6/EDCiZPPQFs9JekwUs
         ZlzzuTcNRB+n/8w7JHd4CWOtw9sqZ+B/ANUdGjAuok9weuVArD4haVRex+ZNS9QbSmLc
         KKRzR+/849b59dYQjJXzpXtG18sP68PWk0H1987Eu0r/VNzZet+YjTvG5CVJbzWfYh+r
         WbYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=A4gErQwcovPGwZT4gEAa3Li39AJAsoNTKFl4QcwkCGU=;
        b=Sm2ZG0VSDqcLdggj6//2ZJOUoMiHyLOL+EWQIIu0V4hC15dO+DAIz6rxtA9t114eEo
         ossiZ4WQy3wj9h+8lpx7lsu1QkUqeb7fVxb4gIFxNlaHfEWFlvj4r2+W8wC/RqkePCtT
         zAsR1LKMKl9Tua04v1BTwzD+Mi7Y7o0RyMcNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=A4gErQwcovPGwZT4gEAa3Li39AJAsoNTKFl4QcwkCGU=;
        b=eVGDMH2+yo2Pi+fvby+W6LFsqBmDjJVxYOFItZWoD5sV6Bsa9D2R9gFDf+JgjNFxfX
         R6PhqfJkZ7sVAzhk1AZndAa9YVcdS9uga+CjdSzIxzacH/FGtNCMWnTaFTkJ6QyqDEXH
         I8j3EMQd9TjhHvDAfhNeBMSaSRFCBsunXKlpU62xDeGmnoFgTjoTareQoRZCjDkzORry
         QQ1wk5vi/dulAj3/u0dlCzmmtsQxT6GBct6ece2JT4xOx/pDQNR0Yk7bJRgfeXgBvudG
         Hf7I+SpAy9puLlcisNPIQMkHwWrxuEaYryBxUVqfG7biy1S2AxxRIrrBgk3uFse2J8tT
         aVSQ==
X-Gm-Message-State: APt69E1X8VYBDjwYSpYDfLAIsFxRvxVuziwWVbVWzQLjlB8AHhrPn7ni
        PPAXBk5uNIxbrWk9gsx466kdO9M2EVU3QGKRcg3Gjg==
X-Google-Smtp-Source: ADUXVKIf89mkMmKHSeLKPHDv5WbGRSp7uaN+3qDaVJ1Ee78Tc+0Ok3+VKJlnzydNBrjOoKpz0KtnMHd0LPkAjGVHEHw=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr16338640ybi.193.1530642639140;
 Tue, 03 Jul 2018 11:30:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 11:30:38 -0700 (PDT)
In-Reply-To: <20180703100102.16615-1-mark.rutland@arm.com>
References: <20180703100102.16615-1-mark.rutland@arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 3 Jul 2018 11:30:38 -0700
X-Google-Sender-Auth: 42PCM3IB1fvRqcz2zyUSS_uWffQ
Message-ID: <CAGXu5jLATGcq_mgetUurBriCaPmBQmBwxVW7aa9fAKM2XeSjHw@mail.gmail.com>
Subject: Re: [PATCH] refcount: always allow checked forms
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 3:01 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> In many cases, it would be useful to be able to use the full
> sanity-checked refcount helpers regardless of CONFIG_REFCOUNT_FULL, as
> this would help to avoid duplicate warnings where callers try to
> sanity-check refcount manipulation.
>
> This patch refactors things such that the full refcount helpers were
> always built, as refcount_${op}_checked(), such that they can be used
> regardless of CONFIG_REFCOUNT_FULL. This will allow code which *always*
> wants a checked refcount to opt-in, avoiding the need to duplicate the
> logic for warnings.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>

Looks good to me! Thanks for doing this. :)

Acked-by: Kees Cook <keescook@chromium.org>

> ---
>  include/linux/refcount.h | 27 +++++++++++++++++-------
>  lib/refcount.c           | 53 +++++++++++++++++++++++-------------------------
>  2 files changed, 45 insertions(+), 35 deletions(-)
>
> Dave pointed out that it would be useful to be able to opt-in to full checks
> regardless of CONFIG_REFCOUNT_FULL, so that we can simplify callsites where we
> always want checks. I've spotted a few of these in code which is still awaiting
> conversion.

Yeah, I need to go through the cocci output -- Elena had several
outstanding patches that never got picked up.

> I'm assuming that the atomics group is intended to own the refcount code, even
> though this isn't currently the case in MAINTAINERS.

That's how it has landed in the past, yes, but if there is a
dependency on these for code that will use it, maybe it should go that
way?

-Kees

>
> Mark.
>
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index a685da2c4522..b505f75ccf68 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -42,17 +42,30 @@ static inline unsigned int refcount_read(const refcount_t *r)
>         return atomic_read(&r->refs);
>  }
>
> +extern __must_check bool refcount_add_not_zero_checked(unsigned int i, refcount_t *r);
> +extern void refcount_add_checked(unsigned int i, refcount_t *r);
> +
> +extern __must_check bool refcount_inc_not_zero_checked(refcount_t *r);
> +extern void refcount_inc_checked(refcount_t *r);
> +
> +extern __must_check bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r);
> +
> +extern __must_check bool refcount_dec_and_test_checked(refcount_t *r);
> +extern void refcount_dec_checked(refcount_t *r);
> +
>  #ifdef CONFIG_REFCOUNT_FULL
> -extern __must_check bool refcount_add_not_zero(unsigned int i, refcount_t *r);
> -extern void refcount_add(unsigned int i, refcount_t *r);
>
> -extern __must_check bool refcount_inc_not_zero(refcount_t *r);
> -extern void refcount_inc(refcount_t *r);
> +#define refcount_add_not_zero  refcount_add_not_zero_checked
> +#define refcount_add           refcount_add_checked
> +
> +#define refcount_inc_not_zero  refcount_inc_not_zero_checked
> +#define refcount_inc           refcount_inc_checked
> +
> +#define refcount_sub_and_test  refcount_sub_and_test_checked
>
> -extern __must_check bool refcount_sub_and_test(unsigned int i, refcount_t *r);
> +#define refcount_dec_and_test  refcount_dec_and_test_checked
> +#define refcount_dec           refcount_dec_checked
>
> -extern __must_check bool refcount_dec_and_test(refcount_t *r);
> -extern void refcount_dec(refcount_t *r);
>  #else
>  # ifdef CONFIG_ARCH_HAS_REFCOUNT
>  #  include <asm/refcount.h>
> diff --git a/lib/refcount.c b/lib/refcount.c
> index d3b81cefce91..3d514f915999 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -38,10 +38,8 @@
>  #include <linux/refcount.h>
>  #include <linux/bug.h>
>
> -#ifdef CONFIG_REFCOUNT_FULL
> -
>  /**
> - * refcount_add_not_zero - add a value to a refcount unless it is 0
> + * refcount_add_not_zero_checked - add a value to a refcount unless it is 0
>   * @i: the value to add to the refcount
>   * @r: the refcount
>   *
> @@ -58,7 +56,7 @@
>   *
>   * Return: false if the passed refcount is 0, true otherwise
>   */
> -bool refcount_add_not_zero(unsigned int i, refcount_t *r)
> +bool refcount_add_not_zero_checked(unsigned int i, refcount_t *r)
>  {
>         unsigned int new, val = atomic_read(&r->refs);
>
> @@ -79,10 +77,10 @@ bool refcount_add_not_zero(unsigned int i, refcount_t *r)
>
>         return true;
>  }
> -EXPORT_SYMBOL(refcount_add_not_zero);
> +EXPORT_SYMBOL(refcount_add_not_zero_checked);
>
>  /**
> - * refcount_add - add a value to a refcount
> + * refcount_add_checked - add a value to a refcount
>   * @i: the value to add to the refcount
>   * @r: the refcount
>   *
> @@ -97,14 +95,14 @@ EXPORT_SYMBOL(refcount_add_not_zero);
>   * cases, refcount_inc(), or one of its variants, should instead be used to
>   * increment a reference count.
>   */
> -void refcount_add(unsigned int i, refcount_t *r)
> +void refcount_add_checked(unsigned int i, refcount_t *r)
>  {
> -       WARN_ONCE(!refcount_add_not_zero(i, r), "refcount_t: addition on 0; use-after-free.\n");
> +       WARN_ONCE(!refcount_add_not_zero_checked(i, r), "refcount_t: addition on 0; use-after-free.\n");
>  }
> -EXPORT_SYMBOL(refcount_add);
> +EXPORT_SYMBOL(refcount_add_checked);
>
>  /**
> - * refcount_inc_not_zero - increment a refcount unless it is 0
> + * refcount_inc_not_zero_checked - increment a refcount unless it is 0
>   * @r: the refcount to increment
>   *
>   * Similar to atomic_inc_not_zero(), but will saturate at UINT_MAX and WARN.
> @@ -115,7 +113,7 @@ EXPORT_SYMBOL(refcount_add);
>   *
>   * Return: true if the increment was successful, false otherwise
>   */
> -bool refcount_inc_not_zero(refcount_t *r)
> +bool refcount_inc_not_zero_checked(refcount_t *r)
>  {
>         unsigned int new, val = atomic_read(&r->refs);
>
> @@ -134,10 +132,10 @@ bool refcount_inc_not_zero(refcount_t *r)
>
>         return true;
>  }
> -EXPORT_SYMBOL(refcount_inc_not_zero);
> +EXPORT_SYMBOL(refcount_inc_not_zero_checked);
>
>  /**
> - * refcount_inc - increment a refcount
> + * refcount_inc_checked - increment a refcount
>   * @r: the refcount to increment
>   *
>   * Similar to atomic_inc(), but will saturate at UINT_MAX and WARN.
> @@ -148,14 +146,14 @@ EXPORT_SYMBOL(refcount_inc_not_zero);
>   * Will WARN if the refcount is 0, as this represents a possible use-after-free
>   * condition.
>   */
> -void refcount_inc(refcount_t *r)
> +void refcount_inc_chcked(refcount_t *r)
>  {
> -       WARN_ONCE(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
> +       WARN_ONCE(!refcount_inc_not_zero_checked(r), "refcount_t: increment on 0; use-after-free.\n");
>  }
> -EXPORT_SYMBOL(refcount_inc);
> +EXPORT_SYMBOL(refcount_inc_checked);
>
>  /**
> - * refcount_sub_and_test - subtract from a refcount and test if it is 0
> + * refcount_sub_and_test_checked - subtract from a refcount and test if it is 0
>   * @i: amount to subtract from the refcount
>   * @r: the refcount
>   *
> @@ -174,7 +172,7 @@ EXPORT_SYMBOL(refcount_inc);
>   *
>   * Return: true if the resulting refcount is 0, false otherwise
>   */
> -bool refcount_sub_and_test(unsigned int i, refcount_t *r)
> +bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
>  {
>         unsigned int new, val = atomic_read(&r->refs);
>
> @@ -192,10 +190,10 @@ bool refcount_sub_and_test(unsigned int i, refcount_t *r)
>
>         return !new;
>  }
> -EXPORT_SYMBOL(refcount_sub_and_test);
> +EXPORT_SYMBOL(refcount_sub_and_test_checked);
>
>  /**
> - * refcount_dec_and_test - decrement a refcount and test if it is 0
> + * refcount_dec_and_test_checked - decrement a refcount and test if it is 0
>   * @r: the refcount
>   *
>   * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
> @@ -207,14 +205,14 @@ EXPORT_SYMBOL(refcount_sub_and_test);
>   *
>   * Return: true if the resulting refcount is 0, false otherwise
>   */
> -bool refcount_dec_and_test(refcount_t *r)
> +bool refcount_dec_and_test_checked(refcount_t *r)
>  {
> -       return refcount_sub_and_test(1, r);
> +       return refcount_sub_and_test_checked(1, r);
>  }
> -EXPORT_SYMBOL(refcount_dec_and_test);
> +EXPORT_SYMBOL(refcount_dec_and_test_checked);
>
>  /**
> - * refcount_dec - decrement a refcount
> + * refcount_dec_checked - decrement a refcount
>   * @r: the refcount
>   *
>   * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
> @@ -223,12 +221,11 @@ EXPORT_SYMBOL(refcount_dec_and_test);
>   * Provides release memory ordering, such that prior loads and stores are done
>   * before.
>   */
> -void refcount_dec(refcount_t *r)
> +void refcount_dec_checked(refcount_t *r)
>  {
> -       WARN_ONCE(refcount_dec_and_test(r), "refcount_t: decrement hit 0; leaking memory.\n");
> +       WARN_ONCE(refcount_dec_and_test_checked(r), "refcount_t: decrement hit 0; leaking memory.\n");
>  }
> -EXPORT_SYMBOL(refcount_dec);
> -#endif /* CONFIG_REFCOUNT_FULL */
> +EXPORT_SYMBOL(refcount_dec_checked);
>
>  /**
>   * refcount_dec_if_one - decrement a refcount if it is 1
> --
> 2.11.0
>



-- 
Kees Cook
Pixel Security
