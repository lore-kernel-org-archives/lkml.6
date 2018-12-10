Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116DDC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBD120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544474379;
	bh=BDVTQYQ2Rwk7O+sWc9YZfgDeK4oJp8mNM4xhfV+Y7Zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cVTR2grfS/ob63BaogfR2qZz4TrGPVeWReO9HxVw4Yak/jNcgb1IVfVT3R9fnRryM
	 bUk2KI3BB5q4xsGz5P2X5rQ2wSzFi0eWk3dueacVJ/WnXSuc5ruvx3RNFwNB9Pf8d5
	 CeKyJxdIbcOOfzOmbOaphr+e5EH6mTXPse2mrFmY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBD120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeLJUji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:39:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbeLJUjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:39:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC2920821;
        Mon, 10 Dec 2018 20:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544474375;
        bh=BDVTQYQ2Rwk7O+sWc9YZfgDeK4oJp8mNM4xhfV+Y7Zc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bwI/nBUVzGSlcxCOrblUfWcB4ckSp+b500NoT0MAIcN5hB31+Y7aYZuxKAFGV0gj5
         EiQcqDDe2rJmpu6i9kigjO9F706vHcoUgTblrVxNm/GqjEw0JQ2n94tjeLeifTbFvP
         swoDJftPWLBC3VEb9XvCvNjIiRwcj/OgQ77Roo6M=
Date:   Mon, 10 Dec 2018 20:39:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: Add the TI ads124s08 ADC code
Message-ID: <20181210203931.2975ef15@archlinux>
In-Reply-To: <b6690112-9862-8178-14d4-c4a65b201c29@ti.com>
References: <20181204175955.8259-1-dmurphy@ti.com>
        <20181204175955.8259-2-dmurphy@ti.com>
        <20181208115609.1311188a@archlinux>
        <b6690112-9862-8178-14d4-c4a65b201c29@ti.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Replies to queries inline.

On Mon, 10 Dec 2018 14:14:55 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Jonathan
> 
> Thanks for the review
> 
> On 12/08/2018 05:56 AM, Jonathan Cameron wrote:
> > On Tue, 4 Dec 2018 11:59:55 -0600
> > Dan Murphy <dmurphy@ti.com> wrote:
> >   
> >> Introduce the TI ADS124S08 and the ADS124S06 ADC
> >> devices from TI.  The ADS124S08 is the 12 channel ADC
> >> and the ADS124S06 is the 6 channel ADC device
> >>
> >> These devices share a common datasheet:
> >> http://www.ti.com/lit/gpn/ads124s08
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com>  
> > Various minor things inline.
> >   
> 
> No worries.  I believe I used the ADS8688 driver as a reference so that driver
> may need to be updated as well

Great if you don't mind fixing the buffer size issue in there as well.

> 
> > Thanks,
> > 
> > Jonathan
> >   
> >> ---
> >>  drivers/iio/adc/Kconfig        |  10 +
> >>  drivers/iio/adc/Makefile       |   1 +
> >>  drivers/iio/adc/ti-ads124s08.c | 437 +++++++++++++++++++++++++++++++++
> >>  3 files changed, 448 insertions(+)
> >>  create mode 100644 drivers/iio/adc/ti-ads124s08.c
> >>
> >> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >> index a52fea8749a9..e8c5686e6716 100644
> >> --- a/drivers/iio/adc/Kconfig
> >> +++ b/drivers/iio/adc/Kconfig
> >> @@ -887,6 +887,16 @@ config TI_ADS8688
> >>  	  This driver can also be built as a module. If so, the module will be
> >>  	  called ti-ads8688.
> >>  
> >> +config TI_ADS124S08
> >> +	tristate "Texas Instruments ADS124S08"
> >> +	depends on SPI && OF
> >> +	help
> >> +	  If you say yes here you get support for Texas Instruments ADS124S08
> >> +	  and ADS124S06 ADC chips
> >> +
> >> +	  This driver can also be built as a module. If so, the module will be
> >> +	  called ti-ads124s08.
> >> +
> >>  config TI_AM335X_ADC
> >>  	tristate "TI's AM335X ADC driver"
> >>  	depends on MFD_TI_AM335X_TSCADC && HAS_DMA
> >> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> >> index a6e6a0b659e2..d70293abfdba 100644
> >> --- a/drivers/iio/adc/Makefile
> >> +++ b/drivers/iio/adc/Makefile
> >> @@ -79,6 +79,7 @@ obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
> >>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
> >>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
> >>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> >> +obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
> >>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
> >>  obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
> >>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> >> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> >> new file mode 100644
> >> index 000000000000..b6fc93f37355
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/ti-ads124s08.c
> >> @@ -0,0 +1,437 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +// TI ADS124S0X chip family driver
> >> +// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/  
> > An oddity of current kernel style is that typically only the spdx
> > line is // 
> > 
> > The rest are a normal kernel multiline comment.  
> 
> Ack.  Finding it is up to the maintainer here on the preference so I will change it.
> 
> >   
> >> +
> >> +#include <linux/err.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/device.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_gpio.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/sysfs.h>
> >> +
> >> +#include <linux/gpio/consumer.h>
> >> +#include <linux/regulator/consumer.h>
> >> +#include <linux/spi/spi.h>
> >> +
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/buffer.h>
> >> +#include <linux/iio/trigger_consumer.h>
> >> +#include <linux/iio/triggered_buffer.h>
> >> +#include <linux/iio/sysfs.h>
> >> +
> >> +#define ADS124S08_ID		0x00
> >> +#define ADS124S06_ID		0x01  
> > 
> > Use an enum for these as the actual values don't matter, only that
> > they are unique.
> >   
> 
> Ack.  Is there a preference on using the sentinnal or not?

