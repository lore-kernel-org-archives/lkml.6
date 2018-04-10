Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeDJMoJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:44:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53059 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753595AbeDJMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:44:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180410124403epoutp04c48ef5ee2c3eabdba2d7eb15257626e0~kE7U9cNrp0491204912epoutp04F
X-AuditID: b6c32a47-0fbff70000000fe8-d4-5accb1926aa6
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
Subject: [PATCH 10/17] thermal: rcar_gen3_thermal: enable/check sensor after
 its setup is finished
Date: Tue, 10 Apr 2018 14:42:04 +0200
Message-id: <1523364131-31059-11-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+3bOzo6zxWlK+9AwW/iHRl4q8cOiLIROWBBBF0ZUB3dQc17Y
        UckIMhWdztlURB1eQrs5MtPUTVNr3ubSrLBM1CzFRI28MNBuVs6j/z3f+/wenveFj8Sk2UI3
        Mio2gVXHMio5IcabOr2D9uXX9Sv8Cw3+qK64Voim7VaAanTdOKp4PyREL28PAvRv8psQvTKl
        ClC6oRJH96YmRGiwpZRAdl0XQKXzoyI0NZFLoJkGGap/NEygny3lOGobt4OQ7XTqQg9BGz6/
        JuhmwycR3TgSSFe1zgroemMWQY8NtRK0Lm2eoHMbjIA2DZVjdG/RCk5bh00C2l7vcUaiEB9W
        sqqoJFbtd+SqOHKofVIYn0lef2DzSwETRDZwIiF1EBZ9bcazgZiUUmYAqzVNQv6xAmDXnA1s
        Ui2WdAFvPAdQa9ZvUL8ArDKNYg6KoIJhXqZxLUGSrlQYbHhMOhiMKsHh4lg35pi7UEpYteTp
        kDjlBcuehTuSEuokHGxsFvJdHtDWU7Cundbmv9sW1qsgpRXB4eoSnIdCocHWvnGCC5yzNoh4
        7Q6njXWAD6QBuGxuxXhDD2BrrZTXh2Cn9d16A0Ztg5rOVZFjIUhJoCZjA6Hh4sydjegxqDdr
        Mf7eUgDf5Pwg9MDtLthiBDvYeC4mguX2xx/w5ZgYLjE2wjc8LqYerP8QnxNm0DRwqgNQJJBv
        legtfQqpkEnikmM6ACQxuatEVdOvkEqUTPINVh13RZ2oYrkO4E7icpkk5fSaRUUwCWw0y8az
        6k1XQDq5pQDxQE++8vgT85/o8aMZMkvqrqnAKOZWTsBSd96oRq0Luxz2wluhxJJHRhb3ejpr
        zxdM38c/7OHSLs71c1lhzpdkZcurT+NWdNTC0gVliPhvobYv0itIX3vW/RrzcfBtWolWu3tn
        brBfeEHGF0si8/1mZ7tM97C3IiS0+FzobKVKjnORTIAPpuaY/0QuabkdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsVy+t9jAd2JG89EGRy7ZmOxccZ6Votnn48z
        WqztPcpiMf/KNVaLA42XGS3+P3rNanFqexOTRcusRSwWS548ZLe4vGsOm8Xn3iOMFnPe3Wa3
        ePKwj83ixRZxi00rbrBZ/Nw1j8Vi773PjA6CHk3vj7F5zLp/ls1j56y77B5bb5l6LN7zkslj
        06pONo871/awefQ2v2Pz6NuyitFj+7V5zB4npn9n8Th+YzuTx+dNcgG8UVw2Kak5mWWpRfp2
        CVwZ1/Y9Yi1o56hYdlK/gfEhWxcjJ4eEgInEroMtTF2MXBxCAjsZJdomtjBDOL8YJX68/wVW
        xSZgJTGxfRVjFyMHh4iAt8SWNRwgNcwCM1kk2qY+BYsLC6RILP6oAGKyCKhKzN2cDNLJK+Ap
        cXnrTlaIXXISJ49NBrM5geK/975nBSkXEvCQ+DbFegIjzwJGhlWMkqkFxbnpucVGBUZ5qeV6
        xYm5xaV56XrJ+bmbGIHhvu2wVv8OxsdL4g8xCnAwKvHwTjh4OkqINbGsuDL3EKMEB7OSCG/O
        2jNRQrwpiZVVqUX58UWlOanFhxilOViUxHn5849FCgmkJ5akZqemFqQWwWSZODilGhh57GXq
        FBceVpnmEjHhpdVJ7qnnpasvRbxPuhD/kavg2U0ehsoYvy7NWedjrs3mlLh/ZUPHhvtLZ7Mc
        PyMp+fS+5aXL+7hibr/ZkL3u26U7On4iIj/udkwJef36XAan6Uvn+F/rY607ZEPPZTUwh6z6
        s6X9V3H1en3O31MOmLut59W59vpzl+JvJZbijERDLeai4kQABvtNH3MCAAA=
X-CMS-MailID: 20180410124402epcas2p25249fff958ca0f54094d43275ffa47a7
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180410124402epcas2p25249fff958ca0f54094d43275ffa47a7
X-RootMTR: 20180410124402epcas2p25249fff958ca0f54094d43275ffa47a7
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124402epcas2p25249fff958ca0f54094d43275ffa47a7@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable/check sensor after setting tsc->zone and checking ntrips.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 87061b1..98d418b 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -429,9 +429,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
-		thermal_zone_device_toggle(zone, true);
-		thermal_zone_device_check(zone);
-
 		tsc->zone = zone;
 
 		ret = of_thermal_get_ntrips(tsc->zone);
@@ -439,6 +436,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
+
+		thermal_zone_device_toggle(zone, true);
+		thermal_zone_device_check(zone);
 	}
 
 	priv->num_tscs = i;
-- 
1.9.1
