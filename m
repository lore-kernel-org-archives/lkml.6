Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756083AbeDZL5c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:57:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48322 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755771AbeDZLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:14 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180426115212epoutp01d78a8e2b8d63908511d5771dc021ae09~o_iowrcuj0415504155epoutp01H
X-AuditID: b6c32a35-9cbff70000001024-d4-5ae1bd6cc984
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 05/18] thermal: exynos: use sanitize_temp_error() in
 exynos7_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:20 +0200
Message-id: <1524743493-28113-6-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCmrm7O3odRBjM2qlhsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcWqDYMEk3oqX7Y/ZGxh7uLsYOTkkBEwkFm1ewtLFyMUhJLCDUWLL6wZmCOc7o0TP
        lH+sXYwcYFVH18qDNAgJbGCU2DGdCaLmF6PEvO8vmUASbAJWEhPbVzGC2CICWhInLm0HK2IW
        mMMoMathNwtIQlggXuLo5k+sIDaLgKrEtgMP2EBsXgEPie8t01khTpKTOHlsMpjNKeApceFI
        E9h5EgJ/WSXaH35ghyhykWh9uJUJwhaWeHV8CzvEpdISl47aQtQ3M0p827GHGaJmAqPEnvVC
        ELa1xOHjF8EWMAvwSbz72gP1Ja9ERxtUiYfEwoZ+qHscJQ48eQP1MdAz23d+ZpvAKLWAkWEV
        o1hqQXFuemqxYYGhXnFibnFpXrpecn7uJkZw/GmZ7mCccs7nEKMAB6MSD2/AwgdRQqyJZcWV
        uYcYJTiYlUR441sfRgnxpiRWVqUW5ccXleakFh9ilOZgURLnfepzJkpIID2xJDU7NbUgtQgm
        y8TBKdXAGC3QoTjNPnWzpplytdjH10tY3TkffDvNsHvOyjWNAswCNYzHvn2Xk5Cw4ph5XoRt
        XcH8wPVCAnGe4RzCp9Laf6pwKjzXX/pa/zbXzMmPV9QfKwlhexC65XVCxRmV7caH4hO/+Xrn
        /ZSK/jp/rUnGH9Otx2/2Pe5QcdG/XF9VfW655+zd658eVmIpzkg01GIuKk4EADy7PYe7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42I5/e+xoG723odRBo/a1S02zljPajH/yjVW
        i8u75rBZfO49wmgx4/w+JosnD/vYHNg8ds66y+6xeM9LJo++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKOLVBsGASb8XL9sfsDYw93F2MHBwSAiYSR9fKdzFycQgJrGOUWPJmKhOE84tRYvKO
        Q6xdjJwcbAJWEhPbVzGC2CICWhInLm0HK2IWmMMo8XzFHCaQhLBAvMTRzZ/AGlgEVCW2HXjA
        BmLzCnhIfG+ZDhaXEJCTOHlsMpjNKeApceFIEwuILQRUc7/vPdsERp4FjAyrGCVTC4pz03OL
        jQoM81LL9YoTc4tL89L1kvNzNzECA2bbYa2+HYz3l8QfYhTgYFTi4Q1Y+CBKiDWxrLgy9xCj
        BAezkghvfOvDKCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8t/OORQoJpCeWpGanphakFsFkmTg4
        pRoYU7YY3F8f7/fg/9aK1RU/nnMa5bBfiJaaP8+gv9xjwtMb9w0y+X0uXN7dJDC/iu+5sp5h
        8h6TGz/YVb8KVusu22i1c953j9ctdq/1+UTDmfhrbGYpmdiXK51vubHTl8d1pReP6ry+qEiX
        z517ixbVpmvVzlvH/6v+clysS0TIiUetMhNrJUSVWIozEg21mIuKEwGLV9f1FAIAAA==
X-CMS-MailID: 20180426115211epcas1p3db7cbe215a3dfb49567a771931574a2f
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180426115211epcas1p3db7cbe215a3dfb49567a771931574a2f
X-RootMTR: 20180426115211epcas1p3db7cbe215a3dfb49567a771931574a2f
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115211epcas1p3db7cbe215a3dfb49567a771931574a2f@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sanitize_temp_error() to handle Exynos7 SoCs and then use it in
exynos7_tmu_initialize().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 3b41666..5a64879 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -286,7 +286,11 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 {
-	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
+	u16 tmu_temp_mask =
+		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
+						: EXYNOS_TMU_TEMP_MASK;
+
+	data->temp_error1 = trim_info & tmu_temp_mask;
 	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
 				EXYNOS_TMU_TEMP_MASK);
 
@@ -592,12 +596,7 @@ static int exynos7_tmu_initialize(struct platform_device *pdev)
 	unsigned int reg_off, bit_off;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
-
-	data->temp_error1 = trim_info & EXYNOS7_TMU_TEMP_MASK;
-	if (!data->temp_error1 ||
-	    (data->min_efuse_value > data->temp_error1) ||
-	    (data->temp_error1 > data->max_efuse_value))
-		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
+	sanitize_temp_error(data, trim_info);
 
 	/* Write temperature code for rising and falling threshold */
 	for (i = (of_thermal_get_ntrips(tz) - 1); i >= 0; i--) {
-- 
1.9.1
