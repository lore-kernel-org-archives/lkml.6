Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9751FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D8A20870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pGMn10+h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CRdIOZOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D8A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389226AbeGJSp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:45:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732443AbeGJSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:45:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5360B60B26; Tue, 10 Jul 2018 17:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531243628;
        bh=M5IFkUPlOhbJ7uNEKajrwoZY2izVPWF9L2p6i0my0a4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pGMn10+hVxQYJy6I4z0lkn4ulU5JEQb6tzxgXb1rwLydxoU6KpS0JXEGXgg2oPZSr
         7cDvUFjCGx0MWEvP0oSuYNvtg0c4jjnHADCYzCqS/op4shtEcrL5kYriZ81mEKyZBH
         5bu14YI2X3rrLfB073R1wIjxqRlBLuJMVL0In0qg=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A93BB607EB;
        Tue, 10 Jul 2018 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531243627;
        bh=M5IFkUPlOhbJ7uNEKajrwoZY2izVPWF9L2p6i0my0a4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CRdIOZOjXvBIojugC2jknEdEI+MS0IANBf+aOQWjuW5PnegTsE3bAkldMzklaHJi7
         u/SB49sOYQmExsgzZs/XlCspmIcGzgtL2qQ16FJxbZDeT6svpt1ax34B3g6H3Nf0L6
         +ekiuXEUJYpCWyZymLeB7345znS1HOQ5N5ZeonXU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A93BB607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v5 6/6] crypto: qcom: Add ACPI support
To:     Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
References: <20180709061925.20276-1-vkoul@kernel.org>
 <20180709061925.20276-7-vkoul@kernel.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <2a678412-26d4-769e-ff6f-ace5d53e70b5@codeaurora.org>
Date:   Tue, 10 Jul 2018 11:27:05 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709061925.20276-7-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/2018 12:19 AM, Vinod Koul wrote:
> From: Timur Tabi <timur@codeaurora.org>
> 
> Add support for probing on ACPI systems, with ACPI HID QCOM8160.
> 
> On ACPI systems, clocks are always enabled, the PRNG should
> already be enabled, and the register region is read-only.
> The driver only verifies that the hardware is already
> enabled never tries to disable or configure it.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> [port to crypto API]
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

> ---
>   drivers/crypto/qcom-rng.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
> index f1bd86acaf9d..8118d4cd93b2 100644
> --- a/drivers/crypto/qcom-rng.c
> +++ b/drivers/crypto/qcom-rng.c
> @@ -4,6 +4,7 @@
>   // Based on msm-rng.c and downstream driver
>   
>   #include <crypto/internal/rng.h>
> +#include <linux/acpi.h>
>   #include <linux/clk.h>
>   #include <linux/crypto.h>
>   #include <linux/module.h>
> @@ -168,13 +169,17 @@ static int qcom_rng_probe(struct platform_device *pdev)
>   	if (IS_ERR(rng->base))
>   		return PTR_ERR(rng->base);
>   
> -	rng->clk = devm_clk_get(&pdev->dev, "core");
> -	if (IS_ERR(rng->clk))
> -		return PTR_ERR(rng->clk);
>   
> -	rng->skip_init = (unsigned long)of_device_get_match_data(&pdev->dev);
> +	/* ACPI systems have clk already on, so skip clk_get */
> +	if (!has_acpi_companion(&pdev->dev)) {
> +		rng->clk = devm_clk_get(&pdev->dev, "core");
> +		if (IS_ERR(rng->clk))
> +			return PTR_ERR(rng->clk);
> +	}
>   
> +	rng->skip_init = (unsigned long)device_get_match_data(&pdev->dev);
>   	qcom_rng_dev = rng;
> +
>   	ret = crypto_register_rng(&qcom_rng_alg);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Register crypto rng failed: %d\n", ret);
> @@ -193,6 +198,14 @@ static int qcom_rng_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +#if IS_ENABLED(CONFIG_ACPI)
> +static const struct acpi_device_id qcom_rng_acpi_match[] = {
> +	{ .id = "QCOM8160", .driver_data = 1 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
> +#endif
> +
>   static const struct of_device_id qcom_rng_of_match[] = {
>   	{ .compatible = "qcom,prng", .data = (void *)0},
>   	{ .compatible = "qcom,prng-ee", .data = (void *)1},
> @@ -206,6 +219,7 @@ static struct platform_driver qcom_rng_driver = {
>   	.driver = {
>   		.name = KBUILD_MODNAME,
>   		.of_match_table = of_match_ptr(qcom_rng_of_match),
> +		.acpi_match_table = ACPI_PTR(qcom_rng_acpi_match),
>   	}
>   };
>   module_platform_driver(qcom_rng_driver);
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
