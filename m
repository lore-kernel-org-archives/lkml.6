Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1F9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB9E20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jkl9WzMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB9E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbeGJNJA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:09:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34273 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754101AbeGJNI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:08:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so14519146wrt.1;
        Tue, 10 Jul 2018 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YnhuqDmoeHjxgjNu4XDygjxmlwVDz+emJ4HAtoGGqUk=;
        b=Jkl9WzMFOdixsy/TR6Mz68XvEN96jVJV/pEH9PTsfmR/k62C1lBHOanKm/+L8GWMQN
         j22dcR18SEgdGXlpjJiuZwp9qdOdiVJEvjZeVrjCNIma3nBgNvdIe9+kQWiwjkh3OVqe
         C65Ll/1ISFYLE8mx5h/G22DU6ALQzy76PPkY4L9Bso0WwM5HwOKHavvpqaisVoehm+M+
         jFfjxR4wgE7wyPbyJDCTjcHSrZTs0V8W1ML+bzxBdqniMeLNC1ZgYPJEMEObinn7AWmZ
         vfZ6P8gI0ZwD0AtCQFGnEn4yl8C8mF0xMb6sSnjp/vnDfHG+BiKog9X6KcQFBSlMT0VF
         nSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YnhuqDmoeHjxgjNu4XDygjxmlwVDz+emJ4HAtoGGqUk=;
        b=AF8Eo659a36/C/b2CpTrKCLU6NEx3Ns0SJMtqb6INXA9tAUaAUFdCae+UiBDd6sm5R
         6eTikE0dDQasdnvuR/bmTCFYfGYaZH2Cu4MkR7F2MJltX1hs/ZhGT3++1LjPX4ZVq84C
         OoJMvX2cCpFAxQWfgzxJqVaoEYR9wRWaykyzKkbOhc5KNx2TTr+t9QdEF2osnkHBzyA4
         R8N60gffRdSMH21DzuJFbM3yswI1ptk/N7RZwtEZt9/9vJHux0dDc6lvbfth+y/oRFQc
         r5A5UzbncHgic7AGcQRoxrXRtd/wltFItHWQkcF1eaKQx/H7euaZcskpqlZtBrz70oVt
         /t9g==
X-Gm-Message-State: APt69E19nmI1O35R5I6Pws+i2xkXno1Xmz5C+qq2xdYxNTYOqdtyqhwa
        2kn4S63ykeL5qH7EKKAm4nMQ6fUa6Pk=
X-Google-Smtp-Source: AAOMgpc7K2bGer15MhaW54cZrqStNxUpV6fQoe6+uCHefY+Fol2UkWsY+ebYDtVLeA+KcBEJCq1NqA==
X-Received: by 2002:adf:a197:: with SMTP id u23-v6mr19151567wru.50.1531228136673;
        Tue, 10 Jul 2018 06:08:56 -0700 (PDT)
Received: from [192.168.0.59] ([195.238.85.143])
        by smtp.gmail.com with ESMTPSA id 6-v6sm2483824wmi.26.2018.07.10.06.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 06:08:56 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] drm/panel: Add support for Olimex LCD-OLinuXino
 panel
To:     Thierry Reding <thierry.reding@gmail.com>,
        Stefan Mavrodiev <stefan@olimex.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1529909093-17021-1-git-send-email-stefan@olimex.com>
 <20180710103250.GG1504@ulmo>
