Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE53C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DF420BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="Y0zAzXPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DF420BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389515AbeGLArD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:47:03 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33235 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389386AbeGLArD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:47:03 -0400
Received: by mail-io0-f195.google.com with SMTP id z20-v6so26258514iol.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qazZB8+/Zc4PKmsr/cxyx/qR0X+Xy3reyALADtugDww=;
        b=Y0zAzXPlNBZ4ml5Fk99HUpyGbf/kNCEuxFBnXelV/hdegojRfUDAWOvgj5b0/7NT+O
         5B17RSv21ywQjIoSC29hSwEYgTglrH+J9kg816xH78atIIwgCtjc7FRIoxAXNmb+FG6F
         3rfKPeBBSG6tTco2UFv2e9cWrwWtZXNBYaD0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qazZB8+/Zc4PKmsr/cxyx/qR0X+Xy3reyALADtugDww=;
        b=ntJ8Mb9/SGZOpGHfN6Va/z7dOkx1JclZnzKg0pxmLNqA4wGz/hnrTugrUzvV4uFogz
         kCOw14uh5A5F5pLunTyMtdcR8Z4kGTTOn5A6GY2ICk9E4vl5c3N9MHwdhxaIL3vZpWhq
         mD5NTdL1P0Yny8xLbeviqx148K5vpU/zgTu5NGgDDU20v54x8A77X/xljm6uUUxaGdy0
         C+WHzyTCxiVHP+VTcxLHztUp4CTrXtHrzBAEeUN9JrUa00U7ZpbS9emM69llmSLKqxRR
         khb2Y7AYA2JMQ/wUpHFDkDlV5pc3faCXL+qkDIrowtlIbORqaR0JCz91aST7WCQSNXNV
         +YKQ==
X-Gm-Message-State: AOUpUlEGAWnDKcnzFH+8f017ga4tcRot1VfyOfQBTQNKcd/J+ETNHoiK
        fY2SuMWrUCR6dtnGXnvF0wBPe+2HjiLDAuXOQwkcltx0NIQ=
X-Google-Smtp-Source: AAOMgpfgfFj03VfWe4PaE4aV55YjPAzYHvslPnChZMh2OnW+jyuD8bPtFZrF3w08rpnhFUy+iSkqa5HTiTtGCbZ+e0I=
X-Received: by 2002:a6b:cd83:: with SMTP id d125-v6mr980189iog.370.1531356007796;
 Wed, 11 Jul 2018 17:40:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:4847:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 17:40:07
 -0700 (PDT)
In-Reply-To: <1531311229-3586-1-git-send-email-himanshujha199640@gmail.com>
References: <1531311229-3586-1-git-send-email-himanshujha199640@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Wed, 11 Jul 2018 17:40:07 -0700
Message-ID: <CAJCx=g=ud98YWOAhepZOV_D_s8pfNx_PnyXis=WjX1O_XkzRvQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: chemical: Add support for Bosch BME680 sensor
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 5:13 AM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> Bosch BME680 is a 4-in-1 sensor with temperature, pressure, humidity
> and gas sensing capability. It supports both I2C and SPI communication
> protocol for effective data communication.
>
> The device supports two modes:
>
> 1. Sleep mode
> 2. Forced mode
>
> The measurements only takes place when forced mode is triggered and a
> single TPHG cycle is performed by the sensor. The sensor automatically
> goes to sleep after afterwards.
>
> The device has various calibration constants/parameters programmed into
> devices' non-volatile memory(NVM) during production and can't be altered
> by the user. These constants are used in the compensation functions to
> get the required compensated readings along with the raw data. The
> compensation functions/algorithms are provided by Bosch Sensortec GmbH
> via their API[1]. As these don't change during the measurement cycle,
> therefore we read and store them at the probe. The default configs
> supplied by Bosch are also set at probe.
>
> 0-day tested with build success.
>
> GSoC-2018: https://summerofcode.withgoogle.com/projects/#6691473790074880
> Mentor: Daniel Baluta
> [1] https://github.com/BoschSensortec/BME680_driver
> Datasheet:
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME680-DS001-00.pdf
>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>
> v3:
>    -moved files to chemical directory instead of a dedicated directory.
>    -read calibration parameters serially with endian conversions.
>    -drop some return ret.
>    -removed few unnecessary casts safely.
>    -added 'u' suffix to explicitly specify unsigned for large values
>     and thereby fixing comiler warning.
>    -left aligned all comments.
>    -added a comment explaining heater stability failure.
>
> v2:
>    -Used devm_add_action() to add a generic remove method for
>     both I2C & SPI driver.
>    -Introduction of compensation functions.
>    -chip initialisation routines moved to respective I2C and SPI
>     driver.
>    -Introduction of gas sensing rountines.
>    -Simplified Kconfig to reduce various options.
>
>  drivers/iio/chemical/Kconfig       |  25 +
>  drivers/iio/chemical/Makefile      |   3 +
>  drivers/iio/chemical/bme680.h      |  99 ++++
>  drivers/iio/chemical/bme680_core.c | 946 +++++++++++++++++++++++++++++++++++++
>  drivers/iio/chemical/bme680_i2c.c  |  83 ++++
>  drivers/iio/chemical/bme680_spi.c  | 123 +++++
>  6 files changed, 1279 insertions(+)
>  create mode 100644 drivers/iio/chemical/bme680.h
>  create mode 100644 drivers/iio/chemical/bme680_core.c
>  create mode 100644 drivers/iio/chemical/bme680_i2c.c
>  create mode 100644 drivers/iio/chemical/bme680_spi.c
>
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 5cb5be7..24790a8 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -21,6 +21,31 @@ config ATLAS_PH_SENSOR
>          To compile this driver as module, choose M here: the
>          module will be called atlas-ph-sensor.
>
> +config BME680
> +       tristate "Bosch Sensortec BME680 sensor driver"
> +       depends on (I2C || SPI)
> +       select REGMAP
> +       select BME680_I2C if (I2C)
> +       select BME680_SPI if (SPI)

