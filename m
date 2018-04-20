Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754340AbeDTIJw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:09:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36715 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754271AbeDTIJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:09:46 -0400
X-Google-Smtp-Source: AIpwx48HY/2p4n4j4fHOP9tDyc9ls0vGYRc6AOk06VLF9bEXdrgyOm48w2c5QNg49nBvVxuslEATSw==
Date: Fri, 20 Apr 2018 09:09:43 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: tps65911-comparator: Fix an off by one bug
Message-ID: <20180420080943.jdbf7vtnkc33vbvd@dell>
References: <20180419134634.GA19793@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419134634.GA19793@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018, Dan Carpenter wrote:

> The tps_comparators[] array is used in two places.  We only access the
> COMP1 (1) and COMP2 (2) elements.  Unfortunately, we're accessing the
> wrong elements and also one element beyond the end of the array.  There
> was supposed to be a zero element at the start of the array which is
> isn't accessed but makes the math work out nicely.

I normally just apply patches from you, but this is a hack, right?

> Fixes: 6851ad3ab346 ("TPS65911: Comparator: Add comparator driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I can't actually compile this code...
> 
> diff --git a/drivers/mfd/tps65911-comparator.c b/drivers/mfd/tps65911-comparator.c
> index c0789f81a1c5..35d7380f6fad 100644
> --- a/drivers/mfd/tps65911-comparator.c
> +++ b/drivers/mfd/tps65911-comparator.c
> @@ -42,6 +42,7 @@ struct comparator {
>  };
>  
>  static struct comparator tps_comparators[] = {
> +	{	.name = "COMP", },
>  	{
>  		.name = "COMP1",
>  		.reg = TPS65911_VMBCH,

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
