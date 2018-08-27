Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6570C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5FB208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lrB5h4i2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5FB208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH1AuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:50:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33175 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH1AuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:50:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id 60-v6so149288ple.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHsJhpH8yi6LYKXdGfv7SX1vxH/+vzTAGIg8HnDNG7k=;
        b=lrB5h4i28mhLY0n9fazdo2kFHOve6FmTGUMNADCpzLtSzn4/AvOvN7g0gwMKMxKcIX
         8d8AnP/mEU1sYeBE5fxHuzssYH/5Dd6KospWRSqxowYhc/pUQP9Wj9pWH//1TB10H3oe
         79tNTfPqvwlCoA8fmayMe8/4p7S9hLUUxnAANFpWBPfgOt0uuLrRM61J8DXUSb+YZohy
         CjN/o7D2TjvAt/B0cv+cgJdQjv8OzQ7Vlh88GJ+h0U/Mv2Toaffc2a+fiPIylkrDyfWA
         PeZqtPofEiMo0MJQECcqsPrlNLidEFIZMb72EPUJAzu1gTyGleplGap0DFeuLg0G9fMZ
         zBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHsJhpH8yi6LYKXdGfv7SX1vxH/+vzTAGIg8HnDNG7k=;
        b=T2L4zagFwVdtx4mJRflTr3SLrOATC7j82jn5fUTKHNW4V+wPjTYUKFWY0wBmxUl9/z
         eX103fA/W24FMXEznTX8fAqfHVp+6rMIHkM7Dz9ceiu4vZasFBqEVXqjyjQxbtj0gjVs
         ABRVDbnRJFfXMDHne4rmttqovZ6nUKbOF38Gw/2iju2BeoisPD46IZJQnrIvSrct0sO8
         BItFJtrW2WH5tNkrNlsb8LHJnVCl1hHUqVzJ3ChHmGdA0eSLpoN+iMqhUENXOYrPDqe3
         KTh7USDfo8rPh1E45ImmAAlLd3HrI9gkNnls3FP1v2BoBZFdfzyUpgVFgtH4nOgq3bJy
         dYgw==
X-Gm-Message-State: APzg51D2Et5iXfxOzBo7dsxjqCr8sStpiRsjeVPGutlifQF96GGTSkJV
        nXoXmB/4zgtP1EjJcbYdbxyoNN8KKGzzyLqhiEzkag==
X-Google-Smtp-Source: ANB0VdaRrE8r1QZp5z83pkGUKlLi/b8pQ0WkDENY87AC9My9Brxifg5pdkE5DCkUA7e+55gsOQcYfProWUxuXM+6Tiw=
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3-v6mr14562935plz.238.1535403707572;
 Mon, 27 Aug 2018 14:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com>
In-Reply-To: <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 27 Aug 2018 14:01:36 -0700
Message-ID: <CAKwvOdko=t=wBsiwwMaWOLuir09jLi-r_oyr=1q-HRsi=-DjoA@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     daniel.santos@pobox.com
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, sparse@chrisli.org,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 1:42 PM Daniel Santos <daniel.santos@pobox.com> wrote:
>
> Hello Nick,
>
> On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
> >> Now we're back to the question of "what do you mean by 'constant'"?  If
> >> you mean a C constant expression (as defined in the C standard) than
> >> almost none of this code fits that criteria.  For these compile-time
> >> assertions to work, we are concerned with the data flow analysis and
> >> constant propagation performed by the compiler during optimization.  You
> >> will notice in include/linux/compiler.h that __compiletime_assert is a
> >> no-op when __OPTIMIZE__ is not defined.
> > Depending on optimizations for static assertions sounds problematic.
>
> (with my best Palpatine voice) It is unavoidable.

LOL

