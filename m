Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeCNU7m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:59:42 -0400
Received: from avasout05.plus.net ([84.93.230.250]:35307 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeCNU7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:59:40 -0400
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=J9KEEjvS c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=beXlt2xKAAAA:8 a=6zb38KopAAAA:8 a=NEAV23lmAAAA:8
 a=XYAwZIGsAAAA:8 a=hD80L64hAAAA:8 a=gDa6Kuw4OPRGGaaQh-IA:9
 a=5DIlHvWof964zkOF:21 a=oFeqof8tiyqOLYqH:21 a=CjuIK1q_8ugA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22 a=gcY2M4Ci8LIz02MwfSIM:22
 a=sLgWHmCJlhLUVLMAeJB5:22 a=E8ToXWR_bxluHZ7gmE-Z:22
Date: Wed, 14 Mar 2018 20:59:38 +0000
From: Nick Dyer <nick@shmanahar.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] Input: atmel_mxt_ts - remove platform data support
Message-ID: <20180314205938.GD26353@lava.h.shmanahar.org>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-15-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312190907.174301-15-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfGdepyqMvzHAidQH1MhYO2xJabQFoNTQ5NmQ6bIFPgqcv5A4C5COOY6aSPJHr1vFA2Xm2wlNPPUT9Trt/2xPYXCD09yw/ZDmGi92wiU9KYZ24HIx3ZZl
 0oRBvpWKEQsS7LZINTxmej7wOm3IKzvuWms=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 12:09:07PM -0700, Dmitry Torokhov wrote:
> Date: Mon, 12 Mar 2018 12:09:07 -0700
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
> Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
>  linux-kernel@vger.kernel.org
> Subject: [PATCH 14/14] Input: atmel_mxt_ts - remove platform data support
> 
> Now that there are no users of custom Atmel platform data, and everyone
> has switched to the generic device properties, we can remove support for
> the platform data.

