Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534E0C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A40206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tqgw/ve3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A40206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeKUAMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:12:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39349 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbeKUAMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:12:51 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181120134336euoutp0216b51c963cef52e1dea5e54963546c99~o2PRM_fzu0170001700euoutp02_
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 13:43:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181120134336euoutp0216b51c963cef52e1dea5e54963546c99~o2PRM_fzu0170001700euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542721416;
        bh=+mfFu0bs0CraK4PPP//RQD6+IHITJ+E9umpNAcCFgPY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Tqgw/ve3x9Sv126BVhaAbUrgffabl7s8wEFUGxy3MqS7S1OnoJ+fixTC0QeZvXHCY
         RwQXSIut+i0Flnc8QlFbprvTyxxXpzA487ukoBPt9+jowD7Ez8MaZPdEcI2Q0RJ3Uf
         3BY6EIPqW29LcRBoEzFPHE+/M6iRxw5ScATar7BQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181120134335eucas1p24c215e9da768061e4917fa69e795e2c3~o2PQVIEa-1031010310eucas1p2P;
        Tue, 20 Nov 2018 13:43:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 13.7C.04806.68F04FB5; Tue, 20
        Nov 2018 13:43:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137~o2PPAZGzR1898418984eucas1p2V;
        Tue, 20 Nov 2018 13:43:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181120134333eusmtrp11992d67bae425cf9f61ffe484eea2376~o2POx74os2449524495eusmtrp1s;
        Tue, 20 Nov 2018 13:43:33 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-e5-5bf40f86b4a8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 78.C8.04284.58F04FB5; Tue, 20
        Nov 2018 13:43:33 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181120134333eusmtip246e4ae01df7f5ec36a09b3c70ccd9e95~o2POVpmJR0771907719eusmtip2E;
        Tue, 20 Nov 2018 13:43:33 +0000 (GMT)
