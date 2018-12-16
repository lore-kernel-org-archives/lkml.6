Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E6FC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752B12183F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544963085;
	bh=DLU/yWIUkclTsZIOp7I8UfRCsI9bRYSGZ+PzPyR4EmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LrtTHXUa5Gc3YPYg2pvS7PFpPEl5zR8WzLS1lMK1uJXlcg5z//X42balwLliXsxh0
	 K4Kxi4tt2IvWnS1LyzpHzHBXKjNacumTahxWTb9HYQoWs5IdJQaX4EL8B1vBlLsED4
	 xlvyu7SH0d7yIFZUYwJrXeO21oYKdG8y88RGAh9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbeLPMYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 07:24:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbeLPMYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 07:24:44 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA572086C;
        Sun, 16 Dec 2018 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544963082;
        bh=DLU/yWIUkclTsZIOp7I8UfRCsI9bRYSGZ+PzPyR4EmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jrLFhWJHjrbtaEyQZH9srEyqw3z9uIi8o1hx8If+6/g5z5TXXVkLKnlp8O/rU9k4n
         +XRpHJewqKb8o2w+O6xvEtuVj2HGHk3PRi44V2vtidtMesI2/iX8rebNRoRQauJSKz
         7xTEvzsM+aL1igDnkL87mHM7sE/Uut3MBu/JbVdY=
Date:   Sun, 16 Dec 2018 12:24:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     marcel.ziswiler@toradex.com, stefan@agner.ch,
        thierry.reding@gmail.com,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Freeman Liu <freeman.liu@spreadtrum.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Kent Gustavsson <kent@minoris.se>
Subject: Re: [PATCH v4 5/8] iio: adc: add STMPE ADC driver using IIO
 framework
Message-ID: <20181216122434.00739fea@archlinux>
In-Reply-To: <20181212130649.15146-5-dev@pschenker.ch>
References: <20181212130649.15146-1-dev@pschenker.ch>
        <20181212130649.15146-5-dev@pschenker.ch>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 14:06:46 +0100
Philippe Schenker <dev@pschenker.ch> wrote:

> This adds an ADC driver for the STMPE device using the industrial
> input/output interface. The driver supports raw reading of values.
> The driver depends on the MFD STMPE driver. If the touchscreen
> block is enabled too, only four of the 8 ADC channels are available.
>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Hi.

