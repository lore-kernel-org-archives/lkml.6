Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F731ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C07C20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EoWKsit2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C07C20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeINSWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:22:02 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:45014 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:22:02 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w8ED7FJe021837;
        Fri, 14 Sep 2018 22:07:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w8ED7FJe021837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536930436;
        bh=mVuX9lbU+Gg0O5l1JNLiHg2q96yBdP/Bt54iMuMJb7g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=EoWKsit2crdR7JcKbNx8WAzBlJqJiN+N/5JZsmlLhSnNj0zxagI2DL1mcxlYxfiZR
         68Bct7dXHxLjmTjtfxEz7v1AGAbzUNrfMdCxwpu7k1AGSY5ngiExL55CHTGi5b+sfS
         eb0rtaNaSRqUvNNFMS5wxQPjbswTUrzleMNYtQCCD7bYwUJngkYeKHmgIKeIfUGbL+
         Q7bU0CPRqHBtO5Q7k87of404DA1rA3ZgJz8ZUwwgH6rqb36VV6XEmUiWwd2hf1EIor
         mhDRBP/mxZg2jvEbXzH9BlpfcKjTBLm8Gmsu2UeyiC6SNATxOBJH/RzTaBoDX2HCiv
         1I+0xFVNLFZSQ==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id 125-v6so1512431vke.11;
        Fri, 14 Sep 2018 06:07:15 -0700 (PDT)
X-Gm-Message-State: APzg51Dls8tCw/SJAB12JGBjVZvZTlBRc6e2WkNuJ3v9FEWzG8baqflh
        gNX7AoXAqJBNkmX+c8xbAtF7e2Yqlxr+nR2ncWQ=
X-Google-Smtp-Source: ANB0Vda+Pr6OoQJda99MedbFlTVPiIt+Ax07FPmkUZQlzmzXPvGG81Sk8ZMo5ZvGLUk3D3UrifMBGpecKOEW6GcrX84=
X-Received: by 2002:a1f:21d4:: with SMTP id h203-v6mr2854832vkh.64.1536930434245;
 Fri, 14 Sep 2018 06:07:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 06:06:33
 -0700 (PDT)
In-Reply-To: <1536734610-22173-2-git-send-email-yamada.masahiro@socionext.com>
References: <1536734610-22173-1-git-send-email-yamada.masahiro@socionext.com> <1536734610-22173-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 14 Sep 2018 22:06:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHOOLA+Hje0VUsxNJWov_nDaBa90SwsKr=QSCa3LYYYQ@mail.gmail.com>
Message-ID: <CAK7LNATHOOLA+Hje0VUsxNJWov_nDaBa90SwsKr=QSCa3LYYYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: remove dead code in cmd_files calculation in
 top Makefile
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-12 15:43 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Nobody sets 'targets' in the top-level Makefile or arch/*/Makefile,
> hence $(targets) is empty.
>
> $(wildcard .*.cmd) will do for including the .vmlinux.cmd file.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>  Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 4b76e22..8f6dbfc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1721,8 +1721,7 @@ cmd_crmodverdir = $(Q)mkdir -p $(MODVERDIR) \
>                    $(if $(KBUILD_MODULES),; rm -f $(MODVERDIR)/*)
>
>  # read all saved command lines
> -
> -cmd_files := $(wildcard .*.cmd $(foreach f,$(sort $(targets)),$(dir $(f)).$(notdir $(f)).cmd))
> +cmd_files := $(wildcard .*.cmd)
>
>  ifneq ($(cmd_files),)
>    $(cmd_files): ;      # Do not try to update included dependency files
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
