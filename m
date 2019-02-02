Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9461BC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA5B20869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549091804;
	bh=LbbWCY52MZJlTmK3M5ALRbknLFOVhDeo6yjUTIUVON4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=knORhaJ5fL4V8HFeh/dJSU+ZGflt1oOJILdmAiB6rUXjoSuRlADiRktlQ6LO+J3fj
	 SpfJ/2X6se4abZgxF+wYD4mcL0KxsZAc9s6KGbdx/0d5EEgHiJT4f4gA6c38JflzdD
	 wEfdpSvdDnHhiRiB2Z9VD1i8UR4r7mRmOHJh/YSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfBBHQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:16:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfBBHQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:16:42 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D1420869;
        Sat,  2 Feb 2019 07:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549091800;
        bh=LbbWCY52MZJlTmK3M5ALRbknLFOVhDeo6yjUTIUVON4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XV10zHJblF6h4vbJVPvIyVrzQD8uDn6PSM2LNL4FdmV0Y5YlRRmhdpLGRScahI4OF
         JWKEq830IrJPSm4Tn10+FlfsukSxQq0gQi4ooYffqCsE2GpCmUnnK977u1cRW2PWxO
         mj7xmS39AtqyhePekiP6LVOQ7xJsJHdqOuH6K/rw=
Date:   Sat, 2 Feb 2019 08:16:25 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 11/13] spi: atmel-quadspi: add support for named
 peripheral clock
Message-ID: <20190202081625.58a0be1d@bbrezillon>
In-Reply-To: <20190202040653.1217-12-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-12-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 04:07:41 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Naming clocks is a good practice. Keep supporting unnamed
> peripheral clock, to be backward compatible with old DTs.
> While here, rename clk to pclk, to indicate that it is a
> peripheral clock.
> 
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v3: new patch
> 
>  drivers/spi/atmel-quadspi.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index bfa5f5e92d96..c9548942535a 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -136,7 +136,7 @@
>  struct atmel_qspi {
>  	void __iomem		*regs;
>  	void __iomem		*mem;
> -	struct clk		*clk;
> +	struct clk		*pclk;
>  	struct platform_device	*pdev;
>  	u32			pending;
>  	u32			smm;
> @@ -338,7 +338,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  	if (!spi->max_speed_hz)
>  		return -EINVAL;
>  
> -	src_rate = clk_get_rate(aq->clk);
> +	src_rate = clk_get_rate(aq->pclk);
>  	if (!src_rate)
>  		return -EINVAL;
>  
> @@ -429,15 +429,18 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Get the peripheral clock */
> -	aq->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(aq->clk)) {
> +	aq->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(aq->pclk))
> +		aq->pclk = devm_clk_get(&pdev->dev, NULL);
> +
> +	if (IS_ERR(aq->pclk)) {
>  		dev_err(&pdev->dev, "missing peripheral clock\n");
> -		err = PTR_ERR(aq->clk);
> +		err = PTR_ERR(aq->pclk);
>  		goto exit;
>  	}
>  
>  	/* Enable the peripheral clock */
> -	err = clk_prepare_enable(aq->clk);
> +	err = clk_prepare_enable(aq->pclk);
>  	if (err) {
>  		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
>  		goto exit;
> @@ -448,25 +451,25 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "missing IRQ\n");
>  		err = irq;
> -		goto disable_clk;
> +		goto disable_pclk;
>  	}
>  	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
>  			       0, dev_name(&pdev->dev), aq);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_pclk;
>  
>  	err = atmel_qspi_init(aq);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_pclk;
>  
>  	err = spi_register_controller(ctrl);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_pclk;
>  
>  	return 0;
>  
> -disable_clk:
> -	clk_disable_unprepare(aq->clk);
> +disable_pclk:
> +	clk_disable_unprepare(aq->pclk);
>  exit:
>  	spi_controller_put(ctrl);
>  
> @@ -480,7 +483,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  
>  	spi_unregister_controller(ctrl);
>  	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
> -	clk_disable_unprepare(aq->clk);
> +	clk_disable_unprepare(aq->pclk);
>  	return 0;
>  }
>  
> @@ -488,7 +491,7 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
>  {
>  	struct atmel_qspi *aq = dev_get_drvdata(dev);
>  
> -	clk_disable_unprepare(aq->clk);
> +	clk_disable_unprepare(aq->pclk);
>  
>  	return 0;
>  }
> @@ -497,7 +500,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
>  {
>  	struct atmel_qspi *aq = dev_get_drvdata(dev);
>  
> -	clk_prepare_enable(aq->clk);
> +	clk_prepare_enable(aq->pclk);
>  
>  	return atmel_qspi_init(aq);
>  }

