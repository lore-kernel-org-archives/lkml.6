Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09780C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 07:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944EC204EC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 07:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mTlqM40r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944EC204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeIILyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 07:54:38 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:25229 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbeIILyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 07:54:38 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w8975de9006673;
        Sun, 9 Sep 2018 16:05:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w8975de9006673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536476740;
        bh=osU7bwDS0GcGU+SVxK3i3OKhMCnbqWpDeKUUduc6QRo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mTlqM40rWtb4uJIkN1uuipjHwEMwRqQ5v+iZ9nvOweC5IvvzEQxMWnCsNelFkAF/z
         qhR0+nKltXxTH967SkfDcrG5rxmQMtSsJPvizVmZ6x7HqCDjFmNbyyI4DRlB9r9El5
         gzIucx94s0y4DRfLigGsjfR8BNalXhz6Wyf6VA8I9aH2SLWE4utJ0uhm/zem5maF6T
         NTymZNuvIyhUPdUGhK7+zbclJSMSTsbSZNjf/GzZhSfzF6QyCHy8T8hCPiKL5TwMdm
         Erias926TN1D9uFmHDLxz50mqzWzAZW4iqjBqtsOjMctwyT3FQ+nIaOG+a7Bnqu4ba
         PfX1gjKUicBhA==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id e139-v6so2270272vkf.6;
        Sun, 09 Sep 2018 00:05:40 -0700 (PDT)
X-Gm-Message-State: APzg51BJxdimT9tG80yH2NFbxHCSuO3pMUAW8TNOBP7/Lw7EGGy3JJ1m
        /hRzq6Q4vz9UHGXodSDM2MWzGUu22Z2PY5K9eB4=
X-Google-Smtp-Source: ANB0VdZWlFvmB6OMnrz22+X4yE2RYOaREkc1eY8mHVqsXspUjnRv00MaoYqLEfiKPPK1cDyNwu/wAJkPw7Z5d+HHjKI=
X-Received: by 2002:a1f:de46:: with SMTP id v67-v6mr4856432vkg.55.1536476739054;
 Sun, 09 Sep 2018 00:05:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 00:04:58 -0700 (PDT)
In-Reply-To: <1536021744-2552-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536021744-2552-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 9 Sep 2018 16:04:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQOY4fkkTnOwXs8YtS+q8UNTZ+iYgx1Jim=LQkRGNF5OQ@mail.gmail.com>
Message-ID: <CAK7LNAQOY4fkkTnOwXs8YtS+q8UNTZ+iYgx1Jim=LQkRGNF5OQ@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: remove left-over Blackfin code
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Aaron Wu <Aaron.Wu@analog.com>,
        Bryan Wu <cooloney@gmail.com>,
        Robin Getz <robin.getz@analog.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-04 9:42 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> These symbols were added by commit 028f042613c3 ("kallsyms: support
> kernel symbols in Blackfin on-chip memory") for Blackfin.
>
> The Blackfin support was removed by commit 4ba66a976072 ("arch: remove
> blackfin port").
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.



>  scripts/kallsyms.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index a9186a9..50af068 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -48,8 +48,6 @@ static unsigned long long relative_base;
>  static struct addr_range text_ranges[] = {
>         { "_stext",     "_etext"     },
>         { "_sinittext", "_einittext" },
> -       { "_stext_l1",  "_etext_l1"  }, /* Blackfin on-chip L1 inst SRAM */
> -       { "_stext_l2",  "_etext_l2"  }, /* Blackfin on-chip L2 SRAM */
>  };
>  #define text_range_text     (&text_ranges[0])
>  #define text_range_inittext (&text_ranges[1])
> --
> 2.7.4
>





-- 
Best Regards
Masahiro Yamada
