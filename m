Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35216C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68D3214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lv4NTMfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68D3214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeHVNMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:12:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55943 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbeHVNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:12:53 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so2086774itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XJ18fxEQvDQ8NxG9MFPEOKOMNUkOBlWKKfCxFjMB/1k=;
        b=Lv4NTMfM/+EqSyUI5uzY56o4Tjs4XPRPw3XfR12v+5a9pOgGyqJc1jPAzB5J6mrcT/
         7ShFYokbXIkx4KTpo22mqlawrHoAio9F2W2ISDAttlrNniea2qRMCYWdUYwMxq0WM7RI
         4QqZOp9WOxurm/bVkaWCkr2HXBsIRrkGOJE7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XJ18fxEQvDQ8NxG9MFPEOKOMNUkOBlWKKfCxFjMB/1k=;
        b=hUK47j3xNIMMgMxECdHFLovo63PjZftfKNAxE/ZxmaNedZAm8+NazacGcYRSja+s4D
         q3e9xaRYQFI1If7/3rhIiptvw3KvPtwMOXG4XGvFaDryWFYVeQjmKhRjOfzEuumHvmGu
         XPlE0AxCiGzhtbuaBD7TqtoL8oML9beHTuKt5ip0Dj0QjMvN0sa6xSIYmbJn8yJSUAil
         Ry7ShhKUSCtCd7QgBy0vJg8TwLEqCbAmQ4YZ2zvZGLm6uP0fITOIHycAwvCOYL0GQyvv
         E4y6RBtNW328UIwxFCaYXi/JNOR45PfAboeULi+XO9WOoWYiIBsE1nRdP7ihV2IDDnH6
         gPKA==
X-Gm-Message-State: APzg51AxW3ZjqoB4Y8cLRPPJA5Kwadeid7XgSReRbKTa9ILPWTmS7ySV
        skPkjOrq1cB/5I9cL3WFgHyxg/5ONVocLG/jYlmG0Q==
X-Google-Smtp-Source: ANB0VdaCruR6fBigGv+fhyiyeXFp24pBginCsCUJYFQDLehF22NikMzhXFFcl/vnkJwTwsEF7gDE0zCDvwOTbRgh1tM=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr2657217itb.45.1534931324235;
 Wed, 22 Aug 2018 02:48:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 02:48:43
 -0700 (PDT)
In-Reply-To: <20180821130320.1682-1-paul@crapouillou.net>
References: <20180821130320.1682-1-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Aug 2018 11:48:43 +0200
Message-ID: <CAPDyKFqF0kQO1xgSV1s0QjG=JUwhvXwy8h8gOD=A4_RPf5GhGg@mail.gmail.com>
Subject: Re: [PATCH] mmc: jz4740: Drop dependency on MACH_JZ4740/80
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 August 2018 at 15:03, Paul Cercueil <paul@crapouillou.net> wrote:
> Depending on MACH_JZ4740 | MACH_JZ4780 prevent us from creating a generic
> kernel that works on more than one MIPS board. Instead, we just depend on
> MIPS being set.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Thanks, queued for v4.20!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0581c199c996..71d9bdc52422 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -761,7 +761,7 @@ config MMC_SH_MMCIF
>
>  config MMC_JZ4740
>         tristate "Ingenic JZ47xx SD/Multimedia Card Interface support"
> -       depends on MACH_JZ4740 || MACH_JZ4780
> +       depends on MIPS
>         help
>           This selects support for the SD/MMC controller on Ingenic
>           JZ4740, JZ4750, JZ4770 and JZ4780 SoCs.
> --
> 2.11.0
>