Thanks, this is a nice tidy up.

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  MAINTAINERS                                |   1 -
>  drivers/input/touchscreen/atmel_mxt_ts.c   | 125 +++++++++------------
>  include/linux/platform_data/atmel_mxt_ts.h |  31 -----
>  3 files changed, 50 insertions(+), 107 deletions(-)
>  delete mode 100644 include/linux/platform_data/atmel_mxt_ts.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4623caf8d72d8..37b70874a4771 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2394,7 +2394,6 @@ T:	git git://github.com/ndyer/linux.git
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
>  F:	drivers/input/touchscreen/atmel_mxt_ts.c
> -F:	include/linux/platform_data/atmel_mxt_ts.h
>  
>  ATMEL SAMA5D2 ADC DRIVER
>  M:	Ludovic Desroches <ludovic.desroches@microchip.com>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index cf2aac4e79ae8..642211254acc4 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -23,10 +23,10 @@
>  #include <linux/delay.h>
>  #include <linux/firmware.h>
>  #include <linux/i2c.h>
> -#include <linux/platform_data/atmel_mxt_ts.h>
>  #include <linux/input/mt.h>
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/property.h>
> @@ -274,7 +274,6 @@ struct mxt_data {
>  	struct i2c_client *client;
>  	struct input_dev *input_dev;
>  	char phys[64];		/* device physical location */
> -	const struct mxt_platform_data *pdata;
>  	struct mxt_object *object_table;
>  	struct mxt_info info;
>  	unsigned int irq;
> @@ -325,6 +324,9 @@ struct mxt_data {
>  
>  	/* for config update handling */
>  	struct completion crc_completion;
> +
> +	u32 *t19_keymap;
> +	unsigned int t19_num_keys;
>  };
>  
>  struct mxt_vb2_buffer {
> @@ -743,15 +745,14 @@ static int mxt_write_object(struct mxt_data *data,
>  static void mxt_input_button(struct mxt_data *data, u8 *message)
>  {
>  	struct input_dev *input = data->input_dev;
> -	const struct mxt_platform_data *pdata = data->pdata;
>  	int i;
>  
> -	for (i = 0; i < pdata->t19_num_keys; i++) {
> -		if (pdata->t19_keymap[i] == KEY_RESERVED)
> +	for (i = 0; i < data->t19_num_keys; i++) {
> +		if (data->t19_keymap[i] == KEY_RESERVED)
>  			continue;
>  
>  		/* Active-low switch */
> -		input_report_key(input, pdata->t19_keymap[i],
> +		input_report_key(input, data->t19_keymap[i],
>  				 !(message[1] & BIT(i)));
>  	}
>  }
> @@ -759,7 +760,7 @@ static void mxt_input_button(struct mxt_data *data, u8 *message)
>  static void mxt_input_sync(struct mxt_data *data)
>  {
>  	input_mt_report_pointer_emulation(data->input_dev,
> -					  data->pdata->t19_num_keys);
> +					  data->t19_num_keys);
>  	input_sync(data->input_dev);
>  }
>  
> @@ -1859,7 +1860,6 @@ static void mxt_input_close(struct input_dev *dev);
>  static void mxt_set_up_as_touchpad(struct input_dev *input_dev,
>  				   struct mxt_data *data)
>  {
> -	const struct mxt_platform_data *pdata = data->pdata;
>  	int i;
>  
>  	input_dev->name = "Atmel maXTouch Touchpad";
> @@ -1873,15 +1873,14 @@ static void mxt_set_up_as_touchpad(struct input_dev *input_dev,
>  	input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
>  			  MXT_PIXELS_PER_MM);
>  
> -	for (i = 0; i < pdata->t19_num_keys; i++)
> -		if (pdata->t19_keymap[i] != KEY_RESERVED)
> +	for (i = 0; i < data->t19_num_keys; i++)
> +		if (data->t19_keymap[i] != KEY_RESERVED)
>  			input_set_capability(input_dev, EV_KEY,
> -					     pdata->t19_keymap[i]);
> +					     data->t19_keymap[i]);
>  }
>  
>  static int mxt_initialize_input_device(struct mxt_data *data)
>  {
> -	const struct mxt_platform_data *pdata = data->pdata;
>  	struct device *dev = &data->client->dev;
>  	struct input_dev *input_dev;
>  	int error;
> @@ -1947,7 +1946,7 @@ static int mxt_initialize_input_device(struct mxt_data *data)
>  	}
>  
>  	/* If device has buttons we assume it is a touchpad */
> -	if (pdata->t19_num_keys) {
> +	if (data->t19_num_keys) {
>  		mxt_set_up_as_touchpad(input_dev, data);
>  		mt_flags |= INPUT_MT_POINTER;
>  	} else {
> @@ -2921,51 +2920,42 @@ static void mxt_input_close(struct input_dev *dev)
>  	mxt_stop(data);
>  }
>  
> -static const struct mxt_platform_data *
> -mxt_parse_device_properties(struct i2c_client *client)
> +static int mxt_parse_device_properties(struct mxt_data *data)
>  {
>  	static const char keymap_property[] = "linux,gpio-keymap";
> -	struct mxt_platform_data *pdata;
> +	struct device *dev = &data->client->dev;
>  	u32 *keymap;
>  	int n_keys;
>  	int error;
>  
> -	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata)
> -		return ERR_PTR(-ENOMEM);
> -
> -	if (device_property_present(&client->dev, keymap_property)) {
> -		n_keys = device_property_read_u32_array(&client->dev,
> -							keymap_property,
> +	if (device_property_present(dev, keymap_property)) {
> +		n_keys = device_property_read_u32_array(dev, keymap_property,
>  							NULL, 0);
>  		if (n_keys <= 0) {
>  			error = n_keys < 0 ? n_keys : -EINVAL;
> -			dev_err(&client->dev,
> -				"invalid/malformed '%s' property: %d\n",
> +			dev_err(dev, "invalid/malformed '%s' property: %d\n",
>  				keymap_property, error);
> -			return ERR_PTR(error);
> +			return error;
>  		}
>  
> -		keymap = devm_kmalloc_array(&client->dev, n_keys, sizeof(u32),
> +		keymap = devm_kmalloc_array(dev, n_keys, sizeof(*keymap),
>  					    GFP_KERNEL);
>  		if (!keymap)
> -			return ERR_PTR(-ENOMEM);
> +			return -ENOMEM;
>  
> -		error = device_property_read_u32_array(&client->dev,
> -						       keymap_property,
> +		error = device_property_read_u32_array(dev, keymap_property,
>  						       keymap, n_keys);
>  		if (error) {
> -			dev_err(&client->dev,
> -				"failed to parse '%s' property: %d\n",
> +			dev_err(dev, "failed to parse '%s' property: %d\n",
>  				keymap_property, error);
> -			return ERR_PTR(error);
> +			return error;
>  		}
>  
> -		pdata->t19_keymap = keymap;
> -		pdata->t19_num_keys = n_keys;
> +		data->t19_keymap = keymap;
> +		data->t19_num_keys = n_keys;
>  	}
>  
> -	return pdata;
> +	return 0;
>  }
>  
>  #ifdef CONFIG_ACPI
> @@ -3048,25 +3038,12 @@ static const struct dmi_system_id mxt_dmi_table[] = {
>  	{ }
>  };
>  
> -static int mxt_acpi_probe(struct i2c_client *client)
> +static int mxt_prepare_acpi_properties(struct i2c_client *client)
>  {
>  	struct acpi_device *adev;
>  	const struct dmi_system_id *system_id;
>  	const struct mxt_acpi_platform_data *acpi_pdata;
>  
> -	/*
> -	 * Ignore ACPI devices representing bootloader mode.
> -	 *
> -	 * This is a bit of a hack: Google Chromebook BIOS creates ACPI
> -	 * devices for both application and bootloader modes, but we are
> -	 * interested in application mode only (if device is in bootloader
> -	 * mode we'll end up switching into application anyway). So far
> -	 * application mode addresses were all above 0x40, so we'll use it
> -	 * as a threshold.
> -	 */
> -	if (client->addr < 0x40)
> -		return -ENXIO;

Could you use 0x4a, since that's the lowest application mode address,
same in the other place.

Can I ask if you've checked the behaviour if the device is probed while
it's already in bootloader mode? Ideally you want to be able to recover
from a bad firmware flash.

> -
>  	adev = ACPI_COMPANION(&client->dev);
>  	if (!adev)
>  		return -ENOENT;
> @@ -3102,37 +3079,29 @@ static int mxt_acpi_probe(struct i2c_client *client)
>  	return 0;
>  }
>  #else
> -static int mxt_acpi_probe(struct i2c_client *client)
> +static int mxt_prepare_acpi_properties(struct i2c_client *client)
>  {
>  	return -ENOENT;
>  }
>  #endif
>  
> -static const struct mxt_platform_data *
> -mxt_get_platform_data(struct i2c_client *client)
> -{
> -	const struct mxt_platform_data *pdata;
> -
> -	pdata = dev_get_platdata(&client->dev);
> -	if (pdata)
> -		return pdata;
> -
> -	return mxt_parse_device_properties(client);
> -}
> -
>  static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
>  	struct mxt_data *data;
> -	const struct mxt_platform_data *pdata;
>  	int error;
>  
> -	error = mxt_acpi_probe(client);
> -	if (error && error != -ENOENT)
> -		return error;
> -
> -	pdata = mxt_get_platform_data(client);
> -	if (IS_ERR(pdata))
> -		return PTR_ERR(pdata);
> +	/*
> +	 * Ignore ACPI devices representing bootloader mode.
> +	 *
> +	 * This is a bit of a hack: Google Chromebook BIOS creates ACPI
> +	 * devices for both application and bootloader modes, but we are
> +	 * interested in application mode only (if device is in bootloader
> +	 * mode we'll end up switching into application anyway). So far
> +	 * application mode addresses were all above 0x40, so we'll use it
> +	 * as a threshold.
> +	 */
> +	if (ACPI_COMPANION(&client->dev) && client->addr < 0x40)
> +		return -ENXIO;
>  
>  	data = devm_kzalloc(&client->dev, sizeof(struct mxt_data), GFP_KERNEL);
>  	if (!data)
> @@ -3142,7 +3111,6 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		 client->adapter->nr, client->addr);
>  
>  	data->client = client;
> -	data->pdata = pdata;
>  	data->irq = client->irq;
>  	i2c_set_clientdata(client, data);
>  
> @@ -3150,6 +3118,14 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	init_completion(&data->reset_completion);
>  	init_completion(&data->crc_completion);
>  
> +	error = mxt_prepare_acpi_properties(client);
> +	if (error && error != -ENOENT)
> +		return error;
> +
> +	error = mxt_parse_device_properties(data);
> +	if (error)
> +		return error;
> +
>  	data->reset_gpio = devm_gpiod_get_optional(&client->dev,
>  						   "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(data->reset_gpio)) {
> @@ -3159,8 +3135,7 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	}
>  
>  	error = devm_request_threaded_irq(&client->dev, client->irq,
> -					  NULL, mxt_interrupt,
> -					  pdata->irqflags | IRQF_ONESHOT,
> +					  NULL, mxt_interrupt, IRQF_ONESHOT,
>  					  client->name, data);
>  	if (error) {
>  		dev_err(&client->dev, "Failed to register interrupt\n");
> @@ -3280,7 +3255,7 @@ MODULE_DEVICE_TABLE(i2c, mxt_id);
>  static struct i2c_driver mxt_driver = {
>  	.driver = {
>  		.name	= "atmel_mxt_ts",
> -		.of_match_table = of_match_ptr(mxt_of_match),
> +		.of_match_table = mxt_of_match,
>  		.acpi_match_table = ACPI_PTR(mxt_acpi_id),
>  		.pm	= &mxt_pm_ops,
>  	},
> diff --git a/include/linux/platform_data/atmel_mxt_ts.h b/include/linux/platform_data/atmel_mxt_ts.h
> deleted file mode 100644
> index 695035a8d7fb9..0000000000000
> --- a/include/linux/platform_data/atmel_mxt_ts.h
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -/*
> - * Atmel maXTouch Touchscreen driver
> - *
> - * Copyright (C) 2010 Samsung Electronics Co.Ltd
> - * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
> - */
> -
> -#ifndef __LINUX_PLATFORM_DATA_ATMEL_MXT_TS_H
> -#define __LINUX_PLATFORM_DATA_ATMEL_MXT_TS_H
> -
> -#include <linux/types.h>
> -
> -enum mxt_suspend_mode {
> -	MXT_SUSPEND_DEEP_SLEEP	= 0,
> -	MXT_SUSPEND_T9_CTRL	= 1,
> -};
> -
> -/* The platform data for the Atmel maXTouch touchscreen driver */
> -struct mxt_platform_data {
> -	unsigned long irqflags;
> -	u8 t19_num_keys;
> -	const unsigned int *t19_keymap;
> -	enum mxt_suspend_mode suspend_mode;
> -};
> -
> -#endif /* __LINUX_PLATFORM_DATA_ATMEL_MXT_TS_H */
> -- 
> 2.16.2.660.g709887971b-goog
> 
