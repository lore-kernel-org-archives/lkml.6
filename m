Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D594C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 02:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D130B208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 02:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EqKvxp3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D130B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935885AbeFNCnq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 22:43:46 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37312 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935736AbeFNCno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 22:43:44 -0400
Received: by mail-oi0-f66.google.com with SMTP id l22-v6so4297305oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 19:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R8KEjr0SRyxF1ITr840x82OM0a2T25AhefG7I+8R7dA=;
        b=EqKvxp3jSRnlFS3uI6hZq3cDAKi/RO6mXib44qZLzuItXmm50px7cvT2SwZ2RRO4J4
         95EZphhefkPAYLiLngkEP3af9+Cv5BHvGr/dHSgjdg6rW4AlHbvlTyMIwIUCLf92A4US
         ikRpVXestrVPk8mYJF5Sibejtb2IUdCtDvArw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R8KEjr0SRyxF1ITr840x82OM0a2T25AhefG7I+8R7dA=;
        b=RFWvcA9kIo1RwmznUwwTolCQv1OJVqs/NrLDHR8PgOJ5DZvOXCmXyVUI2IvXm3kGl3
         Wz1MuNXCoiCxJGJgakFXicl8tlhmy/kkIxbgvqt27dUMbN9IOlYnWXCSQiOq7Vuk2RM7
         RFRT7DvbaCNG104NHHdplUlPbGLMBhNsOO8ELhUhkSFvK6CDeOcEhayZTw8W2TyQuClw
         gSdV7p4zKO0Pk1VqgAXfNNTh/RQgksbWApzCc7WUTrQNrhBvpaTFlB35bHL5Kf+uuzqW
         4aVP85pMsk8ZF56BbQoBUk3ROD2M1droNoh2WWWXcbka8IhoexaKQPRMS4AafkeyazAC
         5TBg==
X-Gm-Message-State: APt69E1UpOH/APnNLGY03HLQ4Tvi54X8NHtSnvmsuAR1HpQ6sQ7ZxMX8
        PVMut1k5g/x8LAzMCvVPSnxmcOrQsg1NG1jOMOA/VA==
X-Google-Smtp-Source: ADUXVKLGkH8/PrHdZxnQNrCZIIW7BpOtYnM8Y35uooMTGEjOCY122lnrrZYCeyslnf5TWdixmxNwvnMB33Lr/at0Gbk=
X-Received: by 2002:aca:d9c5:: with SMTP id q188-v6mr391581oig.168.1528944223942;
 Wed, 13 Jun 2018 19:43:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d44:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 19:43:43
 -0700 (PDT)
In-Reply-To: <CAMz4ku+bkt_OB_rchYmOkmCx6XcNZkONSgfdifOi4hz9Xyv+ig@mail.gmail.com>
References: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1528871668.git.baolin.wang@linaro.org>
 <25f44d68e5bb003a5d89545dd6493175af41d107.1528871668.git.baolin.wang@linaro.org>
 <alpine.DEB.2.21.1806131034001.18339@vps.pmeerw.net> <CAMz4ku+bkt_OB_rchYmOkmCx6XcNZkONSgfdifOi4hz9Xyv+ig@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 14 Jun 2018 10:43:43 +0800
