Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id P0V4LMhqGVvSQAAAmS7hNA
	; Thu, 07 Jun 2018 17:26:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9A7C2608BA; Thu,  7 Jun 2018 17:26:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERFrJs+j"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F2566601B4;
	Thu,  7 Jun 2018 17:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2566601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933807AbeFGR0b (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:26:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39881 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933668AbeFGR0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:26:25 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so6556017plt.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3l3SarRkUZt1ZR2hf6cCyxlYIBmDr+5VTqDQHa4DQ8=;
        b=ERFrJs+jLTtAd1I5lDOeLNeIV5ZkRM/aw+ovTtM5PrwGkYo1bbp8eIcsxVKOdMUDVH
         Jb/yqOrF3WKGWo96IlzJfEsMKEgG3+Ci2ez/YqcY3HXJaapTZdQXE6to8LKjOwdGbfbl
         MqAJR+psKVR3dx4pi0iQkE5/EM7RFmqf5cNxbCUJO7hUK6Rsksrn/wTdv2RvPZQ50awJ
         setMsRW/L7ecj9DcKPPcbwcWadu0rkvYrgLDQMM4Ki/JckWPgCpVZnMYHkTTSKhXsMky
         eqtqlTFviCfPH90Fu3qqETVxFPynbwhzk7XGYbvXJD2WOoUr+bV8dfmcIY3j2LZtwZ3d
         +Myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3l3SarRkUZt1ZR2hf6cCyxlYIBmDr+5VTqDQHa4DQ8=;
        b=mn9aqM0qqPGOnfqCzNHQxOTvA1w7+OPMe1cV2jIzu4IoROLUI/2huYYQLNmmJCfe0I
         1CJI9M+nbjTJtrCLB6CuhVO09ycYwl28jljywXk0nBM9W11xCLnR4qsoEz4yxv6kwWnd
         XzcY36a/S3+5V3VWRWVgSBOsymP5AbuzHsxKZHmf5ozfcxbUamWhzgRWHtAI5uPi8MfT
         valF4Q1++4Riym4Bhs+nPhqp9O3iCYFuJO7E1oOEk8kwf4QrK3auXhcP1lSfvlmppgl9
         Yqh0nv4NH1wS11L+Xo0Z9ZUZiFWI/j+hdVVEk4IYR+SRcudyogu+5NDJWQIIiTjoqvL8
         L+5A==
X-Gm-Message-State: APt69E31royx47pQb7ZYA1N2pnmEyrYQlETpwgwTFRQWGU2V845LlrS9
        yfDNKlH1LuxAKrVm61TQZT0YqOnbgT1orXSZYkfvMg==
X-Google-Smtp-Source: ADUXVKJTkd/fMVAMC/+BZOdl9R2KJ6aQW6L4S81Vy5UiWFH7OUmHpp/IHOa3NjY9mr1UCYB6blAvQZXEPt+pdflPwM8=
X-Received: by 2002:a17:902:1347:: with SMTP id r7-v6mr2916432ple.62.1528392383587;
 Thu, 07 Jun 2018 10:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180605170532.170361-1-ndesaulniers@google.com>
 <20180605170532.170361-2-ndesaulniers@google.com> <202492204c2d5bd5ca27307cbca5e44673b739ed.camel@perches.com>
In-Reply-To: <202492204c2d5bd5ca27307cbca5e44673b739ed.camel@perches.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 7 Jun 2018 10:26:10 -0700
Message-ID: <CAKwvOdkUk7ZL8tXgBs0Y+0Y5NVebgAYne_qgdSWWDOvQaWFPhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] compiler-gcc.h: add gnu_inline to all inline declarations
To: joe@perches.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, akataria@vmware.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>, hpa@zytor.com,
        "J. Kiszka" <jan.kiszka@siemens.com>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kirill.shutemov@linux.intel.com, mingo@redhat.com,
        mjg59@google.com, Matthias Kaehlcke <mka@chromium.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
        thomas.lendacky@amd.com, Thiebaud Weksteen <tweek@google.com>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 10:23 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-06-05 at 10:05 -0700, Nick Desaulniers wrote:
> > Functions marked extern inline do not emit an externally visible
> > function when the gnu89 C standard is used. Some KBUILD Makefiles
> > overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
> > an explicit C standard specified, the default is gnu11. Since c99, the
> > semantics of extern inline have changed such that an externally visible
> > function is always emitted. This can lead to multiple definition errors
> > of extern inline functions at link time of compilation units whose build
> > files have removed an explicit C standard compiler flag for users of GCC
> > 5.1+ or Clang.
> []
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> []
> > @@ -72,17 +72,24 @@
> >   * -Wunused-function.  This turns out to avoid the need for complex #ifdef
> >   * directives.  Suppress the warning in clang as well by using "unused"
> >   * function attribute, which is redundant but not harmful for gcc.
> > + * Prefer gnu_inline, so that extern inline functions do not emit an
> > + * externally visible function. This makes extern inline behave as per gnu89
> > + * semantics rather than c99. This prevents multiple symbol definition errors
> > + * of extern inline functions at link time.
> >   */
> >  #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||             \
> >      !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
> > -#define inline inline                __attribute__((always_inline,unused)) notrace
> > -#define __inline__ __inline__        __attribute__((always_inline,unused)) notrace
> > -#define __inline __inline    __attribute__((always_inline,unused)) notrace
> > +#define inline \
> > +     inline __attribute__((always_inline, unused, gnu_inline)) notrace
> > +#define __inline__ \
> > +     __inline__ __attribute__((always_inline, unused, gnu_inline)) notrace
> > +#define __inline \
> > +     __inline __attribute__((always_inline, unused, gnu_inline)) notrace
>
> Perhaps these are simpler as
>
> #define __inline__      inline
> #define __inline        inline

Working on this now, going to push v3 soon.  I was wondering more
about these definitions of inline.

Probably want:

#define __inline__ __inline__ inline
#define __inline __inline inline

These are the only references I found to:

__inline__: https://gcc.gnu.org/onlinedocs/gcc/Inline.html
__inline: http://www.keil.com/support/man/docs/armcc/armcc_chr1359124967692.htm

The commit that introduced them was:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1365647022eb05a5993f270a78e9bef3bf554eb
which was an interesting read.

I get the feeling that the use of __inline__ or __inline (vs inline)
in the kernel may be wrong and their use should be eradicated in the
follow up patch set, but it would be cool if others have additional
insight.

This code in Clang seems to treat them all as the same:
https://github.com/llvm-mirror/clang/blob/1a597eeed3579b4320b62ff55150195482545992/lib/Lex/PPDirectives.cpp#L2285

-- 
Thanks,
~Nick Desaulniers
