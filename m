Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565D0C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA3B213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MEqOkfhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBKBnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 20:43:45 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:63744 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfBKBnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 20:43:45 -0500
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x1B1hfY6010608;
        Mon, 11 Feb 2019 10:43:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x1B1hfY6010608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549849422;
        bh=Vx3BEED24LNtlEnMfZYvOUWbLE0Q2Fmq6gH3TAuvniY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MEqOkfhQq7BUZ8ezcQG4oJ8EoBfuBuQwYBs7PsMIuBSgd0w0TzbKlXxRrXznhvsLb
         7594MKI0trpJENJB/gEeU4oJx5IKuiaQhBh1XbXsTd7y9TB1OKXSpDqZsy+gaIYwRp
         eB916uLX0gS4aJFFAhC9DIQEsAQaDXeNNDonnw2XDyWgDmISbCIHXccl6fKab1zrk7
         pIHJQKBB/6NQ9LATMoXV4iR5TC6W1EdKuNMlqF63mk64h2BwsTDeOKkmDhoFFMbXr7
         h0bslrKCUDZ5s2o5gRJSA1hOT2RdyH0p9VM88J03TdXxtQavYNPhaekLJEEkHAJCtK
         cdQ9tYkHCE63w==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id v70so2093586vkv.7;
        Sun, 10 Feb 2019 17:43:42 -0800 (PST)
X-Gm-Message-State: AHQUAub5tRLmAqkwu15uyKgj9n/6aBcUO72JlkhUjAebe/dAVPapQ0+7
        S6jPFWKcBAy2Mpnf1zsJ5eK9i1tWlpKQ9mwr62Y=
X-Google-Smtp-Source: AHgI3IYznTNwgf8zS8CXs8EaWLNBWbCbPlieXEGgiYU5TOklpu27sQa+5S7/B6/U7XUZnXUaV1qdZDQ/lFXQ6sD8UNE=
X-Received: by 2002:a1f:1ac3:: with SMTP id a186mr5800723vka.34.1549849421400;
 Sun, 10 Feb 2019 17:43:41 -0800 (PST)
MIME-Version: 1.0
References: <1548387699-9222-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1548387699-9222-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 11 Feb 2019 10:43:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ6bRxhXuSgVS0DqZ_izMyKuujmQe9TVV8pDXve-gs90g@mail.gmail.com>
Message-ID: <CAK7LNAQ6bRxhXuSgVS0DqZ_izMyKuujmQe9TVV8pDXve-gs90g@mail.gmail.com>
Subject: Re: [PATCH] libfdt: prefix header search paths with $(srctree)/
To:     DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On Fri, Jan 25, 2019 at 12:42 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Currently, the Kbuild core manipulates header search paths in a crazy
> way [1].
>
> To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> the search paths in the srctree. Some Makefiles are already written in
> that way, but not all. The goal of this work is to make the notation
> consistent, and finally get rid of the gross hacks.
>
> Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> ("kbuild: do not drop -I without parameter").
>
> [1]: https://patchwork.kernel.org/patch/9632347/
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Could you apply this to your tree?

Thanks.

Masahiro


> ---
>
>  lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index e1b59da..05973c1 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -208,7 +208,7 @@ KCOV_INSTRUMENT_stackdepot.o := n
>  libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
>                fdt_empty_tree.o
>  $(foreach file, $(libfdt_files), \
> -       $(eval CFLAGS_$(file) = -I$(src)/../scripts/dtc/libfdt))
> +       $(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
>  lib-$(CONFIG_LIBFDT) += $(libfdt_files)
>
>  obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
