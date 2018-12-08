Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD6C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E122082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UNUTlWlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E122082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLHG4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 01:56:12 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:20748 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHG4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 01:56:11 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wB86u3vo030299;
        Sat, 8 Dec 2018 15:56:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wB86u3vo030299
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544252164;
        bh=ITOK08EYvUCvw47kQ32f9mxht24HrpRIOXsJDSTNuZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UNUTlWlkwnvQo+yP7+wcTEsYDK1aVae00SSgt5p4oXM+CS0Dl2+zxVcH7tCUi/0kU
         FC812+OwKCOC/fIHsFOqjXGdWQsfVKGT9EkWHX33tqA7pN1MeCDqR/rn5H7NAxPBE/
         w/JrIdZICWwRStUTptnpkqWhao7lU1OCxC1E3rgFEIqUUuGSzuTA2AHGRJmz+DQ71k
         ure6DSeQh9mtqk9N9v0TacYK1/uLWirRhCVaTZm2jat2gk3YUSIn0Y6CvoYdZG6WWX
         no8auhsFufryE+O++LcKMrjt0ykzZiI2NoyR0xWkDJPy+e9yTEddnBF4VHoQOf5BU1
         sA3WWmlHw4UpQ==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id j23so1452171vke.13;
        Fri, 07 Dec 2018 22:56:04 -0800 (PST)
X-Gm-Message-State: AA+aEWap2Sf1YtyJGuVa29MFN5O3xkST8yrFPw2QhzyFK1SKkbxYTl5W
        lMfd9CSKadGQap1Ds9YKpZFqizwGvrYEktisrhM=
X-Google-Smtp-Source: AFSGD/XIsvYt15cppNhAGGxrKI8cG+QaUjUF1rVNb43upRftZli6nK7Py7XsBIOtALLgvSrIBaywxASh8DdRnDOsSU4=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr2078894vkb.34.1544252163323;
 Fri, 07 Dec 2018 22:56:03 -0800 (PST)
MIME-Version: 1.0
References: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 8 Dec 2018 15:55:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3P8JQ9Ej-cDMOEAYYGkSfomRAdEfGVDMuB5foeDdJSA@mail.gmail.com>
Message-ID: <CAK7LNAT3P8JQ9Ej-cDMOEAYYGkSfomRAdEfGVDMuB5foeDdJSA@mail.gmail.com>
Subject: Re: [PATCH 1/5] kconfig: remove unneeded setsym label in conf_read_simple()
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 6:17 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The two 'goto setsym' statements are reachable only when sym == NULL.
>
> The code below the 'setsym:' label does nothing when sym == NULL
> since there is just one if-block guarded by 'if (sym && ...)'.
>
> Hence, 'goto setsym' can be replaced with 'continue'.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applied to linux-kbuild/kconfig.



>  scripts/kconfig/confdata.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 91d0a5c..1e35529 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -363,7 +363,7 @@ int conf_read_simple(const char *name, int def)
>                                 sym = sym_find(line + 2 + strlen(CONFIG_));
>                                 if (!sym) {
>                                         sym_add_change_count(1);
> -                                       goto setsym;
> +                                       continue;
>                                 }
>                         } else {
>                                 sym = sym_lookup(line + 2 + strlen(CONFIG_), 0);
> @@ -397,7 +397,7 @@ int conf_read_simple(const char *name, int def)
>                                 sym = sym_find(line + strlen(CONFIG_));
>                                 if (!sym) {
>                                         sym_add_change_count(1);
> -                                       goto setsym;
> +                                       continue;
>                                 }
>                         } else {
>                                 sym = sym_lookup(line + strlen(CONFIG_), 0);
> @@ -416,7 +416,7 @@ int conf_read_simple(const char *name, int def)
>
>                         continue;
>                 }
> -setsym:
> +
>                 if (sym && sym_is_choice_value(sym)) {
>                         struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
>                         switch (sym->def[def].tri) {
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
