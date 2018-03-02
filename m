Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1164852-1519981722-2-7043151130662691251
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981721; b=pHHKEVon8Ed9+JReXA2vSInhX1Bx2mRwRWSeRtHqoOxO/bP
    9TS0RJ0QgJTEvHzlW68amgZTuFQ3wwduXo76Ts8uJciQgE/08t82Rv+baR9ujvVd
    N07PLriReCXCyVlyP3hDvNBi3FfU0oYhaw6sM1w8vyoP5+CrKnKGF48OEi0oG/rj
    llp4DbAvUo9S3VgrN1au/LRp+7n3YLWja9BQ4kgb7jGcYqlAE9R7lOGl/qoBFBnR
    ZxtnHu5i0s6fAZsR565zFof9alm9ewZ2jefisbb4Ax4usa6u9bDZjBGAeDD0AGda
    wKGb2hpKnE2V2fVKFLApfRrM/6meP5tRr4PNnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519981721; bh=BcCrJSF8Wl3bNIW73c6/sicGIcsxoHjgUv8vko72/1U=; b=W
    rgvqhymOwO0K9lyYcODf8k2OQ+vyDjwHNFbiANj927ue6EeLqofHeqklJve4icPT
    rVxRCbQzz8oFsZ+4NC00OUlPiXIXmbRuhryBDx4y6n3Hszn+hqA5DRoVd7mrqtPr
    h4oC4DZnDVEVTAUnv/1ezoEzIktNbqvxEKgt/yv9a8oJ+4XVyO5+HKGo9JXaAER/
    PaXwHmLcnud4cXdXAHSK7wHZ4YyNGigCJAIQ8EPOFrNTC4i/Km5537VCp/4x/4AM
    LULmrcf0F0z8l0VekpvbD2IOZGF0idL9ExqOlheW7BLP0H/k7v8TrPO3xLeD4xoK
    4woAdoOtM/qv8FxKgwDbw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CItoYnFn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CItoYnFn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425185AbeCBJGp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:06:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50277 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425305AbeCBJGb (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 2 Mar 2018 04:06:31 -0500
X-Google-Smtp-Source: AG47ELuW8+gnhLwRBlblVXeXsOnFv5y9W4h9/GZnHhOVFiR2MC3wWvLKGkPGZ6YUeVBh0GPPCYJgLQ==
Subject: Re: [PATCH v5 12/12] extcon: axp288: Set USB role where necessary
To: Chanwoo Choi <cw00.choi@samsung.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180228150749.26831-1-hdegoede@redhat.com>
 <CGME20180228150823epcas1p18ceabaf6cbfffbc9b54ed5e1458b7b80@epcas1p1.samsung.com>
 <20180228150749.26831-13-hdegoede@redhat.com> <5A989D2B.8090903@samsung.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <01235ed2-59e1-93c1-7bc1-03d5dd1b4f3e@redhat.com>
Date: Fri, 2 Mar 2018 10:06:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A989D2B.8090903@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 02-03-18 01:39, Chanwoo Choi wrote:
> Hi,
> 
> Basically, I have no objection. But I'll reply the my ack tag
> after finishing the review of 'devcon and usb_role_switch' from USB maintainer.
> 
> And I have a question.
> Before this patch, extcon-axp288 is used to detect charger connector
> and extcon-intel-int3496 is used to detect the USB_HOST connector
> on one h/w device?

Yes the ACPI tables of some devices with an AXP288 PMIC have an INT3496
ACPI device which gives access to the id-pin on the micro-AB connector
which the extcon-intel-int3496 exports as a USB_HOST connector, on these
devices we fully control the USB role.

On other devices the switching of the USB data lines is controlled by AML
code which switches the data lines, but never sets the VBus valid bit
in the USB PHY control registers, so it is effectively switching between
between the host and none roles, since the device role only works when
the VBus valid bit is set.

This patch addresses both types of devices / ACPI tables and makes
host *and* device mode work. This patch also makes switching between them
by plugging in a different cable after boot work.

Regards,

Hans



> 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
> 
> On 2018년 03월 01일 00:07, Hans de Goede wrote:
>> The AXP288 BC1.2 charger detection / extcon code may seem like a strange
>> place to add code to control the USB role-switch on devices with an AXP288,
>> but there are 2 reasons to do this inside the axp288 extcon code:
>>
>> 1) On many devices the USB role is controlled by ACPI AML code, but the AML
>>     code only switches between the host and none roles, because of Windows
>>     not really using device mode. To make device mode work we need to toggle
>>     between the none/device roles based on Vbus presence, and the axp288
>>     extcon gets interrupts on Vbus insertion / removal.
>>
>> 2) In order for our BC1.2 charger detection to work properly the role
>>     mux must be properly set to device mode before we do the detection.
>>
>> Also note the Kconfig help-text / obsolete depends on USB_PHY which are
>> remnants from older never upstreamed code also controlling the mux from
>> the axp288 extcon code.
>>
>> This commit also adds code to get notifications from the INT3496 extcon
>> device, which is used on some devices to notify the kernel about id-pin
>> changes instead of them being handled through AML code.
>>
>> This fixes:
>> -Device mode not working on most CHT devices with an AXP288
>> -Host mode not working on devices with an INT3496 ACPI device
>> -Charger-type misdetection (always SDP) on devices with an INT3496 when the
>>   USB role (always) gets initialized as host
>>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v4:
>> -Add Andy's Reviewed-by
>>
>> Changes in v2:
>> -Add depends on X86 to Kconfig (the AXP288 PMIC is only used on X86)
>> -Use new acpi_dev_get_first_match_name() helper to get the INT3496 device-name
>> -Add Heikki's Reviewed-by
>> ---
>>   drivers/extcon/Kconfig         |   3 +-
>>   drivers/extcon/extcon-axp288.c | 177 +++++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 171 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>> index a7bca4207f44..de15bf55895b 100644
>> --- a/drivers/extcon/Kconfig
>> +++ b/drivers/extcon/Kconfig
>> @@ -30,7 +30,8 @@ config EXTCON_ARIZONA
>>   
>>   config EXTCON_AXP288
>>   	tristate "X-Power AXP288 EXTCON support"
>> -	depends on MFD_AXP20X && USB_PHY
>> +	depends on MFD_AXP20X && USB_SUPPORT && X86
>> +	select USB_ROLE_SWITCH
>>   	help
>>   	  Say Y here to enable support for USB peripheral detection
>>   	  and USB MUX switching by X-Power AXP288 PMIC.
>> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
>> index 3ec4c715e240..51e77c7a32c2 100644
>> --- a/drivers/extcon/extcon-axp288.c
>> +++ b/drivers/extcon/extcon-axp288.c
>> @@ -1,6 +1,7 @@
>>   /*
>>    * extcon-axp288.c - X-Power AXP288 PMIC extcon cable detection driver
>>    *
>> + * Copyright (c) 2017-2018 Hans de Goede <hdegoede@redhat.com>
>>    * Copyright (C) 2015 Intel Corporation
>>    * Author: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
>>    *
>> @@ -14,6 +15,8 @@
>>    * GNU General Public License for more details.
>>    */
>>   
>> +#include <linux/acpi.h>
>> +#include <linux/connection.h>
>>   #include <linux/module.h>
>>   #include <linux/kernel.h>
>>   #include <linux/io.h>
>> @@ -25,6 +28,11 @@
>>   #include <linux/extcon-provider.h>
>>   #include <linux/regmap.h>
>>   #include <linux/mfd/axp20x.h>
>> +#include <linux/usb/role.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include <asm/cpu_device_id.h>
>> +#include <asm/intel-family.h>
>>   
>>   /* Power source status register */
>>   #define PS_STAT_VBUS_TRIGGER		BIT(0)
>> @@ -97,9 +105,19 @@ struct axp288_extcon_info {
>>   	struct device *dev;
>>   	struct regmap *regmap;
>>   	struct regmap_irq_chip_data *regmap_irqc;
>> +	struct usb_role_switch *role_sw;
>> +	struct work_struct role_work;
>>   	int irq[EXTCON_IRQ_END];
>>   	struct extcon_dev *edev;
>> +	struct extcon_dev *id_extcon;
>> +	struct notifier_block id_nb;
>>   	unsigned int previous_cable;
>> +	bool vbus_attach;
>> +};
>> +
>> +static const struct x86_cpu_id cherry_trail_cpu_ids[] = {
>> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_AIRMONT, X86_FEATURE_ANY },
>> +	{}
>>   };
>>   
>>   /* Power up/down reason string array */
>> @@ -137,20 +155,74 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>>   	regmap_write(info->regmap, AXP288_PS_BOOT_REASON_REG, clear_mask);
>>   }
>>   
>> -static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>> +/*
>> + * The below code to control the USB role-switch on devices with an AXP288
>> + * may seem out of place, but there are 2 reasons why this is the best place
>> + * to control the USB role-switch on such devices:
>> + * 1) On many devices the USB role is controlled by AML code, but the AML code
>> + *    only switches between the host and none roles, because of Windows not
>> + *    really using device mode. To make device mode work we need to toggle
>> + *    between the none/device roles based on Vbus presence, and this driver
>> + *    gets interrupts on Vbus insertion / removal.
>> + * 2) In order for our BC1.2 charger detection to work properly the role
>> + *    mux must be properly set to device mode before we do the detection.
>> + */
>> +
>> +/* Returns the id-pin value, note pulled low / false == host-mode */
>> +static bool axp288_get_id_pin(struct axp288_extcon_info *info)
>>   {
>> -	int ret, stat, cfg, pwr_stat;
>> -	u8 chrg_type;
>> -	unsigned int cable = info->previous_cable;
>> -	bool vbus_attach = false;
>> +	enum usb_role role;
>> +
>> +	if (info->id_extcon)
>> +		return extcon_get_state(info->id_extcon, EXTCON_USB_HOST) <= 0;
>> +
>> +	/* We cannot access the id-pin, see what mode the AML code has set */
>> +	role = usb_role_switch_get_role(info->role_sw);
>> +	return role != USB_ROLE_HOST;
>> +}
>> +
>> +static void axp288_usb_role_work(struct work_struct *work)
>> +{
>> +	struct axp288_extcon_info *info =
>> +		container_of(work, struct axp288_extcon_info, role_work);
>> +	enum usb_role role;
>> +	bool id_pin;
>> +	int ret;
>> +
>> +	id_pin = axp288_get_id_pin(info);
>> +	if (!id_pin)
>> +		role = USB_ROLE_HOST;
>> +	else if (info->vbus_attach)
>> +		role = USB_ROLE_DEVICE;
>> +	else
>> +		role = USB_ROLE_NONE;
>> +
>> +	ret = usb_role_switch_set_role(info->role_sw, role);
>> +	if (ret)
>> +		dev_err(info->dev, "failed to set role: %d\n", ret);
>> +}
>> +
>> +static bool axp288_get_vbus_attach(struct axp288_extcon_info *info)
>> +{
>> +	int ret, pwr_stat;
>>   
>>   	ret = regmap_read(info->regmap, AXP288_PS_STAT_REG, &pwr_stat);
>>   	if (ret < 0) {
>>   		dev_err(info->dev, "failed to read vbus status\n");
>> -		return ret;
>> +		return false;
>>   	}
>>   
>> -	vbus_attach = (pwr_stat & PS_STAT_VBUS_VALID);
>> +	return !!(pwr_stat & PS_STAT_VBUS_VALID);
>> +}
>> +
>> +static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>> +{
>> +	int ret, stat, cfg;
>> +	u8 chrg_type;
>> +	unsigned int cable = info->previous_cable;
>> +	bool vbus_attach = false;
>> +
>> +	vbus_attach = axp288_get_vbus_attach(info);
>>   	if (!vbus_attach)
>>   		goto no_vbus;
>>   
>> @@ -201,6 +273,12 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>>   		info->previous_cable = cable;
>>   	}
>>   
>> +	if (info->role_sw && info->vbus_attach != vbus_attach) {
>> +		info->vbus_attach = vbus_attach;
>> +		/* Setting the role can take a while */
>> +		queue_work(system_long_wq, &info->role_work);
>> +	}
>> +
>>   	return 0;
>>   
>>   dev_det_ret:
>> @@ -210,6 +288,18 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>>   	return ret;
>>   }
>>   
>> +static int axp288_extcon_id_evt(struct notifier_block *nb,
>> +				unsigned long event, void *param)
>> +{
>> +	struct axp288_extcon_info *info =
>> +		container_of(nb, struct axp288_extcon_info, id_nb);
>> +
>> +	/* We may not sleep and setting the role can take a while */
>> +	queue_work(system_long_wq, &info->role_work);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>>   static irqreturn_t axp288_extcon_isr(int irq, void *data)
>>   {
>>   	struct axp288_extcon_info *info = data;
>> @@ -231,10 +321,20 @@ static void axp288_extcon_enable(struct axp288_extcon_info *info)
>>   					BC_GLOBAL_RUN, BC_GLOBAL_RUN);
>>   }
>>   
>> +static void axp288_put_role_sw(void *data)
>> +{
>> +	struct axp288_extcon_info *info = data;
>> +
>> +	cancel_work_sync(&info->role_work);
>> +	usb_role_switch_put(info->role_sw);
>> +}
>> +
>>   static int axp288_extcon_probe(struct platform_device *pdev)
>>   {
>>   	struct axp288_extcon_info *info;
>>   	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>> +	struct device *dev = &pdev->dev;
>> +	const char *name;
>>   	int ret, i, pirq;
>>   
>>   	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>> @@ -245,9 +345,33 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>   	info->regmap = axp20x->regmap;
>>   	info->regmap_irqc = axp20x->regmap_irqc;
>>   	info->previous_cable = EXTCON_NONE;
>> +	INIT_WORK(&info->role_work, axp288_usb_role_work);
>> +	info->id_nb.notifier_call = axp288_extcon_id_evt;
>>   
>>   	platform_set_drvdata(pdev, info);
>>   
>> +	info->role_sw = usb_role_switch_get(dev);
>> +	if (IS_ERR(info->role_sw))
>> +		return PTR_ERR(info->role_sw);
>> +	if (info->role_sw) {
>> +		ret = devm_add_action_or_reset(dev, axp288_put_role_sw, info);
>> +		if (ret)
>> +			return ret;
>> +
>> +		name = acpi_dev_get_first_match_name("INT3496", NULL, -1);
>> +		if (name) {
>> +			info->id_extcon = extcon_get_extcon_dev(name);
>> +			if (!info->id_extcon)
>> +				return -EPROBE_DEFER;
>> +
>> +			dev_info(dev, "controlling USB role\n");
>> +		} else {
>> +			dev_info(dev, "controlling USB role based on Vbus presence\n");
>> +		}
>> +	}
>> +
>> +	info->vbus_attach = axp288_get_vbus_attach(info);
>> +
>>   	axp288_extcon_log_rsi(info);
>>   
>>   	/* Initialize extcon device */
>> @@ -289,6 +413,19 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>   
>> +	if (info->id_extcon) {
>> +		ret = devm_extcon_register_notifier_all(dev, info->id_extcon,
>> +							&info->id_nb);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/* Make sure the role-sw is set correctly before doing BC detection */
>> +	if (info->role_sw) {
>> +		queue_work(system_long_wq, &info->role_work);
>> +		flush_work(&info->role_work);
>> +	}
>> +
>>   	/* Start charger cable type detection */
>>   	axp288_extcon_enable(info);
>>   
>> @@ -308,8 +445,32 @@ static struct platform_driver axp288_extcon_driver = {
>>   		.name = "axp288_extcon",
>>   	},
>>   };
>> -module_platform_driver(axp288_extcon_driver);
>> +
>> +static struct devcon axp288_extcon_role_sw_conn = {
>> +	.endpoint[0] = "axp288_extcon",
>> +	.endpoint[1] = "intel_xhci_usb_sw-role-switch",
>> +	.id = "usb-role-switch",
>> +};
>> +
>> +static int __init axp288_extcon_init(void)
>> +{
>> +	if (x86_match_cpu(cherry_trail_cpu_ids))
>> +		add_device_connection(&axp288_extcon_role_sw_conn);
>> +
>> +	return platform_driver_register(&axp288_extcon_driver);
>> +}
>> +module_init(axp288_extcon_init);
>> +
>> +static void __exit axp288_extcon_exit(void)
>> +{
>> +	if (x86_match_cpu(cherry_trail_cpu_ids))
>> +		remove_device_connection(&axp288_extcon_role_sw_conn);
>> +
>> +	platform_driver_unregister(&axp288_extcon_driver);
>> +}
>> +module_exit(axp288_extcon_exit);
>>   
>>   MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
>> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
>>   MODULE_DESCRIPTION("X-Powers AXP288 extcon driver");
>>   MODULE_LICENSE("GPL v2");
>>
> 
