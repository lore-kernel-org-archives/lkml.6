Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42998FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF7F21476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EZUqvq3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF7F21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeINSVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:21:08 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:16747 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:21:08 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8ED6JkX027630;
        Fri, 14 Sep 2018 22:06:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8ED6JkX027630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536930380;
        bh=+zll+6ZVyBIcbztlGJjNPPqLUlaPp4W3nvhc6rZCl80=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=EZUqvq3rikFUxlEY/ET3OVLvIF2/Pmr5ucGMgs8gnHhWwTCRLbgaPSnpWlrLyG0rd
         BIhX04dykGluqWsyPDLnr76+fr3WnntQR/fI+yKZxhTRjLlK8P3eXF5jrI3XxdVDjU
         cUAtZAseRTTpXvnQ09DiMN2mO7WuaIyei1G/si2itjk6q9QawuojLhcOyfxmqK3HkX
         3kseDbaZOSLr2VI3gQv4N1lZRUBm1it+Q5t/seCwP9GOz1MTnQrDtTix/2LWq1TEJI
         GOlsFQtfCkXdJKlHwBesDSUcW5PYp9J6GdIVZXyxGWTS6KGZD67CGvSGxchc746a8B
         Uwpif8GKmxZLg==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id o11-v6so7007804uak.5;
        Fri, 14 Sep 2018 06:06:20 -0700 (PDT)
X-Gm-Message-State: APzg51DtEKH4et9/nayle5ERTXG4nA8WGJomoxkDUa0svUWNc3ZsZ6+l
        xA+rcQ32Z9F+VVabVJL8R69pUHUXiSOllN3XeOk=
X-Google-Smtp-Source: ANB0VdbnL4zrIdF407g5NSuRnDrpDmgHTVrxlPW7x9ufLSO5M6acUrMUFIzES5gYTt49pKjRlVgZBW9B4i0iUX7BZ3Q=
X-Received: by 2002:a9f:3e87:: with SMTP id x7-v6mr3967635uai.53.1536930379054;
 Fri, 14 Sep 2018 06:06:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 06:05:38
 -0700 (PDT)
In-Reply-To: <1536734610-22173-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536734610-22173-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 14 Sep 2018 22:05:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2_5iak0iQ6xvsgyuvJdUD6TJe=g3VAPe08DA3UtK4nA@mail.gmail.com>
Message-ID: <CAK7LNAR2_5iak0iQ6xvsgyuvJdUD6TJe=g3VAPe08DA3UtK4nA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: hide most of targets when running config or
 mixed targets
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
> When mixed/config targets are being processed, the top Makefile
> does not need to parse the rest of targets.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>  Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 4d5c883..4b76e22 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1615,9 +1615,6 @@ namespacecheck:
>  export_report:
>         $(PERL) $(srctree)/scripts/export_report.pl
>
> -endif #ifeq ($(config-targets),1)
> -endif #ifeq ($(mixed-targets),1)
> -
>  PHONY += checkstack kernelrelease kernelversion image_name
>
>  # UML needs a little special treatment here.  It wants to use the host
> @@ -1732,6 +1729,8 @@ ifneq ($(cmd_files),)
>    include $(cmd_files)
>  endif
>
> +endif   # ifeq ($(config-targets),1)
> +endif   # ifeq ($(mixed-targets),1)
>  endif  # skip-makefile
>
>  PHONY += FORCE
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
