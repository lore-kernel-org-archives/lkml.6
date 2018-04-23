Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932066AbeDWOfY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:35:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36828 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754962AbeDWOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:34:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180423143405euoutp0236fe69e346435c028b467c63105ccf65~oF0H33Qhg2198521985euoutp021
X-AuditID: cbfec7f5-f95739c0000028a9-56-5addeedbd617
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v7 4/6] regulator: core: Resolve coupled regulators
Date: Mon, 23 Apr 2018 16:33:40 +0200
Message-id: <1524494022-22260-5-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7djP87q3392NMpi1l8ti44z1rBZTHz5h
        s5h/5ByrxdllB9ksHl71t/h2pYPJ4vKuOWwWC17eYrFYe+Quu8XS6xeZLFr3HmG32H/Fy4HH
        Y828NYwe375OYvGY3XCRxWPnrLvsHptWdbJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8aZ
        w69ZC5oUK/6uOszcwPhWqouRk0NCwERi5/ztjF2MXBxCAisYJbbde8MG4XxmlNi1aiszTNW5
        H7+ZQGwhgWWMEs+eJUAU/WeUeD31AHsXIwcHm4CWxJr2eJAaEQEbibc3DoBNZRboZ5aY3NTK
        ApIQFnCWOHbpIpjNIqAqcXX1Z1YQm1fAReL5jbeMEMvkJG6e6wRbzCngKrGk+QE7yCAJgR1s
        EtNnbWGFKHKR2HV3JVSDsMSr41vYIWwZicuTu1kg7GqJi193sUHYNRKNtzdA1VhLfJ60BWwB
        swCfxKRt05lBHpAQ4JXoaBOCKPGQOLuqFWqMo8SOzz+YIZ6fwSix8I7wBEapBYwMqxjFU0uL
        c9NTi43zUsv1ihNzi0vz0vWS83M3MQLj+vS/4193MO77k3SIUYCDUYmHd4fu3Sgh1sSy4src
        Q4wSHMxKIrwP3wCFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp1EUJCaQnlqRmp6YWpBbBZJk4
        OKUaGNdc9nPNdRb7sPHKlHVenJ+D3Q5tuuX6Tfxp7eVf8io1J15kT5lU+WiOyxJJiXu2s/7L
        cm6dGtngbyQdarzq5PR3fi+fdt7TtFb7FjP7yPNGOfcLLcd6f33iWOO0dtuporzIs//iVDbe
        SLisdNz15bIqrt5fZtt9DnZ7pe98ILN9V3WartLDI9FKLMUZiYZazEXFiQCIgtba5wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsVy+t/xy7o3392NMvg8Vc9i44z1rBZTHz5h
        s5h/5ByrxdllB9ksHl71t/h2pYPJ4vKuOWwWC17eYrFYe+Quu8XS6xeZLFr3HmG32H/Fy4HH
        Y828NYwe375OYvGY3XCRxWPnrLvsHptWdbJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8aZ
        w69ZC5oUK/6uOszcwPhWqouRk0NCwETi3I/fTF2MXBxCAksYJSat+80C4TQySSw7u46ti5GD
        g01AS2JNezxIg4iAjcTbGwcYQWqYBSYySyxcfIUVJCEs4Cxx7NJFFhCbRUBV4urqz2BxXgEX
        iec33jJCbJOTuHmukxnE5hRwlVjS/IAdxBYCqtm3bxfzBEaeBYwMqxhFUkuLc9Nzi430ihNz
        i0vz0vWS83M3MQLDb9uxn1t2MHa9Cz7EKMDBqMTDu0P3bpQQa2JZcWXuIUYJDmYlEd6Hb4BC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEec8bVEYJCaQnlqRmp6YWpBbBZJk4OKUaGDsuuIbPVbn3
        2PaXycwLTy++aVJys7Z2K+MqVMi5f6m52dPlS3CVybPiPXZF94VKDiYtubC16s3Vl5fYV2wR
        5XO3cPh9cn7tci+G3no+uf7YVd3h2Xc+b9gtvHOL+3qX/kOJPE97bmf/TGcru5A6gUdzy62S
        NylNSXP/50ecP2E2mUXqhZbdKyWW4oxEQy3mouJEAMsnpqw7AgAA
X-CMS-MailID: 20180423143401eucas1p1cfe9b2c807cf88b3f3b68b7b2f580e83
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180423143401eucas1p1cfe9b2c807cf88b3f3b68b7b2f580e83
X-RootMTR: 20180423143401eucas1p1cfe9b2c807cf88b3f3b68b7b2f580e83
References: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
        <CGME20180423143401eucas1p1cfe9b2c807cf88b3f3b68b7b2f580e83@eucas1p1.samsung.com>
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
 drivers/regulator/core.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index acca5de..82b002e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4117,6 +4117,96 @@ static int regulator_register_resolve_supply(struct device *dev, void *data)
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
+	if (!IS_ENABLED(CONFIG_OF))
+		return 0;
+
+	if (regulator_fill_coupling_array(rdev))
+		rdev_dbg(rdev, "unable to resolve coupling\n");
+
+	return 0;
+}
+
+static int regulator_resolve_coupling(struct regulator_dev *rdev)
+{
+	int n_phandles;
+
+	if (!IS_ENABLED(CONFIG_OF))
+		n_phandles = 0;
+	else
+		n_phandles = of_get_n_coupled(rdev);
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
@@ -4250,6 +4340,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
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
@@ -4744,6 +4841,9 @@ static int __init regulator_init_complete(void)
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
