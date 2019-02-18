Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2F9C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728C8217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNtmHRp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390581AbfBRQ5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:57:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37942 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733069AbfBRQ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:57:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id v26so17832282wmh.3;
        Mon, 18 Feb 2019 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Te/+py7/8j9kLxPbLdOqa2CQTZpN9pqS5WYOYHf4nJg=;
        b=cNtmHRp7rXeg9Ep48gVhu8ZlNBoWHN1JTWGcm9qhMrqoV8kBIEtvl1/9vMo6vX2738
         Y4/Wrj646OoCw3I1fx3cSuDgcrK7B43AmCZP3ZaC93ZImw2srVfJglnTKUI3xlScIrAB
         uteGio+F1WIj9kqvfWwk1AjORAZ9V/AWZbk7VtBV1dQbvNVm4ofWqsCGRkVo1Lqca1jP
         NVtwpaJiIGFqAaHWw3+SSYCFi1iatM0tO8IuSIvax4hKRQCETOgX8qCDkkgyCPPRqHBQ
         0oDxgc5NuWlIYrROmszAO3Vdombxl+fwEGwn0To6mPJ4DgaoeF7stpy1VXl4iyIGfK65
         sz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Te/+py7/8j9kLxPbLdOqa2CQTZpN9pqS5WYOYHf4nJg=;
        b=GIU/KSe5tqjIltDRBINJTBm7AFKPFyF4AwDYnSYcyplsoBPMKDXSt6VzxXNRFC29ia
         Uo55+9WZaAPzKQQ1iU21q8VR45RIaxA1OFGsiF9fEHiZgPYCl06PLCOkARCp1i2fng3d
         54r0qc54BsiZkEV8DOZ8Onn7r8nVnv4dURb3/o79/oqposCWwZ+sA8rO9LLKxKg/kD8x
         0Z5Z5SeIZJf7tS/dfI+5nO5DPMr4EuThwKtAx//u3fbazWjyuVcAPLK69iczFAEjVUbT
         b68Lh+KqwhX4hgGOBuWUyRqvKI49jrnOQBbg6omls1bHJHuAAjsTIOc7JOYKXfYIsmgi
         b/CQ==
X-Gm-Message-State: AHQUAuYjCLzHXKZVnKvDBvp18VX6KR68E0uTVg3d4/LrZg9zlsosfZWx
        nEJVgJOSoRygnc088Xm/wfg=
X-Google-Smtp-Source: AHgI3Iam1UNgqaSdUK1u9wD3MUMnBvJwgCAw9PzzE5b4ZxeIKU1TqE/XE7HuZ/dtFRNGP1c34vu6Og==
X-Received: by 2002:a1c:740d:: with SMTP id p13mr17707006wmc.46.1550509032980;
        Mon, 18 Feb 2019 08:57:12 -0800 (PST)
Received: from debian64.daheim (p4FD09F2C.dip0.t-ipconnect.de. [79.208.159.44])
        by smtp.gmail.com with ESMTPSA id 184sm19291828wmz.18.2019.02.18.08.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 08:57:12 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.92-RC6)
        (envelope-from <chunkeey@gmail.com>)
        id 1gvmEB-0002ap-Ix; Mon, 18 Feb 2019 17:57:11 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 4.14 62/62] pinctrl: msm: fix gpio-hog related boot issues
Date:   Mon, 18 Feb 2019 17:57:11 +0100
Message-ID: <4323375.xCQYxFPVKo@debian64>
In-Reply-To: <20190218133511.112652987@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org> <20190218133511.112652987@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 18, 2019 2:44:08 PM CET Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 


Wait! There's a problem! This patch "alone" is not enough to fix "the gpio-hog
kills system" bug. The series also included the necessary dts change:

"[v6,2/2] ARM: dts: qcom: add gpio-ranges property"
<https://patchwork.kernel.org/patch/10432105/>

This patch is still set to "Awaiting upstream". But, from what I can tell
"linux-arm-msm" is the upstream, right?

Anyway we had this discussion before:
<https://www.spinics.net/lists/stable-commits/msg95383.html>
But I don't have a long enough "poking tool" you speak of to do
anything about it.

So @Amit / @greg : can you please poke Andy about it?

Note 2:
The series also included a dt-binding patch:
"[v6,1/2] dt-bindings: pinctrl: qcom: add gpio-ranges, gpio-reserved-ranges"
<https://patchwork.kernel.org/patch/10431593/> 

