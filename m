Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDPQTy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:19:54 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:21346 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeDPQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:19:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180416161950epoutp02bf77d18bd6b1732e0e6d823f9e208484~l9vco9rlU1509215092epoutp02M
X-AuditID: b6c32a39-579ff70000000ff4-0d-5ad4cd25153d
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: kishon@ti.com
Cc: krzk@kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] phy: exynos-mipi-video: Simplify code by using
 regmap_update_bits()
Date: Mon, 16 Apr 2018 18:19:38 +0200
Message-id: <20180416161938.26958-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCmvq7q2StRBudfWlhsnLGe1eLC0x42
        i/PnN7BbXN41h81ixvl9TBZrj9xltzj8pp3Vgd1j06pONo++LasYPY7f2M7k8XmTXABLFJdN
        SmpOZllqkb5dAlfG3Tu/GQveCVZ8XveKpYHxP18XIyeHhICJxLt3DYxdjFwcQgI7GCWeHJ/P
        CuF8Z5Q4cmEhG0zV7fWdzCC2kMAGRon2UxIQRb8YJa63tbOAJNgEDCV6j/YBjeLgEBEQlPj0
        CWwqs8BORomFD78ygtQIC4RJ/JrwmR3EZhFQlTjwbiorSD2vgLXEl1WMELvkJd4vuA/WKyHw
        klVi24KnLBAJF4m2Q1egDhKWeHV8CztIr4SAtMSlo7YQ4WqJzrYudojeFkaJP9MuQdVbSxw+
        fpEVxGYW4JN497WHFaKXV6KjTQiixEPi96f1UOWOEmtmHWKH+DdWYtKa7UwTGCUXMDKsYhRL
        LSjOTU8tNiww1StOzC0uzUvXS87P3cQIjjctyx2Mx875HGIU4GBU4uGV2HElSog1say4MvcQ
        owQHs5II7/xDQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T33ORAkJpCeWpGanphakFsFkmTg4
        pRoYXboez3gge2neOjsdFk/riFepM26LvlgYv+e20z7OXcFHLr2bsfthxCmHZQa99yPFDGK/
        uvNayp/R/tct5eRaFblJ8s4Cz+lMEk1XJ1sz71TOn2E7y6b9bNfS1pMHVFRSOzgEN/mUbN/2
        yfVQaDD70okN/+6v35UvLJVTuT/MpdKLe5dm28oIJZbijERDLeai4kQAVGGrubMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHJMWRmVeSWpSXmKPExsVy+t9jQV3Vs1eiDA6dELHYOGM9q8WFpz1s
        FufPb2C3uLxrDpvFjPP7mCzWHrnLbnH4TTurA7vHplWdbB59W1Yxehy/sZ3J4/MmuQCWKC6b
        lNSczLLUIn27BK6Mu3d+Mxa8E6z4vO4VSwPjf74uRk4OCQETidvrO5m7GLk4hATWMUp0bDvA
        COH8YpT40XyTCaSKTcBQovdoH1CCg0NEQFDi0yewGmaBnYwSj/b2sYPUCAuESfya8BnMZhFQ
        lTjwbiorSD2vgLXEl1WMEMvkJd4vuM84gZFrASPDKkbJ1ILi3PTcYqMCw7zUcr3ixNzi0rx0
        veT83E2MwFDYdlirbwfj/SXxhxgFOBiVeHgldlyJEmJNLCuuzD3EKMHBrCTCO/8QUIg3JbGy
        KrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZJg5OqQbGoMvZouUCAg56ug9W
        rwh7bHtF9Sn/hSrnTQW6DH6SVw7Mmr9BZD7zTqO+WZVxMqGXNDWe71ihmHx+nVeNT8C1C0Ih
        7vWly4LONLHEn+T/Wupr9octWz+uXFb0cN7L/qt7u9afCjBw4GgwcMy6dZnr6t/fgQv9+383
        OFwqNLKNCTVe08OlfEqJpTgj0VCLuag4EQAMd01AAQIAAA==
X-CMS-MailID: 20180416161949epcas1p11b738f30a12bd2f62ad9422f7c4e7ed6
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180416161949epcas1p11b738f30a12bd2f62ad9422f7c4e7ed6
X-RootMTR: 20180416161949epcas1p11b738f30a12bd2f62ad9422f7c4e7ed6
References: <CGME20180416161949epcas1p11b738f30a12bd2f62ad9422f7c4e7ed6@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no functional change, just replacing regmap_read()/modify/
regmap_write() with regmap_update_bits() function calls.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/phy/samsung/phy-exynos-mipi-video.c | 34 ++++++++++++-----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos-mipi-video.c b/drivers/phy/samsung/phy-exynos-mipi-video.c
index c198886f80a3..00d89599c67d 100644
--- a/drivers/phy/samsung/phy-exynos-mipi-video.c
+++ b/drivers/phy/samsung/phy-exynos-mipi-video.c
@@ -231,33 +231,27 @@ struct exynos_mipi_video_phy {
 static int __set_phy_state(const struct exynos_mipi_phy_desc *data,
 			   struct exynos_mipi_video_phy *state, unsigned int on)
 {
-	u32 val;
+	struct regmap *enable_map = state->regmaps[data->enable_map];
+	struct regmap *resetn_map = state->regmaps[data->resetn_map];
 
 	spin_lock(&state->slock);
 
 	/* disable in PMU sysreg */
 	if (!on && data->coupled_phy_id >= 0 &&
-	    state->phys[data->coupled_phy_id].phy->power_count == 0) {
-		regmap_read(state->regmaps[data->enable_map], data->enable_reg,
-			    &val);
-		val &= ~data->enable_val;
-		regmap_write(state->regmaps[data->enable_map], data->enable_reg,
-			     val);
-	}
-
+	    state->phys[data->coupled_phy_id].phy->power_count == 0)
+		regmap_update_bits(enable_map, data->enable_reg,
+				   data->enable_val, 0);
 	/* PHY reset */
-	regmap_read(state->regmaps[data->resetn_map], data->resetn_reg, &val);
-	val = on ? (val | data->resetn_val) : (val & ~data->resetn_val);
-	regmap_write(state->regmaps[data->resetn_map], data->resetn_reg, val);
-
+	if (on)
+		regmap_update_bits(resetn_map, data->resetn_reg,
+				   data->resetn_val, data->resetn_val);
+	else
+		regmap_update_bits(resetn_map, data->resetn_reg,
+				   data->resetn_val, 0);
 	/* enable in PMU sysreg */
-	if (on) {
-		regmap_read(state->regmaps[data->enable_map], data->enable_reg,
-			    &val);
-		val |= data->enable_val;
-		regmap_write(state->regmaps[data->enable_map], data->enable_reg,
-			     val);
-	}
+	if (on)
+		regmap_update_bits(enable_map, data->enable_reg,
+				   data->enable_val, data->enable_val);
 
 	spin_unlock(&state->slock);
 
-- 
2.14.2
