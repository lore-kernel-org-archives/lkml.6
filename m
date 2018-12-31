Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337BAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6F421019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LdjwhjP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeLaWoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 17:44:21 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44119 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLaWoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 17:44:20 -0500
Received: by mail-yb1-f193.google.com with SMTP id e1so6431696ybn.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 14:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rITVePHL/56oXRysj09iMlQmQaOFNRUc27HDPslO6Mk=;
        b=LdjwhjP7HN7GjFWjNsSOHzoR1rELyx0FRVFdJ5tr2MuEW7lUxehLghMuQoYrSoz4sd
         qBpq5DAR+Zpp00wmIXR4ixFBP7zWvq/ts9CxTxOXQ12nAUHsjNcfe0iu2kbZouN3ruEO
         aa67gdkqt3i3i4TNRqr1qamRCvLTv7rJqS2fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rITVePHL/56oXRysj09iMlQmQaOFNRUc27HDPslO6Mk=;
        b=SgOFzGh3cY+UPTULjmsVJfl/+aR8qQ9uQdm4un4wDOgHRQKmRNo+icCjli57RHY0FF
         r1jehQTzgeIzhIXVKoT9J7lmz/t+JDen//H2EKgs3dWsPo/5ghqLlrNSx6exzkQ0dD5J
         0ZVkDY5OsmXSgbSoZBK/sNah4OliZZ8pNf15TK5VwSk6tzCqLIN9MxuV+jO+ovcHTgVo
         OtTbUGIoniVvkXxoFyQoc4iqi78hoxi9LZusZ6eFWi0TmAxgtw4DftClbhiUZVzeGi9S
         nfmnokiicVKEI+j3a+TXuCfK9Pb/WKKCKZbhkubKRzUetFasOkSnP7i8+4rvWm+4OEYu
         SVRA==
X-Gm-Message-State: AJcUukfUI3eXIUw40+8rv4gpM9WwCPxEHyn/7BpeWdY4xDLw+ZgnHO+s
        KdB8JGBOwf7ytordwfzEDx8Un1ac/yGPfQ==
X-Google-Smtp-Source: ALg8bN7AmjgGQJsYRk6J5Kdi9tfq94zadtR0FdZRaHy2O/qXz39LzTTSK/rjV1Efbv8HXE8Cs7qnLQ==
X-Received: by 2002:a5b:352:: with SMTP id q18mr12140522ybp.371.1546296259235;
        Mon, 31 Dec 2018 14:44:19 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l140sm17940235ywe.77.2018.12.31.14.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 14:44:18 -0800 (PST)
Subject: Re: [PATCH] nvmem: bcm-ocotp: Add ACPI support to BCM OCOTP
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <1545881941-19986-1-git-send-email-srinath.mannam@broadcom.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <483c6309-e3bd-005c-c4c4-6ec04b2c4c02@broadcom.com>
Date:   Mon, 31 Dec 2018 14:44:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545881941-19986-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018-12-26 7:39 p.m., Srinath Mannam wrote:
> Add ACPI support to bcm ocotp driver
>
> This patch is based on Linux-4.20-rc7.
>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/nvmem/bcm-ocotp.c | 37 ++++++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
> index 4159b3f..a809751 100644
> --- a/drivers/nvmem/bcm-ocotp.c
> +++ b/drivers/nvmem/bcm-ocotp.c
> @@ -11,13 +11,14 @@
>    * GNU General Public License for more details.
>    */
>   
> +#include <linux/acpi.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/io.h>
>   #include <linux/module.h>
>   #include <linux/nvmem-provider.h>
>   #include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   
>   /*
> @@ -78,9 +79,9 @@ static struct otpc_map otp_map_v2 = {
>   };
>   
>   struct otpc_priv {
> -	struct device       *dev;
> -	void __iomem        *base;
> -	struct otpc_map     *map;
> +	struct device *dev;
> +	void __iomem *base;
> +	const struct otpc_map *map;
>   	struct nvmem_config *config;
>   };
>   
> @@ -237,16 +238,22 @@ static struct nvmem_config bcm_otpc_nvmem_config = {
>   };
>   
>   static const struct of_device_id bcm_otpc_dt_ids[] = {
> -	{ .compatible = "brcm,ocotp" },
> -	{ .compatible = "brcm,ocotp-v2" },
> +	{ .compatible = "brcm,ocotp", .data = &otp_map },
> +	{ .compatible = "brcm,ocotp-v2", .data = &otp_map_v2 },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, bcm_otpc_dt_ids);
>   
> +static const struct acpi_device_id bcm_otpc_acpi_ids[] = {
> +	{ .id = "BRCM0700", .driver_data = (kernel_ulong_t)&otp_map },
> +	{ .id = "BRCM0701", .driver_data = (kernel_ulong_t)&otp_map_v2 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, bcm_otpc_acpi_ids);
> +
>   static int bcm_otpc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct device_node *dn = dev->of_node;
>   	struct resource *res;
>   	struct otpc_priv *priv;
>   	struct nvmem_device *nvmem;
> @@ -257,14 +264,9 @@ static int bcm_otpc_probe(struct platform_device *pdev)
>   	if (!priv)
>   		return -ENOMEM;
>   
> -	if (of_device_is_compatible(dev->of_node, "brcm,ocotp"))
> -		priv->map = &otp_map;
> -	else if (of_device_is_compatible(dev->of_node, "brcm,ocotp-v2"))
> -		priv->map = &otp_map_v2;
> -	else {
> -		dev_err(dev, "%s otpc config map not defined\n", __func__);
> -		return -EINVAL;
> -	}
> +	priv->map = device_get_match_data(dev);
> +	if (!priv->map)
> +		return -ENODEV;
>   
>   	/* Get OTP base address register. */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -281,7 +283,7 @@ static int bcm_otpc_probe(struct platform_device *pdev)
>   	reset_start_bit(priv->base);
>   
>   	/* Read size of memory in words. */
> -	err = of_property_read_u32(dn, "brcm,ocotp-size", &num_words);
> +	err = device_property_read_u32(dev, "brcm,ocotp-size", &num_words);
>   	if (err) {
>   		dev_err(dev, "size parameter not specified\n");
>   		return -EINVAL;
> @@ -294,7 +296,7 @@ static int bcm_otpc_probe(struct platform_device *pdev)
>   	bcm_otpc_nvmem_config.dev = dev;
>   	bcm_otpc_nvmem_config.priv = priv;
>   
> -	if (of_device_is_compatible(dev->of_node, "brcm,ocotp-v2")) {
> +	if (priv->map == &otp_map_v2) {
>   		bcm_otpc_nvmem_config.word_size = 8;
>   		bcm_otpc_nvmem_config.stride = 8;
>   	}
> @@ -315,6 +317,7 @@ static struct platform_driver bcm_otpc_driver = {
>   	.driver = {
>   		.name	= "brcm-otpc",
>   		.of_match_table = bcm_otpc_dt_ids,
> +		.acpi_match_table = ACPI_PTR(bcm_otpc_acpi_ids),
>   	},
>   };
>   module_platform_driver(bcm_otpc_driver);
