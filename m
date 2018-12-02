Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE3EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 16:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811A520881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 16:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD0xg3j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811A520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLBQfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 11:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeLBQfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 11:35:50 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88A3120851;
        Sun,  2 Dec 2018 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543768548;
        bh=XHnFZUzjikEIzswR+pgNBqgCDVe7JPz4x+V1pDPjkwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dD0xg3j3AmKPqEGv5ug4VKmH/rWuZEuD4K1QHObwMwvPOVgKaiBlLTxS9pGeVhXrU
         LtMkBzTjUhPwLHdZ41vqyMM/H/HETI9XsWEcsIre/5ufd86sFhglusPqCrCGP8Hgab
         kHoJF23OtPf4CMl0rybjskcJz/iZYgRMXk4hx6KI=
Date:   Sun, 2 Dec 2018 16:35:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/15] platform/x86: intel_cht_int33fe: Get rid of
 obsolete conditional
Message-ID: <20181202163543.39933073@archlinux>
In-Reply-To: <20181128114535.80223-7-andriy.shevchenko@linux.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
        <20181128114535.80223-7-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 13:45:26 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Now, when i2c_acpi_new_device() never returns NULL, there is no point to check
> for it. Besides that, i2c_acpi_new_device() returns -EPROBE_DEFER directly and
> caller doesn't need to guess is better.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Ah, the code I commented on earlier goes away anyway.  Not to worry then!

Jonathan

> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 367d6e304ade..616b8853a91f 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -169,13 +169,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>  		board_info.properties = max17047_props;
>  		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
>  		if (IS_ERR(data->max17047))
> -			ret = PTR_ERR(data->max17047);
> -		else if (!data->max17047)
> -			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
> -		else
> -			ret = 0;
> -		if (ret)
> -			return ret;
> +			return PTR_ERR(data->max17047);
>  	}
>  
>  	data->connections[0].endpoint[0] = "port0";
> @@ -200,28 +194,20 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>  	board_info.irq = fusb302_irq;
>  
>  	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
> -	if (IS_ERR(data->fusb302))
> +	if (IS_ERR(data->fusb302)) {
>  		ret = PTR_ERR(data->fusb302);
> -	else if (!data->fusb302)
> -		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
> -	else
> -		ret = 0;
> -	if (ret)
>  		goto out_unregister_max17047;
> +	}
>  
>  	memset(&board_info, 0, sizeof(board_info));
>  	board_info.dev_name = "pi3usb30532";
>  	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
>  
>  	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
> -	if (IS_ERR(data->pi3usb30532))
> +	if (IS_ERR(data->pi3usb30532)) {
>  		ret = PTR_ERR(data->pi3usb30532);
> -	else if (!data->pi3usb30532)
> -		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
> -	else
> -		ret = 0;
> -	if (ret)
>  		goto out_unregister_fusb302;
> +	}
>  
>  	platform_set_drvdata(pdev, data);
>  

