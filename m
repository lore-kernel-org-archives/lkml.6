Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D7C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E7F2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mArZQ+0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E7F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJ1Vgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:36:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47075 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJ1Vgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:36:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id bb7-v6so2502541plb.13;
        Sun, 28 Oct 2018 05:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zh1XZcfn81XXtuE3Q2zC/H087swHCUfSUNmPutXptaE=;
        b=mArZQ+0n4a1HhHG7GKAZC83m0YUM2ya5B0B1vSodGCipE0iK0r6YOsXHKlUzBHzOwO
         DQRnAs9d+mSRD5ZVstJHf33F5lEYmFUMdaFI14ByqwJ9m0S2u7MEXUIhDJI1nAp3ukjR
         DNrRQ7ZIGO0hsPz1tbMt43uUj+M4DoyS11TeMVAo/wf6VQJKW0IC3FWWtrxLDdvF/Xqp
         io/5OlDsmJGejL2Pv4NSkY2QbfNXW4Goc87Od7rmnzGD93XNdKV3GLq8fi63f62Zk05y
         S+nkwVlIx00ylZ7SmrGGkPjSdFcAB1s5f/GilBibusaOlXaMLb935vFh3cMewx5Us1cP
         9ELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zh1XZcfn81XXtuE3Q2zC/H087swHCUfSUNmPutXptaE=;
        b=m1ij4Tx90OtsyxfhlDPWqfvqiZlZjMPUpyr8pU35/lxQA9bUDuT7czY/1G6Bzaqlys
         iiqAoOAeRqRGSz25oX+yRqTSRCf0ZHpOKRSCznpOsWPz9cyO4MFm3m3qH82FMS3JQVKx
         QNQvT8TtXHJ+vl1lKf4qfzaoWAl0IxGHutN2LINX8l7Dxx2And4YCT6bdpM60fHor+lw
         XsSVF2zVWeSCfqXa5mqUC0Fl1WyNzVIpYcChNEb68yVE3vGoa2oZpEWR3MlBWuCSo7qz
         mrmBAXgranA4H5CZte38EYPr1t/KeOs+ixYgq5enrPrFjYi56TOyBOJv3rC9i7D15Wda
         cGhA==
X-Gm-Message-State: AGRZ1gKtS5k+cxG5hze+4Xb53bKwM1Oz0eJouJeK5tVpozQS0p7qd9Vh
        sYFSKjK1yeGvwd0ALP2srdg=
X-Google-Smtp-Source: AJdET5evkPNMRYnlKKG6ENfnlaPjPrfWobW125pSZtT1HIx0Cy7gxgnNI9Ls5XsTDraf1Mlp0DB+2w==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10-v6mr10383706plb.130.1540731121510;
        Sun, 28 Oct 2018 05:52:01 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id o2-v6sm17266686pgp.82.2018.10.28.05.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 05:52:00 -0700 (PDT)
Date:   Sun, 28 Oct 2018 12:51:59 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     changbin.du@gmail.com, Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/4] kernel hacking: new config
 CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Message-ID: <20181028125106.azcn2dxia3snplin@mail.google.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
 <20181019124921.13780-5-changbin.du@gmail.com>
 <CAK7LNARW0=0d7m5DAgZOir=h0Y4tssqZoQRGasnGPNnvNf_+pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARW0=0d7m5DAgZOir=h0Y4tssqZoQRGasnGPNnvNf_+pg@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 11:28:24AM +0900, Masahiro Yamada wrote:
