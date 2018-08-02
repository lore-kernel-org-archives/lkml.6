Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A93C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B869B2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Kze0TmRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B869B2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbeHBRlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:41:11 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:20365 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732430AbeHBRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:41:10 -0400
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com [209.85.217.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w72Fn3Gh028480;
        Fri, 3 Aug 2018 00:49:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w72Fn3Gh028480
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533224944;
        bh=Rjk32v8BRzIWY9QAWY/wb4/FNzuQpPgY5XhNHfCLy3o=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Kze0TmRRTx+tNv5KcalDGPdbFXDk7BtLGqUQqE/lTFIKPZ3wRE9wBwiDCq3VruncF
         ufFkaJx8eS3CnZblYwRUzg9ApuF762kOWhyLbP+wce+ge3EEP8mmWk4OnW2oteug6x
         6kGS49aBM3bUD8c7P5IBpAzHlIFayuL/hpkdOUmVryW4rg3RDx0pFziiGM/JUxWMjx
         EMRJB71gZyLB3ShJex9griR2nZMyclgudRtjatcRVIk188RpQiqXyQ77uO07LWyxA3
         wjuQwmlshEiBCq1wjoFL4GJPiMXe2tctv+8p4uiPYcAW5hJo0H5wP0L5HXbUN1ss+1
         OYHez5pNbqeDg==
X-Nifty-SrcIP: [209.85.217.176]
Received: by mail-ua0-f176.google.com with SMTP id x24-v6so1761250ual.10;
        Thu, 02 Aug 2018 08:49:04 -0700 (PDT)
X-Gm-Message-State: AOUpUlHGXN4tmSxYJXNKsToaoXaipoo0ObQceWi6iKRYFPWbdlnnMaVz
        XVljfphzWgNSrOf914zUo4w6OqVyPSZBd95chDc=
X-Google-Smtp-Source: AAOMgpdJ+NPx/1Ps3B/kgFyoBFIi8a05NyVF8/hEv1l4jbTToeqKCbCNwNOfbTuW9WdSsYJBFiRMCx5kfpAP+GR9wZs=
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr31876uad.82.1533224943155;
 Thu, 02 Aug 2018 08:49:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 08:48:22 -0700 (PDT)
In-Reply-To: <20180802134708.26456-1-dirk@gouders.net>
References: <20180802134708.26456-1-dirk@gouders.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 3 Aug 2018 00:48:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS2JRuT2-2jx0t4BM9VrJROXZNL4zqsVNNvYnodHx+HAQ@mail.gmail.com>
Message-ID: <CAK7LNAS2JRuT2-2jx0t4BM9VrJROXZNL4zqsVNNvYnodHx+HAQ@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: Makefile.modbuiltin: include auto.conf and
 tristate.conf mandatory
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-02 22:47 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
> The files auto.conf and tristate.conf are mandatory for building
> modules.builtin files, therefore include them as such.
>
> Usually, the top-level Makefile ensures that those files exist but we
> want to make sure we get noticed if they are missing for whatever
> reason.
>
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---

Applied. Thanks!

>  scripts/Makefile.modbuiltin | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
> index 40867a41615b..a072a4267746 100644
> --- a/scripts/Makefile.modbuiltin
> +++ b/scripts/Makefile.modbuiltin
> @@ -8,10 +8,10 @@ src := $(obj)
>  PHONY := __modbuiltin
>  __modbuiltin:
>
> --include include/config/auto.conf
> +include include/config/auto.conf
>  # tristate.conf sets tristate variables to uppercase 'Y' or 'M'
>  # That way, we get the list of built-in modules in obj-Y
> --include include/config/tristate.conf
> +include include/config/tristate.conf
>
>  include scripts/Kbuild.include
>
> --
> 2.16.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
