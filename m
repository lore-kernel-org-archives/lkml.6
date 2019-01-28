Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E32C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456BA2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sopOnbdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfA1Nrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:47:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33251 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1Nrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:47:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190128134745euoutp024ec6de666a6199c8dfa93ad93ed5e485~_BzlpgnVE2019220192euoutp02M
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:47:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190128134745euoutp024ec6de666a6199c8dfa93ad93ed5e485~_BzlpgnVE2019220192euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548683265;
        bh=AzY+m48wsP/vnI+rjolBeql4eTrj2Z7qeb5MH7cEdsg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sopOnbdh1HuHJTS7ikoTvvSVPPjm8z/nC2ChYlupt1U5lUkKOylG5yFNXiu1vYndz
         xP/qWpk6DLBxrXrr3BmU07yuaidRlq10+RlKtHLhp6XvRCORweNE9x7KrtRf86FFz2
         bAyxdZ3x8IYBe6xDw2FH1UyWz/+SrK5sjNr2LP8k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190128134744eucas1p2ff0605917bb0cac408db872abcbb0da1~_Bzk0R9Af0441604416eucas1p2A;
        Mon, 28 Jan 2019 13:47:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 66.E9.04806.FF70F4C5; Mon, 28
        Jan 2019 13:47:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190128134743eucas1p29fcf2039bafeddea2fc9c053d20c4d8c~_BzkBUzIw0262002620eucas1p2I;
        Mon, 28 Jan 2019 13:47:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190128134743eusmtrp2bc75490f675543fd285bd9fb32fb8c21~_BzjywSym2948429484eusmtrp2I;
        Mon, 28 Jan 2019 13:47:43 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-76-5c4f07ffdd95
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.50.04128.EF70F4C5; Mon, 28
        Jan 2019 13:47:42 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190128134742eusmtip1a0a0b897de706f9b6dfd9a5dd00e9657~_BzjQ1oDv0466404664eusmtip1O;
        Mon, 28 Jan 2019 13:47:42 +0000 (GMT)
Subject: Re: [PATCH 2/2] drm/panel: Add driver for Samsung S6E63M0 panel
To:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        thierry.reding@gmail.com
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <d34b1458-70ac-68ab-93a6-75da2227ce83@samsung.com>
Date:   Mon, 28 Jan 2019 14:47:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125164645.19208-2-pawel.mikolaj.chmiel@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87r/2f1jDDrvG1r0njvJZDH/yDlW
        iytf37NZnD+/gd3i8q45bBZrj9xlt1h6/SKTxY/jfcwWrXuPsFv83DWPxYHLY828NYweO2fd
        ZffYtKqTzWP7twesHve7jzN59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8anE2dZCo6eZaz4
        cG4SawPjjvmMXYycHBICJhKfJ7cD2VwcQgIrGCXevPrEBpIQEvjCKDFjrhRE4jOjxMGjP9m7
        GDnAOvZ360DElzNKNM5pYIJw3jJKrJ2zB2yssICHxKILC5hBbBGBOIkLjxaxgRQxC5xglFjS
        uJoJJMEmoCnxd/NNsHW8AnYSE5dNBYuzCKhKbG24D2aLCkRIHO59xwhRIyhxcuYTFpArOAVc
        JNb1SIGEmQXkJZq3zmaGsMUlbj2ZzwTx2j12ib0fOCFsF4n7x5ezQNjCEq+Ob2GHsGUk/u+E
        qa+XaJp5hRnkTgmBDkaJE4uXs0EkrCUOH7/ICrKXGejm9bv0IcKOEi9mL2GGBAqfxI23ghAn
        8ElM2jYdKswr0dEmBFGtKHH/7FZmCFtcYumFr2wTGJVmIflrFpJnZiF5ZhbC3gWMLKsYxVNL
        i3PTU4uN81LL9YoTc4tL89L1kvNzNzECk9bpf8e/7mDc9yfpEKMAB6MSD++G/74xQqyJZcWV
        uYcYJTiYlUR4p173ixHiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgm
        y8TBKdXAuLHBnkcz6+SBR6yXIhR/uPVuXrtY5adPyXSjG4x9kb5V2sxZAdt7N+gUFv33+WHv
        ErnQ3rbr+sZ7rWJKR/iWNx/6t3/Pq9NeIXmq+47NZXMqM3y11Dg8JUh9w8+c26Z8XV+rk9Ju
        OrDaL7pTIKLHdnb/jdc+Svmrbol9rPzG+c9l6fvdotu+KLEUZyQaajEXFScCAO2ne5xWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7r/2P1jDOY2WFn0njvJZDH/yDlW
        iytf37NZnD+/gd3i8q45bBZrj9xlt1h6/SKTxY/jfcwWrXuPsFv83DWPxYHLY828NYweO2fd
        ZffYtKqTzWP7twesHve7jzN59G1ZxejxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6R
        iaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsanE2dZCo6eZaz4cG4SawPjjvmMXYwcHBICJhL7
        u3W6GDk5hASWMko8WyEIYksIiEvsnv+WGcIWlvhzrYuti5ELqOY1o8TbG5+YQBLCAh4Siy4s
        ACsSEYiTmHxuGhNIEbPACUaJfW+WsUFMvcgo0fdPCMRmE9CU+Lv5JlicV8BOYuKyqWCDWARU
        JbY23AezRQUiJD4+3ccEUSMocXLmExaQQzkFXCTW9UiBhJkF1CX+zLvEDGHLSzRvnQ1li0vc
        ejKfaQKj0Cwk3bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgXG67djP
        LTsYu94FH2IU4GBU4uE1YPOPEWJNLCuuzD3EKMHBrCTCO/W6X4wQb0piZVVqUX58UWlOavEh
        RlOg3yYyS4km5wNTSF5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6p
        BsYTqXekYoS3hmq3hb7e/z3mIkNT6kr2hxwv/1z98fZLeFHPotz5my9NOj3lBfOv5RYPTn9o
        WrmkWL02yfxjl1LSscoec+tP904LF1xMzjxxc36WtHcwi8t/3V3+Zw1WNLzXV9pnslcr9dtf
        /S32x61qjrBrKZxOd1ZJVKk1e/UqtChdT25K2FklluKMREMt5qLiRAB4TQDH6QIAAA==
