Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2211DC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B582B216F6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aR5+7Lxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B582B216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeHEKTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 06:19:49 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40426 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeHEKTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 06:19:48 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so8482689iob.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mKl5iCULWG/QQNgt2Hom1+IXP+JXntiV600kFrjbwvE=;
        b=aR5+7Lxtn36lHlhNBG7UENHI9kxr6X5eBW9Olrj+PfD9iWylXCjl4tBDGlUYe2LC+6
         9h9K6PROHprxLcskVK3V4Ei6FON86cNBRMWLYMxF5whL3X44h9IEpBdun3nLFxq0SqjS
         rY7qjTOpkmlhGzZ+ma/rIw8h5vQ/1Vg0AYO5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mKl5iCULWG/QQNgt2Hom1+IXP+JXntiV600kFrjbwvE=;
        b=Ujer9Y+4KB6AYl4sHh/HqKjamKXnwzKBOfdlg5GO2FRto/Xe5ACEjIhqAZ8iBOSsON
         JWzkpqw5i7nYQ4KJjTiLGUEnCA6rx582MqF9+h3R6hdB0HnWVOotX3xt+FNWYHR2IR04
         OrriO7Gc2b5o3zp1//YpDKkiEF3/rTPri+NHfb1UNeYbPOxscj2iKZs2Tfc40ySvqUgB
         3bVXy6IgTdFr0jwjWLt4aqz14f9qxoQLhdAJNJTtByDHYuOmpE1pLW2EyWDxvOK/Dsjv
         aRSYjFcq7nyHFyynkidZRiURrMK1uwXhiGreNt9PZ0uT6yBwqwkjnyu/NY8fysaf3azd
         ZRpg==
X-Gm-Message-State: AOUpUlGnIB8MBy3AQYnrWHq9flGVkpNs8MOAY+f0SA+jDFj9/5XbXWVK
        qJqZrnlFyiKqor55hh7/22lQcFX4B2oc73kWRgksOA==
X-Google-Smtp-Source: AA+uWPzSG3aFKOoWgX/WvOXySkrsn4N++DvKQUvzh1q6Hbtks2NhrWQVOsAHM/y8pQWIKy4Wn4EWeignYODD4mTf+60=
X-Received: by 2002:a6b:5208:: with SMTP id g8-v6mr11997231iob.60.1533456964357;
 Sun, 05 Aug 2018 01:16:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 01:16:03 -0700 (PDT)
In-Reply-To: <20180805032119.20485-2-jlee@suse.com>
References: <20180805032119.20485-1-jlee@suse.com> <20180805032119.20485-2-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 5 Aug 2018 10:16:03 +0200
Message-ID: <CAKv+Gu-zMbPQe6UtrDxoOX6Csfu9xturNVs2rrhd7c=NRzghVg@mail.gmail.com>
Subject: Re: [PATCH 1/6] x86/KASLR: make getting random long number function public
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 August 2018 at 05:21, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> Separating the functions for getting random long number from KASLR
> to x86 library, then it can be used to generate random long for
> EFI root key.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Ryan Chen <yu.chen.surf@gmail.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Not my call to make perhaps, but i'm nacking it anyway.

Playing games with counters and other low entropy inputs may have been
acceptable for kaslr on x86 when it was first introduced, but using it
to generate symmetric keys is really out of the question.

On modern x86, i suppose rdrand is a given, and these days we have
EFI_RNG_PROTOCOL as well (and an open source UEFI driver for ChasoKey,
btw - perhaps we should try and get MS to sign that?), although I'm
not sure whether any x86 support this out of the box now.

BTW using low entropy inputs on top of rdrand or EFI_RNG_PROTOCOL is
fine, if you're paranoid, but if you have neither of those, you should
really fail the call.


