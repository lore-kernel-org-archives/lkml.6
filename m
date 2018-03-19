Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972031AbeCSVrj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:47:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42532 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965004AbeCSVre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:47:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A87C60312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH] regulator: fix platform_no_drv_owner.cocci warnings
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org
References: <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <20180318203832.GA74597@lkp-hsx03.lkp.intel.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <d7f7ade6-865a-00da-b4c9-6225b8822ec0@codeaurora.org>
Date: Mon, 19 Mar 2018 14:47:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180318203832.GA74597@lkp-hsx03.lkp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18/2018 01:38 PM, kbuild test robot wrote:
> From: Fengguang Wu <fengguang.wu@intel.com>
> 
> drivers/regulator/qcom_rpmh-regulator.c:1104:3-8: 
> No need to set .owner here. The core will do it.

Thanks for pointing this out.

> --- a/drivers/regulator/qcom_rpmh-regulator.c
> +++ b/drivers/regulator/qcom_rpmh-regulator.c
> @@ -1101,7 +1101,6 @@ static struct platform_driver rpmh_regul
>  	.driver		= {
>  		.name		= "qcom-rpmh-regulator",
>  		.of_match_table	= rpmh_regulator_match_table,
> -		.owner		= THIS_MODULE,
>  	},
>  	.probe		= rpmh_regulator_probe,
>  	.remove		= rpmh_regulator_remove,

I'll make this modification in [1] if I end up sending out a second
version of the patch.

Take care,
David

[1]: https://lkml.org/lkml/2018/3/16/1430

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