X-CMS-MailID: 20190128134743eucas1p29fcf2039bafeddea2fc9c053d20c4d8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190126203507epcas4p37827a9244ab1501dc4e412fe297c6c0e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190126203507epcas4p37827a9244ab1501dc4e412fe297c6c0e
References: <20190125164645.19208-1-pawel.mikolaj.chmiel@gmail.com>
        <CGME20190126203507epcas4p37827a9244ab1501dc4e412fe297c6c0e@epcas4p3.samsung.com>
        <20190125164645.19208-2-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł,

Nice work.

I agree with most Sam's comments (maybe expect DRM_DEV_* logging - I am
not sure if we need concurrent logging facility).

I'd like to add few more comments:



On 25.01.2019 17:46, Paweł Chmiel wrote:
> This patch adds Samsung S6E63M0 AMOLED LCD panel driver, connected over
> spi. It's based on already removed, non dt s6e63m0 driver and
> panel-samsung-ld9040. There is possibility to choose one from 3
> different gamma tables.
> It can be found for example in some of Samsung Aries based phones.
>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   7 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 712 ++++++++++++++++++
>  3 files changed, 720 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 3f3537719beb..4a4b64f74e70 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -82,6 +82,13 @@ config DRM_PANEL_SAMSUNG_LD9040
>  	depends on OF && SPI
>  	select VIDEOMODE_HELPERS
>  
> +config DRM_PANEL_SAMSUNG_S6E63M0
> +	tristate "Samsung S6E63M0 RGB/SPI panel"
> +	depends on OF
> +	depends on SPI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select VIDEOMODE_HELPERS
> +
>  config DRM_PANEL_LG_LG4573
>  	tristate "LG4573 RGB/SPI panel"
>  	depends on OF && SPI
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 4396658a7996..3e5d53fdee47 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) += panel-raspberrypi-touchscreen
>  obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D16D0) += panel-samsung-s6d16d0.o
> +obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0) += panel-samsung-s6e63m0.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) += panel-samsung-s6e3ha2.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) += panel-samsung-s6e63j0x03.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> new file mode 100644
> index 000000000000..cb5c090621ad
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> @@ -0,0 +1,712 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * S6E63M0 AMOLED LCD drm_panel driver.
> + *
> + * Copyright (C) 2019 Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> + * Derived from drivers/gpu/drm/panel-samsung-ld9040.c
> + *
> + * Andrzej Hajda <a.hajda@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.


You do not need license 'body' if SPDX is in use.


> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_panel.h>
> +
> +#include <linux/backlight.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <video/mipi_display.h>
> +#include <video/of_videomode.h>
> +#include <video/videomode.h>
> +
> +/* Manufacturer Command Set */
> +#define MCS_STAND_BY_OFF                0x11

MIPI_DCS_EXIT_SLEEP_MODE

