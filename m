Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3AFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE6F20893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D+WwJIeE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D+WwJIeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE6F20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeH1Me1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:34:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1Me1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:34:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 67D10604BE; Tue, 28 Aug 2018 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535445830;
        bh=VGfYb3FvuRPruvjz2FMTMkWu4HQjcmcp2lBxwHhBz4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D+WwJIeEb/KEzRcsHroq6SEifa8CmIkg6UUDSJetfzspodbpiUfpMusOFOL+Em+pT
         J1NRymog06wDYwo6wazUl6qxQWqlcJfhTOxKRWru/P08DlNrA1BYVEDtOS7c0Ok/5V
         JQlu1B4UOrtGdXpE1dBvGsgDubqYlXPJ24yHx9p0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0703460241;
        Tue, 28 Aug 2018 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535445830;
        bh=VGfYb3FvuRPruvjz2FMTMkWu4HQjcmcp2lBxwHhBz4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D+WwJIeEb/KEzRcsHroq6SEifa8CmIkg6UUDSJetfzspodbpiUfpMusOFOL+Em+pT
         J1NRymog06wDYwo6wazUl6qxQWqlcJfhTOxKRWru/P08DlNrA1BYVEDtOS7c0Ok/5V
         JQlu1B4UOrtGdXpE1dBvGsgDubqYlXPJ24yHx9p0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Aug 2018 14:13:49 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: adsp: Add SDM845 ADSP and CDSP support
In-Reply-To: <20180828071458.26858-1-bjorn.andersson@linaro.org>
References: <20180828071458.26858-1-bjorn.andersson@linaro.org>
Message-ID: <bc66f41f8e96e92af424af473cd746d5@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Sibi Sankar <sibis@codeaurora.org>

On 2018-08-28 12:44, Bjorn Andersson wrote:
> Add support for booting the Audio and Compute DSPs found in Qualcomm's
> SDM845 platform.
> 
> As with the previous platforms the power rail handling needs to be
> updated once the appropriate support lands upstream.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,adsp.txt     |  2 ++
>  drivers/remoteproc/qcom_q6v5_pas.c                   | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> index 728e4193f7a6..b7d058228185 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> @@ -10,6 +10,8 @@ on the Qualcomm ADSP Hexagon core.
>  		    "qcom,msm8974-adsp-pil"
>  		    "qcom,msm8996-adsp-pil"
>  		    "qcom,msm8996-slpi-pil"
> +		    "qcom,sdm845-adsp-pas"
> +		    "qcom,sdm845-cdsp-pas"
> 
>  - interrupts-extended:
>  	Usage: required
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c
> b/drivers/remoteproc/qcom_q6v5_pas.c
> index 2478ef3cd519..53eff2afda06 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -342,6 +342,16 @@ static const struct adsp_data adsp_resource_init = 
> {
>  		.ssctl_id = 0x14,
>  };
> 
> +static const struct adsp_data cdsp_resource_init = {
> +	.crash_reason_smem = 601,
> +	.firmware_name = "cdsp.mdt",
> +	.pas_id = 18,
> +	.has_aggre2_clk = false,
> +	.ssr_name = "cdsp",
> +	.sysmon_name = "cdsp",
> +	.ssctl_id = 0x17,
> +};
> +
>  static const struct adsp_data slpi_resource_init = {
>  		.crash_reason_smem = 424,
>  		.firmware_name = "slpi.mdt",
> @@ -355,6 +365,8 @@ static const struct adsp_data slpi_resource_init = 
> {
>  static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,msm8974-adsp-pil", .data = 
> &adsp_resource_init},
>  	{ .compatible = "qcom,msm8996-adsp-pil", .data = 
> &adsp_resource_init},
>  	{ .compatible = "qcom,msm8996-slpi-pil", .data = 
> &slpi_resource_init},
> +	{ .compatible = "qcom,sdm845-adsp-pas", .data = &adsp_resource_init},
> +	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &cdsp_resource_init},
>  	{ },
>  };

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
