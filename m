Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA77C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046502064D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fwO8SKyC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LQQ2/p8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046502064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeGCRIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:08:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38702 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934265AbeGCRIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:08:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CF43D60B19; Tue,  3 Jul 2018 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530637695;
        bh=b3vkaI8wRThjfzMgfdxep1qnl8oPVIFCx7UW8y1PD0E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fwO8SKyCQEEaBtd6P8GIGC0xcY8qA98XtinHKb7/yB9bZq3LpDfekozFtNenGDwev
         yd1zrb2weDtA38v+ZRmEy2KCmTW8hLY8JG5qsaRJW3FOSxyC4EBRn8/cQGRCxdFhHX
         QZA0J+QgHjdY2ZsOZDigaymVaiDLULQDCTj6HOz0=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AE4560290;
        Tue,  3 Jul 2018 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530637694;
        bh=b3vkaI8wRThjfzMgfdxep1qnl8oPVIFCx7UW8y1PD0E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LQQ2/p8b0cX3wRtSSWdD/WJjbfg+d5xi37j/ZVnvckp5vtSzWegPfTi9qt6o8FKSf
         oicYzxrVKJ5L7cCpq6kVSiiMgurHGq6EGLxNbcaRIJ8+wH7Cdzdgm+c3gH6XaH8k4F
         4kiupxKL2WasP+rOeW2tXm5d40ExjsS/t2oAzYss=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AE4560290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 6/6] crypto: qcom: Add ACPI support
To:     Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
References: <20180703060434.19293-1-vkoul@kernel.org>
 <20180703060434.19293-7-vkoul@kernel.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <28000d33-5321-76af-7985-94a564a75336@codeaurora.org>
Date:   Tue, 3 Jul 2018 11:08:10 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703060434.19293-7-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2018 12:04 AM, Vinod Koul wrote:
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
> ---
>   drivers/crypto/qcom-rng.c | 37 +++++++++++++++++++++++++++++++++----
>   1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
> index fdbbcac7bcb8..bc0131d130d6 100644
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
> @@ -154,6 +155,7 @@ static int qcom_rng_probe(struct platform_device *pdev)
>   {
>   	struct resource *res;
>   	struct qcom_rng *rng;
> +	u32 val;
>   	int ret;
>   
>   	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
> @@ -168,11 +170,27 @@ static int qcom_rng_probe(struct platform_device *pdev)
>   	if (IS_ERR(rng->base))
>   		return PTR_ERR(rng->base);
>   
> -	rng->clk = devm_clk_get(&pdev->dev, "core");
> -	if (IS_ERR(rng->clk))
> -		return PTR_ERR(rng->clk);
>   
> -	rng->skip_init = (unsigned long)of_device_get_match_data(&pdev->dev);
> +	/*
> +	 * ACPI systems have v2 hardware. The clocks are always enabled,
> +	 * the PRNG register space is read-only and the PRNG should
> +	 * already be enabled.
> +	 */
> +	if (has_acpi_companion(&pdev->dev)) {
> +		val = readl(rng->base + PRNG_CONFIG);
> +		if (!(val & PRNG_CONFIG_HW_ENABLE)) {
> +			dev_err(&pdev->dev, "device is not enabled\n");
> +			return -ENODEV;
> +		}
> +		rng->skip_init = 1;
> +	} else {
> +		rng->clk = devm_clk_get(&pdev->dev, "core");
> +		if (IS_ERR(rng->clk))
> +			return PTR_ERR(rng->clk);
> +
> +		rng->skip_init =
> +			(unsigned long)of_device_get_match_data(&pdev->dev);
> +	}
>   
>   	qcom_rng_dev = rng;
>   	ret = crypto_register_rng(&qcom_rng_alg);
> @@ -193,6 +211,16 @@ static int qcom_rng_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +#if IS_ENABLED(CONFIG_ACPI)
> +static const struct acpi_device_id qcom_rng_acpi_match[] = {
> +	{
> +		.id = "QCOM8160",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, msm_rng_acpi_match);

qcom_rng_acpi_match?
Looks like a copy/paste issue.  This causes a build failure for me.
I'm trying to see if it works otherwise...

> +#endif
> +
>   static const struct of_device_id qcom_rng_of_match[] = {
>   	{ .compatible = "qcom,prng", .data = (void *)0},
>   	{ .compatible = "qcom,prng-ee", .data = (void *)1},
> @@ -206,6 +234,7 @@ static struct platform_driver qcom_rng_driver = {
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
