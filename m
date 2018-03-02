Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-122591-1519951158-2-1265621725499162724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519951157; b=FnjJ5wLVKMCz9aQLpEgFIg2ADOgJVXhnteDwrnuQqLYEEuo
    3ecINVupMKSPO0UC9+8KPcH/f3D6Fci5ruStlTdluMC7G+Fi/6nr0iF57qMB+57f
    9htmjxbbckxlAx1xTgL4kYucZpwmcS8cNszYvlvZ+5/cBu0IfPKYpbdilZwhIgKv
    tNbwJz03klW44gJpeYt+CITxkEqnfjKGHBqAyhdRsbx1TjKJ8Zx80LcB6tCxubUS
    xpOsNY2HJWabeNFqI7wjEFzFAx4QMIL2KHfPxQ4rT43c07t93/Px+Oe+d+GGt0y2
    YtQ4fL7KcFz+6ixqov5HR/eaU9o7Lfz9ANP/X5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1519951157; bh=j7t/UKO0
    Nek2ahrRRdVwXWORW7j5XY3FgssR7hiqbH4=; b=mPvcqlYT8SA2ocjlz0B+OSHo
    1yWzm+ISvB1DbQgSj/1kNHNs/0cX3QJG0P0F69jfZFx/vx21yMbRTJmSOb0U1ZIq
    aubm01RnqoIeccNjyGx1DrEK9EN9a3Jilg8Mo9b2b2BMkKgQAC5lDkU42LyPIla0
    TfG9LD5Gc5Op/HKEfeKK5Wz3GSVsNrzwXIk2+WSm8cG7NVFMMo/JOn/9awmj9FCF
    wYatd01vg8R/kSO+TvYjoZAdLD7SXB03/n7mpnMlY3/DPEfxdUnBMGnpTAZMm/te
    feLPL30z8aDR0wr0rTdb9wJ+WYIOn8rM/FjGaNwqdcnYvnILGqtnAog06BymoQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=hoC4gmyK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=hoC4gmyK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163827AbeCBAjN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 19:39:13 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:39221 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163826AbeCBAjL (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Mar 2018 19:39:11 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180302003908epoutp023e2ff4d987e8b01d633cab57e70e4bfa~X84Q7Ofh31525815258epoutp02u
X-AuditID: b6c32a46-3c1ff70000001029-a4-5a989d2c2cb1
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A989D2B.8090903@samsung.com>
Date: Fri, 02 Mar 2018 09:39:07 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 12/12] extcon: axp288: Set USB role where necessary
In-reply-to: <20180228150749.26831-13-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmma7O3BlRBu8Xc1tMmvGf2aJroYFF
        8+L1bBZvjk9nsuhavZPF4vKuOWwWi5a1Mls8WXiGyaJ50xRWi9uNK9gsVu95wezA7bF5hZbH
        4j0vmTzmnQz02D93DbvH+31X2Tx2fm9g9+jbsorR4/MmuQCOqFSbjNTElNQihdS85PyUzLx0
        WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAzlRTKEnNKgUIBicXFSvp2NkX5pSWp
        Chn5xSW2StGGhkZ6hgbmekZGRnomxrFWRqZAJQmpGS8PnmUq2BxX0fvzHGMD4zPvLkZODgkB
        E4kvs/pYQGwhgR2MEq9WhXcxcgHZ3xklfs3ewQ5TdO/FBRaIxG5GiebXTcwgCV4BQYkfk+8B
        JTg4mAXkJY5cygYJMwtoSmzdvZ4dov4eo8SZf0vYIeq1JH5Nb2IFsVkEVCUWX/8EZrMBxfe/
        uMEGYvMLKEpc/fGYEcQWFYiQ2Dn/G1iviMBlJom2yc4QC5IkmrceYQKxhQW8JCaffQN2D6eA
        lcTxlQ1sIIslBP6zSdx58YgV5DgJAReJo+dMIJ4Rlnh1fAvUY9ISz1ZtZISob2eUaN87jxnC
        mcIoce76PSaIKmOJZwu7mCA280l0HP7LDjGUV6KjTQiixEPi4ZpWqKGOEus/H2CD+H4Po8SL
        hsvsExjlZiEF2CxEgM1CCrAFjMyrGMVSC4pz01OLjQqM9IoTc4tL89L1kvNzNzGCE6aW2w7G
        Jed8DjEKcDAq8fDu4JwRJcSaWFZcmXuIUYKDWUmE9/T2aVFCvCmJlVWpRfnxRaU5qcWHGE2B
        4T2RWUo0OR+YzPNK4g1NLA1MzMyMzM0sgAlMnLc1wCVKSCA9sSQ1OzW1ILUIpo+Jg1OqgTHt
        oQIXXyD7RWeLsK/um1X/VSzUrZy73f2f+bbZJ+IcfZ8fnceoVaprpvr5l/XPQ8qPwyb8fHsz
        fOcf2Y6QNyLb1s2KSedi1LnSs1qouzk8Y+fz16X9krYTQ5ifOeoyaHO/5+RiedjjEZmdqeX5
        q92u8+7l45Ksy02i3t6eeE42/OJuVosDdkosxRmJhlrMRcWJANtFNuGuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t9jAV3tuTOiDO6f1LaYNOM/s0XXQgOL
        5sXr2SzeHJ/OZNG1eieLxeVdc9gsFi1rZbZ4svAMk0XzpimsFrcbV7BZrN7zgtmB22PzCi2P
        xXteMnnMOxnosX/uGnaP9/uusnns/N7A7tG3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZLw+e
        ZSrYHFfR+/McYwPjM+8uRk4OCQETiXsvLrB0MXJxCAnsZJQ4sPI4G0iCV0BQ4sfke0AJDg5m
        AXmJI5eyQcLMAuoSk+YtYoaof8Ao8bTrIitEvZbEr+lNYDaLgKrE4uufwGw2oPj+FzfAZvIL
        KEpc/fGYEWSmqECERPeJSpA5IgJXmSR2NJxjhViQJLHsyGZGEFtYwEti8tk3UMv2MErcvDKB
        CSTBKWAlcXxlA9sERoFZSG6dhXDrLCS3LmBkXsUomVpQnJueW2xUYJSXWq5XnJhbXJqXrpec
        n7uJERgt2w5r9e9gfLwk/hCjAAejEg/vDs4ZUUKsiWXFlbmHGCU4mJVEeE9vnxYlxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnJc//1ikkEB6YklqdmpqQWoRTJaJg1OqgVFjvUxm2SVv9bBo+7j6
        k/vPf5wZPGdZssLcPUZxD/zqJLm9lN51ZUY//XrkZ/3EOU4Hly72UpOv+vPi9I030+OOyUZq
        XVRaodc/5Ssjn7Smioz8qf9ifEnrL2sKypeunLE+qHKS+OcPZbxxSQoysSsF/1xRT28xeiU0
        17Wq/oRg5aWjl5790VBiKc5INNRiLipOBADTGMylkgIAAA==
