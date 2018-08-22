Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A917C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA58214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2VTmd6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA58214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeHVNN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:13:26 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37551 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbeHVNNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:13:25 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so2156394itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G7k12NEe/K6PhOVSzhCdcl0vo4/q1k38l6Vn9h3lL9E=;
        b=J2VTmd6hyjupGWEQGxzYDVktNIN4W4ET98wJ1x4f0/3hHwu2KZE48S9bhO7gkLGRQs
         MWEUSkkwLOBd1jwzZHoBZyJbTqVRnneHxmr113EghETFjQGaE/ZVLsnYxZHOw/Ue7atj
         nnBJ+WhbHYISnlVX/9pW3L6/K/RQtOB3ORE0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G7k12NEe/K6PhOVSzhCdcl0vo4/q1k38l6Vn9h3lL9E=;
        b=h6B/3JkBMOrpojM0SOJ7q9bjYvEPiO8DeERt+Xmrh2yRe3WjkPWWQus4riE1rS6ps1
         RNBTs2glgyfqKZUzh55tN5eSeVNwhP6Ww1bL10E5fAYQA+XewovYBMLk67pRq2JwQWoN
         my8WMROnTKXpMj2Fu3PxZhYuKO5QhMI3chzaH15iCWKu5bGT6nQ+8QkvTyTBNTXk17lB
         1AnXB+oOKLuPf+YOCRTh+OQ3NVr6pl7jUroV4tVY67V+iP/QTeF5HL7atF267F4xkJXM
         msYCB53+VXpC3pcnOk5A6ln6DEBXXQkjQnPNyMrrL7KCfJA4EOdhYIPypv8E/7RWobXT
         Negw==
X-Gm-Message-State: APzg51CkMMrPVEEGYbKnSYQI4Tg9Zc8tV87JXI2JNFDDaPOtOLObWdng
        ZdjrR07NTd0VpTGknG9BmJoUC7YGUE0mMW6zGr0Y6Q==
X-Google-Smtp-Source: ANB0VdYmDoRQeGdwY7edk3huJmUvTrxd89wVESVotcglM5kI0dUuv6J5B4qphKRQoZD8U2yTpIX/leQs54dU6lqV7sA=
X-Received: by 2002:a24:800c:: with SMTP id g12-v6mr2487688itd.146.1534931355360;
 Wed, 22 Aug 2018 02:49:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 02:49:15
 -0700 (PDT)
In-Reply-To: <20180821152151.32113-1-paul@crapouillou.net>
References: <20180821152151.32113-1-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Aug 2018 11:49:15 +0200
Message-ID: <CAPDyKFr+xbnMdzj90bHi84gD9W4U0CUvrExBdmhJ-1miFi8xog@mail.gmail.com>
Subject: Re: [PATCH] mmc: jz4740: Add support for the JZ4725B
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>, od@zcrc.me,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 August 2018 at 17:21, Paul Cercueil <paul@crapouillou.net> wrote:
> The JZ4725B is the first JZ SoC version that introduced a 32-bit IMASK
> register, not the JZ4750.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Thanks, queued for v4.20!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/jz4740.txt | 1 +
>  drivers/mmc/host/jz4740_mmc.c                    | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/jz4740.txt b/Documentation/devicetree/bindings/mmc/jz4740.txt
> index 7cd8c432d7c8..8a6f87f13114 100644
> --- a/Documentation/devicetree/bindings/mmc/jz4740.txt
> +++ b/Documentation/devicetree/bindings/mmc/jz4740.txt
> @@ -7,6 +7,7 @@ described in mmc.txt.
>  Required properties:
>  - compatible: Should be one of the following:
>    - "ingenic,jz4740-mmc" for the JZ4740
> +  - "ingenic,jz4725b-mmc" for the JZ4725B
>    - "ingenic,jz4780-mmc" for the JZ4780
>  - reg: Should contain the MMC controller registers location and length.
>  - interrupts: Should contain the interrupt specifier of the MMC controller.
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 993386c9ea50..0c1efd5100b7 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -115,7 +115,7 @@
>
>  enum jz4740_mmc_version {
>         JZ_MMC_JZ4740,
> -       JZ_MMC_JZ4750,
> +       JZ_MMC_JZ4725B,
>         JZ_MMC_JZ4780,
>  };
>
> @@ -176,7 +176,7 @@ struct jz4740_mmc_host {
>  static void jz4740_mmc_write_irq_mask(struct jz4740_mmc_host *host,
>                                       uint32_t val)
>  {
> -       if (host->version >= JZ_MMC_JZ4750)
> +       if (host->version >= JZ_MMC_JZ4725B)
>                 return writel(val, host->base + JZ_REG_MMC_IMASK);
>         else
>                 return writew(val, host->base + JZ_REG_MMC_IMASK);
> @@ -1012,6 +1012,7 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
>
>  static const struct of_device_id jz4740_mmc_of_match[] = {
>         { .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
> +       { .compatible = "ingenic,jz4725b-mmc", .data = (void *)JZ_MMC_JZ4725B },
>         { .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
>         {},
>  };
> --
> 2.11.0
>
