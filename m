Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A4C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5EB20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ByvvIguU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ByvvIguU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfAVGyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:54:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVGyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:54:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B7DD160112; Tue, 22 Jan 2019 06:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548140050;
        bh=bRxgBIDXyaA/wO+ILENvcJSwu3d4IwPowzDLzkmM5RI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ByvvIguUqHP+TRNBl/0TKbt9JKAI/PjacgvWJ9cd9I7UKGbkGIGRbzT/H8LEP5XF5
         wiJ5oUCoQzd42Yl8tmjWZZ+6O6HuFSbMEPQo13TMDgHoM8OpkHGE+HgSb5CW+JSp95
         sdIRjXb8vttvGhDYIFvwB0B2BY1SAejJs+a8kEV0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 399CF60312;
        Tue, 22 Jan 2019 06:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548140050;
        bh=bRxgBIDXyaA/wO+ILENvcJSwu3d4IwPowzDLzkmM5RI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ByvvIguUqHP+TRNBl/0TKbt9JKAI/PjacgvWJ9cd9I7UKGbkGIGRbzT/H8LEP5XF5
         wiJ5oUCoQzd42Yl8tmjWZZ+6O6HuFSbMEPQo13TMDgHoM8OpkHGE+HgSb5CW+JSp95
         sdIRjXb8vttvGhDYIFvwB0B2BY1SAejJs+a8kEV0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Jan 2019 12:24:10 +0530
From:   alokc@codeaurora.org
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Alok Chauhan <alokc@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
In-Reply-To: <1548069703-26595-4-git-send-email-alokc@codeaurora.org>
References: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
 <1548069703-26595-4-git-send-email-alokc@codeaurora.org>
Message-ID: <b0df5f24c58766ac10ed1524abfa5f11@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't review this patch. I've resend patches after adding all the 
mailing list.
Sorry for inconvenience. Please review patches with spi/i2c/uart/kernel 
mailing list added.

On 2019-01-21 16:51, Alok Chauhan wrote:
> Get the interconnect paths for I2C based Serial Engine device
> and vote accordingly based on maximum supported I2C frequency.
> 
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c
> b/drivers/i2c/busses/i2c-qcom-geni.c
> index db075bc..e8fe63a 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -14,6 +14,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/qcom-geni-se.h>
>  #include <linux/spinlock.h>
> +#include <linux/interconnect.h>
> 
>  #define SE_I2C_TX_TRANS_LEN		0x26c
>  #define SE_I2C_RX_TRANS_LEN		0x270
> @@ -508,6 +509,15 @@ static int geni_i2c_probe(struct platform_device 
> *pdev)
>  		return ret;
>  	}
> 
> +	/* Set the bus quota to a reasonable value */
> +	gi2c->se.avg_bw = Bps_to_icc(1000);
> +	gi2c->se.peak_bw = Bps_to_icc(76800000);
> +	ret = geni_interconnect_init(&gi2c->se);
> +	if (ret) {
> +		dev_err(&pdev->dev, "interconnect_init failed %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
>  							&gi2c->clk_freq_out);
>  	if (ret) {
> @@ -611,6 +621,8 @@ static int __maybe_unused
> geni_i2c_runtime_suspend(struct device *dev)
>  		gi2c->suspended = 1;
>  	}
> 
> +	geni_icc_update_bw(&gi2c->se, false);
> +
>  	return 0;
>  }
> 
> @@ -619,6 +631,7 @@ static int __maybe_unused
> geni_i2c_runtime_resume(struct device *dev)
>  	int ret;
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
> 
> +	geni_icc_update_bw(&gi2c->se, true);
>  	ret = geni_se_resources_on(&gi2c->se);
>  	if (ret)
>  		return ret;

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
