Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032669AbeCAPsr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:48:47 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:35917 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031899AbeCAPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:48:45 -0500
X-Google-Smtp-Source: AG47ELtqIenmXo4kXXKeh8jIngz+RjQB5RJpMHYnVZUlfYIHAtYLuXsLJJR6JQCq7YeupdqXay9XeZoQQItpdO3ctro=
MIME-Version: 1.0
In-Reply-To: <20180301152744.30718-1-robh@kernel.org>
References: <20180301152744.30718-1-robh@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 1 Mar 2018 15:48:43 +0000
Message-ID: <CAKv+Gu-sAQ6x8uCNtQjVrc4tzF7FyCBva8A92-Nxc=ciJj1eLA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: add strrchr function
To: Rob Herring <robh@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 March 2018 at 15:27, Rob Herring <robh@kernel.org> wrote:
> libfdt gained a new dependency on strrchr, so copy the implementation
> from lib/string.c.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack. This is a dependency for dtc/libfdt sync with upstream.
>
>  drivers/firmware/efi/libstub/string.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware/efi/libstub/string.c
> index ed10e3f602c5..c1a7e58a5af7 100644
> --- a/drivers/firmware/efi/libstub/string.c
> +++ b/drivers/firmware/efi/libstub/string.c
> @@ -56,3 +56,20 @@ int strncmp(const char *cs, const char *ct, size_t count)
>         return 0;
>  }
>  #endif
> +
> +#ifndef __HAVE_ARCH_STRRCHR

As discussed over IRC, this #ifndef needs to be dropped.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> +/**
> + * strrchr - Find the last occurrence of a character in a string
> + * @s: The string to be searched
> + * @c: The character to search for
> + */
> +char *strrchr(const char *s, int c)
> +{
> +       const char *last = NULL;
> +       do {
> +               if (*s == (char)c)
> +                       last = s;
> +       } while (*s++);
> +       return (char *)last;
> +}
> +#endif
> --
> 2.14.1
>
