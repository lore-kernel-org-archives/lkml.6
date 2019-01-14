Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A25C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5CA206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jdn17jXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfANQ3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:29:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39836 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfANQ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:29:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so27167833qtj.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=A5cQcWgbQjYFw544uutW3MxtIejCvx84mGC5rsDJ3Uo=;
        b=Jdn17jXhi5/Cb6MK2/K85r7Tc0CfKsJZgI/IyqenXtjyT7I1liyDG5P0lYQLaXshSX
         8fM6j+jIg4LXs4aP6HvhyexqvoeLF1IwFwAmRBnrsgVLY+NoY70whcaTx18GJrHth3bi
         X2CdXlaX9eEmpLzviWdyuGf+3hyqiO9MQUMfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=A5cQcWgbQjYFw544uutW3MxtIejCvx84mGC5rsDJ3Uo=;
        b=QEu1ygQsdnsPC4aNb9SxI8T+Vlk0rkPOFXQF/G9/amZylOuhwHUwgT5X5gLBftTx4V
         J1bE9VbnUOcUrBrBuJ4jtp9Stwxz6bqCM3MBRWulXaNrmnlpMhVdoX1PEiHeysWBCB1R
         7aaG7YNKtkYTKd0X1tfLm5Waqv+OGlk93IAc59yyFqmjmObrgj+1QaNANRnvSVR7SzKH
         SW9LZDM/Nuvc6w3OU3qEJG98mvIC0MW1PMDjNcjx5mIFVVVyGDe7d+ZoGYtV8NH+g26G
         Oi4yubw8dU9Kqmp/dY3vQ9a9hpdgsiXj22CgZW4kYTm4UBYgp9Lk31lK6xL/rcHSPbHy
         DKqA==
X-Gm-Message-State: AJcUukfY2nZMCKzvuxjPYPUid+OGRG2EOc2UG6LB87rDjoh23luW1uPX
        DZ04QRhczu5C/nqZ6GfomPfhNg==
X-Google-Smtp-Source: ALg8bN5azjlcexe1pAxWtCK01n9/B3FewGfDUYqJy+A14m052i2QnO5+vn3UPSWta1b4A+qKBKmuIg==
X-Received: by 2002:ac8:60cb:: with SMTP id i11mr24962694qtm.360.1547483350790;
        Mon, 14 Jan 2019 08:29:10 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id l95sm7311992qkh.37.2019.01.14.08.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:29:09 -0800 (PST)
Date:   Mon, 14 Jan 2019 11:29:07 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] mmc: mvsdio: handle highmem pages
In-Reply-To: <20190114095804.27978-8-hch@lst.de>
Message-ID: <nycvar.YSQ.7.76.1901141107030.4477@knanqh.ubzr>
References: <20190114095804.27978-1-hch@lst.de> <20190114095804.27978-8-hch@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019, Christoph Hellwig wrote:

> Instead of setting up a kernel pointer to track the current PIO address,
> track the offset in the current page, and do an atomic kmap for the page
> while doing the actual PIO operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Just a small suggestion below


> ---
>  drivers/mmc/host/mvsdio.c | 48 +++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index e22bbff89c8d..545e370d6dae 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/highmem.h>
>  #include <linux/platform_device.h>
>  #include <linux/mbus.h>
>  #include <linux/delay.h>
> @@ -42,7 +43,8 @@ struct mvsd_host {
>  	unsigned int intr_en;
>  	unsigned int ctrl;
>  	unsigned int pio_size;
> -	void *pio_ptr;
> +	struct scatterlist *pio_sg;
> +	unsigned int pio_offset; /* offset in words into the segment */
>  	unsigned int sg_frags;
>  	unsigned int ns_per_clk;
>  	unsigned int clock;
> @@ -96,9 +98,9 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>  	if (tmout_index > MVSD_HOST_CTRL_TMOUT_MAX)
>  		tmout_index = MVSD_HOST_CTRL_TMOUT_MAX;
>  
> -	dev_dbg(host->dev, "data %s at 0x%08x: blocks=%d blksz=%d tmout=%u (%d)\n",
> +	dev_dbg(host->dev, "data %s at 0x%08llx: blocks=%d blksz=%d tmout=%u (%d)\n",
>  		(data->flags & MMC_DATA_READ) ? "read" : "write",
> -		(u32)sg_virt(data->sg), data->blocks, data->blksz,
> +		(u64)sg_phys(data->sg), data->blocks, data->blksz,
>  		tmout, tmout_index);
>  
>  	host->ctrl &= ~MVSD_HOST_CTRL_TMOUT_MASK;
> @@ -118,10 +120,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>  		 * boundary.
>  		 */
>  		host->pio_size = data->blocks * data->blksz;
> -		host->pio_ptr = sg_virt(data->sg);
> +		host->pio_sg = data->sg;
> +		host->pio_offset = data->sg->offset / 2;
>  		if (!nodma)
> -			dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
> -				host->pio_ptr, host->pio_size);
> +			dev_dbg(host->dev, "fallback to PIO for data at 0x%x size %d\n",
> +				host->pio_offset, host->pio_size);
>  		return 1;
>  	} else {
>  		dma_addr_t phys_addr;
> @@ -291,8 +294,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
>  {
>  	void __iomem *iobase = host->base;
>  
> -	if (host->pio_ptr) {
> -		host->pio_ptr = NULL;
> +	if (host->pio_sg) {
> +		host->pio_sg = NULL;
> +		host->pio_offset = 0;
>  		host->pio_size = 0;
>  	} else {
>  		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
> @@ -376,11 +380,12 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>  	if (host->pio_size &&
>  	    (intr_status & host->intr_en &
>  	     (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
> -		u16 *p = host->pio_ptr;
> +		u16 *p = kmap_atomic(sg_page(host->pio_sg));
> +		unsigned int o = host->pio_offset;

To minimize code change, you could do:

		u16 *p0 = kmap_atomic(sg_page(host->pio_sg));
		u16 *p = p0 + host->pio_offset;

and at the end:

		host->pio_offset = p - p0;

leaving the middle code unchanged.

This might also produce slightly better assembly with the post increment 
instructions on ARM if the compiler doesn't figure it out on its own 
otherwise.


Nicolas
