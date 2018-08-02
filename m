Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6F8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BB7214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLjhSHWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BB7214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbeHBLQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:16:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44125 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbeHBLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:16:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so1358674wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aMv4nYqVSkb0BEoOfsvB+zEAMf/cdHDTuKRsJvn2bDc=;
        b=eLjhSHWaMdwNe7I/ToD/wFDe9j8cm8RJxiWIYc+aamBloDv8qLnM/Gv9Xdc/L4CAHw
         yp+eWnVo1VrxG86HLffw1Lq5d1NhvuUrJDtUemHoDl8YHMW1OetBxVqXjQYGIBQceBpQ
         IpdULsXavaklKBfAX/nINRizXxbAwi0wbDQOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMv4nYqVSkb0BEoOfsvB+zEAMf/cdHDTuKRsJvn2bDc=;
        b=uZKZdPJwyNkTbiIYBB/uW5sX1RZl6zvQUz2MywO132FdcBQ6/5kvlPMjkoV+UAy8Rm
         VvGO64nwmZ/lm08QH+rMFc8n3OgdDIae7E23DvLbrsc1mMjaYwTnUzEu5r1WjWqka7FR
         lNdsxowHlJGVHA/bCt295gEAcK1HEbH84qxEWLnjZDHa7ZJx3WaytaGPgMgiyIfsMSAF
         T5H4g5iFBDjVdd4MdzTbnTQJMs2lHag9kV2JW57ZgIO1aeHkNxQxqZRefqlhHWnYVdOp
         N/Zn0SN3ybUbYxA1BpaHUwS3l43rlLgx7JPWLm6/NnLRfSg9QDfzJWhwTNtvr8RGA6E/
         DMDw==
X-Gm-Message-State: AOUpUlHtmqhWThkqJfrl92F1uE0cDPuQWgCarR7JSGOesYOw7yMVcfv1
        gYxuswF8HkpN4/Cqudf6j8hA4w==
X-Google-Smtp-Source: AAOMgpfQbgiFAv8autE4q+9F3Pv2H37EgkSLZ4nOaoQEgZpiinZpxza6KgNfKPNRuO0c7156CuYd3Q==
X-Received: by 2002:adf:adae:: with SMTP id w43-v6mr1426563wrc.251.1533201975165;
        Thu, 02 Aug 2018 02:26:15 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 2-v6sm1519513wmi.17.2018.08.02.02.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 02:26:14 -0700 (PDT)