A few trivial comments inline.  Fix those up and you can add my
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ---
>=20
> Changes in v4:
>  - Moved MFD changes to a precursor patch
>  - Moved stmpe-ts changes to a precursor patch
>  - Created stmpe_read_temp and stmpe_read_voltage functions to make
>    read_raw more readable
>  - Added local lock instead of using indio_dev's mlock
>  - Use be16_to_cpu() macro instead of bitshifting
>  - Added stmpe_enable again to stmpe_adc_init_hw
>  - Use devm_add_action_or_reset to get rid of the remove function
>    (I tested if that actually works)
>=20
> Changes in v3:
>  - Removed COMPILE_TEST from dependings in Kconfig
>  - Removed stmpe_adc_get_platform_info() function and integrated the
>    few code lines in the other function
>=20
> Changes in v2:
>  - Code formatting
>  - Removed unused includes
>  - Defined the macro STMPE_START_ONE_TEMP_CONV with other macros.
>  - Added new macro that defines the channel of the temperature sensor.
>    Took new name for STMPE_MAX_ADC->STMPE_ADC_LAST_NR and used it
>    throughout the code for better readability.
>  - Added mutex_unlock where missing.
>=20
>  drivers/iio/adc/Kconfig     |   7 +
>  drivers/iio/adc/Makefile    |   1 +
>  drivers/iio/adc/stmpe-adc.c | 368 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 376 insertions(+)
>  create mode 100644 drivers/iio/adc/stmpe-adc.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a52fea8749a9..224f2067494d 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -734,6 +734,13 @@ config STM32_DFSDM_ADC
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called stm32-dfsdm-adc.
> =20
> +config STMPE_ADC
> +	tristate "STMicroelectronics STMPE ADC driver"
> +	depends on OF && MFD_STMPE
> +	help
> +	  Say yes here to build support for ST Microelectronics STMPE
> +	  built-in ADC block (stmpe811).
> +
>  config STX104
>  	tristate "Apex Embedded Systems STX104 driver"
>  	depends on PC104 && X86
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index a6e6a0b659e2..cba889c30bf9 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_STM32_ADC_CORE) +=3D stm32-adc-core.o
>  obj-$(CONFIG_STM32_ADC) +=3D stm32-adc.o
>  obj-$(CONFIG_STM32_DFSDM_CORE) +=3D stm32-dfsdm-core.o
>  obj-$(CONFIG_STM32_DFSDM_ADC) +=3D stm32-dfsdm-adc.o
> +obj-$(CONFIG_STMPE_ADC) +=3D stmpe-adc.o
>  obj-$(CONFIG_TI_ADC081C) +=3D ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) +=3D ti-adc0832.o
>  obj-$(CONFIG_TI_ADC084S021) +=3D ti-adc084s021.o
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> new file mode 100644
> index 000000000000..4333da19a097
> --- /dev/null
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -0,0 +1,368 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  STMicroelectronics STMPE811 IIO ADC Driver
> + *
> + *  4 channel, 10/12-bit ADC
> + *
> + *  Copyright (C) 2013-2018 Toradex AG <stefan.agner@toradex.com>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/stmpe.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/device.h>
> +
> +#define STMPE_REG_INT_STA		0x0B
> +#define STMPE_REG_ADC_INT_EN		0x0E
> +#define STMPE_REG_ADC_INT_STA		0x0F
> +
> +#define STMPE_REG_ADC_CTRL1		0x20
> +#define STMPE_REG_ADC_CTRL2		0x21
> +#define STMPE_REG_ADC_CAPT		0x22
> +#define STMPE_REG_ADC_DATA_CH(channel)	(0x30 + 2 * (channel))
> +
> +#define STMPE_REG_TEMP_CTRL		0x60
> +#define STMPE_TEMP_CTRL_ENABLE		BIT(0)
> +#define STMPE_TEMP_CTRL_ACQ		BIT(1)
> +#define STMPE_TEMP_CTRL_THRES_EN	BIT(3)
> +#define STMPE_START_ONE_TEMP_CONV	(STMPE_TEMP_CTRL_ENABLE | \
> +					STMPE_TEMP_CTRL_ACQ | \
> +					STMPE_TEMP_CTRL_THRES_EN)
> +#define STMPE_REG_TEMP_DATA		0x61
> +#define STMPE_REG_TEMP_TH		0x63
> +#define STMPE_ADC_LAST_NR		7
> +#define STMPE_TEMP_CHANNEL		(STMPE_ADC_LAST_NR + 1)
> +
> +#define STMPE_ADC_CH(channel)		((1 << (channel)) & 0xff)
> +
> +#define STMPE_ADC_TIMEOUT		msecs_to_jiffies(1000)
> +
> +struct stmpe_adc {
> +	struct stmpe *stmpe;
> +	struct clk *clk;
> +	struct device *dev;
> +	struct mutex lock;
> +
> +	/* We are allocating plus one for the temperature channel */
> +	struct iio_chan_spec stmpe_adc_iio_channels[STMPE_ADC_LAST_NR + 2];
> +
> +	struct completion completion;
> +
> +	u8 channel;
> +	u32 value;
> +};
> +
> +static int stmpe_read_voltage(struct stmpe_adc *info,
> +		struct iio_chan_spec const *chan, int *val)
> +{
> +	long ret;
> +
> +	mutex_lock(&info->lock);
> +
> +	info->channel =3D (u8)chan->channel;
> +
> +	if (info->channel > STMPE_ADC_LAST_NR) {
> +		mutex_unlock(&info->lock);
> +		return -EINVAL;
> +	}
> +
> +	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
> +			STMPE_ADC_CH(info->channel));
> +
> +	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
> +			STMPE_ADC_CH(info->channel));
> +
> +	*val =3D info->value;
> +
> +	ret =3D wait_for_completion_interruptible_timeout
> +		(&info->completion, STMPE_ADC_TIMEOUT);
> +
> +	if (ret <=3D 0) {
> +		mutex_unlock(&info->lock);
> +		if (ret =3D=3D 0)
> +			return -ETIMEDOUT;
> +		else
> +			return ret;
> +	}
> +
> +	*val =3D info->value;
> +
> +	mutex_unlock(&info->lock);
> +
> +	return 0;
> +}
> +
> +static int stmpe_read_temp(struct stmpe_adc *info,
> +		struct iio_chan_spec const *chan, int *val)
> +{
> +	long ret;
> +
> +	mutex_lock(&info->lock);
> +
> +	info->channel =3D (u8)chan->channel;
> +
> +	if (info->channel !=3D STMPE_TEMP_CHANNEL) {
> +		mutex_unlock(&info->lock);
> +		return -EINVAL;
> +	}
> +
> +	stmpe_reg_write(info->stmpe, STMPE_REG_TEMP_CTRL,
> +			STMPE_START_ONE_TEMP_CONV);
> +
> +	ret =3D wait_for_completion_interruptible_timeout
> +		(&info->completion, STMPE_ADC_TIMEOUT);
> +
> +	if (ret <=3D 0) {
> +		mutex_unlock(&info->lock);
> +		if (ret =3D=3D 0)
> +			return -ETIMEDOUT;
> +		else
> +			return ret;
> +	}
> +
> +	/*
> +	 * absolute temp =3D +V3.3 * value /7.51 [K]
> +	 * scale to [milli =C2=B0C]
> +	 */
> +	*val =3D ((449960l * info->value) / 1024l) - 273150;
> +
> +	mutex_unlock(&info->lock);
> +
> +	return 0;
> +}
> +
> +static int stmpe_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val,
> +			  int *val2,
> +			  long mask)
> +{
> +	struct stmpe_adc *info =3D iio_priv(indio_dev);
> +	long ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_PROCESSED:
> +
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			ret =3D stmpe_read_voltage(info, chan, val);
> +			break;
> +
> +		case IIO_TEMP:
> +			ret =3D stmpe_read_temp(info, chan, val);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 3300;
> +		*val2 =3D info->stmpe->mod_12b ? 12 : 10;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
> +{
> +	struct stmpe_adc *info =3D (struct stmpe_adc *)dev_id;
> +	u16 data;
> +
> +	if (info->channel > STMPE_TEMP_CHANNEL)
> +		return IRQ_NONE;
> +
> +	if (info->channel <=3D STMPE_ADC_LAST_NR) {
> +		int int_sta;
> +
> +		int_sta =3D stmpe_reg_read(info->stmpe, STMPE_REG_ADC_INT_STA);
> +
> +		/* Is the interrupt relevant */
> +		if (!(int_sta & STMPE_ADC_CH(info->channel)))
> +			return IRQ_NONE;
> +
> +		/* Read value */
> +		stmpe_block_read(info->stmpe,
> +			STMPE_REG_ADC_DATA_CH(info->channel), 2, (u8 *) &data);
> +
> +		stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_STA, int_sta);
> +	} else if (info->channel =3D=3D STMPE_TEMP_CHANNEL) {
> +		/* Read value */
> +		stmpe_block_read(info->stmpe, STMPE_REG_TEMP_DATA, 2,
> +				(u8 *) &data);
> +	}
> +
> +	info->value =3D (u32) be16_to_cpu(data);
> +	complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info stmpe_adc_iio_info =3D {
> +	.read_raw =3D &stmpe_read_raw,
> +};
> +
> +static void stmpe_adc_voltage_chan(struct iio_chan_spec *ics, int chan)
> +{
> +	ics->type =3D IIO_VOLTAGE;
> +	ics->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
> +	ics->info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE);
> +	ics->indexed =3D 1;
> +	ics->channel =3D chan;
> +}
> +
> +static void stmpe_adc_temp_chan(struct iio_chan_spec *ics, int chan)
> +{
> +	ics->type =3D IIO_TEMP;
> +	ics->info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED);
> +	ics->indexed =3D 1;
> +	ics->channel =3D chan;
> +}
> +
> +static int stmpe_adc_init_hw(struct stmpe_adc *adc)
> +{
> +	int ret;
> +	struct stmpe *stmpe =3D adc->stmpe;
> +
> +	ret =3D stmpe_enable(stmpe, STMPE_BLOCK_ADC);
> +	if (ret) {
> +		dev_err(stmpe->dev, "Could not enable clock for ADC\n");
> +		return ret;
> +	}
> +
> +	ret =3D stmpe811_adc_common_init(stmpe);
> +	if (ret) {
> +		stmpe_disable(stmpe, STMPE_BLOCK_ADC);
> +		return ret;
> +	}
> +
> +	/* use temp irq for each conversion completion */
> +	stmpe_reg_write(stmpe, STMPE_REG_TEMP_TH, 0);
> +	stmpe_reg_write(stmpe, STMPE_REG_TEMP_TH + 1, 0);
> +
> +	return 0;
> +}
> +
> +static int stmpe_adc_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev =3D NULL;

