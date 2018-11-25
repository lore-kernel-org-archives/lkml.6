Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F131C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52CB20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="advw79U+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52CB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeKYWnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeKYWnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:43:06 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B70720855;
        Sun, 25 Nov 2018 11:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543146730;
        bh=dUvu2QlLVDlHRH86+9I0kp6Tzg7FclmcjKH2FcnvQNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=advw79U+D3BR6tQnlUB4VcrVWdpyY03EtR/y1nJjJI5RZZgx/AhhwEwQz7OQvgD/L
         RtcMs2H7xJ3ILs+2DUoiWlb5WXQFcqR+AkR6ryzgFkhrul8xAA8oqmc1LRDV7tVqNw
         48Cavq6Aq5HYkKnlqZMCrK8kPKnqjHu3yEh9s+nA=
Date:   Sun, 25 Nov 2018 11:52:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] Staging: iio: adt7316: Change the name from
 irq_flags to irq_type
Message-ID: <20181125115205.2a402509@archlinux>
In-Reply-To: <20181120165836.7335-1-shreeya.patel23498@gmail.com>
References: <20181120165836.7335-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 22:28:36 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Most of the drivers in IIO uses irq_type as the name for
> storing the interrupt type and hence change the name from
> irq_flags to irq_type for maintaining the consistency.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index dfae22619287..9c72538baf9e 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2102,7 +2102,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
>  	unsigned short *adt7316_platform_data = dev->platform_data;
> -	int irq_flags = IRQF_TRIGGER_LOW;
> +	int irq_type = IRQF_TRIGGER_LOW;
>  	int ret = 0;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> @@ -2147,18 +2147,18 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  
>  	if (chip->bus.irq > 0) {
>  		if (adt7316_platform_data[0])
> -			irq_flags = adt7316_platform_data[0];
> +			irq_type = adt7316_platform_data[0];
>  
>  		ret = devm_request_threaded_irq(dev, chip->bus.irq,
>  						NULL,
>  						adt7316_event_handler,
> -						irq_flags | IRQF_ONESHOT,
> +						irq_type | IRQF_ONESHOT,
>  						indio_dev->name,
>  						indio_dev);
>  		if (ret)
>  			return ret;
>  
> -		if (irq_flags & IRQF_TRIGGER_HIGH)
> +		if (irq_type & IRQF_TRIGGER_HIGH)
>  			chip->config1 |= ADT7316_INT_POLARITY;
>  	}
>  