Message-ID: <CAMz4kuJVghre3jFHHNZqZZoLrpZFYVmfxEEQoPf6eA5YDtknZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: Add Spreadtrum SC27XX PMICs ADC support
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        freeman.liu@spreadtrum.com, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 13 June 2018 at 17:17, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi Peter,
>
> On 13 June 2018 at 16:53, Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
>>
>>> From: Freeman Liu <freeman.liu@spreadtrum.com>
>>
>> some comments below
>>
>>> The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
>>> which is used to sample voltages with 12 bits conversion.
>>>
>>> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> ---
>>>  drivers/iio/adc/Kconfig      |   10 +
>>>  drivers/iio/adc/Makefile     |    1 +
>>>  drivers/iio/adc/sc27xx_adc.c |  558 ++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 569 insertions(+)
>>>  create mode 100644 drivers/iio/adc/sc27xx_adc.c
>>>
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index 9da7907..985b73e 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -621,6 +621,16 @@ config ROCKCHIP_SARADC
>>>         To compile this driver as a module, choose M here: the
>>>         module will be called rockchip_saradc.
>>>
>>> +config SC27XX_ADC
>>> +     tristate "Spreadtrum SC27xx series PMICs ADC"
>>> +     depends on MFD_SC27XX_PMIC || COMPILE_TEST
>>> +     help
>>> +       Say yes here to build support for the integrated ADC inside the
>>> +       Spreadtrum SC27xx series PMICs.
>>> +
>>> +       This driver can also be built as a module. If so, the module
>>> +       will be called sc27xx_adc.
>>> +
>>>  config SPEAR_ADC
>>>       tristate "ST SPEAr ADC"
>>>       depends on PLAT_SPEAR || COMPILE_TEST
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index 28a9423..03db7b5 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -59,6 +59,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>>>  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>>>  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
>>>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>>> +obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>>>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
>>>  obj-$(CONFIG_STX104) += stx104.o
>>>  obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
>>> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
>>> new file mode 100644
>>> index 0000000..d74310a
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/sc27xx_adc.c
>>> @@ -0,0 +1,558 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// Copyright (C) 2018 Spreadtrum Communications Inc.
>>> +
>>> +#include <linux/hwspinlock.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +/* PMIC global registers definition */
>>> +#define SC27XX_MODULE_EN             0xc08
>>> +#define SC27XX_MODULE_ADC_EN         BIT(5)
>>> +#define SC27XX_ARM_CLK_EN            0xc10
>>> +#define SC27XX_CLK_ADC_EN            BIT(5)
>>> +#define SC27XX_CLK_ADC_CLK_EN                BIT(6)
>>> +
>>> +/* ADC controller registers definition */
>>> +#define SC27XX_ADC_CTL                       0x0
>>> +#define SC27XX_ADC_CH_CFG            0x4
>>> +#define SC27XX_ADC_DATA                      0x4c
>>> +#define SC27XX_ADC_INT_EN            0x50
>>> +#define SC27XX_ADC_INT_CLR           0x54
>>> +#define SC27XX_ADC_INT_STS           0x58
>>> +#define SC27XX_ADC_INT_RAW           0x5c
>>> +
>>> +/* Bits and mask definition for SC27XX_ADC_CTL register */
>>> +#define SC27XX_ADC_EN                        BIT(0)
>>> +#define SC27XX_ADC_CHN_RUN           BIT(1)
>>> +#define SC27XX_ADC_12BIT_MODE                BIT(2)
>>> +#define SC27XX_ADC_RUN_NUM_MASK              GENMASK(7, 4)
>>> +#define SC27XX_ADC_RUN_NUM_SHIFT     4
>>> +
>>> +/* Bits and mask definition for SC27XX_ADC_CH_CFG register */
>>> +#define SC27XX_ADC_CHN_ID_MASK               GENMASK(4, 0)
>>> +#define SC27XX_ADC_SCALE_MASK                GENMASK(10, 8)
>>> +#define SC27XX_ADC_SCALE_SHIFT               8
>>> +
>>> +/* Bits definitions for SC27XX_ADC_INT_EN registers */
>>> +#define SC27XX_ADC_IRQ_EN            BIT(0)
>>> +
>>> +/* Bits definitions for SC27XX_ADC_INT_CLR registers */
>>> +#define SC27XX_ADC_IRQ_CLR           BIT(0)
>>> +
>>> +/* Mask definition for SC27XX_ADC_DATA register */
>>> +#define SC27XX_ADC_DATA_MASK         GENMASK(11, 0)
>>> +
>>> +/* Timeout (ms) for the trylock of hardware spinlocks */
>>> +#define SC27XX_ADC_HWLOCK_TIMEOUT    5000
>>> +
>>> +/* Maximum ADC channel number */
>>> +#define SC27XX_ADC_CHANNEL_MAX               32
>>> +
>>> +/* ADC voltage ratio definition */
>>> +#define SC27XX_VOLT_RATIO(n, d)              \
>>> +     (((n) << SC27XX_RATIO_NUMERATOR_OFFSET) | (d))
>>> +#define SC27XX_RATIO_NUMERATOR_OFFSET        16
>>> +#define SC27XX_RATIO_DENOMINATOR_MASK        GENMASK(15, 0)
>>> +
>>> +/* Covert ADC values to voltage values */
>>
>> Convert
>
> Sorry for typo and will fix in next version.
>
>>
>>> +#define SC27XX_ADC_TO_VOLTAGE(volt0, volt1, adc0, adc1, value)       \
>>
>> I'd rather define a function than a macro for this
>
> Sure.
>
>>
>>> +     ({                                                      \
>>> +             int tmp;                                        \
>>> +             tmp = (volt0) - (volt1);                        \
>>> +             tmp = tmp * ((value) - (adc1));                 \
>>> +             tmp = tmp / ((adc0) - (adc1));                  \
>>> +             tmp = tmp + (volt1);                            \
>>> +             if (tmp < 0)                                    \
>>> +                     tmp = 0;                                \
>>> +                                                             \
>>> +             tmp;                                            \
>>> +     })
>>> +
>>> +struct sc27xx_adc_data {
>>> +     struct device *dev;
>>> +     struct regmap *regmap;
>>> +     /*
>>> +      * One hardware spinlock to synchronize between the multiple
>>> +      * subsystems which will access the unique ADC controller.
>>> +      */
>>> +     struct hwspinlock *hwlock;
>>> +     struct completion completion;
>>> +     int channel_scale[SC27XX_ADC_CHANNEL_MAX];
>>> +     int (*get_volt_ratio)(u32 channel, int scale);
>>> +     u32 base;
>>> +     int value;
>>> +     int irq;
>>> +};
>>> +
>>> +struct sc27xx_adc_linear_graph {
>>> +     int volt0;
>>> +     int adc0;
>>> +     int volt1;
>>> +     int adc1;
>>> +};
>>> +
>>> +/*
>>> + * According to the datasheet, we can convert one ADC value to one voltage value
>>> + * through 2 points in the linear graph. If the voltage is less than 1.2v, we
>>> + * should use the small-scale graph, and if more than 1.2v, we should use the
>>> + * big-scale graph.
>>> + */
>>> +static struct sc27xx_adc_linear_graph big_scale_graph = {
>>
>> const
>
> Sure
>
>>
>>> +     4200, 3310,
>>> +     3600, 2832,
>>> +};
>>> +
>>> +static struct sc27xx_adc_linear_graph small_scale_graph = {
>>
>> const
>
> Sure.
>
>>
>>> +     1000, 3413,
>>> +     100, 341,
>>> +};
>>> +
>>> +static int sc27xx_adc_2731_ratio(u32 channel, int scale)
>>
>> can scale be bool?
>> or unsigned?
>
> It can not be a bool, it can be set more than 1 for other PMIC ADC.
>
>>
>> why use u32 for channel? maybe u8 or just unsigned?
>
> OK, u8 is enough.

