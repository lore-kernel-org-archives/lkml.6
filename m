Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427193AbeCBLYP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:24:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37896 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165055AbeCBIvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:51:31 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180302085129euoutp025128361346449f43015f683e61abb6b9~YDmJJv_1Y0222702227euoutp02W
X-AuditID: cbfec7f5-f95739c0000028a9-49-5a991090a726
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v5 3/5] regulator: core: Resolve coupled regulators
Date: Fri, 02 Mar 2018 09:42:47 +0100
Message-id: <1519980169-8491-4-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7djP87oTBGZGGRw4IGGxccZ6VoupD5+w
        Wcw/co7V4uyyg2wW3650MFlc3jWHzWLBy1ssFmuP3GW3WHr9IpNF694j7A5cHmvmrWH0mN1w
        kcVj56y77B6bVnWyefRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGlj+TWQuaFSqub/NtYOyR
        6mLk5JAQMJG4tK6JpYuRi0NIYAWjxJH+VmYI5zOjxIfjX1lgqn7O+8QIkVjGKLG09TQrhPOf
        UWLN4f9AGQ4ONgEtiTXt8SANIgI2Em9vHABrYBY4ziRxfepGJpCEsICzxLV5s1hBbBYBVYmL
        14+wgdi8QPFVi3uYIbbJSdw81wlmcwq4SPx8sIoNZJCEwBI2id19txghilwkFr86AmULS7w6
        voUdwpaR6Ow4yARhV0tc/LqLDcKukWi8vQGqxlri86QtYAuYBfgkJm2bzgzygIQAr0RHmxBE
        iYfE/M//ocY4Sizp+Qb1/XRGict72tgmMEotYGRYxSieWlqcm55abJyXWq5XnJhbXJqXrpec
        n7uJERi/p/8d/7qDcd+fpEOMAhyMSjy8OzlnRAmxJpYVV+YeYpTgYFYS4W35ABTiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOG6dRFyUkkJ5YkpqdmlqQWgSTZeLglGpglFlqfPy69Vn+Q14pVq+e
        SBw9pT3x+Bo5c7Wm37//6z65wXMsW/AT85KKDVaMs/ckl3ceOSt+NnVzvPPvN0Yr5ISlLhil
        ZejbNWkys10qEb7zoZFj2fWd6rPq1q5y2Xxq9vMZqWFrDwbas7Lmvgl5cmu9bXPtFf6DjJb9
        fJFiJscNblraXzHcqsRSnJFoqMVcVJwIAA6NpPvbAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t/xy7r9AjOjDJoW61tsnLGe1WLqwyds
        FvOPnGO1OLvsIJvFtysdTBaXd81hs1jw8haLxdojd9ktll6/yGTRuvcIuwOXx5p5axg9Zjdc
        ZPHYOesuu8emVZ1sHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJWx5c9k1oJmhYrr23wbGHuk
        uhg5OSQETCR+zvvE2MXIxSEksIRRYsXzp+wgCSGBRiaJ53Pzuxg5ONgEtCTWtMeDhEUEbCTe
        3jgAVs8scJJJ4s/FdYwgCWEBZ4lr82axgtgsAqoSF68fYQOxeYHiqxb3MEMsk5O4ea4TzOYU
        cJH4+WAVG8QuZ4nGo+vYJzDyLGBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREYYNuO/dy8
        g/HSxuBDjAIcjEo8vAc+zogSYk0sK67MPcQowcGsJMLb8gEoxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnPe8QWWUkEB6YklqdmpqQWoRTJaJg1OqgdF1y0MXO/ferUfFTxluy35eYLl+4z9pB0ez
        hAducVPUkk5HzYk93h7S8tb2nvRMl5WPDqrYXXnR9t7n+YPX0Q3v9L57n1Diq9H2vy9wzsVH
        /O4SVfGd/q6zz2xrENY5F/4vIo3no9qWNRu+/RO/9URNapX63P6qyQ1uj09d+J5dv6PIzdvq
        Y4QSS3FGoqEWc1FxIgBMqVHYLAIAAA==
