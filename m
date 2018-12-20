Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335F0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2B32176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbeLTKqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:46:15 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58916 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLTKqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:46:15 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2812C207AD; Thu, 20 Dec 2018 11:46:13 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id 812172086A;
        Thu, 20 Dec 2018 11:45:50 +0100 (CET)
Date:   Thu, 20 Dec 2018 11:45:50 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] regulator: act8945a-regulator: make symbol
 act8945a_pm static
Message-ID: <20181220114550.782cdddc@bbrezillon>
In-Reply-To: <1545117021-178814-1-git-send-email-weiyongjun1@huawei.com>
References: <1545117021-178814-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 07:10:21 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Fixes the following sparse warning:
> 
> drivers/regulator/act8945a-regulator.c:340:1: warning:
>  symbol 'act8945a_pm' was not declared. Should it be static?
> 
> Fixes: 7482d6ecc68e ("regulator: act8945a-regulator: Implement PM functionalities")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/regulator/act8945a-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
> index 90572b6..dc3942b 100644
> --- a/drivers/regulator/act8945a-regulator.c
> +++ b/drivers/regulator/act8945a-regulator.c
> @@ -337,7 +337,7 @@ static int act8945a_suspend(struct device *pdev)
>  	return regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x42);
>  }
>  
> -SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
> +static SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
>  
>  static void act8945a_pmic_shutdown(struct platform_device *pdev)
>  {
> 
> 
> 