After more check, the channel type was passed from IIO core, so I
think I should keep it as 'int' type and I do not want to truncate it
to 'u8'.

>>
>>> +{
>>> +     switch (channel) {
>>> +     case 1:
>>> +     case 2:
>>> +     case 3:
>>> +     case 4:
>>> +             return scale ? SC27XX_VOLT_RATIO(400, 1025) :
>>> +                     SC27XX_VOLT_RATIO(1, 1);
>>> +     case 5:
>>> +             return SC27XX_VOLT_RATIO(7, 29);
>>> +     case 6:
>>> +             return SC27XX_VOLT_RATIO(375, 9000);
>>> +     case 7:
>>> +     case 8:
>>> +             return scale ? SC27XX_VOLT_RATIO(100, 125) :
>>> +                     SC27XX_VOLT_RATIO(1, 1);
>>> +     case 19:
>>> +             return SC27XX_VOLT_RATIO(1, 3);
>>> +     default:
>>> +             return SC27XX_VOLT_RATIO(1, 1);
>>> +     }
>>> +     return SC27XX_VOLT_RATIO(1, 1);
>>> +}
>>> +
>>> +static int sc27xx_adc_read(struct sc27xx_adc_data *data, u32 channel,
>>> +                        int scale, int *val)
>>> +{
>>> +     int ret;
>>> +     u32 tmp;
>>> +
>>> +     reinit_completion(&data->completion);
>>> +
>>> +     ret = hwspin_lock_timeout_raw(data->hwlock, SC27XX_ADC_HWLOCK_TIMEOUT);
>>> +     if (ret) {
>>> +             dev_err(data->dev, "timeout to get the hwspinlock\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>>> +                              SC27XX_ADC_EN, SC27XX_ADC_EN);
>>> +     if (ret)
>>> +             goto unlock_adc;
>>> +
>>> +     /* Configure the channel id and scale */
>>> +     tmp = (scale << SC27XX_ADC_SCALE_SHIFT) & SC27XX_ADC_SCALE_MASK;
>>> +     tmp |= channel & SC27XX_ADC_CHN_ID_MASK;
>>> +     ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CH_CFG,
>>> +                              SC27XX_ADC_CHN_ID_MASK | SC27XX_ADC_SCALE_MASK,
>>> +                              tmp);
>>> +     if (ret)
>>> +             goto disable_adc;
>>> +
>>> +     /* Select 12bit conversion mode, and only sample 1 time */
>>> +     tmp = SC27XX_ADC_12BIT_MODE;
>>> +     tmp |= (0 << SC27XX_ADC_RUN_NUM_SHIFT) & SC27XX_ADC_RUN_NUM_MASK;
>>
>> this is still 0

Sorry I missed this comment last time, since other system (synchronize
with hwlock) may set this configuration of the unique ADC controller,
we should re-set this.

-- 
Baolin.wang
Best Regards
