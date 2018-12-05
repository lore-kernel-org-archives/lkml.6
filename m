Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36429C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B0520879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhGKxBJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B0520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeLERrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:47:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36938 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLERrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:47:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so10378045pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWWzcbrSwfAg0ZxQMB2tb6h9CB60uyE2zzgL39jC1qs=;
        b=QhGKxBJVc+/PGXaVm70xwsQpApDz+s2UfTF7gkB0RXEnJxCkN0udCkhAedwxkUZWQH
         Z3z+yxctfHtkqHdRXpei9BNSZqX4xFi+SqOCfAcwQRpbP+0jKjrOVbgmAa407gH6clxW
         sGKYxxsu2ISOUBYU9BMcDrQERLLYHptpxjmR1J54WgJk46n3Dh0XSFp09ZpaIF/9CgGz
         uVCywZ0/C9wIEcZEfr6GFJhWjo/Q7WKC7PL3b1V2KyhSkuKfGsQw97RVvgWSenVsSa02
         Fuq4Qg+6h69qsU0NONkDidqQIKACnNhD8FEpo3nqmjN5rL2VyxcDySRl13OM4AFKuRv/
         Q3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWWzcbrSwfAg0ZxQMB2tb6h9CB60uyE2zzgL39jC1qs=;
        b=rPiQVrBLzaVqFtgNWzIUHnfxiffx16oqweInM7JkVoaBEL3kgLJBXR4Qhe7/43YB+A
         fmT/YsfSKxfEdLaa+hqaWNtIHA2v9U1oiwtesFpvdpoO+s4Xhwy03kzZBT5JSlJGUP7c
         x0tlZnB6C/PYjMx/Et8so8aVlPUHOPBxRCaADcjcizskFu/MsQrjntN5EXBG80Uvk6G4
         j6NXcA2zOsK2B1mmp/P4Dn9Z+Y6ikHDZT04p7WNIhtArgrzwiq7rMM71t80mdvfOQLU5
         xYFODCRuSnNiOPdHXjkda+i5snHtXHftaMyvUw68AehjwQl7QVyZ/JoZC4WPPOu7+CDn
         7RTg==
X-Gm-Message-State: AA+aEWb+cqDehP6b/Wty3tcQ7EWJAugyUBmSE2OLoIgFdIVXBII8bUcF
        naL3FspN0oXTqgnNCsf5piFk3/PXQiJt+1RVRewO4Q==
X-Google-Smtp-Source: AFSGD/U6fSaLsrqIwZBsF5ZBExT8q43sfVzlRaakRZOmgO7OaFsltOEv3p51DpiJfbYstF3xabVXWluEibUKyk2X4WY=
X-Received: by 2002:a65:4683:: with SMTP id h3mr20384165pgr.225.1544032063638;
 Wed, 05 Dec 2018 09:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Dec 2018 09:47:32 -0800
Message-ID: <CAKwvOdkMbf-=aKrWPZ7nPP0miKDxKMDYN4Kk46N4rxOwHb-zAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: Remove '-p' from LDFLAGS
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux@armlinux.org.uk,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 5:42 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> This option is not supported by lld:
>
>     ld.lld: error: unknown argument: -p
>
> This has been a no-op in binutils since 2004 (see commit dea514f51da1 in
> that tree). Given that the lowest officially supported of binutils for
> the kernel is 2.20, which was released in 2009, nobody needs this flag
> around so just remove it. Commit 1a381d4a0a9a ("arm64: remove no-op -p
> linker flag") did the same for arm64.

While investigating the context of 1a381d4a0a9a for review, I found
that bfd had removed -p's implementation a long time ago, but kept the
flag as a no-op for compatibility.  I asked that the patch be extended
to arm as well, but don't think a v2 was ever cut.

Thanks for sending this Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm/Makefile                 | 2 +-
>  arch/arm/boot/compressed/Makefile | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 05a91d8b89f3..e2a0baf36766 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -10,7 +10,7 @@
>  #
>  # Copyright (C) 1995-2001 by Russell King
>
> -LDFLAGS_vmlinux        :=-p --no-undefined -X --pic-veneer
> +LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux        += --be8
>  KBUILD_LDFLAGS_MODULE  += --be8
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 1f5a5ffe7fcf..dcd07bd24b85 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -131,8 +131,6 @@ endif
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux += --be8
>  endif
> -# ?
> -LDFLAGS_vmlinux += -p
>  # Report unresolved symbol references
>  LDFLAGS_vmlinux += --no-undefined
>  # Delete all temporary local symbols
> --
> 2.20.0.rc1
>


-- 
Thanks,
~Nick Desaulniers
