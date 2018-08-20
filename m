Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD69C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA3621569
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uxFCZztP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA3621569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeHTKKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:10:37 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:49898 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTKKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:10:37 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7K6u2tA031544;
        Mon, 20 Aug 2018 15:56:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7K6u2tA031544
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534748163;
        bh=dydO+VJk+vEQ8yLguRGt+3ISby887tBsWdeLUdiUrnY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=uxFCZztPDKwiDikYos225/uQo9dVZp+rWzA2AoWO4E1OKcDW3Zr+IpyYQLZ0zKJcG
         Kj0PK724T9aemLMBEElVNpBLcWAi96+kYbqWHPm92qtjilXAP9KoFgGv81I/Crjtm7
         Yhxnl63gGYA5FU+xu2vx190bzHqw8huUOYcxTodwHjjGIAyzA9bak4ltasyoau8kYO
         uyD/zjYH1Rs45BFj+kxXmYKv+Jx1EW6PXqhDKd2zZlirkdbBFChsw/xTB9fEZkAWSr
         yGhwWsVVEhsC3ssNzIWPYqyEke/gcpdPgyy65mORg9TvTmb88E2iwbZN+fgMLehZlv
         qV86wFJ4PciSA==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id c12-v6so9116019uan.3;
        Sun, 19 Aug 2018 23:56:03 -0700 (PDT)
X-Gm-Message-State: AOUpUlESyhK4G3NSyfqn7DVpI/e+r0QuwnEZDG9J9oi3Yuzzl2jN2oV9
        iVZs4VGsV+eYugvIJUbKwg0tai+YSScwdZQJ3Kg=
X-Google-Smtp-Source: AA+uWPyW07ZV0impQrs2rUiak9K352j72b6mS6AJl6i9iJlcapBTmoYk8FFr1pw4WxPIV9NR6rNt4uyYnOB+cfBltCI=
X-Received: by 2002:ab0:b:: with SMTP id 11-v6mr29079649uai.19.1534748162232;
 Sun, 19 Aug 2018 23:56:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 23:55:21
 -0700 (PDT)
In-Reply-To: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 20 Aug 2018 15:55:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+szUMMyftudykuxVA7ROk6VM+QUobptnLciwAb8pLJw@mail.gmail.com>
Message-ID: <CAK7LNAT+szUMMyftudykuxVA7ROk6VM+QUobptnLciwAb8pLJw@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: consolidate include path options in Makefile
To:     DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


2018-07-04 10:59 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> It is tedious to specify extra compiler options for every file.
> HOST_EXTRACFLAGS is useful to add options to all files in a
> directory.
>
> -I$(src)/libfdt is needed for all the files in this directory
> to include libfdt_env.h etc. from scripts/dtc/libfdt/.
>
> On the other hand, -I$(src) is used to include check-in headers
> from generated C files.  Thus, I added it only to dtc-lexer.lex.o
> and dtc-parser.tab.o .
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


I hope this is a good clean-up.

May I apply this to my kbuild tree for v4.19 ?


> ---
>
>  scripts/dtc/Makefile | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> index 9cac65b..1c943e0 100644
> --- a/scripts/dtc/Makefile
> +++ b/scripts/dtc/Makefile
> @@ -9,21 +9,11 @@ dtc-objs      := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>  dtc-objs       += dtc-lexer.lex.o dtc-parser.tab.o
>
>  # Source files need to get at the userspace version of libfdt_env.h to compile
> +HOST_EXTRACFLAGS := -I$(src)/libfdt
>
> -HOSTCFLAGS_DTC := -I$(src) -I$(src)/libfdt
> -
> -HOSTCFLAGS_checks.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_data.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_dtc.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_flattree.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_fstree.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_livetree.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_srcpos.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_treesource.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_util.o := $(HOSTCFLAGS_DTC)
> -
> -HOSTCFLAGS_dtc-lexer.lex.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_dtc-parser.tab.o := $(HOSTCFLAGS_DTC)
> +# Generated files need one more search path to include headers in source tree
> +HOSTCFLAGS_dtc-lexer.lex.o := -I$(src)
> +HOSTCFLAGS_dtc-parser.tab.o := -I$(src)
>
>  # dependencies on generated files need to be listed explicitly
>  $(obj)/dtc-lexer.lex.o: $(obj)/dtc-parser.tab.h
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