Subject: Re: Applied
 "regulator: wm8994: Pass descriptor instead of GPIO number" to the regulator
 tree
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <66d3b74c-0152-b17b-89d4-a21d33445b25@samsung.com>
Date:   Tue, 20 Nov 2018 14:43:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20180517164120.485F844007E@finisterre.ee.mobilebroadband>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGfXfOzjlaJ183zQe1skFRkV8ZNLAso2g/Qksiowm19DA1v9jU
        Un8kaGqiFmp+rIFBmmGhJSpmqTlxMwTxO7+t8E+JmW1a4bQ8Hi3/3ff13A/3+8DLEJJqsQsT
        GZvAaWJV0TLKjmw0/u7xyLS3KL0/dHnKH36aoeSDd+uQfHqxE8mXBrNF8iJrlUg+0Kyn5Ob5
        NvEpWvFaN0kr6qrvUYqJ4beUokT/BynMdbsviK/aHQ/noiOTOI2X/3W7iO+tq6L46fO3838N
        0mlo6mQOsmUAH4XKz+N0DrJjJPgZgsZ0IyEYC4LK0uINY0awlD4s3lx5kv9ULAyqEFi/lVOC
        mUfQv7JA8ikpjoKhlWGK1444CF5aShAfInAzgrG2ApofUNgHcuZy1kIMw2J/mM9HPCbxPjB3
        ZZA8dsKh8GIwiMcsdoD3ZTPr2Bafg+emUB4TeA+kNzwiBO0MYzPlIr4JcCMNWaZpSnj0Gei5
        byAELYWvpnpa0G7QXZhLCgvpCLJKdbRgchE06Js2tv2gw9Qn5psJfBBqm70EHADG0Yl1DHgH
        jMw5CI/YAQWNJYSAWcjOlAjp/aAz1fyrbe/tJx4gmW7LZbot5+i2nKP73/sYkdXImUvUxqg5
        rW8sd8tTq4rRJsaqPcPiYurQ2g/qXjUtNqFW6w0DwgySbWfxMbNSIlYlaZNjDAgYQubIzinX
        EBuuSk7hNHHXNInRnNaAXBlS5sym2nxUSrBalcDd5Lh4TrM5FTG2LmkozLPd/nBb/VmP6PGq
        4qEM95runUWjIj+stqVV9lKbbFbqFXzFeyoEfSm6aBqbXba4t72pmGyRtQcuO7ntDfjpWjFe
        diLudF9/MP2jtndCmUnn5b0z6uWXQ44UDowtNTVYyc68A6GFHWVNqdta7kSNzHrsekVGLQTG
        N69e8mVTZKQ2QuVziNBoVX8B2B/Iuz0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7qt/F+iDSb3ylhMffiEzeJK6yZG
        i/tfjzJafLvSwWQx5c9yJovLu+awWXx+v5/Vgd1j56y77B6bVnWyedy5tofNY/qc/4wenzfJ
        BbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GV8
        2PePqeC+T0XfjyvsDYz37LsYOTkkBEwkFvctY+1i5OIQEljKKHHg0XwmiISMxMlpDawQtrDE
        n2tdbBBFbxklWp/cByri4BAWyJBYt70WpEZEwFfiwbxmFpAaZoFdjBLPVm8HGyQk4CZx+FcH
        C4jNJmAo0fUWZBAHB6+AncT7PkaQMIuAqsTnEy1gJaICMRLdX/+B7eUVEJQ4OfMJC0g5p4C7
        xOrjMSBhZgF1iT/zLjFD2PISzVtnQ9niEreezGeawCg0C0n3LCQts5C0zELSsoCRZRWjSGpp
        cW56brGhXnFibnFpXrpecn7uJkZgxG079nPzDsZLG4MPMQpwMCrx8AqYf44WYk0sK67MPcQo
        wcGsJML7NhooxJuSWFmVWpQfX1Sak1p8iNEU6LeJzFKiyfnAZJBXEm9oamhuYWlobmxubGah
        JM573qAySkggPbEkNTs1tSC1CKaPiYNTqoHRb/e62rDdy43jC/8tsvm0l01X+q+DoBp74UqR
        B3/PJbq1++6dunMv24d/KXfFOB++P3hZeeapK8mLoxRz3Vva1vSGMPw4tX2RzN6junue9Xs+
        kE2N/8Xscu5YxXLhO6c5ogzlE49+yi4/8vqf175np1d8yKxL0woKmXHjWZrw+9XHy4M0NeUn
        K7EUZyQaajEXFScCAEYEWMXOAgAA
X-CMS-MailID: 20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137
References: <20180517164120.485F844007E@finisterre.ee.mobilebroadband>
        <CGME20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2018-05-17 18:41, Mark Brown wrote:
> The patch
>
>    regulator: wm8994: Pass descriptor instead of GPIO number
>
> has been applied to the regulator tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> >From 3c6b38d45fa51c7c51c5e2347fc1a6bef6a46525 Mon Sep 17 00:00:00 2001
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Mon, 14 May 2018 10:06:34 +0200
> Subject: [PATCH] regulator: wm8994: Pass descriptor instead of GPIO number
>
> Instead of passing a global GPIO number for the enable GPIO, pass
> a descriptor looked up from the device tree node or the board file
> decriptor table for the regulator.
>
> There is a single board file passing the GPIOs for LDO1 and LDO2
> through platform data, so augment this to pass descriptors
> associated with the i2c device as well.
>
> The special GPIO enable DT property for the enable GPIO is
> nonstandard but this was accomodated in
> commit 6a537d48461deacc57c07ed86d9915e5aa4b3539
> "gpio: of: Support regulator nonstandard GPIO properties".
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>


This patch causes following kernel warning on Samsung Exynos4412 based
Trats2 board:

