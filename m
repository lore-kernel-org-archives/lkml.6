Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0D0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E4C2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfAHH5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:57:06 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34689 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHH5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:57:05 -0500
Received: by mail-vs1-f66.google.com with SMTP id y27so1931038vsi.1;
        Mon, 07 Jan 2019 23:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rySBcmuq6MC1aua4zuDq5jYyrsEtfhwGkXLDWTkT/u4=;
        b=MwrEnOyUAIp97AiKfFx5gVb/gLmXYamPfhllx3wvv1AKqukZjWv/gLut78WTj+aNX7
         7p9b7BKycojDBByVYxlU9cBldlg6V9Cbt/9yOk7a1dkioGJDg2eSBzJ7AoVaKVGHd3G/
         ehEnCWC6RIeKeAg/Ywl32dThkN9BRdigCuGCaS1AMkTSKIoSE1F/Km1SDu4urYCW1U7U
         QwSN+ytRJqNUEKZnROJ7Bc+iPNaIhKpeTQwQ5inSI9ZdgITjNQzSiPSkJtKne0nvaBeR
         VRytSPn/hZwXvS+J/rOyxvokv8T8JjHGZ+RShH6p/LpMU1OuE0+7eRRThC0NuXycEtOp
         hsSg==
X-Gm-Message-State: AJcUukcSWjvGfUQ4x4DqkwBfMfb0aCRVCUSiqk9HVnnMwWkLI5kFvauU
        PqXa+ufLjaNh1qosEA0rcMPv+EnrxtY/4DdQjGI=
X-Google-Smtp-Source: ALg8bN7yZ3Ohpnn9jvfWml12rXdCkhly+ugbSQmKYd7Z7sr38oPRiO/6vIQXT6r5clDdWnTRq/yPJYfQdkzkCaU5mn4=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr317002vsm.152.1546934223659;
 Mon, 07 Jan 2019 23:57:03 -0800 (PST)
MIME-Version: 1.0
References: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Jan 2019 08:56:52 +0100
Message-ID: <CAMuHMdU_wUjk=nw9QtWaNGzgb3cCUiKLZpPy+bmcn4qw6zbccw@mail.gmail.com>
Subject: Re: [PATCH] arch: unexport asm/shmparam.h for all architectures
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-riscv@lists.infradead.org, Greentime Hu <green.hu@gmail.com>,
        linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Mark Salter <msalter@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Tue, Jan 8, 2019 at 12:41 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Most architectures do not export shmparam.h to user-space.
>
>   $ find arch -name shmparam.h  | sort
>   arch/alpha/include/asm/shmparam.h
>   arch/arc/include/asm/shmparam.h
>   arch/arm64/include/asm/shmparam.h
>   arch/arm/include/asm/shmparam.h
>   arch/csky/include/asm/shmparam.h
>   arch/ia64/include/asm/shmparam.h
>   arch/mips/include/asm/shmparam.h
>   arch/nds32/include/asm/shmparam.h
>   arch/nios2/include/asm/shmparam.h
>   arch/parisc/include/asm/shmparam.h
>   arch/powerpc/include/asm/shmparam.h
>   arch/s390/include/asm/shmparam.h
>   arch/sh/include/asm/shmparam.h
>   arch/sparc/include/asm/shmparam.h
>   arch/x86/include/asm/shmparam.h
>   arch/xtensa/include/asm/shmparam.h
>
> Strangely, some users of the asm-generic wrapper export shmparam.h
>
>   $ git grep 'generic-y += shmparam.h'
>   arch/c6x/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/h8300/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/hexagon/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/m68k/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/microblaze/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/openrisc/include/uapi/asm/Kbuild:generic-y += shmparam.h
>   arch/riscv/include/asm/Kbuild:generic-y += shmparam.h
>   arch/unicore32/include/uapi/asm/Kbuild:generic-y += shmparam.h
>
> The newly added riscv correctly creates the asm-generic wrapper
> in the kernel space, but the others (c6x, h8300, hexagon, m68k,
> microblaze, openrisc, unicore32) create the one in the uapi directory.
>
> Digging into the git history, now I guess fcc8487d477a ("uapi:
> export all headers under uapi directories") was the misconversion.
> Prior to that commit, no architecture exported to shmparam.h
> As its commit description said, that commit exported shmparam.h
> for c6x, h8300, hexagon, m68k, openrisc, unicore32.
>
> 83f0124ad81e ("microblaze: remove asm-generic wrapper headers")
> accidentally exported shmparam.h for microblaze.
>
> This commit unexports shmparam.h for those architectures.
>
> There is no more reason to export include/uapi/asm-generic/shmparam.h,
> so it has been moved to include/asm-generic/shmparam.h
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks for your patch!

include/uapi/asm-generic/shmparam.h contains a single definition:

    #define SHMLBA PAGE_SIZE         /* attach addr a multiple of this */

So this definition is not used by userspace?

Note that it is refered to by include/uapi/linux/shm.h, albeit in a comment:

    #define SHM_RND         020000  /* round attach address to SHMLBA
boundary */

Glibc provides its own definition in /usr/include/x86_64-linux-gnu/bits/shm.h

    #define SHMLBA (__getpagesize ())

So probably this is safe.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
