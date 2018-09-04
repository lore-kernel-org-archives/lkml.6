Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A253EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599EF2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1ju2Bbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599EF2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeIDLT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:19:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43506 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIDLT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:19:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id h64-v6so2033822lfi.10;
        Mon, 03 Sep 2018 23:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=re0YyN5EOw0zfdIiJN+ViN9M4ElYQq0Cz+zS7RLlNbU=;
        b=s1ju2Bbe3lSBg6KcBNBKkTWgKYRFNKvjF1gDmOYtDlnXVRxXmGnTXmG7zDLnIT2U4b
         hk6kmeA+fpwjh5MUztspkwl+mc8e/5ZnKxE8KYzs0xu1AiZVAqT3MthSsRYYXkV5J9EQ
         X2AOHM3K/mMMVEYzhmmfq6fUKY2WXbgbFKOgyrJJZw4w21pp5Uhq0J4Tk2tr+pBXO/ys
         PZknMh2ZkaVe+Qa0AVEMMNV5hS5V6CLTsN6839+6ubghYTJxGu4XajFahKN/7dxi+3ub
         YS29qIXcM2JYgDnZLBahpwkBQsQxhwGesLkFsQ18uJ4nIDwJy2eTqjrK9uKBF2Vyhggh
         kFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=re0YyN5EOw0zfdIiJN+ViN9M4ElYQq0Cz+zS7RLlNbU=;
        b=ZPtZQnlKyA9Q894YLKqRKNiVD2VIDhopX7AKspWx+BqtEzKhihiBe6CW6MVCHlYv4v
         H9FexM94fZ49KojfDd2meBAfMC4SgYHBhUdbp7SA+3VCcQqjZ9tVxT7CvdOPzb7tMmC0
         HBcCFf9gsXdlPv8LwtPaW4lDWxajOJoz5kT+pBumPS8No3k0UXxZXJDRV3fu1TegCxq7
         xK9DG4uBkHU8/a83QjZiCm9nVamnKJMo9aeXIxFlpnKY35QKmfC9cnApuhttQMwSrYs1
         7YGw7Bz866MVv38JRy//Pc8odwS5eknIslZzT2vYfniVSz5tOHEroHzOG3tV6hpYOlbO
         lxyQ==
X-Gm-Message-State: APzg51CoSSEOGqpUsS7PBIBWzyTJ+Xwv8lFoIuUgU1oVkCC5JWK2aSCj
        XBr937bNFHfypW4mg5AutKBMuPtDKxtnKvYwIWs=
X-Google-Smtp-Source: ANB0VdZTO5SLDRuHWhBXLFptutceOBLZe8zKOol5xq3duMha2HU+FkFA4UCsp36g3CJwnaAxXs1Yps2vyEZ8v7ukKqU=
X-Received: by 2002:a19:23c5:: with SMTP id j188-v6mr19045676lfj.137.1536044142178;
 Mon, 03 Sep 2018 23:55:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:4c3c:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 23:55:01 -0700 (PDT)
In-Reply-To: <b48edead2c6abb862b121d347b01bf07dec818ea.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
 <b48edead2c6abb862b121d347b01bf07dec818ea.1533950271.git.baolin.wang@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 4 Sep 2018 14:55:01 +0800
Message-ID: <CAAfSe-tn3o2WusU1uA6G86dHEJKN0hvOmLb5G6J30KHXB56+gw@mail.gmail.com>
Subject: Re: [PATCH 3/5] serial: sprd: Remove unnecessary resource validation
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 August 2018 at 09:34, Baolin Wang <baolin.wang@linaro.org> wrote:
> The devm_ioremap_resource() will valid the resources, thus remove the
> unnecessary resource validation in the driver.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index e18d8af..03b0cd4 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -710,15 +710,12 @@ static int sprd_probe(struct platform_device *pdev)
>                 up->uartclk = clk_get_rate(clk);
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(&pdev->dev, "not provide mem resource\n");
> -               return -ENODEV;
> -       }
> -       up->mapbase = res->start;
>         up->membase = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(up->membase))
>                 return PTR_ERR(up->membase);
>
> +       up->mapbase = res->start;
> +
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0) {
>                 dev_err(&pdev->dev, "not provide irq resource: %d\n", irq);
> --
> 1.9.1
>
