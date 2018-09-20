Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36BBECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806EF21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VamQboH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806EF21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbeITWC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeITWC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:02:27 -0400
Received: from localhost (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEF62087A;
        Thu, 20 Sep 2018 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537460293;
        bh=R1a2FX2dV7JqpxHeZOB+vVTGda5hK8U//UyRGlFHeLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VamQboH++I6YwozpPIHjM/1eu6Xp26JHtZ7wXYAI1WMfCLT3UFKv5L9+6OHUKJKQn
         emFybLzSaoNagrKvSXSp1VWH6v1//HU+RlgMVAB5p6ERCimiNQYQPy4jl8tIL5Aq+S
         X3QJ1yoUqtpL6XDDVWST/vRhr38iQcfyzWAQSocs=
Date:   Thu, 20 Sep 2018 09:18:13 -0700
From:   Vinod <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: smd-rpm: Add QCS404 compatible
Message-ID: <20180920161813.GE2350@vkoul-mobl>
References: <20180920014540.14894-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920014540.14894-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-18, 18:45, Bjorn Andersson wrote:
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt | 1 +
>  drivers/soc/qcom/smd-rpm.c                                  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
> index 89e1cb9212f6..ec95705ba692 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
> @@ -23,6 +23,7 @@ resources.
>  		    "qcom,rpm-msm8916"
>  		    "qcom,rpm-msm8974"
>  		    "qcom,rpm-msm8998"
> +		    "qcom,rpm-qcs404"
>  
>  - qcom,smd-channels:
>  	Usage: required
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> index 93517ed83355..b8e63724a49d 100644
> --- a/drivers/soc/qcom/smd-rpm.c
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -227,6 +227,7 @@ static const struct of_device_id qcom_smd_rpm_of_match[] = {
>  	{ .compatible = "qcom,rpm-msm8974" },
>  	{ .compatible = "qcom,rpm-msm8996" },
>  	{ .compatible = "qcom,rpm-msm8998" },
> +	{ .compatible = "qcom,rpm-qcs404" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
> -- 
> 2.18.0

-- 
~Vinod