Don't think you actually need parentheses around any of these, but of
course then again doesn't hurt

> +       help
> +         Say yes here to build support for Bosch Sensortec BME680 sensor with
> +         temperature, pressure, humidity and gas sensing capability.
> +
> +         This driver can also be built as a module. If so, the module for I2C
> +         would be called bme680_i2c and bme680_spi for SPI support.
> +
> +config BME680_I2C
> +       tristate
> +       depends on BME680
> +       depends on I2C

Wouldn't  "depends on I2C && BME680"  be cleaner?  Maybe someone else
here can tell me if I'm too nit-picky :)

> +       select REGMAP_I2C
> +
> +config BME680_SPI
> +       tristate
> +       depends on BME680
> +       depends on SPI

Same only with SPI

> +       select REGMAP_SPI
> +
>  config CCS811
>         tristate "AMS CCS811 VOC sensor"
>         depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index a629b29..2f4c4ba 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -4,6 +4,9 @@
>
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ATLAS_PH_SENSOR)  += atlas-ph-sensor.o
> +obj-$(CONFIG_BME680) += bme680_core.o
> +obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
> +obj-$(CONFIG_BME680_SPI) += bme680_spi.o
>  obj-$(CONFIG_CCS811)           += ccs811.o
>  obj-$(CONFIG_IAQCORE)          += ams-iaq-core.o
>  obj-$(CONFIG_VZ89X)            += vz89x.o
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> new file mode 100644
> index 0000000..80c4190
> --- /dev/null
> +++ b/drivers/iio/chemical/bme680.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BME680_H_
> +#define BME680_H_
> +
> +#define BME680_REG_CHIP_I2C_ID                 0xD0
> +#define BME680_REG_CHIP_SPI_ID                 0x50
> +#define BME680_CHIP_ID_VAL                     0x61
> +#define BME680_REG_SOFT_RESET                  0xE0
> +#define BME680_CMD_SOFTRESET                   0xB6
> +#define BME680_REG_STATUS                      0x73
> +#define   BME680_SPI_MEM_PAGE_BIT              BIT(4)
> +#define   BME680_SPI_MEM_PAGE_1_VAL            1
> +
> +#define BME680_OSRS_TEMP_X(osrs_t)             ((osrs_t) << 5)
> +#define BME680_OSRS_PRESS_X(osrs_p)            ((osrs_p) << 2)
> +#define BME680_OSRS_HUMID_X(osrs_h)            ((osrs_h) << 0)
> +
> +#define BME680_REG_TEMP_MSB                    0x22
> +#define BME680_REG_PRESS_MSB                   0x1F
> +#define BM6880_REG_HUMIDITY_MSB                        0x25
> +#define BME680_REG_GAS_MSB                     0x2A
> +#define BME680_REG_GAS_R_LSB                   0x2B
> +#define   BME680_GAS_STAB_BIT                  BIT(4)
> +
> +#define BME680_REG_CTRL_HUMIDITY               0x72
> +#define   BME680_OSRS_HUMIDITY_MASK            GENMASK(2, 0)
> +
> +#define BME680_REG_CTRL_MEAS                   0x74
> +#define   BME680_OSRS_TEMP_MASK                        GENMASK(7, 5)
> +#define   BME680_OSRS_PRESS_MASK               GENMASK(4, 2)
> +#define   BME680_MODE_MASK                     GENMASK(1, 0)
> +
> +#define BME680_MODE_FORCED                     BIT(0)
> +#define BME680_MODE_SLEEP                      0
> +
> +#define BME680_REG_CONFIG                      0x75
> +#define   BME680_FILTER_MASK                   GENMASK(4, 2)
> +#define   BME680_FILTER_COEFF                  BIT(1)
> +
> +/* TEMP/PRESS/HUMID reading skipped */
> +#define BME680_MEAS_SKIPPED                    0x8000
> +
> +#define BME680_MAX_OVERFLOW_VAL                        0x40000000
> +#define BME680_HUM_REG_SHIFT_VAL               4
> +#define BME680_BIT_H1_DATA_MSK                 0x0F
> +
> +#define BME680_REG_RES_HEAT_RANGE              0x02
> +#define BME680_RHRANGE_MSK                     0x30
> +#define BME680_REG_RES_HEAT_VAL                        0x00
> +#define BME680_REG_RANGE_SW_ERR                        0x04
> +#define BME680_RSERROR_MSK                     0xF0
> +#define BME680_REG_RES_HEAT_0                  0x5A
> +#define BME680_REG_GAS_WAIT_0                  0x64
> +#define BME680_GAS_RANGE_MASK                  0x0F
> +#define BME680_ADC_GAS_RES_SHIFT               6
> +#define BME680_AMB_TEMP                                25
> +
> +#define BME680_REG_CTRL_GAS_1                  0x71
> +#define   BME680_RUN_GAS_MASK                  BIT(4)
> +#define   BME680_NB_CONV_MASK                  GENMASK(3, 0)
> +#define        BME680_RUN_GAS_EN                       BIT(4)
> +#define BME680_NB_CONV_0                       0
> +
> +#define BME680_REG_MEAS_STAT_0                 0x1D
> +#define   BME680_GAS_MEAS_BIT                  BIT(6)
> +
> +/* Calibration Parameters */
> +#define BME680_T2_LSB_REG      0x8A
> +#define BME680_T3_REG          0x8C
> +#define BME680_P1_LSB_REG      0x8E
> +#define BME680_P2_LSB_REG      0x90
> +#define BME680_P3_REG          0x92
> +#define BME680_P4_LSB_REG      0x94
> +#define BME680_P5_LSB_REG      0x96
> +#define BME680_P7_REG          0x98
> +#define BME680_P6_REG          0x99
> +#define BME680_P8_LSB_REG      0x9C
> +#define BME680_P9_LSB_REG      0x9E
> +#define BME680_P10_REG         0xA0
> +#define BME680_H2_LSB_REG      0xE2
> +#define BME680_H2_MSB_REG      0xE1
> +#define BME680_H1_MSB_REG      0xE3
> +#define BME680_H1_LSB_REG      0xE2
> +#define BME680_H3_REG          0xE4
> +#define BME680_H4_REG          0xE5
> +#define BME680_H5_REG          0xE6
> +#define BME680_H6_REG          0xE7
> +#define BME680_H7_REG          0xE8
> +#define BME680_T1_LSB_REG      0xE9
> +#define BME680_GH2_LSB_REG     0xEB
> +#define BME680_GH1_REG         0xED
> +#define BME680_GH3_REG         0xEE
> +
> +extern const struct regmap_config bme680_regmap_config;
> +
> +int bme680_core_probe(struct device *dev, struct regmap *regmap,
> +                     const char *name);
> +
> +#endif  /* BME680_H_ */
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> new file mode 100644
> index 0000000..8dd789e
> --- /dev/null
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -0,0 +1,946 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Bosch BME680 - Temperature, Pressure, Humidity & Gas Sensor
> + *
> + * Copyright (C) 2017 - 2018 Bosch Sensortec GmbH
> + * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
> + */
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/log2.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include "bme680.h"
> +
> +struct bme680_calib {
> +       u16 par_t1;
> +       s16 par_t2;
> +       s8  par_t3;
> +       u16 par_p1;
> +       s16 par_p2;
> +       s8  par_p3;
> +       s16 par_p4;
> +       s16 par_p5;
> +       s8  par_p6;
> +       s8  par_p7;
> +       s16 par_p8;
> +       s16 par_p9;
> +       u8  par_p10;
> +       u16 par_h1;
> +       u16 par_h2;
> +       s8  par_h3;
> +       s8  par_h4;
> +       s8  par_h5;
> +       s8  par_h6;
> +       s8  par_h7;
> +       s8  par_gh1;
> +       s16 par_gh2;
> +       s8  par_gh3;
> +       u8  res_heat_range;
> +       s8  res_heat_val;
> +       s8  range_sw_err;
> +};
> +
> +struct bme680_data {
> +       struct regmap *regmap;
> +       struct bme680_calib bme680;
> +       u8 oversampling_temp;
> +       u8 oversampling_press;
> +       u8 oversampling_humid;
> +       u16 heater_dur;
> +       u16 heater_temp;
> +       /*
> +        * Carryover value from temperature conversion, used in pressure
> +        * and humidity compensation calculations.
> +        */
> +       s32 t_fine;
> +};
> +
> +const struct regmap_config bme680_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +};
> +EXPORT_SYMBOL(bme680_regmap_config);
> +
> +static const struct iio_chan_spec bme680_channels[] = {
> +       {
> +               .type = IIO_TEMP,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +                                     BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +       },
> +       {
> +               .type = IIO_PRESSURE,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +                                     BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +       },
> +       {
> +               .type = IIO_HUMIDITYRELATIVE,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +                                     BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +       },
> +       {
> +               .type = IIO_RESISTANCE,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +       },
> +};
> +
> +static const int bme680_oversampling_avail[] = { 1, 2, 4, 8, 16 };
> +
> +static int bme680_read_calib(struct bme680_data *data,
> +                            struct bme680_calib *calib)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       unsigned int tmp, tmp_msb, tmp_lsb;
> +       int ret;
> +       __le16 buf;
> +
> +       /* Temperature related coefficients */
> +       ret = regmap_bulk_read(data->regmap, BME680_T1_LSB_REG,
> +                              (u8 *) &buf, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_T1_LSB_REG\n");
> +               return ret;
> +       }
> +       calib->par_t1 = le16_to_cpu(buf);
> +
> +       ret = regmap_bulk_read(data->regmap, BME680_T2_LSB_REG,
> +                              (u8 *) &buf, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_T2_LSB_REG\n");
> +               return ret;
> +       }
> +       calib->par_t2 = le16_to_cpu(buf);
> +
> +       ret = regmap_read(data->regmap, BME680_T3_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_T3_REG\n");
> +               return ret;
> +       }
> +       calib->par_t3 = tmp;
> +
> +       /* Pressure related coefficients */
> +       ret = regmap_bulk_read(data->regmap, BME680_P1_LSB_REG,
> +                              (u8 *) &buf, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_P1_LSB_REG\n");
> +               return ret;
> +       }
> +       calib->par_p1 = le16_to_cpu(buf);
> +
> +       ret = regmap_bulk_read(data->regmap, BME680_P2_LSB_REG,
> +                              (u8 *) &buf, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_P2_LSB_REG\n");
> +               return ret;
> +       }
> +       calib->par_p2 = le16_to_cpu(buf);
> +
> +       ret = regmap_read(data->regmap, BME680_P3_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_P3_REG\n");
> +               return ret;
> +       }
> +       calib->par_p3 = tmp;
> +
> +       ret = regmap_bulk_read(data->regmap, BME680_P4_LSB_REG,
> +                              (u8 *) &buf, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_P4_LSB_REG\n");
> +               return ret;
> +       }
> +       calib->par_p4 = le16_to_cpu(buf);
> +
> +       ret = regmap_bulk_read(data->regmap, BME680_P5_LSB_REG,
> +                              (u8 *) &buf, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_P5_LSB_REG\n");
> +               return ret;
> +       }
> +       calib->par_p5 = le16_to_cpu(buf);
> +
> +       ret = regmap_read(data->regmap, BME680_P6_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_P6_REG\n");
> +               return ret;
> +       }
> +       calib->par_p6 = tmp;
> +
> +       ret = regmap_read(data->regmap, BME680_P7_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_P7_REG\n");
> +               return ret;
> +       }
> +       calib->par_p7 = tmp;
> +
> +       ret = regmap_bulk_read(data->regmap, BME680_P8_LSB_REG,
> +                              (u8 *) &buf, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_P8_LSB_REG\n");
> +               return ret;
> +       }
> +       calib->par_p8 = le16_to_cpu(buf);
> +
> +       ret = regmap_bulk_read(data->regmap, BME680_P9_LSB_REG,
> +                              (u8 *) &buf, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_P9_LSB_REG\n");
> +               return ret;
> +       }
> +       calib->par_p9 = le16_to_cpu(buf);
> +
> +       ret = regmap_read(data->regmap, BME680_P10_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_P10_REG\n");
> +               return ret;
> +       }
> +       calib->par_p10 = tmp;
> +
> +       /* Humidity related coefficients */
> +       ret = regmap_read(data->regmap, BME680_H1_MSB_REG, &tmp_msb);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_H1_MSB_REG\n");
> +               return ret;
> +       }
> +
> +       ret = regmap_read(data->regmap, BME680_H1_LSB_REG, &tmp_lsb);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_H1_LSB_REG\n");
> +               return ret;
> +       }
> +
> +       calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> +                               (tmp_lsb & BME680_BIT_H1_DATA_MSK);
> +
> +       ret = regmap_read(data->regmap, BME680_H2_MSB_REG, &tmp_msb);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_H2_MSB_REG\n");
> +               return ret;
> +       }
> +
> +       ret = regmap_read(data->regmap, BME680_H2_LSB_REG, &tmp_lsb);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_H2_LSB_REG\n");
> +               return ret;
> +       }
> +
> +       calib->par_h2 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> +                               (tmp_lsb >> BME680_HUM_REG_SHIFT_VAL);
> +
> +       ret = regmap_read(data->regmap, BME680_H3_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_H3_REG\n");
> +               return ret;
> +       }
> +       calib->par_h3 = tmp;
> +
> +       ret = regmap_read(data->regmap, BME680_H4_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_H4_REG\n");
> +               return ret;
> +       }
> +       calib->par_h4 = tmp;
> +
> +       ret = regmap_read(data->regmap, BME680_H5_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_H5_REG\n");
> +               return ret;
> +       }
> +       calib->par_h5 = tmp;
> +
> +       ret = regmap_read(data->regmap, BME680_H6_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_H6_REG\n");
> +               return ret;
> +       }
> +       calib->par_h6 = tmp;
> +
> +       ret = regmap_read(data->regmap, BME680_H7_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_H7_REG\n");
> +               return ret;
> +       }
> +       calib->par_h7 = tmp;
> +
> +       /* Gas heater related coefficients */
> +       ret = regmap_read(data->regmap, BME680_GH1_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_GH1_REG\n");
> +               return ret;
> +       }
> +       calib->par_gh1 = tmp;
> +
> +       ret = regmap_bulk_read(data->regmap, BME680_GH2_LSB_REG,
> +                              (u8 *) &buf, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_GH2_LSB_REG\n");
> +               return ret;
> +       }
> +       calib->par_gh2 = le16_to_cpu(buf);
> +
> +       ret = regmap_read(data->regmap, BME680_GH3_REG, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read BME680_GH3_REG\n");
> +               return ret;
> +       }
> +       calib->par_gh3 = tmp;
> +
> +       /* Other coefficients */
> +       ret = regmap_read(data->regmap, BME680_REG_RES_HEAT_RANGE, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read resistance heat range\n");
> +               return ret;
> +       }
> +       calib->res_heat_range = (tmp & BME680_RHRANGE_MSK) / 16;
> +
> +       ret = regmap_read(data->regmap, BME680_REG_RES_HEAT_VAL, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read resistance heat value\n");
> +               return ret;
> +       }
> +       calib->res_heat_val = tmp;
> +
> +       ret = regmap_read(data->regmap, BME680_REG_RANGE_SW_ERR, &tmp);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read range software error\n");
> +               return ret;
> +       }
> +       calib->range_sw_err = (tmp & BME680_RSERROR_MSK) / 16;
> +
> +       return 0;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static s32 bme680_compensate_temp(struct bme680_data *data,
> +                                 s32 adc_temp)
> +{
> +       struct bme680_calib *calib = &data->bme680;
> +       s64 var1, var2, var3, calc_temp;
> +
> +       var1 = ((s32) adc_temp >> 3) - ((s32) calib->par_t1 << 1);
> +       var2 = (var1 * (s32) calib->par_t2) >> 11;
> +       var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
> +       var3 = ((var3) * ((s32) calib->par_t3 << 4)) >> 14;
> +       data->t_fine = (s32) (var2 + var3);
> +       calc_temp = (s16) (((data->t_fine * 5) + 128) >> 8);
> +
> +       return calc_temp;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static u32 bme680_compensate_press(struct bme680_data *data,
> +                                  u32 adc_press)
> +{
> +       struct bme680_calib *calib = &data->bme680;
> +       s32 var1, var2, var3, press_comp;
> +
> +       var1 = (((s32)data->t_fine) >> 1) - 64000;
> +       var2 = ((((var1 >> 2) * (var1 >> 2)) >> 11) * (s32)calib->par_p6) >> 2;
> +       var2 = var2 + ((var1 * (s32)calib->par_p5) << 1);
> +       var2 = (var2 >> 2) + ((s32)calib->par_p4 << 16);
> +       var1 = (((((var1 >> 2) * (var1 >> 2)) >> 13) *
> +                       ((s32)calib->par_p3 << 5)) >> 3) +
> +                       (((s32)calib->par_p2 * var1) >> 1);
> +       var1 = var1 >> 18;
> +       var1 = ((32768 + var1) * (s32)calib->par_p1) >> 15;
> +       press_comp = 1048576 - adc_press;
> +       press_comp = ((press_comp - (var2 >> 12)) * 3125);
> +
> +       if (press_comp >= BME680_MAX_OVERFLOW_VAL)
> +               press_comp = ((press_comp / (u32)var1) << 1);
> +       else
> +               press_comp = ((press_comp << 1) / (u32)var1);
> +
> +       var1 = ((s32)calib->par_p9 * (((press_comp >> 3) *
> +                                    (press_comp >> 3)) >> 13)) >> 12;
> +       var2 = ((press_comp >> 2) * (s32)calib->par_p8) >> 13;
> +       var3 = ((press_comp >> 8) * (press_comp >> 8) *
> +                       (press_comp >> 8) * calib->par_p10) >> 17;
> +
> +       press_comp += ((var1 + var2 + var3 + ((s32)calib->par_p7 << 7)) >> 4);
> +
> +       return press_comp;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static u32 bme680_compensate_humid(struct bme680_data *data,
> +                                  u16 adc_humid)
> +{
> +       struct bme680_calib *calib = &data->bme680;
> +       s32 var1, var2, var3, var4, var5, var6, temp_scaled, calc_hum;
> +
> +       temp_scaled = (((s32) data->t_fine * 5) + 128) >> 8;
> +       var1 = (adc_humid - ((s32) ((s32) calib->par_h1 * 16))) -
> +                       (((temp_scaled * (s32) calib->par_h3) / 100) >> 1);
> +       var2 = ((s32) calib->par_h2 * (((temp_scaled * (s32) calib->par_h4) /
> +                       ((s32) 100)) + (((temp_scaled * ((temp_scaled *
> +                       (s32) calib->par_h5) / 100)) >> 6) / 100) +
> +                       (s32) (1 << 14))) >> 10;
> +       var3 = var1 * var2;
> +       var4 = (s32) calib->par_h6 << 7;
> +       var4 = (var4 + ((temp_scaled * (s32) calib->par_h7) / 100)) >> 4;
> +       var5 = ((var3 >> 14) * (var3 >> 14)) >> 10;
> +       var6 = (var4 * var5) >> 1;
> +       calc_hum = (((var3 + var6) >> 10) * 1000) >> 12;
> +
> +       if (calc_hum > 100000) /* Cap at 100%rH */
> +               calc_hum = 100000;
> +       else if (calc_hum < 0)
> +               calc_hum = 0;
> +
> +       return calc_hum;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
> +                                u8 gas_range)
> +{
> +       struct bme680_calib *calib = &data->bme680;
> +       s64 var1;
> +       u64 var2;
> +       s64 var3;
> +       u32 calc_gas_res;
> +
> +       /* Look up table 1 for the possible gas range values */
> +       u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
> +                               2147483647u, 2147483647u, 2126008810u,
> +                               2147483647u, 2130303777u, 2147483647u,
> +                               2147483647u, 2143188679u, 2136746228u,
> +                               2147483647u, 2126008810u, 2147483647u,
> +                               2147483647u};
> +       /* Look up table 2 for the possible gas range values */
> +       u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
> +                               512000000u, 255744255u, 127110228u, 64000000u,
> +                               32258064u, 16016016u, 8000000u, 4000000u,
> +                               2000000u, 1000000u, 500000u, 250000u, 125000u};
> +
> +       var1 = ((1340 + (5 * (s64) calib->range_sw_err)) *
> +                       ((s64) lookupTable1[gas_range])) >> 16;
> +       var2 = (((s64) ((s64) gas_res_adc << 15) - 16777216) + var1);
> +       var3 = (((s64) lookupTable2[gas_range] * (s64) var1) >> 9);
> +       calc_gas_res = (u32) ((var3 + ((s64) var2 >> 1)) / (s64) var2);
> +
> +       return calc_gas_res;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static u8 bme680_calc_heater_res(struct bme680_data *data, u16 temp)
> +{
> +       struct bme680_calib *calib = &data->bme680;
> +       s32 var1, var2, var3, var4, var5, heatr_res_x100;
> +       u8 heatr_res;
> +
> +       if (temp > 400) /* Cap temperature */
> +               temp = 400;
> +
> +       var1 = (((s32) BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
> +       var2 = (calib->par_gh1 + 784) * (((((calib->par_gh2 + 154009) *
> +                                               temp * 5) / 100)
> +                                               + 3276800) / 10);
> +       var3 = var1 + (var2 / 2);
> +       var4 = (var3 / (calib->res_heat_range + 4));
> +       var5 = (131 * calib->res_heat_val) + 65536;
> +       heatr_res_x100 = ((var4 / var5) - 250) * 34;
> +       heatr_res = (heatr_res_x100 + 50) / 100;
> +
> +       return heatr_res;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static u8 bme680_calc_heater_dur(u16 dur)
> +{
> +       u8 durval, factor = 0;
> +
> +       if (dur >= 0xfc0) {
> +               durval = 0xff; /* Max duration */
> +       } else {
> +               while (dur > 0x3F) {
> +                       dur = dur / 4;
> +                       factor += 1;
> +               }
> +               durval = dur + (factor * 64);
> +       }
> +
> +       return durval;
> +}
> +
> +static int bme680_set_mode(struct bme680_data *data, bool mode)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret;
> +
> +       if (mode) {
> +               ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> +                                       BME680_MODE_MASK, BME680_MODE_FORCED);
> +               if (ret < 0)
> +                       dev_err(dev, "failed to set forced mode\n");
> +
> +       } else {
> +               ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> +                                       BME680_MODE_MASK, BME680_MODE_SLEEP);
> +               if (ret < 0)
> +                       dev_err(dev, "failed to set sleep mode\n");
> +
> +       }
> +
> +       return ret;
> +}
> +
> +static int bme680_chip_config(struct bme680_data *data)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret;
> +       u8 osrs = BME680_OSRS_HUMID_X(data->oversampling_humid + 1);
> +       /*
> +        * Highly recommended to set oversampling of humidity before
> +        * temperature/pressure oversampling.
> +        */
> +       ret = regmap_update_bits(data->regmap, BME680_REG_CTRL_HUMIDITY,
> +                                BME680_OSRS_HUMIDITY_MASK, osrs);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to write ctrl_hum register\n");
> +               return ret;
> +       }
> +
> +       /* IIR filter settings */
> +       ret = regmap_update_bits(data->regmap, BME680_REG_CONFIG,
> +                                BME680_FILTER_MASK,
> +                                BME680_FILTER_COEFF);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to write config register\n");
> +               return ret;
> +       }
> +
> +       osrs = BME680_OSRS_TEMP_X(data->oversampling_temp + 1) |
> +               BME680_OSRS_PRESS_X(data->oversampling_press + 1);
> +
> +       ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> +                               BME680_OSRS_TEMP_MASK |
> +                               BME680_OSRS_PRESS_MASK,
> +                               osrs);
> +       if (ret < 0)
> +               dev_err(dev, "failed to write ctrl_meas register\n");
> +
> +       return ret;
> +}
> +
> +static int bme680_gas_config(struct bme680_data *data)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret;
> +       u8 heatr_res, heatr_dur;
> +
> +       heatr_res = bme680_calc_heater_res(data, data->heater_temp);
> +
> +       /* set target heater temperature */
> +       ret = regmap_write(data->regmap, BME680_REG_RES_HEAT_0, heatr_res);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to write res_heat_0 register\n");
> +               return ret;
> +       }
> +
> +       heatr_dur = bme680_calc_heater_dur(data->heater_dur);
> +
> +       /* set target heating duration */
> +       ret = regmap_write(data->regmap, BME680_REG_GAS_WAIT_0, heatr_dur);
> +       if (ret < 0) {
> +               dev_err(dev, "failted to write gas_wait_0 register\n");
> +               return ret;
> +       }
> +
> +       /* Selecting the runGas and NB conversion settings for the sensor */
> +       ret = regmap_update_bits(data->regmap, BME680_REG_CTRL_GAS_1,
> +                                BME680_RUN_GAS_MASK | BME680_NB_CONV_MASK,
> +                                BME680_RUN_GAS_EN | BME680_NB_CONV_0);
> +       if (ret < 0)
> +               dev_err(dev, "failed to write ctrl_gas_1 register\n");
> +
> +       return ret;
> +}
> +
> +/* Outputs temperature measurement in degC */
> +static int bme680_read_temp(struct bme680_data *data,
> +                           int *val, int *val2)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret = 0;
> +       __be32 tmp = 0;
> +       s32 adc_temp, comp_temp;
> +
> +       /* set forced mode to trigger measurement */
> +       ret = bme680_set_mode(data, true);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
> +                              (u8 *) &tmp, 3);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read temperature\n");
> +               return ret;
> +       }
> +
> +       adc_temp = be32_to_cpu(tmp) >> 12;
> +       if (adc_temp == BME680_MEAS_SKIPPED) {
> +               /* reading was skipped */
> +               dev_err(dev, "reading temperature skipped\n");
> +               return -EINVAL;
> +       }
> +       comp_temp = bme680_compensate_temp(data, adc_temp);
> +       /*
> +        * val might be NULL if we're called by the read_press/read_humid
> +        * routine which is callled to get t_fine value used in
> +        * compensate_press/compensate_humid to get compensated
> +        * pressure/humidity readings.
> +        */
> +       if (val && val2) {
> +               *val = comp_temp;
> +               *val2 = 100;
> +               return IIO_VAL_FRACTIONAL;
> +       }
> +
> +       return ret;
> +}
> +
> +/* Outputs pressure measurement in hPa */
> +static int bme680_read_press(struct bme680_data *data,
> +                            int *val, int *val2)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret;
> +       __be32 tmp = 0;
> +       s32 adc_press;
> +
> +       /* Read and compensate temperature to get a reading of t_fine */
> +       ret = bme680_read_temp(data, NULL, NULL);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = regmap_bulk_read(data->regmap, BME680_REG_PRESS_MSB,
> +                              (u8 *) &tmp, 3);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read pressure\n");
> +               return ret;
> +       }
> +
> +       adc_press = be32_to_cpu(tmp) >> 12;
> +       if (adc_press == BME680_MEAS_SKIPPED) {
> +               /* reading was skipped */
> +               dev_err(dev, "reading pressure skipped\n");
> +               return -EINVAL;
> +       }
> +
> +       *val = bme680_compensate_press(data, adc_press);
> +       *val2 = 100;
> +       return IIO_VAL_FRACTIONAL;
> +}
> +
> +/* Outputs humidity measurement in %r.H */
> +static int bme680_read_humid(struct bme680_data *data,
> +                            int *val, int *val2)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret;
> +       __be16 tmp = 0;
> +       s32 adc_humidity;
> +       u32 comp_humidity;
> +
> +       /* Read and compensate temperature so we get a reading of t_fine */
> +       ret = bme680_read_temp(data, NULL, NULL);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = regmap_bulk_read(data->regmap, BM6880_REG_HUMIDITY_MSB,
> +                              (u8 *) &tmp, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read humidity\n");
> +               return ret;
> +       }
> +
> +       adc_humidity = be16_to_cpu(tmp);
> +       if (adc_humidity == BME680_MEAS_SKIPPED) {
> +               /* reading was skipped */
> +               dev_err(dev, "reading humidity skipped\n");
> +               return -EINVAL;
> +       }
> +       comp_humidity = bme680_compensate_humid(data, adc_humidity);
> +
> +       *val = comp_humidity;
> +       *val2 = 1000;
> +       return IIO_VAL_FRACTIONAL;
> +}
> +
> +/* Outputs gas measurement in ohm */
> +static int bme680_read_gas(struct bme680_data *data,
> +                          int *val)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret;
> +       __be16 tmp = 0;
> +       unsigned int check;
> +       u16 adc_gas_res;
> +       u8 gas_range;
> +
> +       /* Set heater settings */
> +       ret = bme680_gas_config(data);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to set gas config\n");
> +               return ret;
> +       }
> +
> +       /* set forced mode to trigger a single measurement */
> +       ret = bme680_set_mode(data, true);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
> +       if (check & BME680_GAS_MEAS_BIT) {
> +               dev_err(dev, "gas measurement incomplete\n");
> +               return -EBUSY;
> +       }
> +
> +       ret = regmap_read(data->regmap, BME680_REG_GAS_R_LSB, &check);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read gas_r_lsb register\n");
> +               return ret;
> +       }
> +
> +       if ((check & BME680_GAS_STAB_BIT) == 0) {
> +       /*
> +        * occurs if either the gas heating duration was insuffient
> +        * to reach the target heater temperature or the target
> +        * heater temperature was too high for the heater sink to
> +        * reach.
> +        */
> +               dev_err(dev, "heater failed to reach the target temperature\n");
> +               return -EINVAL;
> +       }
> +
> +       ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
> +                              (u8 *) &tmp, 2);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read gas resistance\n");
> +               return ret;
> +       }
> +
> +       gas_range = check & BME680_GAS_RANGE_MASK;
> +       adc_gas_res = be16_to_cpu(tmp) >> BME680_ADC_GAS_RES_SHIFT;
> +
> +       *val = bme680_compensate_gas(data, adc_gas_res, gas_range);
> +       return IIO_VAL_INT;
> +}
> +
> +static int bme680_read_raw(struct iio_dev *indio_dev,
> +                          struct iio_chan_spec const *chan,
> +                          int *val, int *val2, long mask)
> +{
> +       struct bme680_data *data = iio_priv(indio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_PROCESSED:
> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       return bme680_read_temp(data, val, val2);
> +               case IIO_PRESSURE:
> +                       return bme680_read_press(data, val, val2);
> +               case IIO_HUMIDITYRELATIVE:
> +                       return bme680_read_humid(data, val, val2);
> +               case IIO_RESISTANCE:
> +                       return bme680_read_gas(data, val);
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       *val = 1 << data->oversampling_temp;
> +                       return IIO_VAL_INT;
> +               case IIO_PRESSURE:
> +                       *val = 1 << data->oversampling_press;
> +                       return IIO_VAL_INT;
> +               case IIO_HUMIDITYRELATIVE:
> +                       *val = 1 << data->oversampling_humid;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int bme680_write_oversampling_ratio_temp(struct bme680_data *data,
> +                                               int val)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); ++i) {
> +               if (bme680_oversampling_avail[i] == val) {
> +                       data->oversampling_temp = ilog2(val);
> +
> +                       return bme680_chip_config(data);
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int bme680_write_oversampling_ratio_press(struct bme680_data *data,
> +                                                int val)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); ++i) {
> +               if (bme680_oversampling_avail[i] == val) {
> +                       data->oversampling_press = ilog2(val);
> +
> +                       return bme680_chip_config(data);
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int bme680_write_oversampling_ratio_humid(struct bme680_data *data,
> +                                                int val)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); ++i) {
> +               if (bme680_oversampling_avail[i] == val) {
> +                       data->oversampling_humid = ilog2(val);
> +
> +                       return bme680_chip_config(data);
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int bme680_write_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int val, int val2, long mask)
> +{
> +       struct bme680_data *data = iio_priv(indio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       return bme680_write_oversampling_ratio_temp(data, val);
> +               case IIO_PRESSURE:
> +                       return bme680_write_oversampling_ratio_press(data, val);
> +               case IIO_HUMIDITYRELATIVE:
> +                       return bme680_write_oversampling_ratio_humid(data, val);
> +               default:
> +                       return -EINVAL;
> +               }
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static const char bme680_oversampling_ratio_show[] = "1 2 4 8 16";
> +
> +static IIO_CONST_ATTR(oversampling_ratio_available,
> +                     bme680_oversampling_ratio_show);
> +
> +static struct attribute *bme680_attributes[] = {
> +       &iio_const_attr_oversampling_ratio_available.dev_attr.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group bme680_attribute_group = {
> +       .attrs = bme680_attributes,
> +};
> +
> +static const struct iio_info bme680_info = {
> +       .read_raw = &bme680_read_raw,
> +       .write_raw = &bme680_write_raw,
> +       .attrs = &bme680_attribute_group,
> +};
> +
> +static const char *bme680_match_acpi_device(struct device *dev)
> +{
> +       const struct acpi_device_id *id;
> +
> +       id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +       if (!id)
> +               return NULL;
> +
> +       return dev_name(dev);
> +}
> +
> +static void bme680_core_remove(void *arg)
> +{
> +       iio_device_unregister(arg);
> +}
> +
> +int bme680_core_probe(struct device *dev, struct regmap *regmap,
> +                     const char *name)
> +{
> +       struct iio_dev *indio_dev;
> +       struct bme680_data *data;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       ret = devm_add_action(dev, bme680_core_remove, indio_dev);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to register remove action\n");
> +               return ret;
> +       }
> +
> +       if (!name && ACPI_HANDLE(dev))
> +               name = bme680_match_acpi_device(dev);
> +
> +       data = iio_priv(indio_dev);
> +       dev_set_drvdata(dev, indio_dev);
> +       data->regmap = regmap;
> +       indio_dev->dev.parent = dev;
> +       indio_dev->name = name;
> +       indio_dev->channels = bme680_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(bme680_channels);
> +       indio_dev->info = &bme680_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +       /* default values for the sensor */
> +       data->oversampling_humid = ilog2(2); /* 2X oversampling rate */
> +       data->oversampling_press = ilog2(4); /* 4X oversampling rate */
> +       data->oversampling_temp = ilog2(8);  /* 8X oversampling rate */
> +       data->heater_temp = 320; /* degree Celsius */
> +       data->heater_dur = 150;  /* milliseconds */
> +
> +       ret = bme680_chip_config(data);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to set chip_config data\n");
> +               return ret;
> +       }
> +
> +       ret = bme680_gas_config(data);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to set gas config data\n");
> +               return ret;
> +       }
> +
> +       ret = bme680_read_calib(data, &data->bme680);
> +       if (ret < 0) {
> +               dev_err(dev,
> +                       "failed to read calibration coefficients at probe\n");
> +               return ret;
> +       }
> +
> +       return iio_device_register(indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(bme680_core_probe);
> +
> +MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> +MODULE_DESCRIPTION("Bosch BME680 Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
> new file mode 100644
> index 0000000..a3a77cf
> --- /dev/null
> +++ b/drivers/iio/chemical/bme680_i2c.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BME680 - I2C Driver
> + *
> + * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
> + *
> + * 7-Bit I2C slave address is:
> + *     - 0x76 if SDO is pulled to GND
> + *     - 0x77 if SDO is pulled to VDDIO
> + *
> + * Note: SDO pin cannot be left floating otherwise I2C address
> + *      will be undefined.
> + */
> +#include <linux/acpi.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "bme680.h"
> +
> +static int bme680_i2c_probe(struct i2c_client *client,
> +                           const struct i2c_device_id *id)
> +{
> +       struct regmap *regmap;
> +       const char *name = NULL;
> +       unsigned int val;
> +       int ret;
> +
> +       regmap = devm_regmap_init_i2c(client, &bme680_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> +                               (int)PTR_ERR(regmap));
> +               return PTR_ERR(regmap);
> +       }
> +
> +       ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
> +                          BME680_CMD_SOFTRESET);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = regmap_read(regmap, BME680_REG_CHIP_I2C_ID, &val);
> +       if (ret < 0) {
> +               dev_err(&client->dev, "Error reading I2C chip ID\n");
> +               return ret;
> +       }
> +
> +       if (val != BME680_CHIP_ID_VAL) {
> +               dev_err(&client->dev, "Wrong chip ID, got %x expected %x\n",
> +                               val, BME680_CHIP_ID_VAL);
> +               return -ENODEV;
> +       }
> +
> +       if (id)
> +               name = id->name;
> +
> +       return bme680_core_probe(&client->dev, regmap, name);
> +}
> +
> +static const struct i2c_device_id bme680_i2c_id[] = {
> +       {"bme680", 0},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
> +
> +static const struct acpi_device_id bme680_acpi_match[] = {
> +       {"BME0680", 0},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> +
> +static struct i2c_driver bme680_i2c_driver = {
> +       .driver = {
> +               .name                   = "bme680_i2c",
> +               .acpi_match_table       = ACPI_PTR(bme680_acpi_match),
> +       },
> +       .probe = bme680_i2c_probe,
> +       .id_table = bme680_i2c_id,
> +};
> +module_i2c_driver(bme680_i2c_driver);
> +
> +MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> +MODULE_DESCRIPTION("BME680 I2C driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
> new file mode 100644
> index 0000000..1fb3466
> --- /dev/null
> +++ b/drivers/iio/chemical/bme680_spi.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BME680 - SPI Driver
> + *
> + * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
> + */
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "bme680.h"
> +
> +static int bme680_regmap_spi_write(void *context, const void *data,
> +                                  size_t count)
> +{
> +       struct spi_device *spi = context;
> +       u8 buf[2];
> +
> +       memcpy(buf, data, 2);
> +       /*
> +        * The SPI register address (= full register address without bit 7)
> +        * and the write command (bit7 = RW = '0')
> +        */
> +       buf[0] &= ~0x80;
> +
> +       return spi_write_then_read(spi, buf, 2, NULL, 0);
> +}
> +
> +static int bme680_regmap_spi_read(void *context, const void *reg,
> +                                 size_t reg_size, void *val, size_t val_size)
> +{
> +       struct spi_device *spi = context;
> +
> +       return spi_write_then_read(spi, reg, reg_size, val, val_size);
> +}
> +
> +static struct regmap_bus bme680_regmap_bus = {
> +       .write = bme680_regmap_spi_write,
> +       .read = bme680_regmap_spi_read,
> +       .reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +       .val_format_endian_default = REGMAP_ENDIAN_BIG,
> +};
> +
> +static int bme680_spi_probe(struct spi_device *spi)
> +{
> +       const struct spi_device_id *id = spi_get_device_id(spi);
> +       struct regmap *regmap;
> +       unsigned int val;
> +       int ret;
> +
> +       spi->bits_per_word = 8;
> +       ret = spi_setup(spi);
> +       if (ret < 0) {
> +               dev_err(&spi->dev, "spi_setup failed!\n");
> +               return ret;
> +       }
> +
> +       regmap = devm_regmap_init(&spi->dev, &bme680_regmap_bus,
> +                                 &spi->dev, &bme680_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +                               (int)PTR_ERR(regmap));
> +               return PTR_ERR(regmap);
> +       }
> +
> +       ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
> +                          BME680_CMD_SOFTRESET);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* after power-on reset, Page 0(0x80-0xFF) of spi_mem_page is active */
> +       ret = regmap_read(regmap, BME680_REG_CHIP_SPI_ID, &val);
> +       if (ret < 0) {
> +               dev_err(&spi->dev, "Error reading SPI chip ID\n");
> +               return ret;
> +       }
> +
> +       if (val != BME680_CHIP_ID_VAL) {
> +               dev_err(&spi->dev, "Wrong chip ID, got %x expected %x\n",
> +                               val, BME680_CHIP_ID_VAL);
> +               return -ENODEV;
> +       }
> +       /*
> +        * select Page 1 of spi_mem_page to enable access to
> +        * to registers from address 0x00 to 0x7F.
> +        */
> +       ret = regmap_write_bits(regmap, BME680_REG_STATUS,
> +                               BME680_SPI_MEM_PAGE_BIT,
> +                               BME680_SPI_MEM_PAGE_1_VAL);
> +       if (ret < 0) {
> +               dev_err(&spi->dev, "failed to set page 1 of spi_mem_page\n");
> +               return ret;
> +       }
> +
> +       return bme680_core_probe(&spi->dev, regmap, id->name);
> +}
> +
> +static const struct spi_device_id bme680_spi_id[] = {
> +       {"bme680", 0},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(spi, bme680_spi_id);
> +
> +static const struct acpi_device_id bme680_acpi_match[] = {
> +       {"BME0680", 0},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> +
> +static struct spi_driver bme680_spi_driver = {
> +       .driver = {
> +               .name                   = "bme680_spi",
> +               .acpi_match_table       = ACPI_PTR(bme680_acpi_match),
> +       },
> +       .probe = bme680_spi_probe,
> +       .id_table = bme680_spi_id,
> +};
> +module_spi_driver(bme680_spi_driver);
> +
> +MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> +MODULE_DESCRIPTION("Bosch BME680 SPI driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
