Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B188C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2D21A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="APUIDeZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbeLVQ7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:59:51 -0500
Received: from condef-08.nifty.com ([202.248.20.73]:40934 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeLVQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:59:50 -0500
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-08.nifty.com with ESMTP id wBM9AA45030206;
        Sat, 22 Dec 2018 18:10:10 +0900
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wBM99ipA027379;
        Sat, 22 Dec 2018 18:09:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wBM99ipA027379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545469785;
        bh=/0DRDpxXUJmenuFs2Hdijyybmefwg/x9M4htc5Ma8m0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=APUIDeZUif1pgviY4PvI1xd/F9sUXdLaYpTieULtWKeNO6INCS9HeVLSPGrZF20zm
         0nSWK6WBETqIGuqUhGOsl572t2kxK5j8g2FWWf7hRqeRnPLOUnSx0UmJRiLUtY1N2r
         V3wBJCAHRCbvleHuywYTCoLWUPHYfodxvf3bDqZZsa4P+3QQkKcOV1tunwKW92maq3
         vRoxNvMpwijyZmTMxPJuygIHlRcFz53w45TEGEiaRXiBcr7oeo8cde0dzYCNIbN8WP
         hFyuoh6yBWNcwe+W6NIJWEQttnHRxyagKQ37pmlACUxtkbdkFVt7y4GLfEMjW9Foo3
         I4LlU5cX8D+pw==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id u19so2524446uae.4;
        Sat, 22 Dec 2018 01:09:44 -0800 (PST)
X-Gm-Message-State: AJcUukdY6um8l4CCo1ietrz2xRY0irPLDwtpD7mEfVwd4h1wjO39TDNh
        Yz1QBtcZBY38UxmxQE47un5DiStawxCqYdNqIko=
X-Google-Smtp-Source: ALg8bN7Lblj5lCFvf487mX2xeVBpxLZKkOkWFhzO233oj53smuMISos6DVDyNVFZeVfcRF1hj63gg5szoC6nv/+wSSo=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr2119534uaj.42.1545469783570;
 Sat, 22 Dec 2018 01:09:43 -0800 (PST)
MIME-Version: 1.0
References: <1545361961-31990-1-git-send-email-yamada.masahiro@socionext.com> <1545361961-31990-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1545361961-31990-3-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 22 Dec 2018 18:09:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnbbmffjZ5ZVD5q9Xag0Hk143jKpywHjdO8w8xNOoM6w@mail.gmail.com>
Message-ID: <CAK7LNATnbbmffjZ5ZVD5q9Xag0Hk143jKpywHjdO8w8xNOoM6w@mail.gmail.com>
Subject: Re: [PATCH 3/3] firmware: rewrite Makefile
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 5:43 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Clean up the Makefile. Equivalent *.gen.S files are produced.
>
>  - Use filechk to remove ugly wordsize_deps
>
>  - Get FWNAME, FWSTR, ASM_WORD, ASM_ALIGN, and PROGBITS out of the
>    recipe for readability
>
>  - Move mkdir into the recipe
>
>  - Clean up generated directories by 'make clean'
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

> -targets := $(patsubst $(obj)/%,%, \
> -                                $(shell find $(obj) -name \*.gen.S 2>/dev/null))
> +targets := $(shell cd $(obj) && find * -name '*.gen.S')
> +clean-dirs := $(shell cd $(obj) && find * -maxdepth 0 -type d)

This 'find' emits a warning for out-of-tree build.
So, I will get it back to the original code.


-- 
Best Regards
Masahiro Yamada
