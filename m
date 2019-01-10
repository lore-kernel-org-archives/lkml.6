Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D38C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318122173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s1433isI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfAJLdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:33:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38508 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfAJLdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:33:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so11744554wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 03:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=qPQkRPBWGLMdgjVsBEx4c9gZ5TM6yu/W/N2PrOaMgSk=;
        b=s1433isIdfa6p2CS2A/Ik0HH/60B5plW5m5JK4z8heX9hL1na/D5PhzJO9MH6S7J+o
         QzI0AB/JZ+6fVB/cwrDEfY9tjlROH9u6O02SKs/JQHmadRYoo7OeJFcqndI4pGv9CP1t
         EJNNUjjJCgAN6NhrydGxa6ROOKAbh4oe/DZpDGnXAxCC9kHpXavRI6eiZjAhUhgS291m
         BjZMZP9OMs/TlUrFInP2Nfh9v+tV1hz0po/B5oCQVXYeo4aVa/Aq5ddCd+OE7ZZ3oa3w
         n8MWdWMm6xFLqcjK7rLPlx2LbCpRVDcNTLizw2wKY+iJjtqanAq0St/VAufjEMAGpBxf
         2YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=qPQkRPBWGLMdgjVsBEx4c9gZ5TM6yu/W/N2PrOaMgSk=;
        b=PqOGcbvXIp7lG5ko29vuQHw9+qACvj8lo5i3VjjBEJTgaBi9hQwXGCy2iGDryYDdOs
         JGdzHis8fTXUvZBgJbMaj1tfzoKdDL7oRwqml2PqaTQczMM4mOsUTR14gpa4DdgN6X8z
         Odyodi/zmY+4PNBYPjHla9dtd1eHu8M2AFAn8XLftvpBjHoXT4nr8WFGcPImznaa1w1H
         GuCnZy1qJJN6SegBn9Rn8x/k3ui9EUfjzjOpmJkaifm1sAyj4s9QmaYnzJVUgkUJg9qw
         npPbm9B1p93LMgBiRIdeRRznecTCNqT9BizMfhG+hcFIwiGh7bpGeKKN+oMMT2NYOVTs
         oTfg==
X-Gm-Message-State: AJcUukejbh4B2xfHJxVcg62vAMp5HZtlqVLGX99cnUugdKyKxCeERd9/
        m3cMw61hdx8lbNBHVa615dUvPDmRJZE4g2rFvqY=
X-Google-Smtp-Source: ALg8bN7zYJPPNroeL+xWYkR1mwYvCJ2s0pWArHBpsfZIuob6XQQA+d5lZHYhHEPnxRRu4HDVL7lulA==
X-Received: by 2002:a1c:1383:: with SMTP id 125mr9892521wmt.71.1547119992948;
        Thu, 10 Jan 2019 03:33:12 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f5ef])
        by smtp.gmail.com with ESMTPSA id v12sm23337899wmd.27.2019.01.10.03.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 03:33:12 -0800 (PST)
References: <20190101194414.24766-1-martin.blumenstingl@googlemail.com> <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux@roeck-us.net,
        bgolaszewski@baylibre.com, ulf.hansson@linaro.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mmc: core: don't override the CD GPIO level when "cd-inverted" is set
In-reply-to: <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
Date:   Thu, 10 Jan 2019 12:33:09 +0100
Message-ID: <8636q0u4qy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue 01 Jan 2019 at 19:44, Martin Blumenstingl wrote:

> Since commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> tree") gpiolib-of parses the "cd-gpios" property and flips the polarity
> if "cd-inverted" is also set. This results in the "cd-inverted" property
> being evaluated twice, which effectively makes it a no-op:
> - first in drivers/gpio/gpiolib-of.c (of_xlate_and_get_gpiod_flags) when
>   setting up the CD GPIO
> - then again in drivers/mmc/core/slot-gpio.c (mmc_gpio_get_cd) when
>   reading the CD GPIO value at runtime
>
> On boards which are using device-tree with the "cd-inverted" property
> being set any inserted card are not detected anymore. This is due to the
> MMC core treating the CD GPIO with the wrong polarity.
>
> Disable "override_cd_active_level" for the card detection GPIO which is
> parsed using mmc_of_parse. This fixes SD card detection on the boards
> which are currently using the "cd-inverted" device-tree property (tested
> on Meson8b Odroid-C1 and Meson8b EC-100).
>
> This does not remove the CD GPIO inversion logic from the MMC core
> because there's at least one driver (sdhci-pci-core for Intel BayTrail
> based boards) which still passes "override_cd_active_level = true" to
> mmc_gpiod_request_cd(). Due to lack of hardware for testing this is left
> untouched.
> In the future the GPIO inversion logic for both, card and read-only
> detection can be removed once no driver is using it anymore.
>
> Fixes: 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/mmc/core/host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index f57f5de54206..cf58ccaf22d5 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -234,7 +234,7 @@ int mmc_of_parse(struct mmc_host *host)
>  		if (device_property_read_bool(dev, "broken-cd"))
>  			host->caps |= MMC_CAP_NEEDS_POLL;
>  
> -		ret = mmc_gpiod_request_cd(host, "cd", 0, true,
> +		ret = mmc_gpiod_request_cd(host, "cd", 0, false,
>  					   cd_debounce_delay_ms * 1000,
>  					   &cd_gpio_invert);
>  		if (!ret)

Test on libretech-cc, sd is fixed with that patch.

Tested-by: Loys Ollivier <loys.ollivier@gmail.com>
-- 
-L
