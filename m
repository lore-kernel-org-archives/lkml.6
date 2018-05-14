Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeENLph (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:45:37 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22566 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbeENLnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:43:41 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180514114339epoutp0161ae9baa0dbc7f5d5a372b902966f831~ugCTmjewA0604106041epoutp01l
X-AuditID: b6c32a36-b6dff70000001027-7c-5af9766a6959
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 08/14] thermal: ti-soc-thermal: use common struct
 temp_sensor_data for OMAP5
Date: Mon, 14 May 2018 13:42:15 +0200
Message-id: <1526298141-14045-9-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCmrm5W2c8og44bxhYbZ6xntZh/5Rqr
        xantTUwWl3fNYbOYvaSfxeJz7xFGiycP+9gc2D12zrrL7rF4z0smj74tqxg9jt/YzuTxeZNc
        AGsUl01Kak5mWWqRvl0CV8bmxd1sBY9UK6ZOv87ewPhRvouRk0NCwERi0dGjzF2MXBxCAjsY
        JRY+u8wC4XxnlHj3tZERpqpnzQZWiMRuRonrZ5rZIZxfjBJ31pxhB6liE7CSmNi+CqxDRMBN
        YtaSP2A2s8BURolNE+pBbGGBOIntUx6wgtgsAqoS395uBrN5BTwkdrxcywyxTU7i5LHJYHFO
        AU+JDe0v2SDiPWwSq3pEIWwXiSdv2pggbGGJV8e3AN3AAWRLS1w6agtym4RAM6PEtx17oGZO
        YJTYs14IwraWOHz8IivEbXxAX/awQvTySnS0QZV4SCxsPQ813lHixrd/jBD/zmGUOH5tH9sE
        RqkFjAyrGMVSC4pz01OLDQuM9IoTc4tL89L1kvNzNzGCo1LLbAfjonM+hxgFOBiVeHgDlv+I
        EmJNLCuuzD3EKMHBrCTCu9voZ5QQb0piZVVqUX58UWlOavEhRmkOFiVx3jlKX6OEBNITS1Kz
        U1MLUotgskwcnFINjNK3jzrG23swelxc19LjL3/w0tf21muMb9Q/tBY6Bi09ZMIiGGO9/fn/
        gjcpSx74vV3NznqMQ/Pbgpnv2TkOsfXYbKqYxf7LZafb49L/ZRq9J4LedAoocLZpe/+u3bjs
        yJeHGYunfIkPWqrOL5PVzOwWv1d60RWVc4LfLui0CPsWZv28laN7UImlOCPRUIu5qDgRAIRK
        9cnGAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42I5/e+xgG5m2c8og6cPJS02zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsErozNi7vZCh6pVkydfp29gfGjfBcjJ4eEgIlEz5oNrF2MXBxCAjsZ
        JY5POsMO4fxilJh4bTIbSBWbgJXExPZVjCC2iICbxKwlfxhBipgFpjJKTP50CqxIWCBOYvuU
        B6wgNouAqsS3t5vBbF4BD4kdL9cyQ6yTkzh5bDJYnFPAU2JD+0uwXiGgmtu/W9gmMPIsYGRY
        xSiZWlCcm55bbFRgmJdarlecmFtcmpeul5yfu4kRGEjbDmv17WC8vyT+EKMAB6MSD++KlT+i
        hFgTy4orcw8xSnAwK4nw7jb6GSXEm5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs
        1NSC1CKYLBMHp1QDo/D6TXV8t/q0bVRsnKZtt+Y92F9ps7dw782Jen+juVwOs7cnxaje4f4f
        m8IalWe2Q99Rqm+hyDTJQ5HGwk38XA8cgzSq9/wUrWJW0fy7ctVO34caH5YkrfnsmDvNWPO9
        6vyt139OPBe7LfSYqdu63oKf23OC3s/c1bWh+nMbl4QL34d01n4jJZbijERDLeai4kQACLax
        siACAAA=
X-CMS-MailID: 20180514114337epcas1p1ba67790ed771ab09c0be25712c8b385f
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180514114337epcas1p1ba67790ed771ab09c0be25712c8b385f
X-RootMTR: 20180514114337epcas1p1ba67790ed771ab09c0be25712c8b385f
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114337epcas1p1ba67790ed771ab09c0be25712c8b385f@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all struct temp_sensor_data instances for OMAP5 are
identical so just use one common structure to avoid duplication.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    | 42 ++++++----------------
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h  | 34 ++++--------------
 2 files changed, 18 insertions(+), 58 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index a7ca3b6..defa714 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -114,34 +114,14 @@
 	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_CORE,
 };
 
