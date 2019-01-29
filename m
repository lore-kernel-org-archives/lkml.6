Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D232BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9389321473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dp01m6Qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfA2OAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:00:33 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37845 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfA2OAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:00:30 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so4628315iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 06:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4zcgd3Vbndg4db40jWoYorNuCcNwPTIDUnri9LlK3c=;
        b=Dp01m6QwRkjgDLFshj/dO/oyMkKJq+Z8m58tczA88pXAs0tZ799WD6d4is9oxVLK0J
         u4U8mi3P27m1qRUyosoUu4938vx3Cyn0NGVLxKuvxjR55kX+rYjiUhqYauyTXOBBFGeP
         SQFEPbuQlKtcx5wwA6lITUM8C241JFQKs4odJ7eTTJnagV0ZYArP04HJfR1UaYgoveGq
         n2SWDH5vijtsJAsgdpM92vAcQoFbiiCxQM5ievE1AVqhWZXZhkuvdvax2ZrqsdwYHK/7
         QdADaUKvTUL1igCbWl/p+aszHlkfIVcfAtv7oiiBHsGerXdw4pGb7VcrQjl/IxJF5OAR
         Hnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4zcgd3Vbndg4db40jWoYorNuCcNwPTIDUnri9LlK3c=;
        b=ReZ2Cej7bI/lQ0rIyQxHOfyCR1piBUkR3htruU5L/lvdqZ/6s6nq/kebtQDBix42/l
         zVzXOVBZLPP/o7/Sog3/Ob9utOVwbHhvK0PZqamxTYBEMow0u2oToUR8B7OVR1qwU0Sy
         I/e0kSxtOeBD6W7fp1+z8hJz88NnGf2xsAD5g9t8OQeUUm0DK5isnaMx3hEwlam6/KgX
         cki5O5mfKYAJ78EMQC0p828HUV0qj+k8f4W/xzQgUXeuZIT9mXoA2S/vF+g7L9q4LUZa
         y6LwXFv+GfySY50Crtiw/S48jXj5sXyOBy+4XoGCGjI40DWCLoLPUOVmGeFIR23S88jT
         yfhQ==
X-Gm-Message-State: AJcUukeWUgwYTwo0FkRTc5hgznYNLdUHRZ0vBroIUUhlQUmGQ00SleDg
        Fflp9lJf9ii0dK2By4x5QG9zdPijhIJBtdkBz/HXYw==
X-Google-Smtp-Source: ALg8bN6JxgAYUbzcBnXtroRi3XEoFFRAv+WZ1Bejs8L19aJFMDMkMnIh+6re9mKcQ2u4URs1GzvPPZx3NcrSazGz2vI=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr10338196iti.166.1548770429414;
 Tue, 29 Jan 2019 06:00:29 -0800 (PST)
MIME-Version: 1.0
References: <1548677377-22177-1-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1548677377-22177-1-git-send-email-elena.reshetova@intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 29 Jan 2019 15:00:18 +0100
Message-ID: <CACT4Y+aw1L7u+WJb8Ug8ED2bESfZccVK3o_7OBbjyQbQrLskbg@mail.gmail.com>
Subject: Re: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 1:10 PM Elena Reshetova
<elena.reshetova@intel.com> wrote:
>
> This adds an smp_acquire__after_ctrl_dep() barrier on successful
> decrease of refcounter value from 1 to 0 for refcount_dec(sub)_and_test
> variants and therefore gives stronger memory ordering guarantees than
> prior versions of these functions.
>
> Co-Developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> ---
>  Documentation/core-api/refcount-vs-atomic.rst | 28 +++++++++++++++++++++++----
>  arch/x86/include/asm/refcount.h               | 21 ++++++++++++++++----
>  lib/refcount.c                                | 16 ++++++++++-----
>  3 files changed, 52 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
> index 322851b..95d4b4e 100644
> --- a/Documentation/core-api/refcount-vs-atomic.rst
> +++ b/Documentation/core-api/refcount-vs-atomic.rst
> @@ -54,6 +54,14 @@ must propagate to all other CPUs before the release operation
>  (A-cumulative property). This is implemented using
>  :c:func:`smp_store_release`.
>
> +An ACQUIRE memory ordering guarantees that all post loads and
> +stores (all po-later instructions) on the same CPU are
> +completed after the acquire operation. It also guarantees that all
> +po-later stores on the same CPU and all propagated stores from other CPUs
> +must propagate to all other CPUs after the acquire operation
> +(A-cumulative property). This is implemented using
> +:c:func:`smp_acquire__after_ctrl_dep`.

The second part starting from "It also guarantees that". I am not sure
I understand what it means. Is it just a copy-paste from RELEASE? I am
not sure ACQUIRE provides anything like this.


