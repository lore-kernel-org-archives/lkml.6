Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5095FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C3A20866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fk78/3Wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C3A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeKLKOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:14:39 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:52822 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbeKLKOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:14:39 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181112002404epoutp03d2ce731afbd8d65bf5980a4234ff89a4~mOK6Y61kQ2889028890epoutp03i;
        Mon, 12 Nov 2018 00:24:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181112002404epoutp03d2ce731afbd8d65bf5980a4234ff89a4~mOK6Y61kQ2889028890epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541982245;
        bh=AYCvgoA9d0i5Aij4Ehtl3yejkwMGn2Di94odI+wUa+4=;
        h=Date:From:To:Subject:In-reply-to:References:From;
        b=fk78/3WmPJYkRBN0wviQr8o1cXeTZror9O2wjDmourv83M5x8ptgS/9zw2bnSosaU
         XG+1yJ/jrrvEEfGq9UDWbbEiUKhroxG3dDxwHCZDZgfQLgqggOCAPjSIRbNSk2hhfB
         Rvlrd0NuoWfE1vFfZ4OAapsOIAHNgfSO6HFst5Pk=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181112002402epcas1p3695f03b89f9fc3f5ee4d298d96cd44f0~mOK4JK7Bf0373903739epcas1p3K;
        Mon, 12 Nov 2018 00:24:02 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.66.04218.228C8EB5; Mon, 12 Nov 2018 09:24:02 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181112002402epcas2p2e68d2a9b6c5996677d1654dfed0a7ddf~mOK3p31dR1994119941epcas2p2l;
        Mon, 12 Nov 2018 00:24:02 +0000 (GMT)
X-AuditID: b6c32a47-be1ff7000000107a-bc-5be8c822c206
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.5B.03702.128C8EB5; Mon, 12 Nov 2018 09:24:01 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PI200HHZ141DH50@mmp1.samsung.com>; Mon, 12 Nov 2018 09:24:01 +0900 (KST)
Message-id: <5BE8C821.5080002@samsung.com>
Date:   Mon, 12 Nov 2018 09:24:01 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device
 is not found
In-reply-to: <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29m5KK2OM/XDbutgYCtrc80+I8vK6lRCRj+K/GEnPai5Gzub
        ZAVNJatRVoQGmplpsmakeUvzVsu0u9gFhcowxVYE3aSSsDrbKfLf8z7v8368z/O9FKasI8Kp
        TJONt5o4A0MEyptvL4yJYu56kzWV1eHoRN5ZGeopGCWRs0KD8itrCfShV6ScNa1y9PTGOQKV
        Vp2Uo68nugG6WH0YQ6MVD2XoRa6LQDXtXgyVjRdh6PgbNXrQZkMTnj5ZfBBb96YGZxtcarbe
        fYxgz9/bxnaVXSHZj53PCbb1u4NkCxvdgO0dvC5jv9bPTQrclbUyg+fSeKuKN6Wa0zJN6XHM
        lu0p61L0MRptlDYWLWdUJs7IxzEJiUlRGzINohlGlc0Z7CKVxAkCs3TVSqvZbuNVGWbBFsfw
        ljSDJdayROCMgt2UviTVbFyh1Wii9aJwd1ZGXn4TaXEz++50eYADnJ3tBAEUpJfBkqEm0gkC
        KSXdAuD48DdMKr4DWOmYIP6p+p7041KjDcALv1pwX0NBB8EfZ4bkTkBRGD0Pdj/J8tEYvRA2
        tdWSPqykXwH47DKQ5Gp461ixf1ROL4BjPfn+9wmR7/IO+vEMej58/mPErw+hd8LW8m/+7WbS
        Dhx+HijwDwfTu+Dj/na/KIDeCHuLL5HSom4SvhjZIeEE2O/N/csHw/e9jX/xLDjmvgZ8j0L6
        iGjZm49LxSkAP91vkEkqHRyrcMokO9Ph0duTpM8lpBXwaIFSkrDw3etCIKUyAGDzrXLyFJhd
        MiWYkv/BlEwJ5gLA3CCUtwjGdF6Ituimflk98F+remMLaH6c6AE0BZhpiki7N1mJc9lCjtED
        IIUxMxWTN0VKkcbl7Oet5hSr3cALHqAXgz2NhYekmsXbN9lStPponU6H9MtjdZpYJkwxPKss
        WUmnczY+i+ctvPXfnIwKCHeAWlfujgMDtQF7f0bmJWytQPjnFWUv9eO64bdXOw6VWox7Wtur
        VpcOnPwZFP87uPTA6XLn5q1WF24cNqx/1Bl2EI8YWTtZ2J3oXvO7OHRUP6QMkW9CETEfVdz8
        OWNEkfH1F/gqoiOeNx3qKFLnaOs6Fy9aW5N9sA4khw72KKvCXIxcyOC0aswqcH8Afrrnu8MD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t9jAV3FEy+iDRYst7bobZrOZHGs7Qm7
        RddCA4vmxevZLN4cBwp1rd7JYnF51xw2i9lL+lksPvceYbRYtKyV2eLJwjNMFrcbV7BZrN7z
        gtli7pepzBY9j7QsTu8usfh56DyTg6DHhkerWT02r9Dy2LSqk81j3slAj/1z17B7vN93lc1j
        5/cGdo++LasYPY7f2M7k8XmTXABXFJdNSmpOZllqkb5dAldGU/NW9oJVShVH9x9ibGCcLtPF
        yMkhIWAicf7SRdYuRi4OIYGdjBIfXr1mBknwCghK/Jh8j6WLkYODWUBe4silbJAws4C6xKR5
        i5gh6u8zSmxpvsoOUa8lcbBzGiuIzSKgKvHsWDMbiM0GFN//4gaYzS+gKHH1x2NGkJmiAhES
        3ScqQeaICDSxSpx89ZYRpEZYIEri15SpTBALrjNKrPoxjwkkwSngLnF82lL2CYz8s5DcNwvh
        vllI7lvAyLyKUTK1oDg3PbfYqMAoL7Vcrzgxt7g0L10vOT93EyMwwrYd1urfwfh4SfwhRgEO
        RiUe3obyF9FCrIllxZW5hxglOJiVRHj/HgAK8aYkVlalFuXHF5XmpBYfYpTmYFES5+XPPxYp
        JJCeWJKanZpakFoEk2Xi4JRqYMzv9XG42NpypPiQJeubKJYd/JGPAj6mZ1rUdlUGzzl/hWve
        VvPJmzdfis3mfdEwUXmezjWTr4Z5lr++SaWzerxcMG0Vk8Mf1X7ZA2l/M+uP9krHP+eeGx3y
        1nevCIedqpH4I96fL5a1vJ+44JqsbWPoxibnFdEen7Tb9xRteBLYVL98E4eRjxJLcUaioRZz
        UXEiACmlBq2sAgAA
