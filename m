Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeDJMot (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:44:49 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23352 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753821AbeDJMop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:44:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180410124444epoutp02a167dfe5b9f019aa8e9e9e521940af27~kE77JbbEw0173301733epoutp02a
X-AuditID: b6c32a37-575ff70000000fe6-50-5accb1bbdeb8
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
Subject: [PATCH 15/17] thermal: uniphier: enable/check sensor after its
 setup is finished
Date: Tue, 10 Apr 2018 14:42:09 +0200
Message-id: <1523364131-31059-16-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTURjHPd6XXYer2xQ9KEgMgjLUxKJTmWUI3dQoSPpghY28qbWp7PqS
        QWFaltLUMEjnUrMw02SpK92caPNl+Rb4kkhpm6WlWSpNE60otzu//Z7z/M75Pw8cChPnEV5U
        QmIKq0iUyiSkEH/VsSPAr6W+P3pX7aoPqi/WEOiL1QRQnbILR+UjowRqvzEM0L9PcwTqbcpy
        RjdVlTh6MjUpQMN6NYmsyk6A1PMfBGhqMp9EM1pP1FA9RqJVfRmOWj9aweEtTNZCN8mozAMk
        o1NNCJiX7/cwjw2zzkxDTS7JjI8aSEaZPU8y+doawDSNlmHMmwcrOGMaa3JmrA0+J0XRwuBY
        VpaQxioCQs4L45/mdIPkBZcrA4/MIBM0UnnAhYL0bjjUvgjygJAS080AzpS2Y3yxAqC56q9g
        w1I9rHVYLQAuq38QfLEGYFG5HrNZJL0f3rtds25RlDsdAbXPKZuD0SU4XBzvsjtu9Bn4ObtY
        YHNwehuc7d1qQxF9DJZY5HyWD+zpLiJs7LJ+/Lt1wR4F6QIBHCyYdwwUBjMtVYBnN/jNpLU/
        CWlvONR1kPezAfzVbMB4pxBAg0bM8wHYYRq0B2D0Jji/fJfg74rgnRyHwkBL0TOc51A4W1Lt
        2F0NoM6oxwqBVwVwqgEebDInj2O5wOQgf04q51IT4/wvJMkbgP2H+O5tBi/eRhoBTQGJq6jw
        dV+0mJCmcRlyI4AUJnEXyer6o8WiWGnGVVaRFKNIlbGcEXhTuMRTNB253qLjpCnsZZZNZhUb
        XWfKxSsTFOfdr67Mumja6dkTXjEyq9Z6zmCngiM7l9mo0ydk4NbPqDBX0xJClszrMdRcytn0
        d/ty9PpppXBzLRuy/VqGyG+y73u8TjMoLE3TM+bwfB/l0f5DHo1BS2uXrH8UoUcqNOlfuXHN
        8Zm2eie3CCI3tVPddq5TV6SYiKWlaWMSnIuXBvpiCk76H+Gi62AdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t9jAd1dG89EGVztMrTYOGM9q8Wzz8cZ
        Ldb2HmWxmH/lGqvFgcbLjBb/H71mtTi1vYnJomXWIhaLJU8esltc3jWHzeJz7xFGiznvbrNb
        PHnYx2bxYou4xaYVN9gsfu6ax2Kx995nRgdBj6b3x9g8Zt0/y+axc9Zddo+tt0w9Fu95yeSx
        aVUnm8eda3vYPHqb37F59G1Zxeix/do8Zo8T07+zeBy/sZ3J4/MmuQDeKC6blNSczLLUIn27
        BK6M5W3HGAvec1acXXifsYFxM0cXIyeHhICJxKy5qxm7GLk4hAR2MkocOHCKDcL5xShx4sA7
        dpAqNgEriYntq4CqODhEBLwltqzhAKlhFpjJItE29SkjSI2wQLTE3olHWUBqWARUJV6eUgAx
        eQU8JWY+yIXYJSdx8thkVhCbEyj8e+97VpASIQEPiW9TrCcw8ixgZFjFKJlaUJybnltsVGCY
        l1quV5yYW1yal66XnJ+7iREY8NsOa/XtYLy/JP4QowAHoxIP74SDp6OEWBPLiitzDzFKcDAr
        ifDmrD0TJcSbklhZlVqUH19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwenVANj
        7NH8lg3P3tUtamMVj3cunbpH/Rz/7nktjxc7PpL0mZFVtEqLSVnGdH1Py7vJJ0qF/h26Fzd1
        f1fLwfUc+jmtLcL79RN+Fd/63NSxUXF5GWPolWlKxRpN96I1f82QDWiQX5jb6bhAu1nE4+XS
        hNiHzdP8r73jFTcN0/Y/fCdqrQyz3r/iw7OUWIozEg21mIuKEwE/0NNtdAIAAA==
X-CMS-MailID: 20180410124442epcas1p1b9d69f57eb25cc4dc69ebd7e85479036
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180410124442epcas1p1b9d69f57eb25cc4dc69ebd7e85479036
X-RootMTR: 20180410124442epcas1p1b9d69f57eb25cc4dc69ebd7e85479036
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124442epcas1p1b9d69f57eb25cc4dc69ebd7e85479036@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sensor after checking trip points (unipher_tm_enable_sensor()
enables IRQ so we need to toggle sensor before calling it) and check
sensor after doing chipset specific enable sensor operation.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/uniphier_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 8070747..cdecccd 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -307,9 +307,6 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(tdev->tz_dev);
 	}
 
-	thermal_zone_device_toggle(tdev->tz_dev, true);
-	thermal_zone_device_check(tdev->tz_dev);
-
 	/* get trip points */
 	trips = of_thermal_get_trip_points(tdev->tz_dev);
 	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
@@ -332,8 +329,12 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	thermal_zone_device_toggle(tdev->tz_dev, true);
+
 	uniphier_tm_enable_sensor(tdev);
 
+	thermal_zone_device_check(tdev->tz_dev);
+
 	return 0;
 }
 
-- 
1.9.1
