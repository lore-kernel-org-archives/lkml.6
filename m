Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4E8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323B4208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KU5s3bBy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N1K3eYRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323B4208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbeJEXRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:17:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbeJEXRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:17:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E378660C67; Fri,  5 Oct 2018 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538756280;
        bh=jz3qw9RDsrEcd7fAVaj7VEtNs9pDSKtUdoUSu2jwhYk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=KU5s3bByH71iwN6MWTblzigE3ze4EQueN2tbt8U48cTJYscnFYcmTQ8Dtx07zjC5e
         dDaAnnn/bwZElbMo5AR0oz0QzuIw+iRzCYP0Xz4mg0CpyBkpFfNdKMQLQ4k3fU5isq
         6yjjvO4MOVeeAeAyFmBlHyyPxEwiWJdr4LFrhIVs=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B157460C67;
        Fri,  5 Oct 2018 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538756277;
        bh=jz3qw9RDsrEcd7fAVaj7VEtNs9pDSKtUdoUSu2jwhYk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=N1K3eYRlbrUJMTa6SakErc9y6UFeMjCZlTthiPFJuxauj+TnlpN1yOc1b5s3ej1yV
         w9qdhbhh6rSogj5WwEGmRAeJMcVMQXvMD5fNB55Bj9FNVsirwzess7MzRqCiu5IS56
         /+hTxQChZIPZxT/OVjWOM8NS62vdz2DIE4PDdHOw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B157460C67
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v5 3/3] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
 <20181005065300.22882-3-ricardo.ribalda@gmail.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <8d10f9b4-7ea9-7d27-478a-39982ba49587@codeaurora.org>
Date:   Fri, 5 Oct 2018 10:17:55 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005065300.22882-3-ricardo.ribalda@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2018 12:53 AM, Ricardo Ribalda Delgado wrote:
> Current code assumes that the direction is input if direction_input
> function is set.
> This might not be the case on GPIOs with programmable direction.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>   drivers/gpio/gpiolib.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 907019b67a58..e016b22658ff 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1349,20 +1349,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
>   
>   	spin_unlock_irqrestore(&gpio_lock, flags);
>   
> -	for (i = 0; i < chip->ngpio; i++) {
> -		struct gpio_desc *desc = &gdev->descs[i];
> -
> -		desc->gdev = gdev;
> -
> -		/* REVISIT: most hardware initializes GPIOs as inputs (often
> -		 * with pullups enabled) so power usage is minimized. Linux
> -		 * code should set the gpio direction first thing; but until
> -		 * it does, and in case chip->get_direction is not set, we may
> -		 * expose the wrong direction in sysfs.
> -		 */
> -		desc->flags = !chip->direction_input ? (1 << FLAG_IS_OUT) : 0;
> -	}
> -
>   #ifdef CONFIG_PINCTRL
>   	INIT_LIST_HEAD(&gdev->pin_ranges);
>   #endif
> @@ -1391,6 +1377,19 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
>   	if (status)
>   		goto err_remove_chip;
>   
> +	for (i = 0; i < chip->ngpio; i++) {
> +		struct gpio_desc *desc = &gdev->descs[i];
> +
> +		desc->gdev = gdev;
> +
> +		if (chip->get_direction && gpiochip_line_is_valid(chip, i))
> +			desc->flags = !chip->get_direction(chip, i) ?
> +					(1 << FLAG_IS_OUT) : 0;
> +		else
> +			desc->flags = !chip->direction_input ?
> +					(1 << FLAG_IS_OUT) : 0;
> +	}
> +
>   	acpi_gpiochip_add(chip);
>   
>   	machine_gpiochip_add(chip);
> 

We have a successful boot this time.

Timur I see:
ubuntu@ubuntu:~$ dmesg | grep gpio
[    7.388887] gpiochip_find_base: found new base at 362
[    7.433186] gpio gpiochip0: (QCOM8002:00): added GPIO chardev (254:0)
[    7.433218] gpiochip_setup_dev: registered GPIOs 362 to 511 on 
device: gpiochip0 (QCOM8002:00)
[    7.433222] gpio gpiochip0: (QCOM8002:00): created GPIO range 0->149 
==> QCOM8002:00 PIN 0->149

Looks like the driver is initing just fine to me.  Is setting up the 
jumpers and running gpio-test warranted?

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
