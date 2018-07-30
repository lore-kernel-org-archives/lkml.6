Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63560C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B34520890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOyADngR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B34520890
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeG3WwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:52:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44420 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbeG3WwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:52:25 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so6100303pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jPhAof9dtrfQt/2yCs8hnrwZP2WcKlHYCsMQRRTom5Y=;
        b=qOyADngR31MTWB+f5llQ7Bn6HP+g27pARUAveHXYj5rN8W5UN/VCc/dRFQYY6v8/62
         DhdWFzNiIw9vxDE42bLchL+86J4dd8+ORAPPbrm45l8Pc8Oxshz7NF0BxeRdTtUhSM/z
         TW4krmd3lOVpQLICAKRh2V4wOdRwmuJ3A9S5/1AOGtzwbOl/2Uacunqhft1tvq1GSGwx
         FJ+97w9sey7NxVsFgB9cXzK0eNjl1Da83N44JynT6lT3udvDucLch7UesWNXVbIxgZfJ
         X0TMZX0C9siWMd8tPC6b321Yk9iPHK6ynIrHZUjtJ48Vq5AiPaRqOkG16pVgRpS7aw0t
         OfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jPhAof9dtrfQt/2yCs8hnrwZP2WcKlHYCsMQRRTom5Y=;
        b=m6cHc9t2V2Ck7OGXTjl5PcsJS9/Z0et/NQalDM9K33pm6dlfy3BxcUL7k8dfOSqiRd
         Xu9McoyPQlwHq75qtvS97CFez2Y6oFJaLie8mT/ncp7rjCD8w+WGDRBstrqzKneGVWMk
         oYJHRxMNlpf1TJVV9NjU8DuQdK0bhug6FlJm/G7BzCm/L5vs/3MWvm+WNU6MQwYjSnOF
         qWHYLnfAS6kEtxEk0GZUlUk+B01rgrh2tT317chvH3UseWPAlKW5UJdDtI5+lua1fvIf
         CNoqjYrmzhi7NoQCht1IaP1TMHsSf+yg/y7DCQudTh2QgzU+m+pkEI30MCM1uIr255Ah
         efwQ==
X-Gm-Message-State: AOUpUlGj/25W3Cu25blX/OVucweplJLOWAMsREsH1v338z0NiWwbOlb8
        z5D8nhpi8EmQbD2gL6fIHO1VV1bsrnOJAhwIk//RlA==
X-Google-Smtp-Source: AAOMgpfJh5zKvm6/9dv+ZI7sSXkuQWAZEpg26IGGLu3mKXclH6ndV7zw77+ale+qi9mRBD7pKQ+r49NrmRCO67VJnAs=
X-Received: by 2002:a17:902:9a01:: with SMTP id v1-v6mr18076744plp.20.1532985333485;
 Mon, 30 Jul 2018 14:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180730170622.99349-1-ndesaulniers@google.com>
 <20180730183943.GA9221@flashbox> <CAKwvOdmYjgSMH5jESiK3kQa1DSyBpxesAmi_gbY9LL5_8XrA5g@mail.gmail.com>
 <20180730200119.GA8599@flashbox>
In-Reply-To: <20180730200119.GA8599@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Jul 2018 14:15:22 -0700
Message-ID: <CAKwvOdn91nh-0fBocAm=-bUb0-S5BBsKFeSZeV3C9byLb057gQ@mail.gmail.com>
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

On Mon, Jul 30, 2018 at 1:01 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Jul 30, 2018 at 12:48:06PM -0700, Nick Desaulniers wrote:
> > On Mon, Jul 30, 2018 at 11:39 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Mon, Jul 30, 2018 at 10:06:20AM -0700, Nick Desaulniers wrote:
> > > > Starting with Clang-7.0, _THIS_IP_ generates -Wreturn-stack-address
> > > > warnings for almost every translation unit. In general, I'd prefer =
to
> > > > leave this on (returning the address of a stack allocated variable =
is in
> > > > general a bad idea) and disable it only at whitelisted call sites.
> > > >
> > > > We can't do something like:
> > > >  #pragma clang diagnostic push
> > > >  #pragma clang diagnostic ignored "-Wreturn-stack-address"
> > > >  <code>
> > > >  #pragma clang diagnostic pop
> > > >
> > > > in a GNU Statement Expression or macro, hence we use _Pragma, which=
 is
