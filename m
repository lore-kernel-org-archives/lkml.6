Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3472C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3928720866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Od6S9ydL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3928720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeILM0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:26:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36014 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeILM0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:26:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so933844edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6BOC7pyLBxb9juNkPVwIxkGfr699+O4QxjSLeOjklkk=;
        b=Od6S9ydL+D1UMrAxSBxP1eDKzrVx4yw+uPHz1uqiQ3992Skq3Fc19803/L0q84AgWd
         tte8AD1p68iCtjB+Qpnmq8+1neLkG9eDIqpJB0RPdT4IfduOKjGgthDn7DR1mhG2KBw9
         15F2lXz5uU0OFQgoCF/H/DIhtIcRM2Ksr9OPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6BOC7pyLBxb9juNkPVwIxkGfr699+O4QxjSLeOjklkk=;
        b=pHvlYW8ux/5WvZ1V2RhqjeXZ0LUUNAxmoswk62x6VPXKdDQlYKjbe8349TyKH5nQWG
         booWDehjyE0FRqhZh36ezb6w5RXg8wg7UP9BN5kGLoCM6EfcIvWahYUsqxuWNvdx/l1+
         peHTDbjonLcGtfRF09mWHBADe7xG6veXUSJIiJhSE8FnB+eg3PDB47HtJ/Ddow1zfceN
         vRU5tIelns5/k29yeJ9g8Zo0FuTHjVl6VFUN/3+ssVkYpAfnxqaSr/AwJOchME/CzsVr
         BKrEcNoCWFsY/J2SlNM8TS4SVP8nsi+2k2cYtivKoeFVqqgLqXcV3R1eRU2vt9p0I0ZA
         Pywg==
X-Gm-Message-State: APzg51DhzMLjbwMHS1WppzXDf6SDIME096b7jsf93EmJhuVOfLBktdkl
        0/h0ez0f09kRyQDKL00Ix3EisA==
X-Google-Smtp-Source: ANB0VdbExT9pkqdV0cm/tYe7gSjyAugZyg8lwahal9WxqywALSq1VGrJj9OYQdni2qIByonZ/wg0TQ==
X-Received: by 2002:a50:abc2:: with SMTP id u60-v6mr1192476edc.131.1536736990391;
        Wed, 12 Sep 2018 00:23:10 -0700 (PDT)
Received: from [192.168.0.12] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id w41-v6sm257676edd.92.2018.09.12.00.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:23:09 -0700 (PDT)
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <94c68436-b618-40fc-46d6-165799312289@linaro.org>
Date:   Wed, 12 Sep 2018 08:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180911153340.GY4185@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review

