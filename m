Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D80C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E7D208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UME7xA9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E7D208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934651AbeFRKrW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:47:22 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34722 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933501AbeFRKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:47:20 -0400
Received: by mail-oi0-f68.google.com with SMTP id i205-v6so14394514oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jPSchfaEGY8HjzFumr+fDpJDoRROADnaVty6rJaXu88=;
        b=UME7xA9aHUEh1Ojxx3JDr6UuC1xon32av7VMvbU7sZ3I4lT+cX7qXfF1zbb4gQTIUI
         N1fLq/Xie5fU1IMFYnQJbI9S3lJH6MSu1+lL0gDIyZTjtIopCZ0qj2NnX9AgRcKLKWyp
         Z0wxnLxhPxbzX4K02CdPNTc5H2uB0+DapUju0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jPSchfaEGY8HjzFumr+fDpJDoRROADnaVty6rJaXu88=;
        b=cCGoNQmOuge2REw60luhnkOvOHekcH/1iV2Rwcej1+nszITbCg/K0GiiEZwnrPKorI
         RRttYKNO3HlWZQ6vaJzjiHR7J8YlZsOJqctU6/DaaNu6ssBfaYlSDHPuktyXuoOxDES0
         A8+WRFd4xoOGpQIyVZOOdS6tRKANHSG3N/IGrjbQ/qtQuw7z/kuqO5nZUlKsyqjk9+K/
         Hm/UYmCZnPYeXjDOtCWM9Vd9oeNFlMCajCGQlTvx/YnyMDl+dZcam5vbshSeOCNfrU6H
         xFWbDCYdegP8G9gpSlRN29kuEwokCKImVdy6gS0SmwZBNZVseA5V9Gh2S1yBmZNF2RCF
         fNgw==
X-Gm-Message-State: APt69E0/3vpACrpv5d3AXlnj9tL+8/7yT0Ui5K2NZJ+Jk5SweFo/o+J3
        Pqe5LBYF2OsAhkhASLRuYZXIlan8NNMovS4Ajuzebg==
X-Google-Smtp-Source: ADUXVKJJukmzI7Oo+kD+zcc2ta5upfFd116zhFuqDW60Y0z1v/cvU6TsTBvncJs8JCKj98zI7gnE4YjxBhYW+nF9Wk8=
X-Received: by 2002:aca:686:: with SMTP id 128-v6mr6834643oig.31.1529318839476;
 Mon, 18 Jun 2018 03:47:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d44:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 03:47:18
 -0700 (PDT)
In-Reply-To: <2E8CE82E-41FD-4DA8-8969-FD5ADA229464@jic23.retrosnub.co.uk>
References: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
 <5728839377cefd20cdb95913b43dbdab530c1e81.1529040864.git.baolin.wang@linaro.org>
 <20180616193540.6ed717f7@archlinux> <CAMz4kuLVtdbBaNBY6e8F9fPuSBo60HGxzJ2wsW-dDV9-iOsfDg@mail.gmail.com>
 <2E8CE82E-41FD-4DA8-8969-FD5ADA229464@jic23.retrosnub.co.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 18 Jun 2018 18:47:18 +0800
Message-ID: <CAMz4ku+60=rCh-OyK14B94mU1e6ffASa9+YdKNfOz2t4irY6tA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add Spreadtrum SC27XX PMICs ADC support
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@spreadtrum.com, Mark Brown <broonie@kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 18 June 2018 at 18:20, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 17 June 2018 09:03:04 BST, Baolin Wang <baolin.wang@linaro.org> wrote:
>>Hi Jonathan,
>>
>>On 17 June 2018 at 02:35, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On Fri, 15 Jun 2018 15:03:36 +0800
>>> Baolin Wang <baolin.wang@linaro.org> wrote:
>>>
>>>> From: Freeman Liu <freeman.liu@spreadtrum.com>
>>>>
>>>> The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
>>>> which is used to sample voltages with 12 bits conversion.
>>>>
>>>> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>
>>> Hi,
>>>
>>> There are some race conditions around the probe and remove.
>>> More care is needed when we have a mixture of managed and unmanaged
>>cleanup
>>> like here.
>>
>>Thanks to point the race issue.
>>
>>>
>>> I'm not understanding the way you have exposed a simple _raw and
>>_scale
>>> attributes with what looks to be different scaling to that applied
>>> in _processed.   As I say below, we should not have both of those
>>interface
>>> options anyway.  The ABI is that (X_raw + X_offset)*X_scale =
>>X_processed.
>>> (with defaults of X_scale = 1 and X_offset = 0).
>>
>>See below comments.
>>
>>>
>>> Please rename to avoid using wild cards in the name.  That's gone
>>> wrong so many times in the past you wouldn't believe it!
>>> Hmm Awkward though if the MFD is already upstream. Ah well, I guess
>>> for consistency we should follow that and groan when it goes wrong.
>>
>>Can I rename to be 'sprd-pmic-adc.c'? I can not rename it as
>>'sc2731-adc', we have differnet PMICs (SC2730, SC2731, SC2720 etc.),
>>but they are all integrated the same ADC controller.
>
> You can rename as this is a common problem throughout drivers. There is no good solution.
>
> Given mfd naming, just leave it with wild cards as better than a name no one will recognise

