Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAE2C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBEA21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RtStZ84x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBEA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJIWSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:18:25 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:21966 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJIWSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:18:25 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w99F0xvo019733;
        Wed, 10 Oct 2018 00:01:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w99F0xvo019733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539097260;
        bh=gagouvCe8ApY94C5pfI1CwemkqTfpTJ6ogGONKydfxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RtStZ84xHbnQ39wNlmRSDE/ezM75e9fyMcJ/FByHGD+EvW9rrKzDxT5+XJDiOny4o
         UtWxGPhTOqb/cvSItyA29Uem3lQvQ2tApwX53bSRVFbeGyYAmNLLANZQeOmxA/0gdV
         rmYrMcj1PD226adAswYw9VmDFdSvVHZ3Vpsibc70NwsWbqbRNT/AqkNh/5Txggoj0V
         eFCHN6TNo8hUEAj+YQZ9DR2FXtvroUKcafU4YtdL/RxHSe/29kWhYzxxUjxVGqsqxa
         fjgA9QIfEAZNvoEs4fg97eKP5fxOXsLoiHjLXaPPR4uaeRzQ+pj5va/RvoZ16LvNb5
         EY73vPhYdq4tQ==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id w194so1797221vsc.11;
        Tue, 09 Oct 2018 08:00:59 -0700 (PDT)
X-Gm-Message-State: ABuFfoisW9FRTbgAz8ssUPFk0SwqkCRwsBGWX/8jVgsqzhjvID2t9cFe
        2fn8Tjf9RsQg0j097FBKdG3+hEdWJJPkvdzcQRM=
X-Google-Smtp-Source: ACcGV61G//kCXfKEP08IQmUNhGe/BzH+ElXsnAOB0+Cz4cD5ELavZX4G5OZyU50CmLo/QShzSNn1U3FUH5lzkWBV2u0=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr8839745vsb.155.1539097258827;
 Tue, 09 Oct 2018 08:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <1538115715-10078-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538115715-10078-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 10 Oct 2018 00:00:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQCfnV49tJ9BcO5M+bqk9egsHP7fv4y2Q5L-G87FB-wPw@mail.gmail.com>
Message-ID: <CAK7LNAQCfnV49tJ9BcO5M+bqk9egsHP7fv4y2Q5L-G87FB-wPw@mail.gmail.com>
Subject: Re: [PATCH] modpost: remove leftover symbol prefix handling for
 module device table
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:23 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Blackfin and metag were the only architectures that prefix symbols with
> an underscore.  They were removed by commit 4ba66a976072 ("arch: remove
> blackfin port"), commit bb6fb6dfcc17 ("metag: Remove arch/metag/"),
> respectively.
>
> It is no longer necessary to handle <prefix> part of module device
> table symbols.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.


>  scripts/mod/file2alias.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 7be4369..ba4ebc4 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1415,11 +1415,10 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>         if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
>                 return;
>
> -       /* All our symbols are of form <prefix>__mod_<name>__<identifier>_device_table. */
> -       name = strstr(symname, "__mod_");
> -       if (!name)
> +       /* All our symbols are of form __mod_<name>__<identifier>_device_table. */
> +       if (strncmp(symname, "__mod_", strlen("__mod_")))
>                 return;
> -       name += strlen("__mod_");
> +       name = symname + strlen("__mod_");
>         namelen = strlen(name);
>         if (namelen < strlen("_device_table"))
>                 return;
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