On 11/09/18 16:33, Lee Jones wrote:
> On Tue, 04 Sep 2018, Srinivas Kandagatla wrote:
> 
>> Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
>> It has mulitple blocks like Soundwire controller, codec,
>> Codec processing engine, ClassH controller, interrupt mux.
>> It supports both I2S/I2C and SLIMbus audio interfaces.
>>
>> This patch adds support to SLIMbus audio interface.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-by: Vinod Koul <vkoul@kernel.org>
>> ---
>>   drivers/mfd/Kconfig                   |  14 +
>>   drivers/mfd/Makefile                  |   4 +
>>   drivers/mfd/wcd9335-core.c            | 291 ++++++++++++
>>   include/linux/mfd/wcd9335/registers.h | 627 ++++++++++++++++++++++++++
>>   include/linux/mfd/wcd9335/wcd9335.h   |  32 ++
>>   5 files changed, 968 insertions(+)
>>   create mode 100644 drivers/mfd/wcd9335-core.c
>>   create mode 100644 include/linux/mfd/wcd9335/registers.h
>>   create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 11841f4b7b2b..f0b3eeb61d63 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1807,6 +1807,20 @@ config MFD_WM97xx
>>   	  support for the WM97xx, in order to use the actual functionaltiy of
>>   	  the device other drivers must be enabled.
>>   
>> +config MFD_WCD9335_SLIM
>> +	tristate "Qualcomm WCD9335 with SLIMbus"
>> +	select MFD_CORE
>> +	select REGMAP_IRQ
>> +	select REGMAP_SLIMBUS
>> +	depends on SLIMBUS
>> +	help
>> +	  The WCD9335 is a standalone Hi-Fi audio CODEC IC, supports
>> +	  Qualcomm Technologies, Inc. (QTI) multimedia solutions,
>> +	  including the MSM8996, MSM8976, and MSM8956 chipsets.
>> +	  It has in-build Soundwire controller, interrupt mux.
>> +	  It supports both I2S/I2C and SLIMbus audio interfaces.
>> +	  This option selects SLIMbus audio interface.
> 
> Odd line breaks here.  1 sentence per line?
> 
>>   config MFD_STW481X
>>   	tristate "Support for ST Microelectronics STw481x"
>>   	depends on I2C && (ARCH_NOMADIK || COMPILE_TEST)
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 5856a9489cbd..9d0b98d0cb2c 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -56,6 +56,10 @@ endif
>>   ifeq ($(CONFIG_MFD_CS47L24),y)
>>   obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
>>   endif
>> +
>> +obj-$(CONFIG_MFD_WCD9335_SLIM)	+= wcd9335.o
>> +wcd9335-objs			:= wcd9335-core.o
>> +
>>   obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
>>   wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
>>   wm831x-objs			+= wm831x-auxadc.o
>> diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
>> new file mode 100644
>> index 000000000000..dbfae50c28b2
>> --- /dev/null
>> +++ b/drivers/mfd/wcd9335-core.c
>> @@ -0,0 +1,291 @@
...
>> +
>> +static int wcd9335_parse_dt(struct wcd9335 *wcd)
> 
> This strategy is normally used to segregate OF specific calls.  A
> driver can then choose to call them depending on whether Device Tree
> is in use or not.  Seeing as most of these calls aren't actually OF
> specific and that you call wcd9335_parse_dt() regardless, I suggest
> you move it all into probe().
> 
I will move them to probe in next version.

