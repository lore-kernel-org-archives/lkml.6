Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeDJMod (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:44:33 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57810 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeDJMoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:44:30 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180410124429epoutp03c3e4c4ef792e361065b4b73882650e91~kE7tJOy5V0588705887epoutp03w
X-AuditID: b6c32a39-579ff70000000ff4-1a-5accb1ac6cba
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 13/17] thermal: tegra: enable/check sensor after its setup
 is finished
Date: Tue, 10 Apr 2018 14:42:07 +0200
Message-id: <1523364131-31059-14-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG/TyXnc0mp2n6NVFwKKWRF0j70hSFgiMa9F9hkM48qeRlbCoq
        BqapOVIMoXLOa4k1FHXNpjbF+yo1qpmK2kUz8ZIXGGlaYG7H/nu+9/m97/O+8FGYSEmIqaTU
        dFaeKk2WkAL85aCX3+nm9rFov95Ne9T+uJVAS2YjQC2lwziqnZgkUN8dE0D7C2sEeqvPt0V3
        VQ04ero4z0OmbjWJzKVDAKk3Znlocb6MRMs6Z6R9Nk2i3e4aHPV8MYOwo0z+5gjJqL6Ok0yX
        6jOP6ZgJYJ4YVmwZraaEZOYmDSRTWrBBMmU6DWD0kzUY8/rRDs4Yp/W2jFnrdlkYLTgfzyYn
        ZbJy39BYQWJb8Xsgm6Gy2usWeHmgmacEfArSZ6DqYQdQAgElojsB3MtrJLnHDoDNW4YDh7JS
        E1UCS4OIfgVgW1EEx+wBuDw4TlgMkg6CD4o1Vt6RjoS6ZsrCYHQlDrfmhjEL40BfhYVjBdZk
        nPaE7U311rqQjoCV232HG7nBNyMV1pn8g/qfnk3CMgjSFTy4Vr1OctAF2P98COO0A1w16njc
        oi7w43AIxxcAuN1pOGTKATS0ijgdDAeNH6wBGG0PN37dJ7heIbxXdIgwsOlbPcHpcFjYZYmy
        HKwGcKq4AZQDcR2w0QAnVqZISWAV/rIAH4U0RZGRmuBzIy1FC6w/xPtcJxh5FzUAaApIjgjL
        +0ejRYQ0U5GdMgAghUkchcktY9EiYbw0O4eVp8XIM5JZxQBwoXCJs/BH1IFFJ0jT2VssK2Pl
        /11bii/OA6Huw+WxYqP/pcawv5XdwZPXdrI8+adijpvCob2dfc6x3dtXZKreXJmvsO1TyKq4
        y0WprbJZA+a9XNfvJS/qxVn+A06RpmVXEMbAlbjMk8RosIfdxVnZzRl1tb5WvaSLym8L+L1v
        t6458TOuI3DL4zo2L5ia8PXaH3PXBAadleCKRKm/NyZXSP8BlYGZsh0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t9jAd3VG89EGayax22xccZ6Votnn48z
        WqztPcpiMf/KNVaLA42XGS3+P3rNanFqexOTRcusRSwWS548ZLe4vGsOm8Xn3iOMFnPe3Wa3
        ePKwj83ixRZxi00rbrBZ/Nw1j8Vi773PjA6CHk3vj7F5zLp/ls1j56y77B5bb5l6LN7zkslj
        06pONo871/awefQ2v2Pz6NuyitFj+7V5zB4npn9n8Th+YzuTx+dNcgG8UVw2Kak5mWWpRfp2
        CVwZG9ovMBbc4qjYuOARewPjGvYuRg4OCQETiSuzuboYuTiEBHYySkw9+Iq1i5ETyPnFKNHw
        lRHEZhOwkpjYvooRpF5EwFtiyxoOkHpmgZksEm1Tn4LVCAtESDw//YsFxGYRUJXYuHwhM4jN
        K+ApMfPbAXYQW0JATuLksclg8zmB4r/3vmcFmSkk4CHxbYr1BEaeBYwMqxglUwuKc9Nzi40K
        DPNSy/WKE3OLS/PS9ZLzczcxAgN+22Gtvh2M95fEH2IU4GBU4uGdcPB0lBBrYllxZe4hRgkO
        ZiUR3py1Z6KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ897OOxYpJJCeWJKanZpakFoEk2Xi4JRq
        YGTNX76zvNnDNNGuzOndLi5+Hlt2/+n8l6Z5LOL40f4+sVJ+f7C86seEBf137SsdTsy3E/z3
        yNmS4e3JW/cs9XNaPk6RmLn6u/vaZadufih5wxK9PfKEa/jTXau9FTyWXTXdpi789PKNXcUP
        1RofKx8U53k719XKhF0xN33uA/aMB5KylSITVimxFGckGmoxFxUnAgB6hSNAdAIAAA==
X-CMS-MailID: 20180410124427epcas1p371389bc9fdfa2f1582950b68a9121caf
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180410124427epcas1p371389bc9fdfa2f1582950b68a9121caf
X-RootMTR: 20180410124427epcas1p371389bc9fdfa2f1582950b68a9121caf
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124427epcas1p371389bc9fdfa2f1582950b68a9121caf@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable/check sensor after setting zone->tz and programming hwtrips.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/tegra/soctherm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 9554613..81784b8 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1400,9 +1400,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 		}
 
-		thermal_zone_device_toggle(z, true);
-		thermal_zone_device_check(z);
-
 		zone->tz = z;
 		tegra->thermctl_tzs[soc->ttgs[i]->id] = z;
 
@@ -1410,6 +1407,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		err = tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
 		if (err)
 			goto disable_clocks;
+
+		thermal_zone_device_toggle(z, true);
+		thermal_zone_device_check(z);
 	}
 
 	soctherm_debug_init(pdev);
-- 
1.9.1
