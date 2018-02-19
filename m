Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbeBSOPc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:15:32 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37113 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbeBSOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:15:31 -0500
Message-ID: <1519049728.3408.18.camel@pengutronix.de>
Subject: Re: [PATCH] gpu: ipu-v3: make const arrays int_reg static, shrinks
 object size
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Colin King <colin.king@canonical.com>, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Feb 2018 15:15:28 +0100
In-Reply-To: <20180214184559.8616-1-colin.king@canonical.com>
References: <20180214184559.8616-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Wed, 2018-02-14 at 18:45 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const read-only arrays int_reg on the stack but instead
> make them static. Makes the object code smaller by over 80 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   28024	   8936	    192	  37152	   9120	drivers/gpu/ipu-v3/ipu-common.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   27794	   9080	    192	  37066	   90ca	drivers/gpu/ipu-v3/ipu-common.o
> 
> (gcc version 7.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
> index 658fa2d3e40c..48685cddbad1 100644
> --- a/drivers/gpu/ipu-v3/ipu-common.c
> +++ b/drivers/gpu/ipu-v3/ipu-common.c
> @@ -1089,7 +1089,7 @@ static void ipu_irq_handler(struct irq_desc *desc)
>  {
>  	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	const int int_reg[] = { 0, 1, 2, 3, 10, 11, 12, 13, 14};
> +	static const int int_reg[] = { 0, 1, 2, 3, 10, 11, 12, 13, 14};
>  
>  	chained_irq_enter(chip, desc);
>  
> @@ -1102,7 +1102,7 @@ static void ipu_err_irq_handler(struct irq_desc *desc)
>  {
>  	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	const int int_reg[] = { 4, 5, 8, 9};
> +	static const int int_reg[] = { 4, 5, 8, 9};
>  
>  	chained_irq_enter(chip, desc);

Applied to imx-drm/next, thank you.

regards
Philipp
