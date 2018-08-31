Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2148BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32C220841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEJOuqc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32C220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIACtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:49:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54600 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeIACtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:49:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so6501031wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eLfnMqsOtBZ5X/PZiNA5zDcvLniTokm3iCs8AdKlvag=;
        b=GEJOuqc44R8Xhd9Ezx1m7wQNhcMZE0YBX/YiRVHDl1tjgB6/mML/J/bVgOOdYUvXhm
         FSb0nOsSDawFnnCg0FsJqUwT0+rCFhgIoCip5MafImeXR6rk2ALO2auuAeAR4aA8iKeT
         5JkxZN4i8YbwRWIbYXk/KuG6aTWf0+3gUl+PXMnuxcSR0MxFrEAoP20MvXZIs7HJVxAJ
         70ypgRTYRBESXuovS6kJi3qU3EDWwHBwRO08af/FRWn7lIaIW8wErR4yInJ1BJURswFv
         P8YPN+vOCmp69GnySXARi7zwNx6ScPQPoaK8G479YF7bmZKg+eWwkh+Tc8V5MemTC47f
         30Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eLfnMqsOtBZ5X/PZiNA5zDcvLniTokm3iCs8AdKlvag=;
        b=pXQMm9Vkoom9G6Yj9U6vPIpuR3dnZhfdfaZB0lIyqFrw/6Vxbdj3H9JTiv+5ie8B3p
         VzMUQ+uv6M+OwJ5x2i/huzv32v2G/yg/Uw3BQMg0XoxiKyRepC548O8IGDSAjrtEXx0C
         BoPXmk/HguZ4a2Q0P4P4JjopkB4ud4dnoIHbFIjWavCzDOIHxjLmGSZkooVBjUIIN6BE
         D89YRov5u68sGKoH8Q7PKINuBHPm0RVK1Y1EimjLdaRjp+7/039L1iRxeVQTUFmriAag
         TkAJjl9L0TTLZbOXbLBE1mxgf1HySYFyviFw14J4T2roL1WfK45XKXPbKxuD6J4DCadI
         gO/g==
X-Gm-Message-State: APzg51BZOh4GYg5Z/k2TVYJM8VpbwQdokWut2u0rjiq9YK9HnkfRhhX6
        hsVoBvzvx6lI1Q9tCz6TXTA=
X-Google-Smtp-Source: ANB0VdYI4LoVaE37SInTkq/K7L4HCG/ZXdnZ3mex7P3CWTtEjlcUiDZaWPXBmiMsvZ9kT0hDP87ymg==
X-Received: by 2002:a1c:ee57:: with SMTP id m84-v6mr5726207wmh.9.1535755197651;
        Fri, 31 Aug 2018 15:39:57 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:1c3e:86e4:17b5:54c7])
        by smtp.gmail.com with ESMTPSA id d18-v6sm4386771wmb.33.2018.08.31.15.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 15:39:56 -0700 (PDT)
Date:   Sat, 1 Sep 2018 00:39:55 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Christopher Li <sparse@chrisli.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 6/7] Compiler Attributes: remove unneeded sparse
 (__CHECKER__) tests
Message-ID: <20180831223954.ljokaxczxyw5wvbu@ltop.local>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-6-miguel.ojeda.sandonis@gmail.com>
 <CAKwvOdkZeFj1QW8QBDSCet2Kv1jRka0DK_eSJwNmfG1Zqn2zcg@mail.gmail.com>
 <CANiq72=2Q1+EoqSzvT3aHGWFAJds4ZHXVq_yT+JCYvUhiHtHGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=2Q1+EoqSzvT3aHGWFAJds4ZHXVq_yT+JCYvUhiHtHGg@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:55:51PM +0200, Miguel Ojeda wrote:
> Hi Nick,
> 
> On Fri, Aug 31, 2018 at 11:38 PM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > On Fri, Aug 31, 2018 at 10:05 AM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> >>
> >> Sparse knows about a few more attributes now, so we can remove
> >> the __CHECKER__ conditions from them (which, in turn, allow us
> >> to move some of them later on to compiler_attributes.h).
> >>
> >>   * assume_aligned: since sparse's commit ffc860b ("sparse:
> >>     ignore __assume_aligned__ attribute"), included in 0.5.1
> >>
> >>   * error: since sparse's commit 0a04210 ("sparse: Add 'error'
> >>     to ignored attributes"), included in 0.5.0
> >>
> >>   * hotpatch: since sparse's commit 6043210 ("sparse/parse.c:
> >>     ignore hotpatch attribute"), included in 0.5.1
> >>
> >>   * warning: since sparse's commit 977365d ("Avoid "attribute
> >>     'warning': unknown attribute" warning"), included in 0.4.2
> >>
> >> Cc: Eli Friedman <efriedma@codeaurora.org>
> >> Cc: Christopher Li <sparse@chrisli.org>
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Ingo Molnar <mingo@kernel.org>
> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> Cc: Joe Perches <joe@perches.com>
> >> Cc: Dominique Martinet <asmadeus@codewreck.org>
> >> Cc: Nick Desaulniers <ndesaulniers@google.com>
> >> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> >> ---
> >>  include/linux/compiler-gcc.h   | 6 ++----
> >>  include/linux/compiler_types.h | 2 +-
> >>  2 files changed, 3 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> >> index fdf2fbe6d544..32e6ce06163f 100644
> >> --- a/include/linux/compiler-gcc.h
> >> +++ b/include/linux/compiler-gcc.h
> >> @@ -84,14 +84,12 @@
> >>
> >>  #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
> >>
> >> -#ifndef __CHECKER__
> >>  #define __compiletime_warning(message) __attribute__((warning(message)))
> >>  #define __compiletime_error(message) __attribute__((error(message)))
> >>
> >> -#ifdef LATENT_ENTROPY_PLUGIN
> >> +#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
> >>  #define __latent_entropy __attribute__((latent_entropy))
> >>  #endif
> >> -#endif /* __CHECKER__ */
> >>
> >>  /*
> >>   * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
> >> @@ -139,7 +137,7 @@
> >>
> >>  /* gcc version specific checks */
> >>
> >> -#if GCC_VERSION >= 40900 && !defined(__CHECKER__)
> >> +#if GCC_VERSION >= 40900
> >>  /*
> >>   * __assume_aligned(n, k): Tell the optimizer that the returned
> >>   * pointer can be assumed to be k modulo n. The second argument is
> >> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> >> index 3662b19599fc..5dddc7e0c607 100644
> >> --- a/include/linux/compiler_types.h
> >> +++ b/include/linux/compiler_types.h
> >> @@ -216,7 +216,7 @@ struct ftrace_likely_data {
> >>  #define __must_check
> >>  #endif
> >>
> >> -#if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
> >> +#if defined(CC_USING_HOTPATCH)
> >>  #define notrace                        __attribute__((hotpatch(0, 0)))
> >>  #else
> >>  #define notrace                        __attribute__((no_instrument_function))
> >> --
> >> 2.17.1
> >>
> >
> > Everything looks correct here.  It would be good for the sparse
> > maintainer to triple check the commit sha's (as those are for sparse's
> > code base, not the kernel's) and have their blessing.  If Chris is
> 
> Actually, nowadays it is very easy to check in sparse's
> gcc-attr-list.h file, but since the file was not always there, I tried
> to find out when the support for each attribute was added.

Acked-by: Luc Van Oostenryck <luc.vanoosternyck@gmail.com>
