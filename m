Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2FEECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3122075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKyrVaiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3122075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbeGRRpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:45:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38637 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeGRRpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:45:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so10156349oie.5;
        Wed, 18 Jul 2018 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Db+ZZ5NVq67Gdwg8SSgTCGavFVL8ZSaxVeKvn3ysEIA=;
        b=nKyrVaiCGH599r070C0J90+LDYCu2GMEfAriVRAmBMpk0dFOYHmRevXGPcKUT/OiUd
         SGU2MyOse6ZPsqaRizqgme+cGQgPBObqsqVF6aVIYDUgPEMU0BoiO28aiFmkokQ1d7z7
         I+HUtn9H3i6NF2J+MdRSc6BZnlowQSnq/HMzVANeWRHS5zymj2TTeIsezRILSa3V3hKp
         vtGwmWxITfyHvphVySQ9QxCwHKfkmZwVCanH/AiSUWaWAoyotbC3rYaUWwCa2lSfp7fQ
         OSKktUQoMUE1EPcICvfn9Y7XuGBOrxKC77Jsxp+y/tP/h0D1MFznehYo6HUr6siDDKVZ
         w9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Db+ZZ5NVq67Gdwg8SSgTCGavFVL8ZSaxVeKvn3ysEIA=;
        b=peh25OiIdsxeXP1dkoV8wx+oZFQmMALU4iPsB7PuNRpLKv+gYKeOuupvn3dDU9/WDZ
         y85hWdLi7sqrFU0YRZEXXEGFqKe//13s5NiOF+j9fJ2SPXGV07GLH/+Al0GFqhgmV13+
         hfGvj+DAR/ok4IQKILcYJIC/x5QZpT3CbyatEz9sgHWmvsZuUk0McUXGeummZqy2hl2E
         BZNRX6kgXI2hjH7Zhijrf+mRwpnm0p5O6M3swkqMhrOi6qCsb5u2U7j11lX+F71ZGJLZ
         KCQbrkH7lTCLh30SZBCzG4mUnwOORFf8O009RNw3cFmiTrZwPurdIdo5xklTcTUor/eT
         VC5Q==
X-Gm-Message-State: AOUpUlFO63FTj+gMf4kZF+BdjFgisWJXjiZ/KqjVrGYrTL1bPIHQFJzu
        hMU2SkkNgr5T+zHowI3rBbo=
X-Google-Smtp-Source: AAOMgpdeHypcHJAC6crkRtSTeGeZGoqpcFI1E9TtedVhbx5q66fQb0YNytIPKV4fN9Vxfr/87TVG/g==
X-Received: by 2002:aca:40d6:: with SMTP id n205-v6mr7530377oia.35.1531933607384;
        Wed, 18 Jul 2018 10:06:47 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id r10-v6sm2974170oif.37.2018.07.18.10.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:06:46 -0700 (PDT)
Date:   Wed, 18 Jul 2018 17:06:42 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: ti_am335x_tsc: Mark TSC device as wakeup
 source
Message-ID: <20180718170642.2ebl5msdn6aahdas@penguin>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630103318.25355-3-vigneshr@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 04:03:15PM +0530, Vignesh R wrote:
> Instead of TSCADC MFD device, mark TSC as wakeup source and change all
> wakeup related PM calls to operate on TSC device.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index b86c1e5fbc11..a4f25a915ffc 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -46,6 +46,7 @@ static const int config_pins[] = {
>  struct titsc {
>  	struct input_dev	*input;
>  	struct ti_tscadc_dev	*mfd_tscadc;
> +	struct device		*dev;
>  	unsigned int		irq;
>  	unsigned int		wires;
>  	unsigned int		x_plate_resistance;
> @@ -276,7 +277,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
>  	if (status & IRQENB_HW_PEN) {
>  		ts_dev->pen_down = true;
>  		irqclr |= IRQENB_HW_PEN;
> -		pm_stay_awake(ts_dev->mfd_tscadc->dev);
> +		pm_stay_awake(ts_dev->dev);
>  	}
>  
>  	if (status & IRQENB_PENUP) {
> @@ -286,7 +287,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
>  			input_report_key(input_dev, BTN_TOUCH, 0);
>  			input_report_abs(input_dev, ABS_PRESSURE, 0);
>  			input_sync(input_dev);
> -			pm_relax(ts_dev->mfd_tscadc->dev);
> +			pm_relax(ts_dev->dev);
>  		} else {
>  			ts_dev->pen_down = true;
>  		}
> @@ -422,6 +423,7 @@ static int titsc_probe(struct platform_device *pdev)
>  	ts_dev->mfd_tscadc = tscadc_dev;
>  	ts_dev->input = input_dev;
>  	ts_dev->irq = tscadc_dev->irq;
> +	ts_dev->dev = &pdev->dev;
>  
>  	err = titsc_parse_dt(pdev, ts_dev);
>  	if (err) {
> @@ -436,6 +438,8 @@ static int titsc_probe(struct platform_device *pdev)
>  		goto err_free_mem;
>  	}
>  
> +	device_init_wakeup(&pdev->dev, true);
> +
>  	titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
> @@ -467,6 +471,7 @@ static int titsc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free_irq:
> +	device_init_wakeup(&pdev->dev, false);
>  	free_irq(ts_dev->irq, ts_dev);
>  err_free_mem:
>  	input_free_device(input_dev);
> @@ -479,6 +484,7 @@ static int titsc_remove(struct platform_device *pdev)
>  	struct titsc *ts_dev = platform_get_drvdata(pdev);
>  	u32 steps;
>  
> +	device_init_wakeup(&pdev->dev, false);
>  	free_irq(ts_dev->irq, ts_dev);
>  
>  	/* total steps followed by the enable mask */
> @@ -499,7 +505,7 @@ static int __maybe_unused titsc_suspend(struct device *dev)
>  	unsigned int idle;
>  
>  	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
> -	if (device_may_wakeup(tscadc_dev->dev)) {
> +	if (device_may_wakeup(dev)) {
>  		titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
>  		idle = titsc_readl(ts_dev, REG_IRQENABLE);
>  		titsc_writel(ts_dev, REG_IRQENABLE,
> @@ -515,11 +521,11 @@ static int __maybe_unused titsc_resume(struct device *dev)
>  	struct ti_tscadc_dev *tscadc_dev;
>  
>  	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
> -	if (device_may_wakeup(tscadc_dev->dev)) {
> +	if (device_may_wakeup(dev)) {
>  		titsc_writel(ts_dev, REG_IRQWAKEUP,
>  				0x00);
>  		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
> -		pm_relax(ts_dev->mfd_tscadc->dev);
> +		pm_relax(dev);
>  	}
>  	titsc_step_config(ts_dev);
>  	titsc_writel(ts_dev, REG_FIFO0THR,
> -- 
> 2.18.0
> 

-- 
Dmitry
