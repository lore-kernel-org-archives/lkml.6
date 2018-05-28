Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938259AbeE1L3U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:29:20 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42007 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938132AbeE1L3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:29:12 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180528112910euoutp027cd95f7b7d3d561a7e4a75d818650c47~yy3py49bT3108431084euoutp02T
X-AuditID: cbfec7f5-b5fff700000028a9-24-5b0be80403a8
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 10/19 v3] regulator: s2mps11: Pass descriptor instead of
 GPIO number
Date: Mon, 28 May 2018 13:29:07 +0200
Message-id: <2026891.KGZ2uNuXyI@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CACRpkdZFrFuNnP=uJyREckr8EXW6L2ku+=QwVA7Tva3CpfrpCQ@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djP87osL7ijDeZds7aY+vAJm8X1L89Z
        Lc6f38Bu8e1KB5PFlD/LmSwu75rDZnFxxRcmB3aPnbPusntsWtXJ5nHn2h42j74tqxg9Pm+S
        C2CN4rJJSc3JLEst0rdL4MpY1yVW0ClSMfH5O8YGxtMCXYycHBICJhLTVyxnBbGFBFYwSny7
        6NXFyAVkf2aUeNLSyghT1HewjxkisYxR4tiCRnYI5zejxM5zm9hAqtgErCQmtq8C6xAR0JHo
        3vaTFaSIWeAfo8TbX2vYQRLCAlESq39eBytiEVCV+NC4kwnE5hXQlHi/qQMsLirgJbFlXztY
        nFMgWKJ113moGkGJH5PvsYDYzALyEvv2T2WFsHUkzh5bxwiyTEJgC5vEuwkf2SHudpFYeuk5
        C4QtLPHq+BaouIxEZ8dBJoiGfkaJn41/oJwZjBKrtyxngqiyljh8/CLUCj6JSdumA0OAAyjO
        K9HRJgRR4iGx8vJzJkhYNDBJfD+whmUCo8wsJNfOQnLtLCTXLmBkXsUonlpanJueWmycl1qu
        V5yYW1yal66XnJ+7iRGYEk7/O/51B+O+P0mHGAU4GJV4eBt+c0ULsSaWFVfmHmKU4GBWEuHl
        0gUK8aYkVlalFuXHF5XmpBYfYpTmYFES543TqIsSEkhPLEnNTk0tSC2CyTJxcEo1MC4t2MnG
        sTF6x6RedwfTFe0+33+kLbhjzX525Z4FxxcEz9T8ULFTKTmt5vrPG0wzss9u31f7kXX7V1+P
        GWLd7/Rj7Szjt+beYlKJqvZmu/WvwutH3L6+xbf3feIrdb/E/9Bk5r81CxVObwic92z9YlVe
        ZW/mIgmGrXwX3oWGSpRMjl1cH7zwX7wSS3FGoqEWc1FxIgA4F32GBQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t/xq7osL7ijDeYtZreY+vAJm8X1L89Z
        Lc6f38Bu8e1KB5PFlD/LmSwu75rDZnFxxRcmB3aPnbPusntsWtXJ5nHn2h42j74tqxg9Pm+S
        C2CN4rJJSc3JLEst0rdL4MpY1yVW0ClSMfH5O8YGxtMCXYycHBICJhJ9B/uYQWwhgSWMEoub
        U7oYuYDsv4wS235dZwFJsAlYSUxsX8UIYosI6Eh0b/vJClLELPCPUeJV2z12kISwQJTE6p/X
        wYpYBFQlPjTuZAKxeQU0Jd5v6gCLiwp4SWzZ1w4W5xQIlpjWvAlq8xpGifUfsyHqBSV+TL4H
        tphZQF5i3/6prBC2lsT6nceZJjDyz0JSNgtJ2SwkZQsYmVcxiqSWFuem5xYb6hUn5haX5qXr
        JefnbmIEhvK2Yz8372C8tDH4EKMAB6MSD2/Db65oIdbEsuLK3EOMEhzMSiK8XLpAId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYysT3fc8IjQbfizsDtY
        q93238Jyi9TrXp1zTkVkRqzj2+TpU/x4cdxBxekp+fU7ruXEvN2w9tsk0btmfecCpcTW6Dqe
        Obtnz1ve3X99DyTNNBG2cH7yXlDgWtWDuUt+CQvkRYkzvvvL4f036cfuHYEsX3d/aWH40vHb
        /vGjr1vT53WYdr/OUF2mxFKckWioxVxUnAgA5jJHgmECAAA=
