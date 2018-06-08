Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 256yDkupGlu9RQAAmS7hNA
	; Fri, 08 Jun 2018 16:06:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 11965607DC; Fri,  8 Jun 2018 16:06:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TkHBSsnH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EDDC6607A4;
	Fri,  8 Jun 2018 16:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDDC6607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeFHQGS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:06:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55833 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeFHQGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:06:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180608160612euoutp02e8e47f34fcd7b26041e2af51c9aa7be0~2OvrpduDV2790427904euoutp02M;
        Fri,  8 Jun 2018 16:06:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180608160612euoutp02e8e47f34fcd7b26041e2af51c9aa7be0~2OvrpduDV2790427904euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528473972;
        bh=7IdCQIVswN0EoPlY110aQoEaYF9RC9SpFmcmhqTiYtE=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=TkHBSsnHuO0JJWJr+gvBhlBU6Q+XiFTYEHdBs7ugNfew/zqmEpfXmpXbgspyLMWo4
         94Xyh9ma+0uJWUPzep8WjVh6hG0jzGOeC93I8RVxp4B1bhI91AcQAwU43pOwnX51sM
         Yrq31lwfii4YcdMSKklFUHWBZR0F+aGUH/cQ6/pk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180608160610eucas1p12c2bc8f46f72bf4e158e73f3cb569481~2OvpHYyKG0748707487eucas1p1R;
        Fri,  8 Jun 2018 16:06:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 56.81.10409.079AA1B5; Fri,  8
        Jun 2018 17:06:08 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180608160607eucas1p25cf1af748ac2790edfdf67776192e7f1~2OvmUGhEV1185011850eucas1p2R;
        Fri,  8 Jun 2018 16:06:07 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-e3-5b1aa9701191
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.C6.04183.F69AA1B5; Fri,  8
        Jun 2018 17:06:07 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PA000L4OI26SA10@eusync1.samsung.com>; Fri, 08 Jun
        2018 17:06:07 +0100 (BST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fb_omap: add gpiolib dependency
Date: Fri, 08 Jun 2018 18:06:06 +0200
Message-id: <2141120.Yc9aKbDC23@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180530214938.1073749-1-arnd@arndb.de>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7djP87oFK6WiDS48MLH4O+kYu8WVr+/Z
        LE70fWC1uLxrDpvF7CX9LBbr599ic2Dz+P1rEqPH/e7jTB7Hb2xn8vi8SS6AJYrLJiU1J7Ms
        tUjfLoEr40jHI8aCBvGKtc9esTcwfhDpYuTkkBAwkVjRfIixi5GLQ0hgBaPE/mePmSGcz4wS
        UyasZ4Wp+tJ1kAkisYxRYtf0f+wQzm9Gif7dN9hBqtgErCQmtq9iBLFFBBQlpr54BjaKGaTj
        yemTYEXCQKNW/fzLBGKzCKhKvHy9ia2LkYODV0BTYkFvKkhYVMBLYsu+drASTgFTidXTd4HN
        5BUQlPgx+R4LiM0sIC+xb/9UVghbR+LssXVgP0gIbGCTWHb2KRvE2S4Sfx+eZ4awhSVeHd/C
        DmHLSFye3M0C0TCdUeLNr6VQznpGiTVnjjFBVFlLHD5+EWoFn8SkbdOZQS6VEOCV6GgTgijx
        kPi5/iErJCg6GCUWP/vJMoFRZhaSa2chuXYWkmsXMDKvYhRPLS3OTU8tNs5LLdcrTswtLs1L
        10vOz93ECEwAp/8d/7qDcd+fpEOMAhyMSjy8DU1S0UKsiWXFlbmHGCU4mJVEeJ8pAYV4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzxmnURQkJpCeWpGanphakFsFkmTg4pRoYEzqvN7x/dZMnUM1+
        y8RZ5taPPNVqGWTXsJ5PktsQWtr2YDKrxHkm118cd9IFc7VKwn+U5Nrse7GrVcunqtWowJgh
        scz3T5DwgpzXNlFqWq0hH6/NCvhmLW/dkryhRWnSa2V/GzX5q5kmWx7MfbzOWmKpRg7Pcr8n
        1Xd+tazul9Gd/GLb5+1KLMUZiYZazEXFiQCYv06//AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xy7r5K6WiDT52MVv8nXSM3eLK1/ds
        Fif6PrBaXN41h81i9pJ+Fov182+xObB5/P41idHjfvdxJo/jN7YzeXzeJBfAEsVlk5Kak1mW
        WqRvl8CVcaTjEWNBg3jF2mev2BsYP4h0MXJySAiYSHzpOsjUxcjFISSwhFFidsMrZpCEkMBf
        RonHr3hAbDYBK4mJ7asYQWwRAUWJqS+eMYM0MAssY5T4/v4WK0hCGGjSqp9/mUBsFgFViZev
        N7F1MXJw8ApoSizoTQUJiwp4SWzZ1w5WwilgKrF6+i5GiMVdjBL/fl9kA0nwCghK/Jh8jwXE
        ZhaQl9i3fyorhK0lsX7ncaYJjPyzkJTNQlI2C0nZAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ
        +bmbGIGBu+3Yzy07GLveBR9iFOBgVOLhbWiSihZiTSwrrsw9xCjBwawkwvtMCSjEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmc97xBZZSQQHpiSWp2ampBahFMlomDU6qBMe48b86JB1sbuitX/TT8
        vsJ278qSQ9zmCqHmAkZP39+6aFCjW9RyXfOrsFroS413zWXndkp99eXcx7MpcCv/14zJnzbx
        C024seu/OPe88OcrWiJ1e03fzOa3Kgm+t2TPtYtGHaUnLm+r3l3jI/nsfSFzxqSkGtZLr1oX
        8BilbXr0n6UyJa+yVImlOCPRUIu5qDgRAIsZLzhYAgAA
X-CMS-MailID: 20180608160607eucas1p25cf1af748ac2790edfdf67776192e7f1
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530214948epcas1p43ed1ac72bc8959b7bf0f21220c48e96d
References: <CGME20180530214948epcas1p43ed1ac72bc8959b7bf0f21220c48e96d@epcas1p4.samsung.com>
        <20180530214938.1073749-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 30, 2018 11:49:22 PM Arnd Bergmann wrote:
> Building the omap sub-drivers when CONFIG_GPIOLIB is disabled causes
> lots of build failures, either from using gpiolib interfaces, or from
> including the wrong headers:
> 
> drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c: In function 'opa362_enable':
> drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c:101:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_enable':
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:86:2: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_probe_pdata':
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:189:23: error: implicit declaration of function 'gpio_to_desc'; did you mean 'irq_to_desc'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_probe_of':
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:210:9: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_gpio_request_one'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c: In function 'sharp_ls_enable':
> drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c:120:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c: In function 'lb035q02_enable':
> drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c:170:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c: In function 'hdmi_probe_of':
> drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c:584:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c: In function 'hdmi_probe_of':
> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:554:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]
> 
> Rather than fixing up each one individually, this just marks all of it
> as depending on GPIOLIB.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.18 (w/ fb_omap->fb_omap2 fixed in the patch title), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
