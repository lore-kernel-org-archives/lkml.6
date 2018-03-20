Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeCTKMX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:12:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeCTKMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:12:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE9A060312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 2/6] phy: qcom-qusb2: Fix crash if nvmem cell not
 specified
To: Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-kernel@vger.kernel.org>
References: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
 <1521193500-4696-3-git-send-email-mgautam@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <24bc718a-10cd-6fd7-aa16-af201c08f17f@codeaurora.org>
Date: Tue, 20 Mar 2018 15:42:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521193500-4696-3-git-send-email-mgautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manu,


On 3/16/2018 3:14 PM, Manu Gautam wrote:
> Driver currently crashes due to NULL pointer deference
> while updating PHY tune register if nvmem cell is NULL.
> Since, fused value for Tune1/2 register is optional,
> we'd rather bail out.

fixes: ("ca04d9d3e1b1 phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom 
chips") ?
and please CC to stable as well - ver 4.14.

With that,
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Thanks
Vivek
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qusb2.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index 94afeac..40fdef8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -315,6 +315,10 @@ static void qusb2_phy_set_tune2_param(struct qusb2_phy *qphy)
>   	const struct qusb2_phy_cfg *cfg = qphy->cfg;
>   	u8 *val;
>   
> +	/* efuse register is optional */
> +	if (!qphy->cell)
> +		return;
> +
>   	/*
>   	 * Read efuse register having TUNE2/1 parameter's high nibble.
>   	 * If efuse register shows value as 0x0, or if we fail to find
