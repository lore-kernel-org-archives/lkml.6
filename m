Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2EBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA53421A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1br9lJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA53421A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeHGCKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:10:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40230 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732394AbeHGCKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:10:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so13957866wrs.7;
        Mon, 06 Aug 2018 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZOcve2pj6lUDqqVbstP/7F3gcosRzvFjEZdmi/suXQ=;
        b=s1br9lJ2J/+Ie8Arn+PjXGL7/KjAwXND5A+vQ6w0A927O4LMpE6at5q2vdeMViDK+g
         pG8kz9RDvad570FDQ0RmsnlClo8Tl9SBVPI63DSdzgXX6PACURQanHBIY494FXetCPkV
         HFGoppARxt+rVn3vZBYk1T1nWieEGBC21n5+nXzkUaeuQbIU91XGESI5PiU+UBVDJM+Q
         1FL6FE9eTBR0ISnzI0Qn2ekOQ9qJ4N9wKrnM6pZIiciKx0WyKd5IHNhDutSQdQGnL9HO
         qKORDsWDMTywStWB1pDh4VLmtUuX79zvNypek8kw0UPufVFA/plqDd1UxJ9ypwy52BrW
         u7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZOcve2pj6lUDqqVbstP/7F3gcosRzvFjEZdmi/suXQ=;
        b=sxveIcpLX6m4+0dDykR916oVIPN+XSbxklWq+GATwA1MD6cKLO1QufxE8I6tnjd3sK
         GErhh5Wc7scerWnaThGTRZ58Y95IBPtY/A5D0dxT8nXNNpmpPL8iBKE43xl3f/OdH5X2
         NSjh4m5kEBZAWwZWuI6q0j7bpsYZeUk8xKpYyxIca6MRvfhUd5gYHa4uGbwwfYcGSgOs
         SqdEQzgzQU+HhncRcNlAMKs1DNnf1BQVjMboX3+cF8KW8ADw0lSgGofjSo8KwUH+NMpJ
         13/DZBxGwZcYvm7RxyTPl0+M/NR7PB1wIK/At+F1U5uYic6RqB8jLpLSvEIEzpWUCU20
         JJcQ==
X-Gm-Message-State: AOUpUlHwjvjAFXJushq/vLf+b3OVjgu6JUfzATYyA3UaJFFX3zLbUvOl
        XImVPDnAIoqW3dKOHZcxOKxSWfTc
X-Google-Smtp-Source: AAOMgpcg1IqN1iJ3m9mypU3uuIm341G+UYC6V3UdUu7jKzrOBqx/BrKYx6hf9+i+zT8CN6mNAtwSLg==
X-Received: by 2002:adf:88e3:: with SMTP id g32-v6mr10321453wrg.62.1533599917811;
        Mon, 06 Aug 2018 16:58:37 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id h17-v6sm10455046wrq.73.2018.08.06.16.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 16:58:36 -0700 (PDT)