If the sentinel is useful for a loop or range check then yes, if not
then don't bother.

> 
> >> +
> >> +/* Commands */
> >> +#define ADS124S_CMD_NOP		0x00  
> > Why this shorter prefix? Are all ADS124S parts
> > compatible with this list? 
> >   
> 
> Ack.  Yes the 124S are all compatible since there are only 2 ATM.
> 
> 
> >> +#define ADS124S_CMD_WAKEUP	0x02
> >> +#define ADS124S_CMD_PWRDWN	0x04
> >> +#define ADS124S_CMD_RESET	0x06
> >> +#define ADS124S_CMD_START	0x08
> >> +#define ADS124S_CMD_STOP	0x0a
> >> +#define ADS124S_CMD_SYOCAL	0x16
> >> +#define ADS124S_CMD_SYGCAL	0x17
> >> +#define ADS124S_CMD_SFOCAL	0x19
> >> +#define ADS124S_CMD_RDATA	0x12
> >> +#define ADS124S_CMD_RREG	0x20
> >> +#define ADS124S_CMD_WREG	0x40
> >> +
> >> +/* Registers */
> >> +#define ADS124S0X_ID		0x00  
> > Avoid wild cards in naming.  It always goes wrong when
> > along comes another part that is similar but not quite the
> > same yet fits in your naming scheme.  Just pick a part
> > and name after that.  
> 
> The issue is that there are some registers below that are S08 only
> and do not apply to the S06.
> 
> This is why I choose the wild card.  I can use the 08 since that has a master set.
> Unless I can keep the 0X

Use 08 seems like a good solution as they are definitely valid for that.

...

> >> +
> >> +static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
> >> +{
> >> +	struct ads124s_private *priv = iio_priv(indio_dev);
> >> +	int ret;
> >> +	u32 tmp;
> >> +	struct spi_transfer t[] = {
> >> +		{
> >> +			.tx_buf = &priv->data[0],
> >> +			.len = 4,
> >> +			.cs_change = 1,
> >> +		}, {
> >> +			.tx_buf = &priv->data[1],
> >> +			.rx_buf = &priv->data[1],
> >> +			.len = 4,
> >> +		},
> >> +	};  
> > 
> > Pity we don't have a spi_write_the_read_with_cs or
> > something like that.  I wonder how common this structure is?  
> 
> This is common with this part and the ads8688 and another spi part I am working on for CAN.
> 
> I just don't know if there are any parts that hold CS for more then one data xfer.

There definitely are though I couldn't name one right now.
Some devices use the CS to reset a simple state machine.  If you drop
it then the state machine resets, even mid read.

...
> 
> >   
> >> +
> >> +static const struct iio_info ads124s_info = {
> >> +	.read_raw = &ads124s_read_raw,
> >> +};
> >> +
> >> +static irqreturn_t ads124s_trigger_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	struct ads124s_private *priv = iio_priv(indio_dev);
> >> +	u16 buffer[ADS124S0X_MAX_CHANNELS];  
> > 
> > There is an unfortunate oddity in how push_to_buffers_with_timestamp
> > works in that it builds the data for the kfifo inline in the buffer
> > provided.  Thus that buffer has to have room for the channels and
> > the 64 bit timestamp.  
> 
> Hmmm.  This is like the 8688.  I am starting to think the 8688 needs to be updated.

Yes that looks wrong.  Thanks!

> 
> >   
> >> +	int i, j = 0;
> >> +	int ret;
> >> +
> >> +	for (i = 0; i < indio_dev->masklength; i++) {
> >> +		if (!test_bit(i, indio_dev->active_scan_mask))  
> > 
> > for_each_bit_set   
> 
> Same as above.  But I can change it.
> 
> >   
> >> +			continue;
> >> +
> >> +		ret = ads124s_write_reg(indio_dev, ADS124S0X_INPUT_MUX, i);  
> > 
> > Does this need to be rewritten if the channel is already correct?  
> 
> This is an iterative loop so the channel should be different each time 0 - 12

doh.  I'm not sure how I misread that.  However, not true for the raw
read above I think?
   
...
> > 
> > You can move to fully managed if you use devm_add_action_or_reset
> > to turn the regulator off.
> >   
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct spi_device_id ads124s_id[] = {
> >> +	{ "ads124s08", ADS124S08_ID },
> >> +	{ "ads124s06", ADS124S06_ID },
> >> +	{ }
> >> +};
> >> +MODULE_DEVICE_TABLE(spi, ads124s_id);
> >> +
> >> +static const struct of_device_id ads124s_of_table[] = {
> >> +	{ .compatible = "ti,ads124s08" },
> >> +	{ .compatible = "ti,ads124s06" },  
> > 
> > It's trivial but numerical order preferred as it makes it
> > obvious where to add new devices later.  
> 
> Actually I based these off the ID read from the device.
> The S08 ID is 0x0 and the S06 is 0x1.  Bit I can reorder this since it just the compatible.

Given that reason for the order is hidden by the defines
I'd reorder to avoid someone else coming and tidying it up later!

> 
> Dan
...

Jonathan
