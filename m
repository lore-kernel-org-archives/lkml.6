Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jKOLKW5rGVt1RgAAmS7hNA
	; Thu, 07 Jun 2018 17:29:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1809B608B8; Thu,  7 Jun 2018 17:29:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6g9QHoC"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 834D9605A2;
	Thu,  7 Jun 2018 17:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 834D9605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933851AbeFGR30 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:29:26 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:47025 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933048AbeFGR3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:29:23 -0400
Received: by mail-pg0-f66.google.com with SMTP id d2-v6so5067654pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOqwRXQdwGNR/NVrDmZDDcJXxtMZYfMw4zUrQNsDD60=;
        b=M6g9QHoCYpVyDji8IFFZREtYo0Ed8D7J8JgCmNQ95DRaxver3m3fy9c1CJVVp5kPjQ
         4G0DJN6Kp8JEY5+A3kW7t74XJyvLbU9AN/VJU8TGOXN8SsEXby+2+bJtktDZ4afjtqxh
         RvboPtYvQJrDb6wleAACNqd92lmypLPIyrryGxSGkIiPTLM+NUe4A/KKsbXtqHLyAK+9
         I+KXly1gX4195bSyBnXJgB41rbYcnS7cEycLpYVT3ZxGyvJzn1Q91+M+6OKiUev8/j0L
         zApNLv9FAucUcyklWdi7aw4mKYBacv3AHyIgKwlJk2HAi6P9i3525vtSVkukeNJz9y96
         r73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOqwRXQdwGNR/NVrDmZDDcJXxtMZYfMw4zUrQNsDD60=;
        b=HUX8aZcgXHEhue6EJPo8KkKTFSyHZZmGlXGWKcPUQr5X000mvxzsHBXcr18YeXcOlx
         pjoV8KFbs89RKJNUaTxWvfkyKdrwWA2FJeMhtiL77bB02AxylyJlTjP2k+QqyhlVFWIX
         qH/UDmRu/LRPo2WWr6RdaP0/qxrNAgoFICG8vwi8mkoHp/qwxRCjdfH6RqeK8NRunwJl
         pE4f8dQegEEqrhcf4sSKwoj1cmPXKa+82ZTWyLN7JdFkigJfIOXyTP+BHi7TdDgNpXQD
         GqOvIwaDkazjEdWrM35dx2GFPxiAPZAZusvkV53MLTteEmvtU4+uhmdfTJezJMURvujI
         Dqgw==
X-Gm-Message-State: APt69E2/RVmZK2vif96pAi9Fa1C45+u4Mqiyt40jVu4rHg7r1JXoCaNZ
        oeBwETWsqJX5QRjgZUC+HWRFfjFMZgIKSPg1/fDsEw==
X-Google-Smtp-Source: ADUXVKJeL7sxNFWDPdKVZQQ/sVQKNLPN+6RZZFGX/Wo2gYETKhfBqCSMerBnrompYFlgAMzzn2Vj3zwuyu6r+XxydJI=
X-Received: by 2002:a62:a30e:: with SMTP id s14-v6mr2654951pfe.168.1528392562862;
 Thu, 07 Jun 2018 10:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180605170532.170361-1-ndesaulniers@google.com>
 <20180605170532.170361-2-ndesaulniers@google.com> <202492204c2d5bd5ca27307cbca5e44673b739ed.camel@perches.com>
 <CAKwvOdkUk7ZL8tXgBs0Y+0Y5NVebgAYne_qgdSWWDOvQaWFPhw@mail.gmail.com>
In-Reply-To: <CAKwvOdkUk7ZL8tXgBs0Y+0Y5NVebgAYne_qgdSWWDOvQaWFPhw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 7 Jun 2018 10:29:10 -0700
Message-ID: <CAKwvOdm5_ZuPSPqvfsz1fpm3Z--Tvun3rZ_iQJUE=xegHT149w@mail.gmail.com>
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

On Thu, Jun 7, 2018 at 10:26 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jun 5, 2018 at 10:23 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Tue, 2018-06-05 at 10:05 -0700, Nick Desaulniers wrote:
> > > Functions marked extern inline do not emit an externally visible
> > > function when the gnu89 C standard is used. Some KBUILD Makefiles
> > > overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
> > > an explicit C standard specified, the default is gnu11. Since c99, the
> > > semantics of extern inline have changed such that an externally visible
> > > function is always emitted. This can lead to multiple definition errors
> > > of extern inline functions at link time of compilation units whose build
> > > files have removed an explicit C standard compiler flag for users of GCC
> > > 5.1+ or Clang.
> > []
> > > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > []
> > > @@ -72,17 +72,24 @@
> > >   * -Wunused-function.  This turns out to avoid the need for complex #ifdef
> > >   * directives.  Suppress the warning in clang as well by using "unused"
> > >   * function attribute, which is redundant but not harmful for gcc.
> > > + * Prefer gnu_inline, so that extern inline functions do not emit an
> > > + * externally visible function. This makes extern inline behave as per gnu89
> > > + * semantics rather than c99. This prevents multiple symbol definition errors
> > > + * of extern inline functions at link time.
> > >   */
> > >  #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||             \
> > >      !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
> > > -#define inline inline                __attribute__((always_inline,unused)) notrace
> > > -#define __inline__ __inline__        __attribute__((always_inline,unused)) notrace
> > > -#define __inline __inline    __attribute__((always_inline,unused)) notrace
> > > +#define inline \
> > > +     inline __attribute__((always_inline, unused, gnu_inline)) notrace
> > > +#define __inline__ \
> > > +     __inline__ __attribute__((always_inline, unused, gnu_inline)) notrace
> > > +#define __inline \
> > > +     __inline __attribute__((always_inline, unused, gnu_inline)) notrace
> >
> > Perhaps these are simpler as
> >
> > #define __inline__      inline
> > #define __inline        inline
>
> Probably want:
>
> #define __inline__ __inline__ inline
> #define __inline __inline inline

Oh, never mind, if my changes to `inline` add the `inline` keyword,
then we can remove the redefinition __inline__ and __inline.  All that
to say your original suggestion is better than my follow up.
-- 
Thanks,
~Nick Desaulniers
