Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756061AbeDZLwd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:52:33 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:48679 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756013AbeDZLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180426115222epoutp0264b737b2e0b745358222eab8b2b6075a~o_ixg_kqX1584115841epoutp02M
X-AuditID: b6c32a46-145ff70000001024-be-5ae1bd7559af
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 09/18] thermal: exynos: clear IRQs later in
 exynos4412_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:24 +0200
Message-id: <1524743493-28113-10-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCmhW7p3odRBlMmGFtsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVca+7j6ngPVfF9Re3WRsYV3B2MXJySAiYSFw7d52xi5GLQ0hgB6PEt9tbGUESQgLf
        GSVe/GWDKTp+5zkTRHwDo8TrW+YQDb8YJXZdvs4OkmATsJKY2L4KrFlEQEvixKXtTCBFzAJz
        GCVmNexm6WLk4BAWiJRoe5YKUsMioCqxuPEeK0iYV8BT4v0CUYhdchInj01mBbE5gcIXjjSx
        gIyREPjLKrHs6CxGiCIXiQ+HHjJB2MISr45vYYewpSWerdrICNHQDPTNjj3MEIkJjBJ71gtB
        2NYSh49fBNvALMAn0XH4LzvIERICvBIdbVAlHhKz/q6FmukosbKhkR3ieaBfNiwNmMAotYCR
        YRWjWGpBcW56arFRgZFecWJucWleul5yfu4mRnD0abntYFxyzucQowAHoxIPb8DCB1FCrIll
        xZW5hxglOJiVRHjjWx9GCfGmJFZWpRblxxeV5qQWH2KU5mBREudt8D0TJSSQnliSmp2aWpBa
        BJNl4uCUamCco6HHIaG2bqL1DMEFT1NaFM+UcvC66B++OjnU3KEwPdu8z7xL5ZmWnul5R6Up
        e83u2kyLt9yr4Dwt3yFRTfjbEgmVb6ZrUx/d7T7A3Ld1W4n5lFUVPrm2CapV9yobnxRcuRUQ
        UbRb4pjZRBa7rPjV/ZWy3NMkt18tz9H/pyPiqSR1nem4hRJLcUaioRZzUXEiAMfqlfK6AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42I5/e+xoG7p3odRBt2NihYbZ6xntZh/5Rqr
        xeVdc9gsPvceYbSYcX4fk8WTh31sDmweO2fdZfdYvOclk0ffllWMHp83yQWwRHHZpKTmZJal
        FunbJXBl3OvuYyp4z1Vx/cVt1gbGFZxdjJwcEgImEsfvPGfqYuTiEBJYxyhxo3E2I4Tzi1Hi
        7bHvTCBVbAJWEhPbVzGC2CICWhInLm0H62AWmMMo8XzFHCCHg0NYIFKi7VkqSA2LgKrE4sZ7
        rCBhXgFPifcLRCGWyUmcPDaZFcTmBApfONLEAmILCXhI3O97zzaBkWcBI8MqRsnUguLc9Nxi
        owKjvNRyveLE3OLSvHS95PzcTYzAgNl2WKt/B+PjJfGHGAU4GJV4eAMWPogSYk0sK67MPcQo
        wcGsJMIb3/owSog3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB9MSS1OzU1ILUIpgsEwen
        VAMj04I3d9et+2PQEvuBaX9Ur4qd/bMZPQuPtpdwuS9g2+D67kRTZ2z4I5Wjk9MO1NdX2HIu
        yeC5cFLyyc5Z/V9jDgg+mPffe8uZ1dJhH9YZbflodeDmp9+C7BJP57uIyHh2ddUslQli/b1r
        63+NtHkrAhnjTknulua86Vx/9PVe5lVXQ4/1dpzUVWIpzkg01GIuKk4EALnTOX8UAgAA
X-CMS-MailID: 20180426115221epcas2p29faeae4b9bd5eb023e9696e2c33c01e9
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115221epcas2p29faeae4b9bd5eb023e9696e2c33c01e9
X-RootMTR: 20180426115221epcas2p29faeae4b9bd5eb023e9696e2c33c01e9
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115221epcas2p29faeae4b9bd5eb023e9696e2c33c01e9@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear IRQs after enabling thermal tripping (it should make no
difference in driver operation). This prepares the driver code
to moving IRQs clearing call from ->tmu_initialize method to
exynos_tmu_initialize().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 44a426a..1664d37 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -470,8 +470,6 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	writel(rising_threshold, data->base + EXYNOS_THD_TEMP_RISE);
 	writel(get_th_reg(data, 0, true), data->base + EXYNOS_THD_TEMP_FALL);
 
-	data->tmu_clear_irqs(data);
-
 	/* if last threshold limit is also present */
 	for (i = 0; i < of_thermal_get_ntrips(data->tzd); i++) {
 		if (trips[i].type == THERMAL_TRIP_CRITICAL) {
@@ -488,6 +486,8 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
 	con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
+
+	data->tmu_clear_irqs(data);
 }
 
 static void exynos5433_tmu_initialize(struct platform_device *pdev)
-- 
1.9.1
