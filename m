Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbeDJMng (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:43:36 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:52837 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeDJMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:43:32 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180410124329epoutp04111b9b120e16161c763c10f705687837~kE61NAZaQ0381603816epoutp04j
X-AuditID: b6c32a47-0fbff70000000fe8-96-5accb16f2f45
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
Subject: [PATCH 05/17] thermal: bcm2835: enable/check sensor after its setup
 is finished
Date: Tue, 10 Apr 2018 14:41:59 +0200
Message-id: <1523364131-31059-6-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUhTYRTGfbe7uztxepuSbwqWCyEl7cOslwwpM7phRf07lLzqTa1NbVct
        A/GzUvFjUlGKqZVgToc6pi6d5eZnU8tlmJgmS5Es0GSQqYi5D/973vP83vOcA4fgikp4XkRS
        chojT6alYtwZ6+jzPxmY0jYqOfppJAS1PW/hoUXLEECq0gEM1X6Z5KHe3AmAtn/85iFjZx4H
        FVS9wlD9gpmPJrqqcWQp7QeoevkbHy2Yy3D0U+OJ1G+mcLTeVYOhnu8WcHYPlbcyiFNVc2M4
        9bZqlk+1T4dQr3VLHEqtLMKpmUkdTpXmL+NUmUYJqM7JGi41/GwNo4amOjmURe1zTShxPhPP
        SJMyGPmRsBjnxNbxESx1i7hX0j2O54AxfjEQEJA8Aed6Gna0MyEitQBOdr3D7Y81AI0z7dxd
        qvFlE2Y3ugEsfNLs+LIB4PTsPG6lcPI0rHikBMWAIDzISKhpJqwMl6zE4J+ZAVsnd1ICl1XF
        PKvGSD84slFnqwtJClasluP2NB/4YfCxjRGQl+BmzwrPXi/nwz7VQbuOgMYFk2M6d/hrSOPY
        xxsuKtuANRiS+QD+1eockAJAXYvIrkNh35DJ1pRLusLCvi2+dWhICmHhQwdCQX1thyP3HPw3
        O+DYvhpA8/AwXwG86oCTEuxlUllZAsMeTw0OYmkZm56cEBSXIlMD240EXNSCjo+XDYAkgNhF
        qNCPSEQ8OoPNlBkAJLhiD6FUNSoRCePpzPuMPOWGPF3KsAbgTWBiT2HOlR2LTKDTmNsMk8rI
        d10OIfDKAfW+roZswf7om763/M/rWytJPeYbHpHUZji1Wa9dXYmNdi+4QLRfdynXN4pj6Kia
        KIsfx+2p+vCdz7P92YGHuumilvdxkVf3iRVh4V+z1nvdQhvuvjDHbpuEhnEJ3q+QNm5qAh+k
        5VbOj9MZWUumYCdjdxPKiRAUHehUSXyaxRibSB8L4MpZ+j9RSe2cHwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t9jAd38jWeiDCacYLfYOGM9q8Wzz8cZ
        Ldb2HmWxmH/lGqvFgcbLjBb/H71mtTi1vYnJomXWIhaLJU8esltc3jWHzeJz7xFGiznvbrNb
        PHnYx2bxYou4xaYVN9gsfu6ax2Kx995nRgdBj6b3x9g8Zt0/y+axc9Zddo+tt0w9Fu95yeSx
        aVUnm8eda3vYPHqb37F59G1Zxeix/do8Zo8T07+zeBy/sZ3J4/MmuQDeKC6blNSczLLUIn27
        BK6MDRdOsxT85ajo2X2BrYHxLHsXIyeHhICJxMqFq1m6GLk4hAR2Mkr869rJDuH8YpTYvvoB
        G0gVm4CVxMT2VYxdjBwcIgLeElvWcIDUMAvMZJFom/qUEaRGWCBKYtu2k2A2i4CqxOlfC5hB
        bF4BD4mJH/vZILbJSZw8NpkVxOYU8JT4vfc9K8hMIaCab1OsJzDyLGBkWMUomVpQnJueW2xU
        YJSXWq5XnJhbXJqXrpecn7uJERj02w5r9e9gfLwk/hCjAAejEg/vhIOno4RYE8uKK3MPMUpw
        MCuJ8OasPRMlxJuSWFmVWpQfX1Sak1p8iFGag0VJnJc//1ikkEB6YklqdmpqQWoRTJaJg1Oq
        gTGVsTVAK8xSdYXI6b8vPO31Dmu96a9fFjf5DKOG0t2ylLMxMb33guQmx/e/0DQr2P1l46pb
        G/Nt8lcdOxxvvYpfN+SdeO7iZXXCPYzMWw9N27c2rGTjzlw3hiUBvVZq8+cu3GKifrfWfr2H
        aM5ucX23Ldc8grJq2A8zKqVf/Wtxs6Jd+VdboBJLcUaioRZzUXEiAEtVU/t2AgAA
X-CMS-MailID: 20180410124327epcas2p1da6a39c2e0443b5b5ec575941f6255a7
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180410124327epcas2p1da6a39c2e0443b5b5ec575941f6255a7
X-RootMTR: 20180410124327epcas2p1da6a39c2e0443b5b5ec575941f6255a7
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124327epcas2p1da6a39c2e0443b5b5ec575941f6255a7@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable/check sensor after HW-block setup (if necessary) and setting
data->tz.

Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 1270e3f..d52c125 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -227,9 +227,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	thermal_zone_device_toggle(tz, true);
-	thermal_zone_device_check(tz);
-
 	/*
 	 * right now the FW does set up the HW-block, so we are not
 	 * touching the configuration registers.
@@ -276,6 +273,9 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	data->tz = tz;
 
+	thermal_zone_device_toggle(tz, true);
+	thermal_zone_device_check(tz);
+
 	platform_set_drvdata(pdev, tz);
 
 	bcm2835_thermal_debugfs(pdev);
-- 
1.9.1
