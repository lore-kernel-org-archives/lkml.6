Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB8CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A9920878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A9920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeGJHPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:15:32 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43054 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeGJHPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:15:30 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so40669710oib.10;
        Tue, 10 Jul 2018 00:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwKrW6mT4u9JAZLluFBYtFh88wVkaqRFNP7pLqPDvSw=;
        b=AnZ0y2WvtqAoOOt+HXTgwej35jzTE9UkYYVadh3h4qUhJ66gOWrE6xp/vuV4ulGe9O
         6eQnZ5lSilxZdfM40G9hMVYjIUmpimLGnh2KO8Fh2g3yWr0JJa/NwQ6DiZP/Loy8aiGF
         8W6PR+jWc44gi1IVSQ+WPpAYVRZgEyPVbMcx6ft5wtu+1jn8pmS3AOSwaKUhIoJ1d1pv
         cc8aUOAS29CD9V2bsfMnnsL+TCq83zrIdj+Ch2aPnbmpTa8EXd/7uzvpO71tKacCWPub
         VQHG4OhSeJc7J6INyHuO8Z1mKlqlwPnGZXV8+zsD/paW5rn5KUnotPcHre/vIW8EMl9i
         0sLw==
X-Gm-Message-State: APt69E0QlkxOyzQH0koL5xpAe+zxXwmEJwF3lS6fP0E/9tZ9TqvRurSH
        Axa5+ZU2rE4PfMDsy6U9ZZtIwn4z1yoL3saSjZsG1A2W
X-Google-Smtp-Source: AAOMgpeb/ovXsMPVl9nZNvQHJMFLUCKwpfMnxiISzdezqDVswi3v60twltm9p8wzsd+8ZtEXC6ydWspX177f6lSdx5c=
X-Received: by 2002:aca:758c:: with SMTP id q134-v6mr28498734oic.334.1531206930180;
 Tue, 10 Jul 2018 00:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180709135713.8083-1-fancer.lancer@gmail.com> <20180709135713.8083-2-fancer.lancer@gmail.com>
In-Reply-To: <20180709135713.8083-2-fancer.lancer@gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 10 Jul 2018 09:15:17 +0200
Message-ID: <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated() method
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'
On Mon, Jul 9, 2018 at 3:57 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Adaptive ioremap_wc() method is now available (see "mips: mm:
> Create UCA-based ioremap_wc() method" commit). We can use it for
> UCA-featured MMIO transactions in the kernel, so we don't need
> it platform clone ioremap_uncached_accelerated() being declard.
> Seeing it is also unused anywhere in the kernel code, lets remove
> it from io.h arch-specific header then.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Singed-off-by: Paul Burton <paul.burton@mips.com>

nit: 'Signed' (on both patches)

> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: stable@vger.kernel.org
> ---
>  arch/mips/include/asm/io.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index babe5155a..360b7ddeb 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -301,15 +301,11 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
>         __ioremap_mode((offset), (size), boot_cpu_data.writecombine)
>
>  /*
> - * These two are MIPS specific ioremap variant.         ioremap_cacheable_cow
> - * requests a cachable mapping, ioremap_uncached_accelerated requests a
> - * mapping using the uncached accelerated mode which isn't supported on
> - * all processors.
> + * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
> + * requests a cachable mapping with CWB attribute enabled.
>   */
>  #define ioremap_cacheable_cow(offset, size)                            \
>         __ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
> -#define ioremap_uncached_accelerated(offset, size)                     \
> -       __ioremap_mode((offset), (size), _CACHE_UNCACHED_ACCELERATED)
>
>  static inline void iounmap(const volatile void __iomem *addr)
>  {
> --
> 2.12.0
>
>
