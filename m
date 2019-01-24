Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F81C282C2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB9F217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gaiP6cwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfAXCDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:03:39 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:39156 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfAXCDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:03:37 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190124020334epoutp01c7e7daf068670040b2b4eb2fe0587de4~8pnnvzFoN1786017860epoutp01E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:03:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190124020334epoutp01c7e7daf068670040b2b4eb2fe0587de4~8pnnvzFoN1786017860epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548295414;
        bh=10oyO78+qRMAxUwAnIOBFa9VdFEK1yybQwwlzXWH7/Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gaiP6cwdGFB3aRHGRgBDkuOvWjbDLIwunvHEYiVQsz4B68wZxF7waFBAH36wUTEuW
         g6ZgRCHVawfTbUMs+nndCj9o5aLiyTyfgJlOklMocqseWEGzGFSXO5mv9PBIWlgAPI
         fqBTGZundIluHPwsGv9mNjRVJogan3+I/nAKL7R8=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190124020329epcas1p207b3072d8eae07cb820166ccde7516c7~8pnjaBxPQ2130621306epcas1p2Q;
        Thu, 24 Jan 2019 02:03:29 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.8C.04288.9EC194C5; Thu, 24 Jan 2019 11:03:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190124020320epcas1p123f83c614b32fe8db50579457c547c0f~8pna__uoT0260002600epcas1p1K;
        Thu, 24 Jan 2019 02:03:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190124020320epsmtrp2f0d833897d7483fabe49ca6fd2f06270~8pna9sWRo1060810608epsmtrp2L;
        Thu, 24 Jan 2019 02:03:20 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-6a-5c491ce96b15
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.65.03971.8EC194C5; Thu, 24 Jan 2019 11:03:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190124020320epsmtip1b1a31eb5dd893ff7f60d3876bb79e39a~8pnawkM2R2930929309epsmtip1p;
        Thu, 24 Jan 2019 02:03:20 +0000 (GMT)
Subject: Re: [PATCH V2] drivers: extcon: Add support for ptn5150
To:     Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <075f45f2-527a-e659-f26d-66f9dc24bb53@samsung.com>
Date:   Thu, 24 Jan 2019 11:03:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548247616-6709-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTX/eljGeMQd8yXovLu+awWdxuXMFm
        8XL/dFYHZo+ds+6ye/RtWcXo8XmTXABzVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtAiJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        ZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xqneN8wFndUVV05sZ2lgXJjUxcjJISFgIvHu5HbW
        LkYuDiGBHYwS/RP2QDmfGCV6b1xhBakSEvjGKHFuZRZMx/0r39khivYySrQ09TNCOO8ZJW6e
        mMHWxcjBISzgILFskwtIgwhQw7qW48wgYWYBK4mNS41BwmwCWhL7X9xgA7H5BRQlrv54zAhi
        8wrYSZxc3A1mswioStz7OpkFxBYViJDouL+aDaJGUOLkzCdgcU6BAIl1H/czgdjMAuISt57M
        h7LlJZq3zmYGOU1C4ACbxLa2bUwQD7hIfDz6mRXCFpZ4dXwLO4QtJfH53V42CLtaYuXJI2wQ
        zR2MElv2X4BqMJbYv3QyE8QzmhLrd+lDLOOTePe1hxUkLCHAK9HRJgRRrSxx+cFdqLWSEovb
        O6HGe0gc3H6ffQKj4iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBCXJcb2IEJ0Etix2M
        e875HGIU4GBU4uHlKPSIEWJNLCuuzD3EKMHBrCTC63rRLUaINyWxsiq1KD++qDQntfgQoykw
        tCcyS4km5wMTdF5JvKGpkbGxsYWJoZmpoaGSOO96B+cYIYH0xJLU7NTUgtQimD4mDk6pBsYd
        P/Mt3T74T577yDUzyZ95Yeix6KrJbvs/aFY2BevtYzxVLlfpKXl2m9Cc2at33T3xRPv2A87o
        7/lfdvVFGEk4/TPaoG/1aO3W/rXGD1J/XmN/+szp3HuziesSnHIrrXq6c09k5BXNLLtnbn/i
        c4ttebrmP++uTJWmR7UVM8O2sUi8veNi6K7EUpyRaKjFXFScCADro1QhmAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnO4LGc8Yg7mLtC0u75rDZnG7cQWb
        xcv901kdmD12zrrL7tG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZp3rfMBd0VldcObGdpYFx
        YVIXIyeHhICJxP0r39m7GLk4hAR2M0r8XLuQESIhKTHt4lHmLkYOIFtY4vDhYpCwkMBboJr7
        WSBhYQEHiWWbXEDCIkBj1rUcB6tmFrCS2LjUGGLiUUaJBes3s4LUsAloSex/cYMNxOYXUJS4
        +uMx2CZeATuJk4u7wWwWAVWJe18ns4DYogIREmdfroOqEZQ4OfMJWJxTIEBi3cf9TCA2s4C6
        xJ95l5ghbHGJW0/mQ8XlJZq3zmaewCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56brFhgWFe
        arlecWJucWleul5yfu4mRnA0aGnuYLy8JP4QowAHoxIPL0ehR4wQa2JZcWXuIUYJDmYlEV7X
        i24xQrwpiZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTDmXjdK
        qd8aw3IseKeU5BTD282Va6dES0tETby+rb7W/bHFelcJxjU2FruljF78M//XduTVBv3UR/nz
        hSazKNo6Fd6yaagSelVtM+N+lHx4l7iNxN0S7dVL1ppf3lP/f1LHN//+LqbHcaelOto28By8
        E2LfLGR65W3QXXf2F73nrG6xKMy9/UOJpTgj0VCLuag4EQAHelzeggIAAA==