X-CMS-MailID: 20180528112908eucas1p2946a9b6385fcaf6c19921c9767420405
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528112908eucas1p2946a9b6385fcaf6c19921c9767420405
References: <20180514080640.12515-1-linus.walleij@linaro.org>
        <20180526100243.GA1564@sirena.org.uk>
        <CACRpkdZFrFuNnP=uJyREckr8EXW6L2ku+=QwVA7Tva3CpfrpCQ@mail.gmail.com>
        <CGME20180528112908eucas1p2946a9b6385fcaf6c19921c9767420405@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

On Monday, May 28, 2018 10:41:31 AM Linus Walleij wrote:
> On Sat, May 26, 2018 at 12:02 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, May 14, 2018 at 10:06:31AM +0200, Linus Walleij wrote:
> >> Instead of passing a global GPIO number for the enable GPIO, pass
> >> a descriptor looked up with the standard devm_gpiod_get_optional()
> >> call.
> >>
> >> This regulator supports passing platform data, but enable/sleep
> >> regulators are looked up from the device tree exclusively, so
> >> we can need not touch other files.
> >
> > This seems to have broken the boot on Odroid XU3 so I'm going to revert
> > it:
> >
> > https://storage.kernelci.org/next/master/v4.17-rc6-9523-g47b9cef0672d/arm/multi_v7_defconfig/lab-baylibre-seattle/boot-exynos5422-odroidxu3.html
> 
> How annoying. I will check with a colleague who might have this
> board so I can test it on hardware.

I've reproduced the problem on TM2e board and the patch below fixes
it (old code always initialized the structure, new code does it only
in case GPIO properties are provided).

I've also tested the new code (with fixup) on Artik5 board (which
actually uses GPIO properties) and discovered the other problem,
the GPIO core code doesn't handle shared GPIOs which are used by
many platforms.

Old code:
[    1.094950] s2mps11-pmic s2mps14-regulator: Using GPIO 21 for ext-control over 10/LDO11
[    1.095210] s2mps11-pmic s2mps14-regulator: Using GPIO 21 for ext-control over 11/LDO12

New code (with fixup):
[    1.114288] s2mps11-pmic s2mps14-regulator: Using GPIO for ext-control over 10/LDO11
[    1.143209] s2mps11-pmic s2mps14-regulator: Failed to get control GPIO for 11/LDO12

[ It fails with -EBUSY on gpiod_request() in gpiod_get_from_of_node(). ]

Therefore it seems that more work is needed before s2mps11 driver
can be converted to use GPIO descriptors.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Index: b/drivers/regulator/s2mps11.c
===================================================================
--- a/drivers/regulator/s2mps11.c	2018-05-28 10:53:58.121322472 +0200
+++ b/drivers/regulator/s2mps11.c	2018-05-28 11:33:38.613382421 +0200
@@ -1147,7 +1147,7 @@ static int s2mps11_pmic_probe(struct pla
 		return -EINVAL;
 	}
 
-	s2mps11->ext_control_gpiod = devm_kmalloc(&pdev->dev,
+	s2mps11->ext_control_gpiod = devm_kzalloc(&pdev->dev,
 			sizeof(*s2mps11->ext_control_gpiod) * rdev_num,
 			GFP_KERNEL);
 	if (!s2mps11->ext_control_gpiod)
