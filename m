Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20602C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70A720865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uV/pJLmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70A720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeIKM02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:26:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42372 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeIKM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:26:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id g23-v6so10911225plq.9;
        Tue, 11 Sep 2018 00:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JrVEHUybFRsXN9BkwTdqsjLNHAXfTRRTKVqp6cxEPaQ=;
        b=uV/pJLmuKRxqaFUvkh52Wa0RiiUJPFw5Vc07JB5W4B0zOs0eLGigquGtzLhQbT4/E/
         2fMX5SdQa+bYJPkhWUFh9YgjJTayPnqG4r+0yxAjvaMK3aGUBdQOHipDzz4JyF/4VuQ7
         DD0CjQ9Ri6CqC/fBm7rfMhzAQyNLEUOcr0mEiIv26gCo2/obu1ov7uqZ9abVLQ9qA+Ql
         Kbc7LkIq2Oki31yrl1Ej5lxnIiT4AFulGe5zmyJZ5eui4XWWGPyeS0J9qNU1gpooPWN+
         QoiA6MLUVcG0XTL1mq+Lpd1gpEKhr5ejL2Wfg2spPQqiyyw80jRlgwQ2ueocL4dCZvjZ
         3mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JrVEHUybFRsXN9BkwTdqsjLNHAXfTRRTKVqp6cxEPaQ=;
        b=uBXJhr9WSX6XNfOCux42IDqhxNf4g9YhkGz95joYOo6vmOHltx37doRoSe+EMmJFxR
         mzQAri4tsqyu06vLM534/xKEjim9MNfoYJ12NeS3fdq7lXjeHaQeMNi9zqSlRvUAE8Cp
         pBxo8VFAL1SfCj3qw5BIyzsgZlbHku2VyNWM121fCgzpKPs2VJRKYqYi5YYAG3QkTyZT
         2fb4pZ99uvqqo1dHDce6hEqTCcEGT3ga9tFWBTZfK4JNECYbx8ftObWE+TtatKtKTxSF
         VZLYImoUS8WApp5T/lszfuAAT3dqODGfO8P8oPL50VXBmlLrwGAZGzz/CRCUolQ7Ow+n
         pYoQ==
X-Gm-Message-State: APzg51DCmu+D7GNZUz6Hp39BZPQ4tTE+Gc3rbo9s0DU9Sn+WUCnX0xMB
        eKmzWYG7lMPm2Y2IWxegOV4=
X-Google-Smtp-Source: ANB0VdYjl7Mxs7DXpKer07pqyYPiwDgqtgYtrh2R7uDgiRzaiYx08x1k0aSIYPixOw6a1hu6JZnSXw==
X-Received: by 2002:a17:902:585:: with SMTP id f5-v6mr25764400plf.7.1536650910053;
        Tue, 11 Sep 2018 00:28:30 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id 70-v6sm25998422pfz.27.2018.09.11.00.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 00:28:29 -0700 (PDT)
Date:   Tue, 11 Sep 2018 12:58:20 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, andriy.shevchenko@linux.intel.com,
        matt.ranostay@konsulko.com, ak@it-klinger.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: Add driver support for ST's VL53L0X ToF
 ranging sensor.
Message-ID: <20180911072820.GA7083@himanshu-Vostro-3559>
References: <20180910144259.1339-1-songqiang.1304521@gmail.com>
 <20180910175747.GA5883@himanshu-Vostro-3559>
 <20180911064638.GA31507@Eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911064638.GA31507@Eros>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:46:38PM +0800, Song Qiang wrote:
