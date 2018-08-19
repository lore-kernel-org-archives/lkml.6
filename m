Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2799C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2523B208AC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvLqJG8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2523B208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeHSUHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 16:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeHSUHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 16:07:02 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7481208AC;
        Sun, 19 Aug 2018 16:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534697696;
        bh=J2Qlu1TNuv/KG9rSKVhQRPOA5ZNNeL8IIbnogCaNHgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DvLqJG8g3bsTJRXZ0P+F5ItL9CpOweRAM/C8/c12Cl6lYRdloJVsDorDwVNwMKtUi
         wsEGh0QfNXzqWa14HgHZEnanpO+dvWY2C2y04KUYkoyatHtiFRkUBarMmjfGSxSorF
         R6orx3bmMBGUyIovyJhCbPYEkjZ2JpZbWSAZ2t44=
Date:   Sun, 19 Aug 2018 17:54:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Add ADC5_AMUX_THM[24]_100K_PU
 to rev2 channel list
Message-ID: <20180819175452.31e0906b@archlinux>
In-Reply-To: <20180810194702.144641-1-mka@chromium.org>
References: <20180810194702.144641-1-mka@chromium.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 12:47:02 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> Add ADC5_AMUX_THM2_100K_PU and ADC5_AMUX_THM4_100K_PU to the list of
> rev2 ADC channels.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
This is fine and applied to the togreg branch of iio.git.
Pushed out as testing to let the autobuilders play with it.

However, I took a quick look and can't immediately see what prevents us
specifying channels in DT that don't have these definitions in the driver.

Should we have a check for that as at least superficially it seems like
a bad idea!

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index a4299417f3de..1f9298a5c83d 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -491,8 +491,12 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
>  					SCALE_HW_CALIB_PMIC_THERM)
>  	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
>  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> +	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>  	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
>  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> +	[ADC5_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_100k_pu", 1,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>  	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 1,
>  					SCALE_HW_CALIB_THERM_100K_PULLUP)
>  	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 1,

