Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeCIMXp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:23:45 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46456 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeCIMWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:22:37 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180309122235euoutp014a4b49d97ff56ab108a192d91177d0e7~aP-dXzXni1671716717euoutp01C
X-AuditID: cbfec7f4-6f9ff700000043e4-36-5aa27c8a2386
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v6 4/6] regulator: core: Resolve coupled regulators
Date: Fri, 09 Mar 2018 13:22:06 +0100
Message-id: <1520598128-11768-5-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7djP87pdNYuiDH5sUrDYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLh1f9Lb5d6WCyuLxrDpvFgpe3WCzWHrnLbrH0+kUmi9a9R9gt9l/xcuDx
        WDNvDaPHt6+TWDxmN1xk8dg56y67x6ZVnWwefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlbFm
        3zT2gm8KFc9mbmNpYHwi1cXIySEhYCLx9MMDxi5GLg4hgRWMEle/b2SBcD4zSsyfupwNpmrn
        k1nsEIlljBKLXi9lB0kICfxnlNh2UK6LkYODTUBLYk17PEhYRMBG4u2NA2BTmQX6mSUmN7Wy
        gCSEBZwl1rXOABvKIqAqsa25lQ2kl1fAReLFr1yIXXISN891MoPYnAKuEueuv2GEiO9gk7h3
        vADCdpG4OaEB6jZhiVfHt7BD2DISlyd3s0DY1RIXv+6CqqmRaLy9AarGWuLzpC1g85kF+CQm
        bZvODHKChACvREebEESJh8Tftd+hxjhKvDnxkhXi9RmMEm82fGGawCi1gJFhFaN4amlxbnpq
        sVFearlecWJucWleul5yfu4mRmBUn/53/MsOxl1/kg4xCnAwKvHwPnBcGCXEmlhWXJl7iFGC
        g1lJhLeqYlGUEG9KYmVValF+fFFpTmrxIUZpDhYlcd44jbooIYH0xJLU7NTUgtQimCwTB6dU
        AyOrlcJetogpzMcvdX1bceAzs9+Lxa/YnI7FBs8PWrzmE/+F+4nF/+9HccqUt337/Oy7VpkN
        b/2jkHOfb2fOXPlClE+9aM+B5rf/9IVPXf00vfaw52eBfQfu9cy8s3XpFCWlmRKrGPV/hwUL
        rNDSf35yXUVp3MLzH0TuLd3tV2Jgn6mbed7eosBGiaU4I9FQi7moOBEAt2eLAOYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t/xy7qdNYuiDHp/2VhsnLGe1WLqwyds
        FvOPnGO1OLvsIJvFw6v+Ft+udDBZXN41h81iwctbLBZrj9xlt1h6/SKTReveI+wW+694OfB4
        rJm3htHj29dJLB6zGy6yeOycdZfdY9OqTjaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgyliz
        bxp7wTeFimczt7E0MD6R6mLk5JAQMJHY+WQWexcjF4eQwBJGiTPnv0I5jUwSO7bvAXI4ONgE
        tCTWtMeDNIgI2Ei8vXGAEaSGWWAis8TCxVdYQRLCAs4S61pnsIHYLAKqEtuaW9lAenkFXCRe
        /MqFWCYncfNcJzOIzSngKnHu+htGEFsIqKRjxnP2CYw8CxgZVjGKpJYW56bnFhvpFSfmFpfm
        pesl5+duYgQG37ZjP7fsYOx6F3yIUYCDUYmH94Hjwigh1sSy4srcQ4wSHMxKIrxVFYuihHhT
        EiurUovy44tKc1KLDzFKc7AoifOeN6iMEhJITyxJzU5NLUgtgskycXBKNTByvC5o8K+o/Zr2
        PuTh+at9m58o8179zeskf3yJs/mOLOa3j/+fCtBS+8x0/LDLpMUZtprLY15JP35Q+EXWqO1E
        yXW7Gyt1nts3WiVotfZYz332QD00dp9f2/sbEaU3t3tK1Iu8ckiJq4mZYTjn2UO+20GWXHc9
        A9he/zx/PvHw8w6dvMj+RhUlluKMREMt5qLiRABQDBVMOgIAAA==
X-CMS-MailID: 20180309122234eucas1p1a5c9e939848191de36a9daa06e785ae7
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309122234eucas1p1a5c9e939848191de36a9daa06e785ae7
X-RootMTR: 20180309122234eucas1p1a5c9e939848191de36a9daa06e785ae7
References: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
        <CGME20180309122234eucas1p1a5c9e939848191de36a9daa06e785ae7@eucas1p1.samsung.com>
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
index f6e784c..60fb05d 100644
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
+		return 0;
+
+	n_phandles = of_get_n_coupled(rdev);
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
@@ -4743,6 +4840,9 @@ static int __init regulator_init_complete(void)
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
