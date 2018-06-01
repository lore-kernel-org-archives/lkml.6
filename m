Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeFANfo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:35:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38016 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeFANfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:35:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8374A60249
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [RFC PATCH 3/5] remoteproc: qcom: adsp: Use common q6v5 helpers
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20180523052054.19025-1-bjorn.andersson@linaro.org>
 <20180523052054.19025-4-bjorn.andersson@linaro.org>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <101bb9f7-b571-ef00-e957-a83fb80e1536@codeaurora.org>
Date: Fri, 1 Jun 2018 19:05:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523052054.19025-4-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Reviewed and validated PAS and non-PAS ADSP PIL on sdm845 with the changes.

Adding tag.


On 5/23/2018 10:50 AM, Bjorn Andersson wrote:
> Migrate the Hexagon V5 PAS (ADSP) driver to using the newly extracted
> helper functions. The use of the handover callback does introduce latent
> disabling of proxy resources. But apart from this there should be no
> change in functionality.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   drivers/remoteproc/Kconfig         |   1 +
>   drivers/remoteproc/qcom_adsp_pil.c | 156 +++++------------------------
>   2 files changed, 28 insertions(+), 129 deletions(-)
>
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 63b79ea91a21..d51d155cf8bd 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -93,6 +93,7 @@ config QCOM_ADSP_PIL
>   	depends on QCOM_SYSMON || QCOM_SYSMON=n
>   	select MFD_SYSCON
>   	select QCOM_MDT_LOADER
>

Thanks,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
