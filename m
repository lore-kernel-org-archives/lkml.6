Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeDVR3i (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 13:29:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46750 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbeDVR3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 13:29:35 -0400
Date: Sun, 22 Apr 2018 19:29:21 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        kernel-janitors@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 30/61] mtd: nand: onenand: simplify getting .drvdata
Message-ID: <20180422192921.61a6b28b@bbrezillon>
In-Reply-To: <20180419140641.27926-31-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <20180419140641.27926-31-wsa+renesas@sang-engineering.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 16:06:00 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to nand/next.

Thanks,

Boris

> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/mtd/nand/onenand/samsung.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/onenand/samsung.c b/drivers/mtd/nand/onenand/samsung.c
> index 2e9d076e445a..4cce4c0311ca 100644
> --- a/drivers/mtd/nand/onenand/samsung.c
> +++ b/drivers/mtd/nand/onenand/samsung.c
> @@ -958,8 +958,7 @@ static int s3c_onenand_remove(struct platform_device *pdev)
>  
>  static int s3c_pm_ops_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct mtd_info *mtd = platform_get_drvdata(pdev);
> +	struct mtd_info *mtd = dev_get_drvdata(dev);
>  	struct onenand_chip *this = mtd->priv;
>  
>  	this->wait(mtd, FL_PM_SUSPENDED);
> @@ -968,8 +967,7 @@ static int s3c_pm_ops_suspend(struct device *dev)
>  
>  static  int s3c_pm_ops_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct mtd_info *mtd = platform_get_drvdata(pdev);
> +	struct mtd_info *mtd = dev_get_drvdata(dev);
>  	struct onenand_chip *this = mtd->priv;
>  
>  	this->unlock_all(mtd);
