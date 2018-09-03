Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2D320869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="msSfucKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2D320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbeICVt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730906AbeICVt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:49:56 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECA120658;
        Mon,  3 Sep 2018 17:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535995727;
        bh=x7vW0j13mCBy48jU5x/ve/S+Cxqk1Jyx865v257BL8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=msSfucKI94lY4AoFgEkYEwjVAv5zjc/9Im9k/mFpcIPdLdq6f4Qc5vk/yosA0+2El
         VoQY4VlYmg/o85MK8/imTa3KCofyE9vZlbmy4x7ute3HFGr4WNSXZSQ2cuOAvlAVde
         Px/EC9r7xsRdS4PlxmSu2uFyXAGKOZN4VTy9G0Gg=
Date:   Mon, 3 Sep 2018 18:28:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 05/30] iio: adc: move SUN4I_GPADC_CHANNEL define to
 header file
Message-ID: <20180903182840.77231c8b@archlinux>
In-Reply-To: <882cb5f9-867b-d120-5ef5-80a8bee2d628@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
        <20180830154518.29507-6-embed3d@gmail.com>
        <20180902210109.7bd4a567@archlinux>
        <882cb5f9-867b-d120-5ef5-80a8bee2d628@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018 16:24:32 +0200
Philipp Rossak <embed3d@gmail.com> wrote:

> On 02.09.2018 22:01, Jonathan Cameron wrote:
> > On Thu, 30 Aug 2018 17:44:53 +0200
> > Philipp Rossak <embed3d@gmail.com> wrote:
> >   
> >> We are moving the SUN4I_GPADC_CHANNEL define to the header file.  
> > Maxime has raised this point in other patches...
> > 
> > Why?  Obvious what but I have no idea why you are doing this.
> > 
> > Thanks,
> > 
> > Jonathan  
> There are two reasons:
> 1. Personal taste: I like to have the #define stuff in the header file.
> 2. When I started the rework I had to get some better overview, so I 
> moved it...
> 
> Since those two reasons are no good reasons to submit a patch I will 
> drop it and keep it in the *.c file.
Don't move it.

For a 'utility' type define like this that is just about cutting
down on code repetition it is nice to be able to see what it does near
to where it is used.

Also, as a general rule kernel style is to not put things in a header
unless they are needed in multiple files.  There are exceptions, but
it is generally felt keeping things local to where they are used
leads to easier to review code.

Jonathan
> 
> Philipp
> 
> >>
> >> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> >> ---
> >>   drivers/iio/adc/sun4i-gpadc-iio.c | 9 ---------
> >>   include/linux/mfd/sun4i-gpadc.h   | 9 +++++++++
> >>   2 files changed, 9 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> >> index d95dd0fde2a6..666329940e1e 100644
> >> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> >> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> >> @@ -109,15 +109,6 @@ struct sun4i_gpadc_iio {
> >>   	struct device			*sensor_device;
> >>   };
> >>   
> >> -#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
> >> -	.type = IIO_VOLTAGE,					\
> >> -	.indexed = 1,						\
> >> -	.channel = _channel,					\
> >> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> >> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> >> -	.datasheet_name = _name,				\
> >> -}
> >> -
> >>   static struct iio_map sun4i_gpadc_hwmon_maps[] = {
> >>   	{
> >>   		.adc_channel_label = "temp_adc",
> >> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
> >> index 139872c2e0fe..54c7c9375c1b 100644
> >> --- a/include/linux/mfd/sun4i-gpadc.h
> >> +++ b/include/linux/mfd/sun4i-gpadc.h
> >> @@ -90,6 +90,15 @@
> >>   /* 10s delay before suspending the IP */
> >>   #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
> >>   
> >> +#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
> >> +	.type = IIO_VOLTAGE,					\
> >> +	.indexed = 1,						\
> >> +	.channel = _channel,					\
> >> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> >> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> >> +	.datasheet_name = _name,				\
> >> +}
> >> +
> >>   struct sun4i_gpadc_dev {
> >>   	struct device			*dev;
> >>   	struct regmap			*regmap;  
> >   

