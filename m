Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1610EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EFD2170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rQV/P7bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EFD2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeHTT3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:29:03 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:20133 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeHTT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:29:03 -0400
X-Greylist: delayed 150198 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2018 15:29:00 EDT
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com [209.85.213.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7KGChkO008518;
        Tue, 21 Aug 2018 01:12:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7KGChkO008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534781564;
        bh=t1zbW3CGxlJfu3AD7cOSHCR7BIPrWK6M8vfE3Oroj1Y=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rQV/P7bvrEhzPv6te0VDTZ731EWyGD3tHZOzosqCdJBlXGXX3H4wvP+8eMc5D6yGn
         P30UEKa2oPg0Uv51ZPTE0OWYQeaLYVoNOghIMUn+BzJ8jqnl63wk0FzYqiT6wafaj5
         ATTVVYzxtpIxTY3VZs0W6W5HqjKKIIpmdSWZuoLjAcopSzr6OsF3ut5h6pzJRtRL8C
         YpD8KbbgjfuQwUY7spen9a2XaDv9MVDrYvejNQxOHvIjnVj4ZFsm8cEOUfO3dCZcg4
         xkZnC1Mv9WFPqaW1yon7p+aUf5OMKy+fC1zWit9c6A3Sw/3F2fQpfDEvlruvjt7yXA
         EZBCkW4Qesc1Q==
X-Nifty-SrcIP: [209.85.213.51]
Received: by mail-vk0-f51.google.com with SMTP id 125-v6so6776171vke.11;
        Mon, 20 Aug 2018 09:12:44 -0700 (PDT)
X-Gm-Message-State: AOUpUlHCwajk6Rx+oKDdgLcHo2JZSfJh8M7dejSf+NRo31UZS6SY9+n0
        QHZk3MF5MwPixZMlRxLgyR4QPryvH/nliAEs9EI=
X-Google-Smtp-Source: AA+uWPwQeel8wxOJI1zlXI4wF5z/nVmm25EXx9tAGpscH7RSjl3AJ+resZOEkRINJr+zqo8bsLgk65y8CFQDX9bZjKE=
X-Received: by 2002:a1f:3a95:: with SMTP id h143-v6mr31291812vka.42.1534781563160;
 Mon, 20 Aug 2018 09:12:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 09:12:02
 -0700 (PDT)
In-Reply-To: <1534631687-18347-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534631687-18347-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 Aug 2018 01:12:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQHcKJLahTssT8tG6i0YM_UpM2A+vKOeeuwryx2UwVWeQ@mail.gmail.com>
Message-ID: <CAK7LNAQHcKJLahTssT8tG6i0YM_UpM2A+vKOeeuwryx2UwVWeQ@mail.gmail.com>
Subject: Re: [PATCH] export.h: remove VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR()
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keyrings@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-19 7:34 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> With the special case handling for Blackfin and Metag was removed by
> commit 94e58e0ac312 ("export.h: remove code for prefixing symbols with
> underscore"), VMLINUX_SYMBOL() is no-no.
>
> Replace the remaining usages, then remove the definition of
> VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR().
>
> <asm-generic/vmlinux.lds.h> no longer needs to include <linux/export.h>.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Fixed the typo no-no -> no-op,
then applied  to linux-kbuild.


>  certs/system_certificates.S       | 16 ++++++++--------
>  include/asm-generic/vmlinux.lds.h |  2 --
>  include/linux/export.h            |  7 -------
>  usr/initramfs_data.S              |  4 ++--
>  4 files changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/certs/system_certificates.S b/certs/system_certificates.S
> index 3918ff7..8f29058 100644
> --- a/certs/system_certificates.S
> +++ b/certs/system_certificates.S
> @@ -5,8 +5,8 @@
>         __INITRODATA
>
>         .align 8
> -       .globl VMLINUX_SYMBOL(system_certificate_list)
> -VMLINUX_SYMBOL(system_certificate_list):
> +       .globl system_certificate_list
> +system_certificate_list:
>  __cert_list_start:
>  #ifdef CONFIG_MODULE_SIG
>         .incbin "certs/signing_key.x509"
> @@ -15,21 +15,21 @@ __cert_list_start:
>  __cert_list_end:
>
>  #ifdef CONFIG_SYSTEM_EXTRA_CERTIFICATE
> -       .globl VMLINUX_SYMBOL(system_extra_cert)
> +       .globl system_extra_cert
>         .size system_extra_cert, CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE
> -VMLINUX_SYMBOL(system_extra_cert):
> +system_extra_cert:
>         .fill CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE, 1, 0
>
>         .align 4
> -       .globl VMLINUX_SYMBOL(system_extra_cert_used)
> -VMLINUX_SYMBOL(system_extra_cert_used):
> +       .globl system_extra_cert_used
> +system_extra_cert_used:
>         .int 0
>
>  #endif /* CONFIG_SYSTEM_EXTRA_CERTIFICATE */
>
>         .align 8
> -       .globl VMLINUX_SYMBOL(system_certificate_list_size)
> -VMLINUX_SYMBOL(system_certificate_list_size):
> +       .globl system_certificate_list_size
> +system_certificate_list_size:
>  #ifdef CONFIG_64BIT
>         .quad __cert_list_end - __cert_list_start
>  #else
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index f173b5f..7b75ff6 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -54,8 +54,6 @@
>  #define LOAD_OFFSET 0
>  #endif
>
> -#include <linux/export.h>
> -
>  /* Align . to a 8 byte boundary equals to maximum function alignment. */
>  #define ALIGN_FUNCTION()  . = ALIGN(8)
>
> diff --git a/include/linux/export.h b/include/linux/export.h
> index b768d6d..c363bde 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -10,13 +10,6 @@
>   * hackers place grumpy comments in header files.
>   */
>
> -#define __VMLINUX_SYMBOL(x) x
> -#define __VMLINUX_SYMBOL_STR(x) #x
> -
> -/* Indirect, so macros are expanded before pasting. */
> -#define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)
> -#define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
> -
>  #ifndef __ASSEMBLY__
>  struct kernel_symbol
>  {
> diff --git a/usr/initramfs_data.S b/usr/initramfs_data.S
> index b28da79..d07648f 100644
> --- a/usr/initramfs_data.S
> +++ b/usr/initramfs_data.S
> @@ -30,8 +30,8 @@ __irf_start:
>  .incbin __stringify(INITRAMFS_IMAGE)
>  __irf_end:
>  .section .init.ramfs.info,"a"
> -.globl VMLINUX_SYMBOL(__initramfs_size)
> -VMLINUX_SYMBOL(__initramfs_size):
> +.globl __initramfs_size
> +__initramfs_size:
>  #ifdef CONFIG_64BIT
>         .quad __irf_end - __irf_start
>  #else
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
