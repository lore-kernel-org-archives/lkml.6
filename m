Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36331C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10E721783
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547121754;
	bh=wl7w4ILeytw2T1W1IfyV7T/7MtKx8iAJk4i8gklPMjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qM4RZlR5jegg3uLg54W8YQ/t0thNDGGGpeMfUSiLZ0ovpqLOszzPbqSb6wdNc2iJE
	 ZoK3MbBd+RYJ120mtePKP0UYEgsHJIpreBgrJUH3hvhOHvOBFCm+Fqsjcppp7N0x4n
	 OPYbV9/s0k8rOUZJX6iwyoUwRCt0Us+cJIMToBqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfAJMCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:02:33 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43050 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfAJMCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:02:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so8082417lff.10;
        Thu, 10 Jan 2019 04:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FfPic8K1SjxZf9AKhGO/Zg3kvZjFTXQnItiVNIW+L08=;
        b=bHu+5QRI35+OBDzkXTe0nF0gmRDUosRt6+4axlG5yYKiuEZXlnD47K63RWmxex2L5I
         N9RF59PBpn7zLbeHKSBT5ZJ/1UDPH4VLAQ2NugwigTnJ/mnpe1eqjWbmQEFkFqJQTnAH
         xWgC2N2Gl74TT/h+ONSOwngNde17gufJKo4/vEwm7WmOF8nKRNzSWKDJQetkCuwP0oeg
         BcxMrT5AwzCUNIVk4xn9Dwd4ODNVstPNNABecqeKzQuQdvX6p5fFUSIKfSc4J58DYPK5
         tBuAL15B6h0oVpkE6dhwqVkB0NyJ3CkeuAXnKLxFoF6+e1PhRKlqT22RPQ8ePZpUtZP8
         LDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FfPic8K1SjxZf9AKhGO/Zg3kvZjFTXQnItiVNIW+L08=;
        b=d2JV5SzPzONX+kcOMUpBFPSMQ6Xe24DAqCBFg1IBKRPzufJ+bWtvlLC9vJIOmfzrDZ
         LMeTninyqcnHizH9n4tJbfwiExbYoDBQOZgettPX5yY4Tv754ixTFb89DL93UN88fIG4
         gNd3YOFm0UiBavTxWBLQLqirARXLJnoWreRqugs2gYDvA1dvNZclNG73l9YU0ewgIY4K
         b2GtSkf6xTHS42NcC1lsE0JN4G/Xuyt+ubnczleaQE/ugWb0XWSkb3st88SKT++kKqIG
         ARjZxu/uP/YdZqCwi0g9i+eNo+SwveeOQNwIK2CfWP5zUykAV/FG6S67WeCZFBa5FMIz
         8CSA==
X-Gm-Message-State: AJcUukeHBoSJyHK4PawRi0Glzs/4bIgDYwA/btdAnQD491kh+/uOow9L
        Nzhwuu2T0Kx2RmzsnXSGXwA=
X-Google-Smtp-Source: ALg8bN4CH4ka0vKvQt5fOdKT559QejkHt0hNcA3NH/phjiBX9GeZVx10HavYchIlbWTFriLN+V0V2Q==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr5911233lfl.129.1547121750057;
        Thu, 10 Jan 2019 04:02:30 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d5sm14052501lfi.65.2019.01.10.04.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:02:29 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghZ2a-0002gM-Kx; Thu, 10 Jan 2019 13:02:28 +0100
Date:   Thu, 10 Jan 2019 13:02:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 1/5] gnss: sirf: write data to gnss only when the gnss
 device is open
Message-ID: <20190110120228.GB3430@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
 <20181209195150.5192-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209195150.5192-2-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 08:51:46PM +0100, Andreas Kemnade wrote:
> The api forbids writing data there otherwise. Prepare for the
> serdev_open()/close() being a part of runtime pm.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
>  add locking
> 
>  drivers/gnss/sirf.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index 2c22836d3ffd..ba663de1db49 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -35,6 +35,12 @@ struct sirf_data {
>  	struct gpio_desc *wakeup;
>  	int irq;
>  	bool active;
> +	/*
> +	 * There might be races between returning data and closing the gnss
> +	 * device.
> +	 */

Please drop this comment, which is too verbose. The mutex protects the
opened flag, and that could be indicated using a new line above the
mutex and below the flag, or using a short comment before the mutex.

> +	struct mutex gdev_mutex;

Please rename "mutex". We should be able to reuse this for the serdev
open count as well, right?

> +	bool opened;

Rename "open" (i.e. same tense as "active").

And just add a newline here too.

>  	wait_queue_head_t power_wait;
>  };
>  
> @@ -44,6 +50,7 @@ static int sirf_open(struct gnss_device *gdev)
>  	struct serdev_device *serdev = data->serdev;
>  	int ret;
>  
> +	data->opened = true;

Always hold the mutex when manipulating the open flag so we don't have
to worry about ordering issues.

>  	ret = serdev_device_open(serdev);
>  	if (ret)
>  		return ret;
> @@ -55,6 +62,7 @@ static int sirf_open(struct gnss_device *gdev)
>  	if (ret < 0) {
>  		dev_err(&gdev->dev, "failed to runtime resume: %d\n", ret);
>  		pm_runtime_put_noidle(&serdev->dev);
> +		data->opened = false;

And to avoid problems on error paths.

>  		goto err_close;
>  	}
>  
> @@ -74,6 +82,9 @@ static void sirf_close(struct gnss_device *gdev)
>  	serdev_device_close(serdev);
>  
>  	pm_runtime_put(&serdev->dev);

Add a newline here.

> +	mutex_lock(&data->gdev_mutex);
> +	data->opened = false;
> +	mutex_unlock(&data->gdev_mutex);
>  }
>  
>  static int sirf_write_raw(struct gnss_device *gdev, const unsigned char *buf,
> @@ -105,8 +116,22 @@ static int sirf_receive_buf(struct serdev_device *serdev,
>  {
>  	struct sirf_data *data = serdev_device_get_drvdata(serdev);
>  	struct gnss_device *gdev = data->gdev;
> +	int ret = 0;
> +
> +	/*
> +	 * we might come here everytime when runtime is resumed
> +	 * and data is received. Two cases are possible
> +	 * 1. device is opened during initialisation
> +	 * 2. kernel is compiled without runtime pm
> +	 *    and device is opened all the time
> +	 */

This comments makes little sense with the current code. Please remove.

> +	mutex_lock(&data->gdev_mutex);
> +	if (data->opened)
> +		ret = gnss_insert_raw(gdev, buf, count);
>  

No new line (or add one after mutex_lock() above).

> -	return gnss_insert_raw(gdev, buf, count);
> +	mutex_unlock(&data->gdev_mutex);
> +
> +	return ret;
>  }
>  
>  static const struct serdev_device_ops sirf_serdev_ops = {
> @@ -275,6 +300,7 @@ static int sirf_probe(struct serdev_device *serdev)
>  	data->serdev = serdev;
>  	data->gdev = gdev;
>  
> +	mutex_init(&data->gdev_mutex);
>  	init_waitqueue_head(&data->power_wait);
>  
>  	serdev_device_set_drvdata(serdev, data);

Johan
