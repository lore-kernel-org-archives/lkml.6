Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 71RzKRY8GltJMgAAmS7hNA
	; Fri, 08 Jun 2018 08:21:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 303BF607E4; Fri,  8 Jun 2018 08:21:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etDAjx/s"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3577560590;
	Fri,  8 Jun 2018 08:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3577560590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeFHIVD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:21:03 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45448 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbeFHIU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:20:57 -0400
Received: by mail-ua0-f193.google.com with SMTP id k14-v6so8317508uao.12;
        Fri, 08 Jun 2018 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NWmvzHPjVAmhSPhpySA9HxGmxP0SkDV4oBWdkqOYiTQ=;
        b=etDAjx/sQmpwA/3eVSOLe7t73qmFO1x8VW+j3CsBZBP5lVlfHLAuG3jcjK+sUlgxfJ
         dPu4Kfd+r62dVKY8aIM6MGYh6w8HAHjYy8HY8bwKtAezYnHG50qBdAdxfZHjpoEfarg8
         WQ1S9g4J44iA4zuweCdlT3KL+hKYM73AhqhRBql5KLuGaclC6bZkgtPpbDo8rvdyuQg9
         AThOp4iBUneMHxtwz9dOb0HrsJvVQ8rjDiG583J+9IYkedExhcjCnNu+CIy5V4ZBzu4R
         31HvUYZSyHvOKR+MuJrvMGn3poQwB9YkqYUtcpB7MTINPwfgLjU7gH7xCyljCZthq4l4
         P2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NWmvzHPjVAmhSPhpySA9HxGmxP0SkDV4oBWdkqOYiTQ=;
        b=QWNNNtVCdip/rvn6BygSBsy40khpvr209+8kwQRICPwdCf8/N905W7QQ1BVUNE0A9d
         mrUY4ySsARpKCID0g/Yy7Ff4t/qpcPAel+OOtF5vAsF6SMoQfqAITK5I8RNVzRWGzka7
         ItTDHVrAawwuTR5UbrlBPOHxUW5QBcMtrB+AEoOytQ1dOUR+whpNnxFlerSGYutb/LAS
         OdwWcu4ui3hUaSZ1+r7ent1h/kj9te+u3oTHwGlIdHptLznMuGBdEcQ2W+VeNR1b10tg
         TNhZyVekAeIQ1cxTENJY8H9IvjEbyr+Osrpz4tjOnxIAaCt+Oth+dM8M+EL8znYwRKEn
         cn6A==
X-Gm-Message-State: APt69E0IxK5/Rnptxt6gxap6S301xZmhzIYq9Ktc+FdS0NiDLWcL+JSC
        4X2L785a+O6aHTXv577asEiOPHGQo1dfuoQ6MWc=
X-Google-Smtp-Source: ADUXVKIOrknkTN2ksupkLe+23JYEb8w890RGQn+eECvkEQEcyQ8s6zW+VuXyVr023ZduRlgOO2Wp4MRa1Bp9arDlPbU=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr3519615uae.12.1528446056898;
 Fri, 08 Jun 2018 01:20:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 01:20:56 -0700 (PDT)
In-Reply-To: <1528417303-14842-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528417303-14842-1-git-send-email-yamada.masahiro@socionext.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Jun 2018 10:20:56 +0200
X-Google-Sender-Auth: TL4l73weN0xTJcJn741o8pQV8A4
Message-ID: <CAMuHMdX7oyxQKyc-DTXKG+o0SA_eJhKEFznn3bPxD0Gi=sA01A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix endless syncconfig in case arch Makefile sets CROSS_COMPILE
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Fri, Jun 8, 2018 at 2:21 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Commit 21c54b774744 ("kconfig: show compiler version text in the top
> comment") was intended to detect the compiler upgrade, but Geert
> reported a breakage on the m68k build.
>
> The compiler upgrade is detected by the change of the environment
> variable, CC_VERSION_TEXT, which contains the first line of the output
> from $(CC) --version.  Currently, this works well when CROSS_COMPILE
> is given via the environment variable or the Make command line.
>
> However, some architectures such as m68k can specify CROSS_COMPILE
> from arch/$(SRCARCH)/Makefile as well.  In this case, "make ARCH=m68k"
> ends up with endless syncconfig loop.
>
>   $ make ARCH=m68k defconfig
>   *** Default configuration is based on 'multi_defconfig'
>   #
>   # configuration written to .config
>   #
>   $ make ARCH=m68k
>   scripts/kconfig/conf  --syncconfig Kconfig
>   scripts/kconfig/conf  --syncconfig Kconfig
>   scripts/kconfig/conf  --syncconfig Kconfig
>   scripts/kconfig/conf  --syncconfig Kconfig

[...]

> Fixes: 21c54b774744 ("kconfig: show compiler version text in the top comment")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks for fixing this quickly!

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
