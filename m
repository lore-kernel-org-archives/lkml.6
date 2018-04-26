Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756129AbeDZL5y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:57:54 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21222 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755561AbeDZLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:07 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180426115205epoutp0316efdd6e41453f124651621d89b9c4f3~o_ih27oUi2180121801epoutp03H
X-AuditID: b6c32a45-8f3ff70000001020-37-5ae1bd65eb2d
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 02/18] thermal: exynos: always check for trips points
 existence
Date: Thu, 26 Apr 2018 13:51:17 +0200
Message-id: <1524743493-28113-3-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmqW7q3odRBi2fRS02zljPajH/yjVW
        i8u75rBZfO49wmgx4/w+JosnD/vYHNg8ds66y+6xeM9LJo++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKuNn/mr3ggVDF7tVNzA2Ms/m7GDk5JARMJD71LmTvYuTiEBLYwSix4dRHZgjnO6PE
        mfOfWWGqTi2ZzgZiCwlsYJR42qoLYf9ilNg+gQvEZhOwkpjYvooRxBYR0JI4cWk7E8ggZoE5
        jBKzGnazgCSEBQIl5s/9zwRiswioSnxbtIoZxOYV8JBonPQdapmcxMljk8FsTgFPiQtHmlhA
        BkkI/GSV2HfuHDNEkYvElzsdbBC2sMSr41vYIWxpiWerNjJCNDQzSnzbsQeqYQKjxJ71QhC2
        tcTh4xfBNjAL8El0HP4L1MwBFOeV6GiDKvGQ6N36jwnCdpSY1LuLBRIsQN8cP7+CdQKj1AJG
        hlWMYqkFxbnpqcVGBYZ6xYm5xaV56XrJ+bmbGMExqOW6g3HGOZ9DjAIcjEo8vAELH0QJsSaW
        FVfmHmKU4GBWEuGNb30YJcSbklhZlVqUH19UmpNafIhRmoNFSZy3wfdMlJBAemJJanZqakFq
        EUyWiYNTqoFxv/EDkfB5CUXld3ifmGcp5dnrWc+PqjxjdHvL6qJKpvv5p5kuSn89ttZ0VsLM
        rIu3K86E/v/wYVqV3q9J4TWG1qpyi51DPoh8dmudG5y1s2VC6rnApJzvuudDUl7f092hvrjh
        860szeQTMQ2zDZ1dHly7mCSQEN9xV1rO0jZRUGTfDZUPn/WUWIozEg21mIuKEwGC4v6SvQIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e+xoG7K3odRBk+/sVtsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcbP/NXvBA6GK3aubmBsYZ/N3MXJySAiYSJxaMp2ti5GLQ0hgHaPE0z/LmSCcX4wS
        K1fcZwapYhOwkpjYvooRxBYR0JI4cWk7WBGzwBxGiecr5jCBJIQF/CVubJsJVsQioCrxbdEq
        sGZeAQ+JxknfWSHWyUmcPDYZzOYU8JS4cKSJBcQWAqq53/eebQIjzwJGhlWMkqkFxbnpucVG
        BUZ5qeV6xYm5xaV56XrJ+bmbGIFBs+2wVv8OxsdL4g8xCnAwKvHwBix8ECXEmlhWXJl7iFGC
        g1lJhDe+9WGUEG9KYmVValF+fFFpTmrxIUZpDhYlcV7+/GORQgLpiSWp2ampBalFMFkmDk6p
        Bkb5tSKvd7JPd2NnmPjsQlhC2k72zyJKU+WOTW0OSjm2yGiasr/2Ea/9+/842bGoP7ApTDK2
        bvB/z8bLqyJmPLXKbELJFpMrnscFbZzPnOnu+x565Zaz0KOM7sqi7VYrzp13/xhk0pz1dnb2
        b1/B5+xnvb7bHokr9QhwV9YIuH/lP4+cn1OpsxJLcUaioRZzUXEiAFXl4JYWAgAA
X-CMS-MailID: 20180426115204epcas2p3a0b53d8b2bdd687b1acc19db98f30227
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115204epcas2p3a0b53d8b2bdd687b1acc19db98f30227
X-RootMTR: 20180426115204epcas2p3a0b53d8b2bdd687b1acc19db98f30227
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115204epcas2p3a0b53d8b2bdd687b1acc19db98f30227@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Check for trip points existence in exynos_tmu_initialize() so it is
  checked on all SoCs.

* Use dev_err() instead of pr_err().

* Fix dev_err() to reference "device tree" not "of-thermal.c".

* Remove no longer needed checks from exynos4210_tmu_initialize() and
  get_th_reg().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 523d26e..9e040eb 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -309,12 +309,6 @@ static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
 	unsigned long temp;
 	int i;
 
-	if (!trips) {
-		pr_err("%s: Cannot get trip points from of-thermal.c!\n",
-		       __func__);
-		return 0;
-	}
-
 	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
 		if (trips[i].type == THERMAL_TRIP_CRITICAL)
 			continue;
@@ -334,14 +328,23 @@ static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
 static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	struct thermal_zone_device *tzd = data->tzd;
+	const struct thermal_trip * const trips =
+		of_thermal_get_trip_points(tzd);
 	int ret;
 
-	if (of_thermal_get_ntrips(data->tzd) > data->ntrip) {
+	if (!trips) {
+		dev_err(&pdev->dev,
+			"Cannot get trip points from device tree!\n");
+		return -ENODEV;
+	}
+
+	if (of_thermal_get_ntrips(tzd) > data->ntrip) {
 		dev_info(&pdev->dev,
 			 "More trip points than supported by this TMU.\n");
 		dev_info(&pdev->dev,
 			 "%d trip points should be configured in polling mode.\n",
-			 (of_thermal_get_ntrips(data->tzd) - data->ntrip));
+			 (of_thermal_get_ntrips(tzd) - data->ntrip));
 	}
 
 	mutex_lock(&data->lock);
@@ -397,13 +400,6 @@ static int exynos4210_tmu_initialize(struct platform_device *pdev)
 	unsigned long reference, temp;
 	unsigned int status;
 
-	if (!trips) {
-		pr_err("%s: Cannot get trip points from of-thermal.c!\n",
-		       __func__);
-		ret = -ENODEV;
-		goto out;
-	}
-
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
 		ret = -EBUSY;
-- 
1.9.1
