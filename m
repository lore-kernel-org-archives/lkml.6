Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD019C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE9E20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FL/xfqLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393663AbfAPOfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:35:21 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:64705 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbfAPOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:35:21 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x0GEZ946009281;
        Wed, 16 Jan 2019 23:35:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x0GEZ946009281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547649309;
        bh=+jli3ZL8FOAuv4V8Lvb0rzw5Y0ubCjCOdZ9vaiLzM+8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FL/xfqLGvjSekpYXhaacrSB2At2QJ/AWxICvAB0YKTML+dAi+Cn4+4ScL4yg2U4kD
         2ARe5GHjpAiuWsE+xM4gj58E4Jv/4sJuFMmabtBcgooLE/G9U87dnAwfRKYzgb5TpK
         +elJweR6Spi7w638ZmproPho0ZoKrUvvrJSUfx6wUOQMLkuqswCXJRSNlEBL3dpS5T
         LQQRO8i5w9NQ4Hx1FEP80B9qeGlv9bX09dBcTQxbY5xI2zIx1u+5dJqrP98J/URPLY
         zwLlN+ACKR6XxAO+AeZn5Lm86impQTi44uSfAh+ycb2OX/thbwLhFISMd3j4fn1p6T
         HizrmxsaSrwLg==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id d2so2236830ual.2;
        Wed, 16 Jan 2019 06:35:09 -0800 (PST)
X-Gm-Message-State: AJcUukdLqgtMRAO2OqjqcRl5tS9LHZa+W46y9dnVQRZjk7K7tv7zWwyA
        utYEbvPdLRcW3XjAGlx+ML3faWJmhFgNfbPewF8=
X-Google-Smtp-Source: ALg8bN5KAxwlGhp7OZlcl7GRUh9//SYQNBx1NwCK3uiZai0hz1kLPHORToYP1dc96cnwC5ipNv3uP8Mr/bFY0qVekx0=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr3771975uad.55.1547649308404;
 Wed, 16 Jan 2019 06:35:08 -0800 (PST)
MIME-Version: 1.0
References: <1547454569-27319-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547454569-27319-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 16 Jan 2019 23:34:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNASKFbynGoie6Pox8nZhikeobMDBk-V8gz=Z6cj3_ieKCQ@mail.gmail.com>
Message-ID: <CAK7LNASKFbynGoie6Pox8nZhikeobMDBk-V8gz=Z6cj3_ieKCQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove unused archmrproper
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 5:30 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> No one uses archmrproper.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild/fixes.

>
>  Makefile            | 4 ++--
>  arch/h8300/Makefile | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 68898cc..a9c54e1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1360,11 +1360,11 @@ mrproper: rm-dirs  := $(wildcard $(MRPROPER_DIRS))
>  mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
>  mrproper-dirs      := $(addprefix _mrproper_,scripts)
>
> -PHONY += $(mrproper-dirs) mrproper archmrproper
> +PHONY += $(mrproper-dirs) mrproper
>  $(mrproper-dirs):
>         $(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
>
> -mrproper: clean archmrproper $(mrproper-dirs)
> +mrproper: clean $(mrproper-dirs)
>         $(call cmd,rmdirs)
>         $(call cmd,rmfiles)
>
> diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
> index 4003ddc..f801f37 100644
> --- a/arch/h8300/Makefile
> +++ b/arch/h8300/Makefile
> @@ -37,8 +37,6 @@ libs-y        += arch/$(ARCH)/lib/
>
>  boot := arch/h8300/boot
>
> -archmrproper:
> -
>  archclean:
>         $(Q)$(MAKE) $(clean)=$(boot)
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
