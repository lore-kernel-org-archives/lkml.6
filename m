Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E7C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D5D20881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKrwRJ1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D5D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbeLBP4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLBP4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 10:56:13 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410A220851;
        Sun,  2 Dec 2018 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543766171;
        bh=kfB2CwL9PDdYHtwon+GTQVTrdrxlsRJSWRgVA7YykFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MKrwRJ1j6tzrMmZRa6WwbzonlI19f4TBZBYFbXa/x3nPSaypK/704MrbmqaRQjypi
         +ra+1tmc46bL6U4Q2mwBA4/u9vbkQaeByOPnu4oT47ItgZ4Cz9fFg8iQW6dOMp4YsJ
         xbbE2kKUQIETFrcCgcsRL1ZR7aRo1ZIuryAS4uF8=
Date:   Sun, 2 Dec 2018 15:56:06 +0000
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
Subject: Re: [PATCH v5 02/15] platform/x86: intel_cht_int33fe: Accept errors
 of i2c_acpi_new_device()
Message-ID: <20181202155606.16b55703@archlinux>
In-Reply-To: <20181128114535.80223-3-andriy.shevchenko@linux.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
        <20181128114535.80223-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 13:45:22 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In the future i2c_acpi_new_device() will return error pointer in some cases.
> Prepare intel_cht_int33fe driver to support that.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Really trivial comment inline.  I haven't checked back to see if there
has been any previous discussion on that bit of code.

Otherwise looks sensible to me.

Jonathan



> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 28 +++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 431151d4e611..367d6e304ade 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -168,8 +168,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>  		board_info.dev_name = "max17047";
>  		board_info.properties = max17047_props;
>  		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
> -		if (!data->max17047)
> -			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
> +		if (IS_ERR(data->max17047))
> +			ret = PTR_ERR(data->max17047);
Every so slightly nicer to just return directly in these error cases?
> +		else if (!data->max17047)
> +			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
> +		else
> +			ret = 0;

Particularly so as then you don't need to set this ret as it's set in all
paths where it is used below anyway...

> +		if (ret)
> +			return ret;
>  	}
>  
>  	data->connections[0].endpoint[0] = "port0";
> @@ -194,7 +200,13 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>  	board_info.irq = fusb302_irq;
>  
>  	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
> -	if (!data->fusb302)
> +	if (IS_ERR(data->fusb302))
> +		ret = PTR_ERR(data->fusb302);
> +	else if (!data->fusb302)
> +		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
> +	else
> +		ret = 0;
> +	if (ret)
>  		goto out_unregister_max17047;
>  
>  	memset(&board_info, 0, sizeof(board_info));
> @@ -202,7 +214,13 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>  	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
>  
>  	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
> -	if (!data->pi3usb30532)
> +	if (IS_ERR(data->pi3usb30532))
> +		ret = PTR_ERR(data->pi3usb30532);
> +	else if (!data->pi3usb30532)
> +		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
> +	else
> +		ret = 0;
> +	if (ret)
>  		goto out_unregister_fusb302;
>  
>  	platform_set_drvdata(pdev, data);
> @@ -217,7 +235,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>  
>  	device_connections_remove(data->connections);
>  
> -	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
> +	return ret;
>  }
>  
>  static int cht_int33fe_remove(struct platform_device *pdev)

