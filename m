Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E60BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07E82075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0+O60GR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07E82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966606AbeFSPLZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:11:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36370 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966525AbeFSPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:11:22 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so8707pgd.3;
        Tue, 19 Jun 2018 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oaY2Ks01ZL29mhNUkiUh/ykrjN613PqIXyVV+cYk2wU=;
        b=X0+O60GRl0ynJ/tif3Y8DJDkjMkNmvtkzU9C3aMseGtGYJmHufH2JSltOCjeqDUMe6
         1jHk8kKoz08rpqTREHQfcar1RYAasNw1tZkwXNfborUOBIBB9b4fDgACYCg7uFuXpeZH
         3VdQ9rozFnD0K80SzNdpG23TgTPOHt1MEvOy2hb/FLa1MlyV6XDxJ70ItecUXD/8bgaU
         nCe/78Wkw9adZet0JqHY3SJjcykpC3cUQkjm89gX0Y4U6W29KDf5fQLoVTIjQWz/Pt+t
         jdCSmIdffPl9T2WVdevCU0JutvSf/PhxeMrZ0SXqy6/KRDFU1uTd3O1kaIUdua8OPSUG
         l0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oaY2Ks01ZL29mhNUkiUh/ykrjN613PqIXyVV+cYk2wU=;
        b=nYDBzO/RR8CYwhP8jWS6e+KCOuv3N9WmBmgqrw61GykHBYmkfP+i7rZOiwa+ndjOZf
         zF2P5ereaAWheOotH21EskbTq8QWFt1FhcMuLxyrKVLe3RrwOMw7g5wcalEpj0Ckaowu
         J4VfizKn1lF2mVXHESnQAacZXf/tnNkLsHSokMgGOisi7jaDd7+l7krq9XSK4Nxl266T
         H86rBA1SCiYov9oOzG9bpsyUez6ntii9tN2t/UmMLIJPRVGoGIswEyZokj5ROaECReXc
         5X3sNyxMOc2kmy/jKKhwXFcYa0TF0NSzhaC+Vo3NZk3ACjmEUginvV1L2HRVWJK/NUfH
         xxAw==
X-Gm-Message-State: APt69E1fV0dzSkXhQp+47dMw/68JAus2f9K+4OsFVWMyF1WF0fowpoaW
        fI0SmXz2L24Rl7c/JBbc1WE=
X-Google-Smtp-Source: ADUXVKL/XzwGW108H0Wwl9+Lxhm1LH3yHWV8rhwwXsxJHKpV8Jncmdtt7zWR7r2acWF44si4vJ3C8w==
X-Received: by 2002:a63:5f0b:: with SMTP id t11-v6mr15124161pgb.79.1529421082067;
        Tue, 19 Jun 2018 08:11:22 -0700 (PDT)
Received: from [192.168.43.210] (mobile-166-137-178-150.mycingular.net. [166.137.178.150])
        by smtp.gmail.com with ESMTPSA id z12-v6sm10715837pgu.57.2018.06.19.08.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 08:11:21 -0700 (PDT)
Subject: Re: [PATCH] of/platform: add initcall_debug logs for device creates
To:     Todd Poynor <toddpoynor@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Poynor <toddpoynor@google.com>
References: <20180619014608.92061-1-toddpoynor@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <43fca3e7-4ba5-661f-0871-fedd9ff67673@gmail.com>
Date:   Tue, 19 Jun 2018 08:11:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619014608.92061-1-toddpoynor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todd,

On 06/18/18 18:46, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Add initcall_debug logs for the amount of time taken by each OF platform
> bus device create call.  For example:
> 
>    of platform device create /reserved-memory/ramoops@a3800000 took
>    3255 usecs
> 
> initcall_debug already reports the total of all such device creates
> as a single entry for function of_platform_default_populate_init (or
> similar, depending on the board).  The new logs help identify which of
> the potentially hundreds of device inits take significant amounts of
> time.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/of/platform.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> Note it's likely only a few devices take significant lengths of time to
> init, whereas there may be hundreds of uninteresting cases also logged.
> Adding a threshold for reporting might be desirable, although for boot
> time sleuthing it's probably fine to generate a ton of output and narrow
> down the points of interest with tools.
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 6925d993e1f0..eeb4c595f43c 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -14,6 +14,7 @@
>  #include <linux/amba/bus.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> @@ -159,6 +160,19 @@ struct platform_device *of_device_alloc(struct device_node *np,
>  }
>  EXPORT_SYMBOL(of_device_alloc);
>  
> +static void of_platform_log_inittime(struct device_node *node,
> +				     ktime_t starttime)

Please call it pr_delta_time() instead.


> +{
> +	ktime_t delta, endtime;
> +	unsigned long long duration;
> +
> +	endtime = ktime_get();
> +	delta = ktime_sub(endtime, starttime);
> +	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> +	pr_debug("of platform device create %s took %lld usecs\n",
> +		 node->full_name, duration);

The device node full_name field no longer contains the full path of
the node name.  To deal with this, use %pOF on node instead of
%s on node->full_name  (core-api/printk-formats.rst).


> +}
> +
>  /**
>   * of_platform_device_create_pdata - Alloc, initialize and register an of_device
>   * @np: pointer to node to create device for
> @@ -176,6 +190,8 @@ static struct platform_device *of_platform_device_create_pdata(
>  					struct device *parent)
>  {
>  	struct platform_device *dev;
> +	ktime_t starttime = 0;

I assume the initialization to zero is to silence a compiler warning.  Is my
assumption correct?


> +	int ret;
>  
>  	if (!of_device_is_available(np) ||
>  	    of_node_test_and_set_flag(np, OF_POPULATED))
> @@ -187,9 +203,14 @@ static struct platform_device *of_platform_device_create_pdata(
>  
>  	dev->dev.bus = &platform_bus_type;
>  	dev->dev.platform_data = platform_data;
> +	if (initcall_debug)
> +		starttime = ktime_get();
>  	of_msi_configure(&dev->dev, dev->dev.of_node);
> +	ret = of_device_add(dev);
> +	if (initcall_debug)
> +		of_platform_log_inittime(np, starttime);
>  
> -	if (of_device_add(dev) != 0) {
> +	if (ret != 0) {
>  		platform_device_put(dev);
>  		goto err_clear_flag;
>  	}
> @@ -352,6 +373,7 @@ static int of_platform_bus_create(struct device_node *bus,
>  	struct platform_device *dev;
>  	const char *bus_id = NULL;
>  	void *platform_data = NULL;
> +	ktime_t starttime = 0;
>  	int rc = 0;
>  
>  	/* Make sure it has a compatible property */
> @@ -384,7 +406,11 @@ static int of_platform_bus_create(struct device_node *bus,
>  		 * Don't return an error here to keep compatibility with older
>  		 * device tree files.
>  		 */
> +		if (initcall_debug)
> +			starttime = ktime_get();
>  		of_amba_device_create(bus, bus_id, platform_data, parent);
> +		if (initcall_debug)
> +			of_platform_log_inittime(bus, starttime);
>  		return 0;
>  	}
>  
> 

