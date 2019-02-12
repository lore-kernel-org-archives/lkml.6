Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3CFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6696120821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rQ0ZUDh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfBLJLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:11:25 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35933 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfBLJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:11:24 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212091122euoutp023b5b47a88cff673d45b88a68a03450ab~CktjxrAkC2674426744euoutp02p
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:11:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212091122euoutp023b5b47a88cff673d45b88a68a03450ab~CktjxrAkC2674426744euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549962682;
        bh=aeh0xMON6rMbyDViEheoDiasDsnHeCCwuogVHf8y/Qc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rQ0ZUDh60JXBxetn08iNkT0ZUqxI2FzIn0dRfNEjFoAg7ab/qzHchf39sSJsGvt98
         Fc0/mIozyxyUmeRJOH+6W7WR4XhbTwRaL5og2TDkhT4OUTwoF4hYJhLfe902E/8ZW9
         aPYYKVObYyTFENjNEzz23Bix7MGD6IAqBbHpsDDs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212091121eucas1p2c4501060ad741d384e9eef858e90aead~CktjBeJcn2022920229eucas1p2Y;
        Tue, 12 Feb 2019 09:11:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9E.44.04806.9BD826C5; Tue, 12
        Feb 2019 09:11:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190212091120eucas1p28742c5997e23b7712fa72b90338a0f84~Ckth-yLZZ2022920229eucas1p2W;
        Tue, 12 Feb 2019 09:11:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212091120eusmtrp2400449f31b05518542b3ede70cd60a02~CkthxRFYR0773307733eusmtrp2N;
        Tue, 12 Feb 2019 09:11:20 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-79-5c628db9296d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FF.45.04284.7BD826C5; Tue, 12
        Feb 2019 09:11:19 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212091119eusmtip133951ad22abe2493e773359e0a1b7569~CkthOsJPF2556625566eusmtip1-;
        Tue, 12 Feb 2019 09:11:19 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] drm/panel: Add driver for Samsung S6E63M0 panel
To:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3fc37ef2-181f-6268-756f-634a4355db61@samsung.com>
Date:   Tue, 12 Feb 2019 10:11:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1958995.aBsZzC1X05@acerlaptop>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtt7vd3Y0m16n4YS8aZGW+wogbiliELJOI8I+ykV3zopJT2VVT
        E5LM12pWQxSnqTTFMEvz2cxMfDSlfKVWlqLBLFS0wtTMrLZdJf875zvnexz4CEzaJXAiIqPj
        GFU0HSXDxfzGlyt9bgZNqMLzRhlBafp6eFRJZ5+AGl78ilP9/TVCaqi5CKcedY4LqfJ3gzzq
        pzEHo9KfdwqpleZivp9YXlVcheQG3bhQXluZjcubliYF8ombRp48p74SyRdqd54WBot9wpio
        yARG5eF7URxR0ZuBx2pbUOKA+kAqas5FaiQigDwECx2vcTUSE1LyAYK0tOV18gPB6rNRHkcW
        EDwx1fM2WsoLhtZdFQha9IWII3MIcttnBRaXHXkSivLuYhZsTx4DTcMMZjFhpAnByK0BvkXA
        yf2wVjeKW7CE9IXRpo9CC+aTe6DthdbqcSDPQodmHnEeW+gpMFnrItIVxrInrMswchekNRRi
        HHaED6YS691AvhVC1dy0uZkwk+OQvubHRbCDGWO9kMPb4a+hZD3aNbheMIxxvVkIuvUVOCd4
        Q4dxUGCZg5mPrm724MpHQaNbwrjxNvB+zpY7wQa0jfnrZQlkZUg5926Y6G3AOOwI5QOL+B0k
        020KptsURrcpjO7/3lLEr0SOTDyrDGdYr2jmijtLK9n46HD3SzHKWmR+rld/jItPUevv0HZE
        Eki2VZIYQyukAjqBTVK2IyAwmb0kKTtUIZWE0UnJjComRBUfxbDtaBvBlzlKrm6ZPC8lw+k4
        5jLDxDKqDZVHiJxSUWCq22ypi1oQpyWVosRyU1txi0qrdD3V5VAytte5FPLmyuL1j4/EHg6a
        stunH61uLGq6p7hwYjrfcP920Gp947jn/EOviqmU/G+6X8G9xuWUgDM76JB+51L1TJBPsndV
        ZE1Oq/0nxZe2wD0y7zcz51w/+2eymYOzI/513/u6A1gZn42gD7pgKpb+B6tMgJ5YAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7rbe5NiDOYvsrHoPXeSyWL+kXOs
        Fle+vmezOH9+A7vF5V1z2CzWHrnLbrH0+kUmix/H+5gtWvceYbf4uWseiwOXx5p5axg9ds66
        y+6xaVUnm8f2bw9YPe53H2fy6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
        E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzlZ9vYCibtYay40KXdwLhrCmMXIyeHhICJxNKZ
        l9m6GLk4hASWMkrMn7aKFSIhLrF7/ltmCFtY4s+1Lqii14wSC8/fBEsIC3hLzJk2EcwWEXCS
        6N36ihmkiFngCaPElFtTmSA6ljFJtKx7wgJSxSagKfF38002EJtXwE7i5vbb7CA2i4CqxIH9
        k8BqRAUiJD4+3ccEUSMocXImRC+ngI7Enc77YOcxC6hL/Jl3iRnClpdo3jobyhaXuPVkPtME
        RqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQKjdduxn5t3MF7a
        GHyIUYCDUYmHtyI/MUaINbGsuDL3EKMEB7OSCG9lZ1KMEG9KYmVValF+fFFpTmrxIUZToOcm
        MkuJJucDE0leSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQbGhv4o
        zdBMubyHdRvrp3xKr9i1xVpjmzY/a41dScCFFIFDHrzdSyUK5bTVb9x+e2L1YYXndpb2JTLP
        Z4raVJy9JeMcHzrJ/MxH24UZVy8xxds8MVX/nZiinBL61YJ/ddzaP1Mqd25NN3hwxFng5OdF
        K/Z+Lor8fzrSYK6RaswJnsdWa65o/dBTYinOSDTUYi4qTgQAzCBZLOwCAAA=