-/* Thresholds and limits for OMAP5430 MPU temperature sensor */
-static struct temp_sensor_data omap5430_mpu_temp_sensor_data = {
-	.tshut_hot = OMAP5430_MPU_TSHUT_HOT,
-	.tshut_cold = OMAP5430_MPU_TSHUT_COLD,
-	.t_hot = OMAP5430_MPU_T_HOT,
-	.t_cold = OMAP5430_MPU_T_COLD,
-	.min_freq = OMAP5430_MPU_MIN_FREQ,
-	.max_freq = OMAP5430_MPU_MAX_FREQ,
-};
-
-/* Thresholds and limits for OMAP5430 GPU temperature sensor */
-static struct temp_sensor_data omap5430_gpu_temp_sensor_data = {
-	.tshut_hot = OMAP5430_GPU_TSHUT_HOT,
-	.tshut_cold = OMAP5430_GPU_TSHUT_COLD,
-	.t_hot = OMAP5430_GPU_T_HOT,
-	.t_cold = OMAP5430_GPU_T_COLD,
-	.min_freq = OMAP5430_GPU_MIN_FREQ,
-	.max_freq = OMAP5430_GPU_MAX_FREQ,
-};
-
-/* Thresholds and limits for OMAP5430 CORE temperature sensor */
-static struct temp_sensor_data omap5430_core_temp_sensor_data = {
-	.tshut_hot = OMAP5430_CORE_TSHUT_HOT,
-	.tshut_cold = OMAP5430_CORE_TSHUT_COLD,
-	.t_hot = OMAP5430_CORE_T_HOT,
-	.t_cold = OMAP5430_CORE_T_COLD,
-	.min_freq = OMAP5430_CORE_MIN_FREQ,
-	.max_freq = OMAP5430_CORE_MAX_FREQ,
+/* Thresholds and limits for OMAP5430 MPU/GPU/CORE temperature sensor */
+static struct temp_sensor_data omap5430_temp_sensor_data = {
+	.tshut_hot = OMAP5430_TSHUT_HOT,
+	.tshut_cold = OMAP5430_TSHUT_COLD,
+	.t_hot = OMAP5430_T_HOT,
+	.t_cold = OMAP5430_T_COLD,
+	.min_freq = OMAP5430_MIN_FREQ,
+	.max_freq = OMAP5430_MAX_FREQ,
 };
 
 /*
@@ -264,7 +244,7 @@
 	.sensors = {
 		{
 		.registers = &omap5430_mpu_temp_sensor_registers,
-		.ts_data = &omap5430_mpu_temp_sensor_data,
+		.ts_data = &omap5430_temp_sensor_data,
 		.domain = "cpu",
 		.register_cooling = ti_thermal_register_cpu_cooling,
 		.unregister_cooling = ti_thermal_unregister_cpu_cooling,
@@ -273,14 +253,14 @@
 		},
 		{
 		.registers = &omap5430_gpu_temp_sensor_registers,
-		.ts_data = &omap5430_gpu_temp_sensor_data,
+		.ts_data = &omap5430_temp_sensor_data,
 		.domain = "gpu",
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_5430_GPU,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_5430_GPU,
 		},
 		{
 		.registers = &omap5430_core_temp_sensor_registers,
-		.ts_data = &omap5430_core_temp_sensor_data,
+		.ts_data = &omap5430_temp_sensor_data,
 		.domain = "core",
 		},
 	},
diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
index e931ae0..98438cf 100644
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
@@ -115,34 +115,14 @@
 #define OMAP5430_ADC_START_VALUE			540
 #define OMAP5430_ADC_END_VALUE				945
 
-/* OMAP5430.GPU temperature definitions */
+/* OMAP5430 sensor temperature definitions */
 /* bandgap clock limits */
-#define OMAP5430_GPU_MAX_FREQ				1500000
-#define OMAP5430_GPU_MIN_FREQ				1000000
+#define OMAP5430_MAX_FREQ				1500000
+#define OMAP5430_MIN_FREQ				1000000
 /* interrupts thresholds */
-#define OMAP5430_GPU_TSHUT_HOT				915
-#define OMAP5430_GPU_TSHUT_COLD				900
-#define OMAP5430_GPU_T_HOT				800
-#define OMAP5430_GPU_T_COLD				795
-
-/* OMAP5430.MPU temperature definitions */
-/* bandgap clock limits */
-#define OMAP5430_MPU_MAX_FREQ				1500000
-#define OMAP5430_MPU_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define OMAP5430_MPU_TSHUT_HOT				915
-#define OMAP5430_MPU_TSHUT_COLD				900
-#define OMAP5430_MPU_T_HOT				800
-#define OMAP5430_MPU_T_COLD				795
-
-/* OMAP5430.CORE temperature definitions */
-/* bandgap clock limits */
-#define OMAP5430_CORE_MAX_FREQ				1500000
-#define OMAP5430_CORE_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define OMAP5430_CORE_TSHUT_HOT				915
-#define OMAP5430_CORE_TSHUT_COLD			900
-#define OMAP5430_CORE_T_HOT				800
-#define OMAP5430_CORE_T_COLD				795
+#define OMAP5430_TSHUT_HOT				915
+#define OMAP5430_TSHUT_COLD				900
+#define OMAP5430_T_HOT					800
+#define OMAP5430_T_COLD					795
 
 #endif /* __OMAP5XXX_BANDGAP_H */
-- 
1.9.1