> On Fri, Oct 19, 2018 at 9:50 PM Du Changbin <changbin.du@gmail.com> wrote:
> >
> > This will apply GCC '-Og' optimization level which is supported
> > since GCC 4.8. This optimization level offers a reasonable level
> > of optimization while maintaining fast compilation and a good
> > debugging experience. It is similar to '-O1' while perferring
> > to keep debug ability over runtime speed.
> >
> > If enabling this option breaks your kernel, you should either
> > disable this or find a fix (mostly in the arch code). Currently
> > this option has only been tested on x86_64 and arm platform.
> >
> > This option can satisfy people who was searching for a method
> > to disable compiler optimizations so to achieve better kernel
> > debugging experience with kgdb or qemu.
> >
> > The main problem of '-Og' is we must not use __attribute__((error(msg))).
> > The compiler will report error though the call to error function
> > still can be optimize out. So we must fallback to array tricky.
> >
> > Comparison of vmlinux size: a bit smaller.
> >
> >     w/o CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
> >     $ size vmlinux
> >        text    data     bss     dec     hex filename
> >     22665554   9709674  2920908 35296136        21a9388 vmlinux
> >
> >     w/ CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
> >     $ size vmlinux
> >        text    data     bss     dec     hex filename
> >     21499032   10102758 2920908 34522698        20ec64a vmlinux
> >
> > Comparison of system performance: a bit drop (~6%).
> >     This benchmark of kernel compilation is suggested by Ingo Molnar.
> >     https://lkml.org/lkml/2018/5/2/74
> >
> >     Preparation: Set cpufreq to 'performance'.
> >     for ((cpu=0; cpu<120; cpu++)); do
> >       G=/sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
> >       [ -f $G ] && echo performance > $G
> >     done
> >
> >     w/o CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
> >     $ perf stat --repeat 5 --null --pre                 '\
> >         cp -a kernel ../kernel.copy.$(date +%s);         \
> >         rm -rf *;                                        \
> >         git checkout .;                                  \
> >         echo 1 > /proc/sys/vm/drop_caches;               \
> >         find ../kernel* -type f | xargs cat >/dev/null;  \
> >         make -j kernel >/dev/null;                       \
> >         make clean >/dev/null 2>&1;                      \
> >         sync                                            '\
> >                                                          \
> >         make -j8 >/dev/null
> >
> >     Performance counter stats for 'make -j8' (5 runs):
> >
> >         219.764246652 seconds time elapsed                   ( +-  0.78% )
> >
> >     w/ CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
> >     $ perf stat --repeat 5 --null --pre                 '\
> >         cp -a kernel ../kernel.copy.$(date +%s);         \
> >         rm -rf *;                                        \
> >         git checkout .;                                  \
> >         echo 1 > /proc/sys/vm/drop_caches;               \
> >         find ../kernel* -type f | xargs cat >/dev/null;  \
> >         make -j kernel >/dev/null;                       \
> >         make clean >/dev/null 2>&1;                      \
> >         sync                                            '\
> >                                                          \
> >         make -j8 >/dev/null
> >
> >     Performance counter stats for 'make -j8' (5 runs):
> >
> >          233.574187771 seconds time elapsed                  ( +-  0.19% )
> >
> > Signed-off-by: Du Changbin <changbin.du@gmail.com>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  Makefile                     |  5 +++++
> >  include/linux/compiler-gcc.h |  2 +-
> >  include/linux/compiler.h     |  2 +-
> >  init/Kconfig                 | 19 +++++++++++++++++++
> >  4 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 757d6507cb5c..ea908cfe8594 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -657,6 +657,10 @@ KBUILD_CFLAGS      += $(call cc-disable-warning, format-truncation)
> >  KBUILD_CFLAGS  += $(call cc-disable-warning, format-overflow)
> >  KBUILD_CFLAGS  += $(call cc-disable-warning, int-in-bool-context)
> >
> > +ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
> > +KBUILD_CFLAGS  += $(call cc-option, -Og)
> 
> 
> This line is a problem.
> 
> As you stated in your patch description, -Og is supported on GCC 4.8+
> but the minimum GCC version supported for Linux kernel is GCC 4.6
> 
> 
> If you use either GCC 4.6 or 4.7,
> $(call cc-option, -Og) is evaluated to empty.
> 
> It means no optimization flag is given to the compiler, then
> the build fails.
> 
> I'd like to suggest to change as follows:
> 
>
Thanks for pointing this out and kind suggestions. I have tested with your
modification. Will update patch serias soon.