> > > > its raison d'=C3=AAtre: https://gcc.gnu.org/onlinedocs/cpp/Pragmas.=
html
> > > >
> > > > Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
> > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > ---
> > > >  include/linux/kernel.h | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > > > index 941dc0a5a877..5906f5727f90 100644
> > > > --- a/include/linux/kernel.h
> > > > +++ b/include/linux/kernel.h
> > > > @@ -168,7 +168,15 @@
> > > >
> > > >
> > > >  #define _RET_IP_             (unsigned long)__builtin_return_addre=
ss(0)
> > > > -#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&_=
_here; })
> > > > +#define _THIS_IP_  (                                              =
   \
> > > > +{                                                                 =
   \
> > > > +     _Pragma("clang diagnostic push")                             =
   \
> > > > +     _Pragma("clang diagnostic ignored \"-Wreturn-stack-address\""=
)  \
> > > > +     __label__ __here;                                            =
   \
> > > > +__here: (unsigned long)&&__here;                                  =
   \
> > > > +     _Pragma("clang diagnostic pop")                              =
   \
> > > > +}                                                                 =
   \
> > > > +)
> > > >
> > > >  #ifdef CONFIG_LBDAF
> > > >  # include <asm/div64.h>
> > > > --
> > > > 2.18.0.233.g985f88cf7e-goog
> > > >
> > >
> > > This generates a ton of warnings with GCC:
> > >
> > > In file included from ./include/linux/spinlock.h:58,
> > >                  from ./include/linux/mmzone.h:8,
> > >                  from ./include/linux/gfp.h:6,
> > >                  from ./include/linux/slab.h:15,
> > >                  from ./include/linux/crypto.h:24,
> > >                  from arch/x86/kernel/asm-offsets.c:9:
> > > ./include/linux/bottom_half.h: In function =E2=80=98local_bh_disable=
=E2=80=99:
> > > ./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagn=
ostic [-Werror=3Dunknown-pragmas]
> > >   __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> > >
> > > ./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagn=
ostic [-Werror=3Dunknown-pragmas]
> > > ./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagn=
ostic [-Werror=3Dunknown-pragmas]
> > > ./include/linux/bottom_half.h: In function =E2=80=98local_bh_enable=
=E2=80=99:
> > > ./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagn=
ostic [-Werror=3Dunknown-pragmas]
> > >   __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> > >
> > > ./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagn=
ostic [-Werror=3Dunknown-pragmas]
> > > ./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagn=
ostic [-Werror=3Dunknown-pragmas]
> > > cc1: all warnings being treated as errors
> > > make[1]: *** [Kbuild:56: arch/x86/kernel/asm-offsets.s] Error 1
> > > make: *** [Makefile:1081: prepare0] Error 2
> >
> > Ah, good catch.  I thought I had tested locally with gcc-8, but it
> > seems that it was likely only godbolt.  I do see the errors locally
> > when building with gcc-8.
> >
> > >
> > > A proper solution is probably going to involve what was done for the
> > > -Wattribute-alias warnings from GCC 8 in commits 8793bb7f4a9d ("kbuil=
d:
> > > add macro for controlling warnings to linux/compiler.h") and
> > > bee20031772a ("disable -Wattribute-alias warning for SYSCALL_DEFINEx(=
)")
> > >
> > > I'll take a look at it in a bit unless someone beats me to it.
> >
> > I'll fix this up, triple check with gcc-8, and attribute you in the
> > Suggested-by tag.  Thank you for verifying.
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> I forgot to mention there is a similar macro that will need this same
> fix in arch/arm64/include/asm/processor.h (current_text_addr), if you
> want to tackle it in v2. Do CC me on the next series so that I can test,
> thank you for doing this!

!!!

$ grep -R current_text_addr

shows many definitions of current_text_addr per arch/ that are all
essentially the same, and very very few uses of it.  I prefer to
consolidate current_text_addr() in a follow up series, since a common
definition with per-arch overrides will have to get a lot of sign
offs.

Though, for arm64, a simple:
-#define current_text_addr() ({ __label__ _l; _l: &&_l;})
+#define current_text_addr() _THIS_IP_

does the trick, it would be better to have a single shared definition.

--=20
Thanks,
~Nick Desaulniers
