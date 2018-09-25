Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2E6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136C720877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LjweQ3N+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AfkKY1uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136C720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeIYQZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:25:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36398 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIYQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:25:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 98D3E6020A; Tue, 25 Sep 2018 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537870727;
        bh=6cWhn3yoZG/6JP205FDz7qbu6mkGK1aIJEaah/Qc+VU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LjweQ3N+p3Leqveip1DENFpkGHRYRxLtBGoqMkYlVSkiMTyOpA9lvvdBXIZZUTroP
         wL5e7QU0uB3Ei42gMpMfO1fgtQHZm9z5Av0uIDH41en1fTSlz4s8UOUhl4mVqNEP2G
         +NFQvMgPVkPA60YkQ5smYozMXOrgSKDN4RHmfpTo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C19B26020A;
        Tue, 25 Sep 2018 10:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537870726;
        bh=6cWhn3yoZG/6JP205FDz7qbu6mkGK1aIJEaah/Qc+VU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AfkKY1uuNekwQPiuZuC4sD7sG/2oqVNfG9Klc0DeZYlCGR3N7s9wvlLfSoaxRx8ZM
         qKjCC0S9nJ1xLC7sa0Aq48IG+ElJJ81KWcV0e3GJ+ZQUguxHfFneDFKj2dEjkMiXWY
         jW8CvMQG3ra1Vg0hWuw6mDthvcq6bjigv0Ymhw+M=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Sep 2018 15:48:46 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: pas: Add QCS404 remoteprocs
In-Reply-To: <20180920172237.30965-1-bjorn.andersson@linaro.org>
References: <20180920172237.30965-1-bjorn.andersson@linaro.org>
Message-ID: <f0887494a9957496399046bac9b1fa32@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 2018-09-20 22:52, Bjorn Andersson wrote:
> From: Govind Singh <govinds@codeaurora.org>
> 
> Add compatibles for the three PAS based remote processors found in
> QCS404.
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> [bjorn: Added adsp and cdsp to the patch]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,adsp.txt     |  3 +++
>  drivers/remoteproc/qcom_adsp_pil.c                   | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> index b7d058228185..9c0cff3a5ed8 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> @@ -10,6 +10,9 @@ on the Qualcomm ADSP Hexagon core.
>  		    "qcom,msm8974-adsp-pil"
>  		    "qcom,msm8996-adsp-pil"
>  		    "qcom,msm8996-slpi-pil"
> +		    "qcom,qcs404-adsp-pas"
> +		    "qcom,qcs404-cdsp-pas"
> +		    "qcom,qcs404-wcss-pas"
>  		    "qcom,sdm845-adsp-pas"
>  		    "qcom,sdm845-cdsp-pas"
> 
> diff --git a/drivers/remoteproc/qcom_adsp_pil.c
> b/drivers/remoteproc/qcom_adsp_pil.c
> index da2254ea1135..fcbb816a9698 100644
> --- a/drivers/remoteproc/qcom_adsp_pil.c
> +++ b/drivers/remoteproc/qcom_adsp_pil.c
> @@ -362,10 +362,22 @@ static const struct adsp_data slpi_resource_init 
> = {
>  		.ssctl_id = 0x16,
>  };
> 
> +static const struct adsp_data wcss_resource_init = {
> +	.crash_reason_smem = 421,
> +	.firmware_name = "wcnss.mdt",
> +	.pas_id = 6,
> +	.ssr_name = "mpss",
> +	.sysmon_name = "wlan",

Shouldn't the sysmon name be "wcnss" instead of "wlan"?

> +	.ssctl_id = 0x12,
> +};
> +
>  static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,msm8974-adsp-pil", .data = 
> &adsp_resource_init},
>  	{ .compatible = "qcom,msm8996-adsp-pil", .data = 
> &adsp_resource_init},
>  	{ .compatible = "qcom,msm8996-slpi-pil", .data = 
> &slpi_resource_init},
> +	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init 
> },
> +	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init 
> },
> +	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init 
> },
>  	{ .compatible = "qcom,sdm845-adsp-pas", .data = &adsp_resource_init},
>  	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &cdsp_resource_init},
>  	{ },

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
