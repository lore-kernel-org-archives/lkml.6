Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E1C37C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2F020020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dnv9yzVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2F020020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935811AbeFMOcP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:32:15 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:26682 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935560AbeFMOcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:32:11 -0400
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com [209.85.217.181]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w5DEW7eX002959;
        Wed, 13 Jun 2018 23:32:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w5DEW7eX002959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528900328;
        bh=duFpFEqOiSgR5OHgZmhEdtOwJ2GQvFfhQmrfWtc6Bbw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dnv9yzVJEhTAuYHc+XC/fHx0eR3W/09Ng7nWgecW8iooCN9t+K4iqYwn8+Mx+kpNQ
         NZVAbLMg31AsFxi1sr7VT2Gl4DTET7M5ZAjhxCUHW+V9JPyw82Dk2liXDBCd+nzwlU
         B0tywYoLGcFAfd9N8rS3uLMjMmuzvAjpVmbbe2Cc3vytTLZ0+khq28rHkZowQjzHw0
         Wiv1h/5bRyNdzZP8G4xZtqjnAq/8F0DhYxRlyMuFdLs2xnsqhLtuIyyBMWMC88DLvb
         +J0UiXhYvFpHrS0b6IbCytFKBdaPuAwtQKMG46IN6hd5mlBpeEeRyPKCi8k6pzEoay
         f/qdxoRitsjyw==
X-Nifty-SrcIP: [209.85.217.181]
Received: by mail-ua0-f181.google.com with SMTP id k14-v6so1843415uao.12;
        Wed, 13 Jun 2018 07:32:07 -0700 (PDT)
X-Gm-Message-State: APt69E0RtMF7Eha5Cds/D7pwkhDP6nwnrZzwYJ47cM6yVFaHhICj2tHQ
        zNI/X8hQVmTMdsM/2R9pGD300RGuic2YeBQy3v8=
X-Google-Smtp-Source: ADUXVKLGlzoxmwSU6FGP6HbX2xhHvzh5BRKIX1PN2YBlyeFblDWYh2ncrDbyaELfqyd0iVhT2KALv4XCFxQd70ynqng=
X-Received: by 2002:ab0:7089:: with SMTP id m9-v6mr3427152ual.141.1528900326488;
 Wed, 13 Jun 2018 07:32:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 07:31:25
 -0700 (PDT)
In-Reply-To: <1525852402-29269-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525852402-29269-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Jun 2018 23:31:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjBYQ1YKGnFodng8uibRDuJ+D9iD4OLQ-qE_8xYOv6Ww@mail.gmail.com>
Message-ID: <CAK7LNAQjBYQ1YKGnFodng8uibRDuJ+D9iD4OLQ-qE_8xYOv6Ww@mail.gmail.com>
Subject: Re: [PATCH] sh: remove no-op macro VMLINUX_SYMBOL()
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-09 16:53 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
> is defined.  It has ever been selected only by BLACKFIN and METAG.
> VMLINUX_SYMBOL() is unneeded for SuperH-specific code.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---



For information for SH maintainers just in case.

I already picked up this patch to my Kbuild tree.

Thanks.



>  arch/sh/include/asm/vmlinux.lds.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sh/include/asm/vmlinux.lds.h b/arch/sh/include/asm/vmlinux.lds.h
> index f312813..9929556 100644
> --- a/arch/sh/include/asm/vmlinux.lds.h
> +++ b/arch/sh/include/asm/vmlinux.lds.h
> @@ -7,9 +7,9 @@
>  #ifdef CONFIG_DWARF_UNWINDER
>  #define DWARF_EH_FRAME                                                 \
>         .eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {                 \
> -                 VMLINUX_SYMBOL(__start_eh_frame) = .;                 \
> +                 __start_eh_frame = .;                                 \
>                   *(.eh_frame)                                          \
> -                 VMLINUX_SYMBOL(__stop_eh_frame) = .;                  \
> +                 __stop_eh_frame = .;                                  \
>         }
>  #else
>  #define DWARF_EH_FRAME
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