No need to initialize. It's set in all the paths where it can be used.

> +	struct stmpe_adc *info =3D NULL;

Same with this one.

> +	struct device_node *np;
> +	u32 norequest_mask =3D 0;
> +	int irq_temp, irq_adc;
> +	int num_chan =3D 0;
> +	int i =3D 0;
> +	int ret;
> +
> +	irq_adc =3D platform_get_irq_byname(pdev, "STMPE_ADC");
> +	if (irq_adc < 0)
> +		return irq_adc;
> +
> +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(struct stmpe_adc=
));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	info =3D iio_priv(indio_dev);
> +	mutex_init(&info->lock);
> +
> +	init_completion(&info->completion);
> +	ret =3D devm_request_threaded_irq(&pdev->dev, irq_adc, NULL,
> +					stmpe_adc_isr, IRQF_ONESHOT,
> +					"stmpe-adc", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed requesting irq, irq =3D %d\n",
> +				irq_adc);
> +		return ret;
> +	}
> +
> +	irq_temp =3D platform_get_irq_byname(pdev, "STMPE_TEMP_SENS");
> +	if (irq_temp >=3D 0) {
> +		ret =3D devm_request_threaded_irq(&pdev->dev, irq_temp, NULL,
> +						stmpe_adc_isr, IRQF_ONESHOT,
> +						"stmpe-adc", info);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "failed requesting irq for"
> +				 " temp sensor, irq =3D %d\n", irq_temp);
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->name		=3D dev_name(&pdev->dev);
> +	indio_dev->dev.parent	=3D &pdev->dev;
> +	indio_dev->info		=3D &stmpe_adc_iio_info;
> +	indio_dev->modes	=3D INDIO_DIRECT_MODE;
> +
> +	info->stmpe =3D dev_get_drvdata(pdev->dev.parent);
> +
> +	np =3D pdev->dev.of_node;
> +
> +	if (!np)
> +		dev_err(&pdev->dev, "no device tree node found\n");
> +
> +	of_property_read_u32(np, "st,norequest-mask", &norequest_mask);
> +
> +	for_each_clear_bit(i, (unsigned long *) &norequest_mask,
> +			   (STMPE_ADC_LAST_NR + 1)) {
> +		stmpe_adc_voltage_chan(&info->stmpe_adc_iio_channels[num_chan], i);
> +		num_chan++;
> +	}
> +	stmpe_adc_temp_chan(&info->stmpe_adc_iio_channels[num_chan], i);
> +	num_chan++;
> +	indio_dev->channels =3D info->stmpe_adc_iio_channels;
> +	indio_dev->num_channels =3D num_chan;
> +
> +	ret =3D stmpe_adc_init_hw(info);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(&pdev->dev,
> +			(void (*)(void *))iio_device_unregister, indio_dev);

Why do this?

devm_iio_device_register exists which is basically the same thing but
more readable!

> +}
> +
> +static int __maybe_unused stmpe_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct stmpe_adc *info =3D iio_priv(indio_dev);
> +
> +	stmpe_adc_init_hw(info);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(stmpe_adc_pm_ops, NULL, stmpe_adc_resume);
> +
> +static struct platform_driver stmpe_adc_driver =3D {
> +	.probe		=3D stmpe_adc_probe,
> +	.driver		=3D {
> +		.name	=3D "stmpe-adc",
> +		.pm	=3D &stmpe_adc_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(stmpe_adc_driver);
> +
> +MODULE_AUTHOR("Stefan Agner <stefan.agner@toradex.com>");
> +MODULE_DESCRIPTION("STMPEXXX ADC driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:stmpe-adc");