OK.

>>
>>>> ---
>>>> Changes since v1:
>>>>  - Add const for static structures definition.
>>>>  - Change SC27XX_ADC_TO_VOLTAGE macro to be one function.
>>>>  - Move channel scale accessing into mutex protection.
>>>>  - Fix some typos.
>>>> ---
>>>>  drivers/iio/adc/Kconfig      |   10 +
>>>>  drivers/iio/adc/Makefile     |    1 +
>>>>  drivers/iio/adc/sc27xx_adc.c |  547
>>++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 558 insertions(+)
>>>>  create mode 100644 drivers/iio/adc/sc27xx_adc.c
>>>>
>>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>>> index 9da7907..985b73e 100644
>>>> --- a/drivers/iio/adc/Kconfig
>>>> +++ b/drivers/iio/adc/Kconfig
>>>> @@ -621,6 +621,16 @@ config ROCKCHIP_SARADC
>>>>         To compile this driver as a module, choose M here: the
>>>>         module will be called rockchip_saradc.
>>>>
>>>> +config SC27XX_ADC
>>>> +     tristate "Spreadtrum SC27xx series PMICs ADC"
>>>> +     depends on MFD_SC27XX_PMIC || COMPILE_TEST
>>>> +     help
>>>> +       Say yes here to build support for the integrated ADC inside
>>the
>>>> +       Spreadtrum SC27xx series PMICs.
>>>> +
>>>> +       This driver can also be built as a module. If so, the module
>>>> +       will be called sc27xx_adc.
>>>> +
>>>>  config SPEAR_ADC
>>>>       tristate "ST SPEAr ADC"
>>>>       depends on PLAT_SPEAR || COMPILE_TEST
>>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>>> index 28a9423..03db7b5 100644
>>>> --- a/drivers/iio/adc/Makefile
>>>> +++ b/drivers/iio/adc/Makefile
>>>> @@ -59,6 +59,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>>>>  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>>>>  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
>>>>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>>>> +obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>>>>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
>>>>  obj-$(CONFIG_STX104) += stx104.o
>>>>  obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
>>>> diff --git a/drivers/iio/adc/sc27xx_adc.c
>>b/drivers/iio/adc/sc27xx_adc.c
>>>> new file mode 100644
>>>> index 0000000..52e5b74
>>>> --- /dev/null
>>>> +++ b/drivers/iio/adc/sc27xx_adc.c
>>>
>>> In general (i.e. when we notice in time) we don't allow wild cards in
>>names.
>>> Far too many times we did this in the past and ended up with later
>>parts
>>> that fitted the name, but could not be supported by the driver.
>>>
>>> The convention is to name everything after the first part supported.
>>> So here, sc2731. (I relaxed my thoughts on this later having seen the
>>mfd
>>> has this naming - so there are no ideal options left..)
>>
>>Like I explained above, maybe change to 'sprd_pmic_adc.c', is this OK
>>for you?
> Goes wrong just as quickly as wild cards...

OK.

