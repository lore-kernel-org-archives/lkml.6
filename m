Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B3C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 20:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9278620C0B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 20:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQwG77BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9278620C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeHSXiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 19:38:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34239 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeHSXiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 19:38:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so5754245pgv.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 13:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plJTYoRDVLnZSBycfgbG5/NLr145Ynmr8vbtse3A2RU=;
        b=mQwG77BOUqq6+XdO+PmQNWhCF8Spnb9h4z0eO/fwx462mcSla/U7XVTpZu66MsIYd5
         drjXoExRYP6n6Cd40rhKT6ya8s1Xa/KtgmWyAdfw3gicUBW8SLIswpKXl74gyrdql5EX
         KHRNzFK6jpEzSfyNcDT7OHQ0B2SCqL7eKg2RoRNOnNNOG79x36EIy7+JayejZ0EJadZz
         WhGz3TuUk2SIW1nUgEVdVnbulefChgykKByAogrj1yeBpN59QZWry84yIMSt2mDEvqYM
         1RFmQsfgzUYrRFuw4mUscfBoHShPDnjbeMddqXtYbNkVd38iZ5jdFaqqrpyd5u6nUu65
         VeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plJTYoRDVLnZSBycfgbG5/NLr145Ynmr8vbtse3A2RU=;
        b=UnjyKpTg3NSHTGqF/U3JhbD8Rdw76RjSLuCC0nlCn/l+kZnuRQmZM220NQgOZ/DWwQ
         NGdrAaxsEZlI6TnGdbs/iQ3xwweMhl8zbv8lJHqIyx3iaEs+nKEhBDEjoEXu2VZHfzfY
         jVimPYJlVn6C4Liu4eC4kC4WgmKZmPIdXysZEVzDu2aXHvVEpv745qoA1Df1sFt/vVkm
         TdaCzo7/wvzGOM/4cQVOP8FCMQhq8BI0YmXHOxKbHmXUDf3P5lQ882YbZVcqNVAZoqx4
         mMK5J29C0qNF1yLr+cAo4n01DCb3FznH3hUd0ecrc4IK/Tm2upK4ARNcT74annvONllX
         KZvg==
X-Gm-Message-State: AOUpUlEFAJL13HmFINJYshaAWLkBG3nkL6n/IRNpx+FFXPgrPkfy81Hv
        sUpqJJlRnW48cLccYQUWCzSDWfO1sFKoKKgaJjNaLg==
X-Google-Smtp-Source: AA+uWPySS/wVGHmHp3/dlnzjKeupl8qP7TYQ+hC+06inPEFoXqZU3NwEtw2z95/tNBKhdiG1w55G8GLrBTS17EZQXX4=
X-Received: by 2002:a63:28c1:: with SMTP id o184-v6mr39909345pgo.225.1534710324849;
 Sun, 19 Aug 2018 13:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com> <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
In-Reply-To: <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sun, 19 Aug 2018 13:25:13 -0700
Message-ID: <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        james.hogan@imgtec.com, joe@ovn.org, daniel.santos@pobox.com,
        Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>, sparse@chrisli.org,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        George Burgess <gbiv@google.com>,
        James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ gbiv who wrote this cool paste (showing alternatives to
_Static_assert, which is supported by both compilers in -std=gnu89,
but not until gcc 4.6): https://godbolt.org/g/DuLsxu

I can't help but think that BUILD_BUG_ON_MSG should use
_Static_assert, then have fallbacks for gcc < 4.6.

On Sun, Aug 19, 2018 at 9:14 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Aug 18, 2018 at 10:51 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > __compiletime_assert_fallback() is supposed to stop building earlier
> > by using the negative-array-size method in case the compiler does not
> > support "error" attribute, but has never worked like that.
> >
> > You can try this simple code:
> >
> >     #include <linux/build_bug.h>
> >     void foo(void)
> >     {
> >             BUILD_BUG_ON(1);
> >     }
> >
> > GCC (precisely, GCC 4.3 or later) immediately terminates the build,
> > but Clang does not report anything because Clang does not support the
> > "error" attribute now.  It will eventually fail in the link stage,
> > but at least __compiletime_assert_fallback() is not working.
> >
> > The root cause is commit 1d6a0d19c855 ("bug.h: prevent double evaluation
> > of `condition' in BUILD_BUG_ON").  Prior to that commit, BUILD_BUG_ON()
> > was checked by the negative-array-size method *and* the link-time trick.
> > Since that commit, the negative-array-size is not effective because
> > '__cond' is no longer constant.  As the comment in <linux/build_bug.h>
> > says, GCC (and Clang as well) only emits the error for obvious cases.
> >
> > When '__cond' is a variable,
> >
> >     ((void)sizeof(char[1 - 2 * __cond]))
> >
> > ... is not obvious for the compiler to know the array size is negative.
> >
> > One way to fix this is to stop the variable assignment, i.e. to pass
> > '!(condition)' directly to __compiletime_error_fallback() at the cost
> > of the double evaluation of 'condition'.  However, all calls of
> > BUILD_BUG() would be turned into errors even if they are called from
> > dead-code.
> >
> > This commit does not change the current behavior since it just rips
> > off the code that has not been effective for some years.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Yeah, Clang would only complain about the VLA (and not error) and then
> later fail at link time. This seems like a reasonable change to me.

Heh, we were just talking about this (-Wvla warnings from this macro).
Was there a previous thread before this patch?

>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> >
> >  include/linux/compiler.h | 17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 42506e4..c062238f4 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -295,29 +295,14 @@ unsigned long read_word_at_a_time(const void *addr)
> >  #endif
> >  #ifndef __compiletime_error
> >  # define __compiletime_error(message)
> > -/*
> > - * Sparse complains of variable sized arrays due to the temporary variable in
> > - * __compiletime_assert. Unfortunately we can't just expand it out to make
> > - * sparse see a constant array size without breaking compiletime_assert on old
> > - * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
> > - */
> > -# ifndef __CHECKER__
> > -#  define __compiletime_error_fallback(condition) \
> > -       do { ((void)sizeof(char[1 - 2 * condition])); } while (0)

Note that there are a few definitions of BUILD_BUG_ON that still use
this negative array size trick.  Should that pattern be removed from
them as well?  See:
* arch/x86/boot/boot.h#L33
* include/linux/build_bug.h#L66
* tools/include/linux/kernel.h#L38

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
