Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046D7217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547033444;
	bh=8nQ/HIENA1bc/LnRLbCHAaCtkgLD42I2sJgt19k887M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VzRyEDvc7zimlw/LtaWXM95Hwqyf3PyegY7uD0m2QTSx2Q9bJ1XTXgaPo9sWXbsN3
	 aNGIz3oMcKLMwIpMz7VS66l7iD8n03V0avN2O4D4blkiiAWG/MNdwMzwx+2Uxk6dx/
	 sxqrq5mPRwwbHC1xsiwtzPWAjotY62F5s+0wFW1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfAILam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:30:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37596 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfAILam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:30:42 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so5377275lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5bnCElsR2YQ1UtJOKP5sc5ZGiYKE6tkungMtChwQfZQ=;
        b=OZGmTKUZo9E/nPrTg1QY7UrfKEGpHT1czaA6veFM8hFCz6gWGr9EuUmC0Baq2BY7Sm
         l1oZGsx3LB4IFX1nZzuKwpmoyCUvNmcmCW7etZHQuzpnQPoJMVW4v2kP18UdNCKgx99I
         K23yffgNhMJu27dodOGnd6q18XyPdXT8ETYHsETstctD0JMOgcBat770SiXvVTSM4IH/
         eHQOxPEwuP1quRDrXNoMU2Y01vA3qjJ4o6v8FfuE7+25ih5INy4pd71a3rWFVhkJ+GLQ
         YQJArpRl/0bWM406Wj2p5caFhiRFwjiBAH3baUAukvVBPVaaOIaoZf+DxXQKtMfnf1V+
         2dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5bnCElsR2YQ1UtJOKP5sc5ZGiYKE6tkungMtChwQfZQ=;
        b=YP1Ow/6Xu4c+WuDbrdw03sQVcxRnQf0SDbPwtRb/Xe1dThPLAWLzqUOZQxI/9b4WNX
         8qDZJHtiRinJAbuc+J/X7pPxrK8EZE4/0bg8arkWBHyr55uh0UY5sDDLRZeQrythrnL2
         /qnlGvXeuZUXeegj9ogrUqpMDERz7Dmn0kDeHCoAIRl4ObQ9jpgW5U2P7MLvMOX5458h
         ird6ftWhpmc+/KVeXo2D/AobycB98HQiHKJTqA6EBc+x8vzMksEfPYDZN3PLfyeWjg3Y
         ZQ0zSq9gyssf1vnPBH4OI11Cm6c6m3+DSqZPzP5KdbMHBvVONNB6ehJOLrVM1lWUI08p
         Omzg==
X-Gm-Message-State: AJcUukevTaNxOdmv6n6gm8EciZ6QTCyxaZ2XJCT8geBe8Sm2HzXHEFXG
        9lXfKVta22YmwIlN3RTz/FI=
X-Google-Smtp-Source: ALg8bN78qiOerfWNe9hQBKL8n/ku2kbT1J/mTu/Tdz2J6VbYY/v5XsTpT4f3hAK3GxdUaMeAb2qIFg==
X-Received: by 2002:a19:f20:: with SMTP id e32mr3368544lfi.51.1547033440224;
        Wed, 09 Jan 2019 03:30:40 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b20sm13447002lfj.61.2019.01.09.03.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 03:30:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghC4J-0008O7-0k; Wed, 09 Jan 2019 12:30:43 +0100
Date:   Wed, 9 Jan 2019 12:30:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] staging: greybus: arche-apb-ctrl.c: Switch to the
 gpio descriptor interface
Message-ID: <20190109113043.GK14782@localhost>
References: <cover.1545488665.git.nishadkamdar@gmail.com>
 <54ba56b6b071ba48ca06713a108ccfb542c5d2e5.1545488665.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ba56b6b071ba48ca06713a108ccfb542c5d2e5.1545488665.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 08:22:09PM +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v4:
>  - Use gpiod_set_raw_value() for deassert_reset() and
>    assert_reset() as gpiod_set_value() will change the
>    sematics of these calls by taking any gpio flags
>    into account.

Please also mention this in the commit message (i.e. that we continue to
ignore gpio flags from device tree for now).

>  - Remove some unnecesssary line breaks.
>  - Restore 'spi_en' gpio check in fw_flashing_seq()
>    as it is currently optional.
> Changes in v3:
>  - Add this patch in a patchset.
> Changes in v2:
>  - Resolved compilation errors.
> ---

> @@ -75,11 +74,10 @@ static int coldboot_seq(struct platform_device *pdev)
>  		return 0;
>  
>  	/* Hold APB in reset state */
> -	assert_reset(apb->resetn_gpio);
> +	assert_reset(apb->resetn);
>  
> -	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
> -	    gpio_is_valid(apb->spi_en_gpio))
> -		devm_gpio_free(dev, apb->spi_en_gpio);
> +	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING && apb->spi_en)
> +		devm_gpiod_put(dev, apb->spi_en);
>  
>  	/* Enable power to APB */
>  	if (!IS_ERR(apb->vcore)) {
> @@ -101,13 +99,13 @@ static int coldboot_seq(struct platform_device *pdev)
>  	apb_bootret_deassert(dev);
>  
>  	/* On DB3 clock was not mandatory */
> -	if (gpio_is_valid(apb->clk_en_gpio))
> -		gpio_set_value(apb->clk_en_gpio, 1);
> +	if (apb->clk_en)
> +		gpiod_set_value(apb->clk_en, 1);
>  
>  	usleep_range(100, 200);
>  
>  	/* deassert reset to APB : Active-low signal */
> -	deassert_reset(apb->resetn_gpio);
> +	deassert_reset(apb->resetn);
>  
>  	apb->state = ARCHE_PLATFORM_STATE_ACTIVE;
>  
> @@ -136,25 +134,25 @@ static int fw_flashing_seq(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (gpio_is_valid(apb->spi_en_gpio)) {
> +	if (apb->spi_en) {
>  		unsigned long flags;
>  
>  		if (apb->spi_en_polarity_high)
> -			flags = GPIOF_OUT_INIT_HIGH;
> +			flags = GPIOD_OUT_HIGH;
>  		else
> -			flags = GPIOF_OUT_INIT_LOW;
> +			flags = GPIOD_OUT_LOW;
>  
> -		ret = devm_gpio_request_one(dev, apb->spi_en_gpio,
> -					    flags, "apb_spi_en");
> -		if (ret) {
> -			dev_err(dev, "Failed requesting SPI bus en gpio %d\n",
> -				apb->spi_en_gpio);
> +		apb->spi_en = devm_gpiod_get(dev, "gb,spi-en-gpio", flags);

I just noticed that you change the name of the device-tree property here
(and later in apb_ctrl_get_devtree_data()). How is that expected to
work without breaking current systems? This will be unavoidable at some
point, but must not be snuck into a patch like this without any comment.
Please keep the current names for now.

I do think you need to drop the "-gpio" suffix when requesting the gpio
though. Please double check to make sure.

Johan