> ---
>  arch/x86/boot/compressed/kaslr.c | 21 -------------
>  arch/x86/boot/compressed/misc.c  | 17 ++++++++++
>  arch/x86/boot/compressed/misc.h  |  6 ++++
>  arch/x86/lib/kaslr.c             | 61 ++---------------------------------
>  arch/x86/lib/random.c            | 68 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 93 insertions(+), 80 deletions(-)
>  create mode 100644 arch/x86/lib/random.c
>
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index b87a7582853d..0f40d2178ebc 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -33,13 +33,11 @@
>  #include "error.h"
>  #include "../string.h"
>
> -#include <generated/compile.h>
>  #include <linux/module.h>
>  #include <linux/uts.h>
>  #include <linux/utsname.h>
>  #include <linux/ctype.h>
>  #include <linux/efi.h>
> -#include <generated/utsrelease.h>
>  #include <asm/efi.h>
>
>  /* Macros used by the included decompressor code below. */
> @@ -57,25 +55,6 @@ extern unsigned long get_cmd_line_ptr(void);
>  /* Used by PAGE_KERN* macros: */
>  pteval_t __default_kernel_pte_mask __read_mostly = ~0;
>
> -/* Simplified build-specific string for starting entropy. */
> -static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
> -               LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
> -
> -static unsigned long rotate_xor(unsigned long hash, const void *area,
> -                               size_t size)
> -{
> -       size_t i;
> -       unsigned long *ptr = (unsigned long *)area;
> -
> -       for (i = 0; i < size / sizeof(hash); i++) {
> -               /* Rotate by odd number of bits and XOR. */
> -               hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
> -               hash ^= ptr[i];
> -       }
> -
> -       return hash;
> -}
> -
>  /* Attempt to create a simple but unpredictable starting entropy. */
>  static unsigned long get_boot_seed(void)
>  {
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 8dd1d5ccae58..eb0ab9cad4e4 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -426,3 +426,20 @@ void fortify_panic(const char *name)
>  {
>         error("detected buffer overflow");
>  }
> +
> +#if CONFIG_RANDOMIZE_BASE
> +unsigned long rotate_xor(unsigned long hash, const void *area,
> +                       size_t size)
> +{
> +       size_t i;
> +       unsigned long *ptr = (unsigned long *)area;
> +
> +       for (i = 0; i < size / sizeof(hash); i++) {
> +               /* Rotate by odd number of bits and XOR. */
> +               hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
> +               hash ^= ptr[i];
> +       }
> +
> +       return hash;
> +}
> +#endif
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index a423bdb42686..957f327ad83c 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -70,6 +70,8 @@ int cmdline_find_option_bool(const char *option);
>
>
>  #if CONFIG_RANDOMIZE_BASE
> +#include <generated/compile.h>
> +#include <generated/utsrelease.h>
>  /* kaslr.c */
>  void choose_random_location(unsigned long input,
>                             unsigned long input_size,
> @@ -78,6 +80,10 @@ void choose_random_location(unsigned long input,
>                             unsigned long *virt_addr);
>  /* cpuflags.c */
>  bool has_cpuflag(int flag);
> +/* Simplified build-specific string for starting entropy. */
> +static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
> +               LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
> +unsigned long rotate_xor(unsigned long hash, const void *area, size_t size);
>  #else
>  static inline void choose_random_location(unsigned long input,
>                                           unsigned long input_size,
> diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
> index 79778ab200e4..29ed9bfde5a5 100644
> --- a/arch/x86/lib/kaslr.c
> +++ b/arch/x86/lib/kaslr.c
> @@ -26,67 +26,10 @@
>  #define get_boot_seed() kaslr_offset()
>  #endif
>
> -#define I8254_PORT_CONTROL     0x43
> -#define I8254_PORT_COUNTER0    0x40
> -#define I8254_CMD_READBACK     0xC0
> -#define I8254_SELECT_COUNTER0  0x02
> -#define I8254_STATUS_NOTREADY  0x40
> -static inline u16 i8254(void)
> -{
> -       u16 status, timer;
> -
> -       do {
> -               outb(I8254_PORT_CONTROL,
> -                    I8254_CMD_READBACK | I8254_SELECT_COUNTER0);
> -               status = inb(I8254_PORT_COUNTER0);
> -               timer  = inb(I8254_PORT_COUNTER0);
> -               timer |= inb(I8254_PORT_COUNTER0) << 8;
> -       } while (status & I8254_STATUS_NOTREADY);
> -
> -       return timer;
> -}
> +#include "random.c"
>
>  unsigned long kaslr_get_random_long(const char *purpose)
>  {
> -#ifdef CONFIG_X86_64
> -       const unsigned long mix_const = 0x5d6008cbf3848dd3UL;
> -#else
> -       const unsigned long mix_const = 0x3f39e593UL;
> -#endif
> -       unsigned long raw, random = get_boot_seed();
> -       bool use_i8254 = true;
> -
> -       debug_putstr(purpose);
>         debug_putstr(" KASLR using");
> -
> -       if (has_cpuflag(X86_FEATURE_RDRAND)) {
> -               debug_putstr(" RDRAND");
> -               if (rdrand_long(&raw)) {
> -                       random ^= raw;
> -                       use_i8254 = false;
> -               }
> -       }
> -
> -       if (has_cpuflag(X86_FEATURE_TSC)) {
> -               debug_putstr(" RDTSC");
> -               raw = rdtsc();
> -
> -               random ^= raw;
> -               use_i8254 = false;
> -       }
> -
> -       if (use_i8254) {
> -               debug_putstr(" i8254");
> -               random ^= i8254();
> -       }
> -
> -       /* Circular multiply for better bit diffusion */
> -       asm(_ASM_MUL "%3"
> -           : "=a" (random), "=d" (raw)
> -           : "a" (random), "rm" (mix_const));
> -       random += raw;
> -
> -       debug_putstr("...\n");
> -
> -       return random;
> +       return get_random_long(purpose);
>  }
> diff --git a/arch/x86/lib/random.c b/arch/x86/lib/random.c
> new file mode 100644
> index 000000000000..f2fe6a784c98
> --- /dev/null
> +++ b/arch/x86/lib/random.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <asm/io.h>
> +#include <asm/archrandom.h>
> +
> +#define I8254_PORT_CONTROL     0x43
> +#define I8254_PORT_COUNTER0    0x40
> +#define I8254_CMD_READBACK     0xC0
> +#define I8254_SELECT_COUNTER0  0x02
> +#define I8254_STATUS_NOTREADY  0x40
> +static inline u16 i8254(void)
> +{
> +       u16 status, timer;
> +
> +       do {
> +               outb(I8254_PORT_CONTROL,
> +                    I8254_CMD_READBACK | I8254_SELECT_COUNTER0);
> +               status = inb(I8254_PORT_COUNTER0);
> +               timer  = inb(I8254_PORT_COUNTER0);
> +               timer |= inb(I8254_PORT_COUNTER0) << 8;
> +       } while (status & I8254_STATUS_NOTREADY);
> +
> +       return timer;
> +}
> +
> +static unsigned long get_random_long(const char *purpose)
> +{
> +#ifdef CONFIG_X86_64
> +       const unsigned long mix_const = 0x5d6008cbf3848dd3UL;
> +#else
> +       const unsigned long mix_const = 0x3f39e593UL;
> +#endif
> +       unsigned long raw, random = get_boot_seed();
> +       bool use_i8254 = true;
> +
> +       debug_putstr(purpose);
> +
> +       if (has_cpuflag(X86_FEATURE_RDRAND)) {
> +               debug_putstr(" RDRAND");
> +               if (rdrand_long(&raw)) {
> +                       random ^= raw;
> +                       use_i8254 = false;
> +               }
> +       }
> +
> +       if (has_cpuflag(X86_FEATURE_TSC)) {
> +               debug_putstr(" RDTSC");
> +               raw = rdtsc();
> +
> +               random ^= raw;
> +               use_i8254 = false;
> +       }
> +
> +       if (use_i8254) {
> +               debug_putstr(" i8254");
> +               random ^= i8254();
> +       }
> +
> +       /* Circular multiply for better bit diffusion */
> +       asm(_ASM_MUL "%3"
> +           : "=a" (random), "=d" (raw)
> +           : "a" (random), "rm" (mix_const));
> +       random += raw;
> +
> +       debug_putstr("...\n");
> +
> +       return random;
> +}
> --
> 2.13.6
>
