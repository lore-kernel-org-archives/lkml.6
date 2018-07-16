Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E5AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EA2208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjTmCUJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EA2208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbeGPLqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:46:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46824 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPLqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:46:06 -0400
Received: by mail-io0-f194.google.com with SMTP id i18-v6so21682713ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QTL84Qn7dmy1PeBiUm0AtuOXpI1oY/KM2g6RxTEfo34=;
        b=SjTmCUJurfQLWIajxodqFYZXzUmNUEca9b1+2+jCXWjiPV38zE5oNfoJVUSxdCCKZN
         1Q1oFuqBCsKRVjbRxw6izoUBSmAYZ9Mi8kS2afpwcjQuPwPZ7/SNrzdClwguUzVQrrta
         q5qVomEg1ARmkFYiE5/qYPWA7R347Rn8jlW2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QTL84Qn7dmy1PeBiUm0AtuOXpI1oY/KM2g6RxTEfo34=;
        b=BTT/ZVArF5nDdRhpqarMrWtlhTVwxwJUwALn8DqQby5Y05HjqW6tK1LRQazaHtquYj
         bcaRMO71tAsGMhqZJOO3LBG5Pm+kVzTb9HKfXpnpUtAjqlVRclUVt82Dwg46TbivhdBk
         s4xSH8zu05qf3R63d4rDrS0SzaMY9vykSLohYiCmGyuQ7C7eORKnK+uwRXIGrpWTSR2L
         dmyv8QkIx3Kk/EPv5FvoR3wsWuFHpDx3FGaOAYtf5KXQZE78UxgHltSZ2ODRLHFiFedR
         3FDv43vuyDAPDipFS7bygtjOZK84ISeM+1qoWE4P3aKC6y3Xt5nrGl+oClbAvIQyToLf
         4XzQ==
X-Gm-Message-State: AOUpUlFea4IvB0qxYZGvgVX/iqPhPu+657JAYN0DTXAwO8euef1vyDxB
        wT6hQrfe4f8naVSCQETvG04qHUMafv+tzTC2CrKcog==
X-Google-Smtp-Source: AAOMgpfXnbbcWjLaKd4ztWXcbsck6FJ8ue+9GjdYkeBhKkn5G8uxPLEv/TxPIZKk28/LLTQxfotlYDxZakU02afMzog=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr40572677iof.266.1531739949717;
 Mon, 16 Jul 2018 04:19:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 04:19:09
 -0700 (PDT)
In-Reply-To: <1531739517-23108-1-git-send-email-hongjiefang@asrmicro.com>
References: <1531739517-23108-1-git-send-email-hongjiefang@asrmicro.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jul 2018 13:19:09 +0200
Message-ID: <CAPDyKFqU+_zPFw7f4FGWPe9OPpsDDtdF7JUxMA8ejTB0RyUCCw@mail.gmail.com>
Subject: Re: [PATCH V3] mmc: core: improve reasonableness of bus width setting
 for HS400es
To:     Hongjie Fang <hongjiefang@asrmicro.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Bastian Stender <bst@pengutronix.de>,
        Chanho Min <chanho.min@lge.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 July 2018 at 13:11, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
> mmc_select_hs400es() calls mmc_select_bus_width() which will continue
> to set 4bit transfer mode if fail to set 8bit mode. The bus width
> should not be set to 4bit in HS400es.
>
> When fail to set 8bit mode, need return error directly for HS400es.
>
> Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
> ---
>  drivers/mmc/core/mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4466f5d..b2e1eb6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1338,8 +1338,11 @@ static int mmc_select_hs400es(struct mmc_card *card)
>                 goto out_err;
>
>         err = mmc_select_bus_width(card);
> -       if (err < 0)
> +       if (err != MMC_BUS_WIDTH_8) {
> +               pr_err("%s: switch to 8bit bus width failed, err:%d\n",
> +                       mmc_hostname(host), err);
>                 goto out_err;

You need to set err to a proper error code, else you may return a
non-error code from the out_err label.

[...]

Kind regards
Uffe
