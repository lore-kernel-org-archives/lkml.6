Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4CDFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7132E21476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GxUzEYV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7132E21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeINSUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:20:20 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:63799 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINSUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:20:20 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w8ED5c2b016341;
        Fri, 14 Sep 2018 22:05:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w8ED5c2b016341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536930339;
        bh=J2w0FFgOymZT/pjSRP26LjEdCBL6wh2LtC7euUYULL4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GxUzEYV6cXb5sW+ecxoKXCSvmlkxiVga3E9AWo0iky9mhEDut21QnbDT5VmhbWI5b
         JwSODrmxWFGcwnsnAI5Fo3eU7jfWPjglrZsW5sVKopOosIvdyuAQevYRGTA0uIPGV0
         6pHTtMYkSv4aSACfj5JhPxXIgOZkPY+4t8oRskOflvGKFedqqdh32UAzdXKe6CPHIy
         NipsTjIJ9zSAU0KTM5MBcTxx6TWl9zIDyj4JXe6ojkOIJyMw+j/3kD7C/ZIiYhIyC8
         AkABO93uvg9lH8sdLQuTRGKxL4+xCymH04XA178QpvBBPwaciVwJnH7bb1mZOF5bey
         1y/0X11mC/amA==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id f4-v6so6975190uao.10;
        Fri, 14 Sep 2018 06:05:39 -0700 (PDT)
X-Gm-Message-State: APzg51DPgYPOuOIInTHyjQeFMsDFpuQu1YccYetyOs7TEkCieiz1MCxb
        7zMitaQA49UKfFoHJCFCkJPeRFc0d8LNnf/1r0Q=
X-Google-Smtp-Source: ANB0VdbgSCnXizVQye90iP+VroK+Y4BurlwuJWb8eTR3pjfs3dSgleP1ZtDowVRlak9w1iTxo567bcwBGVm4cbR042g=
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr3914443uag.16.1536930338206;
 Fri, 14 Sep 2018 06:05:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 06:04:57
 -0700 (PDT)
In-Reply-To: <1536727974-28211-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536727974-28211-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 14 Sep 2018 22:04:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQPnZW9fa5AvACotct5CfFNvHp-ivqoiqQiPXDQKVyQmg@mail.gmail.com>
Message-ID: <CAK7LNAQPnZW9fa5AvACotct5CfFNvHp-ivqoiqQiPXDQKVyQmg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: prefix Makefile.dtbinst path with $(srctree) unconditionally
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-12 13:52 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> $(srctree) always points to the top of the source tree whether
> KBUILD_SRC is set or not.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>  scripts/Kbuild.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index ce53639..46cc43e 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -193,7 +193,7 @@ modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
>  # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
>  # Usage:
>  # $(Q)$(MAKE) $(dtbinst)=dir
> -dtbinst := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.dtbinst obj
> +dtbinst := -f $(srctree)/scripts/Makefile.dtbinst obj
>
>  ###
>  # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.clean obj=
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
