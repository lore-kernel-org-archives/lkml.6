Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12A52086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547318025;
	bh=S41U4c+3kwO7mI53EVF66x9cJRkL93sNj00G2x4p4FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Kf4XP/2o6UAjZFXVrtyTS7W01FAfH8DdMP6m0WAMF4G9Qj6Pakth56TcEoUcLjube
	 8/bzdPYs8RzeIbMhYeNFtrjZo3dE0IIMIu4ubRlZ1+rG2b5DTRQ4jV98R+/vH4GrCr
	 yHurHMtP8pyAHdIsZsmRh6urFfZgG+Kml7mbOR1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfALSdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:33:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfALSdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:33:43 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CF42084C;
        Sat, 12 Jan 2019 18:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547318022;
        bh=S41U4c+3kwO7mI53EVF66x9cJRkL93sNj00G2x4p4FY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KAxLlZ8ouVtxe5V3ZcOOyLrSdf3sYNdfDE7tEz54+MacfZCTx+kSyp30O8R9g2yHF
         WQVx3mHuWKtznaTd0mnncq/yVZ7oH7YYTY+fLSZwNPgUt0mBxBzYD7WYa4L+59pdOv
         XV2QJhg8v/jGfl6Gmli5qlqO4dkMH9Mj52FXF2qk=
Date:   Sat, 12 Jan 2019 18:33:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v3 3/3] iio: ti-ads8688: Update buffer allocation for
 timestamps
Message-ID: <20190112183338.59076438@archlinux>
In-Reply-To: <20190111195707.2086-3-dmurphy@ti.com>
References: <20190111195707.2086-1-dmurphy@ti.com>
        <20190111195707.2086-3-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 13:57:07 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Per Jonathan Cameron, the buffer needs to allocate room for a
> 64 bit timestamp as well as the channels.  Change the buffer
> to allocate this additional space.
> 
> Fixes: 2a86487786b5c ("iio: adc: ti-ads8688: add trigger and buffer support")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
Thanks for fixing this up!

Jonathan

> ---
> 
> v3 - Updated the buffer allocation definition I also dropped the device managed
> patch as I don't have time to invest in that code - https://lore.kernel.org/patchwork/patch/1023971/
> v2 - New patch suggested change by maintainer - https://lore.kernel.org/patchwork/patch/1021048/
> 
>  drivers/iio/adc/ti-ads8688.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index 184d686ebd99..8b4568edd5cb 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -41,6 +41,7 @@
>  
>  #define ADS8688_VREF_MV			4096
>  #define ADS8688_REALBITS		16
> +#define ADS8688_MAX_CHANNELS		8
>  
>  /*
>   * enum ads8688_range - ADS8688 reference voltage range
> @@ -385,7 +386,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> -	u16 buffer[8];
> +	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
>  	int i, j = 0;
>  
>  	for (i = 0; i < indio_dev->masklength; i++) {

