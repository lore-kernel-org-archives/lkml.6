Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305EDC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF49820834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWzMwlC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF49820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJZFRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:17:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46292 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZFRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:17:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id o2-v6so7847725lfl.13;
        Thu, 25 Oct 2018 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=1Pvyy8JfvzD+ln7cq3fmPY+c1x/u+0vJcXUqs9Hu+hA=;
        b=oWzMwlC5VY6Z5vuU6koUWYJv1uKImopNu4Sh0LIqK1d0qMmQtOV9PsLSXDtdl6oCFr
         5cTDdyCrerDGjQD5C+7NBuoDoO0TioeK95dqtR8/1wqWOVR7Kp7PTZ3v16q1wjuqQM5+
         YLHS0J3RvWABzG8EZ+UpCKdEh0oWrjMFmAys27hUJYyM8XbsT58BRbc5N8zJ3Pxpuqn3
         CLuZE/Okmk1B6B/rp8FWybsA0jG5/PeojibCEEbkZzxYlpIAqOxnHw3ixFyKBGdUtTS8
         tRWFKs3UVXKu33x6io81fwai4c1Jvky0bWnz68tazbCUigq79gYivn12BQJ0KK/psbX1
         ubVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1Pvyy8JfvzD+ln7cq3fmPY+c1x/u+0vJcXUqs9Hu+hA=;
        b=aCOcFRaWlrvuoMUNTc/TpsxTXTIVCGpQAMyuE6zWaRzj/GtpaHfrhVgxryAetGuqxA
         uxbABUVkEEw48FJ2ap5f2SjfeNn8h5iA4W0wow2i3eijU0ahbyE6RstS+LeCfCoEMCUz
         iCMRSveBpcQ/zha6KJlW3BrHpFx4icLdJHYStN2ylnJw6cL3/f2lw3MEF6gnOc0sW2XI
         WmpIumCskuVx06E1+Ca5T3BgLzJSgqSYvW1EKHP5L67HN1am7TlcHOOx+nWbP7vFhSkg
         YK/ehFhORn/8f9vBU0QXRXJSqOCu8FJ876MzLSL+zLhrK+PULGWFZv98ZKWqItMfzdQP
         6NYg==
X-Gm-Message-State: AGRZ1gIzVEtjtCOLLm9/IboCyr9AGvIrQAE5Pi27Zvw14H9cvZd/jSM9
        91yrV4rAF8azu36HY8jF84E=
X-Google-Smtp-Source: AJdET5fRWbmN/tpCffR+umA/ly4/TQJRuYjGOYSKjedSIALpAGJwQvLDXhB4yMsexvt/py37k2ac/Q==
X-Received: by 2002:a19:c203:: with SMTP id l3mr421243lfc.113.1540500206786;
        Thu, 25 Oct 2018 13:43:26 -0700 (PDT)
Received: from ?IPv6:2001:14ba:8017:3300:313a:d550:4603:9163? (dtynxhybvjnm1yvtdwgvt-3.rev.dnainternet.fi. [2001:14ba:8017:3300:313a:d550:4603:9163])
        by smtp.googlemail.com with ESMTPSA id u20-v6sm1432671lfk.55.2018.10.25.13.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:43:25 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] firmware: xilinx: Add reset API's
To:     Nava kishore Manne <nava.manne@xilinx.com>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, jollys@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
References: <20181026122424.30831-1-nava.manne@xilinx.com>
 <20181026122424.30831-2-nava.manne@xilinx.com>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <e5e8a803-0563-b52b-668e-010256705e2e@gmail.com>
Date:   Thu, 25 Oct 2018 23:43:24 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026122424.30831-2-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some comments below.

