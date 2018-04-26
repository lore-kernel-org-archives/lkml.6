Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756292AbeDZL4c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:56:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:48648 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755433AbeDZLwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:18 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180426115216epoutp02cc6f4b12b5683f8a42eab6a33e4e6aa7~o_iseQu1f1528215282epoutp02w
X-AuditID: b6c32a36-b55ff70000001027-07-5ae1bd708f43
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 07/18] thermal: exynos: remove threshold_code checking from
 exynos4210_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:22 +0200
Message-id: <1524743493-28113-8-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmnm7B3odRBu9uGlpsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcW/iLZaCR5wVi47sZ2xgnM7RxcjJISFgIvHsyEWWLkYuDiGBHYwSq8+9ZoZwvjNK
        7Dq5nhGm6t2ZdawgtpDABkaJ7oXCEEW/GCU2P9vBBpJgE7CSmNi+CqxBREBL4sSl7UwgRcwC
        cxglZjXsZgFJCAtkSix4NBFsEouAqkT/1oVgzbwCHhJbjr1gg9gmJ3Hy2GSwGk4BT4kLR5rA
        7pMQ+MsqMeHudnaIIheJ3j09zBC2sMSr41uA4hxAtrTEpaO2EPXNjBLfduyBqpnAKLFnvRCE
        bS1x+PhFsAXMAnwS7772sEL08kp0tEGVeEjsuDcJqtVR4tbdH9BgAXqm79dktgmMUgsYGVYx
        iqUWFOempxYbFhjpFSfmFpfmpesl5+duYgTHoJbZDsZF53wOMQpwMCrx8AYsfBAlxJpYVlyZ
        e4hRgoNZSYQ3vvVhlBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHepz5nooQE0hNLUrNTUwtSi2Cy
        TBycUg2MmbFZj+oMdhZL9Qb7m//Y8uXzjtcV2XGzPhyWrPv4+QD7n4Q9f5v8Agz7a34EXD/8
        JUxN73nS7pAN51dnTFvuyla64un6jgNVCZzvFPnYJH53R7FMUk6TXlgmosQrtcxZ9Zj0rj83
        d7gacvFMndsQuLh3p7Bm+qYMk4jJH8K0wzfpW/2K2ftTiaU4I9FQi7moOBEAqOfhSL0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xoG7B3odRBu/+K1tsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcW/iLZaCR5wVi47sZ2xgnM7RxcjJISFgIvHuzDpWEFtIYB2jxKe9JV2MXED2L0aJ
        s1NXMoIk2ASsJCa2rwKzRQS0JE5c2s4EUsQsMIdR4vmKOUwgCWGBTIkFjyaCTWIRUJXo37qQ
        DcTmFfCQ2HLsBRvENjmJk8cmg9VwCnhKXDjSxAKx2UPift97tgmMPAsYGVYxSqYWFOem5xYb
        FRjmpZbrFSfmFpfmpesl5+duYgSGzLbDWn07GO8viT/EKMDBqMTDG7DwQZQQa2JZcWXuIUYJ
        DmYlEd741odRQrwpiZVVqUX58UWlOanFhxilOViUxHlv5x2LFBJITyxJzU5NLUgtgskycXBK
        NTA2z94RkH0/5QbvpM5XgYXrH53zudjmNv1sw8cTDzYUPXYsMotdnfzl0ZXrdlkzDP7rXVs4
        m7196xzDmlxvlt/v9vFr+6yuUfI6W57TzJ9w+o2gh6VuKcPDpZLR/PoJNzfO1L681rByZYWA
        0KJtNafi1KLm7k6o8Al3y1h964zPyp7kxbLrZjYosRRnJBpqMRcVJwIAK/daHBUCAAA=
X-CMS-MailID: 20180426115216epcas1p3ed61f0fd8563e7ea72f3d7d17c9c039f
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180426115216epcas1p3ed61f0fd8563e7ea72f3d7d17c9c039f
X-RootMTR: 20180426115216epcas1p3ed61f0fd8563e7ea72f3d7d17c9c039f
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115216epcas1p3ed61f0fd8563e7ea72f3d7d17c9c039f@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Exynos4210 one-point trimming is always used and data->temp_error1
is equal to 75. Therefore temp_to_code() will never return negative
value for the reference temperature conversion.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 58cd68e..26a0cb9 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -423,10 +423,6 @@ static int exynos4210_tmu_initialize(struct platform_device *pdev)
 	/* Write temperature code for threshold */
 	reference = trips[0].temperature / MCELSIUS;
 	threshold_code = temp_to_code(data, reference);
-	if (threshold_code < 0) {
-		ret = threshold_code;
-		goto out;
-	}
 	writeb(threshold_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 
 	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
@@ -436,7 +432,7 @@ static int exynos4210_tmu_initialize(struct platform_device *pdev)
 	}
 
 	data->tmu_clear_irqs(data);
-out:
+
 	return ret;
 }
 
-- 
1.9.1
