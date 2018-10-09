Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B564C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11270214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uRWLIKVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11270214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJIWPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:15:54 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:19076 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIWPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:15:54 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w99EwIDo018708;
        Tue, 9 Oct 2018 23:58:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w99EwIDo018708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539097099;
        bh=SL95+f40ErRozyT5ERA43ma0d+ZMbvzq5kbukVq1Fcs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uRWLIKVeIOuPvWvxrtdaqBTG6HigbhRUOo5Fxb2F+ukbMCDh/zbGhJOWcKct0Fosp
         bWD+7T2NabBICFgvfuAbsk/4yjlEa6lpMw2EejKUK4YFstBfuW9dW5IpyW8h3qGr0Q
         ot6MgEWAOKYD0GedjyNCOu+7kO/+vjRzGrhxYX/dhw//6JKUG7yWjdEyviyInyxIFH
         Cmk5fIdycRxdbvPjZ1i96GY1DFFI+09hYzA7ddIWCq444QGi0mXzGgXcG9Fh6aw59X
         6XvvRmJ8bC26Q2nSa+rdIGWuXvK5nLSOOKRaTZJ6olIyodpS7MzwwlyoCuCT9fClGU
         MGzJyoaYjBisw==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id w1so1795948vsj.8;
        Tue, 09 Oct 2018 07:58:18 -0700 (PDT)
X-Gm-Message-State: ABuFfogans6nlxGiB/3P5XSUVJ5FfIzFaut9zeVBcyA01uWwa2IYQEJz
        ybQPGEusX2SiSiz4AcLV/txhlAuOHEWVyNOxJDI=
X-Google-Smtp-Source: ACcGV61jr2oO39378v5f2AqBPeWTIKaHu9Rnvbcwwii+FMUalmYzisKkhhJQFt1ctWteU1Px5tV5ZHGbwqdqeIDTuTk=
X-Received: by 2002:a67:61c1:: with SMTP id v184mr6621044vsb.179.1539097097731;
 Tue, 09 Oct 2018 07:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 9 Oct 2018 23:57:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmxy=FQ0_Qg7ryNnCyh8uR_ffkT5L0P4s015F+1egJYA@mail.gmail.com>
Message-ID: <CAK7LNASmxy=FQ0_Qg7ryNnCyh8uR_ffkT5L0P4s015F+1egJYA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: add -Wno-pointer-sign flag unconditionally
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 6:45 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> We have raised the compiler requirement from time to time.
> With commit cafa0010cd51 ("Raise the minimum required gcc version
> to 4.6"), the minimum for GCC is 4.6 now.
>
> The -Wno-pointer-sign has been here since the pre-git era.  It is
> documented in the GCC 4.6 manual, and it is recognized by Clang
> and ICC as well.
>
> Let's rip off the cc-disable-warning switch, and see if somebody
> complains about it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c6d1f2f..505a324 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -800,7 +800,7 @@ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
>
>  # disable pointer signed / unsigned warnings in gcc 4.0
> -KBUILD_CFLAGS += $(call cc-disable-warning, pointer-sign)
> +KBUILD_CFLAGS += -Wno-pointer-sign
>
>  # disable stringop warnings in gcc 8+
>  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