> +#define MCS_DISPLAY_ON                  0x29
MIPI_DCS_SET_DISPLAY_ON
> +#define MCS_ELVSS_ON                0xb1
> +#define MCS_ACL_CTRL                0xc0
> +#define MCS_DISPLAY_CONDITION   0xf2
> +#define MCS_ETC_CONDITION           0xf6
> +#define MCS_PANEL_CONDITION         0xF8
> +#define MCS_GAMMA_CTRL              0xfa
> +
> +#define MAX_GAMMA_LEVEL             11


GAMMA_LEVEL_COUNT or NUM_GAMMA_LEVELS ?


> +#define GAMMA_TABLE_COUNT           23
> +
> +#define MAX_BRIGHTNESS              (MAX_GAMMA_LEVEL - 1)
> +#define GAMMA_MODE_22               0
> +#define GAMMA_MODE_19               1
> +#define GAMMA_MODE_17               2
> +
> +/* array of gamma tables for gamma value 2.2 */
> +static u8 const s6e63m0_gamma_22[MAX_GAMMA_LEVEL][GAMMA_TABLE_COUNT] = {
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x78, 0xEC, 0x3D, 0xC8,
> +	  0xC2, 0xB6, 0xC4, 0xC7, 0xB6, 0xD5, 0xD7,
> +	  0xCC, 0x00, 0x39, 0x00, 0x36, 0x00, 0x51 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x73, 0x4A, 0x3D, 0xC0,
> +	  0xC2, 0xB1, 0xBB, 0xBE, 0xAC, 0xCE, 0xCF,
> +	  0xC5, 0x00, 0x5D, 0x00, 0x5E, 0x00, 0x82 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x70, 0x51, 0x3E, 0xBF,
> +	  0xC1, 0xAF, 0xB9, 0xBC, 0xAB, 0xCC, 0xCC,
> +	  0xC2, 0x00, 0x65, 0x00, 0x67, 0x00, 0x8D },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x6C, 0x54, 0x3A, 0xBC,
> +	  0xBF, 0xAC, 0xB7, 0xBB, 0xA9, 0xC9, 0xC9,
> +	  0xBE, 0x00, 0x71, 0x00, 0x73, 0x00, 0x9E },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x69, 0x54, 0x37, 0xBB,
> +	  0xBE, 0xAC, 0xB4, 0xB7, 0xA6, 0xC7, 0xC8,
> +	  0xBC, 0x00, 0x7B, 0x00, 0x7E, 0x00, 0xAB },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x66, 0x55, 0x34, 0xBA,
> +	  0xBD, 0xAB, 0xB1, 0xB5, 0xA3, 0xC5, 0xC6,
> +	  0xB9, 0x00, 0x85, 0x00, 0x88, 0x00, 0xBA },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x63, 0x53, 0x31, 0xB8,
> +	  0xBC, 0xA9, 0xB0, 0xB5, 0xA2, 0xC4, 0xC4,
> +	  0xB8, 0x00, 0x8B, 0x00, 0x8E, 0x00, 0xC2 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x62, 0x54, 0x30, 0xB9,
> +	  0xBB, 0xA9, 0xB0, 0xB3, 0xA1, 0xC1, 0xC3,
> +	  0xB7, 0x00, 0x91, 0x00, 0x95, 0x00, 0xDA },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x66, 0x58, 0x34, 0xB6,
> +	  0xBA, 0xA7, 0xAF, 0xB3, 0xA0, 0xC1, 0xC2,
> +	  0xB7, 0x00, 0x97, 0x00, 0x9A, 0x00, 0xD1 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x64, 0x56, 0x33, 0xB6,
> +	  0xBA, 0xA8, 0xAC, 0xB1, 0x9D, 0xC1, 0xC1,
> +	  0xB7, 0x00, 0x9C, 0x00, 0x9F, 0x00, 0xD6 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x5f, 0x50, 0x2d, 0xB6,
> +	  0xB9, 0xA7, 0xAd, 0xB1, 0x9f, 0xbe, 0xC0,
> +	  0xB5, 0x00, 0xa0, 0x00, 0xa4, 0x00, 0xdb },
> +};
> +
> +/* array of gamma tables for gamma value 1.9 */
> +static u8 const s6e63m0_gamma_19[MAX_GAMMA_LEVEL][GAMMA_TABLE_COUNT] = {
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x84, 0x45, 0x4F, 0xCA,
> +	  0xCB, 0xBC, 0xC9, 0xCB, 0xBC, 0xDA, 0xDA,
> +	  0xD0, 0x00, 0x35, 0x00, 0x34, 0x00, 0x4E },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x74, 0x60, 0x4A, 0xC3,
> +	  0xC6, 0xB5, 0xBF, 0xC3, 0xB2, 0xD2, 0xD3,
> +	  0xC8, 0x00, 0x5B, 0x00, 0x5B, 0x00, 0x81 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x6F, 0x65, 0x46, 0xC2,
> +	  0xC4, 0xB3, 0xBF, 0xC2, 0xB2, 0xCF, 0xD1,
> +	  0xC6, 0x00, 0x64, 0x00, 0x64, 0x00, 0x8D },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x6E, 0x65, 0x45, 0xC0,
> +	  0xC3, 0xB2, 0xBA, 0xBE, 0xAE, 0xCD, 0xD0,
> +	  0xC4, 0x00, 0x70, 0x00, 0x70, 0x00, 0x9C },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x69, 0x64, 0x40, 0xBF,
> +	  0xC1, 0xB0, 0xB9, 0xBE, 0xAD, 0xCB, 0xCD,
> +	  0xC2, 0x00, 0x7A, 0x00, 0x7B, 0x00, 0xAA },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x68, 0x64, 0x3F, 0xBE,
> +	  0xC0, 0xB0, 0xB6, 0xBB, 0xAB, 0xC8, 0xCB,
> +	  0xBF, 0x00, 0x85, 0x00, 0x86, 0x00, 0xB8 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x68, 0x64, 0x40, 0xBC,
> +	  0xBF, 0xAF, 0xB4, 0xBA, 0xA9, 0xC8, 0xCA,
> +	  0xBE, 0x00, 0x8B, 0x00, 0x8C, 0x00, 0xC0 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x67, 0x64, 0x3F, 0xBB,
> +	  0xBE, 0xAD, 0xB3, 0xB9, 0xA7, 0xC8, 0xC9,
> +	  0xBE, 0x00, 0x90, 0x00, 0x92, 0x00, 0xC8 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x63, 0x61, 0x3B, 0xBA,
> +	  0xBE, 0xAC, 0xB3, 0xB8, 0xA7, 0xC6, 0xC8,
> +	  0xBD, 0x00, 0x96, 0x00, 0x98, 0x00, 0xCF },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x61, 0x60, 0x39, 0xBB,
> +	  0xBE, 0xAD, 0xB2, 0xB6, 0xA6, 0xC5, 0xC7,
> +	  0xBD, 0x00, 0x9B, 0x00, 0x9E, 0x00, 0xD5 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x61, 0x5F, 0x39, 0xBA,
> +	  0xBD, 0xAD, 0xB1, 0xB6, 0xA5, 0xC4, 0xC5,
> +	  0xBC, 0x00, 0xA0, 0x00, 0xA4, 0x00, 0xDB },
> +};
> +
> +/* array of gamma tables for gamma value 1.7 */
> +static u8 const s6e63m0_gamma_17[MAX_GAMMA_LEVEL][GAMMA_TABLE_COUNT] = {
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x8F, 0x73, 0x63, 0xD1,
> +	  0xD0, 0xC5, 0xCC, 0xD1, 0xC2, 0xDE, 0xE0,
> +	  0xD6, 0x00, 0x39, 0x00, 0x36, 0x00, 0x51 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x82, 0x7A, 0x5B, 0xC8,
> +	  0xCB, 0xBD, 0xC5, 0xCA, 0xBA, 0xD6, 0xD8,
> +	  0xCE, 0x00, 0x5D, 0x00, 0x5E, 0x00, 0x82 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x81, 0x7B, 0x5D, 0xC6,
> +	  0xCA, 0xBB, 0xC3, 0xC7, 0xB8, 0xD6, 0xD8,
> +	  0xCD, 0x00, 0x65, 0x00, 0x67, 0x00, 0x8D },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x7B, 0x77, 0x58, 0xC3,
> +	  0xC8, 0xB8, 0xC2, 0xC6, 0xB6, 0xD3, 0xD4,
> +	  0xCA, 0x00, 0x71, 0x00, 0x73, 0x00, 0x9E },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x75, 0x77, 0x54, 0xC3,
> +	  0xC7, 0xB7, 0xC0, 0xC3, 0xB4, 0xD1, 0xD3,
> +	  0xC9, 0x00, 0x7B, 0x00, 0x7E, 0x00, 0xAB },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x72, 0x75, 0x51, 0xC2,
> +	  0xC6, 0xB5, 0xBF, 0xC1, 0xB3, 0xCE, 0xD1,
> +	  0xC6, 0x00, 0x85, 0x00, 0x88, 0x00, 0xBA },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x71, 0x73, 0x4F, 0xC2,
> +	  0xC5, 0xB5, 0xBD, 0xC0, 0xB2, 0xCD, 0xD1,
> +	  0xC5, 0x00, 0x8B, 0x00, 0x8E, 0x00, 0xC2 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x71, 0x72, 0x4F, 0xC2,
> +	  0xC4, 0xB5, 0xBB, 0xBF, 0xB0, 0xCC, 0xCF,
> +	  0xC3, 0x00, 0x91, 0x00, 0x95, 0x00, 0xCA },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x72, 0x72, 0x50, 0xC0,
> +	  0xC3, 0xB4, 0xB9, 0xBE, 0xAE, 0xCC, 0xCF,
> +	  0xC4, 0x00, 0x97, 0x00, 0x9A, 0x00, 0xD1 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x71, 0x71, 0x50, 0xBF,
> +	  0xC2, 0xB2, 0xBA, 0xBE, 0xAE, 0xCB, 0xCD,
> +	  0xC3, 0x00, 0x9C, 0x00, 0x9F, 0x00, 0xD6 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x70, 0x70, 0x4F, 0xBF,
> +	  0xC2, 0xB2, 0xB8, 0xBC, 0xAC, 0xCB, 0xCD,
> +	  0xC3, 0x00, 0xA0, 0x00, 0xA4, 0x00, 0xDB },
> +};
> +
> +#define S6E63M0_STATE_BIT_ENABLED       0
> +
> +struct s6e63m0 {
> +	struct device *dev;
> +	struct drm_panel panel;
> +
> +	struct regulator_bulk_data supplies[2];
> +	struct gpio_desc *reset_gpio;
> +	u32 power_on_delay;
> +	u32 power_off_delay;
> +	u32 reset_delay;
> +	struct videomode vm;
> +	u32 width_mm;
> +	u32 height_mm;
> +
> +	unsigned long state;
> +	unsigned int gamma_mode;
> +	int brightness;
> +
> +	/* This field is tested by functions directly accessing bus before
> +	 * transfer, transfer is skipped if it is set. In case of transfer
> +	 * failure or unexpected response the field is set to error value.
> +	 * Such construct allows to eliminate many checks in higher level
> +	 * functions.
> +	 */
> +	int error;
> +};
> +
> +static inline struct s6e63m0 *panel_to_s6e63m0(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct s6e63m0, panel);
> +}
> +
> +static int s6e63m0_clear_error(struct s6e63m0 *ctx)
> +{
> +	int ret = ctx->error;
> +
> +	ctx->error = 0;
> +	return ret;
> +}
> +
> +static int s6e63m0_spi_write_word(struct s6e63m0 *ctx, u16 data)
> +{
> +	struct spi_device *spi = to_spi_device(ctx->dev);
> +	struct spi_transfer xfer = {
> +		.len	= 2,
> +		.tx_buf = &data,
> +	};
> +	struct spi_message msg;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	return spi_sync(spi, &msg);
> +}
> +
> +static void s6e63m0_dcs_write(struct s6e63m0 *ctx, const u8 *data, size_t len)
> +{
> +	int ret = 0;
> +
> +	if (ctx->error < 0 || len == 0)
> +		return;
> +
> +	dev_dbg(ctx->dev, "writing dcs seq: %*ph\n", (int)len, data);
> +	ret = s6e63m0_spi_write_word(ctx, *data);
> +
> +	while (!ret && --len) {
> +		++data;
> +		ret = s6e63m0_spi_write_word(ctx, *data | 0x100);
> +	}
> +
> +	if (ret) {
> +		dev_err(ctx->dev, "error %d writing dcs seq: %*ph\n", ret,
> +			(int)len, data);
> +		ctx->error = ret;
> +	}
> +
> +	usleep_range(300, 310);
> +}
> +
> +#define s6e63m0_dcs_write_seq_static(ctx, seq ...) \
> +	({ \
> +		static const u8 d[] = { seq }; \
> +		s6e63m0_dcs_write(ctx, d, ARRAY_SIZE(d)); \
> +	})
> +
> +static void s6e63m0_brightness_set(struct s6e63m0 *ctx)
> +{
> +	/* disable and set new gamma */
> +	switch (ctx->gamma_mode) {
> +	case GAMMA_MODE_22:
> +		s6e63m0_dcs_write(ctx,
> +				  s6e63m0_gamma_22[ctx->brightness],
> +				  ARRAY_SIZE(s6e63m0_gamma_22[ctx->brightness])
> +				  );
> +		break;
> +	case GAMMA_MODE_19:
> +		s6e63m0_dcs_write(ctx,
> +				  s6e63m0_gamma_19[ctx->brightness],
> +				  ARRAY_SIZE(s6e63m0_gamma_19[ctx->brightness])
> +				  );
> +		break;
> +	case GAMMA_MODE_17:
> +		s6e63m0_dcs_write(ctx,
> +				  s6e63m0_gamma_17[ctx->brightness],
> +				  ARRAY_SIZE(s6e63m0_gamma_17[ctx->brightness])
> +				  );
> +		break;
> +	default:
> +		dev_info(ctx->dev,
> +			 "gamma mode could be 0:2.2, 1:1.9 or 2:1.7.Assuming 2.2\n"
> +			 );
> +		s6e63m0_dcs_write(ctx,
> +				  s6e63m0_gamma_22[ctx->brightness],
> +				  ARRAY_SIZE(s6e63m0_gamma_22[ctx->brightness])
> +				  );
> +		break;
> +	}
> +
> +	/* update gamma table. */
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL, 0x01);
> +}
> +
> +static void s6e63m0_init(struct s6e63m0 *ctx)
> +{
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_PANEL_CONDITION,
> +				     0x01, 0x27, 0x27, 0x07, 0x07, 0x54, 0x9f,
> +				     0x63, 0x86, 0x1a, 0x33, 0x0d, 0x00, 0x00);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_DISPLAY_CONDITION,
> +				     0x02, 0x03, 0x1c, 0x10, 0x10);
> +	s6e63m0_dcs_write_seq_static(ctx, 0xf7,
> +				     0x03, 0x00, 0x00);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL,
> +				     0x00, 0x18, 0x08, 0x24, 0x64, 0x56, 0x33,
> +				     0xb6, 0xba, 0xa8, 0xac, 0xb1, 0x9d, 0xc1,
> +				     0xc1, 0xb7, 0x00, 0x9c, 0x00, 0x9f, 0x00,
> +				     0xd6);
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL,
> +				     0x01);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_ETC_CONDITION,
> +				     0x00, 0x8c, 0x07);
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb3,
> +				     0xc);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb5,
> +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
> +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
> +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
> +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
> +				     0x21, 0x20, 0x1e, 0x1e);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb6,
> +				     0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44,
> +				     0x44, 0x55, 0x55, 0x66, 0x66, 0x66, 0x66,
> +				     0x66, 0x66);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb7,
> +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
> +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
> +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
> +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
> +				     0x21, 0x20, 0x1e, 0x1e, 0x00, 0x00, 0x11,
> +				     0x22, 0x33, 0x44, 0x44, 0x44, 0x55, 0x55,
> +				     0x66, 0x66, 0x66, 0x66, 0x66, 0x66);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb9,
> +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
> +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
> +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
> +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
> +				     0x21, 0x20, 0x1e, 0x1e);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xba,
> +				     0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44,
> +				     0x44, 0x55, 0x55, 0x66, 0x66, 0x66, 0x66,
> +				     0x66, 0x66);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xc1,
> +				     0x4d, 0x96, 0x1d, 0x00, 0x00, 0x01, 0xdf,
> +				     0x00, 0x00, 0x03, 0x1f, 0x00, 0x00, 0x00,
> +				     0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x06,
> +				     0x09, 0x0d, 0x0f, 0x12, 0x15, 0x18);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb2,
> +				     0x10, 0x10, 0x0b, 0x05);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_ACL_CTRL,
> +				     0x01);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_ELVSS_ON,
> +				     0x0b);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_STAND_BY_OFF);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_DISPLAY_ON);
> +
> +	s6e63m0_brightness_set(ctx);
> +}
> +
> +static int s6e63m0_power_on(struct s6e63m0 *ctx)
> +{
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(ctx->power_on_delay);
> +
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +	msleep(ctx->reset_delay);
> +	gpiod_set_value(ctx->reset_gpio, 0);
> +	msleep(ctx->reset_delay);
> +
> +	return 0;
> +}
> +
> +static int s6e63m0_power_off(struct s6e63m0 *ctx)
> +{
> +	msleep(ctx->power_off_delay);
> +
> +	return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +}
> +
> +static int s6e63m0_disable(struct drm_panel *panel)
> +{
> +	return 0;
> +}
> +
> +static int s6e63m0_unprepare(struct drm_panel *panel)
> +{
> +	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
> +
> +	clear_bit(S6E63M0_STATE_BIT_ENABLED, &ctx->state);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_ENTER_SLEEP_MODE);
> +
> +	s6e63m0_clear_error(ctx);
> +
> +	return s6e63m0_power_off(ctx);
> +}
> +
> +static int s6e63m0_prepare(struct drm_panel *panel)
> +{
> +	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
> +	int ret;
> +
> +	ret = s6e63m0_power_on(ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	s6e63m0_init(ctx);
> +
> +	ret = s6e63m0_clear_error(ctx);
> +
> +	if (ret < 0)
> +		s6e63m0_unprepare(panel);
> +	else
> +		set_bit(S6E63M0_STATE_BIT_ENABLED, &ctx->state);
> +
> +	return ret;
> +}
> +
> +static int s6e63m0_enable(struct drm_panel *panel)
> +{
> +	return 0;
> +}
> +
> +static int s6e63m0_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_connector *connector = panel->connector;
> +	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_create(connector->dev);
> +	if (!mode) {
> +		DRM_ERROR("failed to create a new display mode\n");
> +		return 0;
> +	}
> +
> +	drm_display_mode_from_videomode(&ctx->vm, mode);
> +	mode->width_mm = ctx->width_mm;
> +	mode->height_mm = ctx->height_mm;
> +	connector->display_info.width_mm = mode->width_mm;
> +	connector->display_info.height_mm = mode->height_mm;
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	mode->flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC;
> +	drm_mode_probed_add(connector, mode);
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs s6e63m0_drm_funcs = {
> +	.disable	= s6e63m0_disable,
> +	.unprepare	= s6e63m0_unprepare,
> +	.prepare	= s6e63m0_prepare,
> +	.enable		= s6e63m0_enable,
> +	.get_modes	= s6e63m0_get_modes,
> +};
> +
> +static int s6e63m0_get_brightness(struct backlight_device *bd)
> +{
> +	return bd->props.brightness;
> +}


This callback can be omitted AFAIK.


> +
> +static int s6e63m0_set_brightness(struct backlight_device *bd)
> +{
> +	struct s6e63m0 *ctx = bl_get_data(bd);
> +
> +	bd->props.power = FB_BLANK_UNBLANK;
> +	if (ctx->brightness != bd->props.brightness) {
> +		ctx->brightness = bd->props.brightness;
> +		if (test_bit(S6E63M0_STATE_BIT_ENABLED, &ctx->state))
> +			s6e63m0_brightness_set(ctx);


It is racy: one thread setting brightness, another disabling panel,
nasty timings and we have attempt to send data to disabled panel.

I do not know backlight framework too much but it does not integrate
well with drm's IMO.

I guess some solution would be to add mutex protecting from concurrent
hw accesses from drm and backlight APIs.


> +	}
> +
> +	return s6e63m0_clear_error(ctx);
> +}
> +
> +static const struct backlight_ops s6e63m0_backlight_ops = {
> +	.get_brightness = s6e63m0_get_brightness,
> +	.update_status	= s6e63m0_set_brightness,
> +};
> +
> +static void s6e63m0_backlight_register(struct s6e63m0 *ctx)
> +{
> +	struct backlight_properties props = {
> +		.type		= BACKLIGHT_RAW,
> +		.brightness	= ctx->brightness,
> +		.max_brightness = MAX_BRIGHTNESS
> +	};
> +	struct device *dev = ctx->dev;
> +	struct backlight_device *bd;
> +
> +	bd = devm_backlight_device_register(dev, "panel", dev, ctx,
> +					    &s6e63m0_backlight_ops, &props);
> +	if (IS_ERR(bd))
> +		dev_err(dev, "error registering backlight device (%ld)\n",
> +			PTR_ERR(bd));
> +}
> +
> +
> +static ssize_t s6e63m0_sysfs_gamma_mode_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct s6e63m0 *ctx = dev_get_drvdata(dev);
> +	char temp[10];
> +
> +	switch (ctx->gamma_mode) {
> +	case GAMMA_MODE_22:
> +		sprintf(temp, "2.2 mode\n");
> +		strcat(buf, temp);
> +		break;
> +	case GAMMA_MODE_19:
> +		sprintf(temp, "1.9 mode\n");
> +		strcat(buf, temp);
> +		break;
> +	case GAMMA_MODE_17:
> +		sprintf(temp, "1.7 mode\n");
> +		strcat(buf, temp);
> +		break;
> +	default:
> +		dev_info(dev, "gamma mode could be 0:2.2, 1:1.9 or 2:1.7)n");
> +		break;
> +	}
> +
> +	return strlen(buf);
> +}
> +
> +static ssize_t s6e63m0_sysfs_gamma_mode_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t len)
> +{
> +	struct s6e63m0 *ctx = dev_get_drvdata(dev);
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &ctx->gamma_mode);
> +	if (rc < 0)
> +		return rc;
> +
> +	s6e63m0_brightness_set(ctx);
> +	return len;
> +}
> +
> +static DEVICE_ATTR(gamma_mode, 0644,
> +		   s6e63m0_sysfs_gamma_mode_show,
> +		   s6e63m0_sysfs_gamma_mode_store);


