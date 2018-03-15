Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbeCOHxo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:53:44 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:49826 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOHxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:53:43 -0400
From: Richard Weinberger <richard@nod.at>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2 v2] mtd: ubi: use put_device() if device_register fail
Date: Thu, 15 Mar 2018 08:55:09 +0100
Message-ID: <5296799.FRhcbj8Hd9@blindfold>
In-Reply-To: <1521098431-29565-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1521098431-29565-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 15. März 2018, 08:20:31 CET schrieb Arvind Yadav:
> if device_register() returned an error! Always use put_device()
> to give up the reference initialized.

Like DaveM said, there is no need to shout and use "!".
 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> change in v2:
>         Fix use-after-free bug. move put_device() after cdev_del().
> 
>  drivers/mtd/ubi/vmt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 3fd8d7f..93c6163 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -610,6 +610,7 @@ int ubi_add_volume(struct ubi_device *ubi, struct
> ubi_volume *vol)
> 
>  out_cdev:
>  	cdev_del(&vol->cdev);
> +	put_device(&vol->dev);
>  	return err;

The more I dig into device code, the more questions I have.
Why is cdev_del() not part of the release function?

Thanks,
//richard
