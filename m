Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeBSDkd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 22:40:33 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33771 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeBSDkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 22:40:31 -0500
X-Google-Smtp-Source: AH8x224z+cZ49+JJYEVk/D/+sT2cXJEMx2tPzEFBGD4IZyFC7Lc55R1po+eHGfr94Szg3PMwm2gc+g==
Date: Mon, 19 Feb 2018 09:10:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] pata_arasan_cf: Delete an error message for a failed
 memory allocation in arasan_cf_probe()
Message-ID: <20180219034028.GH28462@vireshk-i7>
References: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
 <05b48a33-81ae-b1b1-428c-4a9a0c9a4fe8@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05b48a33-81ae-b1b1-428c-4a9a0c9a4fe8@users.sourceforge.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-18, 16:57, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 16 Feb 2018 16:01:12 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/ata/pata_arasan_cf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index b4d54771c9fe..be5fbcedecbf 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -809,10 +809,8 @@ static int arasan_cf_probe(struct platform_device *pdev)
>  	}
>  
>  	acdev = devm_kzalloc(&pdev->dev, sizeof(*acdev), GFP_KERNEL);
> -	if (!acdev) {
> -		dev_warn(&pdev->dev, "kzalloc fail\n");
> +	if (!acdev)
>  		return -ENOMEM;
> -	}
>  
>  	if (pdata)
>  		quirk = pdata->quirk;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
