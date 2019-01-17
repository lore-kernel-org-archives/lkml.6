Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F52C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE66120855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WGf2dvUB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WGf2dvUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfAQKHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:07:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37908 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:07:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9838B607DD; Thu, 17 Jan 2019 10:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547719650;
        bh=/ACOGEZgPu48MHruLb9qUWEi1HgpRMxa7+2CtlVuyYY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WGf2dvUBfqVWk5P6qMtRQ5GsAZcHFSnDtETagfzEmc1bPQ2aicl2ZUgfAQ8+ZZW+R
         9FCL84h8Si9EwaCqUFHe1yC7dnCUm1zTuhNuGyPuefyqLdu/7YEGhOdJtskwRdkpxd
         JxH6p/Xb2f7u7Ic5jiUgs5J3hhFISHupwEmNoVJI=
Received: from [10.79.128.217] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A596C601D3;
        Thu, 17 Jan 2019 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547719650;
        bh=/ACOGEZgPu48MHruLb9qUWEi1HgpRMxa7+2CtlVuyYY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WGf2dvUBfqVWk5P6qMtRQ5GsAZcHFSnDtETagfzEmc1bPQ2aicl2ZUgfAQ8+ZZW+R
         9FCL84h8Si9EwaCqUFHe1yC7dnCUm1zTuhNuGyPuefyqLdu/7YEGhOdJtskwRdkpxd
         JxH6p/Xb2f7u7Ic5jiUgs5J3hhFISHupwEmNoVJI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A596C601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] soc: qcom: rpmpd: Drop family A RPM dependency
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190117051120.31913-1-bjorn.andersson@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <a682fe70-7eae-dd4c-5bca-b08ff24d8479@codeaurora.org>
Date:   Thu, 17 Jan 2019 15:37:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117051120.31913-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/2019 10:41 AM, Bjorn Andersson wrote:
> The MFD_QCOM_RPM is the RPM in family A, but the rpmpd driver only implements
> support for SMD based devices. Drop the dependency and remove includes of the
> family A headers. No functional change.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Sorry for not spotting this earlier, let's apply the series and this fix on
> top.

Thanks Bjorn for catching this,
Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>

> 
>   drivers/soc/qcom/Kconfig |  2 +-
>   drivers/soc/qcom/rpmpd.c | 10 ++++------
>   2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 6241d3e3b115..a5d5167c3f16 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -109,7 +109,7 @@ config QCOM_RPMHPD
>   
>   config QCOM_RPMPD
>   	bool "Qualcomm RPM Power domain driver"
> -	depends on MFD_QCOM_RPM && QCOM_SMD_RPM
> +	depends on QCOM_SMD_RPM
>   	help
>   	  QCOM RPM Power domain driver to support power-domains with
>   	  performance states. The driver communicates a performance state
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index 35a711017d6f..005326050c23 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -6,14 +6,12 @@
>   #include <linux/kernel.h>
>   #include <linux/mutex.h>
>   #include <linux/pm_domain.h>
> -#include <linux/mfd/qcom_rpm.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_opp.h>
>   #include <linux/soc/qcom/smd-rpm.h>
>   
> -#include <dt-bindings/mfd/qcom-rpm.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   
>   #define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, pd)
> @@ -131,8 +129,8 @@ static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
>   		.value = cpu_to_le32(enable),
>   	};
>   
> -	return qcom_rpm_smd_write(pd->rpm, QCOM_RPM_ACTIVE_STATE, pd->res_type,
> -				  pd->res_id, &req, sizeof(req));
> +	return qcom_rpm_smd_write(pd->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
> +				  pd->res_type, pd->res_id, &req, sizeof(req));
>   }
>   
>   static int rpmpd_send_corner(struct rpmpd *pd, int state, unsigned int corner)
> @@ -174,13 +172,13 @@ static int rpmpd_aggregate_corner(struct rpmpd *pd)
>   
>   	active_corner = max(this_active_corner, peer_active_corner);
>   
> -	ret = rpmpd_send_corner(pd, QCOM_RPM_ACTIVE_STATE, active_corner);
> +	ret = rpmpd_send_corner(pd, QCOM_SMD_RPM_ACTIVE_STATE, active_corner);
>   	if (ret)
>   		return ret;
>   
>   	sleep_corner = max(this_sleep_corner, peer_sleep_corner);
>   
> -	return rpmpd_send_corner(pd, QCOM_RPM_SLEEP_STATE, sleep_corner);
> +	return rpmpd_send_corner(pd, QCOM_SMD_RPM_SLEEP_STATE, sleep_corner);
>   }
>   
>   static int rpmpd_power_on(struct generic_pm_domain *domain)
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
