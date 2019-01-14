Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419A5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D3E20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYpWQW+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfANLpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:45:39 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33220 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfANLp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:45:27 -0500
Received: by mail-vk1-f193.google.com with SMTP id d201so4790106vka.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOv9Qrq6hri4qiRM2sCo62WGAz+kbMcRK+rOBxv/WjM=;
        b=SYpWQW+lbgoIZyB962f2Q9e/fJW9TMloKZChuJdxQBFCsdF0CeyUyYErRY9LLnNJRe
         awAeMm6a8KbWUyXVckugLQRwIxViEWqgIYXN6JBKYcM2T9G7N7Sgl1Ur9dB9+qj39uGs
         his75ew4PuQqeRZYSX+pOVnCBz6uWLAaTQ1zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOv9Qrq6hri4qiRM2sCo62WGAz+kbMcRK+rOBxv/WjM=;
        b=RmsmjiqgyBVD0oxMf8yC0z6r4raaDmjLUk3g7NAYZvY+MdI8NiT62ElCAMT/fayz14
         BTYXeO2GjSCV7iZWUxNgbL8SYh+w5RAQB/rc+NC87oh/KoSnYn8TcvChSN1NwKeMvXO/
         S2NAaVAG+JMnIU+wtJfeMqa0SPir9q46cTXB5pAxkBCAsuGt4EcV/sw8NumcwWFbe5oA
         IEURZTquIGfLhDddw8YgftUScQw5uwuUfm/sXltu+WT+18XFAw5czvAgJwkYCzYMEE50
         TfpwWPe8eitEnEI3vLuqpfR/y536yjx6+kM4fnozFkerA39/F26PPoNeX58F3Q464wVe
         /j9A==
X-Gm-Message-State: AJcUukdAbJrhxjevvsW0Di2A4dNoXJoPDii90o9o8q0WlNeRBBfXZ5U7
        CeTGuGK031juNMWJDGArxxlISMzMjHgRE+GYlpPM3Q==
X-Google-Smtp-Source: ALg8bN66qF3i+E4MfhNhpQVy6pgaACLMlC1v/v9pXKlpdaFw4jTRyWAaNfT9MfNtqV9Ngkg2MDJTrmJWXFYrlI/oE+0=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr9160121vka.4.1547466325905;
 Mon, 14 Jan 2019 03:45:25 -0800 (PST)
MIME-Version: 1.0
References: <1547035833-3924-1-git-send-email-wdjjwb@163.com>
In-Reply-To: <1547035833-3924-1-git-send-email-wdjjwb@163.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Jan 2019 12:44:50 +0100
Message-ID: <CAPDyKFq=AY=9hDDAPMjLpNPhN06+ZFpX5DvpFshW7+de1_b=NA@mail.gmail.com>
Subject: Re: [PATCH] mmc:sdio: Remove unneeded variable ret
To:     wangbo <wdjjwb@163.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        wang.bo116@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 at 13:11, wangbo <wdjjwb@163.com> wrote:
>
> In sdio_bus_remove the variable is unneeded,remove it now.
>
> Signed-off-by: wangbo <wang.bo116@zte.com.cn>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_bus.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index b6d8203..62b0f5e 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -179,7 +179,6 @@ static int sdio_bus_remove(struct device *dev)
>  {
>         struct sdio_driver *drv = to_sdio_driver(dev->driver);
>         struct sdio_func *func = dev_to_sdio_func(dev);
> -       int ret = 0;
>
>         /* Make sure card is powered before invoking ->remove() */
>         if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
> @@ -205,7 +204,7 @@ static int sdio_bus_remove(struct device *dev)
>
>         dev_pm_domain_detach(dev, false);
>
> -       return ret;
> +       return 0;
>  }
>
>  static const struct dev_pm_ops sdio_bus_pm_ops = {
> --
> 2.7.4
>
>