X-CMS-MailID: 20180302003907epcas2p2e6c0acb77c5304b4c5ed8d23d0bd5a1a
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180228150823epcas1p18ceabaf6cbfffbc9b54ed5e1458b7b80
X-RootMTR: 20180228150823epcas1p18ceabaf6cbfffbc9b54ed5e1458b7b80
References: <20180228150749.26831-1-hdegoede@redhat.com>
        <CGME20180228150823epcas1p18ceabaf6cbfffbc9b54ed5e1458b7b80@epcas1p1.samsung.com>
        <20180228150749.26831-13-hdegoede@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Basically, I have no objection. But I'll reply the my ack tag 
after finishing the review of 'devcon and usb_role_switch' from USB maintainer.

And I have a question.
Before this patch, extcon-axp288 is used to detect charger connector
and extcon-intel-int3496 is used to detect the USB_HOST connector
on one h/w device?

Best Regards,
Chanwoo Choi
Samsung Electronics

On 2018년 03월 01일 00:07, Hans de Goede wrote:
> The AXP288 BC1.2 charger detection / extcon code may seem like a strange
> place to add code to control the USB role-switch on devices with an AXP288,
> but there are 2 reasons to do this inside the axp288 extcon code:
> 
> 1) On many devices the USB role is controlled by ACPI AML code, but the AML
>    code only switches between the host and none roles, because of Windows
>    not really using device mode. To make device mode work we need to toggle
>    between the none/device roles based on Vbus presence, and the axp288
>    extcon gets interrupts on Vbus insertion / removal.
> 
> 2) In order for our BC1.2 charger detection to work properly the role
>    mux must be properly set to device mode before we do the detection.
> 
> Also note the Kconfig help-text / obsolete depends on USB_PHY which are
> remnants from older never upstreamed code also controlling the mux from
> the axp288 extcon code.
> 
> This commit also adds code to get notifications from the INT3496 extcon
> device, which is used on some devices to notify the kernel about id-pin
> changes instead of them being handled through AML code.
> 
> This fixes:
> -Device mode not working on most CHT devices with an AXP288
> -Host mode not working on devices with an INT3496 ACPI device
> -Charger-type misdetection (always SDP) on devices with an INT3496 when the
>  USB role (always) gets initialized as host
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v4:
> -Add Andy's Reviewed-by
> 
> Changes in v2:
> -Add depends on X86 to Kconfig (the AXP288 PMIC is only used on X86)
> -Use new acpi_dev_get_first_match_name() helper to get the INT3496 device-name
> -Add Heikki's Reviewed-by
> ---
>  drivers/extcon/Kconfig         |   3 +-
>  drivers/extcon/extcon-axp288.c | 177 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 171 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index a7bca4207f44..de15bf55895b 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -30,7 +30,8 @@ config EXTCON_ARIZONA
>  
>  config EXTCON_AXP288
>  	tristate "X-Power AXP288 EXTCON support"
> -	depends on MFD_AXP20X && USB_PHY
> +	depends on MFD_AXP20X && USB_SUPPORT && X86
> +	select USB_ROLE_SWITCH
>  	help
>  	  Say Y here to enable support for USB peripheral detection
>  	  and USB MUX switching by X-Power AXP288 PMIC.
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 3ec4c715e240..51e77c7a32c2 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -1,6 +1,7 @@
>  /*
>   * extcon-axp288.c - X-Power AXP288 PMIC extcon cable detection driver
>   *
> + * Copyright (c) 2017-2018 Hans de Goede <hdegoede@redhat.com>
>   * Copyright (C) 2015 Intel Corporation
>   * Author: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
>   *
> @@ -14,6 +15,8 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/acpi.h>
> +#include <linux/connection.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/io.h>
> @@ -25,6 +28,11 @@
>  #include <linux/extcon-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/axp20x.h>
> +#include <linux/usb/role.h>
> +#include <linux/workqueue.h>
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
>  
>  /* Power source status register */
>  #define PS_STAT_VBUS_TRIGGER		BIT(0)
> @@ -97,9 +105,19 @@ struct axp288_extcon_info {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct regmap_irq_chip_data *regmap_irqc;
> +	struct usb_role_switch *role_sw;
> +	struct work_struct role_work;
>  	int irq[EXTCON_IRQ_END];
>  	struct extcon_dev *edev;
> +	struct extcon_dev *id_extcon;
> +	struct notifier_block id_nb;
>  	unsigned int previous_cable;
> +	bool vbus_attach;
> +};
> +
> +static const struct x86_cpu_id cherry_trail_cpu_ids[] = {
> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_AIRMONT, X86_FEATURE_ANY },
> +	{}
>  };
>  
>  /* Power up/down reason string array */
> @@ -137,20 +155,74 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>  	regmap_write(info->regmap, AXP288_PS_BOOT_REASON_REG, clear_mask);
>  }
>  
> -static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
> +/*
> + * The below code to control the USB role-switch on devices with an AXP288
> + * may seem out of place, but there are 2 reasons why this is the best place
> + * to control the USB role-switch on such devices:
> + * 1) On many devices the USB role is controlled by AML code, but the AML code
> + *    only switches between the host and none roles, because of Windows not
> + *    really using device mode. To make device mode work we need to toggle
> + *    between the none/device roles based on Vbus presence, and this driver
> + *    gets interrupts on Vbus insertion / removal.
> + * 2) In order for our BC1.2 charger detection to work properly the role
> + *    mux must be properly set to device mode before we do the detection.
> + */
> +
> +/* Returns the id-pin value, note pulled low / false == host-mode */
> +static bool axp288_get_id_pin(struct axp288_extcon_info *info)
>  {
> -	int ret, stat, cfg, pwr_stat;
> -	u8 chrg_type;
> -	unsigned int cable = info->previous_cable;
> -	bool vbus_attach = false;
> +	enum usb_role role;
> +
> +	if (info->id_extcon)
> +		return extcon_get_state(info->id_extcon, EXTCON_USB_HOST) <= 0;
> +
> +	/* We cannot access the id-pin, see what mode the AML code has set */
> +	role = usb_role_switch_get_role(info->role_sw);
> +	return role != USB_ROLE_HOST;
> +}
> +
> +static void axp288_usb_role_work(struct work_struct *work)
> +{
> +	struct axp288_extcon_info *info =
> +		container_of(work, struct axp288_extcon_info, role_work);
> +	enum usb_role role;
> +	bool id_pin;
> +	int ret;
> +
> +	id_pin = axp288_get_id_pin(info);
> +	if (!id_pin)
> +		role = USB_ROLE_HOST;
> +	else if (info->vbus_attach)
> +		role = USB_ROLE_DEVICE;
> +	else
> +		role = USB_ROLE_NONE;
> +
> +	ret = usb_role_switch_set_role(info->role_sw, role);
> +	if (ret)
> +		dev_err(info->dev, "failed to set role: %d\n", ret);
> +}
> +
> +static bool axp288_get_vbus_attach(struct axp288_extcon_info *info)
> +{
> +	int ret, pwr_stat;
>  
>  	ret = regmap_read(info->regmap, AXP288_PS_STAT_REG, &pwr_stat);
>  	if (ret < 0) {
>  		dev_err(info->dev, "failed to read vbus status\n");
> -		return ret;
> +		return false;
>  	}
>  
> -	vbus_attach = (pwr_stat & PS_STAT_VBUS_VALID);
> +	return !!(pwr_stat & PS_STAT_VBUS_VALID);
> +}
> +
> +static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
> +{
> +	int ret, stat, cfg;
> +	u8 chrg_type;
> +	unsigned int cable = info->previous_cable;
> +	bool vbus_attach = false;
> +
> +	vbus_attach = axp288_get_vbus_attach(info);
>  	if (!vbus_attach)
>  		goto no_vbus;
>  
> @@ -201,6 +273,12 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>  		info->previous_cable = cable;
>  	}
>  
> +	if (info->role_sw && info->vbus_attach != vbus_attach) {
> +		info->vbus_attach = vbus_attach;
> +		/* Setting the role can take a while */
> +		queue_work(system_long_wq, &info->role_work);
> +	}
> +
>  	return 0;
>  
>  dev_det_ret:
> @@ -210,6 +288,18 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>  	return ret;
>  }
>  
> +static int axp288_extcon_id_evt(struct notifier_block *nb,
> +				unsigned long event, void *param)
> +{
> +	struct axp288_extcon_info *info =
> +		container_of(nb, struct axp288_extcon_info, id_nb);
> +
> +	/* We may not sleep and setting the role can take a while */
> +	queue_work(system_long_wq, &info->role_work);
> +
> +	return NOTIFY_OK;
> +}
> +
>  static irqreturn_t axp288_extcon_isr(int irq, void *data)
>  {
>  	struct axp288_extcon_info *info = data;
> @@ -231,10 +321,20 @@ static void axp288_extcon_enable(struct axp288_extcon_info *info)
>  					BC_GLOBAL_RUN, BC_GLOBAL_RUN);
>  }
>  
> +static void axp288_put_role_sw(void *data)
> +{
> +	struct axp288_extcon_info *info = data;
> +
> +	cancel_work_sync(&info->role_work);
> +	usb_role_switch_put(info->role_sw);
> +}
> +
>  static int axp288_extcon_probe(struct platform_device *pdev)
>  {
>  	struct axp288_extcon_info *info;
>  	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	const char *name;
>  	int ret, i, pirq;
>  
>  	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> @@ -245,9 +345,33 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  	info->regmap = axp20x->regmap;
>  	info->regmap_irqc = axp20x->regmap_irqc;
>  	info->previous_cable = EXTCON_NONE;
> +	INIT_WORK(&info->role_work, axp288_usb_role_work);
> +	info->id_nb.notifier_call = axp288_extcon_id_evt;
>  
>  	platform_set_drvdata(pdev, info);
>  
> +	info->role_sw = usb_role_switch_get(dev);
> +	if (IS_ERR(info->role_sw))
> +		return PTR_ERR(info->role_sw);
> +	if (info->role_sw) {
> +		ret = devm_add_action_or_reset(dev, axp288_put_role_sw, info);
> +		if (ret)
> +			return ret;
> +
> +		name = acpi_dev_get_first_match_name("INT3496", NULL, -1);
> +		if (name) {
> +			info->id_extcon = extcon_get_extcon_dev(name);
> +			if (!info->id_extcon)
> +				return -EPROBE_DEFER;
> +
> +			dev_info(dev, "controlling USB role\n");
> +		} else {
> +			dev_info(dev, "controlling USB role based on Vbus presence\n");
> +		}
> +	}
> +
> +	info->vbus_attach = axp288_get_vbus_attach(info);
> +
>  	axp288_extcon_log_rsi(info);
>  
>  	/* Initialize extcon device */
> @@ -289,6 +413,19 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (info->id_extcon) {
> +		ret = devm_extcon_register_notifier_all(dev, info->id_extcon,
> +							&info->id_nb);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Make sure the role-sw is set correctly before doing BC detection */
> +	if (info->role_sw) {
> +		queue_work(system_long_wq, &info->role_work);
> +		flush_work(&info->role_work);
> +	}
> +
>  	/* Start charger cable type detection */
>  	axp288_extcon_enable(info);
>  
> @@ -308,8 +445,32 @@ static struct platform_driver axp288_extcon_driver = {
>  		.name = "axp288_extcon",
>  	},
>  };
> -module_platform_driver(axp288_extcon_driver);
> +
> +static struct devcon axp288_extcon_role_sw_conn = {
> +	.endpoint[0] = "axp288_extcon",
> +	.endpoint[1] = "intel_xhci_usb_sw-role-switch",
> +	.id = "usb-role-switch",
> +};
> +
> +static int __init axp288_extcon_init(void)
> +{
> +	if (x86_match_cpu(cherry_trail_cpu_ids))
> +		add_device_connection(&axp288_extcon_role_sw_conn);
> +
> +	return platform_driver_register(&axp288_extcon_driver);
> +}
> +module_init(axp288_extcon_init);
> +
> +static void __exit axp288_extcon_exit(void)
> +{
> +	if (x86_match_cpu(cherry_trail_cpu_ids))
> +		remove_device_connection(&axp288_extcon_role_sw_conn);
> +
> +	platform_driver_unregister(&axp288_extcon_driver);
> +}
> +module_exit(axp288_extcon_exit);
>  
>  MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
>  MODULE_DESCRIPTION("X-Powers AXP288 extcon driver");
>  MODULE_LICENSE("GPL v2");
> 