> 
> 
> diff --git a/Makefile b/Makefile
> index 122ab74..9af3dc4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -663,7 +663,7 @@ KBUILD_CFLAGS       += $(call cc-disable-warning,
> format-overflow)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, int-in-bool-context)
> 
>  ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
> -KBUILD_CFLAGS  += $(call cc-option, -Og)
> +KBUILD_CFLAGS  += -Og
>  KBUILD_CFLAGS  += $(call cc-disable-warning,maybe-uninitialized,)
>  else
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> diff --git a/init/Kconfig b/init/Kconfig
> index b01c7c6..a0424dc 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1083,6 +1083,7 @@ config CC_OPTIMIZE_FOR_SIZE
> 
>  config CC_OPTIMIZE_FOR_DEBUGGING
>         bool "Optimize for better debugging experience (-Og)"
> +       depends on $(cc-option,-Og)
>         select NO_AUTO_INLINE
>         help
>           This will apply GCC '-Og' optimization level which is supported
> 
> 
> 
> 
> 
> If -Og is unsupported by the compiler, this is hidden from the Kconfig menu.
> 
> 
> 
> Also, in order to fix a warning from 'make tiny.config'
> could you add the following change?
> 
> 
> 
> diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
> index 7fa0c4a..599ea86 100644
> --- a/kernel/configs/tiny.config
> +++ b/kernel/configs/tiny.config
> @@ -1,5 +1,6 @@
>  # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +# CONFIG_CC_OPTIMIZE_FOR_DEBUGGING is not set
>  # CONFIG_KERNEL_GZIP is not set
>  # CONFIG_KERNEL_BZIP2 is not set
>  # CONFIG_KERNEL_LZMA is not set
> 
> 
> 
> 
> 
> 
> 
> > +KBUILD_CFLAGS  += $(call cc-disable-warning,maybe-uninitialized,)
> > +else
> >  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> >  KBUILD_CFLAGS  += $(call cc-option,-Oz,-Os)
> >  KBUILD_CFLAGS  += $(call cc-disable-warning,maybe-uninitialized,)
> > @@ -667,6 +671,7 @@ else
> >  KBUILD_CFLAGS   += -O2
> >  endif
> >  endif
> > +endif
> >
> >  KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
> >                         $(call cc-disable-warning,maybe-uninitialized,))
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > index 4d36b27214fd..2a76f7c64b54 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -85,7 +85,7 @@
> >
> >  #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
> >
> > -#ifndef __CHECKER__
> > +#if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
> >  #define __compiletime_warning(message) __attribute__((warning(message)))
> >  #define __compiletime_error(message) __attribute__((error(message)))
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 681d866efb1e..9385c62e9f00 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -320,7 +320,7 @@ static inline void *offset_to_ptr(const int *off)
> >   * sparse see a constant array size without breaking compiletime_assert on old
> >   * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
> >   */
> > -# ifndef __CHECKER__
> > +# if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
> >  #  define __compiletime_error_fallback(condition) \
> >         do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
> >  # endif
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 1e234e2f1cba..b01c7c654570 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1081,6 +1081,25 @@ config CC_OPTIMIZE_FOR_SIZE
> >
> >           If unsure, say N.
> >
> > +config CC_OPTIMIZE_FOR_DEBUGGING
> > +       bool "Optimize for better debugging experience (-Og)"
> > +       select NO_AUTO_INLINE
> > +       help
> > +         This will apply GCC '-Og' optimization level which is supported
> > +         since GCC 4.8. This optimization level offers a reasonable level
> > +         of optimization while maintaining fast compilation and a good
> > +         debugging experience. It is similar to '-O1' while preferring to
> > +         keep debug ability over runtime speed. The overall performance
> > +         will drop a bit (~6%).
> > +
> > +         Use only if you want to debug the kernel, especially if you want
> > +         to have better kernel debugging experience with gdb facilities
> > +         like kgdb or qemu. If enabling this option breaks your kernel,
> > +         you should either disable this or find a fix (mostly in the arch
> > +         code).
> > +
> > +         If unsure, select N.
> > +
> >  endchoice
> >
> >  config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> > --
> > 2.17.1
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
