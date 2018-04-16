Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeDPKNp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:13:45 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61625 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbeDPKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:13:42 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180416101340epoutp01a0e00bc80b8562001c08a280f9c06e78~l4vv5aIUd2855528555epoutp01O
X-AuditID: b6c32a45-6ebff70000000fe4-19-5ad477543f09
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 01/14] thermal: exynos: Reading temperature makes sense only
 when TMU is turned on
Date: Mon, 16 Apr 2018 12:11:52 +0200
Message-id: <1523873525-23718-2-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7bCmmW5I+ZUog7ZLIhYbZ6xntZj3WdZi
        /pVrrBb9j18zW5w/v4Hd4vKuOWwWn3uPMFrMOL+PyWLtkbvsFk8e9rE5cHnsnHWX3WPxnpdM
        HptWdbJ53Lm2h82jb8sqRo/Pm+QC2KK4bFJSczLLUov07RK4Mh4tW8RacFuwYu7L34wNjM/5
        uhg5OSQETCQW3XzK3sXIxSEksINR4tvu+cwQzndGialPtrDDVE1f+QkqsYFR4u3tw1DOL0aJ
        DSv2MoJUsQlYSUxsXwVmiwhoSZy4tJ0JpIhZYD+TRO+yuawgCWGBFIndK4+BjWURUJU4cuoA
        UJyDg1fAQ2Lm1VCIbXISJ49NBivnFPCUaFpzjQ1kjoTACjaJLVtAzgApcpE4fOsN1HnCEq+O
        w5wqLfFs1UZGiIZmoId27IFqmMAosWe9EIRtLXH4+EWwDcwCfBIdh/+ygxwhIcAr0dEGVeIh
        8fHNTxYI21Hiz9oTLBAfz2GUuNb0i3UCo9QCRoZVjGKpBcW56anFRgWGesWJucWleel6yfm5
        mxjB8avluoNxxjmfQ4wCHIxKPLw7zl6OEmJNLCuuzD3EKMHBrCTCuywRKMSbklhZlVqUH19U
        mpNafIhRmoNFSZy3wfdMlJBAemJJanZqakFqEUyWiYNTqoExdeGN3OTDH2a1By9jW/DcqGr1
        qn1yYtWrRfxlb1j09lzpn/M5oNPxeFva+SsxT/r9Jy/anW17rUnomP2JpXsZI4LTz8nfPXbh
        1K2o6dP+SS4xqBD+czNNsq/myEOFktZ92Wk9N9fNcF6Wv0H+Xu/+H09Swtfd/a+1eOt50902
        ytOVV0jnqXjFK7EUZyQaajEXFScCAE+NuKzbAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsVy+t9jQd3g8itRBp+eGlpsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+Jou1R+6yWzx52MfmwOWxc9Zddo/Fe14y
        eWxa1cnmcefaHjaPvi2rGD0+b5ILYIvisklJzcksSy3St0vgyni0bBFrwW3BirkvfzM2MD7n
        62Lk5JAQMJGYvvITcxcjF4eQwDpGiVMbvjBBOL+AnIcfGUGq2ASsJCa2rwKzRQS0JE5c2g5W
        xCywn0niw7TrLCAJYYEUid0rj7GD2CwCqhJHTh1g7WLk4OAV8JCYeTUUYpucxMljk1lBbE4B
        T4mmNdfYQGwhoJLGiVcZJzDyLGBkWMUomVpQnJueW2xUYJSXWq5XnJhbXJqXrpecn7uJERhs
        2w5r9e9gfLwk/hCjAAejEg/vjrOXo4RYE8uKK3MPMUpwMCuJ8C5LBArxpiRWVqUW5ccXleak
        Fh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpgVDhyeP3F9a7rdkqoCFp92P1zkbNI
        1w59SaWjZ6PuChjPOOfC9bT83wKxBpkt23cGqM569tbs29rz+9n52I8Ezn43758T96PurEf5
        HkFr89ce3G3yZa6ioMm7rkdGXYUKOzk+LL+ZKmdy1UmFvc6bcfrZlnbZmQGsG/hZlBcud1v2
        K0S1NvzGcyWW4oxEQy3mouJEAJmMA8cyAgAA
X-CMS-MailID: 20180416101339epcas2p171d462b70a85a6fff3bb939fca6d469d
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180416101339epcas2p171d462b70a85a6fff3bb939fca6d469d
X-RootMTR: 20180416101339epcas2p171d462b70a85a6fff3bb939fca6d469d
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101339epcas2p171d462b70a85a6fff3bb939fca6d469d@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

When thermal sensor is not yet enabled, reading temperature might return
random value. This might even result in stopping system booting when such
temperature is higher than the critical value. Fix this by checking if TMU
has been actually enabled before reading the temperature.

This change fixes booting of Exynos4210-based board with TMU enabled (for
example Samsung Trats board), which was broken since v4.4 kernel release.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 9e4249b40340 ("thermal: exynos: Fix first temperature read after registering sensor")
CC: stable@vger.kernel.org # v4.6+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ed805c7..986cbd0 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -185,6 +185,7 @@
  * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
  * @ntrip: number of supported trip points.
+ * @enabled: current status of TMU device
  * @tmu_initialize: SoC specific TMU initialization method
  * @tmu_control: SoC specific TMU control method
  * @tmu_read: SoC specific TMU temperature read method
@@ -205,6 +206,7 @@ struct exynos_tmu_data {
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
 	unsigned int ntrip;
+	bool enabled;
 
 	int (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
@@ -398,6 +400,7 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 	data->tmu_control(pdev, on);
+	data->enabled = on;
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 }
@@ -890,7 +893,7 @@ static int exynos_get_temp(void *p, int *temp)
 {
 	struct exynos_tmu_data *data = p;
 
-	if (!data || !data->tmu_read)
+	if (!data || !data->tmu_read || !data->enabled)
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
-- 
1.9.1
