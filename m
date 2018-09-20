Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19385ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ABC21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFOZtt8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5ABC21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeITWBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:01:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeITWBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:01:17 -0400
Received: from localhost (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9FB2087A;
        Thu, 20 Sep 2018 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537460223;
        bh=dbUwlsAVew/6JDWL9rMQ0ulhdYrtRrC8s2dIMJhogNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFOZtt8f+51EAu/oM+gLx1BN49MW3BMIiNMpR3xUETQTRJ4mRAnt1ESw3JViPCXZh
         XwqgrGYtCVTX99cIHt9BLNb+VIngW+4ZxyR8Yx52xDwC9ddbZ3m6G99S3keUviDsKM
         TW7WJpM7JcMEGY1ZarPVS3VRlz/kQFL/ApzxaU9A=
Date:   Thu, 20 Sep 2018 09:17:03 -0700
From:   Vinod <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] mailbox: qcom: Add QCS404 APPS Global compatible
Message-ID: <20180920161703.GC2350@vkoul-mobl>
References: <20180920014408.14645-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920014408.14645-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-18, 18:44, Bjorn Andersson wrote:
> Add support for the QCS404 APPS Global block with IPC register at offset
> 8.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt        | 1 +
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c                          | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> index 6e8a9ab0fdae..1232fc9fc709 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> @@ -11,6 +11,7 @@ platforms.
>  		    "qcom,msm8916-apcs-kpss-global",
>  		    "qcom,msm8996-apcs-hmss-global"
>  		    "qcom,msm8998-apcs-hmss-global"
> +		    "qcom,qcs404-apcs-apps-global"
>  		    "qcom,sdm845-apss-shared"
>  
>  - reg:
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 333ed4a9d4b8..aed23ac9550d 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -126,6 +126,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = (void *)8 },
>  	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = (void *)16 },
>  	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = (void *)8 },
> +	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = (void *)8 },
>  	{ .compatible = "qcom,sdm845-apss-shared", .data = (void *)12 },
>  	{}
>  };
> -- 
> 2.18.0

-- 
~Vinod
