Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5EFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ECD2073F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eC5v+w/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfACAiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:38:02 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:21443 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfACAiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:38:01 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x030bk6d020197
        for <linux-kernel@vger.kernel.org>; Thu, 3 Jan 2019 09:37:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x030bk6d020197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546475867;
        bh=jWtuHI7ym96qkvTiOoRY/yS6BGWhQVQGbMbaIkh6Ajc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eC5v+w/1IQcVrjvoZTjo7BJqjm+RXkrmaH0J4iW2iNHCavQvLMwJQ5qrMn6Vo/SLc
         A75GWnLmDmvXfaznqyD4fD9GFjGwk0pbC/21rM7Lg/Y57K9mq1a5FOjmh5Mm/TXc9N
         Tclia0ZNp6qwQUc83Ezno+DCFOYLM6Fafxocttw3VkHPujETzAbudi1drrns6zEJln
         Ehik1mzJnnSXfe2rOYFjTt6TnrYfWufOUZH6dStB7aRnYnVTjRKFTrv/ZM46U1iC9x
         UJiMiwsPuYLNpdO+ftQusXV2ab7k/HTWR/iSeme0kyuvq8QeM6jZUSdITfR7VKfjZd
         GYO13ONIMP54A==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id t8so10470138uap.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 16:37:46 -0800 (PST)
X-Gm-Message-State: AJcUukfcFdJ2EYEGgdLGHjvp5iizbOJuOfoW/K9YvLOvsb+KFe08IXOV
        g1db/HjCKGIAzSuUWoWtptpQrGovE5V67RkeWx0=
X-Google-Smtp-Source: ALg8bN4z+J5tbP4cC6mKH3CtcIUqcXpNwKVgmFBnZfVUeyE8gnfdALvAhyX8W2V6UOPMxgPOgjlcUQyptIWtaXsHpjk=
X-Received: by 2002:ab0:66d1:: with SMTP id d17mr3523734uaq.89.1546475865848;
 Wed, 02 Jan 2019 16:37:45 -0800 (PST)
MIME-Version: 1.0
References: <1544969651-14403-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544969651-14403-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Jan 2019 09:37:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHwXW_k9bvhKgMndEvhmn38L60RCi2wg1YdqnCnUpROw@mail.gmail.com>
Message-ID: <CAK7LNATHwXW_k9bvhKgMndEvhmn38L60RCi2wg1YdqnCnUpROw@mail.gmail.com>
Subject: Re: [PATCH] nds32: remove redundant kernel-space generic-y
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nickhu <nickhu@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 11:49 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This commit removes redundant generic-y defines in
> arch/nds32/include/asm/Kbuild.
>
> [1] It is redundant to define the same generic-y in both
>     arch/$(ARCH)/include/asm/Kbuild and
>     arch/$(ARCH)/include/uapi/asm/Kbuild.
>
>     Remove the following generic-y:
>
>       bitsperlong.h
>       bpf_perf_event.h
>       errno.h
>       fcntl.h
>       ioctl.h
>       ioctls.h
>       mman.h
>       shmbuf.h
>       stat.h
>
> [2] It is redundant to define generic-y when arch-specific
>     implementation exists in arch/$(ARCH)/include/asm/*.h
>
>     Remove the following generic-y:
>
>       ftrace.h
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.


>
>  arch/nds32/include/asm/Kbuild | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
> index f81b633..64ceff7 100644
> --- a/arch/nds32/include/asm/Kbuild
> +++ b/arch/nds32/include/asm/Kbuild
> @@ -1,8 +1,6 @@
>  generic-y += asm-offsets.h
>  generic-y += atomic.h
>  generic-y += bitops.h
> -generic-y += bitsperlong.h
> -generic-y += bpf_perf_event.h
>  generic-y += bug.h
>  generic-y += bugs.h
>  generic-y += checksum.h
> @@ -16,17 +14,12 @@ generic-y += div64.h
>  generic-y += dma.h
>  generic-y += dma-mapping.h
>  generic-y += emergency-restart.h
> -generic-y += errno.h
>  generic-y += exec.h
>  generic-y += export.h
>  generic-y += fb.h
> -generic-y += fcntl.h
> -generic-y += ftrace.h
>  generic-y += gpio.h
>  generic-y += hardirq.h
>  generic-y += hw_irq.h
> -generic-y += ioctl.h
> -generic-y += ioctls.h
>  generic-y += irq.h
>  generic-y += irq_regs.h
>  generic-y += irq_work.h
> @@ -38,7 +31,6 @@ generic-y += limits.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mm-arch-hooks.h
> -generic-y += mman.h
>  generic-y += parport.h
>  generic-y += pci.h
>  generic-y += percpu.h
> @@ -46,9 +38,7 @@ generic-y += preempt.h
>  generic-y += sections.h
>  generic-y += segment.h
>  generic-y += serial.h
> -generic-y += shmbuf.h
>  generic-y += sizes.h
> -generic-y += stat.h
>  generic-y += switch_to.h
>  generic-y += timex.h
>  generic-y += topology.h
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