On 26/10/2018 15.24, Nava kishore Manne wrote:
> This Patch Adds reset API's to support release, assert
> and status functionalities by using firmware interface.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
> 		-None.
>
> Changes for v1:
> 		-None.
>
> Changes for RFC-V3:
> 		-None.
>
> Changes for RFC-V2:
> 		-New patch.
>
>   drivers/firmware/xilinx/zynqmp.c     |  40 +++++++++++
>   include/linux/firmware/xlnx-zynqmp.h | 136 +++++++++++++++++++++++++++++++++++
>   2 files changed, 176 insertions(+)
>
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 84b3fd2..cd13b06 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -428,6 +428,44 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
>   	return ret;
>   }
>   
> +/**
> + * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
> + * @reset:		Reset to be configured
> + * @assert_flag:	Flag stating should reset be asserted (1) or
> + *			released (0)
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> +				  const enum zynqmp_pm_reset_action assert_flag)
> +{
> +	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
> +				   0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_reset_get_status - Get status of the reset
> + * @reset:      Reset whose status should be returned
> + * @status:     Returned status
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
> +				      u32 *status)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!status)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
> +				  0, 0, ret_payload);
> +	*status = ret_payload[1];
> +
> +	return ret;
> +}
> +
>   static const struct zynqmp_eemi_ops eemi_ops = {
>   	.get_api_version = zynqmp_pm_get_api_version,
>   	.query_data = zynqmp_pm_query_data,
> @@ -440,6 +478,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
>   	.clock_getrate = zynqmp_pm_clock_getrate,
>   	.clock_setparent = zynqmp_pm_clock_setparent,
>   	.clock_getparent = zynqmp_pm_clock_getparent,
> +	.reset_assert = zynqmp_pm_reset_assert,
> +	.reset_get_status = zynqmp_pm_reset_get_status,
>   };
>   
>   /**
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 015e130..29d83ca 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -34,6 +34,8 @@
>   
>   enum pm_api_id {
>   	PM_GET_API_VERSION = 1,
> +	PM_RESET_ASSERT = 17,
> +	PM_RESET_GET_STATUS,
>   	PM_QUERY_DATA = 35,
>   	PM_CLOCK_ENABLE,
>   	PM_CLOCK_DISABLE,
> @@ -73,6 +75,137 @@ enum pm_query_id {
>   	PM_QID_CLOCK_GET_ATTRIBUTES,
>   };
>   
> +enum zynqmp_pm_reset_action {
> +	PM_RESET_ACTION_RELEASE,
> +	PM_RESET_ACTION_ASSERT,
> +	PM_RESET_ACTION_PULSE,
> +};
> +
> +enum zynqmp_pm_reset {
> +	ZYNQMP_PM_RESET_START = 999,
> +	ZYNQMP_PM_RESET_PCIE_CFG,
Why not just do:

+	ZYNQMP_PM_RESET_START = 1000,
+	ZYNQMP_PM_RESET_PCIE_CFG = 1000,

This way it would not then indicate that START is actual reset line.

> +	ZYNQMP_PM_RESET_PCIE_BRIDGE,
> +	ZYNQMP_PM_RESET_PCIE_CTRL,
> +	ZYNQMP_PM_RESET_DP,
> +	ZYNQMP_PM_RESET_SWDT_CRF,
> +	ZYNQMP_PM_RESET_AFI_FM5,
> +	ZYNQMP_PM_RESET_AFI_FM4,
> +	ZYNQMP_PM_RESET_AFI_FM3,
> +	ZYNQMP_PM_RESET_AFI_FM2,
> +	ZYNQMP_PM_RESET_AFI_FM1,
> +	ZYNQMP_PM_RESET_AFI_FM0,
> +	ZYNQMP_PM_RESET_GDMA,
> +	ZYNQMP_PM_RESET_GPU_PP1,
> +	ZYNQMP_PM_RESET_GPU_PP0,
> +	ZYNQMP_PM_RESET_GPU,
> +	ZYNQMP_PM_RESET_GT,
> +	ZYNQMP_PM_RESET_SATA,
> +	ZYNQMP_PM_RESET_ACPU3_PWRON,
> +	ZYNQMP_PM_RESET_ACPU2_PWRON,
> +	ZYNQMP_PM_RESET_ACPU1_PWRON,
> +	ZYNQMP_PM_RESET_ACPU0_PWRON,
> +	ZYNQMP_PM_RESET_APU_L2,
> +	ZYNQMP_PM_RESET_ACPU3,
> +	ZYNQMP_PM_RESET_ACPU2,
> +	ZYNQMP_PM_RESET_ACPU1,
> +	ZYNQMP_PM_RESET_ACPU0,
> +	ZYNQMP_PM_RESET_DDR,
> +	ZYNQMP_PM_RESET_APM_FPD,
> +	ZYNQMP_PM_RESET_SOFT,
> +	ZYNQMP_PM_RESET_GEM0,
> +	ZYNQMP_PM_RESET_GEM1,
> +	ZYNQMP_PM_RESET_GEM2,
> +	ZYNQMP_PM_RESET_GEM3,
> +	ZYNQMP_PM_RESET_QSPI,
> +	ZYNQMP_PM_RESET_UART0,
> +	ZYNQMP_PM_RESET_UART1,
> +	ZYNQMP_PM_RESET_SPI0,
> +	ZYNQMP_PM_RESET_SPI1,
> +	ZYNQMP_PM_RESET_SDIO0,
> +	ZYNQMP_PM_RESET_SDIO1,
> +	ZYNQMP_PM_RESET_CAN0,
> +	ZYNQMP_PM_RESET_CAN1,
> +	ZYNQMP_PM_RESET_I2C0,
> +	ZYNQMP_PM_RESET_I2C1,
> +	ZYNQMP_PM_RESET_TTC0,
> +	ZYNQMP_PM_RESET_TTC1,
> +	ZYNQMP_PM_RESET_TTC2,
> +	ZYNQMP_PM_RESET_TTC3,
> +	ZYNQMP_PM_RESET_SWDT_CRL,
> +	ZYNQMP_PM_RESET_NAND,
> +	ZYNQMP_PM_RESET_ADMA,
> +	ZYNQMP_PM_RESET_GPIO,
> +	ZYNQMP_PM_RESET_IOU_CC,
> +	ZYNQMP_PM_RESET_TIMESTAMP,
> +	ZYNQMP_PM_RESET_RPU_R50,
> +	ZYNQMP_PM_RESET_RPU_R51,
> +	ZYNQMP_PM_RESET_RPU_AMBA,
> +	ZYNQMP_PM_RESET_OCM,
> +	ZYNQMP_PM_RESET_RPU_PGE,
> +	ZYNQMP_PM_RESET_USB0_CORERESET,
> +	ZYNQMP_PM_RESET_USB1_CORERESET,
> +	ZYNQMP_PM_RESET_USB0_HIBERRESET,
> +	ZYNQMP_PM_RESET_USB1_HIBERRESET,
> +	ZYNQMP_PM_RESET_USB0_APB,
> +	ZYNQMP_PM_RESET_USB1_APB,
> +	ZYNQMP_PM_RESET_IPI,
> +	ZYNQMP_PM_RESET_APM_LPD,
> +	ZYNQMP_PM_RESET_RTC,
> +	ZYNQMP_PM_RESET_SYSMON,
> +	ZYNQMP_PM_RESET_AFI_FM6,
> +	ZYNQMP_PM_RESET_LPD_SWDT,
> +	ZYNQMP_PM_RESET_FPD,
> +	ZYNQMP_PM_RESET_RPU_DBG1,
> +	ZYNQMP_PM_RESET_RPU_DBG0,
> +	ZYNQMP_PM_RESET_DBG_LPD,
> +	ZYNQMP_PM_RESET_DBG_FPD,
> +	ZYNQMP_PM_RESET_APLL,
> +	ZYNQMP_PM_RESET_DPLL,
> +	ZYNQMP_PM_RESET_VPLL,
> +	ZYNQMP_PM_RESET_IOPLL,
> +	ZYNQMP_PM_RESET_RPLL,
> +	ZYNQMP_PM_RESET_GPO3_PL_0,
> +	ZYNQMP_PM_RESET_GPO3_PL_1,
> +	ZYNQMP_PM_RESET_GPO3_PL_2,
> +	ZYNQMP_PM_RESET_GPO3_PL_3,
> +	ZYNQMP_PM_RESET_GPO3_PL_4,
> +	ZYNQMP_PM_RESET_GPO3_PL_5,
> +	ZYNQMP_PM_RESET_GPO3_PL_6,
> +	ZYNQMP_PM_RESET_GPO3_PL_7,
> +	ZYNQMP_PM_RESET_GPO3_PL_8,
> +	ZYNQMP_PM_RESET_GPO3_PL_9,
> +	ZYNQMP_PM_RESET_GPO3_PL_10,
> +	ZYNQMP_PM_RESET_GPO3_PL_11,
> +	ZYNQMP_PM_RESET_GPO3_PL_12,
> +	ZYNQMP_PM_RESET_GPO3_PL_13,
> +	ZYNQMP_PM_RESET_GPO3_PL_14,
> +	ZYNQMP_PM_RESET_GPO3_PL_15,
> +	ZYNQMP_PM_RESET_GPO3_PL_16,
> +	ZYNQMP_PM_RESET_GPO3_PL_17,
> +	ZYNQMP_PM_RESET_GPO3_PL_18,
> +	ZYNQMP_PM_RESET_GPO3_PL_19,
> +	ZNQMP_PM_RESET_GPO3_PL_20,
Typo here. Missing Y.

Thanks,
Vesa Jääskeläinen
