Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68A6ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD3420831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="K//TAq3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD3420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeJ2B3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:29:07 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:17018 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeJ2B3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:29:06 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w9SGhYso025623;
        Mon, 29 Oct 2018 01:43:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w9SGhYso025623
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540745015;
        bh=8U/Ig1UmLFtcit4Sv57d9Gtk8h30Vtmj6fFOQY3850s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K//TAq3Ie3hmjA8uTX0RSO/HrZpFC/YdB3TeoLUkWMvp7ExhK6nOxr9WALuPnFi5l
         Kn8xvggKHA4huPqJkOHDD1Np1fCVGgoG04P4DHpKXkqVa+mUpJjdLtgCnQy+Ia7tcm
         ickK0Xcxow/T5fdzWRyO0lo6OGu2BKR/sv2i1Odl2319sas9N5x+BTYfbDutSwOIsh
         N9YYonivh45IjzHMP6WL8D2+G/C10y+eGwkefvScV/Ee/aVkYXVYt1U4bhPw3SpTE0
         V+xCQg6TH0viBryo3Dnu4wCUvPXcgIprvnT4pAun24lZX0k43AIGBmDDq1jnwt/68D
         UMq2QsS9LYEgw==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id t17so625046vsc.8;
        Sun, 28 Oct 2018 09:43:34 -0700 (PDT)
X-Gm-Message-State: AGRZ1gL0QukwvJo2FuONxijUL0HgO406xOywl16LruZjRqu8G883/Ayy
        C/2qYPImohhtWijVqXkdHwvdt8vysZEGkxV7+2c=
X-Google-Smtp-Source: AJdET5c2gNd+QthG6uNMuIhCpW8tlrSsAy0Qkb2Q01nibXps+WxpCKUeCa+TFE2Iq8lUdEYv16RhDgWNBPsVYdBgfHc=
X-Received: by 2002:a67:a858:: with SMTP id r85mr4615091vse.215.1540745013525;
 Sun, 28 Oct 2018 09:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181024040354.24879-1-leobras.c@gmail.com> <20181024040354.24879-5-leobras.c@gmail.com>
In-Reply-To: <20181024040354.24879-5-leobras.c@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 01:42:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzgdFPpwHEtfDazLd2jAhNy8=f_4mvOQMWfOWCb07E1Q@mail.gmail.com>
Message-ID: <CAK7LNAQzgdFPpwHEtfDazLd2jAhNy8=f_4mvOQMWfOWCb07E1Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] modpost: Changes parameter name to avoid shadowing.
To:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:05 PM Leonardo Bras <leobras.c@gmail.com> wrote:
>
> Changes the parameter name to avoid shadowing a variable.
>
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>


For this one, I'd rather like to see code refactoring
than renaming the variable.

I will take a closer look.




> ---
>  scripts/mod/modpost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 0d998c54564d..368fe42340df 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2228,13 +2228,13 @@ static int add_versions(struct buffer *b, struct module *mod)
>  }
>
>  static void add_depends(struct buffer *b, struct module *mod,
> -                       struct module *modules)
> +                       struct module *module_list)
>  {
>         struct symbol *s;
>         struct module *m;
>         int first = 1;
>
> -       for (m = modules; m; m = m->next)
> +       for (m = module_list; m; m = m->next)
>                 m->seen = is_vmlinux(m->name);
>
>         buf_printf(b, "\n");
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
