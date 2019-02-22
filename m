Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578ECC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDDB2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdZGNswt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfBVPu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:50:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40473 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfBVPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:50:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id u9so1302759pgo.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 07:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GP10BU9F6M7h1OqrL4MqRJyEJPhQSevvarcmyutmZTU=;
        b=vdZGNswtb7AJLs0rpIS2e0Ol5X2dIcIZSFoxgZdR7B92zRX1At+V6fNmMIbgLXXkes
         w68sSJ9Wwf6dfIEL4dep1+IgYx/kvmKziEJCGudoY78EFdrWxSQOi59iqj3qRleNoRJ2
         iKd0DegWZvhq4XWJJ+sD7CpfJOGR0k2Nxa+vL1k7pI1RA6A7CDBueuYF6Zn8280Rte8g
         2lUfmwPD+ByKBC5jPGPg/ooBe7PKW3pENi3yPjy7wHJtPiKuaUBCCjtTcSyerF3Hyf52
         W1DkMFZlZ8KaimKOkVC0GB5msOZ5KomIMddlxcKNTWWyKWOnrbRlJtLAdBViocUS1sOC
         k+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GP10BU9F6M7h1OqrL4MqRJyEJPhQSevvarcmyutmZTU=;
        b=BUDNzNG3xs2MNPH2cF+Ohys2PNp8Pez+rHilFyMGPJ9Jn2VK69IPhSgjgftYJl0/4y
         44sBD3tJwnedP+KBQBUM5N3zn2xMql+96Jww5+cdISTov4QC3lbuBGBgrHeWX1yYZujm
         RYPTyl7NCSU/lTywTPp7fvzzExP9/odRGL+puCiPnXNqhFFlYi5wOW2IiWsl0L7llG7G
         J8+w9WkjVjkYFY7TUE5nA4RgK0ZrCVKsZqpYbWoQFws3iOQRQlApmuY8I25N3eQbRkso
         E26GONww8bcXyB30hvF3U/sphbu+Wt7+jZSVG/CFmUjnTf6tM5qg+JhYAdbztn++oQt3
         zHIQ==
X-Gm-Message-State: AHQUAubZ657QmnVFR8IcnoREqYni9mZ8QkadBmG3kXpsJU4suz3jP0Pz
        Et+VaggYBK7eo02F+gh1VdkiBoUrCBlyJpzrERqgEA==
X-Google-Smtp-Source: AHgI3IYAVx2dXfXXUnziI0AYtr425fVqA5adqxqZTqupFmBYgMgDkPejFZaFhcH12ib2zsUSh1lM9ss5E7447NCmdag=
X-Received: by 2002:a65:6651:: with SMTP id z17mr4330628pgv.95.1550850657657;
 Fri, 22 Feb 2019 07:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20190222144301.3516708-1-arnd@arndb.de>
In-Reply-To: <20190222144301.3516708-1-arnd@arndb.de>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 22 Feb 2019 16:50:46 +0100
Message-ID: <CAAeHK+zDVHqTMAqDGG1sAhvXCbAWun7yHwN=HJ1VBjtoA0aROw@mail.gmail.com>
Subject: Re: [PATCH] arm64: avoid clang warning about self-assignment
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, natechancellor@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 3:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building a preprocessed source file for arm64 now always produces
> a warning with clang because of the page_to_virt() macro assigning
> a variable to itself.
>
> Adding a new temporary variable avoids this issue.
>
> Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via pagealloc")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

> ---
>  arch/arm64/include/asm/memory.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b01ef0180a03..290195168bb3 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -312,8 +312,9 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define page_to_virt(page)     ({                                      \
>         unsigned long __addr =                                          \
>                 ((__page_to_voff(page)) | PAGE_OFFSET);                 \
> -       __addr = __tag_set(__addr, page_kasan_tag(page));               \
> -       ((void *)__addr);                                               \
> +       unsigned long __addr_tag =                                      \
> +                __tag_set(__addr, page_kasan_tag(page));               \
> +       ((void *)__addr_tag);                                           \
>  })
>
>  #define virt_to_page(vaddr)    ((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
> --
> 2.20.0
>
