Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8C6C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4910920839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fB9bKNXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4910920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeILT7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:59:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38295 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbeILT7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:59:20 -0400
Received: by mail-it0-f65.google.com with SMTP id p129-v6so3413475ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k5V+92Mk2pae4B9LhuCcmaUy962Eq0PEXLKrQvbziRQ=;
        b=fB9bKNXfRlaE18KWq8t4mOT6pqGKfk5oLJqvYdLfqUcdq7lXCTlvLyxGlAmpNsp4pD
         PfbU25iwzQYrI5sIqKuvpkAIMIEOlPanPtUWSoz75y3JvqJovQLZogVF28q9Zj6i0yWU
         myjJW5kX+RBb//5ZSI9GAb2My0OKnmekyofBSugnqJpJT7HUlYl7c/5xu9stONwowv+u
         HzbB4nMxKQvhMI+ImS9mCQzKsvVgjD2/yJYknqSAcRxocJ+XCdtZjlgVc7shnlLWRbxy
         L3oEonKRvCmm5V6qihTvB22ZdCJwwurT7yWHzcn9yD8LSchv8nTDxMB2MH5oIVyssPgl
         3pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k5V+92Mk2pae4B9LhuCcmaUy962Eq0PEXLKrQvbziRQ=;
        b=RxndXjEVDNNkcGX/JtWAh1PJKKG466ttkfUW/Ysm3XajLEfwPIWt4+S7lDrGKaxN2P
         l14z+0QWDtAv08KCWXTTql23Ji1mr1n1sYhNLpxj7umuEQ/B5q1dxS03NHBqZZ1Iyps7
         OBALpSAaQQunutfq5rqrmxDj7Tqwowpm2uk6rkBcSr8AzpQgKGLc4n5KgunWjaa3aP9e
         YguaGh/gF1bOOoJuCo2uMF7d03O2c73R7818Z6LCJXKJoopkSe3PIAY0TlsyNpvnobku
         CdvT1aC37TTj6dMsWJC0zUjyoadJ2umIwVLzLY/Axj+NGC/EPc9fMR28vlIL0tJtKSf1
         w+0g==
X-Gm-Message-State: APzg51DzEfqEfD4898feJsBCM6v3HCEuTrpzDxB6JadebMcry+4BRB8O
        Niu30Y4NIxuTxUDvHBXZXiceGthXiy/mASwBIlgt7g==
X-Google-Smtp-Source: ANB0VdYIgDfcH2L/IcfYXP9gKzej4kJkJoVqTXCBYPB7z8lI52qCiftuCmljLZS/HSupcsmnpCc+pmg3X+j6MGEVHOo=
X-Received: by 2002:a02:c04e:: with SMTP id u14-v6mr2172320jam.110.1536764067365;
 Wed, 12 Sep 2018 07:54:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 07:54:06
 -0700 (PDT)
In-Reply-To: <b4ba65afa55f2fdfd2856fb03c5aba99c7a8bdd7.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com> <b4ba65afa55f2fdfd2856fb03c5aba99c7a8bdd7.1535462971.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Sep 2018 16:54:06 +0200
Message-ID: <CACT4Y+Z4zLSBdXGtk-6nH64UpOVA8s5TJZSpokAqEu4pE8LpCA@mail.gmail.com>
Subject: Re: [PATCH v6 04/18] khwasan, arm64: adjust shadow size for CONFIG_KASAN_HW
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> KWHASAN uses 1 shadow byte for 16 bytes of kernel memory, so it requires
> 1/16th of the kernel virtual address space for the shadow memory.
>
> This commit sets KASAN_SHADOW_SCALE_SHIFT to 4 when KHWASAN is enabled.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/Makefile             |  2 +-
>  arch/arm64/include/asm/memory.h | 13 +++++++++----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 106039d25e2f..17047b8ab984 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -94,7 +94,7 @@ endif
>  # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
>  #                               - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
>  # in 32-bit arithmetic
> -KASAN_SHADOW_SCALE_SHIFT := 3
> +KASAN_SHADOW_SCALE_SHIFT := $(if $(CONFIG_KASAN_HW), 4, 3)
>  KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
>         (0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
>         + (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b96442960aea..f5e262ee76c1 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -74,12 +74,17 @@
>  #define KERNEL_END        _end
>
>  /*
> - * KASAN requires 1/8th of the kernel virtual address space for the shadow
> - * region. KASAN can bloat the stack significantly, so double the (minimum)
> - * stack size when KASAN is in use.
> + * KASAN and KHWASAN require 1/8th and 1/16th of the kernel virtual address


I am somewhat confused by the terminology.
"KASAN" is not actually "CONFIG_KASAN" below, it is actually
"CONFIG_KASAN_GENERIC". While "KHWASAN" translates to "KASAN_HW" few
lines later.
I think we need some consistent terminology for comments and config
names until it's too late.


> + * space for the shadow region respectively. They can bloat the stack
> + * significantly, so double the (minimum) stack size when they are in use.
>   */
> -#ifdef CONFIG_KASAN
> +#ifdef CONFIG_KASAN_GENERIC
>  #define KASAN_SHADOW_SCALE_SHIFT 3
> +#endif
> +#ifdef CONFIG_KASAN_HW
> +#define KASAN_SHADOW_SCALE_SHIFT 4
> +#endif
> +#ifdef CONFIG_KASAN
>  #define KASAN_SHADOW_SIZE      (UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
>  #define KASAN_THREAD_SHIFT     1
>  #else
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