wm8994 4-001a: Failed to get supply 'DBVDD1': -517
wm8994 4-001a: Failed to get supplies: -517
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:2421
release_nodes+0x178/0x1fc
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.20.0-rc3-next-20181120-00009-g6917effde9ad #1085
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c01125fc>] (unwind_backtrace) from [<c010e140>] (show_stack+0x10/0x14)
[<c010e140>] (show_stack) from [<c0a4aee0>] (dump_stack+0x98/0xc4)
[<c0a4aee0>] (dump_stack) from [<c0127078>] (__warn+0x10c/0x124)
[<c0127078>] (__warn) from [<c01271a4>] (warn_slowpath_null+0x40/0x48)
[<c01271a4>] (warn_slowpath_null) from [<c0583700>]
(release_nodes+0x178/0x1fc)
[<c0583700>] (release_nodes) from [<c057ed8c>] (really_probe+0xe8/0x400)
[<c057ed8c>] (really_probe) from [<c057f260>]
(driver_probe_device+0x78/0x1b8)
[<c057f260>] (driver_probe_device) from [<c057f4c8>]
(__driver_attach+0x128/0x144)
[<c057f4c8>] (__driver_attach) from [<c057cdd8>]
(bus_for_each_dev+0x68/0xb4)
[<c057cdd8>] (bus_for_each_dev) from [<c057e0d8>]
(bus_add_driver+0x1a8/0x268)
[<c057e0d8>] (bus_add_driver) from [<c0580504>] (driver_register+0x78/0x10c)
[<c0580504>] (driver_register) from [<c06d0540>]
(i2c_register_driver+0x3c/0xa8)
[<c06d0540>] (i2c_register_driver) from [<c0103154>]
(do_one_initcall+0x8c/0x410)
[<c0103154>] (do_one_initcall) from [<c0f0124c>]
(kernel_init_freeable+0x3c8/0x4d0)
[<c0f0124c>] (kernel_init_freeable) from [<c0a64df4>]
(kernel_init+0x8/0x10c)
[<c0a64df4>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xef0e3fb0 to 0xef0e3ff8)
3fa0:                                     00000000 00000000 00000000
00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 177215
hardirqs last  enabled at (177223): [<c0192d64>] console_unlock+0x4ac/0x698
hardirqs last disabled at (177242): [<c0192984>] console_unlock+0xcc/0x698
softirqs last  enabled at (177260): [<c0102618>] __do_softirq+0x4f0/0x5e0
softirqs last disabled at (177251): [<c012f21c>] irq_exit+0x160/0x16c
---[ end trace ed3dd4223b822796 ]---


