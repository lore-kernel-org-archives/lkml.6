Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A111CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4801A20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JIgNTbiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4801A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389070AbeHAOCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:02:31 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33463 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388798AbeHAOCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:02:31 -0400
Received: by mail-io0-f195.google.com with SMTP id z20-v6so15867327iol.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RMgSBzpkzL4yu7QbrCA4OnsYtpbIhAv9afVv2VgAjKM=;
        b=JIgNTbiy09sRQTXpdfmoUxN6dRIn/yfRkjxAi0Wd5cfhLC9v84Hj1fYJYvlO69t0lF
         zheE+Vj1iO1BCFMvYxMOjBHhfhZ4Pzww/oQsIH7o+h2eGzg1to91JU//tn6zFQKLSiVz
         qWzhH8AkwwmzXmKeXbO73KDsPyBFuKGDWBETM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RMgSBzpkzL4yu7QbrCA4OnsYtpbIhAv9afVv2VgAjKM=;
        b=XtRRWImePs5tjBwcGEXgZZS7l0uY5jD2pN5vNeh7jMJYWVxR85/o82DZ5xzMydueFT
         EkKkpwHvedHHzBYj0dQIvVWtFBDQ5bzDwxIrzb/854/D8HMXBWqIDOwDdPxK4vAaTaQv
         K0//fnvliJe4y97uE6RanjETOiLLF/4E/AudCjMNN/WkrLX6X0nVhyQdyBp/BjofgqRM
         099+FZX8orQrareVaxd+yf5pa9UgqVnshzyoNJQ74iIQVITpIwKanulgJXgpU2J7i4Tl
         ADn+mqmuLAhrE0R4WUf4u2sNS2CXWetMGjL5VbxoNESacCsc/ihaar/wtr5a2WqyOiU9
         /pbA==
X-Gm-Message-State: AOUpUlHSemMzASB9bCtpmLvX7grbVI/PK0t7uIy42uwhlHKf5NoZgnDv
        pUiH2xviwKcwLxKzQ1MaqUSSlr6LyL/xKVn6zf2ZZQ==
X-Google-Smtp-Source: AAOMgpfqbQIJHP0ymcUO9Hi448c0N0mtPa4wqa5GdLO4tKRGIXdPWuvq09lIeWTw+jm7zpxvWc0nFpxXZM+alS/nBZ4=
X-Received: by 2002:a6b:e403:: with SMTP id u3-v6mr2940793iog.131.1533125819954;
 Wed, 01 Aug 2018 05:16:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 05:16:59 -0700 (PDT)
In-Reply-To: <1533005709-10909-1-git-send-email-hongjiefang@asrmicro.com>
References: <1533005709-10909-1-git-send-email-hongjiefang@asrmicro.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Aug 2018 14:16:59 +0200
Message-ID: <CAPDyKFoRw39g=wMghJCPid+z0U66cez4N6yPK3TDDPseWoiqQw@mail.gmail.com>
Subject: Re: [PATCH V5] mmc: core: improve reasonableness of bus width setting
 for HS400es
To:     Hongjie Fang <hongjiefang@asrmicro.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms+renesas@verge.net.au>,
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

On 31 July 2018 at 04:55, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
> mmc_select_hs400es() calls mmc_select_bus_width() which will continue
> to set 4bit transfer mode if fail to set 8bit mode. The bus width
> should not be set to 4bit in HS400es.
>
> When fail to set 8bit mode, need return error directly for HS400es.
>
> Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4466f5d..82af1e0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1338,8 +1338,12 @@ static int mmc_select_hs400es(struct mmc_card *card)
>                 goto out_err;
>
>         err = mmc_select_bus_width(card);
> -       if (err < 0)
> +       if (err != MMC_BUS_WIDTH_8) {
> +               pr_err("%s: switch to 8bit bus width failed, err:%d\n",
> +                       mmc_hostname(host), err);
> +               err = err < 0 ? err : -ENOTSUPP;
>                 goto out_err;
> +       }
>
>         /* Switch card to HS mode */
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
