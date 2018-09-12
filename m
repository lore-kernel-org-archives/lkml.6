Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1442C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939A62087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qc3kFkn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939A62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeILVji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:39:38 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54793 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeILVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:39:36 -0400
Received: by mail-it0-f65.google.com with SMTP id f14-v6so3892967ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SEPUNIoWs+8n6i1U3lSMw7VuF0p8mN5nUH0mXmHtrC8=;
        b=qc3kFkn7jHpRQFeUG6CYZtIxWbRE7ahk6yk7Jp0UQqpW7AOPcX65OOPX2bUOCXwIdK
         SDH8hGATezYs8qzjKfamL6uU8bHPmgehSMI+o6vz5UYHUsQrOtu7Qun21UzOKXREQFM0
         suDgIsEfrT/boN2MvRC1cfkddpvub4sNi5C5gTinahPzYsfkDIE0iWLFC0DWpvSdaaQ0
         t2jFzC5qxz969rLd53OaQzq4LaO53l4Ywp/tskSj0ugh5hQJDBn4EIMuOWToxBejRCLh
         D7zbYKQeCZOozLuBOlGEaF30KIi3PmIVwKeGKKWNrEpsO4tw0oGL+/1bMUtuQcfKvtmC
         e2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SEPUNIoWs+8n6i1U3lSMw7VuF0p8mN5nUH0mXmHtrC8=;
        b=KmG3BOO2oJmra9RxhiB/VWjewFp1fOYXW1flp+NrMOHc6xUzhG8Dz/TboUNsqA2Uc3
         F1JnuVX0fjOc4itV4cLOaKSNl11rR8fpcepjxqIl9rqwOy0YbhYVTL29ue/AzYQ6qSDE
         0z5cxn+i/PXT7owo8ZwNbavHQQSTGeekz87VSq4+mN65rvTSeAcAKyaPCRiQykAdixZJ
         8c8SN7kNaL2CvvXpNAmzlhvaAsjw/sVbT8RotrghoOm6JhUFmJdNaD5uetVfeGkZBq32
         fqlybEYPULyJx+sAzwyj3MytVWv2AcEaTvPYhfjgAGQGUPtHu5ibaOKcewJ/LQFzaQb4
         AmEQ==
X-Gm-Message-State: APzg51BHmxT8xc0F6vqLSnR/J+9R86pKttBB0/tuoUyNX+Vp2aK9I6gw
        UZKr32HheAJbFSYLk0u39qBgVX/QGSkCcD+Ar3kw4w==
X-Google-Smtp-Source: ANB0VdZPwstKVjOZWuUIEPZwLLjNMSw36JUNshBL+4clfrHR1kTaG+sktuEAL++18THBOBSNMLfZVfeeDG4bkKJVEPg=
X-Received: by 2002:a02:49cf:: with SMTP id p76-v6mr2679798jad.25.1536770056451;
 Wed, 12 Sep 2018 09:34:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 09:33:56
 -0700 (PDT)
In-Reply-To: <19d757c2cafc277f0143a8ac34e179061f3487f5.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com> <19d757c2cafc277f0143a8ac34e179061f3487f5.1535462971.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Sep 2018 18:33:56 +0200
Message-ID: <CACT4Y+aJ36LGLG=TVOGQoJ+fB4Xc9CjdxAs8KZpUm3AsNEoHFw@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] khwasan, arm64: untag virt address in
 __kimg_to_phys and _virt_addr_is_linear
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
> __kimg_to_phys (which is used by virt_to_phys) and _virt_addr_is_linear
> (which is used by virt_addr_valid) assume that the top byte of the address
> is 0xff, which isn't always the case with KHWASAN enabled.
>
> The solution is to reset the tag in those macros.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/include/asm/memory.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index f5e262ee76c1..f5e2953b7009 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -92,6 +92,13 @@
>  #define KASAN_THREAD_SHIFT     0
>  #endif
>
> +#ifdef CONFIG_KASAN_HW
> +#define KASAN_TAG_SHIFTED(tag)         ((unsigned long)(tag) << 56)
> +#define KASAN_SET_TAG(addr, tag)       (((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
> +                                               KASAN_TAG_SHIFTED(tag))
> +#define KASAN_RESET_TAG(addr)          KASAN_SET_TAG(addr, 0xff)
> +#endif
> +


Wouldn't it be better to
#define KASAN_RESET_TAG(addr) addr
when CONFIG_KASAN_HW is not enabled, and then not duplicate the macros
below? That's what we do in kasan.h for all hooks.
I see that a subsequent patch duplicates yet another macro in this
file. While we could use:

#define __kimg_to_phys(addr)   (KASAN_RESET_TAG(addr) - kimage_voffset)

with and without kasan. Duplicating them increases risk that somebody
will change only the non-kasan version but forget kasan version.



>  #define MIN_THREAD_SHIFT       (14 + KASAN_THREAD_SHIFT)
>
>  /*
> @@ -232,7 +239,12 @@ static inline unsigned long kaslr_offset(void)
>  #define __is_lm_address(addr)  (!!((addr) & BIT(VA_BITS - 1)))
>
>  #define __lm_to_phys(addr)     (((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
> +
> +#ifdef CONFIG_KASAN_HW
> +#define __kimg_to_phys(addr)   (KASAN_RESET_TAG(addr) - kimage_voffset)
> +#else
>  #define __kimg_to_phys(addr)   ((addr) - kimage_voffset)
> +#endif
>
>  #define __virt_to_phys_nodebug(x) ({                                   \
>         phys_addr_t __x = (phys_addr_t)(x);                             \
> @@ -308,7 +320,13 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #endif
>  #endif
>
> +#ifdef CONFIG_KASAN_HW
> +#define _virt_addr_is_linear(kaddr)    (KASAN_RESET_TAG((u64)(kaddr)) >= \
> +                                               PAGE_OFFSET)
> +#else
>  #define _virt_addr_is_linear(kaddr)    (((u64)(kaddr)) >= PAGE_OFFSET)
> +#endif
> +
>  #define virt_addr_valid(kaddr)         (_virt_addr_is_linear(kaddr) && \
>                                          _virt_addr_valid(kaddr))
>
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
