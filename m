Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeCTJMG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:12:06 -0400
Received: from mout.perfora.net ([74.208.4.197]:54289 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751607AbeCTJME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:12:04 -0400
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: airlied@linux.ie, Stefan Agner <stefan@agner.ch>,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH v2] drm/tegra: dc: use correct format array for Tegra124.
Date: Tue, 20 Mar 2018 10:11:44 +0100
Message-Id: <20180320091144.22421-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:MyT1Zu12BNAlARzx44MJaLTDmoQoJFn9JAvuqiI9mcg1yYgzF3Z
 B067Ee3O/XWq6Vqym1u8YbRS31j4zyEEwS7KykFNwN1aE1eBycslsLA19gE4TuYKWoru9Vw
 W39Nwo++QfCeqq1p0mIBuM6nkkohR8JnHuMDu6g/6d1Xy8+/g15htc5YU9J1qL3hFyvqVlK
 D6zcZWxcsr05Y7NJPF6Tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8J4+ZGsL7DY=:E0/RdOQR2DQnJCguuJXgXG
 J7ATWe+fJcfJsJ6xOgqH0ODQY6grjnQumVBML1Nd32bOHrjBf7GD61T7Qg3C0njZGJIV7laJ+
 5is/0Znje3KsZuxlbQPs8qtEzoFqslwPiCtCuS4C68fGQAI6WVP22NBY5kF48ZjGDbO2Ul23k
 l6fID8CyfVB3UvFAGlseR4lOlxqR6Fx8i7akI4KWVChGTcaym+iqJYM3N4h7isBVQrrYzFZ6L
 S8EzyChKDIlYh+xVNpurgXR6Ey2iiWd2ot2lZScuoCfQbUvnWUnHyAkEF6rhomMPGFgfGiHBX
 q7Dm64/OueibxGaR5z1GE1sr/6DwQyPTOE4ZqNp9Sjk17/2gdHPbeZ17THKvQjy0jUHLbzFeA
 OgnmOOg+6XsP66CZUHJIHmAJXL/kg88Ghw5N0H9Z3RuqxXgb3FUL7gt2qZSZdnj9G0A4hqbvS
 l7YofRVTVQSuXUEBDPvKhpF4fDFoUpv04B1sxYsUSmYrU8QmgtZ3NyW+kEhkoPYOw9lTGo4rd
 q9OkEP8vs5BVytngq/SQZA5aOST8bHMSftI+QDAfmWSQcWyWUSMDbzuWAoQ/OYRq4RnWpAo8O
 T6eDMLgsL8GABuuvnZtj5RfDsn6A4kWzbFlVocn6LChYDGd7Ppu3WeUcvx//hD/wBzUf4KFCv
 16FttBKcL8cFpkQLxf67fwCrD2Sja+gscCo2ujdwZJ/hBmzlDMZ7GPGeRQqR4bkUThwFWjOdR
 RsblMJi0EsQ3LqqLmwNJiOAbc0eUExuewlEMQw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

Use tegra124_(primary|overlay)_formats for Tegra124.

Fixes: 511c7023cf23 ("drm/tegra: dc: Support more formats")

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- re-based on top of today's next
- added my ACK

 drivers/gpu/drm/tegra/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 71152776b04c..e0ea5a46ecc9 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2015,9 +2015,9 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.coupled_pm = false,
 	.has_nvdisplay = false,
 	.num_primary_formats = ARRAY_SIZE(tegra124_primary_formats),
-	.primary_formats = tegra114_primary_formats,
+	.primary_formats = tegra124_primary_formats,
 	.num_overlay_formats = ARRAY_SIZE(tegra124_overlay_formats),
-	.overlay_formats = tegra114_overlay_formats,
+	.overlay_formats = tegra124_overlay_formats,
 	.modifiers = tegra124_modifiers,
 };
 
-- 
2.14.3