> ---
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c | 17 +++++++++++++++--
>  drivers/mfd/wm8994-core.c                    |  9 ---------
>  drivers/regulator/wm8994-regulator.c         | 19 +++++++++++--------
>  include/linux/mfd/wm8994/pdata.h             |  3 ---
>  4 files changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> index 5aa472892465..76c4855a03bc 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -194,8 +194,8 @@ static struct wm8994_pdata wm8994_pdata = {
>  		0x3,          /* IRQ out, active high, CMOS */
>  	},
>  	.ldo = {
> -		 { .enable = S3C64XX_GPN(6), .init_data = &wm8994_ldo1, },
> -		 { .enable = S3C64XX_GPN(4), .init_data = &wm8994_ldo2, },
> +		 { .init_data = &wm8994_ldo1, },
> +		 { .init_data = &wm8994_ldo2, },
>  	},
>  };
>  
> @@ -203,6 +203,18 @@ static const struct i2c_board_info wm1277_devs[] = {
>  	{ I2C_BOARD_INFO("wm8958", 0x1a),  /* WM8958 is the superset */
>  	  .platform_data = &wm8994_pdata,
>  	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
> +	  .dev_name = "wm8958",
> +	},
> +};
> +
> +static struct gpiod_lookup_table wm8994_gpiod_table = {
> +	.dev_id = "i2c-wm8958", /* I2C device name */
> +	.table = {
> +		GPIO_LOOKUP("GPION", 6,
> +			    "wlf,ldo1ena", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("GPION", 4,
> +			    "wlf,ldo2ena", GPIO_ACTIVE_HIGH),
> +		{ },
>  	},
>  };
>  
> @@ -381,6 +393,7 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
>  
>  	gpiod_add_lookup_table(&wm5102_reva_gpiod_table);
>  	gpiod_add_lookup_table(&wm5102_gpiod_table);
> +	gpiod_add_lookup_table(&wm8994_gpiod_table);
>  
>  	if (i < ARRAY_SIZE(gf_mods)) {
>  		dev_info(&i2c->dev, "%s revision %d\n",
> diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
> index 953d0790ffd5..c409464231f6 100644
> --- a/drivers/mfd/wm8994-core.c
> +++ b/drivers/mfd/wm8994-core.c
> @@ -21,7 +21,6 @@
>  #include <linux/mfd/core.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> @@ -302,14 +301,6 @@ static int wm8994_set_pdata_from_of(struct wm8994 *wm8994)
>  	if (of_find_property(np, "wlf,ldoena-always-driven", NULL))
>  		pdata->lineout2fb = true;
>  
> -	pdata->ldo[0].enable = of_get_named_gpio(np, "wlf,ldo1ena", 0);
> -	if (pdata->ldo[0].enable < 0)
> -		pdata->ldo[0].enable = 0;
> -
> -	pdata->ldo[1].enable = of_get_named_gpio(np, "wlf,ldo2ena", 0);
> -	if (pdata->ldo[1].enable < 0)
> -		pdata->ldo[1].enable = 0;
> -
>  	return 0;
>  }
>  #else
> diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
> index 7a4ce6df4f22..d3a5f48119c2 100644
> --- a/drivers/regulator/wm8994-regulator.c
> +++ b/drivers/regulator/wm8994-regulator.c
> @@ -19,7 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/slab.h>
>  
>  #include <linux/mfd/wm8994/core.h>
> @@ -129,6 +129,7 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>  	int id = pdev->id % ARRAY_SIZE(pdata->ldo);
>  	struct regulator_config config = { };
>  	struct wm8994_ldo *ldo;
> +	struct gpio_desc *gpiod;
>  	int ret;
>  
>  	dev_dbg(&pdev->dev, "Probing LDO%d\n", id + 1);
> @@ -145,12 +146,14 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>  	config.driver_data = ldo;
>  	config.regmap = wm8994->regmap;
>  	config.init_data = &ldo->init_data;
> -	if (pdata) {
> -		config.ena_gpio = pdata->ldo[id].enable;
> -	} else if (wm8994->dev->of_node) {
> -		config.ena_gpio = wm8994->pdata.ldo[id].enable;
> -		config.ena_gpio_initialized = true;
> -	}
> +
> +	/* Look up LDO enable GPIO from the parent device node */
> +	gpiod = devm_gpiod_get_optional(pdev->dev.parent,
> +					id ? "wlf,ldo2ena" : "wlf,ldo1ena",
> +					GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod))
> +		return PTR_ERR(gpiod);
> +	config.ena_gpiod = gpiod;
>  
>  	/* Use default constraints if none set up */
>  	if (!pdata || !pdata->ldo[id].init_data || wm8994->dev->of_node) {
> @@ -159,7 +162,7 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>  
>  		ldo->init_data = wm8994_ldo_default[id];
>  		ldo->init_data.consumer_supplies = &ldo->supply;
> -		if (!config.ena_gpio)
> +		if (!gpiod)
>  			ldo->init_data.constraints.valid_ops_mask = 0;
>  	} else {
>  		ldo->init_data = *pdata->ldo[id].init_data;
> diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
> index 90c60524a496..fca67bd194e2 100644
> --- a/include/linux/mfd/wm8994/pdata.h
> +++ b/include/linux/mfd/wm8994/pdata.h
> @@ -20,9 +20,6 @@
>  #define WM8994_NUM_AIF   3
>  
>  struct wm8994_ldo_pdata {
> -	/** GPIOs to enable regulator, 0 or less if not available */
> -	int enable;
> -
>  	const struct regulator_init_data *init_data;
>  };
>  
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