I see this attribute was copied from vendor code, but it is still
unclear how it was used there. Have you seen userspace code that used
this property?


> +
> +static int s6e63m0_parse_dt(struct s6e63m0 *ctx)
> +{
> +	struct device *dev = ctx->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	ret = of_get_videomode(np, &ctx->vm, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = of_property_read_u32(np, "power-on-delay", &ctx->power_on_delay);
> +	if (ret) {
> +		dev_info(ctx->dev, "using default power-on-delay of 25ms");
> +		ctx->power_on_delay = 25;
> +	}
> +
> +	ret = of_property_read_u32(np, "power-off-delay",
> +				   &ctx->power_off_delay);
> +	if (ret) {
> +		dev_info(ctx->dev, "using default power-of-delay of 200ms");
> +		ctx->power_off_delay = 200;
> +	}
> +
> +	ret = of_property_read_u32(np, "reset-delay", &ctx->reset_delay);
> +	if (ret) {
> +		dev_info(ctx->dev, "using default reset-delay of 120ms");
> +		ctx->reset_delay = 120;
> +	}
> +
> +	of_property_read_u32(np, "panel-width-mm", &ctx->width_mm);
> +	of_property_read_u32(np, "panel-height-mm", &ctx->height_mm);
> +
> +	return 0;
> +}
> +
> +static int s6e63m0_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct s6e63m0 *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(struct s6e63m0), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, ctx);
> +
> +	ctx->dev = dev;
> +	ctx->brightness = MAX_BRIGHTNESS;
> +	ctx->gamma_mode = GAMMA_MODE_22;
> +
> +	ret = s6e63m0_parse_dt(ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->supplies[0].supply = "vdd3";
> +	ctx->supplies[1].supply = "vci";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> +				      ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);


