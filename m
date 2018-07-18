Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D2FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D372075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PamBwGPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D372075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbeGRRpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:45:20 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44465 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbeGRRpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:45:20 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so10131689oih.11;
        Wed, 18 Jul 2018 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EK6F7CLagOyGSJqQQcRGdoMZQRXhN87UgGgt33olbtw=;
        b=PamBwGPNzy3nLTQZ2DK88nTJZgXt9p62M8qW0YEwbOSKvrOrDeEepOk1Om2J2IXKvf
         D51elT95vodTps08YbTGqy+gUIUFpPdb9XynMSDzOIwG48lQEcI0DjyPNh9MQvXXDaEq
         oM0rubxejEn6AOvDIF5Hvyvh5JgVakEucPVrb5LWPDvPBaPCRQNgEEiRXcosmyQHZVQq
         ip+ziAEuOvmd3zXjC1LNK6ueyIX0hDsQevjHEdz4N5S51ekOLVN+dMycrSAAHKsFGW7B
         7I508kbCUWWQoLThH3+noml1YJl1bHkmbBzeGfl76EoOzmh55J5BPv19u8oGvUQ+vVbQ
         UC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EK6F7CLagOyGSJqQQcRGdoMZQRXhN87UgGgt33olbtw=;
        b=bldajS7nxyQvHtj5RwnB7CwNxh/nHo1Ug7vI9UlZFGe6VbmpdTf1gAvS31SEEhBIxm
         70Jbgv9LImCfLe+SB5GB9FeBQ/suA2bTefSKgqp8mOc1hhXoer7NcUI/neEdiu4sKeNR
         DQ7XdeDkYlndHGS06oYFIIys3FvIPQTabrnheCHqFv4OX2X+ucnFuA1P88zj+PZveXV2
         ommINbmrwvJeuaZi+m56+uCBo5AFsp22MwHOwuftbvTgchQRugZNW9syJ7SkbCW1MSdi
         3RV2Ixjj/b90s2llBKph6lyr8biXmk1UXOVEwsdWq7fmnxoD6pY/2EGW9X/YlXB9YJhm
         Pnvw==
X-Gm-Message-State: AOUpUlETH2C9koekMMicXpbBGlhJ5xE3UYIXRwdCIHZxIoAqHX5mvweC
        LWkpYpkkJIPJhVgW7xtO3LE=
X-Google-Smtp-Source: AAOMgpcCq1A6Z6dB2oj32+JPszh2p37HhlgaeFistQcgEY68FrgOZT3QrwK4wsPIK5wPnDQRgXjsSQ==
X-Received: by 2002:aca:ab11:: with SMTP id u17-v6mr6768165oie.53.1531933589694;
        Wed, 18 Jul 2018 10:06:29 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id 5-v6sm2517738oix.58.2018.07.18.10.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:06:28 -0700 (PDT)
Date:   Wed, 18 Jul 2018 17:06:22 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 5/5] Input: ti_am335x_tsc: Mark IRQ as wakeup capable
Message-ID: <20180718170622.qms254nlvnavfk7q@penguin>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-6-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630103318.25355-6-vigneshr@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 04:03:18PM +0530, Vignesh R wrote:
> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
> IRQ as wakeup capable, so that device irq is not disabled during system
> suspend.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index a4f25a915ffc..9e8684ab48f4 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -27,6 +27,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/sort.h>
> +#include <linux/pm_wakeirq.h>
>  
>  #include <linux/mfd/ti_am335x_tscadc.h>
>  
> @@ -439,6 +440,9 @@ static int titsc_probe(struct platform_device *pdev)
>  	}
>  
>  	device_init_wakeup(&pdev->dev, true);
> +	err = dev_pm_set_wake_irq(&pdev->dev, ts_dev->irq);
> +	if (err)
> +		dev_err(&pdev->dev, "irq wake enable failed.\n");
>  
>  	titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
> @@ -471,6 +475,7 @@ static int titsc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free_irq:
> +	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
>  	free_irq(ts_dev->irq, ts_dev);
>  err_free_mem:
> @@ -484,6 +489,7 @@ static int titsc_remove(struct platform_device *pdev)
>  	struct titsc *ts_dev = platform_get_drvdata(pdev);
>  	u32 steps;
>  
> +	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
>  	free_irq(ts_dev->irq, ts_dev);
>  
> -- 
> 2.18.0
> 

-- 
Dmitry
