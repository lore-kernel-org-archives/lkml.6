Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756273AbeDZLxF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:53:05 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48466 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756078AbeDZLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:39 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180426115237epoutp0198bdcb4ef69fef09acb7dddf57cdda61~o_i-_F3_Q0449504495epoutp01K
X-AuditID: b6c32a46-15dff70000001024-d9-5ae1bd858040
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 15/18] thermal: exynos: check return values of
 ->get_trip_[temp,hyst] methods
Date: Thu, 26 Apr 2018 13:51:30 +0200
Message-id: <1524743493-28113-16-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCmuW7r3odRBof/CFhsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CV8ffUF6aCjVwVV87eYW1g3MHRxcjJISFgIjH/xVbWLkYuDiGBHYwSTT92MUI43xkl
        Hs2bwghT9f7gbXaIxAZGiUvrT7FBOL8YJbrm/GIGqWITsJKY2L4KrENEQEvixKXtTCBFzAJz
        GCVmNexmAUkIC8RL9C44wQ5iswioSrTd+sIKYvMKeEq8Xv2EHWKdnMTJY5PB4pxA8QtHmlhA
        BkkI/GWV6Jn5hhWiyEWia0sLG4QtLPHq+BaoZmmJZ6s2MkI0NDNKfNuxhxkiMYFRYs96IQjb
        WuLw8Ytgg5gF+CQ6Dv8FauYAivNKdLRBlXhI9P+YyARhO0qsub4ErFwI5JtlX/MnMEotYGRY
        xSiWWlCcm55abFRgpFecmFtcmpeul5yfu4kRHIVabjsYl5zzOcQowMGoxMMbsPBBlBBrYllx
        Ze4hRgkOZiUR3vjWh1FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeRt8z0QJCaQnlqRmp6YWpBbB
        ZJk4OKUaGCsTJJ5HnKuWvPFSOiCopmTD5F2BEf3hC8IfPeNVOf8ks3t+bJ/6WfeK0x947X/x
        2h35kVjs+GWnsEZVaPYLU5+KnodPn36WLv3nttrJ4coaO+fE3PU7db4u/2Wj1Do/Yee16riT
        rB3OnQsfX/A0y991WiTisM7eo7xiEXU/Mjzmr7e9dN7poBJLcUaioRZzUXEiAB4d5vO+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xoG7L3odRBufnqlpsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CV8ffUF6aCjVwVV87eYW1g3MHRxcjJISFgIvH+4G12EFtIYB2jxIeDkl2MXED2L0aJ
        61+nMoMk2ASsJCa2r2IEsUUEtCROXNrOBFLELDCHUeL5ijlMIAlhgXiJ3gUnwCaxCKhKtN36
        wgpi8wp4Srxe/YQdYpucxMljk8HinEDxC0eaWCA2e0jc73vPNoGRZwEjwypGydSC4tz03GKj
        AqO81HK94sTc4tK8dL3k/NxNjMCQ2XZYq38H4+Ml8YcYBTgYlXh4AxY+iBJiTSwrrsw9xCjB
        wawkwhvf+jBKiDclsbIqtSg/vqg0J7X4EKM0B4uSOC9//rFIIYH0xJLU7NTUgtQimCwTB6dU
        A6P9o/mHGVfdYf34QsF0q/4deasFAuKKfbdmBP207Y961lo7883UbrZljzZEJpuUaX0pWnWR
        US9ql2j/qtpI00rrI2tWRmk8O1O1YLZThea2q3cule9On6x4Lft8vNQngcfiR87/bVS7eGKp
        1RkpZjdhjn9e0kpKvrtP1Bw/rVDRwlwpwx7b3a/EUpyRaKjFXFScCACneU9rFQIAAA==
X-CMS-MailID: 20180426115236epcas2p3764927b3c23113fb4c3771b753a51199
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115236epcas2p3764927b3c23113fb4c3771b753a51199
X-RootMTR: 20180426115236epcas2p3764927b3c23113fb4c3771b753a51199
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115236epcas2p3764927b3c23113fb4c3771b753a51199@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check return values of ->get_trip_[temp,hyst] methods in
exynos_tmu_initialize().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 244aaf6..abe0737 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -357,19 +357,23 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		/* Write temperature code for rising and falling threshold */
 		for (i = 0; i < ntrips; i++) {
 			/* Write temperature code for rising threshold */
-			tzd->ops->get_trip_temp(tzd, i, &temp);
+			ret = tzd->ops->get_trip_temp(tzd, i, &temp);
+			if (ret)
+				goto err;
 			temp /= MCELSIUS;
 			data->tmu_set_trip_temp(data, i, temp);
 
 			/* Write temperature code for falling threshold */
-			tzd->ops->get_trip_hyst(tzd, i, &hyst);
+			ret = tzd->ops->get_trip_hyst(tzd, i, &hyst);
+			if (ret)
+				goto err;
 			hyst /= MCELSIUS;
 			data->tmu_set_trip_hyst(data, i, temp, hyst);
 		}
 
 		data->tmu_clear_irqs(data);
 	}
-
+err:
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 	if (!IS_ERR(data->clk_sec))
-- 
1.9.1
