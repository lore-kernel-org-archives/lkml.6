Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84448C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0CD222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KAgdLSGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393859AbfBNCKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:24 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:65159 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfBNCKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:24 -0500
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x1E2A7v5014978;
        Thu, 14 Feb 2019 11:10:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x1E2A7v5014978
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550110208;
        bh=fvcpaNMgXMoAkt+h1wYITqXfUtOYx7Y+5g1/h/MdbG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KAgdLSGOBwnbXO+3HVh0ox4lx264FIE5jIB+94k7LBPNelyN0v7mjHWzRE6rw3rod
         lKCBfqk1yxOB3SzHYyaxv2K1dxUNckx2qi+x/rYIMqBSh8500hqllaktbQebEqySEb
         hLX3FfqP7eqAYEDhwCFc7eZePmDhlhcG+N66gFCHqGxm4vdgcIrfDMi65UmagpPID8
         +Ovzzl7nFlRIPWmFSrNCp/wSK0Po3u7MsiUQaAMNOjyWbZi+242Q5n82Ziz9e3xF5/
         xHRVAcdBJ4f+bvk+7753P2pS0K/xoae2N4gHSYKIur/CIgt/07jLRm7XCHkWny1E7l
         H1o7jh0ZGMqdQ==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id f206so1038336vke.6;
        Wed, 13 Feb 2019 18:10:07 -0800 (PST)
X-Gm-Message-State: AHQUAuYy/ohXzjoJUYLDZpZEM6grhMiIk0OIsSwE9mBYzxIXXfR3XbJd
        9063WZlLZYxLYax5thzcTPzxrP3paVIBM02J2BI=
X-Google-Smtp-Source: AHgI3IYUAZY3JywzYPGZvD7o/l6VVb76nNK/+cnfmOVNU9YPA6780YLaJ9lVCQ1aLabF7xr0APRXYTPnJ8JuNZbQzLo=
X-Received: by 2002:a1f:1ac3:: with SMTP id a186mr709977vka.34.1550110206820;
 Wed, 13 Feb 2019 18:10:06 -0800 (PST)
MIME-Version: 1.0
References: <1549245198-6182-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1549245198-6182-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Feb 2019 11:09:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASnRfOOX2oKkPp_Ehe7QG3bMLvR_Sr6CEw91zoqJaqkRQ@mail.gmail.com>
Message-ID: <CAK7LNASnRfOOX2oKkPp_Ehe7QG3bMLvR_Sr6CEw91zoqJaqkRQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kallsyms: add static qualifiers where missing
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     nixiaoming <nixiaoming@huawei.com>,
        Jan Beulich <JBeulich@suse.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mathias Krause <minipli@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 10:57 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Fix the following sparse warnings:
>
> scripts/kallsyms.c:65:5: warning: symbol 'token_profit' was not declared. Should it be static?
> scripts/kallsyms.c:68:15: warning: symbol 'best_table' was not declared. Should it be static?
> scripts/kallsyms.c:69:15: warning: symbol 'best_table_len' was not declared. Should it be static?
>
> Also, remove 'inline' from is_arm_mapping_symbol(). The compiler
> will inline it anyway when it is appropriate to do so.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to linux-kbuild.

> ---
>
>  scripts/kallsyms.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 77cebad..fc00bb0 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -62,11 +62,11 @@ static int all_symbols = 0;
>  static int absolute_percpu = 0;
>  static int base_relative = 0;
>
> -int token_profit[0x10000];
> +static int token_profit[0x10000];
>
>  /* the table that holds the result of the compression */
> -unsigned char best_table[256][2];
> -unsigned char best_table_len[256];
> +static unsigned char best_table[256][2];
> +static unsigned char best_table_len[256];
>
>
>  static void usage(void)
> @@ -80,7 +80,7 @@ static void usage(void)
>   * This ignores the intensely annoying "mapping symbols" found
>   * in ARM ELF files: $a, $t and $d.
>   */
> -static inline int is_arm_mapping_symbol(const char *str)
> +static int is_arm_mapping_symbol(const char *str)
>  {
>         return str[0] == '$' && strchr("axtd", str[1])
>                && (str[2] == '\0' || str[2] == '.');
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
