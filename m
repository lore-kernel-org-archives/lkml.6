Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EEDC65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1FD2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544283158;
	bh=rCe6V2fbo7XddY4IQPET9TAbkgfxWlAfnSWZydoCxVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Mv81PCeU1cZbIJyJ3B7Tj69SPxIA2VeSJvu60R2vqSB7gL8xH0vX+Qa4RTByU8VBx
	 SxNR+usr/vmeg+mLAZXW3mCazUzcmcov9xS79rh/T+PB+V7baGTVAe1KdwHMTXRDyB
	 bqn4EmH164HTJ6YCC3eQQm4Nn0KcWWV75BySJnRw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1FD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLHPch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:32:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbeLHPch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:32:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E221C20700;
        Sat,  8 Dec 2018 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544283156;
        bh=rCe6V2fbo7XddY4IQPET9TAbkgfxWlAfnSWZydoCxVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UW2fCu+mA3sWVEB6bU9L/funy+OnjruvUZB+ZfqEM4wFF8P5Z0ShuK8OWssy2lXAN
         f/pKMmdVZ4ncXj4BLPlxu9idka57ry22m36SLjD8RKxEZuxVCwlu27FGqKOkACK2vi
         KBxsVu3EcKIYtJI1wk2O5BuU2ihsdbY/ssTUALn0=
Date:   Sat, 8 Dec 2018 15:32:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: Re: [PATCH 2/2] staging: iio: adc: ad7192: Add clock output option
Message-ID: <20181208153232.52524bae@archlinux>
In-Reply-To: <20181206091052.7644-2-mircea.caprioru@analog.com>
References: <20181206091052.7644-1-mircea.caprioru@analog.com>
        <20181206091052.7644-2-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 11:10:52 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> When using the internal clock the device has an option in which the clock
> output is available on MCLK2 pin. This patch adds a dt binding for enabling
> this property.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
I'd rather we looked at getting this out of staging, with proper binding
docs before we add too many new features, but I suppose this is small
enough that it isn't too much of a problem other that we are defining
a binding that might not go down well long term.

If nothing else we should be supporting this as a clock source
to allow it for example to be looped into another identical device
as the input.

Here we are putting it out on a pin with no 'consumers'.

Jonathan


> ---
>  drivers/staging/iio/adc/ad7192.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 8a4e6ede42b3..a11c8a82bb7c 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -611,6 +611,10 @@ static const struct iio_chan_spec ad7193_channels[] = {
>  static int ad7192_clock_select(struct spi_device *spi, struct ad7192_state *st)
>  {
>  	int ret;
> +	bool clock_out_en;
> +
> +	clock_out_en = of_property_read_bool(spi->dev.of_node,
> +					     "adi,int-clock-output-enable");
>  
>  	st->clock_sel = AD7192_CLK_EXT_MCLK2;
>  	st->mclk = devm_clk_get(&spi->dev, "clk");
> @@ -626,7 +630,10 @@ static int ad7192_clock_select(struct spi_device *spi, struct ad7192_state *st)
>  				return PTR_ERR(st->mclk);
>  
>  			/* use internal clock */
> -			st->clock_sel = AD7192_CLK_INT;
> +			if (!clock_out_en)
> +				st->clock_sel = AD7192_CLK_INT;
> +			else
> +				st->clock_sel = AD7192_CLK_INT_CO;
>  			st->fclk = AD7192_INT_FREQ_MHZ;
>  		}
>  	}

