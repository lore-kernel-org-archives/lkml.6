Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeDVROI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 13:14:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46273 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbeDVROG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 13:14:06 -0400
Date: Sun, 22 Apr 2018 19:13:34 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 29/61] mtd: devices: simplify getting .drvdata
Message-ID: <20180422191334.784f7723@bbrezillon>
In-Reply-To: <20180419140641.27926-30-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <20180419140641.27926-30-wsa+renesas@sang-engineering.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 16:05:59 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to mtd/next.

Thanks,

Boris

> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/mtd/devices/docg3.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
> index c594fe5eac08..802d8f159e90 100644
> --- a/drivers/mtd/devices/docg3.c
> +++ b/drivers/mtd/devices/docg3.c
> @@ -1470,8 +1470,7 @@ static struct docg3 *sysfs_dev2docg3(struct device *dev,
>  				     struct device_attribute *attr)
>  {
>  	int floor;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct mtd_info **docg3_floors = platform_get_drvdata(pdev);
> +	struct mtd_info **docg3_floors = dev_get_drvdata(dev);
>  
>  	floor = attr->attr.name[1] - '0';
>  	if (floor < 0 || floor >= DOC_MAX_NBFLOORS)