X-CMS-MailID: 20190124020320epcas1p123f83c614b32fe8db50579457c547c0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190123124907epcas3p40b24da2d1633e1323fbf335b602fd7b5
References: <20190122075548.GA30388@chikyu>
        <CGME20190123124907epcas3p40b24da2d1633e1323fbf335b602fd7b5@epcas3p4.samsung.com>
        <1548247616-6709-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijai,

Looks good to me. But, there are minor modification by myself as following:
After fixed them, applied it to extcon-next. Thanks.

- PTN5150A -> PTN5150 because this patch usually used the 'ptn5150' word without 'A'.
- Modify the patch subject to keep the same format of extcon drivers
	- before : drivers: extcon: Add support for ptn5150
	- after  : extcon: Add support for ptn5150 extcon driver
- Remove the space in extcon-ptn5150.txt and then use tab for indentation
- Limit the under 80 char on one line


[Modified version]
    extcon: Add support for ptn5150 extcon driver

    PTN5150 is a small thin low power CC (Configurationn Channel)
    Logic chip supporting the USB Type-C connector application with
    CC control logic detection and indication functions.

    Signed-off-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>


Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt

+* PTN5150 CC (Configuration Channel) Logic device
+
+PTN5150 is a small thin low power CC logic chip supporting the USB Type-C
+connector application with CC control logic detection and indication functions.
+It is interfaced to the host controller using an I2C interface.
+
+Required properties:
+- compatible: should be "nxp,ptn5150"
+- reg: specifies the I2C slave address of the device
+- int-gpio: should contain a phandle and GPIO specifier for the GPIO pin
+       connected to the PTN5150's INTB pin.
+- vbus-gpio: should contain a phandle and GPIO specifier for the GPIO pin which
+       is used to control VBUS.
+- pinctrl-names : a pinctrl state named "default" must be defined.
+- pinctrl-0 : phandle referencing pin configuration of interrupt and vbus
+       control.
+

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

