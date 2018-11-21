Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C6BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FEC21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vQCPDLz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FEC21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeKURBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:01:34 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:39709 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeKURBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:01:34 -0500
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAL6SGXD026147;
        Wed, 21 Nov 2018 15:28:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAL6SGXD026147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542781697;
        bh=h/T7zOcn/nKjSqz8GzehbHyWv7hq91KwVljN8+MZmtA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vQCPDLz1ZOHkX0njIJKKT8fBeuCOiBmE3QbOTflAwjbxaImH2CpjqSqs5MXd/wbyf
         2cS2wQZJBEConXCxFoq8pvMbJevyTFiY8rFwOazOwYe2kQhgEbI9Fe5fr20B/A1aCy
         Oe5BXfy1upF26C8EeRLH0IQATDVVQOkaD789U3AM4ideWSmAEBlMoGX2jv+Gyu5u2F
         4tj6bDfvfLJGrAHQVEoC1zs3G9fOgJIh719CzLflHJgv96/F/TXemnprdG09g+doJ9
         Xz6jjdY08VFZOfliFJJi2xGIcUD2uGn+KEyAXZ4f2FotMGVsCUhUIMLD+FI788JxUD
         ZEX51YVZqKEnQ==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id n126so975114vke.12;
        Tue, 20 Nov 2018 22:28:17 -0800 (PST)
X-Gm-Message-State: AA+aEWYKrYNHRtss3McyGCkwTT/7qNutD8lml1JPyzUrXopjh+dKV+U+
        Rhyy3aunDJSw+WszQmy017akKNQnivbhGcfGzQc=
X-Google-Smtp-Source: AFSGD/WT5Y884VzYdxWcbTZINtHdz9DME3LiuJWoRSjdm1KbMT/qk//Bm22KugRcNMboqsMcoU0c2QfouSzcUZfGSdo=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr2095076vkb.34.1542781696090;
 Tue, 20 Nov 2018 22:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20181023221535.4740-1-samitolvanen@google.com>
In-Reply-To: <20181023221535.4740-1-samitolvanen@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 21 Nov 2018 15:27:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQTvF8NVxukJjSah5YBoMxryH8RkzzXc3jUoxF9RCn4kg@mail.gmail.com>
Message-ID: <CAK7LNAQTvF8NVxukJjSah5YBoMxryH8RkzzXc3jUoxF9RCn4kg@mail.gmail.com>
Subject: Re: [PATCH] modpost: validate symbol names also in find_elf_symbol
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 7:15 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> If an ARM mapping symbol shares an address with a valid symbol,
> find_elf_symbol can currently return the mapping symbol instead, as the
> symbol is not validated. This can result in confusing warnings:
>
>   WARNING: vmlinux.o(.text+0x18f4028): Section mismatch in reference
>   from the function set_reset_devices() to the variable .init.text:$x.0
>
> This change adds a call to is_valid_name to find_elf_symbol, similarly
> to how it's already used in find_elf_symbol2.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---


Applied to linux-kbuild.

Thanks!



>  scripts/mod/modpost.c | 50 ++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 0d998c54564d..b709b2e623d6 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1204,6 +1204,30 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
>         return 1;
>  }
>
> +static inline int is_arm_mapping_symbol(const char *str)
> +{
> +       return str[0] == '$' && strchr("axtd", str[1])
> +              && (str[2] == '\0' || str[2] == '.');
> +}
> +
> +/*
> + * If there's no name there, ignore it; likewise, ignore it if it's
> + * one of the magic symbols emitted used by current ARM tools.
> + *
> + * Otherwise if find_symbols_between() returns those symbols, they'll
> + * fail the whitelist tests and cause lots of false alarms ... fixable
> + * only by merging __exit and __init sections into __text, bloating
> + * the kernel (which is especially evil on embedded platforms).
> + */
> +static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
> +{
> +       const char *name = elf->strtab + sym->st_name;
> +
> +       if (!name || !strlen(name))
> +               return 0;
> +       return !is_arm_mapping_symbol(name);
> +}
> +
>  /**
>   * Find symbol based on relocation record info.
>   * In some cases the symbol supplied is a valid symbol so
> @@ -1229,6 +1253,8 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
>                         continue;
>                 if (ELF_ST_TYPE(sym->st_info) == STT_SECTION)
>                         continue;
> +               if (!is_valid_name(elf, sym))
> +                       continue;
>                 if (sym->st_value == addr)
>                         return sym;
>                 /* Find a symbol nearby - addr are maybe negative */
> @@ -1247,30 +1273,6 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
>                 return NULL;
>  }
>
> -static inline int is_arm_mapping_symbol(const char *str)
> -{
> -       return str[0] == '$' && strchr("axtd", str[1])
> -              && (str[2] == '\0' || str[2] == '.');
> -}
> -
> -/*
> - * If there's no name there, ignore it; likewise, ignore it if it's
> - * one of the magic symbols emitted used by current ARM tools.
> - *
> - * Otherwise if find_symbols_between() returns those symbols, they'll
> - * fail the whitelist tests and cause lots of false alarms ... fixable
> - * only by merging __exit and __init sections into __text, bloating
> - * the kernel (which is especially evil on embedded platforms).
> - */
> -static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
> -{
> -       const char *name = elf->strtab + sym->st_name;
> -
> -       if (!name || !strlen(name))
> -               return 0;
> -       return !is_arm_mapping_symbol(name);
> -}
> -
>  /*
>   * Find symbols before or equal addr and after addr - in the section sec.
>   * If we find two symbols with equal offset prefer one with a valid name.
> --
> 2.19.1.568.g152ad8e336-goog
>


-- 
Best Regards
Masahiro Yamada
