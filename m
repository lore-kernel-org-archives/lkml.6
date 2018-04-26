Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932081AbeDZL5O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:57:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21273 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755973AbeDZLwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:16 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180426115215epoutp03b14be3c332b5b5c59e4c7aceff5f3573~o_iqv0zYj2180121801epoutp03M
X-AuditID: b6c32a47-bdfff70000001011-af-5ae1bd6ee72b
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 06/18] thermal: exynos: fix trips limit checking in
 get_th_reg()
Date: Thu, 26 Apr 2018 13:51:21 +0200
Message-id: <1524743493-28113-7-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCmqW7e3odRBjdPqFlsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcePFK9aCnRwVvRMaWBsYm9m7GDk5JARMJDY+P83cxcjFISSwg1Hix5KNbBDOd0aJ
        Ndd+MMNUXT8/lR0isYFRYsqKfSwQzi9GiZtXHjCBVLEJWElMbF/FCGKLCGhJnLi0nQmkiFlg
        DqPErIbdQB0cHMICQRL/n8WD1LAIqEpsn9nLAmLzCnhItDd9YYXYJidx8thkMJtTwFPiwpEm
        sGUSAn9ZJfa3vWAEmSMh4CIx+UoaRL2wxKvjW6D+kZZ4tmojI0R9M6PEtx17oF6YwCixZ70Q
        hG0tcfj4RbAFzAJ8Eh2H/7JDzOSV6GiDKvGQuN69DyrsKNE/NwXiX6BXLsx6zDyBUWoBI8Mq
        RrHUguLc9NRiowJjveLE3OLSvHS95PzcTYzgCNRy38G47ZzPIUYBDkYlHt6AhQ+ihFgTy4or
        cw8xSnAwK4nwxrc+jBLiTUmsrEotyo8vKs1JLT7EKM3BoiTO2+B7JkpIID2xJDU7NbUgtQgm
        y8TBKdXAKPbg2cqlH5esd7+57OLTYPkjYZpWRldNZ5wQ/v+y4Db/ofwzv5mKuVPcDrAe1am6
        7/GTKWXeiVmMd2JZVtnksyxrdTns/ilcOnZdqerdyev45trbaNm2rYiM63j+YMtmDcHfEVIT
        bVXZM+/H3Xo98ZWClvbWMN1tX71yZoQqXF7LXXicc3q0iBJLcUaioRZzUXEiAAKYWVa8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xoG7e3odRBreXsVtsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcePFK9aCnRwVvRMaWBsYm9m7GDk5JARMJK6fnwpkc3EICaxjlHj0/zYrSEJI4Bej
        xKvzWSA2m4CVxMT2VYwgtoiAlsSJS9uZQBqYBeYwSjxfMYcJJCEsECDRdvUxmM0ioCqxfWYv
        C4jNK+Ah0d70hRVim5zEyWOTwWxOAU+JC0eaWCCWeUjc73vPNoGRZwEjwypGydSC4tz03GKj
        AqO81HK94sTc4tK8dL3k/NxNjMCQ2XZYq38H4+Ml8YcYBTgYlXh4AxY+iBJiTSwrrsw9xCjB
        wawkwhvf+jBKiDclsbIqtSg/vqg0J7X4EKM0B4uSOC9//rFIIYH0xJLU7NTUgtQimCwTB6dU
        A2N8iVtuRa7n1PKVK6eePLTi3YJ5d4xMNNgLJ00/I/rn86Hj277xK6m1+6Rvv/buW1zHquvM
        ejJsXxrvmqz9YrP/6PSLTouLLudPPKxveeZKyovKo6uU7ir75q7QfiIYz7npwRWx+4wHL0w+
        cvVxxz2V0AXv17UVPDFZamPWVTCr1Erzb1Z1+WoHJZbijERDLeai4kQAfUXgKhUCAAA=
X-CMS-MailID: 20180426115214epcas2p33003bbbe84310405c6871853f0df40e3
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115214epcas2p33003bbbe84310405c6871853f0df40e3
X-RootMTR: 20180426115214epcas2p33003bbbe84310405c6871853f0df40e3
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115214epcas2p33003bbbe84310405c6871853f0df40e3@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_thermal_get_ntrips() may return value bigger than supported
by a given SoC (i.e. on Exynos5422/5800) so fix the code to not
iterate the loop for i values >= data->ntrip.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5a64879..58cd68e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -311,9 +311,9 @@ static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(tz);
 	unsigned long temp;
-	int i;
+	int i, ntrips = min_t(int, of_thermal_get_ntrips(tz), data->ntrip);
 
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
+	for (i = 0; i < ntrips; i++) {
 		if (trips[i].type == THERMAL_TRIP_CRITICAL)
 			continue;
 
-- 
1.9.1