From:   Stefan Mavrodiev <stefan.mavrodiev@gmail.com>
Message-ID: <e1229a90-1bdb-0c8e-c371-cde0bc30ea56@gmail.com>
Date:   Tue, 10 Jul 2018 16:08:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710103250.GG1504@ulmo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2018 01:32 PM, Thierry Reding wrote:
> On Mon, Jun 25, 2018 at 09:44:35AM +0300, Stefan Mavrodiev wrote:
>> This patch adds Olimex Ltd. LCD-OLinuXino bridge panel driver. The
>> panel is used with different LCDs (currently from 480x272 to 1280x800).
>> Small EEPROM chip is used for identification, which holds some
>> factory data and timing requirements.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>> Changes for v2:
>>      - Changed lcd_olinuxino_funcs to static const
>>
>>   .../display/panel/olimex,lcd-olinuxino.txt         |  42 +++
>>   MAINTAINERS                                        |   6 +
>>   drivers/gpu/drm/panel/Kconfig                      |  10 +
>>   drivers/gpu/drm/panel/Makefile                     |   1 +
>>   drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 360 +++++++++++++++++++++
>>   5 files changed, 419 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
>>   create mode 100644 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
>> new file mode 100644
>> index 0000000..a89f9c8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
>> @@ -0,0 +1,42 @@
>> +Binding for Olimex Ltd. LCD-OLinuXino bridge panel.
>> +
>> +This device can be used as bridge between a host controller and LCD panels.
>> +Currently supported LCDs are:
>> +  - LCD-OLinuXino-4.3TS
>> +  - LCD-OLinuXino-5
>> +  - LCD-OLinuXino-7
>> +  - LCD-OLinuXino-10
>> +
>> +The panel itself contains:
>> +  - AT24C16C EEPROM holding panel identification and timing requirements
>> +  - AR1021 resistive touch screen controller (optional)
>> +  - FT5x6 capacitive touch screnn controller (optional)
>> +  - GT911/GT928 capacitive touch screen controller (optional)
>> +
>> +The above chips share same I2C bus. The EEPROM is factory preprogrammed with
>> +device information (id, serial, etc.) and timing requirements.
>> +
>> +Touchscreen bingings can be found in these files:
>> +  - input/touchscreen/goodix.txt
>> +  - input/touchscreen/edt-ft5x06.txt
>> +  - input/touchscreen/ar1021.txt
>> +
>> +Required properties:
>> +  - compatible: should be "olimex,lcd-olinuxino"
>> +  - reg: address of the configuration EEPROM, should be <0x50>
>> +  - power-supply: phandle of the regulator that provides the supply voltage
>> +
>> +Optional properties:
>> +  - enable-gpios: GPIO pin to enable or disable the panel
>> +  - backlight: phandle of the backlight device attacked to the panel
>> +
>> +Example:
>> +&i2c2 {
>> +	panel@50 {
>> +		compatible = "olimex,lcd-olinuxino";
>> +		reg = <0x50>;
>> +		power-supply = <&reg_vcc5v0>;
>> +		enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;
>> +		backlight = <&backlight>;
>> +	};
>> +};
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 624c3fd..30343f1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4557,6 +4557,12 @@ S:	Supported
>>   F:	drivers/gpu/drm/nouveau/
>>   F:	include/uapi/drm/nouveau_drm.h
>>   
>> +DRM DRIVER FOR OLIMEX LCD-OLINUXINO PANELS
>> +M:	Stefan Mavrodiev <stefan@olimex.com>
>> +S:	Maintained
>> +F:	drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
>> +F:	Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
>> +
>>   DRM DRIVER FOR PERVASIVE DISPLAYS REPAPER PANELS
>>   M:	Noralf Trønnes <noralf@tronnes.org>
>>   S:	Maintained
>> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
>> index 25682ff..0292994 100644
>> --- a/drivers/gpu/drm/panel/Kconfig
>> +++ b/drivers/gpu/drm/panel/Kconfig
>> @@ -81,6 +81,16 @@ config DRM_PANEL_LG_LG4573
>>   	  Say Y here if you want to enable support for LG4573 RGB panel.
>>   	  To compile this driver as a module, choose M here.
>>   
>> +config DRM_PANEL_OLIMEX_LCD_OLINUXINO
>> +	tristate "Olimex LCD-OLinuXino panel"
>> +	depends on OF
>> +	depends on I2C
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	help
>> +	  Say Y here if you want to enable support for Olimex Ltd.
>> +	  LCD-OLinuXino panel. The panel is used with different sizes LCDs,
>> +	  from 480x272 to 1280x800, and 24 bit per pixel.
>> +
>>   config DRM_PANEL_ORISETECH_OTM8009A
>>   	tristate "Orise Technology otm8009a 480x800 dsi 2dl panel"
>>   	depends on OF
>> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
>> index f26efc1..185027f 100644
>> --- a/drivers/gpu/drm/panel/Makefile
>> +++ b/drivers/gpu/drm/panel/Makefile
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
>>   obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
>>   obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) += panel-jdi-lt070me05000.o
>>   obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
>> +obj-$(CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO) += panel-olimex-lcd-olinuxino.o
>>   obj-$(CONFIG_DRM_PANEL_ORISETECH_OTM8009A) += panel-orisetech-otm8009a.o
>>   obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) += panel-panasonic-vvx10f034n00.o
>>   obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) += panel-raspberrypi-touchscreen.o
>> diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
>> new file mode 100644
>> index 0000000..89d7816
>> --- /dev/null
>> +++ b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
>> @@ -0,0 +1,360 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * LCD-OLinuXino support for panel driver
>> + *
>> + * Copyright (C) 2018 Olimex Ltd.
>> + *   Author: Stefan Mavrodiev <stefan@olimex.com>
>> + */
>> +
>> +#include <linux/backlight.h>
>> +#include <linux/crc32.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <drm/drm_modes.h>
>> +#include <drm/drm_panel.h>
>> +#include <drm/drmP.h>
>> +
>> +#include <video/videomode.h>
>> +#include <video/display_timing.h>
>> +
>> +
>> +#define LCD_OLINUXINO_HEADER_MAGIC	0x4F4CB727
>> +#define LCD_OLINUXINO_DATA_LEN		256
>> +
>> +struct lcd_olinuxino_mode {
>> +	u32 pixelclock;
>> +	u32 hactive;
>> +	u32 hfp;
>> +	u32 hbp;
>> +	u32 hpw;
>> +	u32 vactive;
>> +	u32 vfp;
>> +	u32 vbp;
>> +	u32 vpw;
>> +	u32 refresh;
>> +	u32 flags;
>> +};
>> +
>> +struct lcd_olinuxino_info {
>> +	char name[32];
>> +	u32 width_mm;
>> +	u32 height_mm;
>> +	u32 bpc;
>> +	u32 bus_format;
>> +	u32 bus_flag;
>> +} __attribute__((__packed__));
>> +
>> +struct lcd_olinuxino_eeprom {
>> +	u32 header;
>> +	u32 id;
>> +	char revision[4];
>> +	u32 serial;
>> +	struct lcd_olinuxino_info info;
>> +	u32 num_modes;
>> +	u8 reserved[180];
>> +	u32 checksum;
>> +} __attribute__((__packed__));
>> +
>> +struct lcd_olinuxino {
>> +	struct device *dev;
>> +	struct i2c_client *client;
>> +	struct mutex mutex;
>> +
>> +	struct drm_panel panel;
> You might want to consider moving this to be the first element, that way
> the to_lcd_olinuxino() becomes a nop.
>
>> +	bool prepared;
>> +	bool enabled;
>> +
>> +	struct backlight_device *backlight;
>> +	struct regulator *supply;
>> +	struct gpio_desc *enable_gpio;
>> +
>> +	struct lcd_olinuxino_eeprom eeprom;
>> +};
>> +
>> +static inline struct lcd_olinuxino *to_lcd_olinuxino(struct drm_panel *panel)
>> +{
>> +	return container_of(panel, struct lcd_olinuxino, panel);
>> +}
>> +
>> +static int lcd_olinuxino_disable(struct drm_panel *panel)
>> +{
>> +	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
>> +
>> +	if (!lcd->enabled)
>> +		return 0;
>> +
>> +	if (lcd->backlight) {
>> +		lcd->backlight->props.power = FB_BLANK_POWERDOWN;
>> +		lcd->backlight->props.state |= BL_CORE_FBBLANK;
>> +		backlight_update_status(lcd->backlight);
>> +	}
> This should use the new backlight_disable() helper.
>
>> +
>> +	lcd->enabled = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static int lcd_olinuxino_unprepare(struct drm_panel *panel)
>> +{
>> +	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
>> +
>> +	if (!lcd->prepared)
>> +		return 0;
>> +
>> +	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
>> +	regulator_disable(lcd->supply);
>> +
>> +	lcd->prepared = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static int lcd_olinuxino_prepare(struct drm_panel *panel)
>> +{
>> +	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
>> +	int ret;
>> +
>> +	if (lcd->prepared)
>> +		return 0;
>> +
>> +	ret = regulator_enable(lcd->supply);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	gpiod_set_value_cansleep(lcd->enable_gpio, 1);
>> +	lcd->prepared = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int lcd_olinuxino_enable(struct drm_panel *panel)
>> +{
>> +	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
>> +
>> +	if (lcd->enabled)
>> +		return 0;
>> +
>> +	if (lcd->backlight) {
>> +		lcd->backlight->props.state &= ~BL_CORE_FBBLANK;
>> +		lcd->backlight->props.power = FB_BLANK_UNBLANK;
>> +		backlight_update_status(lcd->backlight);
>> +	}
> And this should simply call backlight_enable().
>
>> +
>> +	lcd->enabled = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int lcd_olinuxino_get_modes(struct drm_panel *panel)
>> +{
>> +	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
>> +	struct drm_connector *connector = lcd->panel.connector;
>> +	struct lcd_olinuxino_info *lcd_info = &lcd->eeprom.info;
>> +	struct drm_device *drm = lcd->panel.drm;
>> +	struct lcd_olinuxino_mode *lcd_mode;
>> +	struct drm_display_mode *mode;
>> +	int i, num = 0;
> These two can be unsigned.
>
>> +
>> +	/* Read up to 4 modes */
>> +	for (i = 0; i < lcd->eeprom.num_modes && i < 4; i++) {
> Can it happen that lcd->eeprom.num_modes >= 4? Seems to me like that
> would be a serious bug. Perhaps move that check to where the EEPROM is
> read and output a warning, then overwrite lcd->eeprom.num_modes with 4?
If num_modes is bigger than 4, then lcd_mode pointer will point to invalid
location. This can happen if someone overwrite the eeprom and apply
correct checksum at the end. Then i < 4 makes sure this won't happen.
>
>> +		lcd_mode = (struct lcd_olinuxino_mode *)
>> +			   &lcd->eeprom.reserved[i * sizeof(*lcd_mode)];
>> +
>> +		mode = drm_mode_create(drm);
>> +		if (!mode) {
>> +			dev_err(drm->dev, "failed to add mode %ux%u@%u\n",
>> +				lcd_mode->hactive,
>> +				lcd_mode->vactive,
>> +				lcd_mode->refresh);
>> +				continue;
>> +		}
>> +
>> +		mode->clock = lcd_mode->pixelclock;
>> +		mode->hdisplay = lcd_mode->hactive;
>> +		mode->hsync_start = lcd_mode->hactive + lcd_mode->hfp;
>> +		mode->hsync_end = lcd_mode->hactive + lcd_mode->hfp +
>> +				  lcd_mode->hpw;
>> +		mode->htotal = lcd_mode->hactive + lcd_mode->hfp +
>> +			       lcd_mode->hpw + lcd_mode->hbp;
>> +		mode->vdisplay = lcd_mode->vactive;
>> +		mode->vsync_start = lcd_mode->vactive + lcd_mode->vfp;
>> +		mode->vsync_end = lcd_mode->vactive + lcd_mode->vfp +
>> +				  lcd_mode->vpw;
>> +		mode->vtotal = lcd_mode->vactive + lcd_mode->vfp +
>> +			       lcd_mode->vpw + lcd_mode->vbp;
>> +		mode->vrefresh = lcd_mode->refresh;
>> +
>> +		if (lcd->eeprom.num_modes == 1)
>> +			mode->type |= DRM_MODE_TYPE_PREFERRED;
> Is there no way to determine the preferred mode if there are more than
> one? Perhaps always prefer the first mode?
My idea here is what if the first mode is not supported by the host? 
That's why
we will be storing multiple modes, one with the most strict timings
(e.g rounded to 10kHz or less, according to the lcd datesheet), and 
others with less strict.
>
>> +		mode->type |= DRM_MODE_TYPE_DRIVER;
>> +
>> +		drm_mode_set_name(mode);
>> +		drm_mode_probed_add(connector, mode);
>> +
>> +		num++;
>> +	}
>> +
>> +	memcpy(connector->display_info.name, lcd_info->name, 32);
>> +	connector->display_info.width_mm = lcd_info->width_mm;
>> +	connector->display_info.height_mm = lcd_info->height_mm;
>> +	connector->display_info.bpc = lcd_info->bpc;
>> +
>> +	if (lcd_info->bus_format)
>> +		drm_display_info_set_bus_formats(&connector->display_info,
>> +						 &lcd_info->bus_format, 1);
>> +	connector->display_info.bus_flags = lcd_info->bus_flag;
>> +
>> +	return num;
>> +}
>> +
>> +static const struct drm_panel_funcs lcd_olinuxino_funcs = {
>> +	.disable = lcd_olinuxino_disable,
>> +	.unprepare = lcd_olinuxino_unprepare,
>> +	.prepare = lcd_olinuxino_prepare,
>> +	.enable = lcd_olinuxino_enable,
>> +	.get_modes = lcd_olinuxino_get_modes,
>> +};
>> +
>> +static int lcd_olinuxino_probe(struct i2c_client *client,
>> +			       const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct device_node *backlight;
>> +	struct lcd_olinuxino *lcd;
>> +	u32 checksum;
>> +	int i, ret = 0;
> i can be unsigned.
>
>> +
>> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK))
>> +		return -ENODEV;
>> +
>> +	lcd = devm_kzalloc(dev, sizeof(*lcd), GFP_KERNEL);
>> +	if (!lcd)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(client, lcd);
>> +	lcd->dev = dev;
>> +	lcd->client = client;
>> +
>> +	mutex_init(&lcd->mutex);
>> +
>> +	/* Copy data into buffer */
>> +	for (i = 0; i < LCD_OLINUXINO_DATA_LEN; i += I2C_SMBUS_BLOCK_MAX) {
>> +		mutex_lock(&lcd->mutex);
>> +		ret = i2c_smbus_read_i2c_block_data(client,
>> +						    i,
>> +						    I2C_SMBUS_BLOCK_MAX,
>> +						    (u8 *)&lcd->eeprom + i);
>> +		mutex_unlock(&lcd->mutex);
>> +		if (ret < 0) {
>> +			dev_err(dev, "error reading from device at %02x\n", i);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	/* Check configuration checksum */
>> +	checksum = ~crc32(~0, (u8 *)&lcd->eeprom, 252);
>> +	if (checksum != lcd->eeprom.checksum) {
>> +		dev_err(dev, "configuration checksum does not match!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Check magic header */
>> +	if (lcd->eeprom.header != LCD_OLINUXINO_HEADER_MAGIC) {
>> +		dev_err(dev, "magic header does not match\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_info(dev, "Detected %s, Rev. %s, Serial: %08x\n",
>> +		 lcd->eeprom.info.name,
>> +		 lcd->eeprom.revision,
>> +		 lcd->eeprom.serial);
>> +
>> +	lcd->enabled = false;
>> +	lcd->prepared = false;
>> +
>> +	lcd->supply = devm_regulator_get(dev, "power");
>> +	if (IS_ERR(lcd->supply))
>> +		return PTR_ERR(lcd->supply);
>> +
>> +	lcd->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
>> +	if (IS_ERR(lcd->enable_gpio))
>> +		return PTR_ERR(lcd->enable_gpio);
>> +
>> +	backlight = of_parse_phandle(dev->of_node, "backlight", 0);
>> +	if (backlight) {
>> +		lcd->backlight = of_find_backlight_by_node(backlight);
>> +		of_node_put(backlight);
>> +
>> +		if (!lcd->backlight)
>> +			return -EPROBE_DEFER;
>> +	}
> This can now simply be of_find_backlight(), or better yet,
> devm_of_find_backlight().
>
>> +
>> +	drm_panel_init(&lcd->panel);
>> +	lcd->panel.dev = dev;
>> +	lcd->panel.funcs = &lcd_olinuxino_funcs;
>> +
>> +	ret = drm_panel_add(&lcd->panel);
>> +	if (ret < 0)
>> +		goto free_backlight;
>> +
>> +	return 0;
>> +
>> +free_backlight:
>> +	if (lcd->backlight)
>> +		put_device(&lcd->backlight->dev);
> With devm_of_find_backlight() this cleanup is no longer necessary.
>
>> +
>> +	return ret;
>> +}
>> +
>> +static int lcd_olinuxino_remove(struct i2c_client *client)
>> +{
>> +	struct lcd_olinuxino *panel = i2c_get_clientdata(client);
>> +
>> +	drm_panel_detach(&panel->panel);
> This should no longer be called from panel drivers, see:
>
> commit 38992c57c9c8425dc9cb75efe6f9b9255ea627a0
> Author: Jyri Sarha <jsarha@ti.com>
> Date:   Thu Apr 26 11:06:59 2018 +0300
>
>      drm/panel: Remove drm_panel_detach() calls from all panel drivers
>
>      Remove all drm_panel_detach() calls from all panel drivers and update
>      the kerneldoc for drm_panel_detach().
>
>      Setting the connector and drm to NULL when the DRM panel device is going
>      away hardly serves any purpose. Usually the whole memory structure is
>      freed right after the remove call. However, calling the detach function
>      from the master DRM device, and setting the connector pointer to NULL,
>      has the logic of marking the panel again as available for another DRM
>      master to attach. The usual situation would be the same DRM master
>      device binding again.
>
>      Signed-off-by: Jyri Sarha <jsarha@ti.com>
>      Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>      Signed-off-by: Thierry Reding <treding@nvidia.com>
>      Link: https://patchwork.freedesktop.org/patch/msgid/464b8d330d6b4c94cfb5aad2ca9ea7eb2c52d934.1524727888.git.jsarha@ti.com
>
>> +	drm_panel_remove(&panel->panel);
>> +
>> +	lcd_olinuxino_disable(&panel->panel);
>> +	lcd_olinuxino_unprepare(&panel->panel);
>> +
>> +	if (panel->backlight)
>> +		put_device(&panel->backlight->dev);
> This can go away with devm_of_find_backlight() as well.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id lcd_olinuxino_of_ids[] = {
>> +	{ .compatible = "olimex,lcd-olinuxino" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, lcd_olinuxino_of_ids);
>> +
>> +static struct i2c_driver lcd_olinuxino_driver = {
>> +	.driver = {
>> +		.name = "lcd_olinuxino",
>> +		.of_match_table = lcd_olinuxino_of_ids,
>> +	},
>> +	.probe = lcd_olinuxino_probe,
>> +	.remove = lcd_olinuxino_remove,
>> +};
>> +
>> +static int __init lcd_olinuxino_init(void)
>> +{
>> +	return i2c_add_driver(&lcd_olinuxino_driver);
>> +}
>> +module_init(lcd_olinuxino_init);
>> +
>> +static void __exit lcd_olinuxino_exit(void)
>> +{
>> +	i2c_del_driver(&lcd_olinuxino_driver);
>> +}
>> +module_exit(lcd_olinuxino_exit);
> module_i2c_driver()?
>
>> +
>> +MODULE_AUTHOR("Stefan Mavrodiev <stefan@olimex.com>");
>> +MODULE_DESCRIPTION("LCD-OLinuXino driver");
>> +MODULE_LICENSE("GPL v2");
> This seems to contradict the GPL-2.0+ in the SPDX header.
Can you elaborate on this?
>
> Thierry

Best regards,
Stefan Mavrodiev