>>>> +
>>>> +static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data,
>>int channel,
>>>> +                                int scale, int raw_adc)
>>>> +{
>>>> +     u32 numerator, denominator;
>>>> +     u32 volt;
>>>> +
>>>> +     /*
>>>> +      * Convert ADC values to voltage values according to the
>>linear graph,
>>>> +      * and channel 5 and channel 1 has been calibrated, so we can
>>just
>>>> +      * return the voltage values calculated by the linear graph.
>>But other
>>>> +      * channels need be calculated to the real voltage values with
>>the
>>>> +      * voltage ratio.
>>>> +      */
>>>> +     switch (channel) {
>>>> +     case 5:
>>>> +             return sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
>>>> +
>>>> +     case 1:
>>>> +             return sc27xx_adc_to_volt(&small_scale_graph,
>>raw_adc);
>>>> +
>>>> +     default:
>>>> +             volt = sc27xx_adc_to_volt(&small_scale_graph,
>>raw_adc);
>>>> +             break;
>>>> +     }
>>>
>>> This looks a lot more complex than simple scaling that is indicated
>>by the
>>> raw and scale attributes? They can't both be right..
>>
>>Since this is special for our ADC controller, we have 2 channels that
>>has been calibrated in hardware, but for other
>>none-calibrated-channels, we should care about the channel voltage
>>ratio when converting to a real voltage values, that is because some
>>channel's voltage is larger so we need one voltage ratio to sample the
>>ADC values.
>
> It's still a question of one or the other. Channels should not do processed and raw without a very good reason.

I think I have explained why we need our special processed approach as below.

>
> Issue with processed is that you can't easily do buffered chrdev streaming in future.
>
>
>>
>>>> +
>>>> +     sc27xx_adc_volt_ratio(data, channel, scale, &numerator,
>>&denominator);
>>>> +
>>>> +     return (volt * denominator + numerator / 2) / numerator;
>>>> +}
>>>> +
>>>> +static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
>>>> +                                  int channel, int scale, int *val)
>>>> +{
>>>> +     int ret, raw_adc;
>>>> +
>>>> +     ret = sc27xx_adc_read(data, channel, scale, &raw_adc);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     *val = sc27xx_adc_convert_volt(data, channel, scale, raw_adc);
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int sc27xx_adc_read_raw(struct iio_dev *indio_dev,
>>>> +                            struct iio_chan_spec const *chan,
>>>> +                            int *val, int *val2, long mask)
>>>> +{
>>>> +     struct sc27xx_adc_data *data = iio_priv(indio_dev);
>>>> +     int scale, ret, tmp;
>>>> +
>>>> +     switch (mask) {
>>>> +     case IIO_CHAN_INFO_RAW:
>>>> +     case IIO_CHAN_INFO_AVERAGE_RAW:
>>>> +             mutex_lock(&indio_dev->mlock);
>>>> +             scale = data->channel_scale[chan->channel];
>>>> +             ret = sc27xx_adc_read(data, chan->channel, scale,
>>&tmp);
>>>> +             mutex_unlock(&indio_dev->mlock);
>>>> +
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +
>>>> +             *val = tmp;
>>>> +             return IIO_VAL_INT;
>>>> +
>>>> +     case IIO_CHAN_INFO_PROCESSED:
>>>> +             mutex_lock(&indio_dev->mlock);
>>>> +             scale = data->channel_scale[chan->channel];
>>>> +             ret = sc27xx_adc_read_processed(data, chan->channel,
>>scale,
>>>> +                                             &tmp);
>>>
>>> To keep to the rule of 'one way to read a value' we don't tend to
>>support
>>> both raw and processed.  The only exception is made for devices where
>>we got
>>> this wrong in the first place and so have to support both to avoid a
>>potential
>>> regression due to ABI changes.
>>>
>>> If it is a simple linear scaling (like here I think) then the
>>preferred option
>>> is to not supply the processed version.  Just do raw.
>>
>>Unfortunately, we can not use the formula ( (X_raw + X_offset)*X_scale
>>= X_processed) for our ADC controller to get a processed value.
>>Firstly, the ADC hardware will do the sampling with the scale value.
>
> Hmm fair enough, scale is fine for that. But don't provide raw unless real voltage is scale *raw
>
>>Secondly we should convert a raw value to a voltage value by the
>>linear graph table, for some channels, we should also use the channel
>>voltage ratio to get a real voltage value. So I think we should keep
>>our special processed approach for consumers.
>
> That's fine but drop the raw access or you are not obeying the abi.

Sorry, I think I did not get your points. Could you elaborate on why
we can not provide raw and processed?
I saw many drivers not only provide the raw access but also the
processed access. Especially for our special processed approach, I
think the raw access and the processed access are both needed for
consumers. Thanks.

-- 
Baolin.wang
Best Regards