which made its way (with the same changes as the 2/2 patch) upstream.
commit c1e802f68ca0 ("dt-bindings: pinctrl: qcom: add gpio-ranges, gpio-reserved-ranges")

Cheers,
Christian

> ------------------
> 
> From: Christian Lamparter <chunkeey@gmail.com>
> 
> commit a86caa9ba5d70696ceb35d1d39caa20d8b641387 upstream.
> 
> Sven Eckelmann reported an issue with the current IPQ4019 pinctrl.
> Setting up any gpio-hog in the device-tree for his device would
> "kill the bootup completely":
> 
> | [    0.477838] msm_serial 78af000.serial: could not find pctldev for node /soc/pinctrl@1000000/serial_pinmux, deferring probe
> | [    0.499828] spi_qup 78b5000.spi: could not find pctldev for node /soc/pinctrl@1000000/spi_0_pinmux, deferring probe
> | [    1.298883] requesting hog GPIO enable USB2 power (chip 1000000.pinctrl, offset 58) failed, -517
> | [    1.299609] gpiochip_add_data: GPIOs 0..99 (1000000.pinctrl) failed to register
> | [    1.308589] ipq4019-pinctrl 1000000.pinctrl: Failed register gpiochip
> | [    1.316586] msm_serial 78af000.serial: could not find pctldev for node /soc/pinctrl@1000000/serial_pinmux, deferring probe
> | [    1.322415] spi_qup 78b5000.spi: could not find pctldev for node /soc/pinctrl@1000000/spi_0_pinmux, deferri
> 
> This was also verified on a RT-AC58U (IPQ4018) which would
> no longer boot, if a gpio-hog was specified. (Tried forcing
> the USB LED PIN (GPIO0) to high.).
> 
> The problem is that Pinctrl+GPIO registration is currently
> peformed in the following order in pinctrl-msm.c:
> 	1. pinctrl_register()
> 	2. gpiochip_add()
> 	3. gpiochip_add_pin_range()
> 
> The actual error code -517 == -EPROBE_DEFER is coming from
> pinctrl_get_device_gpio_range(), which is called through:
>         gpiochip_add
>             of_gpiochip_add
>                 of_gpiochip_scan_gpios
>                     gpiod_hog
>                         gpiochip_request_own_desc
>                             __gpiod_request
>                                 chip->request
>                                     gpiochip_generic_request
>                                        pinctrl_gpio_request
>                                           pinctrl_get_device_gpio_range
> 
> pinctrl_get_device_gpio_range() is unable to find any valid
> pin ranges, since nothing has been added to the pinctrldev_list yet.
> so the range can't be found, and the operation fails with -EPROBE_DEFER.
> 
> This patch fixes the issue by adding the "gpio-ranges" property to
> the pinctrl device node of all upstream Qcom SoC. The pin ranges are
> then added by the gpio core.
> 
> In order to remain compatible with older, existing DTs (and ACPI)
> a check for the "gpio-ranges" property has been added to
> msm_gpio_init(). This prevents the driver of adding the same entry
> to the pinctrldev_list twice.
> 
> Reported-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
> Tested-by: Sven Eckelmann <sven.eckelmann@openmesh.com> [ipq4019]
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c |   23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -839,11 +839,24 @@ static int msm_gpio_init(struct msm_pinc
>  		return ret;
>  	}
>  
> -	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
> -	if (ret) {
> -		dev_err(pctrl->dev, "Failed to add pin range\n");
> -		gpiochip_remove(&pctrl->chip);
> -		return ret;
> +	/*
> +	 * For DeviceTree-supported systems, the gpio core checks the
> +	 * pinctrl's device node for the "gpio-ranges" property.
> +	 * If it is present, it takes care of adding the pin ranges
> +	 * for the driver. In this case the driver can skip ahead.
> +	 *
> +	 * In order to remain compatible with older, existing DeviceTree
> +	 * files which don't set the "gpio-ranges" property or systems that
> +	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
> +	 */
> +	if (!of_property_read_bool(pctrl->dev->of_node, "gpio-ranges")) {
> +		ret = gpiochip_add_pin_range(&pctrl->chip,
> +			dev_name(pctrl->dev), 0, 0, chip->ngpio);
> +		if (ret) {
> +			dev_err(pctrl->dev, "Failed to add pin range\n");
> +			gpiochip_remove(&pctrl->chip);
> +			return ret;
> +		}
>  	}
>  
>  	ret = gpiochip_irqchip_add(chip,
> 
> 
> 



