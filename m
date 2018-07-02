Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5F7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B4525469
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQjA0nBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B4525469
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeGBOhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:37:45 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38756 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbeGBOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:37:43 -0400
Received: by mail-io0-f194.google.com with SMTP id v26-v6so2682859iog.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fpEzOTF2F3/HeXdfyDhMbtiRjVOFiagoD2wnd8LuMyE=;
        b=XQjA0nBpKFXClAP3lpHxuqwW1FctjeHvPUuQ4LVImjzrlYSKgqIM3E0iJCy2owqAFS
         OaR5ivq6tDHRmm1RSGzmEeNN3MAZV4vsYjjPcNsnDZXl4SjqPnsrHgy/J+9K9CvpxPFg
         ZezxV3zNw2AQbR8Z+3lv1O2CYT2z+1jt3Ai0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fpEzOTF2F3/HeXdfyDhMbtiRjVOFiagoD2wnd8LuMyE=;
        b=lWogL2/Lh+rOgZeSVq9LBtUHwz3mFemwxoaEEjQtEQvET05nGkGlYqNA0GYVfJBrAt
         vDkjIFJj8fvanFvkleVLIKNpmOkaK96gMwyeDwOT0A586TpI3LQYv4nfaVpphvv+pUTB
         JR1zw0ExVbN1fZN8rdoXnf16+J9ht/VgrOLL8UmlOOPwfoov1M1bzxK1u6+sU67taRq2
         FA4JVfG+gberVHXdtRUWS+g95sJ6mA6aUBw3BeIi3C9KsRut6IPd8/DuJNKBmHY4toa/
         jIxIQbA+gbB7BDSQEb1wz+k8RzsHS8ykXpUCCuzp3f27+6MMmRaD9TiFALVByHnDeEdN
         awAw==
X-Gm-Message-State: APt69E3uCj6pQJq4jSY9C/DvcL6vh3reuSaXYeMy3qTesl6FZ2FaxPo3
        BQI1SWqdQTh9Qe09+PdBqc6iOqbXFHBrUqxRBx0VqRTz
X-Google-Smtp-Source: AAOMgpeQC5PrcNKvhh/UH0+uTtk9ZRLziEDmXVrVb/5iqNGkl/ert0OTxFhbrkZS0Y5BHQqE6QF7JsNvw456GhQtpE8=
X-Received: by 2002:a6b:e403:: with SMTP id u3-v6mr20588998iog.131.1530542263322;
 Mon, 02 Jul 2018 07:37:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 07:37:42 -0700 (PDT)
In-Reply-To: <1530280769-14114-1-git-send-email-kehuanlin@pinecone.net>
References: <1530280769-14114-1-git-send-email-kehuanlin@pinecone.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jul 2018 16:37:42 +0200
Message-ID: <CAPDyKFpi5tN__ue+j+QREp-KFEE_X6ib2MQY5oVm8q6m+sDwkA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix errors to use card read/write threshold
 for HS400 mode
To:     "Huanlin.Ke" <chgokhl@gmail.com>
Cc:     kehuanlin@pinecone.net, zhangbo_a <zhangbo_a@xiaomi.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER" 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Qing Xia <xiaqing17@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 June 2018 at 15:59, Huanlin.Ke <chgokhl@gmail.com> wrote:
> The card write threshold is applicable for HS400 mode only, so it should
> return back except HS400 timing mode.
>
> The card read threshold is also required for HS400 mode as the host
> controller incorrectly samples the data if the card clock stops within
> a block transfer.
>
> Signed-off-by: Huanlin.Ke <kehuanlin@pinecone.net>
> Signed-off-by: zhangbo_a <zhangbo_a@xiaomi.com>

Thanks for your patch!

I have just applied an earlier version of the patch, posted by Qing
Xia from Hisilicon.
https://patchwork.kernel.org/patch/10434913/

If it works for you as well, I can add your tested by tags for it.

Also, can you perhaps point me to a commit which introduced the problem?

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 623f4d2..d4e6983 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1065,7 +1065,7 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>          * It's used when HS400 mode is enabled.
>          */
>         if (data->flags & MMC_DATA_WRITE &&
> -               !(host->timing != MMC_TIMING_MMC_HS400))
> +               (host->timing != MMC_TIMING_MMC_HS400))
>                 return;
>
>         if (data->flags & MMC_DATA_WRITE)
> @@ -1074,6 +1074,7 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>                 enable = SDMMC_CARD_RD_THR_EN;
>
>         if (host->timing != MMC_TIMING_MMC_HS200 &&
> +           host->timing != MMC_TIMING_MMC_HS400 &&
>             host->timing != MMC_TIMING_UHS_SDR104)
>                 goto disable;
>
> --
> 2.7.4
>