Subject: Re: [PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-3-srinivas.kandagatla@linaro.org>
 <20180802083351.GN4662@dell>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9a33e0ce-a385-cdad-f610-655562bec1f5@linaro.org>
Date:   Thu, 2 Aug 2018 10:26:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180802083351.GN4662@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,


On 02/08/18 09:33, Lee Jones wrote:
> On Fri, 27 Jul 2018, Srinivas Kandagatla wrote:
> 
>> Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
>> It has mulitple blocks like Soundwire controller, codec,
>> Codec processing engine, ClassH controller, interrupt mux.
>> It supports both I2S/I2C and SLIMbus audio interfaces.
>>
>> This patch adds support to SLIMbus audio interface.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/mfd/Kconfig                   |  18 ++
>>   drivers/mfd/Makefile                  |   4 +
>>   drivers/mfd/wcd9335-core.c            | 268 ++++++++++++++++
>>   include/linux/mfd/wcd9335/registers.h | 580 ++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/wcd9335/wcd9335.h   |  42 +++
>>   5 files changed, 912 insertions(+)
>>   create mode 100644 drivers/mfd/wcd9335-core.c
>>   create mode 100644 include/linux/mfd/wcd9335/registers.h
>>   create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index f3fa516011ec..6e5b5f3cfe20 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1807,6 +1807,24 @@ config MFD_WM97xx
>>   	  support for the WM97xx, in order to use the actual functionaltiy of
>>   	  the device other drivers must be enabled.
>>   
>> +config MFD_WCD9335
>> +	tristate
>> +	select MFD_CORE
>> +	select REGMAP
>> +	select REGMAP_IRQ
>> +
>> +config MFD_WCD9335_SLIM
>> +	tristate "Qualcomm WCD9335 with SLIMbus"
>> +	select MFD_WCD9335
>> +	select REGMAP_SLIMBUS
>> +	depends on SLIMBUS
>> +	help
>> +	The WCD9335 is a standalone Hi-Fi audio codec IC, supports
> 
> s/codec/CODEC/
Yep.
> 
>> +	Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
>> +	the MSM8996, MSM8976, and MSM8956 chipsets. It has inbuild
> 
> s/inbuild/in-built/

Sure!

> 
>> +	Soundwire controller, interrupt mux. It supports both I2S/I2C and
>> +	SLIMbus audio interfaces. This option selects SLIMbus audio interface.
> 
> The help should be indented.

Sure!
> 
>>   config MFD_STW481X
>>   	tristate "Support for ST Microelectronics STw481x"
>>   	depends on I2C && (ARCH_NOMADIK || COMPILE_TEST)
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 2852a6042ecf..a4697370640b 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -56,6 +56,10 @@ endif
>>   ifeq ($(CONFIG_MFD_CS47L24),y)
>>   obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
>>   endif
>> +
>> +obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
>> +wcd9335-objs			:= wcd9335-core.o
>> +
>>   obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
>>   wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
>>   wm831x-objs			+= wm831x-auxadc.o
>> diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
>> new file mode 100644
>> index 000000000000..8f746901f4e9
>> --- /dev/null
>> +++ b/drivers/mfd/wcd9335-core.c
>> @@ -0,0 +1,268 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, Linaro Limited
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slimbus.h>
>> +#include <linux/regmap.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/clk.h>
>> +#include <linux/gpio.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/mfd/wcd9335/wcd9335.h>
>> +#include <linux/mfd/wcd9335/registers.h>
> 
> Alphabetical.
> 
Sure will do that in next version.
>> +static const struct regmap_range_cfg wcd9335_ranges[] = {
>> +	{	.name = "WCD9335",
> 
> What is that?  New line please.
Opps, will fix it in next version.
> 
>> +		.range_min =  0x0,
>> +		.range_max =  WCD9335_MAX_REGISTER,
>> +		.selector_reg = WCD9335_REG(0x0, 0),
>> +		.selector_mask = 0xff,
>> +		.selector_shift = 0,
>> +		.window_start = 0x0,
>> +		.window_len = 0x1000,
>> +	},
>> +};
>> +
>> +static struct regmap_config wcd9335_regmap_config = {
>> +	.reg_bits = 16,
>> +	.val_bits = 8,
>> +	.cache_type = REGCACHE_RBTREE,
>> +	.max_register = WCD9335_MAX_REGISTER,
>> +	.can_multi_write = true,
>> +	.ranges = wcd9335_ranges,
>> +	.num_ranges = ARRAY_SIZE(wcd9335_ranges),
>> +};
>> +
>> +static const struct regmap_range_cfg wcd9335_ifd_ranges[] = {
>> +	{	.name = "WCD9335-IFD",
> 
> As above.
> 
Yep.
>> +		.range_min =  0x0,
>> +		.range_max = WCD9335_REG(0, 0x7ff),
>> +		.selector_reg = WCD9335_REG(0, 0x0),
>> +		.selector_mask = 0xff,
>> +		.selector_shift = 0,
>> +		.window_start = 0x0,
>> +		.window_len = 0x1000,
>> +	},
>> +};
>> +
>> +static struct regmap_config wcd9335_ifd_regmap_config = {
>> +	.reg_bits = 16,
>> +	.val_bits = 8,
>> +	.can_multi_write = true,
>> +	.max_register = WCD9335_REG(0, 0x7FF),
>> +	.ranges = wcd9335_ifd_ranges,
>> +	.num_ranges = ARRAY_SIZE(wcd9335_ifd_ranges),
>> +};
>> +
>> +static int wcd9335_parse_dt(struct wcd9335 *wcd)
>> +{
>> +	struct device *dev = wcd->dev;
>> +	struct device_node *np = dev->of_node;
>> +	int ret;
>> +
>> +	wcd->reset_gpio = of_get_named_gpio(np,	"reset-gpio", 0);
>> +	if (wcd->reset_gpio < 0) {
>> +		dev_err(dev, "Reset gpio missing in DT\n");
> 
> s/gpio/GPIO/
> 
> s/missing in DT/missing from DT/
Yep!
> 
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
>> +		dev_err(dev, "slimbus clk not found\n");
> 
> Any reason for abbreviating 'clock' in the error message?
> 
No, Will change it to clock in next version.
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
>> +	if (ret != 0) {
> 
> "if (ret)"
> 
> Same for all.  I won't comment on the others.
Yes, I agree, will fix such instances.
> 
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
>> +	if (ret != 0) {
>> +		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * For WCD9335, it takes about 600us for the Vout_A and
>> +	 * Vout_D to be ready after BUCK_SIDO is powered up.
>> +	 * SYS_RST_N shouldn't be pulled high during this time
>> +	 */
>> +	usleep_range(600, 650);
>> +
>> +	gpio_direction_output(wcd->reset_gpio, 0);
>> +	msleep(20);
> 
> What's this for?  Why can't you just:
> 
This is just making sure that reset line is low before actual the chip 
is taken out of reset.

>    gpio_direction_output(wcd->reset_gpio, 1);
> 
> ... and drop the next 2 lines?
> 
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
>> +	int ret = 0;
>> +
>> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_EFUSE_VAL_OUT0, &val);
>> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_CHIP_ID_BYTE0, &byte0);
>> +
>> +	if ((val < 0) || (byte0 < 0)) {
>> +		dev_err(wcd->dev, "wcd9335 codec version detection fail!\n");
> 
> s/wcd9335 codec/WCD9335 CODEC/ ?
> 
sure!

>> +		return -EINVAL;
>> +	}
>> +
>> +	if (byte0 == 0x1) {
>> +		dev_info(wcd->dev, "wcd9335 codec version is v2.0\n");
>> +		wcd->version = WCD9335_VERSION_2_0;
>> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x01);
>> +		regmap_write(rm, WCD9335_SIDO_SIDO_TEST_2, 0x00);
>> +		regmap_write(rm, WCD9335_SIDO_SIDO_CCL_8, 0x6F);
>> +		regmap_write(rm, WCD9335_BIAS_VBG_FINE_ADJ, 0x65);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x5);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x7);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x3);
>> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x3);
>> +	} else {
>> +		dev_err(wcd->dev, "wcd9335 codec version not supported\n");
> 
> As above.
> 
Yep.
>> +		ret = -EINVAL;
> 
> Why not just
> 
>    return -EINVAL;
> 
> Then you can just return 0 and avoid pre-initialising ret.
Agreed!

> 
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int wcd9335_slim_probe(struct slim_device *slim)
>> +{
>> +	struct device *dev = &slim->dev;
>> +	struct wcd9335 *wcd;
>> +	int ret = 0;
> 
> Why pre-initialise?
looks like over done!
> 
>> +	/* Interface device */
>> +	if (slim->e_addr.dev_index == 0)
> 
> Is 0 the parent?  I think 0 needs defining for clarity.
Sure, Its interface device index, I will try to make this clear by 
defining ir.
> 
>> +		return 0;
>> +
>> +	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
>> +	if (!wcd)
>> +		return	-ENOMEM;
>> +
>> +	wcd->dev = dev;
> 
> '\n' here.
> 
Yep.
>> +	ret = wcd9335_parse_dt(wcd);
>> +	if (ret) {
>> +		dev_err(dev, "Error parsing DT (%d)\n", ret);
> 
> This format changes from message to message.
> 
> Please pick one and stick with it.
> 
> I personally like: "<MESSAGE>: %d", ret
Okay I will keep a close eye on such things before sending next version.
> 
>> +		return ret;
>> +	}
>> +
>> +	ret = wcd9335_power_on_reset(wcd);
>> +	if (ret) {
>> +		dev_err(dev, "Error Powering\n");
> 
> I think this is superflouous since you already printed a message.
> 
Yep!
>> +		return ret;
>> +	}
>> +
>> +	wcd->regmap = regmap_init_slimbus(slim, &wcd9335_regmap_config);
>> +	if (IS_ERR(wcd->regmap)) {
>> +		ret = PTR_ERR(wcd->regmap);
>> +		dev_err(dev, "Failed to allocate register map:%d\n", ret);
> 
> A different format again.  Ensure there is a ' ' after the ':'.
> 
>> +		return ret;
>> +	}
>> +
>> +	dev_set_drvdata(dev, wcd);
> 
> Probably nicer to do this at the very end - after a '\n'.
> 
Okay.
>> +	wcd->slim = slim;
>> +	wcd->intf_type = WCD9335_INTERFACE_TYPE_SLIMBUS;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mfd_cell wcd9335_devices[] = {
>> +	{
>> +		.name = "wcd9335-codec",
>> +	},
>> +};
> 
> When are you going to add the other devices?
> 
We are trying to sort of hw setup to test other devices like soundwire 
controller, will add these once we are in a position to test them.

> By the way, one line entries should be placed on one line.
> 
>> +	{ .name = "wcd9335-codec" },
> 
>> +static int wcd9335_slim_status(struct slim_device *sdev,
>> +				 enum slim_device_status s)
> 
> 's' is not a good variable name.  Suggest 'status'.
> 
Agreed!
>> +{
>> +	struct device_node *ifd_np;
> 
> What's 'ifd'?
> 
SLIMbus Interface device.
>> +	struct wcd9335 *wcd;
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	/* Interface device */
> 
> As previously suggested just define the device ID and drop the
> comment.
> 
Yep.
>> +	if (sdev->e_addr.dev_index == 0)
>> +		return 0;
>> +
>> +	wcd = dev_get_drvdata(&sdev->dev);
>> +	dev = wcd->dev;
> 
> Odd.  You do to the effort of assigning this and use 'wcd->dev' at
> most call sites anyway.  I'd drop 'dev' and just use it from 'wcd'
> everywhere.
> 
Will cleanup such instances!
>> +	ifd_np = of_parse_phandle(wcd->dev->of_node, "qcom,ifd", 0);
>> +	if (!ifd_np) {
>> +		dev_err(wcd->dev, "No Interface device found\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	wcd->slim_ifd = of_slim_get_device(sdev->ctrl, ifd_np);
>> +	if (!wcd->slim_ifd) {
>> +		dev_err(wcd->dev, "Unable to get SLIM Interface device\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	wcd->ifd_regmap = regmap_init_slimbus(wcd->slim_ifd,
>> +					      &wcd9335_ifd_regmap_config);
>> +	if (IS_ERR(wcd->ifd_regmap)) {
>> +		dev_err(dev, "Failed to allocate register map\n");
>> +		return PTR_ERR(wcd->ifd_regmap);
>> +	}
>> +
>> +	ret = wcd9335_bring_up(wcd);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to bringup WCD9335\n");
>> +		return ret;
>> +	}
>> +
>> +	wcd->slim_ifd = wcd->slim_ifd;
> 
> Am I missing something?
No, Its my bad!
> 
>> +	return mfd_add_devices(wcd->dev, 0, wcd9335_devices,
>> +			       ARRAY_SIZE(wcd9335_devices), NULL, 0, NULL);
> 
> No error message if it were to fail?
Will fix this in next version.
> 
>> +}
>> +
>> +static const struct slim_device_id wcd9335_slim_id[] = {
>> +	{0x217, 0x1a0, 0x1, 0x0},
> 
> Well that's just horrific.  Can't these be defined?
> 
Possibly, This is 48bit enumeration address of SLIMbus device, These 
correspond to Manufacture ID, Product-ID, and Device-ID and Instance IDs.

>> +	{}
>> +};
>> +
>> +static struct slim_driver wcd9335_slim_driver = {
>> +	.driver = {
>> +		.name = "wcd9335-slim",
>> +	},
>> +	.probe = wcd9335_slim_probe,
>> +	.device_status = wcd9335_slim_status,
>> +	.id_table = wcd9335_slim_id,
>> +};
>> +
>> +module_slim_driver(wcd9335_slim_driver);
>> +MODULE_DESCRIPTION("WCD9335 slim driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/wcd9335/registers.h b/include/linux/mfd/wcd9335/registers.h
> 
