Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9448FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A44220666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="czXpoDPy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="czXpoDPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A44220666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeJBWFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:05:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeJBWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:05:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A917360818; Tue,  2 Oct 2018 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538493683;
        bh=k8ml4og2ShEOiCeC0Tzue6zXzk5Sef1UtHUdHtwdpFg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=czXpoDPyUxcaYcO/tNzmyF02GjpeblSERVTAUSd8AFWQNqypT/soge/KGUF+rARQM
         xqbq8Y69rKgamQoXLUIEomDA5QDAVwC9+BkSqutZT2JxMNRXd0QtFOSl2MFye1awEX
         xXE2XnsFD5iv3h4lMGiGQl0/F50lsrnWS3iVGE1w=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83E0160818;
        Tue,  2 Oct 2018 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538493683;
        bh=k8ml4og2ShEOiCeC0Tzue6zXzk5Sef1UtHUdHtwdpFg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=czXpoDPyUxcaYcO/tNzmyF02GjpeblSERVTAUSd8AFWQNqypT/soge/KGUF+rARQM
         xqbq8Y69rKgamQoXLUIEomDA5QDAVwC9+BkSqutZT2JxMNRXd0QtFOSl2MFye1awEX
         xXE2XnsFD5iv3h4lMGiGQl0/F50lsrnWS3iVGE1w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83E0160818
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v4 3/3] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@kernel.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20181002140858.16833-1-ricardo.ribalda@gmail.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <d1bbafcb-1b6a-b137-1fd1-954c17e14836@codeaurora.org>
Date:   Tue, 2 Oct 2018 09:21:22 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002140858.16833-1-ricardo.ribalda@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2018 8:08 AM, Ricardo Ribalda Delgado wrote:
> Current code assumes that the direction is input if direction_input
> function is set.
> This might not be the case on GPIOs with programmable direction.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

I'll try to get this series tested on QDF2400 by the end of the week.

> ---
> Changelog v4:
> 
> timur@kernel.org:
> Remove REVISIT comment
> 
>   drivers/gpio/gpiolib.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 6925196136ce..cad859fece65 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1344,20 +1344,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
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
> @@ -1374,6 +1360,19 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
>   	if (status)
>   		goto err_remove_irqchip_mask;
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
>   	status = gpiochip_add_irqchip(chip, lock_key, request_key);
>   	if (status)
>   		goto err_remove_chip;
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