On 19. 1. 23. 오후 9:46, Vijai Kumar K wrote:
> PTN5150A is a small thin low power CC Logic chip supporting
> the USB Type-C connector application with Configurationn Channel(CC)
> control logic detection and indication functions.
> 
> Add driver, Kconfig and Makefile entries.
> 
> Signed-off-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> ---
> Hi Chanwoo,
> 
> I have implemented the review comments and below is the updated patchset.
> Can you please review it?
> 
> Highlights:
>  - extcon.h -> extcon-provider.h
>  - Remove dummy implementations for .remove, _suspend/_resume
>  - Change license format to SPDX
>  - remove extcon-ptn5150.h and collapse definitions to extcon-ptn5150.c
>  - Replace tabs with spaces
>  - Update Documentation
>  - Fix coding style issues 
> 
> Thanks
> Vijai Kumar K
> 
>  .../devicetree/bindings/extcon/extcon-ptn5150.txt  |  27 ++
>  drivers/extcon/Kconfig                             |   8 +
>  drivers/extcon/Makefile                            |   1 +
>  drivers/extcon/extcon-ptn5150.c                    | 335 +++++++++++++++++++++
>  4 files changed, 371 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
>  create mode 100644 drivers/extcon/extcon-ptn5150.c
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
> new file mode 100644
> index 0000000..e772d42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
> @@ -0,0 +1,27 @@
> +
> +* PTN5150 CC (Configuration Channel) Logic device
> +PTN5150A is a small thin low power CC logic chip supporting the USB Type-C
> +connector application with Configuration Channel (CC) control logic detection and
> +indication functions. It is interfaced to the host controller using an I2C interface.
> +
> +Required properties:
> +- compatible: Should be "nxp,ptn5150"
> +- reg: Specifies the I2C slave address of the device
> +- int-gpio: should contain a phandle and GPIO specifier for the GPIO pin
> +	    connected to the PTN5150's INTB pin.
> +- vbus-gpio: should contain a phandle and GPIO specifier for the GPIO pin which
> +	     is used to control VBUS.
> +- pinctrl-names : a pinctrl state named "default" must be defined.
> +- pinctrl-0 : phandle referencing pin configuration of interrupt and vbus control.
> +
> +Example:
> +
> +	ptn5150@1d  {
> +		compatible = "nxp,ptn5150";
> +		reg = <0x1d>;
> +		int-gpio = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
> +		vbus-gpio = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ptn5150_default>;
> +		status = "okay";
> +	};
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index de15bf5..405cd76 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -114,6 +114,14 @@ config EXTCON_PALMAS
>  	  Say Y here to enable support for USB peripheral and USB host
>  	  detection by palmas usb.
>  
> +config EXTCON_PTN5150
> +	tristate "PTN5150 CC (Configuration Channel) LOGIC USB EXTCON support"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to enable support for USB peripheral and USB host
> +	  detection by ptn5150 CC (Configuration Channel) logic chip.
> +
>  config EXTCON_QCOM_SPMI_MISC
>  	tristate "Qualcomm USB extcon support"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> index 0888fde..261ce4c 100644
> --- a/drivers/extcon/Makefile
> +++ b/drivers/extcon/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
>  obj-$(CONFIG_EXTCON_MAX77843)	+= extcon-max77843.o
>  obj-$(CONFIG_EXTCON_MAX8997)	+= extcon-max8997.o
>  obj-$(CONFIG_EXTCON_PALMAS)	+= extcon-palmas.o
> +obj-$(CONFIG_EXTCON_PTN5150)	+= extcon-ptn5150.o
>  obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o
>  obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
>  obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> new file mode 100644
> index 0000000..155620b
> --- /dev/null
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// extcon-ptn5150.c - PTN5150 CC logic extcon driver to support USB detection
> +//
> +// Based on extcon-sm5502.c driver
> +// Copyright (c) 2018-2019 by Vijai Kumar K
> +// Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/extcon-provider.h>
> +#include <linux/gpio.h>
> +
> +/* PTN5150 registers */
> +enum ptn5150_reg {
> +	PTN5150_REG_DEVICE_ID = 0x01,
> +	PTN5150_REG_CONTROL,
> +	PTN5150_REG_INT_STATUS,
> +	PTN5150_REG_CC_STATUS,
> +	PTN5150_REG_CON_DET = 0x09,
> +	PTN5150_REG_VCONN_STATUS,
> +	PTN5150_REG_RESET,
> +	PTN5150_REG_INT_MASK = 0x18,
> +	PTN5150_REG_INT_REG_STATUS,
> +	PTN5150_REG_END,
> +};
> +
> +#define PTN5150_DFP_ATTACHED			0x1
> +#define PTN5150_UFP_ATTACHED			0x2
> +
> +/* Define PTN5150 MASK/SHIFT constant */
> +#define PTN5150_REG_DEVICE_ID_VENDOR_SHIFT	0
> +#define PTN5150_REG_DEVICE_ID_VENDOR_MASK	\
> +	(0x3 << PTN5150_REG_DEVICE_ID_VENDOR_SHIFT)
> +
> +#define PTN5150_REG_DEVICE_ID_VERSION_SHIFT	3
> +#define PTN5150_REG_DEVICE_ID_VERSION_MASK	\
> +	(0x1f << PTN5150_REG_DEVICE_ID_VERSION_SHIFT)
> +
> +#define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
> +#define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
> +	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
> +
> +#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
> +#define PTN5150_REG_CC_VBUS_DETECTION_MASK	\
> +	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
> +
> +#define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
> +#define PTN5150_REG_INT_CABLE_ATTACH_MASK	\
> +	(0x1 << PTN5150_REG_INT_CABLE_ATTACH_SHIFT)
> +
> +#define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
> +#define PTN5150_REG_INT_CABLE_DETACH_MASK	\
> +	(0x1 << PTN5150_REG_CC_CABLE_DETACH_SHIFT)
> +
> +struct ptn5150_info {
> +	struct device *dev;
> +	struct extcon_dev *edev;
> +	struct i2c_client *i2c;
> +	struct regmap *regmap;
> +	struct gpio_desc *int_gpiod;
> +	struct gpio_desc *vbus_gpiod;
> +	int irq;
> +	struct work_struct irq_work;
> +	struct mutex mutex;
> +};
> +
> +/* List of detectable cables */
> +static const unsigned int ptn5150_extcon_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
> +	EXTCON_NONE,
> +};
> +
> +static const struct regmap_config ptn5150_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= PTN5150_REG_END,
> +};
> +
> +static void ptn5150_irq_work(struct work_struct *work)
> +{
> +	struct ptn5150_info *info = container_of(work,
> +			struct ptn5150_info, irq_work);
> +	int ret = 0;
> +	unsigned int reg_data;
> +	unsigned int int_status;
> +
> +	if (!info->edev)
> +		return;
> +
> +	mutex_lock(&info->mutex);
> +
> +	ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
> +	if (ret) {
> +		dev_err(info->dev, "failed to read CC STATUS %d\n", ret);
> +		mutex_unlock(&info->mutex);
> +		return;
> +	}
> +
> +	/* Clear interrupt. Read would clear the register */
> +	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &int_status);
> +	if (ret) {
> +		dev_err(info->dev, "failed to read INT STATUS %d\n", ret);
> +		mutex_unlock(&info->mutex);
> +		return;
> +	}
> +
> +	if (int_status) {
> +		unsigned int cable_attach;
> +
> +		cable_attach = int_status & PTN5150_REG_INT_CABLE_ATTACH_MASK;
> +		if (cable_attach) {
> +			unsigned int port_status;
> +			unsigned int vbus;
> +
> +			port_status = ((reg_data &
> +					PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
> +					PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
> +
> +			switch (port_status) {
> +			case PTN5150_DFP_ATTACHED:
> +				extcon_set_state_sync(info->edev,
> +						EXTCON_USB_HOST, false);
> +				gpiod_set_value(info->vbus_gpiod, 0);
> +				extcon_set_state_sync(info->edev, EXTCON_USB,
> +						true);
> +				break;
> +			case PTN5150_UFP_ATTACHED:
> +				extcon_set_state_sync(info->edev, EXTCON_USB,
> +						false);
> +				vbus = ((reg_data &
> +					PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
> +					PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
> +				if (vbus)
> +					gpiod_set_value(info->vbus_gpiod, 0);
> +				else
> +					gpiod_set_value(info->vbus_gpiod, 1);
> +
> +				extcon_set_state_sync(info->edev,
> +						EXTCON_USB_HOST, true);
> +				break;
> +			default:
> +				dev_err(info->dev,
> +					"Unknown Port status : %x\n",
> +					port_status);
> +				break;
> +			}
> +		} else {
> +			extcon_set_state_sync(info->edev,
> +					EXTCON_USB_HOST, false);
> +			extcon_set_state_sync(info->edev,
> +					EXTCON_USB, false);
> +			gpiod_set_value(info->vbus_gpiod, 0);
> +		}
> +	}
> +
> +	/* Clear interrupt. Read would clear the register */
> +	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS,
> +			&int_status);
> +	if (ret) {
> +		dev_err(info->dev,
> +			"failed to read INT REG STATUS %d\n", ret);
> +		mutex_unlock(&info->mutex);
> +		return;
> +	}
> +
> +	mutex_unlock(&info->mutex);
> +}
> +
> +
> +static irqreturn_t ptn5150_irq_handler(int irq, void *data)
> +{
> +	struct ptn5150_info *info = data;
> +
> +	schedule_work(&info->irq_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ptn5150_init_dev_type(struct ptn5150_info *info)
> +{
> +	unsigned int reg_data, vendor_id, version_id;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, PTN5150_REG_DEVICE_ID, &reg_data);
> +	if (ret) {
> +		dev_err(info->dev, "failed to read DEVICE_ID %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	vendor_id = ((reg_data & PTN5150_REG_DEVICE_ID_VENDOR_MASK) >>
> +				PTN5150_REG_DEVICE_ID_VENDOR_SHIFT);
> +	version_id = ((reg_data & PTN5150_REG_DEVICE_ID_VERSION_MASK) >>
> +				PTN5150_REG_DEVICE_ID_VERSION_SHIFT);
> +
> +	dev_info(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
> +			    version_id, vendor_id);
> +
> +	/* Clear any existing interrupts */
> +	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &reg_data);
> +	if (ret) {
> +		dev_err(info->dev,
> +			"failed to read PTN5150_REG_INT_STATUS %d\n",
> +			ret);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS, &reg_data);
> +	if (ret) {
> +		dev_err(info->dev,
> +			"failed to read PTN5150_REG_INT_REG_STATUS %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ptn5150_i2c_probe(struct i2c_client *i2c,
> +				 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct device_node *np = i2c->dev.of_node;
> +	struct ptn5150_info *info;
> +	int ret;
> +
> +	if (!np)
> +		return -EINVAL;
> +
> +	info = devm_kzalloc(&i2c->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +	i2c_set_clientdata(i2c, info);
> +
> +	info->dev = &i2c->dev;
> +	info->i2c = i2c;
> +	info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
> +	if (!info->int_gpiod) {
> +		dev_err(dev, "failed to get INT GPIO\n");
> +		return -EINVAL;
> +	}
> +	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
> +	if (!info->vbus_gpiod) {
> +		dev_err(dev, "failed to get VBUS GPIO\n");
> +		return -EINVAL;
> +	}
> +	ret = gpiod_direction_output(info->vbus_gpiod, 0);
> +	if (ret) {
> +		dev_err(dev, "failed to set VBUS GPIO direction\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_init(&info->mutex);
> +
> +	INIT_WORK(&info->irq_work, ptn5150_irq_work);
> +
> +	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
> +	if (IS_ERR(info->regmap)) {
> +		ret = PTR_ERR(info->regmap);
> +		dev_err(info->dev, "failed to allocate register map: %d\n",
> +				   ret);
> +		return ret;
> +	}
> +
> +	if (info->int_gpiod) {
> +		info->irq = gpiod_to_irq(info->int_gpiod);
> +		if (info->irq < 0) {
> +			dev_err(dev, "failed to get INTB IRQ\n");
> +			return info->irq;
> +		}
> +
> +		ret = devm_request_threaded_irq(dev, info->irq, NULL,
> +						ptn5150_irq_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						i2c->name, info);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to request handler for INTB IRQ\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Allocate extcon device */
> +	info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
> +	if (IS_ERR(info->edev)) {
> +		dev_err(info->dev, "failed to allocate memory for extcon\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Register extcon device */
> +	ret = devm_extcon_dev_register(info->dev, info->edev);
> +	if (ret) {
> +		dev_err(info->dev, "failed to register extcon device\n");
> +		return ret;
> +	}
> +
> +	/* Initialize PTN5150 device and print vendor id and version id */
> +	ret = ptn5150_init_dev_type(info);
> +	if (ret)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ptn5150_dt_match[] = {
> +	{ .compatible = "nxp,ptn5150" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ptn5150_dt_match);
> +
> +static const struct i2c_device_id ptn5150_i2c_id[] = {
> +	{ "ptn5150", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ptn5150_i2c_id);
> +
> +static struct i2c_driver ptn5150_i2c_driver = {
> +	.driver		= {
> +		.name	= "ptn5150",
> +		.of_match_table = ptn5150_dt_match,
> +	},
> +	.probe	= ptn5150_i2c_probe,
> +	.id_table = ptn5150_i2c_id,
> +};
> +
> +static int __init ptn5150_i2c_init(void)
> +{
> +	return i2c_add_driver(&ptn5150_i2c_driver);
> +}
> +subsys_initcall(ptn5150_i2c_init);
> 