X-CMS-MailID: 20181112002402epcas2p2e68d2a9b6c5996677d1654dfed0a7ddf
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
        <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
        <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2018년 11월 11일 03:10, Andy Shevchenko wrote:
> All current users of extcon_get_extcon_dev() API considers
> an extcon device a mandatory to appear. Thus, they all convert
> NULL pointer to -EPROBE_DEFER error code.
> 
> There is one more caller anticipated with the same requirements.
> 
> To decrease a code duplication and a burden to the callers,
> return -EPROBE_DEFER directly from extcon_get_extcon_dev().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon-axp288.c        | 4 ++--
>  drivers/extcon/extcon.c               | 2 +-
>  drivers/power/supply/axp288_charger.c | 8 ++++----
>  drivers/usb/phy/phy-omap-otg.c        | 6 +++---
>  drivers/usb/typec/tcpm/fusb302.c      | 4 ++--
>  5 files changed, 12 insertions(+), 12 deletions(-)

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi

> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index a983708b77a6..3472d3b756ed 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -360,8 +360,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  		name = acpi_dev_get_first_match_name("INT3496", NULL, -1);
>  		if (name) {
>  			info->id_extcon = extcon_get_extcon_dev(name);
> -			if (!info->id_extcon)
> -				return -EPROBE_DEFER;
> +			if (IS_ERR(info->id_extcon))
> +				return PTR_ERR(info->id_extcon);
>  
>  			dev_info(dev, "controlling USB role\n");
>  		} else {
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 5ab0498be652..2bd0f2f33f05 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -884,7 +884,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  		if (!strcmp(sd->name, extcon_name))
>  			goto out;
>  	}
> -	sd = NULL;
> +	sd = ERR_PTR(-EPROBE_DEFER);
>  out:
>  	mutex_unlock(&extcon_dev_list_lock);
>  	return sd;
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index 735658ee1c60..8558577fccf5 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -768,17 +768,17 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	info->regmap_irqc = axp20x->regmap_irqc;
>  
>  	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
> -	if (info->cable.edev == NULL) {
> +	if (IS_ERR(info->cable.edev)) {
>  		dev_dbg(&pdev->dev, "%s is not ready, probe deferred\n",
>  			AXP288_EXTCON_DEV_NAME);
> -		return -EPROBE_DEFER;
> +		return PTR_ERR(info->cable.edev);
>  	}
>  
>  	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
>  		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
> -		if (info->otg.cable == NULL) {
> +		if (IS_ERR(info->otg.cable)) {
>  			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> -			return -EPROBE_DEFER;
> +			return PTR_ERR(info->otg.cable);
>  		}
>  		dev_info(&pdev->dev,
>  			 "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
> index ee0863c6553e..605314ddcd3d 100644
> --- a/drivers/usb/phy/phy-omap-otg.c
> +++ b/drivers/usb/phy/phy-omap-otg.c
> @@ -91,12 +91,12 @@ static int omap_otg_probe(struct platform_device *pdev)
>  	int ret;
>  	u32 rev;
>  
> -	if (!config || !config->extcon)
> +	if (!config)
>  		return -ENODEV;
>  
>  	extcon = extcon_get_extcon_dev(config->extcon);
> -	if (!extcon)
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(extcon))
> +		return PTR_ERR(extcon);
>  
>  	otg_dev = devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
>  	if (!otg_dev)
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 43b64d9309d0..6d332066202b 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1767,8 +1767,8 @@ static int fusb302_probe(struct i2c_client *client,
>  	 */
>  	if (device_property_read_string(dev, "fcs,extcon-name", &name) == 0) {
>  		chip->extcon = extcon_get_extcon_dev(name);
> -		if (!chip->extcon)
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(chip->extcon))
> +			return PTR_ERR(chip->extcon);
>  	}
>  
>  	chip->vbus = devm_regulator_get(chip->dev, "vbus");
> 

