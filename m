Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09023C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79F6208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgIHDYC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79F6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeJRNYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbeJRNYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:24:00 -0400
Received: from localhost (unknown [106.200.232.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1FC5208E4;
        Thu, 18 Oct 2018 05:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539840286;
        bh=yByO2BzNkGulTncpq/Okvh4w77Cr0gaiPS5eFLpmK1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgIHDYC+tGzbe0n0aPUdnVPogXGSYnlo041iHxLmxWGkv0+XMI3QgNHIictRAnFCi
         4yyTvAkCog1avvd6HchjGlUZvtw6fE3J5nP6q6Fz3n/wxfylB8VWeBKHeg5EnAwePN
         1TlxV8rQ2pb1slvM3/8RnLYuQ8lhMjtj95N98Nfc=
Date:   Thu, 18 Oct 2018 10:54:37 +0530
From:   Vinod <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: pm8941-pwrkey - Add pms405 pwrkey support
Message-ID: <20181018052437.GW2400@vkoul-mobl>
References: <20180920014928.15422-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920014928.15422-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-18, 18:49, Bjorn Andersson wrote:
> From: Vinod Koul <vkoul@kernel.org>
> 
> Update the binding and driver for pms405 pwrkey.

Rob, Dmitry

Gentle reminder for this patch...

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt | 1 +
>  drivers/input/misc/pm8941-pwrkey.c                             | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> index 34ab5763f494..736fba3bad54 100644
> --- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> @@ -8,6 +8,7 @@ PROPERTIES
>  	Definition: must be one of:
>  		    "qcom,pm8941-pwrkey"
>  		    "qcom,pm8941-resin"
> +		    "qcom,pms405-pwrkey"
>  
>  - reg:
>  	Usage: required
> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> index 48153e0ca19a..fccf63263c1c 100644
> --- a/drivers/input/misc/pm8941-pwrkey.c
> +++ b/drivers/input/misc/pm8941-pwrkey.c
> @@ -317,6 +317,7 @@ static const struct pm8941_data resin_data = {
>  static const struct of_device_id pm8941_pwr_key_id_table[] = {
>  	{ .compatible = "qcom,pm8941-pwrkey", .data = &pwrkey_data },
>  	{ .compatible = "qcom,pm8941-resin", .data = &resin_data },
> +	{ .compatible = "qcom,pms405-pwrkey", .data = &pwrkey_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pm8941_pwr_key_id_table);
> -- 
> 2.18.0

-- 
~Vinod