> +
>  A control dependency (on success) for refcounters guarantees that
>  if a reference for an object was successfully obtained (reference
>  counter increment or addition happened, function returned true),
> @@ -119,24 +127,36 @@ Memory ordering guarantees changes:
>     result of obtaining pointer to the object!
>
>
> -case 5) - decrement-based RMW ops that return a value
> ------------------------------------------------------
> +case 5) - generic dec/sub decrement-based RMW ops that return a value
> +---------------------------------------------------------------------
>
>  Function changes:
>
>   * :c:func:`atomic_dec_and_test` --> :c:func:`refcount_dec_and_test`
>   * :c:func:`atomic_sub_and_test` --> :c:func:`refcount_sub_and_test`
> +
> +Memory ordering guarantees changes:
> +
> + * fully ordered --> RELEASE ordering + ACQUIRE ordering and control dependency
> +   on success.

Is ACQUIRE strictly stronger than control dependency?
It generally looks so unless there is something very subtle that I am
missing. If so, should we replace it with just "RELEASE ordering +
ACQUIRE ordering on success"? Looks simpler with less magic trickery.


> +
> +
> +case 6) other decrement-based RMW ops that return a value
> +---------------------------------------------------------
> +
> +Function changes:
> +
>   * no atomic counterpart --> :c:func:`refcount_dec_if_one`
>   * ``atomic_add_unless(&var, -1, 1)`` --> ``refcount_dec_not_one(&var)``
>
>  Memory ordering guarantees changes:
>
> - * fully ordered --> RELEASE ordering + control dependency
> + * fully ordered --> RELEASE ordering + control dependency
>
>  .. note:: :c:func:`atomic_add_unless` only provides full order on success.
>
>
> -case 6) - lock-based RMW
> +case 7) - lock-based RMW
>  ------------------------
>
>  Function changes:
> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> index dbaed55..ab8f584 100644
> --- a/arch/x86/include/asm/refcount.h
> +++ b/arch/x86/include/asm/refcount.h
> @@ -67,16 +67,29 @@ static __always_inline void refcount_dec(refcount_t *r)
>  static __always_inline __must_check
>  bool refcount_sub_and_test(unsigned int i, refcount_t *r)
>  {
> -       return GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
> +       bool ret = GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
>                                          REFCOUNT_CHECK_LT_ZERO,
>                                          r->refs.counter, e, "er", i, "cx");
> +
> +    if (ret) {
> +               smp_acquire__after_ctrl_dep();
> +               return true;
> +    }
> +
> +    return false;
>  }
>
>  static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
>  {
> -       return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> -                                       REFCOUNT_CHECK_LT_ZERO,
> -                                       r->refs.counter, e, "cx");
> +       bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> +                   REFCOUNT_CHECK_LT_ZERO,
> +                   r->refs.counter, e, "cx");
> +    if (ret) {
> +               smp_acquire__after_ctrl_dep();
> +               return true;
> +    }
> +
> +    return false;
>  }
>
>  static __always_inline __must_check
> diff --git a/lib/refcount.c b/lib/refcount.c
> index ebcf8cd..732feac 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -33,6 +33,9 @@
>   * Note that the allocator is responsible for ordering things between free()
>   * and alloc().
>   *
> + * The decrements dec_and_test() and sub_and_test() also provide acquire
> + * ordering on success.
> + *
>   */
>
>  #include <linux/mutex.h>
> @@ -164,8 +167,7 @@ EXPORT_SYMBOL(refcount_inc_checked);
>   * at UINT_MAX.
>   *
>   * Provides release memory ordering, such that prior loads and stores are done
> - * before, and provides a control dependency such that free() must come after.
> - * See the comment on top.
> + * before, and provides an acquire ordering on success such that free() must come after.
>   *
>   * Use of this function is not recommended for the normal reference counting
>   * use case in which references are taken and released one at a time.  In these
> @@ -190,7 +192,12 @@ bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
>
>         } while (!atomic_try_cmpxchg_release(&r->refs, &val, new));
>
> -       return !new;
> +    if (!new) {
> +               smp_acquire__after_ctrl_dep();
> +               return true;
> +    }
> +    return false;
> +
>  }
>  EXPORT_SYMBOL(refcount_sub_and_test_checked);
>
> @@ -202,8 +209,7 @@ EXPORT_SYMBOL(refcount_sub_and_test_checked);
>   * decrement when saturated at UINT_MAX.
>   *
>   * Provides release memory ordering, such that prior loads and stores are done
> - * before, and provides a control dependency such that free() must come after.
> - * See the comment on top.
> + * before, and provides an acquire ordering on success such that free() must come after.
>   *
>   * Return: true if the resulting refcount is 0, false otherwise
>   */
> --
> 2.7.4
>
