Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D4EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996582073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hiDU6GSH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TJPnbHED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996582073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeH3Q3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:29:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37128 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeH3Q3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:29:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1C43560600; Thu, 30 Aug 2018 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535632078;
        bh=06fvCOjyPJiruOmVA7WLAV/lFYfgk0E2qz1+MuGj1yQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hiDU6GSHFxLVgMgfvFxKD9IzYM7MizMBVuZp8TadUixykcghsP+AsFEaWYMGRjh3N
         O60gBrkzc94jriGj9WBTx2HIuOTrUhniZNkxLN3jPyM7K8MDKMisWIEEBirBRwzhKT
         5XzH7mGXAet2Gl2NrO0Cz5/KxTAvmcYL+HvFN5ps=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9DE960540;
        Thu, 30 Aug 2018 12:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535632077;
        bh=06fvCOjyPJiruOmVA7WLAV/lFYfgk0E2qz1+MuGj1yQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TJPnbHEDb4ji9CVRqXJ5Ojh8PRl2YnX6Z5VDahAvJbMkzwGc2GkWhcSd8+UD4hI8n
         XHl/BuEmbF6k078IuqaXjFgy1H4YNN6ZlBD8kAUkKML2ASZsAzQNNb+pJwXiy8Alvw
         64s38zjNNgOMAnskU8XnOk3qBNJowb9inxl0u+T8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9DE960540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Rename Hexagon v5 PAS driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20180828051203.22394-1-bjorn.andersson@linaro.org>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <bdfb0ab2-b5f5-086e-3f97-9c2a8758f2e1@codeaurora.org>
Date:   Thu, 30 Aug 2018 17:57:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828051203.22394-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for posting the patch.


On 8/28/2018 10:42 AM, Bjorn Andersson wrote:
> The Hexagon v5 ADSP driver is used for more than only the ADSP and
> there's an upcoming non-PAS ADSP PIL for SDM845, so rename the driver to
> qcom_q6v5_pas in order to better suite this.
>
> Cc: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/remoteproc/Kconfig                    | 22 +++++++++----------
>   drivers/remoteproc/Makefile                   |  2 +-
>   .../{qcom_adsp_pil.c => qcom_q6v5_pas.c}      |  4 ++--
>   3 files changed, 14 insertions(+), 14 deletions(-)
>   rename drivers/remoteproc/{qcom_adsp_pil.c => qcom_q6v5_pas.c} (98%)
>
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 052d4dd347f9..c98c0b2a2237 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -84,8 +84,16 @@ config KEYSTONE_REMOTEPROC
>   	  It's safe to say N here if you're not interested in the Keystone
>   	  DSPs or just want to use a bare minimum kernel.
>   
> -config QCOM_ADSP_PIL
> -	tristate "Qualcomm ADSP Peripheral Image Loader"
> +config QCOM_RPROC_COMMON
> +	tristate
> +
> +config QCOM_Q6V5_COMMON
> +	tristate
> +	depends on ARCH_QCOM
> +	depends on QCOM_SMEM
> +
> +config QCOM_Q6V5_PAS
> +	tristate "Qualcomm Hexagon v5 Peripheral Authentication Service support"
>   	depends on OF && ARCH_QCOM
>   	depends on QCOM_SMEM
>   	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
> @@ -98,15 +106,7 @@ config QCOM_ADSP_PIL
>   	select QCOM_SCM
>   	help
>   	  Say y here to support the TrustZone based Peripherial Image Loader
> -	  for the Qualcomm ADSP remote processors.
> -
> -config QCOM_RPROC_COMMON
> -	tristate
> -
> -config QCOM_Q6V5_COMMON
> -	tristate
> -	depends on ARCH_QCOM
> -	depends on QCOM_SMEM
> +	  for the Qualcomm Hexagon v5 based remote processors.
>   
>   config QCOM_Q6V5_PIL
>   	tristate "Qualcomm Hexagon V5 Peripherial Image Loader"
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 03332fa7e2ee..eb86c8ba5a87 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -14,9 +14,9 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>   obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>   obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
>   obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
> -obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
>   obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
>   obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
> +obj-$(CONFIG_QCOM_Q6V5_PAS)		+= qcom_q6v5_pas.o
>   obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
>   obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
>   obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
> diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_q6v5_pas.c
> similarity index 98%
> rename from drivers/remoteproc/qcom_adsp_pil.c
> rename to drivers/remoteproc/qcom_q6v5_pas.c
> index d4339a6da616..2478ef3cd519 100644
> --- a/drivers/remoteproc/qcom_adsp_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -364,11 +364,11 @@ static struct platform_driver adsp_driver = {
>   	.probe = adsp_probe,
>   	.remove = adsp_remove,
>   	.driver = {
> -		.name = "qcom_adsp_pil",
> +		.name = "qcom_q6v5_pas",
>   		.of_match_table = adsp_of_match,
>   	},
>   };
>   
>   module_platform_driver(adsp_driver);
> -MODULE_DESCRIPTION("Qualcomm MSM8974/MSM8996 ADSP Peripherial Image Loader");
> +MODULE_DESCRIPTION("Qualcomm Hexagon v5 Peripheral Authentication Service driver");

Probable, we should make similar change at header comment.
  * Qualcomm ADSP/SLPI Peripheral Image Loader for MSM8974 and MSM8996
  *

>   MODULE_LICENSE("GPL v2");

