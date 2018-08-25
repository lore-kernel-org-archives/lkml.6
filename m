Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86675C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6DA21523
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCmGknSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6DA21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeHYLsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 07:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeHYLsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 07:48:07 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E70214AB;
        Sat, 25 Aug 2018 08:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535184597;
        bh=PW8/tXqcJm+sYP4OkvNd11elkKLupMTBwEKZpf2O9Mo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eCmGknSz5NRJIWlcnVNhWvhzQDWGlwFEGG0GG4nJrc0in/R1u68Nj6eGkUmIC0MHo
         ABvYVVNqFmBaN+i7dnLTJp/7wzLss5wA3Uh1zdQwQPurKhlarZbYM5sFV1F1V/jBJ+
         YQP8r4gBdKrp1bPLFAVfoR0AguwuGfwLQ1twp0gA=
Date:   Sat, 25 Aug 2018 09:09:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Add ADC5_AMUX_THM[24]_100K_PU
 to rev2 channel list
Message-ID: <20180825090957.1e3a1076@archlinux>
In-Reply-To: <20180824221439.GT160295@google.com>
References: <20180810194702.144641-1-mka@chromium.org>
        <20180819175452.31e0906b@archlinux>
        <20180824221439.GT160295@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 15:14:39 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> On Sun, Aug 19, 2018 at 05:54:52PM +0100, Jonathan Cameron wrote:
> > On Fri, 10 Aug 2018 12:47:02 -0700
> > Matthias Kaehlcke <mka@chromium.org> wrote:
> >   
> > > Add ADC5_AMUX_THM2_100K_PU and ADC5_AMUX_THM4_100K_PU to the list of
> > > rev2 ADC channels.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>  
> > This is fine and applied to the togreg branch of iio.git.
> > Pushed out as testing to let the autobuilders play with it.  
> 
> Thanks!
> 
> > However, I took a quick look and can't immediately see what prevents us
> > specifying channels in DT that don't have these definitions in the driver.  
> 
> Indeed, the DT could just specify an arbitrary value.
> 
> > Should we have a check for that as at least superficially it seems like
> > a bad idea!  
> 
> It seems there isn't a single contiguous range, but a very superficial
> check could at least verify that the value isn't larger than CHAN_MAX
> or check a few sub-ranges.

Given other entries will be zeroed, just check for something not being 0?

> 
> > > ---
> > >  drivers/iio/adc/qcom-spmi-adc5.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> > > index a4299417f3de..1f9298a5c83d 100644
> > > --- a/drivers/iio/adc/qcom-spmi-adc5.c
> > > +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> > > @@ -491,8 +491,12 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
> > >  					SCALE_HW_CALIB_PMIC_THERM)
> > >  	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
> > >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > > +	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
> > > +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > >  	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
> > >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > > +	[ADC5_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_100k_pu", 1,
> > > +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > >  	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 1,
> > >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > >  	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 1,  
> >   