X-CMS-MailID: 20190212091120eucas1p28742c5997e23b7712fa72b90338a0f84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190211160813epcas4p32d0309c86ee5716a278522fbd4363d16
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190211160813epcas4p32d0309c86ee5716a278522fbd4363d16
References: <20190202142748.6830-1-pawel.mikolaj.chmiel@gmail.com>
        <20190202142748.6830-2-pawel.mikolaj.chmiel@gmail.com>
        <82ccf31e-13c3-1cd5-d87a-0c3291eb0224@samsung.com>
        <CGME20190211160813epcas4p32d0309c86ee5716a278522fbd4363d16@epcas4p3.samsung.com>
        <1958995.aBsZzC1X05@acerlaptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.2019 17:07, Paweł Chmiel wrote:
> On poniedziałek, 11 lutego 2019 16:35:19 CET Andrzej Hajda wrote:
>> On 02.02.2019 15:27, Paweł Chmiel wrote:
>>> This patch adds Samsung S6E63M0 AMOLED LCD panel driver, connected over
>>> spi. It's based on already removed, non dt s6e63m0 driver and
>>> panel-samsung-ld9040. It can be found for example in some of Samsung
>>> Aries based phones.
>>>
>>> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
>>> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>>> ---
>>> Changes from v2:
>>>   - VIDEOMODE_HELPERS is not needed in Kconfig
>>>   - Added help text to Kconfig
>>>   - Remove unneeded videomode includes/fields
>>>   - Add sentinel comment in s6e63m0_of_match struct
>>>   - Handle errors during registration of backlight device. We shouldn't
>>>     register panel if we fail to register backlight device
>>>   - Added Reviewed-by
>>>
>>> Changes from v1:
>>>   - Correct order of Kconfig/Makefile entry
>>>   - Fix SPDX tag, so it matches value of MODULE_LICENSE
>>>   - Remove inclusion of drmP.h
>>>   - Fix code formatting
>>>   - Use DRM_DEV_ERROR/DEBUG
>>>   - Extract hardcoded values
>>>   - Remove possibility to change gamma through sysfs, leaving only one
>>>     gamma table values
>>>   - Fix reset_gpio handling, so it'll be asserted in power_on and
>>>     deasserted in power_off. Also do it before turning voltage on.
>>>   - Disable backlight and enter sleep mode in disable callback.
>>>     Previously it was done in unprepare
>>>   - Enable display and backlight in enable callback. Previously it was
>>>     done in prepare
>>>   - Hardcode display timings and delays. Previously they were readed
>>>     from device tree
>>>   - We're using SPDX, so we don't need to have license body
>>>   - Use MIPI_DCS_EXIT_SLEEP_MODE and MIPI_DCS_SET_DISPLAY_ON
>>>   - Rename MAX_GAMMA_LEVEL to NUM_GAMMA_LEVELS
>>>   - Ommit get_brightness callback
>>>   - Use backlight_enable/disable API, like it's done in other panel
>>>     drivers (for example panel-simple)
>>>   - Make set_brightness called only from backlight api, like it's done
>>>     in other panel drivers (for example panel-simple).
>>>   - Reset gpio should be set to GPIOD_OUT_HIGH. It's declared as active
>>>     low in device tree
>>>   - Don't call power_off in remove callback
>>> ---
>>>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>>>  drivers/gpu/drm/panel/Makefile                |   1 +
>>>  drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 517 ++++++++++++++++++
>>>  3 files changed, 527 insertions(+)
>>>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
>>>
>>> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
>>> index 3f3537719beb..45e9ab4b7857 100644
>>> --- a/drivers/gpu/drm/panel/Kconfig
>>> +++ b/drivers/gpu/drm/panel/Kconfig
>>> @@ -158,6 +158,15 @@ config DRM_PANEL_SAMSUNG_S6E63J0X03
>>>  	depends on BACKLIGHT_CLASS_DEVICE
>>>  	select VIDEOMODE_HELPERS
>>>  
>>> +config DRM_PANEL_SAMSUNG_S6E63M0
>>> +	tristate "Samsung S6E63M0 RGB/SPI panel"
>>> +	depends on OF
>>> +	depends on SPI
>>> +	depends on BACKLIGHT_CLASS_DEVICE
>>> +	help
>>> +	  Say Y here if you want to enable support for Samsung s6e63m0
>>> +	  AMOLED LCD panel.
>>> +
>>>  config DRM_PANEL_SAMSUNG_S6E8AA0
>>>  	tristate "Samsung S6E8AA0 DSI video mode panel"
>>>  	depends on OF
>>> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
>>> index 4396658a7996..4507a2d253ac 100644
>>> --- a/drivers/gpu/drm/panel/Makefile
>>> +++ b/drivers/gpu/drm/panel/Makefile
>>> @@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
>>>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D16D0) += panel-samsung-s6d16d0.o
>>>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) += panel-samsung-s6e3ha2.o
>>>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) += panel-samsung-s6e63j0x03.o
>>> +obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0) += panel-samsung-s6e63m0.o
>>>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
>>>  obj-$(CONFIG_DRM_PANEL_SEIKO_43WVF1G) += panel-seiko-43wvf1g.o
>>>  obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
>>> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
>>> new file mode 100644
>>> index 000000000000..4312aa3e4386
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
>>> @@ -0,0 +1,517 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * S6E63M0 AMOLED LCD drm_panel driver.
>>> + *
>>> + * Copyright (C) 2019 Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
>>> + * Derived from drivers/gpu/drm/panel-samsung-ld9040.c
>>> + *
>>> + * Andrzej Hajda <a.hajda@samsung.com>
>>> + */
>>> +
>>> +#include <drm/drm_modes.h>
>>> +#include <drm/drm_panel.h>
>>> +#include <drm/drm_print.h>
>>> +
>>> +#include <linux/backlight.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/gpio/consumer.h>
>>> +#include <linux/module.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/spi/spi.h>
>>> +
>>> +#include <video/mipi_display.h>
>>> +
>>> +/* Manufacturer Command Set */
>>> +#define MCS_ELVSS_ON                0xb1
>>> +#define MCS_ACL_CTRL                0xc0
>>> +#define MCS_DISPLAY_CONDITION   0xf2
>>> +#define MCS_ETC_CONDITION           0xf6
>>> +#define MCS_PANEL_CONDITION         0xF8
>>> +#define MCS_GAMMA_CTRL              0xfa
>>> +
>>> +#define NUM_GAMMA_LEVELS             11
>>> +#define GAMMA_TABLE_COUNT           23
>>> +
>>> +#define DATA_MASK                                       0x100
>>> +
>>> +#define MAX_BRIGHTNESS              (NUM_GAMMA_LEVELS - 1)
>>> +
>>> +/* array of gamma tables for gamma value 2.2 */
>>> +static u8 const s6e63m0_gamma_22[NUM_GAMMA_LEVELS][GAMMA_TABLE_COUNT] = {
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x78, 0xEC, 0x3D, 0xC8,
>>> +	  0xC2, 0xB6, 0xC4, 0xC7, 0xB6, 0xD5, 0xD7,
>>> +	  0xCC, 0x00, 0x39, 0x00, 0x36, 0x00, 0x51 },
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x73, 0x4A, 0x3D, 0xC0,
>>> +	  0xC2, 0xB1, 0xBB, 0xBE, 0xAC, 0xCE, 0xCF,
>>> +	  0xC5, 0x00, 0x5D, 0x00, 0x5E, 0x00, 0x82 },
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x70, 0x51, 0x3E, 0xBF,
>>> +	  0xC1, 0xAF, 0xB9, 0xBC, 0xAB, 0xCC, 0xCC,
>>> +	  0xC2, 0x00, 0x65, 0x00, 0x67, 0x00, 0x8D },
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x6C, 0x54, 0x3A, 0xBC,
>>> +	  0xBF, 0xAC, 0xB7, 0xBB, 0xA9, 0xC9, 0xC9,
>>> +	  0xBE, 0x00, 0x71, 0x00, 0x73, 0x00, 0x9E },
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x69, 0x54, 0x37, 0xBB,
>>> +	  0xBE, 0xAC, 0xB4, 0xB7, 0xA6, 0xC7, 0xC8,
>>> +	  0xBC, 0x00, 0x7B, 0x00, 0x7E, 0x00, 0xAB },
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x66, 0x55, 0x34, 0xBA,
>>> +	  0xBD, 0xAB, 0xB1, 0xB5, 0xA3, 0xC5, 0xC6,
>>> +	  0xB9, 0x00, 0x85, 0x00, 0x88, 0x00, 0xBA },
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x63, 0x53, 0x31, 0xB8,
>>> +	  0xBC, 0xA9, 0xB0, 0xB5, 0xA2, 0xC4, 0xC4,
>>> +	  0xB8, 0x00, 0x8B, 0x00, 0x8E, 0x00, 0xC2 },
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x62, 0x54, 0x30, 0xB9,
>>> +	  0xBB, 0xA9, 0xB0, 0xB3, 0xA1, 0xC1, 0xC3,
>>> +	  0xB7, 0x00, 0x91, 0x00, 0x95, 0x00, 0xDA },
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x66, 0x58, 0x34, 0xB6,
>>> +	  0xBA, 0xA7, 0xAF, 0xB3, 0xA0, 0xC1, 0xC2,
>>> +	  0xB7, 0x00, 0x97, 0x00, 0x9A, 0x00, 0xD1 },
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x64, 0x56, 0x33, 0xB6,
>>> +	  0xBA, 0xA8, 0xAC, 0xB1, 0x9D, 0xC1, 0xC1,
>>> +	  0xB7, 0x00, 0x9C, 0x00, 0x9F, 0x00, 0xD6 },
>>> +	{ MCS_GAMMA_CTRL, 0x00,
>>> +	  0x18, 0x08, 0x24, 0x5f, 0x50, 0x2d, 0xB6,
>>> +	  0xB9, 0xA7, 0xAd, 0xB1, 0x9f, 0xbe, 0xC0,
>>> +	  0xB5, 0x00, 0xa0, 0x00, 0xa4, 0x00, 0xdb },
>>> +};
>>> +
>>> +struct s6e63m0 {
>>> +	struct device *dev;
>>> +	struct drm_panel panel;
>>> +	struct backlight_device *bl_dev;
>>> +
>>> +	struct regulator_bulk_data supplies[2];
>>> +	struct gpio_desc *reset_gpio;
>>> +
>>> +	bool prepared;
>>> +	bool enabled;
>>> +
>>> +	/*
>>> +	 * This field is tested by functions directly accessing bus before
>>> +	 * transfer, transfer is skipped if it is set. In case of transfer
>>> +	 * failure or unexpected response the field is set to error value.
>>> +	 * Such construct allows to eliminate many checks in higher level
>>> +	 * functions.
>>> +	 */
>>> +	int error;
>>> +};
>>> +
>>> +static const struct drm_display_mode default_mode = {
>>> +	.clock		= 25628,
>>> +	.hdisplay	= 480,
>>> +	.hsync_start	= 480 + 16,
>>> +	.hsync_end	= 480 + 16 + 2,
>>> +	.htotal		= 480 + 16 + 2 + 16,
>>> +	.vdisplay	= 800,
>>> +	.vsync_start	= 800 + 28,
>>> +	.vsync_end	= 800 + 28 + 2,
>>> +	.vtotal		= 800 + 28 + 2 + 1,
>>> +	.vrefresh	= 60,
>>> +	.width_mm	= 53,
>>> +	.height_mm	= 89,
>>> +	.flags		= DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
>>> +};
>>> +
>>> +static inline struct s6e63m0 *panel_to_s6e63m0(struct drm_panel *panel)
>>> +{
>>> +	return container_of(panel, struct s6e63m0, panel);
>>> +}
>>> +
>>> +static int s6e63m0_clear_error(struct s6e63m0 *ctx)
>>> +{
>>> +	int ret = ctx->error;
>>> +
>>> +	ctx->error = 0;
>>> +	return ret;
>>> +}
>>> +
>>> +static int s6e63m0_spi_write_word(struct s6e63m0 *ctx, u16 data)
>>> +{
>>> +	struct spi_device *spi = to_spi_device(ctx->dev);
>>> +	struct spi_transfer xfer = {
>>> +		.len	= 2,
>>> +		.tx_buf = &data,
>>> +	};
>>> +	struct spi_message msg;
>>> +
>>> +	spi_message_init(&msg);
>>> +	spi_message_add_tail(&xfer, &msg);
>>> +
>>> +	return spi_sync(spi, &msg);
>>> +}
>>> +
>>> +static void s6e63m0_dcs_write(struct s6e63m0 *ctx, const u8 *data, size_t len)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	if (ctx->error < 0 || len == 0)
>>> +		return;
>>> +
>>> +	DRM_DEV_DEBUG(ctx->dev, "writing dcs seq: %*ph\n", (int)len, data);
>>> +	ret = s6e63m0_spi_write_word(ctx, *data);
>>> +
>>> +	while (!ret && --len) {
>>> +		++data;
>>> +		ret = s6e63m0_spi_write_word(ctx, *data | DATA_MASK);
>>> +	}
>>> +
>>> +	if (ret) {
>>> +		DRM_DEV_ERROR(ctx->dev, "error %d writing dcs seq: %*ph\n", ret,
>>> +			      (int)len, data);
>>> +		ctx->error = ret;
>>> +	}
>>> +
>>> +	usleep_range(300, 310);
>>> +}
>>> +
>>> +#define s6e63m0_dcs_write_seq_static(ctx, seq ...) \
>>> +	({ \
>>> +		static const u8 d[] = { seq }; \
>>> +		s6e63m0_dcs_write(ctx, d, ARRAY_SIZE(d)); \
>>> +	})
>>> +
>>> +static void s6e63m0_brightness_set(struct s6e63m0 *ctx)
>>> +{
>>> +	int brightness = ctx->bl_dev->props.brightness;
>>> +
>>> +	/* disable and set new gamma */
>>> +	s6e63m0_dcs_write(ctx, s6e63m0_gamma_22[brightness],
>>> +			  ARRAY_SIZE(s6e63m0_gamma_22[brightness]));
>>> +
>>> +	/* update gamma table. */
>>> +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL, 0x01);
>>> +}
>>
>> I guess you can squash this callback into s6e63m0_set_brightness.
>> Moreover you performs transfer here unconditionally, regardless of panel
>> power state, it will fail when drm device is disabled (using echo 255
>>> /sys/class/backlight/...) - panel is also disabled - making transfer to
>> disabled panel by panel driver looks odd, moreover it could be little
>> bit racy. But in practice it could work.
>>
>> Moreover I do not see usage of backlight_properties.power,
>> backlight_properties.state, but I do not understand how exactly
>> backlight interface should work, if someone can point out to proper
>> docs/usage of backlight API I will be glad.
> I also had similar problems (and it was mentioned in previous versions review).
> Now i've tried to replicate behaviour used by some other panel drivers.
>>
>>> +
>>> +static void s6e63m0_init(struct s6e63m0 *ctx)
>>> +{
>>> +	s6e63m0_dcs_write_seq_static(ctx, MCS_PANEL_CONDITION,
>>> +				     0x01, 0x27, 0x27, 0x07, 0x07, 0x54, 0x9f,
>>> +				     0x63, 0x86, 0x1a, 0x33, 0x0d, 0x00, 0x00);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, MCS_DISPLAY_CONDITION,
>>> +				     0x02, 0x03, 0x1c, 0x10, 0x10);
>>> +	s6e63m0_dcs_write_seq_static(ctx, 0xf7,
>>> +				     0x03, 0x00, 0x00);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL,
>>> +				     0x00, 0x18, 0x08, 0x24, 0x64, 0x56, 0x33,
>>> +				     0xb6, 0xba, 0xa8, 0xac, 0xb1, 0x9d, 0xc1,
>>> +				     0xc1, 0xb7, 0x00, 0x9c, 0x00, 0x9f, 0x00,
>>> +				     0xd6);
>>> +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL,
>>> +				     0x01);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, MCS_ETC_CONDITION,
>>> +				     0x00, 0x8c, 0x07);
>>> +	s6e63m0_dcs_write_seq_static(ctx, 0xb3,
>>> +				     0xc);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, 0xb5,
>>> +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
>>> +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
>>> +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
>>> +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
>>> +				     0x21, 0x20, 0x1e, 0x1e);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, 0xb6,
>>> +				     0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44,
>>> +				     0x44, 0x55, 0x55, 0x66, 0x66, 0x66, 0x66,
>>> +				     0x66, 0x66);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, 0xb7,
>>> +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
>>> +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
>>> +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
>>> +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
>>> +				     0x21, 0x20, 0x1e, 0x1e, 0x00, 0x00, 0x11,
>>> +				     0x22, 0x33, 0x44, 0x44, 0x44, 0x55, 0x55,
>>> +				     0x66, 0x66, 0x66, 0x66, 0x66, 0x66);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, 0xb9,
>>> +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
>>> +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
>>> +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
>>> +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
>>> +				     0x21, 0x20, 0x1e, 0x1e);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, 0xba,
>>> +				     0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44,
>>> +				     0x44, 0x55, 0x55, 0x66, 0x66, 0x66, 0x66,
>>> +				     0x66, 0x66);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, 0xc1,
>>> +				     0x4d, 0x96, 0x1d, 0x00, 0x00, 0x01, 0xdf,
>>> +				     0x00, 0x00, 0x03, 0x1f, 0x00, 0x00, 0x00,
>>> +				     0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x06,
>>> +				     0x09, 0x0d, 0x0f, 0x12, 0x15, 0x18);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, 0xb2,
>>> +				     0x10, 0x10, 0x0b, 0x05);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, MCS_ACL_CTRL,
>>> +				     0x01);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, MCS_ELVSS_ON,
>>> +				     0x0b);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_EXIT_SLEEP_MODE);
>>> +}
>>> +
>>> +static int s6e63m0_power_on(struct s6e63m0 *ctx)
>>> +{
>>> +	int ret;
>>> +
>>> +	gpiod_set_value(ctx->reset_gpio, 0);
>>> +	msleep(120);
>>> +
>>> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>>> +	if (ret < 0)
>>> +		return ret;
>>
>> Are you sure gpios before regulators, from my experience usually it is
>> reverse.
> In v1 i had also regulators -> gpios order (like in vendor sources), but i got suggestion that  changing it this way
> we avoid situation where the panel is starting up, reset and then starting up again.


In Samsung panels RESET line usually behaves more like power line, not
as a reset impulse.

Power-on sequence is as follows:

Initial state: RESET line is physically low, supplies off.

Power on:

1. Enable power supplies (sometimes order and timings matters, sometimes
not, depends on panel).

2. After specific time RESET line should be physically raised.

3. After specific time panel is working.


Power off is reverse, with different timings.

See for example datasheets for some panels:

https://www.beyondinfinite.com/lcd/Library/Samsung/AMS369FG06-0.pdf

https://www.displayfuture.com/Display/datasheet/controller/S6D04H0X.pdf


BTW you can try to match your MCS command names with ones specified in
these pdfs.


There are some chances that in case of your panel the sequence is
different, but I do not think so.

I guess vendor code has also this sequence.


>>
>>> +
>>> +	msleep(25);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int s6e63m0_power_off(struct s6e63m0 *ctx)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	gpiod_set_value(ctx->reset_gpio, 1);
>>
>> Ditto.
>>
>>
>>> +	msleep(120);
>>
>> What is the point of this msleep?
> Yes, i missed it when fixing reset_gpio handling (previously it was done only on power_on, like in vendor driver).
> After refactor and spliting code i leaved msleep in both places, where in poweroff it don't have any sense.
>>
>> I guess, the answer for above comments can be difficult, since datasheet
>> is not available, so if you just followed vendor code please feel free
>> to add:
>>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> I got information that this driver was tested on some tegra 2 based samsung device and it was working.
> Samsung Captivate Glide (SGH-i927).
>
> The only one change was that in original driver for that device, there was rotation set.
> Currently i'm sending 
> 0xf7, 0x03, 0x00, 0x00
> where on that device driver was sending 
> 0xf7, 0x00, 0x00, 0x00
> Difference is that when running driver in current shape (sending 0x03), screen is rotated.
>
> So it looks like that panel supports rotation. Should this be added to current driver (for example next patch after gettting initial driver fixed/working/merged),
> or it should be handled somewhere in drm/userspace/some other place?


IIRC rotation can be specified in devicetree property [1].

[1]: Documentation/devicetree/bindings/display/panel/panel.txt


Regards

Andrzej


>
>> --
>>
>> Regards
>> Andrzej
>>
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int s6e63m0_disable(struct drm_panel *panel)
>>> +{
>>> +	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
>>> +
>>> +	if (!ctx->enabled)
>>> +		return 0;
>>> +
>>> +	backlight_disable(ctx->bl_dev);
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_ENTER_SLEEP_MODE);
>>> +	msleep(200);
>>> +
>>> +	ctx->enabled = false;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int s6e63m0_unprepare(struct drm_panel *panel)
>>> +{
>>> +	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
>>> +	int ret;
>>> +
>>> +	if (!ctx->prepared)
>>> +		return 0;
>>> +
>>> +	s6e63m0_clear_error(ctx);
>>> +
>>> +	ret = s6e63m0_power_off(ctx);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	ctx->prepared = false;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int s6e63m0_prepare(struct drm_panel *panel)
>>> +{
>>> +	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
>>> +	int ret;
>>> +
>>> +	if (ctx->prepared)
>>> +		return 0;
>>> +
>>> +	ret = s6e63m0_power_on(ctx);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	s6e63m0_init(ctx);
>>> +
>>> +	ret = s6e63m0_clear_error(ctx);
>>> +
>>> +	if (ret < 0)
>>> +		s6e63m0_unprepare(panel);
>>> +
>>> +	ctx->prepared = true;
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int s6e63m0_enable(struct drm_panel *panel)
>>> +{
>>> +	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
>>> +
>>> +	if (ctx->enabled)
>>> +		return 0;
>>> +
>>> +	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_SET_DISPLAY_ON);
>>> +
>>> +	backlight_enable(ctx->bl_dev);
>>> +
>>> +	ctx->enabled = true;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int s6e63m0_get_modes(struct drm_panel *panel)
>>> +{
>>> +	struct drm_connector *connector = panel->connector;
>>> +	struct drm_display_mode *mode;
>>> +
>>> +	mode = drm_mode_duplicate(panel->drm, &default_mode);
>>> +	if (!mode) {
>>> +		DRM_ERROR("failed to add mode %ux%ux@%u\n",
>>> +			  default_mode.hdisplay, default_mode.vdisplay,
>>> +			  default_mode.vrefresh);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	drm_mode_set_name(mode);
>>> +
>>> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
>>> +	drm_mode_probed_add(connector, mode);
>>> +
>>> +	return 1;
>>> +}
>>> +
>>> +static const struct drm_panel_funcs s6e63m0_drm_funcs = {
>>> +	.disable	= s6e63m0_disable,
>>> +	.unprepare	= s6e63m0_unprepare,
>>> +	.prepare	= s6e63m0_prepare,
>>> +	.enable		= s6e63m0_enable,
>>> +	.get_modes	= s6e63m0_get_modes,
>>> +};
>>> +
>>> +static int s6e63m0_set_brightness(struct backlight_device *bd)
>>> +{
>>> +	struct s6e63m0 *ctx = bl_get_data(bd);
>>> +
>>> +	s6e63m0_brightness_set(ctx);
>>> +
>>> +	return s6e63m0_clear_error(ctx);
>>> +}
>>> +
>>> +static const struct backlight_ops s6e63m0_backlight_ops = {
>>> +	.update_status	= s6e63m0_set_brightness,
>>> +};
>>> +
>>> +static int s6e63m0_backlight_register(struct s6e63m0 *ctx)
>>> +{
>>> +	struct backlight_properties props = {
>>> +		.type		= BACKLIGHT_RAW,
>>> +		.brightness	= MAX_BRIGHTNESS,
>>> +		.max_brightness = MAX_BRIGHTNESS
>>> +	};
>>> +	struct device *dev = ctx->dev;
>>> +	int ret = 0;
>>> +
>>> +	ctx->bl_dev = devm_backlight_device_register(dev, "panel", dev, ctx,
>>> +						     &s6e63m0_backlight_ops,
>>> +						     &props);
>>> +	if (IS_ERR(ctx->bl_dev)) {
>>> +		ret = PTR_ERR(ctx->bl_dev);
>>> +		DRM_DEV_ERROR(dev, "error registering backlight device (%d)\n",
>>> +			      ret);
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int s6e63m0_probe(struct spi_device *spi)
>>> +{
>>> +	struct device *dev = &spi->dev;
>>> +	struct s6e63m0 *ctx;
>>> +	int ret;
>>> +
>>> +	ctx = devm_kzalloc(dev, sizeof(struct s6e63m0), GFP_KERNEL);
>>> +	if (!ctx)
>>> +		return -ENOMEM;
>>> +
>>> +	spi_set_drvdata(spi, ctx);
>>> +
>>> +	ctx->dev = dev;
>>> +	ctx->enabled = false;
>>> +	ctx->prepared = false;
>>> +
>>> +	ctx->supplies[0].supply = "vdd3";
>>> +	ctx->supplies[1].supply = "vci";
>>> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
>>> +				      ctx->supplies);
>>> +	if (ret < 0) {
>>> +		DRM_DEV_ERROR(dev, "failed to get regulators: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>>> +	if (IS_ERR(ctx->reset_gpio)) {
>>> +		DRM_DEV_ERROR(dev, "cannot get reset-gpios %ld\n",
>>> +			      PTR_ERR(ctx->reset_gpio));
>>> +		return PTR_ERR(ctx->reset_gpio);
>>> +	}
>>> +
>>> +	spi->bits_per_word = 9;
>>> +	spi->mode = SPI_MODE_3;
>>> +	ret = spi_setup(spi);
>>> +	if (ret < 0) {
>>> +		DRM_DEV_ERROR(dev, "spi setup failed.\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	drm_panel_init(&ctx->panel);
>>> +	ctx->panel.dev = dev;
>>> +	ctx->panel.funcs = &s6e63m0_drm_funcs;
>>> +
>>> +	ret = s6e63m0_backlight_register(ctx);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	return drm_panel_add(&ctx->panel);
>>> +}
>>> +
>>> +static int s6e63m0_remove(struct spi_device *spi)
>>> +{
>>> +	struct s6e63m0 *ctx = spi_get_drvdata(spi);
>>> +
>>> +	drm_panel_remove(&ctx->panel);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct of_device_id s6e63m0_of_match[] = {
>>> +	{ .compatible = "samsung,s6e63m0" },
>>> +	{ /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, s6e63m0_of_match);
>>> +
>>> +static struct spi_driver s6e63m0_driver = {
>>> +	.probe			= s6e63m0_probe,
>>> +	.remove			= s6e63m0_remove,
>>> +	.driver			= {
>>> +		.name		= "panel-samsung-s6e63m0",
>>> +		.of_match_table = s6e63m0_of_match,
>>> +	},
>>> +};
>>> +module_spi_driver(s6e63m0_driver);
>>> +
>>> +MODULE_AUTHOR("Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>");
>>> +MODULE_DESCRIPTION("s6e63m0 LCD Driver");
>>> +MODULE_LICENSE("GPL v2");
>>
>>
>
>
>
>
>

