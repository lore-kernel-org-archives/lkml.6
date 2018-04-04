Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeDDWeI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 18:34:08 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33321 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeDDWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 18:34:07 -0400
X-Google-Smtp-Source: AIpwx4+mh6uZ0DNqHgC3R6SlJ/566ak9F/kJJR9mpmGggSAztzDuB91vY4rQJkZ1u376+cXbOoXzJZNwKXZHhaPT5Bw=
MIME-Version: 1.0
In-Reply-To: <20180404123117.3575773-1-arnd@arndb.de>
References: <20180404123117.3575773-1-arnd@arndb.de>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 4 Apr 2018 15:34:06 -0700
X-Google-Sender-Auth: TanrZ3x8xj7d8D0pXWwLBUdtQPI
Message-ID: <CAGXu5jK1abgzQCJ+9ysTZHvxPo4vG6dfwPFs_CuXdP=0_Qib_g@mail.gmail.com>
Subject: Re: [PATCH] arm: decompressor: mark error() as __noreturn
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>,
        Jinbum Park <jinb.park7@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 5:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> gcc complains about fortify_panic() possibly returning:
>
> arch/arm/boot/compressed/misc.c: In function 'fortify_panic':
> arch/arm/boot/compressed/misc.c:167:1: error: 'noreturn' function does return [-Werror]
>
> This annotates the error() function as __noreturn, which lets gcc
> see in all configurations that it fortify_panic() cannot return either.
>
> Fixes: ee333554fed5 ("ARM: 8749/1: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/boot/compressed/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index 009db7d275f8..313a587d656b 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -24,7 +24,7 @@ unsigned int __machine_arch_type;
>  #include <linux/linkage.h>
>
>  static void putstr(const char *ptr);
> -extern void error(char *x);
> +extern void error(char *x) __noreturn;
>
>  #include CONFIG_UNCOMPRESS_INCLUDE
>
> --
> 2.9.0
>



-- 
Kees Cook
Pixel Security
