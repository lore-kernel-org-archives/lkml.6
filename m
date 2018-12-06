Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE27C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5625F20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+uC2byA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5625F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbeLFK15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:27:57 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:37018 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeLFK14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:27:56 -0500
Received: by mail-vs1-f41.google.com with SMTP id h18so13976105vsj.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTuQqLojoRyWNzv41Dr7ft3HFMoe6IQKNqxowRqHgkw=;
        b=N+uC2byAvJFhV03P5T30fJEAslEJsX0L1yTGQoR0aXYnLxOunsxyrWYppR9z6PLLUq
         HylY+FjxOvuiinLIEdCC/rlEE81sVxxwNkggmDHrLqQhLambI15DB2jxFt5xp4Rp6kR8
         xqkMM9DjrZG5R/1f/PBpOaIKByvH+cNqB3qu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTuQqLojoRyWNzv41Dr7ft3HFMoe6IQKNqxowRqHgkw=;
        b=WHdQJrRgXV4kCEC6uzvTolVmlIKm98yi0Ly1pyYZ7vPd4508sk0eEPMp8P2MstJyaz
         vZjXCPnRJTDsBFIgyGJPBrCtOSEdPu2gY+kpbQ5Z5hAuCmOExPEYHA6FbY+f1H00ndD7
         +GqeGTW4sf7kMwoZBWliMGlZKJ8zpMEoRvwkBMLwlB/33M+ivC57usRIOMGxKDqwLjBF
         X2dOXTlbKmWLbcrip+xONjSLrB5cOwWt8sGbivh9vO+fb/TiCzla3Q00TWLXVZ9XO9cN
         0q4TbMWmjPUkrLnEM6iBq6/vdqrTP3/CM3Soe1B4YDKwNPRF1AcgAKAwHHUmKs4h2bFz
         8ncg==
X-Gm-Message-State: AA+aEWY0xhvR9xo1uatvTXfMnfEToe7ZUJRUBef1FX+sb2/slh3EqG42
        ei5vx3uRyqyqTtjqDVTTbeihKrb3RdbU454rvgcd8w==
X-Google-Smtp-Source: AFSGD/WeAxhDdJEVtHDUyAUbwOmV0/8NbUB8+e+ab94TdPSaWqIKd+BVinzKpLSTUuXRM/8TKAZtf+w/1D9UunJAwKY=
X-Received: by 2002:a67:e002:: with SMTP id c2mr12640849vsl.34.1544092075440;
 Thu, 06 Dec 2018 02:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20181206092411.12152-1-colin.king@canonical.com>
In-Reply-To: <20181206092411.12152-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Dec 2018 11:27:19 +0100
Message-ID: <CAPDyKFrR6u=WbDo9OpeZeTyEwwQfBqpECNFsOnttewQ6c7ic4g@mail.gmail.com>
Subject: Re: [PATCH][next] mmc: sdhci-of-esdhc: fix spelling mistake
 "upsupported" -> "unsupported"
To:     Colin King <colin.king@canonical.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 10:24, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a pr_warn message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 856e809f38b7..e21e90f81bbd 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -597,7 +597,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>                         pre_div = 4;
>                         div = 3;
>                 } else {
> -                       pr_warn("%s: using upsupported clock division.\n",
> +                       pr_warn("%s: using unsupported clock division.\n",
>                                 mmc_hostname(host->mmc));
>                 }
>         }
> --
> 2.19.1
>
