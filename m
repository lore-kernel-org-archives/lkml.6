Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755978AbeDZLwQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:52:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:48561 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755542AbeDZLwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:05 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180426115203epoutp029d745016b623198971de3498b218ef3e~o_if_s3Bi1577015770epoutp02P
X-AuditID: b6c32a48-c31ff70000000fef-de-5ae1bd62403e
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 01/18] thermal: exynos: fix setting rising_threshold for
 Exynos5433
Date: Thu, 26 Apr 2018 13:51:16 +0200
Message-id: <1524743493-28113-2-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmuW7y3odRBsdamS02zljPajH/yjVW
        i8u75rBZfO49wmgx4/w+JosnD/vYHNg8ds66y+6xeM9LJo++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKuP26kalgJ1vF1+bX7A2M+1m7GDk5JARMJHrbr7GD2EICOxgluh7ydzFyAdnfGSX2
        nbnICFPU+fQmI0RiA6PE4abnLBDOL0aJYy132UCq2ASsJCa2rwLrEBHQkjhxaTsTSBGzwBxG
        iVkNu4E6ODiEBUIluuaFg9SwCKhKPOrdyQJi8wp4SEzf8pkJYpucxMljk8HO4xTwlLhwpAls
        mYTAX1aJHfvesEAUuUicX/2XGcIWlnh1fAs7hC0t8WzVRkaIhmZGiW879kAVTWCU2LNeCMK2
        ljh8/CLYBmYBPomOw3/ZQY6TEOCV6GiDKvGQWP7kC9T7jhJ3nh2Feh/omdaP59gnMEotYGRY
        xSiWWlCcm55abFRgolecmFtcmpeul5yfu4kRHINaHjsYD5zzOcQowMGoxMMbsPBBlBBrYllx
        Ze4hRgkOZiUR3vjWh1FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeRt8z0QJCaQnlqRmp6YWpBbB
        ZJk4OKUaGB1yl915UzZbNi7ji6Qeq97emN9bbhQW1i46+djn9mXOBTs/Ve14prqtcOJN502q
        E/+9yGRj8NhmUc5a87axTlZVjamTmcuKL9vv17dfE08IfStq/nVTcU3liRfiZ9RtskMu7BfN
        DzfuCz/qwNP4Ys+LPdu35Szf96/6+0m5IAv9FJ2qFF+DxUosxRmJhlrMRcWJAF5EKUu9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xoG7i3odRBusXa1hsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcft1I1PBTraKr82v2RsY97N2MXJySAiYSHQ+vcnYxcjFISSwjlFi5pclLBDOL0aJ
        VfPOMoJUsQlYSUxsXwVmiwhoSZy4tJ0JpIhZYA6jxPMVc4AcDg5hgVCJrnnhIDUsAqoSj3p3
        soDYvAIeEtO3fGaC2CYncfLYZLDNnAKeEheONIHVCAHV3O97zzaBkWcBI8MqRsnUguLc9Nxi
        owKjvNRyveLE3OLSvHS95PzcTYzAkNl2WKt/B+PjJfGHGAU4GJV4eAMWPogSYk0sK67MPcQo
        wcGsJMIb3/owSog3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB9MSS1OzU1ILUIpgsEwen
        VANjrYObvcfuS9qRZe+4LDc/2cax1INf4JHsd1lnhiXnri3S2vOqKinSbmprUBu7ZNbJ7ll9
        Zlad4al80hmJm79b1vduuZm4WCO95YKfcopfeVfi4mKDgoUFM0UuhpRbBOg9/xm/w/SBz+TH
        z9Pn/tI/FbrwhdSam6WmBd9EzmsmyfTNjpz6VF+JpTgj0VCLuag4EQAVwAHjFQIAAA==
X-CMS-MailID: 20180426115201epcas2p17e5cdb0f79927903880e58c290b663e6
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115201epcas2p17e5cdb0f79927903880e58c290b663e6
X-RootMTR: 20180426115201epcas2p17e5cdb0f79927903880e58c290b663e6
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115201epcas2p17e5cdb0f79927903880e58c290b663e6@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clearing of the previous value when setting rising
temperature threshold.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index cda716c..523d26e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -577,6 +577,7 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
 		threshold_code = temp_to_code(data, temp);
 
 		rising_threshold = readl(data->base + rising_reg_offset);
+		rising_threshold &= ~(0xff << j * 8);
 		rising_threshold |= (threshold_code << j * 8);
 		writel(rising_threshold, data->base + rising_reg_offset);
 
-- 
1.9.1
