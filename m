Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F03ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB062086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJECgQ5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB062086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeKHSEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:04:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43491 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeKHSEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:04:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id e4so6557312edv.10;
        Thu, 08 Nov 2018 00:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zLgUVMCcNyo7X8xHqHiFzgl3eXfewDLAKeiYFBWReCA=;
        b=gJECgQ5WuZcDJwn2pQa/oxx5KCFB1DMzk4YLFTUaMSMQJDX/Zh59Ebm1NRMyhX2kfb
         oxzgDTWWrrKa6C8l1TcfSHYkWPAKKhkTAL+xxMRCXwMAVJuFBPsHlPhAxLn4pQtL4lXu
         lP9H9ojnqBsqauui1t5is2OqESCLCuxINQcYcQ1M7stYwzNvExKk3DIK6hvjLUzbOLjK
         a3Z/HEpmH+3OP6XH4bm9qX5ZnG/MOXX1I8qCilhslP73wwJeEYLwf+dW0mw+vBCWpm4s
         ZymW6aQsluMw+ZyjiE36bASwBKE2R8FT4c3R7b9FvCS8fzZB/U+Onp0W5BIrldx+CbYn
         y9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zLgUVMCcNyo7X8xHqHiFzgl3eXfewDLAKeiYFBWReCA=;
        b=DvHyd+9k0TCraushe08RvpUHfkcdzVsx9g+wFqLDgeWjWF1e0ubr4eJyaf7RkIUt2g
         ZNs/hK7hNv8LvCQ6sJb8UOPlk4ubcdolu45v5Qu2hLXA7IMNhu3wTcUF/KPXItrz5cgR
         Ue/Mqx386AJa/uWAlxIoHHMDsaRKR6COTphTNGooHNx5SJ5Y91a0UcWVVxNVix0mCc9P
         3yHWDvD3BAi34S04LdUWoxC3Uc5PHANN/2BgJUj0Sa0WjEiZ0jH8K62uWpxsCbDyQcQy
         B84nFGf/0IDZu9B7n5XShViKz52kWbG/7M3IaqNo1KS5ZA8hEXJBRbkvw4Voys0WCHFH
         +nQQ==
X-Gm-Message-State: AGRZ1gKNah7+zpQ+i2FUXy5GkmBRsDxhmHNyv3zlTyWHNnCMjfyr0RCv
        jZuTxqm4M+08hVSsdxh8yzg=
X-Google-Smtp-Source: AJdET5fSbHKEAvOw9uFVWG5QbmBmbKvf9Kjt7rq2/ok+z2zEt1dKo7uVatWmBC+S6qmXynXwRgVuPw==
X-Received: by 2002:a17:906:a984:: with SMTP id jr4-v6mr2341346ejb.90.1541665788103;
        Thu, 08 Nov 2018 00:29:48 -0800 (PST)
Received: from ziggy.stardust ([37.223.147.230])
        by smtp.gmail.com with ESMTPSA id y17-v6sm484049ejj.43.2018.11.08.00.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 00:29:47 -0800 (PST)
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <efa13e0b-0daf-3bf3-27ba-ed90f15c7dfe@gmail.com>
Date:   Thu, 8 Nov 2018 09:29:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181106183609.207702-2-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2018 19:36, Stephen Boyd wrote:
> We have a handful of clk drivers that have a collection of slightly
> variant device support keyed off of the compatible string. In each of
> these drivers, we demux the variant and then call the "real" probe
> function based on whatever is stored in the match data for that
> compatible string. Let's generalize this function so that it can be
> re-used as the platform_driver probe function directly.
> 
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/of/device.c       | 31 +++++++++++++++++++++++++++++++
>  include/linux/of_device.h |  1 +
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 0f27fad9fe94..8381f33ed2d8 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -195,6 +195,37 @@ const void *of_device_get_match_data(const struct device *dev)
>  }
>  EXPORT_SYMBOL(of_device_get_match_data);
>  
> +/**
> + * platform_driver_probe_by_of_match_data - Probe a platform device using match data
> + * @pdev: platform device to probe
> + *
> + * For use by device drivers that multiplex their probe function through DT
> + * match data. Drivers can use this function to call their platform
> + * device probe directly without having to implement a wrapper function.
> + *
> + * static const struct of_device_id probe_funcs[] = {
> + *      { .compatible = "compat,foo", .data = foo_probe },
> + *      {}
> + * };
> + *
> + * struct platform_driver foo_driver = {
> + *      .probe = platform_driver_probe_by_of_match_data,
> + *      .driver = {
> + *            of_match_table = probe_funcs,
> + *      },
> + * };
> + *
> + */
> +int platform_driver_probe_by_of_match_data(struct platform_device *pdev)
> +{
> +	int (*probe_func)(struct platform_device *pdev);
> +
> +	probe_func = of_device_get_match_data(&pdev->dev);

Shouldn't we check if probe_func is not NULL?

> +
> +	return probe_func(pdev);
> +}
> +EXPORT_SYMBOL_GPL(platform_driver_probe_by_of_match_data);
> +
>  static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
>  {
>  	const char *compat;
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 8d31e39dd564..4de84691d1c6 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -33,6 +33,7 @@ extern int of_device_add(struct platform_device *pdev);
>  extern int of_device_register(struct platform_device *ofdev);
>  extern void of_device_unregister(struct platform_device *ofdev);
>  
> +extern int platform_driver_probe_by_of_match_data(struct platform_device *pdev);
>  extern const void *of_device_get_match_data(const struct device *dev);
>  
>  extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
> 
