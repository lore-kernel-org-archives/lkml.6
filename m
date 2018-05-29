Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbeE2J3s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:29:48 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:44308 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeE2J3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:29:44 -0400
X-Google-Smtp-Source: ADUXVKK40dmTVx36rcZhwRsdrJLxAdW4Cxcu4Hha9RGQT5UGn/G/4wH0BCG+2dsYP65u9+Oe2vgHAaLGlLcNXbcvH8s=
MIME-Version: 1.0
In-Reply-To: <20180528162902.15358-1-luc.vanoostenryck@gmail.com>
References: <20180528162902.15358-1-luc.vanoostenryck@gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 29 May 2018 17:29:03 +0800
Message-ID: <CAEbi=3dB=12nPiqk1zC6PTqBb_Z4GaoYUZBww7t_jy3REd=P4A@mail.gmail.com>
Subject: Re: [PATCH] nds32: define __NDS32_E[BL]__ for sparse
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-29 0:29 GMT+08:00 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>:
> nds32 depends on the macros '__NDS32_E[BL]__' to correctly
> select or define endian-specific macros, structures or pieces
> of code.
>
> These macros are predefined by the compiler but sparse knows nothing
> about them and thus may pre-process files differently from what
> GCC would.
>
> Fix this by adding '-D__NDS32_E[BL]__' to CHECKFLAGS.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/nds32/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
> index 513bb2e9b..031c67682 100644
> --- a/arch/nds32/Makefile
> +++ b/arch/nds32/Makefile
> @@ -34,10 +34,12 @@ ifdef CONFIG_CPU_LITTLE_ENDIAN
>  KBUILD_CFLAGS   += $(call cc-option, -EL)
>  KBUILD_AFLAGS   += $(call cc-option, -EL)
>  LDFLAGS         += $(call cc-option, -EL)
> +CHECKFLAGS      += -D__NDS32_EL__
>  else
>  KBUILD_CFLAGS   += $(call cc-option, -EB)
>  KBUILD_AFLAGS   += $(call cc-option, -EB)
>  LDFLAGS         += $(call cc-option, -EB)
> +CHECKFLAGS      += -D__NDS32_EB__
>  endif
>
>  boot := arch/nds32/boot

Thank you Luc.
I'll pick it in my tree.

Acked-by: Greentime Hu <greentime@andestech.com>