>> +{
>> +	struct device *dev = wcd->dev;
>> +	struct device_node *np = dev->of_node;
>> +	int ret;
>> +
>> +	wcd->reset_gpio = of_get_named_gpio(np,	"reset-gpios", 0);
>> +	if (wcd->reset_gpio < 0) {
>> +		dev_err(dev, "Reset GPIO missing from DT\n");
>> +		return wcd->reset_gpio;
>> +	}
>> +
>> +	wcd->mclk = devm_clk_get(dev, "mclk");
>> +	if (IS_ERR(wcd->mclk)) {
>> +		dev_err(dev, "mclk not found\n");
>> +		return PTR_ERR(wcd->mclk);
>> +	}
>> +
>> +	wcd->native_clk = devm_clk_get(dev, "slimbus");
>> +	if (IS_ERR(wcd->native_clk)) {
>> +		dev_err(dev, "slimbus clock not found\n");
>> +		return PTR_ERR(wcd->native_clk);
>> +	}
>> +
>> +	wcd->supplies[0].supply = "vdd-buck";
>> +	wcd->supplies[1].supply = "vdd-buck-sido";
>> +	wcd->supplies[2].supply = "vdd-tx";
>> +	wcd->supplies[3].supply = "vdd-rx";
>> +	wcd->supplies[4].supply = "vdd-io";
>> +
>> +	ret = regulator_bulk_get(dev, WCD9335_MAX_SUPPLY, wcd->supplies);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int wcd9335_power_on_reset(struct wcd9335 *wcd)
>> +{
>> +	struct device *dev = wcd->dev;
>> +	int ret;
>> +
>> +	ret = regulator_bulk_enable(WCD9335_MAX_SUPPLY, wcd->supplies);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * For WCD9335, it takes about 600us for the Vout_A and
>> +	 * Vout_D to be ready after BUCK_SIDO is powered up.
>> +	 * SYS_RST_N shouldn't be pulled high during this time
>> +	 * Toggle the reset line to make sure the reset pulse is
>> +	 * correctly applied
>> +	 */
>> +	usleep_range(600, 650);
>> +
>> +	gpio_direction_output(wcd->reset_gpio, 0);
>> +	msleep(20);
>> +	gpio_set_value(wcd->reset_gpio, 1);
>> +	msleep(20);
>> +
>> +	return 0;
>> +}
>> +
>> +static int wcd9335_bring_up(struct wcd9335 *wcd)
>> +{
>> +	struct regmap *rm = wcd->regmap;
>> +	int val, byte0;
>> +
>> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_EFUSE_VAL_OUT0, &val);
>> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_CHIP_ID_BYTE0, &byte0);
>> +
>> +	if ((val < 0) || (byte0 < 0)) {
>> +		dev_err(wcd->dev, "WCD9335 CODEC version detection fail!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (byte0 == 0x1) {
> 
> What is 0x1?  I suggest you define it.
> 
I agree, I will fix any such hard codes with a define in next version.

>> +		dev_info(wcd->dev, "WCD9335 CODEC version is v2.0\n");
>> +		wcd->version = WCD9335_VERSION_2_0;
>> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x01);
>> +		regmap_write(rm, WCD9335_SIDO_SIDO_TEST_2, 0x00);
>> +		regmap_write(rm, WCD9335_SIDO_SIDO_CCL_8, 0x6F);
>> +		regmap_write(rm, WCD9335_BIAS_VBG_FINE_ADJ, 0x65);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x5);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x7);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x3);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x3);
> 
> You really need to define all of these settings.
> 
> As a human I have no idea what just happened!
> 
>> +	} else {
>> +		dev_err(wcd->dev, "WCD9335 CODEC version not supported\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int wcd9335_slim_probe(struct slim_device *slim)
>> +{
>> +	struct device *dev = &slim->dev;
>> +	struct wcd9335 *wcd;
> 
> Would you consider calling this ddata?

Okay will do that.


> 
>> +	int ret;
>> +
>> +	/* Interface device */
>> +	if (slim->e_addr.dev_index == WCD9335_SLIM_INTERFACE_DEVICE_INDEX)
>> +		return 0;
>> +
>> +	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
>> +	if (!wcd)
>> +		return	-ENOMEM;
>> +
>> +	wcd->dev = dev;
>> +
>> +	ret = wcd9335_parse_dt(wcd);
>> +	if (ret) {
>> +		dev_err(dev, "Error parsing DT: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = wcd9335_power_on_reset(wcd);
>> +	if (ret)
>> +		return ret;
>> +
>> +	wcd->slim = slim;
>> +	wcd->intf_type = WCD9335_INTERFACE_TYPE_SLIMBUS;
>> +
>> +	dev_set_drvdata(dev, wcd);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mfd_cell wcd9335_devices[] = {
>> +	{ .name = "wcd9335-codec", },
>> +};
> 
> Are there more devices to come?
> 
Yes, that is the plan, we are kind of limited in hardware setup to test 
few things like soundwire controller. We are exploring other ways to 
test these.

> MFD cells are usually placed at the very top of the driver.  This
> makes it easy to see which devices are supported by the MFD.
> 
I agree I will move that in next version.

>> +static int wcd9335_slim_status(struct slim_device *sdev,
>> +			       enum slim_device_status status)
> 
> We usually only place PM related functions below probe().
> 
Will reorganize this.

>> +{
>> +	struct device_node *ifc_dev_np;
> 
> ifc isn't very forthcoming.  Any way you can improve the name?
ifc was suggested in dt bindings by Rob,  I can proably rename to 
interface_node.

> 
>> +	struct wcd9335 *wcd;
>> +	int ret;
>> +
>> +	if (sdev->e_addr.dev_index == WCD9335_SLIM_INTERFACE_DEVICE_INDEX)
>> +		return 0;
>> +
>> +	wcd = dev_get_drvdata(&sdev->dev);
>> +
>> +	ifc_dev_np = of_parse_phandle(wcd->dev->of_node, "slim-ifc-dev", 0);
>> +	if (!ifc_dev_np) {
>> +		dev_err(wcd->dev, "No Interface device found\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	wcd->slim_ifc_dev = of_slim_get_device(sdev->ctrl, ifc_dev_np);
>> +	if (!wcd->slim_ifc_dev) {
>> +		dev_err(wcd->dev, "Unable to get SLIM Interface device\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	wcd->regmap = regmap_init_slimbus(sdev, &wcd9335_regmap_config);
>> +	if (IS_ERR(wcd->regmap)) {
>> +		dev_err(wcd->dev, "Failed to allocate slim register map\n");
> 
> s/slim/SLIM/ ?
sure will fix it.
> 
>> +		return PTR_ERR(wcd->regmap);
>> +	}
>> +
>> +	wcd->ifc_dev_regmap = regmap_init_slimbus(wcd->slim_ifc_dev,
>> +						  &wcd9335_ifc_regmap_config);
>> +	if (IS_ERR(wcd->ifc_dev_regmap)) {
>> +		dev_err(wcd->dev, "Failed to allocate ifc register map\n");
> 
> ifc in a human readable context is not good.
> 
>> +		return PTR_ERR(wcd->ifc_dev_regmap);
>> +	}
>> +
>> +	ret = wcd9335_bring_up(wcd);
> 
> So the device_status call-back brings up the hardware?
> 

device status reports the device status at runtime. We can not 
communicate with the device until it is up, enumerated by slimbus and a 
logical address is assigned to it. So the best place to initialize it is 
in status callback where all the above are expected to be done.

Probe is expected to setup the external configurations like 
regulators/pins and so on which gets the device out of reset and ready 
to be enumerated by the slimbus controller.

> That sounds odd to me?
> 
>> +	if (ret) {
>> +		dev_err(wcd->dev, "Failed to bringup WCD9335\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_mfd_add_devices(wcd->dev, 0, wcd9335_devices,
>> +			       ARRAY_SIZE(wcd9335_devices), NULL, 0, NULL);
>> +	if (ret < 0)
> 
> if (ret) ?
> 
>> +		dev_err(wcd->dev, "Failed to add mtd devices: %d\n", ret);
> 
> a) This is not an MTD device - typo?
> b) Please use a message that end users are going to care about
>     Who, in the real world knows what an MFD is?
> 
I agree I will fix such instances before sending next version.

>> +	return ret;
>> +}
>> +

>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/wcd9335/registers.h b/include/linux/mfd/wcd9335/registers.h
>> new file mode 100644
>> index 000000000000..f9fa35fb536b
>> --- /dev/null
>> +++ b/include/linux/mfd/wcd9335/registers.h
>> @@ -0,0 +1,627 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> No copyright?
> 
I will change this to include copyright in next version.

>> +#ifndef _WCD9335_REGISTERS_H
>> +#define _WCD9335_REGISTERS_H
>> +
>> +/*
>> + * WCD9335 register base can change according to the mode it works in
>> + * in slimbus mode the reg base starts from 0x800
> 
> s/slimbus/SLIMBUS/ ?
>
Sure will change this.

>> +struct wcd9335 {
>> +	int version;
>> +	int intr1;
>
This is a hardware pin name for interrupt line 1.


> What's this?  If I have to ask, it's probably not a good name.
> 
>> +	int reset_gpio;
>> +	enum wcd_interface_type intf_type;
>> +	struct device *dev;
>> +	struct clk *mclk;
>> +	struct clk *native_clk;
>> +	struct slim_device *slim;
>> +	struct slim_device *slim_ifc_dev;
>> +	struct regmap *regmap;
>> +	struct regmap *ifc_dev_regmap;
>> +	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
>> +};
> 
> Also, please consider using Kerneldoc format header.
>
Will give that a try in next version.

>> +#endif /* __WCD9335_H__ */
> 
--srini
