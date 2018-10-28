Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C72EC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A265E20881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCvQhAGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A265E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJ2AUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 20:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbeJ2AUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 20:20:52 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FEE420831;
        Sun, 28 Oct 2018 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540740956;
        bh=kuR8DUI+HJ8qJke+uEiBnvTXOiALFYFsGRx2/qfiJiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JCvQhAGkcC7qNkjb/o7sDrGdVV2yPCehfWGqe4O0gj2BeFvxC4HMO7DO9Uk67tiEC
         PXLBYpjKxi9BjgMlDCaP0bgaol0rAXJMSOqiuCFeqNGFWbXHCgDhbtzgGXWDgsmSWB
         JmBYUasXQ1hgqgd9CGseau+gMyH1l9pym/UD306Y=
Date:   Sun, 28 Oct 2018 15:35:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v3 1/3] iio: adc128s052: Add pin-compatible IDs
Message-ID: <20181028153551.6f2cccac@archlinux>
In-Reply-To: <1540481742-23596-2-git-send-email-dan@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
        <1540481742-23596-1-git-send-email-dan@emutex.com>
        <1540481742-23596-2-git-send-email-dan@emutex.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 16:35:40 +0100
Dan O'Donovan <dan@emutex.com> wrote:

> From: Javier Arteaga <javier@emutex.com>
> 
> The datasheets for ADC122S021 and ADC124S021 list two more
> pin-compatible alternatives for each device.
> 
> Add their IDs as compatible strings.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  .../devicetree/bindings/iio/adc/ti-adc128s052.txt        |  9 ++++++++-
>  drivers/iio/adc/ti-adc128s052.c                          | 16 ++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> index daa2b2c..c07ce1a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> @@ -1,7 +1,14 @@
>  * Texas Instruments' ADC128S052, ADC122S021 and ADC124S021 ADC chip
>  
>  Required properties:
> - - compatible: Should be "ti,adc128s052", "ti,adc122s021" or "ti,adc124s021"
> + - compatible: Should be one of:
> +   - "ti,adc128s052"
Hmm.  Ideally I think these should be in 'alphabetical' order. However
I can see a certain logic to having the part whose name we are using for
the driver listed first..

Not important enough to change.

> +   - "ti,adc122s021"
> +   - "ti,adc122s051"
> +   - "ti,adc122s101"
> +   - "ti,adc124s021"
> +   - "ti,adc124s051"
> +   - "ti,adc124s101"
>   - reg: spi chip select number for the device
>   - vref-supply: The regulator supply for ADC reference voltage
>  
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 7cf39b3..e6716c3 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -186,15 +186,23 @@ static int adc128_remove(struct spi_device *spi)
>  static const struct of_device_id adc128_of_match[] = {
>  	{ .compatible = "ti,adc128s052", },
>  	{ .compatible = "ti,adc122s021", },
> +	{ .compatible = "ti,adc122s051", },
> +	{ .compatible = "ti,adc122s101", },
>  	{ .compatible = "ti,adc124s021", },
> -	{ /* sentinel */ },
> +	{ .compatible = "ti,adc124s051", },
> +	{ .compatible = "ti,adc124s101", },
> +	{ }
Dropping then sentinel shouldn't have occurred in this patch.
I don't really care if it is there or not personally but we shouldn't be
making changes without clear benefit.  I'll put it back.
>  };
>  MODULE_DEVICE_TABLE(of, adc128_of_match);
>  
>  static const struct spi_device_id adc128_id[] = {
> -	{ "adc128s052", 0},	/* index into adc128_config */
> -	{ "adc122s021",	1},
> -	{ "adc124s021", 2},
> +	{ "adc128s052", 0 },	/* index into adc128_config */
> +	{ "adc122s021",	1 },
> +	{ "adc122s051",	1 },
> +	{ "adc122s101",	1 },
> +	{ "adc124s021", 2 },
> +	{ "adc124s051", 2 },
> +	{ "adc124s101", 2 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adc128_id);

