Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F11C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8BE20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jw5s/QH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8BE20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeG3VYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:24:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42892 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeG3VYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:24:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so7790092pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WDy8QsOlglij62pYF7V1nZdRLfyIQC/40MYITbKqLII=;
        b=jw5s/QH8qDInvF5qb1XwJXiZ3urTdfOvDBkbmJrDOe+//Jr41PpO4xeQF/IhOczHxT
         sDt9cgogQV3+lZbi1dEnjM4WjnF2F7z9xwM0GJcqaQOfBzkXDZ4y/Bn7nu2vO0q8ovEt
         +o3DSf2TEOJDxKtfo4Dug7D8bcpoa8eVUe4Dh3TJPANwlP+VbSKE5hHkzcqIfP7R6kDk
         dSwq+6T35iYOcUlaOqyCHoQUphKIw5Qzy8jkDFZQANG/AMWyIWpbgOeSi5kvU/jR/M6C
         /KROFlAm6WZYgyMVUc2Vr5j65apgogZAO1RocK2Pku6ZWX8TseBeyOveK1H/F8JD9eJx
         DYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WDy8QsOlglij62pYF7V1nZdRLfyIQC/40MYITbKqLII=;
        b=NUnjW7FlntOenwVMbTC/rOyvIZV5E+t8Hhh6E4K/vQjQyoJo6FypFfoGEV6tBX8/WH
         +qSxhq5vnWYDd/OWTUekFzclTnIOmrqg7vow3su16k4Hs21PwBDdjlLTKg/JtR9SbDYq
         hY16fkiHd1V7B26/x3Ntt5MxqhxvnqAMwU2RUT8ZgLHUeA8W8vtzlIecuCTEI81bsXt3
         2nFXHgs+Tc+M8UVM6Wg9yR66ej/d7l9O+PKIO99LbrMzNXOXoKJpdftOzp51IQTDervL
         NyUgNYzoUoElBk5TKxlrb3urk0TmMtERBY/ZkM/5EWM6mnqWk7m7SNc8Rx9mGnT+Rus8
         ftLA==
X-Gm-Message-State: AOUpUlHRIuijmUgCp4oBJLaXwIijd9l+bVZeMrzbbIAye6xk/irD3Enk
        6q0SlblFMasbwBWjxtp6TYeqn69CvaWn7UyZ6TStnA==
X-Google-Smtp-Source: AAOMgpdVGw1YaiN9n2KH/ZFC0V57ZNJMZwhMsJtD1D7lG9AJGCIdcNWw1Y7tDfQLqqN38zRRn9FrG5uG6U3V+LC/lJo=
X-Received: by 2002:a62:3d86:: with SMTP id x6-v6mr19129641pfj.192.1532980097430;
 Mon, 30 Jul 2018 12:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180730170622.99349-1-ndesaulniers@google.com> <20180730183943.GA9221@flashbox>
In-Reply-To: <20180730183943.GA9221@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Jul 2018 12:48:06 -0700
Message-ID: <CAKwvOdmYjgSMH5jESiK3kQa1DSyBpxesAmi_gbY9LL5_8XrA5g@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
To:     natechancellor@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>, ghackmann@android.com,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        rdunlap@infradead.org, neilb@suse.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:39 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Jul 30, 2018 at 10:06:20AM -0700, Nick Desaulniers wrote:
> > Starting with Clang-7.0, _THIS_IP_ generates -Wreturn-stack-address
> > warnings for almost every translation unit. In general, I'd prefer to
> > leave this on (returning the address of a stack allocated variable is i=
n
> > general a bad idea) and disable it only at whitelisted call sites.
> >
> > We can't do something like:
> >  #pragma clang diagnostic push
> >  #pragma clang diagnostic ignored "-Wreturn-stack-address"
> >  <code>
> >  #pragma clang diagnostic pop
> >
> > in a GNU Statement Expression or macro, hence we use _Pragma, which is
> > its raison d'=C3=AAtre: https://gcc.gnu.org/onlinedocs/cpp/Pragmas.html
> >
> > Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  include/linux/kernel.h | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 941dc0a5a877..5906f5727f90 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -168,7 +168,15 @@
> >
> >
> >  #define _RET_IP_             (unsigned long)__builtin_return_address(0=
)
> > -#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__her=
e; })
> > +#define _THIS_IP_  (                                                 \
> > +{                                                                    \
> > +     _Pragma("clang diagnostic push")                                \
> > +     _Pragma("clang diagnostic ignored \"-Wreturn-stack-address\"")  \
> > +     __label__ __here;                                               \
> > +__here: (unsigned long)&&__here;                                     \
> > +     _Pragma("clang diagnostic pop")                                 \
> > +}                                                                    \
> > +)
> >
> >  #ifdef CONFIG_LBDAF
> >  # include <asm/div64.h>
> > --
> > 2.18.0.233.g985f88cf7e-goog
> >
>
> This generates a ton of warnings with GCC:
>
> In file included from ./include/linux/spinlock.h:58,
>                  from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:6,
>                  from ./include/linux/slab.h:15,
>                  from ./include/linux/crypto.h:24,
>                  from arch/x86/kernel/asm-offsets.c:9:
> ./include/linux/bottom_half.h: In function =E2=80=98local_bh_disable=E2=
=80=99:
> ./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagnosti=
c [-Werror=3Dunknown-pragmas]
>   __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
> ./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagnosti=
c [-Werror=3Dunknown-pragmas]
> ./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagnosti=
c [-Werror=3Dunknown-pragmas]
> ./include/linux/bottom_half.h: In function =E2=80=98local_bh_enable=E2=80=
=99:
> ./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagnosti=
c [-Werror=3Dunknown-pragmas]
>   __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
> ./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagnosti=
c [-Werror=3Dunknown-pragmas]
> ./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagnosti=
c [-Werror=3Dunknown-pragmas]
> cc1: all warnings being treated as errors
> make[1]: *** [Kbuild:56: arch/x86/kernel/asm-offsets.s] Error 1
> make: *** [Makefile:1081: prepare0] Error 2

Ah, good catch.  I thought I had tested locally with gcc-8, but it
seems that it was likely only godbolt.  I do see the errors locally
when building with gcc-8.

>
> A proper solution is probably going to involve what was done for the
> -Wattribute-alias warnings from GCC 8 in commits 8793bb7f4a9d ("kbuild:
> add macro for controlling warnings to linux/compiler.h") and
> bee20031772a ("disable -Wattribute-alias warning for SYSCALL_DEFINEx()")
>
> I'll take a look at it in a bit unless someone beats me to it.

I'll fix this up, triple check with gcc-8, and attribute you in the
Suggested-by tag.  Thank you for verifying.
--=20
Thanks,
~Nick Desaulniers
