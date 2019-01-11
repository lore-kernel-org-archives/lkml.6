Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD4DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6222177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1qkV2mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbfAKOWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:22:47 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52555 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732713AbfAKOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:22:43 -0500
Received: by mail-it1-f195.google.com with SMTP id g76so2682406itg.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thXQpdJWQZ/pTw+bOVc6yKkxMnQgTw767BVi3ucL5wo=;
        b=H1qkV2mpWBrnKbWhNU0h15hRnudYfHLkV0JuuAT8ZI3tB0DXJFaeUeHiyg/SY3s+uH
         QwAC+D3/MKTe9L99ka65jr3UsWolVXkKb8wmYgCgdfDhGo4WO9wxe/EA2eUo3H47L/ve
         5pW0PEDq1JbrzWny0gprxPkvjjWibgbTWH/8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thXQpdJWQZ/pTw+bOVc6yKkxMnQgTw767BVi3ucL5wo=;
        b=R1fYkwaky1WKHpBDX13SG0vewRI9pv0WDFMjZzGYCxGMGIuVx0zrSCR0TWZaBPuDOZ
         ArtRbuodXp9CikePLHf8O3mbsdhjJblbMn5J9cZp91oaiqAo4kuvh1lCFZrfXB89/Esz
         d5dYTXWyuqYCCL3aCBlITxudPl03WK1+BFOqKs4XdRUoXqdLng1kkag9uqKn66L+lQa5
         Ap2U40yRMVsnULg47Ah9oY6DpcA9b6O27kjJQJQtitb6bgo3rFeI14h4zV/mNipvfwuJ
         7mGWYG5qS4nn3AIiVPxN6XVHYcn1SbStDqXOrz6ZQdm7JmWl5BQwtzWWjA5tKZ28IzXk
         9mng==
X-Gm-Message-State: AJcUukf5YmsxkaxYp2sdib58BciN4nE/K9ziAMJ1/1Couw1eRhN07JZx
        LmIFSE92zwlGgYCc769DAlcBOJJ+kKdZMObI4R/e9Q==
X-Google-Smtp-Source: ALg8bN6dcpYmsb8edqQg81GBagPiKfCZ/EdmgYuLrWRgVbJfXZqrIK3kZoACtVt9KZdZJ/0mv59Jb+XepJ6Xqc6FuJ8=
X-Received: by 2002:a24:710:: with SMTP id f16mr1106990itf.121.1547216562905;
 Fri, 11 Jan 2019 06:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20190111074614.GA68053@gmail.com>
In-Reply-To: <20190111074614.GA68053@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 11 Jan 2019 15:22:35 +0100
Message-ID: <CAKv+Gu8oY6VFeuH3T0FU452W-rKGGQk3top5kEbuP2aCxzJTCQ@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fix
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 at 08:46, Ingo Molnar <mingo@kernel.org> wrote:
>
> Linus,
>
> Please pull the latest efi-urgent-for-linus git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus
>
>    # HEAD: b12f5440d8ca02e8f9ab4f1461f9214295cc4f66 Merge branch 'linus' into efi/urgent, to resolve conflict
>
> A single fix that adds an annotation to resolve a kmemleak false
> positive.
>
>  Thanks,
>
>         Ingo
>
> ------------------>
> Qian Cai (1):
>       efi: Let kmemleak ignore false positives
>
>
>  drivers/firmware/efi/efi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 4c46ff6f2242..7ac09dd8f268 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -31,6 +31,7 @@
>  #include <linux/acpi.h>
>  #include <linux/ucs2_string.h>
>  #include <linux/memblock.h>
> +#include <linux/kmemleak.h>
>
>  #include <asm/early_ioremap.h>
>
> @@ -1026,6 +1027,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>         if (!rsv)
>                 return -ENOMEM;
>
> +       kmemleak_ignore(rsv);
> +
>         rsv->size = EFI_MEMRESERVE_COUNT(PAGE_SIZE);
>         atomic_set(&rsv->count, 1);
>         rsv->entry[0].base = addr;

I was hoping we could merge this patch (so we can backport it), but
resolve the conflict by dropping the kmemleak_ignore() again, since it
will now complain since the kmalloc() has been replaced with a
__get_free_page() in the mean time (if that makes sense)
