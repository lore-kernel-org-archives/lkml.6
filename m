Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF78ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54C121476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eVfyepG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54C121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeINSWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:22:08 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:17934 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINSWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:22:08 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8ED7av3028093;
        Fri, 14 Sep 2018 22:07:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8ED7av3028093
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536930457;
        bh=zHqXSJtCWOn47J+1yfnfb8sNmfaG+JMjWYj1f4x7Q/I=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eVfyepG+58vdr1zMk4M6ZJXLTumTcNiCZt06SYNM+/jAiCX8MIJYyMWKO+lUnz+l2
         u3sfUtcgi2RQTvGF/volpBMcafkzSVgFVHN+SQDNZBta+0tT/Qbc22yWYOj/iQWrDY
         MSk/fwio+4CsAddlAvubbDXDHrLbwOe8iqd2oJtuyH32uI5pUx9oHd4ts7YTgMzHFz
         7HW06tvWbxaVpQ+NRPGDd1Qplhedx5Iv0Qu1Q6v8suM7wv47F9nris+fz/8OZlZ6hJ
         299Am/bkT9khV3VEUSysDVzaSiVZTOxblsxmesSY30QcysAidrGKazOJoFXRQMGfTT
         3UracwHIeyk7g==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id m10-v6so467618vsk.1;
        Fri, 14 Sep 2018 06:07:36 -0700 (PDT)
X-Gm-Message-State: APzg51CSP06/Szkrqhe0xNwuAfoKNhhQMfng00HCzP7Vh469OzZ6DGRY
        AX+gXmJmtUhlBP4vHwuvX05qUHkGckqonGynuiY=
X-Google-Smtp-Source: ANB0VdZNsx7xu1eYMwaYToEG5SN3qJlwdFGIhG2ht8EGfMnEIr30Do6wPwagheW16XKeZrBrLN3M+/6cgxJTlz/9jc4=
X-Received: by 2002:a67:7cc9:: with SMTP id x192-v6mr4368947vsc.9.1536930455285;
 Fri, 14 Sep 2018 06:07:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 06:06:54
 -0700 (PDT)
In-Reply-To: <1536733082-19110-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536733082-19110-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 14 Sep 2018 22:06:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARaKFfC_VR8HXWvMf7HQtP2b9YvHfH_WTLer0uGdkPVzg@mail.gmail.com>
Message-ID: <CAK7LNARaKFfC_VR8HXWvMf7HQtP2b9YvHfH_WTLer0uGdkPVzg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove old check for CFLAGS use
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-12 15:18 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> This check has been here more than a decade since commit 0c53c8e6eb45
> ("kbuild: check for wrong use of CFLAGS").
>
> Enough time for migration has passed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.

>  scripts/Makefile.build | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 5a2d1c9..cb03774 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -36,21 +36,11 @@ subdir-ccflags-y :=
>
>  include scripts/Kbuild.include
>
> -# For backward compatibility check that these variables do not change
> -save-cflags := $(CFLAGS)
> -
>  # The filename Kbuild has precedence over Makefile
>  kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
>  kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
>  include $(kbuild-file)
>
> -# If the save-* variables changed error out
> -ifeq ($(KBUILD_NOPEDANTIC),)
> -        ifneq ("$(save-cflags)","$(CFLAGS)")
> -                $(error CFLAGS was changed in "$(kbuild-file)". Fix it to use ccflags-y)
> -        endif
> -endif
> -
>  include scripts/Makefile.lib
>
>  # Do not include host rules unless needed
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
