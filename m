Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C47C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AB020857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8e98gh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AB020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeG3ViA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:38:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53562 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731904AbeG3Vh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:37:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so630718wmh.3;
        Mon, 30 Jul 2018 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aYbEuuEymCMOEvWE8VMBNTm0H1Ih87GNt+6/xIuYeDE=;
        b=I8e98gh0bh11qrH7I7Te2toyi8NmGGDDY9nUDIFQJEnzRFbla5JTs0XfbYWam3K8Ae
         nKNV/T7hXQ5F95xvLk04zM/hwoBq892HVbI9UFbziKpzFtX8xEdS6s/Wy1s/JWFDxuCz
         piwEErQ89p2RSPs7Fig0J3lwznWORLrwgyRiyfBJ0XvLiNd3lq1+viJr3lDLiA+dSyf+
         +++PuWWRGRzclRIZSMR+tIc4M8VROqDlae2w4F5XFKGegBAQHPWom8YhLCSVTHUFSam3
         /bEAiEpbHofalBmJHrIZEL8aJ4i3LCpssj3gwlCgLf9Sw6lWUvCVYH/S1Zjva+uGNKz0
         +8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aYbEuuEymCMOEvWE8VMBNTm0H1Ih87GNt+6/xIuYeDE=;
        b=ZGTEB/1L1k0qziaYjhz5DZAF+LeEc6c/P/5bus7pSRhtdumPCTM5b7EymNNVW2qh/D
         HbpAYXiHeh2iZNR8/nDxayUgAE11A9FJFgsoPE7thaVOdgy9cRkh83bkg45vPlnPE4TZ
         oI3+hdq/mf0KB1GDwaQIbjlO78LMo5aKZ0VTkSPFh2z9h/e1hiLK6iSTe6BYIIs4CzSk
         wuNJ2aKMO20U/oSvEXmSy8Msix321L4UuQrwwZ1KEcloe9oQi/oHaOaNE9Bmjztig0F6
         LRge6nFvVgfyz0G+8VEOsze5Le/7T0pMnJjQ5ZMugpLK0oRM0zXFhOVOzblLWQIy/GC6
         qsCg==
X-Gm-Message-State: AOUpUlH2KRGs+UeteqfJp6F/yt9McEHz5043YWKh62GzBTrlXzHzJhe1
        1DyWY59B/uMHnOsht2E9ZMI=
X-Google-Smtp-Source: AAOMgpfFlbicJGAZG5qAB+f+OyqC5Xg93tf55uEyqlkehutVSWirLnTQbyUpsNabDmqu7LhI3Xou5g==
X-Received: by 2002:a1c:cc01:: with SMTP id h1-v6mr409791wmb.82.1532980881866;
        Mon, 30 Jul 2018 13:01:21 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e137-v6sm699906wma.20.2018.07.30.13.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:01:20 -0700 (PDT)
Date:   Mon, 30 Jul 2018 13:01:19 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
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
Subject: Re: [PATCH] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
Message-ID: <20180730200119.GA8599@flashbox>
References: <20180730170622.99349-1-ndesaulniers@google.com>
 <20180730183943.GA9221@flashbox>
 <CAKwvOdmYjgSMH5jESiK3kQa1DSyBpxesAmi_gbY9LL5_8XrA5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmYjgSMH5jESiK3kQa1DSyBpxesAmi_gbY9LL5_8XrA5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:48:06PM -0700, Nick Desaulniers wrote:
> On Mon, Jul 30, 2018 at 11:39 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, Jul 30, 2018 at 10:06:20AM -0700, Nick Desaulniers wrote:
> > > Starting with Clang-7.0, _THIS_IP_ generates -Wreturn-stack-address
> > > warnings for almost every translation unit. In general, I'd prefer to
> > > leave this on (returning the address of a stack allocated variable is in
> > > general a bad idea) and disable it only at whitelisted call sites.
> > >
> > > We can't do something like:
> > >  #pragma clang diagnostic push
> > >  #pragma clang diagnostic ignored "-Wreturn-stack-address"
> > >  <code>
> > >  #pragma clang diagnostic pop
> > >
> > > in a GNU Statement Expression or macro, hence we use _Pragma, which is
> > > its raison d'être: https://gcc.gnu.org/onlinedocs/cpp/Pragmas.html
> > >
> > > Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  include/linux/kernel.h | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > > index 941dc0a5a877..5906f5727f90 100644
> > > --- a/include/linux/kernel.h
> > > +++ b/include/linux/kernel.h
> > > @@ -168,7 +168,15 @@
> > >
> > >
> > >  #define _RET_IP_             (unsigned long)__builtin_return_address(0)
> > > -#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> > > +#define _THIS_IP_  (                                                 \
> > > +{                                                                    \
> > > +     _Pragma("clang diagnostic push")                                \
> > > +     _Pragma("clang diagnostic ignored \"-Wreturn-stack-address\"")  \
> > > +     __label__ __here;                                               \
> > > +__here: (unsigned long)&&__here;                                     \
> > > +     _Pragma("clang diagnostic pop")                                 \
> > > +}                                                                    \
> > > +)
> > >
> > >  #ifdef CONFIG_LBDAF
> > >  # include <asm/div64.h>
> > > --
> > > 2.18.0.233.g985f88cf7e-goog
> > >
> >
> > This generates a ton of warnings with GCC:
> >
> > In file included from ./include/linux/spinlock.h:58,
> >                  from ./include/linux/mmzone.h:8,
> >                  from ./include/linux/gfp.h:6,
> >                  from ./include/linux/slab.h:15,
> >                  from ./include/linux/crypto.h:24,
> >                  from arch/x86/kernel/asm-offsets.c:9:
> > ./include/linux/bottom_half.h: In function ‘local_bh_disable’:
> > ./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]
> >   __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> >
> > ./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]
> > ./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]
> > ./include/linux/bottom_half.h: In function ‘local_bh_enable’:
> > ./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]
> >   __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> >
> > ./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]
> > ./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]
> > cc1: all warnings being treated as errors
> > make[1]: *** [Kbuild:56: arch/x86/kernel/asm-offsets.s] Error 1
> > make: *** [Makefile:1081: prepare0] Error 2
> 
> Ah, good catch.  I thought I had tested locally with gcc-8, but it
> seems that it was likely only godbolt.  I do see the errors locally
> when building with gcc-8.
> 
> >
> > A proper solution is probably going to involve what was done for the
> > -Wattribute-alias warnings from GCC 8 in commits 8793bb7f4a9d ("kbuild:
> > add macro for controlling warnings to linux/compiler.h") and
> > bee20031772a ("disable -Wattribute-alias warning for SYSCALL_DEFINEx()")
> >
> > I'll take a look at it in a bit unless someone beats me to it.
> 
> I'll fix this up, triple check with gcc-8, and attribute you in the
> Suggested-by tag.  Thank you for verifying.
> -- 
> Thanks,
> ~Nick Desaulniers

I forgot to mention there is a similar macro that will need this same
fix in arch/arm64/include/asm/processor.h (current_text_addr), if you
want to tackle it in v2. Do CC me on the next series so that I can test,
thank you for doing this!

Cheers,
Nathan