X-CMS-MailID: 20180302085127eucas1p19293e26a9abe8f7df6936912e6999b3f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180302085127eucas1p19293e26a9abe8f7df6936912e6999b3f
X-RootMTR: 20180302085127eucas1p19293e26a9abe8f7df6936912e6999b3f
References: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
        <CGME20180302085127eucas1p19293e26a9abe8f7df6936912e6999b3f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
different devices on the board are supplied by different regulators
with non-fixed voltages. If one of these devices temporarily requires
higher voltage, there might occur a situation that the spread between
two devices' voltages is so high, that there is a risk of changing
'high' and 'low' states on the interconnection between devices powered
by those regulators.

Fill coupling descriptor with data obtained from DTS using previously
defined of_functions. Fail to register a regulator, if some data
inconsistency occurs. If some coupled regulators are not yet registered,
don't fail to register, but try to resolve them in late init call.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5494189..f8adfe4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4067,6 +4067,88 @@ static int regulator_register_resolve_supply(struct device *dev, void *data)
 	return 0;
 }
 
+static int regulator_fill_coupling_array(struct regulator_dev *rdev)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	int n_coupled = c_desc->n_coupled;
+	struct regulator_dev *c_rdev;
+	int i;
+
+	for (i = 1; i < n_coupled; i++) {
+		/* already resolved */
+		if (c_desc->coupled_rdevs[i])
+			continue;
+
+		c_rdev = of_parse_coupled_regulator(rdev, i - 1);
+
+		if (c_rdev) {
+			c_desc->coupled_rdevs[i] = c_rdev;
+			c_desc->n_resolved++;
+		}
+	}
+
+	if (rdev->coupling_desc.n_resolved < n_coupled)
+		return -1;
+	else
+		return 0;
+}
+
+static int regulator_register_fill_coupling_array(struct device *dev,
+						  void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+
+	if (regulator_fill_coupling_array(rdev))
+		rdev_dbg(rdev, "unable to resolve coupling\n");
+
+	return 0;
+}
+
+static int regulator_resolve_coupling(struct regulator_dev *rdev)
+{
+	int n_phandles = of_get_n_coupled(rdev);
+
+	if (n_phandles + 1 > MAX_COUPLED) {
+		rdev_err(rdev, "too many regulators coupled\n");
+		return -EPERM;
+	}
+
+	/*
+	 * Every regulator should always have coupling descriptor filled with
+	 * at least pointer to itself.
+	 */
+	rdev->coupling_desc.coupled_rdevs[0] = rdev;
+	rdev->coupling_desc.n_coupled = n_phandles + 1;
+	rdev->coupling_desc.n_resolved++;
+
+	/* regulator isn't coupled */
+	if (n_phandles == 0)
+		return 0;
+
+	/* regulator, which can't change its voltage, can't be coupled */
+	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_VOLTAGE)) {
+		rdev_err(rdev, "voltage operation not allowed\n");
+		return -EPERM;
+	}
+
+	if (rdev->constraints->max_spread <= 0) {
+		rdev_err(rdev, "wrong max_spread value\n");
+		return -EPERM;
+	}
+
+	if (!of_check_coupling_data(rdev))
+		return -EPERM;
+
+	/*
+	 * After everything has been checked, try to fill rdevs array
+	 * with pointers to regulators parsed from device tree. If some
+	 * regulators are not registered yet, retry in late init call
+	 */
+	regulator_fill_coupling_array(rdev);
+
+	return 0;
+}
+
 /**
  * regulator_register - register regulator
  * @regulator_desc: regulator to register
@@ -4200,6 +4282,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (ret < 0)
 		goto wash;
 
+	mutex_lock(&regulator_list_mutex);
+	ret = regulator_resolve_coupling(rdev);
+	mutex_unlock(&regulator_list_mutex);
+
+	if (ret != 0)
+		goto wash;
+
 	/* add consumers devices */
 	if (init_data) {
 		mutex_lock(&regulator_list_mutex);
@@ -4693,6 +4782,9 @@ static int __init regulator_init_complete(void)
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_late_cleanup);
 
+	class_for_each_device(&regulator_class, NULL, NULL,
+			      regulator_register_fill_coupling_array);
+
 	return 0;
 }
 late_initcall_sync(regulator_init_complete);
-- 
2.7.4
