Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeDOQUP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 12:20:15 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38915 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752371AbeDOQUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 12:20:14 -0400
X-Google-Smtp-Source: AIpwx4/BqEYjJkMgekI6BP5Uz4Pl2CZfPDMmGdbNiXARGskYoVJP64qov7bxBkZExECdwis3BE5Vzx0HSk+IRY3wqFo=
MIME-Version: 1.0
In-Reply-To: <20171223004323.1986-1-Jason@zx2c4.com>
References: <20171223004323.1986-1-Jason@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 15 Apr 2018 18:20:11 +0200
X-Gmail-Original-Message-ID: <CAHmME9otwT+14LhmebF8Osna7m_u6xvFEi7pMq2v1-k9WD5Lpw@mail.gmail.com>
Message-ID: <CAHmME9otwT+14LhmebF8Osna7m_u6xvFEi7pMq2v1-k9WD5Lpw@mail.gmail.com>
Subject: Re: [PATCH] arm64: support __int128 with clang
To: Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Would you review/merge this when you have a chance?

Thanks,
Jason

On Sat, Dec 23, 2017 at 1:43 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Commit fb8722735f50 ("arm64: support __int128 on gcc 5+") added support
> for arm64 __int128 with gcc with a version-conditional, but neglected to
> enable this for clang, which in fact appears to support aarch64 __int128.
> This commit therefore enables it if the compiler is clang, using the
> same type of makefile conditional used elsewhere in the tree.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm64/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b481b4a7c011..16c2e8b58546 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -57,7 +57,11 @@ KBUILD_AFLAGS        += $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS  += $(call cc-option,-mabi=lp64)
>  KBUILD_AFLAGS  += $(call cc-option,-mabi=lp64)
>
> +ifeq ($(cc-name),clang)
> +KBUILD_CFLAGS  += -DCONFIG_ARCH_SUPPORTS_INT128
> +else
>  KBUILD_CFLAGS  += $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
> +endif
>
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS        += -mbig-endian
> --
> 2.15.1
>