> On Mon, Sep 10, 2018 at 11:27:47PM +0530, Himanshu Jha wrote:
> > On Mon, Sep 10, 2018 at 10:42:59PM +0800, Song Qiang wrote:
> > > This driver was originally written by ST in 2016 as a misc input device,
> > > and hasn't been maintained for a long time. I grabbed some code from
> > > it's API and reformed it to a iio proximity device driver.
> > > This version of driver uses i2c bus to talk to the sensor and
> > > polling for measuring completes, so no irq line is needed.
> > > This version of driver supports only one-shot mode, and it can be
> > > tested with reading from
> > > /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> > > 
> > > Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> > > ---
> > 
> > The Cc list contains developers who might not be relevant
> > for the discussion.
> > 
> > So, copy only those people listed by:
> > 
> > $./scripts/get_maintainer.pl <driver.patch>
> > 
> > Don't know why Kate & Greg are cc'ed ?
> > 
> > >  .../bindings/iio/proximity/vl53l0x.txt        |  12 +
> > >  drivers/iio/proximity/Kconfig                 |  13 +
> > >  drivers/iio/proximity/Makefile                |   2 +
> > >  drivers/iio/proximity/vl53l0x-i2c.c           | 295 ++++++++++++++++++
> > >  4 files changed, 322 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > >  create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > new file mode 100644
> > > index 000000000000..64b69442f08e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > @@ -0,0 +1,12 @@
> > > +ST's VL53L0X ToF ranging sensor
> > > +
> > > +Required properties:
> > > +	- compatible: must be "st,vl53l0x-i2c"
> > > +	- reg: i2c address where to find the device
> > > +
> > > +Example:
> > > +
> > > +vl53l0x@29 {
> > > +	compatible = "st,vl53l0x-i2c";
> > > +	reg = <0x29>;
> > > +};
> > > diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> > > index f726f9427602..1563a5f9144d 100644
> > > --- a/drivers/iio/proximity/Kconfig
> > > +++ b/drivers/iio/proximity/Kconfig
> > > @@ -79,4 +79,17 @@ config SRF08
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called srf08.
> > >  
> > > +config VL53L0X_I2C
> > > +	tristate "STMicroelectronics VL53L0X ToF ranger sensor (I2C)"
> > > +	select IIO_BUFFER
> > > +	select IIO_TRIGGERED_BUFFER
> > 
> > I don't see any buffer/trigger support, so better to remove these
> > two options.
> > 
> > > +	depends on I2C
> > > +	help
> > > +	  Say Y here to build a driver for STMicroelectronics VL53L0X
> > > +	  ToF ranger sensors with i2c interface.
> > > +	  This driver can be used to measure the distance of objects.
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called vl53l0x-i2c.
> > 
> > `name` attribute will be VL53L0X_DRV_NAME(vl53l0x) if OF matching
> > is not used to probe the driver.
> > 
> > >  endmenu
> > > diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> > > index 4f4ed45e87ef..7cb771665c8b 100644
> > > --- a/drivers/iio/proximity/Makefile
> > > +++ b/drivers/iio/proximity/Makefile
> > > @@ -10,3 +10,5 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
> > >  obj-$(CONFIG_SRF04)		+= srf04.o
> > >  obj-$(CONFIG_SRF08)		+= srf08.o
> > >  obj-$(CONFIG_SX9500)		+= sx9500.o
> > > +obj-$(CONFIG_VL53L0X_I2C)		+= vl53l0x-i2c.o
> > > +
> > > diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> > > new file mode 100644
> > > index 000000000000..c00713041d30
> > > --- /dev/null
> > > +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> > > @@ -0,0 +1,295 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + *  vl53l0x-i2c.c - Support for STM VL53L0X FlightSense TOF
> > > + *					Ranger Sensor on a i2c bus.
> > > + *
> > > + *  Copyright (C) 2016 STMicroelectronics Imaging Division.
> > > + *  Copyright (C) 2018 Song Qiang <songqiang.1304521@gmail.com>
> > > + *
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/iio/iio.h>
> > > +
> > > +#define VL53L0X_DRV_NAME			"vl53l0x"
> > > +
> > > +/* Device register map */
> > > +#define VL_REG_SYSRANGE_START					0x000
> > > +#define VL_REG_SYSRANGE_MODE_MASK				0x0F
> > > +#define VL_REG_SYSRANGE_MODE_START_STOP			0x01
> > > +#define VL_REG_SYSRANGE_MODE_SINGLESHOT			0x00
> > > +#define VL_REG_SYSRANGE_MODE_BACKTOBACK			0x02
> > > +#define VL_REG_SYSRANGE_MODE_TIMED				0x04
> > > +#define VL_REG_SYSRANGE_MODE_HISTOGRAM			0x08
> > > +
> > > +#define VL_REG_SYS_THRESH_HIGH					0x000C
> > > +#define VL_REG_SYS_THRESH_LOW					0x000E
> > > +
> > > +#define VL_REG_SYS_SEQUENCE_CFG					0x0001
> > > +#define VL_REG_SYS_RANGE_CFG					0x0009
> > > +#define VL_REG_SYS_INTERMEASUREMENT_PERIOD		0x0004
> > 
> > Could you please align all these macros properly.
> > 
> > > +#define VL_REG_SYS_INT_CFG_GPIO					0x000A
> > > +#define VL_REG_SYS_INT_GPIO_DISABLED			0x00
> > > +#define VL_REG_SYS_INT_GPIO_LEVEL_LOW			0x01
> > > +#define VL_REG_SYS_INT_GPIO_LEVEL_HIGH			0x02
> > > +#define VL_REG_SYS_INT_GPIO_OUT_OF_WINDOW		0x03
> > > +#define VL_REG_SYS_INT_GPIO_NEW_SAMPLE_READY	0x04
> > > +#define VL_REG_GPIO_HV_MUX_ACTIVE_HIGH			0x0084
> > > +#define VL_REG_SYS_INT_CLEAR					0x000B
> > > +
> > > +/* Result registers */
> > > +#define VL_REG_RESULT_INT_STATUS				0x0013
> > > +#define VL_REG_RESULT_RANGE_STATUS				0x0014
> > > +
> > > +#define VL_REG_RESULT_CORE_PAGE  1
> > > +#define VL_REG_RESULT_CORE_AMBIENT_WINDOW_EVENTS_RTN	0x00BC
> > > +#define VL_REG_RESULT_CORE_RANGING_TOTAL_EVENTS_RTN		0x00C0
> > > +#define VL_REG_RESULT_CORE_AMBIENT_WINDOW_EVENTS_REF	0x00D0
> > > +#define VL_REG_RESULT_CORE_RANGING_TOTAL_EVENTS_REF		0x00D4
> > > +#define VL_REG_RESULT_PEAK_SIGNAL_RATE_REF				0x00B6
> > > +
> > > +/* Algo register */
> > > +#define VL_REG_ALGO_PART_TO_PART_RANGE_OFFSET_MM		0x0028
> > > +
> > > +#define VL_REG_I2C_SLAVE_DEVICE_ADDRESS					0x008a
> > > +
> > > +/* Check Limit registers */
> > > +#define VL_REG_MSRC_CFG_CONTROL						0x0060
> > > +
> > > +#define VL_REG_PRE_RANGE_CFG_MIN_SNR					0X0027
> > > +#define VL_REG_PRE_RANGE_CFG_VALID_PHASE_LOW			0x0056
> > > +#define VL_REG_PRE_RANGE_CFG_VALID_PHASE_HIGH			0x0057
> > > +#define VL_REG_PRE_RANGE_MIN_COUNT_RATE_RTN_LIMIT		0x0064
> > > +
> > > +#define VL_REG_FINAL_RANGE_CFG_MIN_SNR					0X0067
> > > +#define VL_REG_FINAL_RANGE_CFG_VALID_PHASE_LOW			0x0047
> > > +#define VL_REG_FINAL_RANGE_CFG_VALID_PHASE_HIGH			0x0048
> > > +#define VL_REG_FINAL_RANGE_CFG_MIN_COUNT_RATE_RTN_LIMIT	0x0044
> > > +
> > > +#define VL_REG_PRE_RANGE_CFG_SIGMA_THRESH_HI			0X0061
> > > +#define VL_REG_PRE_RANGE_CFG_SIGMA_THRESH_LO			0X0062
> > > +
> > > +/* PRE RANGE registers */
> > > +#define VL_REG_PRE_RANGE_CFG_VCSEL_PERIOD				0x0050
> > > +#define VL_REG_PRE_RANGE_CFG_TIMEOUT_MACROP_HI			0x0051
> > > +#define VL_REG_PRE_RANGE_CFG_TIMEOUT_MACROP_LO			0x0052
> > > +
> > > +#define VL_REG_SYS_HISTOGRAM_BIN					0x0081
> > > +#define VL_REG_HISTOGRAM_CFG_INITIAL_PHASE_SELECT		0x0033
> > > +#define VL_REG_HISTOGRAM_CFG_READOUT_CTRL				0x0055
> > > +
> > > +#define VL_REG_FINAL_RANGE_CFG_VCSEL_PERIOD				0x0070
> > > +#define VL_REG_FINAL_RANGE_CFG_TIMEOUT_MACROP_HI		0x0071
> > > +#define VL_REG_FINAL_RANGE_CFG_TIMEOUT_MACROP_LO		0x0072
> > > +#define VL_REG_CROSSTALK_COMPENSATION_PEAK_RATE_MCPS	0x0020
> > > +
> > > +#define VL_REG_MSRC_CFG_TIMEOUT_MACROP					0x0046
> > > +
> > > +#define VL_REG_SOFT_RESET_GO2_SOFT_RESET_N				0x00bf
> > > +#define VL_REG_IDENTIFICATION_MODEL_ID					0x00c0
> > > +#define VL_REG_IDENTIFICATION_REVISION_ID				0x00c2
> > > +
> > > +#define VL_REG_OSC_CALIBRATE_VAL					0x00f8
> > > +
> > > +#define VL_SIGMA_ESTIMATE_MAX_VALUE					65535
> > > +/* equivalent to a range sigma of 655.35mm */
> > > +
> > > +#define VL_REG_GLOBAL_CFG_VCSEL_WIDTH					0x032
> > > +#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_0			0x0B0
> > > +#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_1			0x0B1
> > > +#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_2			0x0B2
> > > +#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_3			0x0B3
> > > +#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_4			0x0B4
> > > +#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_5			0x0B5
> > > +#define VL_REG_GLOBAL_CFG_REF_EN_START_SELECT			0xB6
> > > +#define VL_REG_DYNAMIC_SPAD_NUM_REQUESTED_REF_SPAD		0x4E /* 0x14E */
> > > +#define VL_REG_DYNAMIC_SPAD_REF_EN_START_OFFSET			0x4F /* 0x14F */
> > > +#define VL_REG_POWER_MANAGEMENT_GO1_POWER_FORCE			0x80
> > > +
> > > +/*
> > > + * Speed of light in um per 1E-10 Seconds
> > > + */
> > > +#define VL_SPEED_OF_LIGHT_IN_AIR					2997
> > > +#define VL_REG_VHV_CFG_PAD_SCL_SDA__EXTSUP_HV			0x0089
> > > +#define VL_REG_ALGO_PHASECAL_LIM			0x0030 /* 0x130 */
> > > +#define VL_REG_ALGO_PHASECAL_CFG_TIMEOUT				0x0030
> > > +
> > > +struct vl53l0x_data {
> > > +	struct i2c_client *client;
> > > +	struct mutex lock;
> > 
> > This lock needs a comment to explain its purpose.
> > 
> > > +	int	useLongRange;
> > 
> > Weird spacing.
> > 
> > > +
> > > +static int vl53l0x_read_proximity(struct vl53l0x_data *data,
> > > +				const struct iio_chan_spec *chan,
> > > +				int *val)
> > 
> > Align all these functions to match open parentheses with mix of
> > tabs + whitespaces(as required):
> > 
> > static int vl53l0x_read_proximity(struct vl53l0x_data *data,
> > 				  const struct iio_chan_spec *chan,
> > 				  int *val)
> > 
> 
> Hi Himanshu,
> 
> I found that some functions like this one is too long for alignment,
> and if we force the parameters to align then the first parameter
> must go to the second line, while I havn't seen people done this
> before. In this case, should I remain others aligned except the
> first parameter or keep them all aligned with the first parameter
> in the second line?

I don't really understand "too long for alignment".

Refer here and look at all the function parameters alignment:
https://raw.githubusercontent.com/torvalds/linux/master/drivers/iio/chemical/bme680_core.c

It just looks more readable and clean.

> I have corrected the problems you and Andy listed just except this
> one, hoping for a reply.

Thanks for repairing them :)

And your question about commit signers:

Yes, kate confirmed to me that she got added when SPDX was introduced, so its
fine. I just told because I had not seen her in any of IIO patches, and
it looked dubious to me.

And Greg also doesn't review IIO patches(but Cc him on staging/iio) and
already gets a blast of other patches from staging, usb, .... + other
important obligations related to -stable release and stuff.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