>
> Actually it's theoretically possible, but the compiler would have to do
> something akin to copying it's control flow graph et. al, run -O2-ish
> optimizations, perform the static assertions and then throw away the
> optimized control flow graph and emit code based upon the original.
>
>
> >>> As the comment in <linux/build_bug.h>
> >>> says, GCC (and Clang as well) only emits the error for obvious cases.
> >>>
> >>> When '__cond' is a variable,
> >>>
> >>>     ((void)sizeof(char[1 - 2 * __cond]))
> >>>
> >>> ... is not obvious for the compiler to know the array size is negative.
> >>>
> >>> Reverting that commit would break BUILD_BUG() because negative-size-array
> >>> is evaluated before the code is optimized out.
> >>>
> >>> Let's give up __compiletime_assert_fallback().  This commit does not
> >>> change the current behavior since it just rips off the useless code.
> >> Clang is not the only target audience of
> >> __compiletime_assert_fallback().  Instead of ripping out something that
> >> may benefit builds with gcc 4.2 and earlier, why not override its
> > Note that with commit cafa0010cd51 ("Raise the minimum required gcc
> > version to 4.6") that gcc < 4.6 is irrelevant.
>
> Ah, I guess I'm not keeping up, that's wonderful news!  Considering that
> I guess I would be OK with its removal, but I still think it would be
> better if a similar mechanism to break the Clang build could be found.
>
> >> definition in compiler-clang.h with something that will break the build
> >> for Clang?  It would need an #ifndef __compiletime_error_fallback here
> >> though.
> >>
> >>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>> Reviewed-by: Kees Cook <keescook@chromium.org>
> >>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >>> ---
> >>>
> >>> Changes in v2:
> >>>   - Rebase
> >>>
> >>>  include/linux/compiler.h | 17 +----------------
> >>>  1 file changed, 1 insertion(+), 16 deletions(-)
> >>>
> >>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> >>> index 681d866..87c776c 100644
> >>> --- a/include/linux/compiler.h
> >>> +++ b/include/linux/compiler.h
> >>> @@ -314,29 +314,14 @@ static inline void *offset_to_ptr(const int *off)
> >>>  #endif
> >>>  #ifndef __compiletime_error
> >>>  # define __compiletime_error(message)
> >>> -/*
> >>> - * Sparse complains of variable sized arrays due to the temporary variable in
> >>> - * __compiletime_assert. Unfortunately we can't just expand it out to make
> >>> - * sparse see a constant array size without breaking compiletime_assert on old
> >>> - * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
> >>> - */
> >>> -# ifndef __CHECKER__
> >>> -#  define __compiletime_error_fallback(condition) \
> >>> -     do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
> >>> -# endif
> >>> -#endif
> >>> -#ifndef __compiletime_error_fallback
> >>> -# define __compiletime_error_fallback(condition) do { } while (0)
> >>>  #endif
> >>>
> >>>  #ifdef __OPTIMIZE__
> >>>  # define __compiletime_assert(condition, msg, prefix, suffix)                \
> >>>       do {                                                            \
> >>> -             int __cond = !(condition);                              \
> >>>               extern void prefix ## suffix(void) __compiletime_error(msg); \
> >>> -             if (__cond)                                             \
> >>> +             if (!(condition))                                       \
> >>>                       prefix ## suffix();                             \
> >>> -             __compiletime_error_fallback(__cond);                   \
> >>>       } while (0)
> >>>  #else
> >>>  # define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
> >> To give any more meaningful feedback I think I will need to experiment
> >> with Clang, older GCC versions and icc.  It occurred to me that I should
> >> probably clean up and publish my __builtin_constant_p test program and
> >> also generate results for more recent compilers.  I can extend it to
> >> test various negative sized array constructs and it could help inform
> >> this decision.
> >>
> >> IMO, the most ideal solution would be a set of C2x (or future)
> >> extensions providing something similar to C++'s constexpr, GCC's
> >> __builtin_constant_p and our BUILD_BUG_ON.  This would cross deeply into
> > Note that __builtin_constant_p is a wild beast with lots of edge
> > cases, and dependencies on compiler and optimization level.  I'm
> > trying to sort out some of these differences right now with llvm
> > developers.
>
> Yes it is.  IIRC, I even found cases where __builtin_constant_p returned
> false, but the emitted code replaced the value in question with a
> constant.  So at least at one point, constant propagation and
> __builtin_constant_p weren't always entirely coherent.

What?! Do you have a link to a repro on godbolt or a gcc bugreport?

Here's a different case I found that looks problematic:
https://godbolt.org/z/g_iqwh

>
> I was working on a GCC extension that would solve this problem earlier
> this year but bills and paying work interrupted me. :)  The solution
> involved adding a "const" attribute for function parameters and
> variables that would simply create a warning or error if the value
> wasn't compiled away at the time middle-end optimizations completed and
> RTL emitted.  It isn't finished -- maybe for gcc10.
>

Speaking with a coworker internally now, discussing Clang's
diagnose_if/enable_if attributes.  It seems that _Static_assert always
(between compilers) considers parameters non-ICE, which sounds like a
defect to me.

-- 
Thanks,
~Nick Desaulniers
