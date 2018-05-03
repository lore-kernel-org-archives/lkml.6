Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeECMXZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:23:25 -0400
Received: from gloria.sntech.de ([95.129.55.99]:43348 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbeECMXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:23:21 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 50/61] thermal: simplify getting .drvdata
Date: Thu, 03 May 2018 14:23:07 +0200
Message-ID: <3499277.H47n29vZV6@phil>
In-Reply-To: <20180419140641.27926-51-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com> <20180419140641.27926-51-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 19. April 2018, 16:06:20 CEST schrieb Wolfram Sang:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/thermal/rockchip_thermal.c | 8 +++-----
>  drivers/thermal/spear_thermal.c    | 8 +++-----
>  drivers/thermal/zx2967_thermal.c   | 6 ++----
>  3 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index f36375d5a16c..9c7643d62ed7 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1327,8 +1327,7 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
>  
>  static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
> +	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
>  	int i;
>  
>  	for (i = 0; i < thermal->chip->chn_num; i++)
> @@ -1346,8 +1345,7 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  
>  static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
> +	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
>  	int i;
>  	int error;
>  
> @@ -1376,7 +1374,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  					      id, thermal->regs,
>  					      thermal->tshut_temp);
>  		if (error)
> -			dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
> +			dev_err(dev, "%s: invalid tshut=%d, error=%d\n",
>  				__func__, thermal->tshut_temp, error);
>  	}
>  

for the Rockchip-part
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
