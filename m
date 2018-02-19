Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeBSRS1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:18:27 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:58016 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753208AbeBSRSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:18:25 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w1JHIKWt016040
X-Nifty-SrcIP: [209.85.217.182]
X-Google-Smtp-Source: AH8x225I4WmiSi7WuCmiBjsAwYJI/Fr6oeVflfJxBXbkAEyniW/abKwKIBMXmmUJ/pRRkZLqVsoKEKloBMzfNwAuxpA=
MIME-Version: 1.0
In-Reply-To: <1519060182-1746-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519060182-1746-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 20 Feb 2018 02:17:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_yqOVKGOEJ_SrvigpqEKZoriuWGuCYdwEWtTtSMxetA@mail.gmail.com>
Message-ID: <CAK7LNAS_yqOVKGOEJ_SrvigpqEKZoriuWGuCYdwEWtTtSMxetA@mail.gmail.com>
Subject: Re: [PATCH] sh: fix build error for empty CONFIG_BUILTIN_DTB_SOURCE
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-20 2:09 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> If CONFIG_USE_BUILTIN_DTB is enabled, but CONFIG_BUILTIN_DTB_SOURCE
> is empty (for example, allmodconfig), a build error occurs.
>
> Surround obj-y with ifneq ... endif.
>
> I replaced $(CONFIG_USE_BUILTIN_DTB) with 'y' since this is always
> the case from the following code from arch/sh/Makefile:
>
>   core-$(CONFIG_USE_BUILTIN_DTB)  += arch/sh/boot/dts/
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/sh/boot/dts/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
> index 715def0..01d0f7f 100644
> --- a/arch/sh/boot/dts/Makefile
> +++ b/arch/sh/boot/dts/Makefile
> @@ -1 +1,3 @@
> -obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
> +ifneq ($(CONFIG_BUILTIN_DTB_SOURCE),"")
> +obj-y += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
> +endif



I inserted this before Nicholas' patch
to silence the test robot.


-- 
Best Regards
Masahiro Yamada
