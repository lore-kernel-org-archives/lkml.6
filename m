Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeEOHCV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:02:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeEOHCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:02:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 235BA60540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 1/2] phy: qcom-qmp: Quiet -EPROBE_DEFER from
 qcom_qmp_phy_probe()
To: Douglas Anderson <dianders@chromium.org>, kishon@ti.com
Cc: linux-kernel@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
References: <20180514224222.54495-1-dianders@chromium.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <ab9e5b1e-c765-c48c-4804-2657e7b8f4f1@codeaurora.org>
Date: Tue, 15 May 2018 12:32:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514224222.54495-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,


On 5/15/2018 4:12 AM, Douglas Anderson wrote:
> The -EPROBE_DEFER virus demands special case code to avoid printing
> error messages when the error is only -EPROBE_DEFER.  Spread the virus
> to a new host: qcom_qmp_phy_probe().  Specifically handle when our
> regulators might not be ready yet.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   drivers/phy/qualcomm/phy-qcom-qmp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 6470c5d61d1c..a740daa58b31 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1447,7 +1447,9 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
>   
>   	ret = qcom_qmp_phy_vreg_init(dev);
>   	if (ret) {
> -		dev_err(dev, "failed to get regulator supplies\n");
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get regulator supplies: %d\n",
> +				ret);
>   		return ret;
>   	}
>   

Thanks for the patch. Looks good to me.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

regards
Vivek