Shouldn't be set to GPIOD_OUT_HIGH? And declared as active low?


> +	if (IS_ERR(ctx->reset_gpio)) {
> +		dev_err(dev, "cannot get reset-gpios %ld\n",
> +			PTR_ERR(ctx->reset_gpio));
> +		return PTR_ERR(ctx->reset_gpio);
> +	}
> +
> +	spi->bits_per_word = 9;
> +	spi->mode = SPI_MODE_3;
> +	ret = spi_setup(spi);
> +	if (ret < 0) {
> +		dev_err(dev, "spi setup failed.\n");
> +		return ret;
> +	}
> +
> +	ret = device_create_file(dev, &dev_attr_gamma_mode);
> +	if (ret < 0)
> +		dev_err(dev, "failed to add sysfs entries\n");
> +
> +	drm_panel_init(&ctx->panel);
> +	ctx->panel.dev = dev;
> +	ctx->panel.funcs = &s6e63m0_drm_funcs;
> +
> +	ret = drm_panel_add(&ctx->panel);
> +	if (ret < 0)
> +		goto err_remove_file;
> +
> +	s6e63m0_backlight_register(ctx);
> +
> +	return 0;
> +
> +err_remove_file:
> +	device_remove_file(dev, &dev_attr_gamma_mode);
> +
> +	return ret;
> +}
> +
> +static int s6e63m0_remove(struct spi_device *spi)
> +{
> +	struct s6e63m0 *ctx = spi_get_drvdata(spi);
> +
> +	s6e63m0_power_off(ctx);


Power should be controlled by drm, of course the problem is that drm
still does not know that panel is during removal, maybe it will be fixed
in near future.  I guess you can remove the line above, and hope the
issue will be fixed in drm core.


Regards

Andrzej


> +	drm_panel_remove(&ctx->panel);
> +	device_remove_file(ctx->dev, &dev_attr_gamma_mode);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id s6e63m0_of_match[] = {
> +	{ .compatible = "samsung,s6e63m0" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, s6e63m0_of_match);
> +
> +static struct spi_driver s6e63m0_driver = {
> +	.probe			= s6e63m0_probe,
> +	.remove			= s6e63m0_remove,
> +	.driver			= {
> +		.name		= "panel-samsung-s6e63m0",
> +		.of_match_table = s6e63m0_of_match,
> +	},
> +};
> +module_spi_driver(s6e63m0_driver);
> +
> +MODULE_AUTHOR("Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>");
> +MODULE_DESCRIPTION("s6e63m0 LCD Driver");
> +MODULE_LICENSE("GPL v2");


