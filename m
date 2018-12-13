Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A85C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01632075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="chJ7mx4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01632075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeLMItJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:49:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40756 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeLMItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:49:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so1448579wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 00:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DcY9SmA95sGKKkT7HJZ9JAbsXGGotQHJqq36bsON21A=;
        b=chJ7mx4MTHpvWff+d8hTpKdhjYfXgSfIROHlqeJk216J/qCysPdO55EKnphsY+covE
         0AJYDJsh22xOkiKh+PjICB38RCajd4VrCWbY0Y2KBfTYiS4DA94sbZi6htcIFDrMV51L
         85kJQR9s/rVr2ako1TPfCCjLyyEMdPzkXZXVTSLB3MOfxN62q/lj7ISmOlgdCIg1NJhq
         4a3pnAa8Q2U66sk/vYX4THaNw0cpQXM6VJkr2ek8ZQ+Vviwm/+vx1bNMEQTSN35BV+c+
         ptekvBNxt8BYNQaKW+uPi0GViTjyRzNDJSU5xIPz5qrWqJXhNQOU0QD0Jh7SewnMGSzJ
         0UrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DcY9SmA95sGKKkT7HJZ9JAbsXGGotQHJqq36bsON21A=;
        b=oqrpO1gH9YSaCljCUcMbnwtRS2vEgjvPN5odPuPUyz+6ZxEflcZpJpLldho6HkgFWL
         +LE6x41cu29/OxD7yG8iOyxCLiO75ZrAHTdWIHHwk6KEFwm2sJKle0CMRE31m+qr4d0W
         mXym2y79dDWu2V//K5QBgLbYURCROyNQHVk9PJMesll6TBSPJ6f30AkgQBIpNorp0IWY
         5IK9gV2k7S5cKthyQ7J9d++blDWEpFUpU5B8fb1a5BrSJLSbW/3VpQwd01Zse0I1romu
         yZUSQRf1ECUO64FJTirG2eM/yuSMJ2IRDq61u2eg5fyxwFQomJJEY4QsdRa8+WujnDRM
         e2eQ==
X-Gm-Message-State: AA+aEWZHNTInRRvRsV18S4M0p+Qzc9PzJTYZ6lQd/4icmkTsiqyg6he/
        pSYdIHCCQKPmKVxSw6oxZeb5VWAtj7nSDg==
X-Google-Smtp-Source: AFSGD/XwdxSRFj8tvGNoticalHMLcPZSjNp8SJjUaVVUALYKvCwtuxzEgTIUngyYTNzho1ZOzeEFyw==
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr9218142wmd.111.1544690946251;
        Thu, 13 Dec 2018 00:49:06 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157? ([2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157])
        by smtp.gmail.com with ESMTPSA id j14sm1078001wrv.96.2018.12.13.00.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 00:49:05 -0800 (PST)
Subject: Re: [PATCH v2 1/3] spi: meson-axg: support MAX 80M clock
To:     Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-2-git-send-email-sunny.luo@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <2d438907-91b5-7443-24f9-57a406aaa040@baylibre.com>
Date:   Thu, 13 Dec 2018 09:49:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544690354-16409-2-git-send-email-sunny.luo@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunny,

On 13/12/2018 09:39, Sunny Luo wrote:
> The SPICC controller in Meson-AXG is capable of running at 80M clock.
> The ASIC IP is improved and the clock is actually running higher than
> previous old SoCs.
> 
> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/spi/spi-meson-spicc.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index 7fe4488..b56249d 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -9,11 +9,13 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
> @@ -34,7 +36,6 @@
>   *   to have a CS go down over the full transfer
>   */
>  
> -#define SPICC_MAX_FREQ	30000000
>  #define SPICC_MAX_BURST	128
>  
>  /* Register Map */
> @@ -120,6 +121,10 @@
>  #define SPICC_BURST_MAX	16
>  #define SPICC_FIFO_HALF 10
>  
> +struct meson_spicc_data {
> +	unsigned int			max_speed_hz;
> +};
> +
>  struct meson_spicc_device {
>  	struct spi_master		*master;
>  	struct platform_device		*pdev;
> @@ -127,6 +132,7 @@ struct meson_spicc_device {
>  	struct clk			*core;
>  	struct spi_message		*message;
>  	struct spi_transfer		*xfer;
> +	const struct meson_spicc_data	*data;
>  	u8				*tx_buf;
>  	u8				*rx_buf;
>  	unsigned int			bytes_per_word;
> @@ -517,6 +523,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  	spicc->pdev = pdev;
>  	platform_set_drvdata(pdev, spicc);
>  
> +	spicc->data = (const struct meson_spicc_data *)
> +		of_device_get_match_data(&pdev->dev);
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	spicc->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(spicc->base)) {
> @@ -567,11 +576,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  	master->unprepare_transfer_hardware = meson_spicc_unprepare_transfer;
>  	master->transfer_one = meson_spicc_transfer_one;
>  
> -	/* Setup max rate according to the Meson GX datasheet */
> -	if ((rate >> 2) > SPICC_MAX_FREQ)
> -		master->max_speed_hz = SPICC_MAX_FREQ;
> -	else
> -		master->max_speed_hz = rate >> 2;
> +	/* Setup max rate according to the Meson datasheet */
> +	master->max_speed_hz = min_t(unsigned int, rate >> 1,
> +				     spicc->data->max_speed_hz);

I think "rate >> 1" here depends on patch 3, either move patch 3 before this one
or keep "rate >> 2" and change it back to "rate >> 1" on patch 3.

>  
>  	ret = devm_spi_register_master(&pdev->dev, master);
>  	if (ret) {
> @@ -602,9 +609,23 @@ static int meson_spicc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct meson_spicc_data meson_spicc_gx_data = {
> +	.max_speed_hz	= 30000000,
> +};
> +
> +static const struct meson_spicc_data meson_spicc_axg_data = {
> +	.max_speed_hz	= 80000000,
> +};
> +
>  static const struct of_device_id meson_spicc_of_match[] = {
> -	{ .compatible = "amlogic,meson-gx-spicc", },
> -	{ .compatible = "amlogic,meson-axg-spicc", },
> +	{
> +		.compatible	= "amlogic,meson-gx-spicc",
> +		.data		= &meson_spicc_gx_data,
> +	},
> +	{
> +		.compatible = "amlogic,meson-axg-spicc",
> +		.data		= &meson_spicc_axg_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
> 

