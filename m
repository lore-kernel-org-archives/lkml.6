Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756237AbeDZLw7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:52:59 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48431 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756042AbeDZLwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:34 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180426115232epoutp01da72deb78e87411abf1424ed25ff66f3~o_i61zsXP0232602326epoutp01e
X-AuditID: b6c32a46-145ff70000001024-d0-5ae1bd7f3608
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 13/18] thermal: exynos: set trips in ascending order in
 exynos7_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:28 +0200
Message-id: <1524743493-28113-14-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCmuW793odRBjf2WllsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVsWTFPZaCXo6KY1vfMjcwfmDrYuTgkBAwkTjcXdvFyMUhJLCDUeLV17lMEM53Ron+
        V6vYuxg5wYoOnt3ABpHYwCgx8fViRgjnF6PExdVvmUCq2ASsJCa2r2IEsUUEtCROXNoONopZ
        YA6jxKyG3SwgCWGBJImNzzexgdgsAqoS0za9Zwe5g1fAU+LtITuIbXISJ49NZgWxOYHCF440
        sYDMkRBoZJNourEQ6iQXibPPHrFA2MISr45vgYpLSzxbtZERoqGZUeLbjj3MEIkJjBJ71gtB
        2NYSh49fBNvALMAn0XH4LzskMHglOtqEIEwPibsfAyGqHSVWvHzBAvEw0C+Xju9mn8AotYCR
        YRWjWGpBcW56arFRgZFecWJucWleul5yfu4mRnAEarntYFxyzucQowAHoxIPb8DCB1FCrIll
        xZW5hxglOJiVRHjjWx9GCfGmJFZWpRblxxeV5qQWH2KU5mBREudt8D0TJSSQnliSmp2aWpBa
        BJNl4uCUamAskGo7fvKXpuuM698d9r15+X3VasWTwTIRr1jP9ybWd66QCrqwoC5d8l3RrK/n
        Y/kDF/Jy7+xaeO9Cdc3s87rhAf8O/ejQDn+YXb+p+KFf6IHmlcI5Pz/UJnnYvb3vkWi7JO16
        3/afGid/CcZ85VgunN1yL8eg+HK4i+n5SybtrC35UZMbtDKVWIozEg21mIuKEwF8DSsxvAIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xoG793odRBt+2q1lsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVsWTFPZaCXo6KY1vfMjcwfmDrYuTkkBAwkTh4dgOQzcUhJLCOUeLM535mCOcXo8S7
        C9/ZQarYBKwkJravYgSxRQS0JE5c2s4EUsQsMIdR4vmKOUwgCWGBJImNzzeBjWURUJWYtuk9
        UDMHB6+Ap8TbQ3YQ2+QkTh6bzApicwKFLxxpYgGxhQQ8JO73vWebwMizgJFhFaNkakFxbnpu
        sVGBUV5quV5xYm5xaV66XnJ+7iZGYMhsO6zVv4Px8ZL4Q4wCHIxKPLwBCx9ECbEmlhVX5h5i
        lOBgVhLhjW99GCXEm5JYWZValB9fVJqTWnyIUZqDRUmclz//WKSQQHpiSWp2ampBahFMlomD
        U6qBccOlwxev2utsYFIq/2e40vXH/DvrN11ifjltf/PSSMtws0nOEU7zNK6v+frIZUc50ye9
        ctvi5ymz7NTuru16dC08Pv69qMZ5o2nX47K/f6nSadnyw2Kfzp4l0ouOnjuk0F7wO/Bb25p1
        D3zfLtgdMWmiM1NKj+8iEV9DwZ6mMh8epjPBlw6asSqxFGckGmoxFxUnAgBWWxpAFQIAAA==
X-CMS-MailID: 20180426115231epcas2p3727de5409903e05811c2b5ed10ee0a51
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115231epcas2p3727de5409903e05811c2b5ed10ee0a51
X-RootMTR: 20180426115231epcas2p3727de5409903e05811c2b5ed10ee0a51
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115231epcas2p3727de5409903e05811c2b5ed10ee0a51@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set trips in ascending order in exynos7_tmu_initialize() (it should
make no difference in driver operation). This prepares the driver
code to moving trips setting from ->tmu_initialize method to
exynos_tmu_initialize().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 12b60e2..571511f 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -618,7 +618,7 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
 	sanitize_temp_error(data, trim_info);
 
 	/* Write temperature code for rising and falling threshold */
-	for (i = (of_thermal_get_ntrips(tz) - 1); i >= 0; i--) {
+	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
 		tz->ops->get_trip_temp(tz, i, &temp);
 		temp /= MCELSIUS;
 		exynos7_tmu_set_trip_temp(data, i, temp);
-- 
1.9.1
