Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeCVChx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:37:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeCVChu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:37:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 963E260817
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH][next] phy: qcom-qusb2: fix missing assignment to an error
 return code
To: Colin King <colin.king@canonical.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180321174538.2194-1-colin.king@canonical.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <40d4e9a6-86c0-4f1d-4768-b27209ab4890@codeaurora.org>
Date: Thu, 22 Mar 2018 08:07:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321174538.2194-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2018 11:15 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The error return code is not being assigned to ret from the call
> to clk_prepare_enable and consequently the current check on ret
> picks up the previous error return. Fix this by adding in the
> missing assignment to ret.
>
> Detected by CoverityScan, CID#166020 ("Logically Dead code")
>
> Fixes: 891a96f65ac3 ("phy: qcom-qusb2: Add support for runtime PM)
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-by: Vivek Gautam <vivek.gautam@codeaurora.org>

regards
Vivek

>   drivers/phy/qualcomm/phy-qcom-qusb2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index 94afeac1a19e..6f5689a40884 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -439,7 +439,7 @@ static int __maybe_unused qusb2_phy_runtime_resume(struct device *dev)
>   	}
>   
>   	if (!qphy->has_se_clk_scheme) {
> -		clk_prepare_enable(qphy->ref_clk);
> +		ret = clk_prepare_enable(qphy->ref_clk);
>   		if (ret) {
>   			dev_err(dev, "failed to enable ref clk, %d\n", ret);
>   			goto disable_ahb_clk;
