Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BD998C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6790720660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8YbGo4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6790720660
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932873AbeFLSda (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:33:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40690 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeFLSd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:33:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so12541405pfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vu8k1S0G3d+1fT045tdUayHnXPTp4ooVg7LZW6u+3Eg=;
        b=W8YbGo4LBRovIvfYOJrDlxUELz7ztlVb5hmoXAS9voXjr4lL0hDe7jbYcggsHfbExd
         pOuYcAxETpo/hxFYMBsp7W5btUqKzfOluHtfCdR9QEIiDx/wwpK0svuFJTbdNJhipitI
         SLt5M9t0N1lMIs6qwST8thjl0Hq+p5zhlk9+YkiUwkqZYdlsFi9rXENns2Gibzilfig/
         dsE+Gi2EW6R++YAVOk5LgJlP8At6Msu6oXRW2YYTK8qOFqOgs5h8w7dXqj1MtyBdDPtv
         5jPkWMDORAg9Z8zfYugW7Uzcwtw51ybg7L4KbKO5YxsjP7BiMRYDS5YJYWGRjovdeRlF
         A2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vu8k1S0G3d+1fT045tdUayHnXPTp4ooVg7LZW6u+3Eg=;
        b=OyMXHGDd+E7qRvHB++xjtOem3tC88XxufXVdPkon9kkJ8p3uamku00kpwfAFbXaKVN
         I6OpAmxGJk23lGP/fEvLONZImmKvl25+K/Gf24PjSgbIrpDQe7Hgbc8E2CncnPDLj6j0
         QhQqlu8XfAEoFR10CN2LneSsI8est6NER2tSwZfSYIJfQktIYgxuyUxxFzYlRjGDi4nH
         3tCwpgVLCZecbu9TYqcs0CoScTtrvVLz/2Rg/ruc/T8mIMgZgRWKnQ9fQ2uUaHvhsD6w
         fzO3o3cA2F5j7g304EQTpiQquY/YnbWkJ+9tuMIQ2gA3WNHA5IkxMN3AtEdP87v4HEQ9
         WU6w==
X-Gm-Message-State: APt69E2FfOhui3otr8Kov8Zk5jqYRi8KFrm6RWEdBG3L4uo3lKjnqoJt
        9Hu1TCJtwIoiFmdbWv5XOye4AYGZFUeLVsIeKNRCPw==
X-Google-Smtp-Source: ADUXVKI1fuZFrabRm8uoEre97iZnQccetpMJ0LNM+kfxe6H822+ympvGRsTw76I8Fm5FXChFXA4nDVks2iCE4tnZAAw=
X-Received: by 2002:a63:370f:: with SMTP id e15-v6mr1302856pga.192.1528828406279;
 Tue, 12 Jun 2018 11:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180607204927.219329-1-ndesaulniers@google.com>
 <20180607204927.219329-2-ndesaulniers@google.com> <CAK8P3a0yi+MrOS=+pjCeUu==YBE_AppB8vfqdsQS-1NpSO2c4A@mail.gmail.com>
 <CA+icZUXDoeo5ktZZPFcFyLzk3xthM-98N88QJFzesg6t+Vr5cQ@mail.gmail.com>
In-Reply-To: <CA+icZUXDoeo5ktZZPFcFyLzk3xthM-98N88QJFzesg6t+Vr5cQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Jun 2018 11:33:14 -0700
Message-ID: <CAKwvOdmxFHfkj81YAXa8fE86fC+k+KvqMvgk4=e62pNCcXbKOg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] compiler-gcc.h: add gnu_inline to all inline declarations
To:     sedat.dilek@gmail.com, Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, hpa@zytor.com,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, tstellar@redhat.com,
        Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, David Rientjes <rientjes@google.com>,
        acme@redhat.com, Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 3:04 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jun 8, 2018 at 9:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jun 7, 2018 at 10:49 PM, Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >> Functions marked extern inline do not emit an externally visible
> >> function when the gnu89 C standard is used. Some KBUILD Makefiles
> >> overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
> >> an explicit C standard specified, the default is gnu11. Since c99, the
> >> semantics of extern inline have changed such that an externally visible
> >> function is always emitted. This can lead to multiple definition errors
> >> of extern inline functions at link time of compilation units whose build
> >> files have removed an explicit C standard compiler flag for users of GCC
> >> 5.1+ or Clang.
> >>
> >> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> >> Suggested-by: Joe Perches <joe@perches.com>
> >
> > I suspect this will break Geert's gcc-4.1.2, which I think doesn't have that
> > attribute yet (4.1.3 or higher have it according to the documentation.
> >
> > It wouldn't be hard to work around that if we want to keep that version
> > working, or we could decide that it's time to officially stop supporting
> > that version, but we should probably decide on one or the other.

Heh, so earlier we decided against compiler flags (-std=gnu89 or
-fgnu89-inline) in preference to function attributes.  The function
attribute is preferable as some of the Makefiles [accidentally?]
overwrite KBUILD_CFLAGS, which is problematic for gcc 5.1 users as the
implicit c standard used was changed to gnu11 from gnu89.  What's nice
is that to support gcc 4.1 users, we simply don't need to add any
attribute, as their implicit c standard is gnu89 which has the
semantics for extern inline that we want.  I have a simple change to
this patch that can support users of various gcc versions, see below:

> Good point.
> What is the minimum requirement of GCC version currently?
> AFAICS x86/asm-goto support requires GCC >= 4.5?

Yes, but that's only for x86, IIUC.  It seems the kernel may have
different minimum required versions of GCC based on arch then?  That
may be ok, but I'm not sure that's easy to keep track of without
having it explicitly stated somewhere like the docs perhaps?

> Just FYI...
> ...saw the last days in upstream commits that kbuild/kconfig for
> 4.18-rc1 offers possibilities to check for cc-version dependencies.

Those will be helpful.  If we want to pursue compiler flags, which get
set some Makefiles, then yes.  But I think a simpler change to my
patch would be as below.

It seems gcc did not get __has_attribute [0] until 5.1, but will
define __GNUC_GNU_INLINE__ if supported. [1]  Unfortunately, Clang
does not define __GNUC_GNU_INLINE__ [2].  So a proper feature test
might look like:

```
#ifndef __has_attribute
#define __has_attribute(x) 0
#endif

#if defined(__GNUC_GNU_INLINE__) || __has_attribute(gnu_inline)
#define __gnu_inline __attribute__(gnu_inline)
#endif

#define inline inline __attribute__((always_inline, unused)) notrace
__gnu_inline
```

Thoughts on this approach? I can send a v5 tomorrow if there's no
major issues.  Feedback appreciated, as always.

[0] https://clang.llvm.org/docs/LanguageExtensions.html#has-attribute
[1] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes
[2] https://bugs.llvm.org/show_bug.cgi?id=37784
-- 
Thanks,
~Nick Desaulniers