Subject: Re: [RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for
 data read/write
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-6-jmkrzyszt@gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <f4ebe9bf-8ca8-9ad2-3e48-697266b6962b@gmail.com>
Date:   Tue, 7 Aug 2018 01:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180806222918.12644-6-jmkrzyszt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2018 12:29 AM, Janusz Krzysztofik wrote:
> Don't readw()/writew() data directly from/to GPIO port which is under
> control of gpio-omap driver, use GPIO API instead.
> 
> Degrade of performance on Amstrad Delta is completely not acceptable.

I'd expect that changing from direct PIO to access through GPIO API
would degrade the performance. Maybe I misunderstood something ?

> The driver should work with any 8+-bit bidirectional GPIO port, not
> only OMAP.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/mtd/nand/raw/ams-delta.c | 97 ++++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 09d6901fc94d..78996ddf82e0 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -24,13 +24,10 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
> -#include <linux/platform_data/gpio-omap.h>
> +#include <linux/platform_device.h>
>  
> -#include <asm/io.h>
>  #include <asm/sizes.h>
>  
> -#include <mach/hardware.h>
> -
>  /*
>   * MTD structure for E3 (Delta)
>   */
> @@ -44,7 +41,7 @@ struct ams_delta_nand {
>  	struct gpio_desc	*gpiod_nwe;
>  	struct gpio_desc	*gpiod_ale;
>  	struct gpio_desc	*gpiod_cle;
> -	void __iomem		*io_base;
> +	struct gpio_descs	*data_gpiods;
>  };
>  
>  /*
> @@ -76,10 +73,14 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
>  {
>  	struct nand_chip *this = mtd_to_nand(mtd);
>  	struct ams_delta_nand *priv = nand_get_controller_data(this);
> -	void __iomem *io_base = priv->io_base;
> +	struct gpio_descs *data_gpiods = priv->data_gpiods;
> +	unsigned long bits = byte;
> +	int i;
> +
> +	for (i = 0; i < data_gpiods->ndescs; i++)
> +		gpiod_direction_output_raw(data_gpiods->desc[i],
> +					   test_bit(i, &bits));
>  
> -	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
> -	writew(byte, this->IO_ADDR_W);
>  	gpiod_set_value(priv->gpiod_nwe, 0);
>  	ndelay(40);
>  	gpiod_set_value(priv->gpiod_nwe, 1);
> @@ -87,18 +88,28 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
>  
>  static u_char ams_delta_read_byte(struct mtd_info *mtd)
>  {
> -	u_char res;
>  	struct nand_chip *this = mtd_to_nand(mtd);
>  	struct ams_delta_nand *priv = nand_get_controller_data(this);
> -	void __iomem *io_base = priv->io_base;
> +	struct gpio_descs *data_gpiods = priv->data_gpiods;
> +	unsigned long bits = 0;
> +	int i, value_array[data_gpiods->ndescs];
> +
> +	for (i = 0; i < data_gpiods->ndescs; i++)
> +		gpiod_direction_input(data_gpiods->desc[i]);
>  
>  	gpiod_set_value(priv->gpiod_nre, 0);
>  	ndelay(40);
> -	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
> -	res = readw(this->IO_ADDR_R);
> +
> +	gpiod_get_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
> +				  value_array);
> +
>  	gpiod_set_value(priv->gpiod_nre, 1);
>  
> -	return res;
> +	for (i = 0; i < data_gpiods->ndescs; i++)
> +		if (value_array[i])
> +			__set_bit(i, &bits);
> +
> +	return bits;
>  }
>  
>  static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
> @@ -159,14 +170,8 @@ static int ams_delta_init(struct platform_device *pdev)
>  	struct ams_delta_nand *priv;
>  	struct nand_chip *this;
>  	struct mtd_info *mtd;
> -	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	void __iomem *io_base;
> -	struct gpio_descs *data_gpiods;
>  	int err = 0;
>  
> -	if (!res)
> -		return -ENXIO;
> -
>  	/* Allocate memory for MTD device structure and private data */
>  	priv = devm_kzalloc(&pdev->dev, sizeof(struct ams_delta_nand),
>  			    GFP_KERNEL);
> @@ -179,25 +184,8 @@ static int ams_delta_init(struct platform_device *pdev)
>  	mtd = nand_to_mtd(this);
>  	mtd->dev.parent = &pdev->dev;
>  
> -	/*
> -	 * Don't try to request the memory region from here,
> -	 * it should have been already requested from the
> -	 * gpio-omap driver and requesting it again would fail.
> -	 */
> -
> -	io_base = ioremap(res->start, resource_size(res));
> -	if (io_base == NULL) {
> -		dev_err(&pdev->dev, "ioremap failed\n");
> -		err = -EIO;
> -		goto out_free;
> -	}
> -
> -	priv->io_base = io_base;
>  	nand_set_controller_data(this, priv);
>  
> -	/* Set address of NAND IO lines */
> -	this->IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
> -	this->IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
>  	this->read_byte = ams_delta_read_byte;
>  	this->write_buf = ams_delta_write_buf;
>  	this->read_buf = ams_delta_read_buf;
> @@ -207,7 +195,7 @@ static int ams_delta_init(struct platform_device *pdev)
>  	if (IS_ERR(priv->gpiod_rdy)) {
>  		err = PTR_ERR(priv->gpiod_rdy);
>  		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
> -		goto out_mtd;
> +		return err;
>  	}
>  
>  	if (priv->gpiod_rdy)
> @@ -225,66 +213,60 @@ static int ams_delta_init(struct platform_device *pdev)
>  	if (IS_ERR(priv->gpiod_nwp)) {
>  		err = PTR_ERR(priv->gpiod_nwp);
>  		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
> -		goto out_mtd;
> +		return err;
>  	}
>  
>  	priv->gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
>  	if (IS_ERR(priv->gpiod_nce)) {
>  		err = PTR_ERR(priv->gpiod_nce);
>  		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
> -		goto out_mtd;
> +		return err;
>  	}
>  
>  	priv->gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
>  	if (IS_ERR(priv->gpiod_nre)) {
>  		err = PTR_ERR(priv->gpiod_nre);
>  		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
> -		goto out_mtd;
> +		return err;
>  	}
>  
>  	priv->gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
>  	if (IS_ERR(priv->gpiod_nwe)) {
>  		err = PTR_ERR(priv->gpiod_nwe);
>  		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
> -		goto out_mtd;
> +		return err;
>  	}
>  
>  	priv->gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
>  	if (IS_ERR(priv->gpiod_ale)) {
>  		err = PTR_ERR(priv->gpiod_ale);
>  		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
> -		goto out_mtd;
> +		return err;
>  	}
>  
>  	priv->gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
>  	if (IS_ERR(priv->gpiod_cle)) {
>  		err = PTR_ERR(priv->gpiod_cle);
>  		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
> -		goto out_mtd;
> +		return err;
>  	}
>  	/* Request array of data pins, initialize them as input */
> -	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
> -	if (IS_ERR(data_gpiods)) {
> -		err = PTR_ERR(data_gpiods);
> +	priv->data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
> +	if (IS_ERR(priv->data_gpiods)) {
> +		err = PTR_ERR(priv->data_gpiods);
>  		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
> -		goto out_mtd;
> +		return err;
>  	}
>  
>  	/* Scan to find existence of the device */
>  	err = nand_scan(mtd, 1);
>  	if (err)
> -		goto out_mtd;
> +		return err;
>  
>  	/* Register the partitions */
>  	mtd_device_register(mtd, partition_info, ARRAY_SIZE(partition_info));
>  
> -	goto out;
> -
> - out_mtd:
> -	iounmap(io_base);
> -out_free:
> - out:
> -	return err;
> +	return 0;
>  }
>  
>  /*
> @@ -294,13 +276,10 @@ static int ams_delta_cleanup(struct platform_device *pdev)
>  {
>  	struct ams_delta_nand *priv = platform_get_drvdata(pdev);
>  	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
> -	void __iomem *io_base = priv->io_base;
>  
> -	/* Release resources, unregister device */
> +	/* Unregister device */
>  	nand_release(mtd);
>  
> -	iounmap(io_base);
> -
>  	return 0;
>  }
>  
> 


-- 
Best regards,
Marek Vasut
