Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbeENLnq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:43:46 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:42377 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbeENLno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:43:44 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180514114342epoutp02af4e2263ce7e11663c6decb91929d5d5~ugCWXyRdf1663216632epoutp02C
X-AuditID: b6c32a47-bc7ff70000001011-6b-5af9766dc543
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 09/14] thermal: ti-soc-thermal: use common struct
 temp_sensor_data for DRA752
Date: Mon, 14 May 2018 13:42:16 +0200
Message-id: <1526298141-14045-10-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCmqW5u2c8og0cXFS02zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsErowzk84zF8zQrej7+oexgfGDahcjJ4eEgInE3A1fGLsYuTiEBHYw
        SjQe7GSBcL4zSqy9eZ0ZpurG3b2sEIndjBJ3m/YzQTi/GCVePfzLBlLFJmAlMbF9FSOILSLg
        JjFryR8wm1lgKqPEpgn1XYwcHMIC8RIvlmeChFkEVCVmbljFCmLzCnhKTJ38jh1imZzEyWOT
        weKcQPEN7S/ZQHZJCPSwSdw/N5MVoshF4vur72wQtrDEq+NboJqlJZ6t2sgI0dDMKPFtxx6o
        FyYwSuxZLwRhW0scPn6RFeI4PomOw3/ZQY6TEOCV6GiDKvGQWPT+G9QuR4lnEx5Cg2UOo8TH
        hWdZJzBKLWBkWMUollpQnJueWmxUYKxXnJhbXJqXrpecn7uJERyXWu47GLed8znEKMDBqMTD
        G7D8R5QQa2JZcWXuIUYJDmYlEd7dRj+jhHhTEiurUovy44tKc1KLDzFKc7AoifOuUfoaJSSQ
        nliSmp2aWpBaBJNl4uCUamDUyi82Ef8VMvV4XPStxOKZVvsEbXyLg3u3aJ78989aRa9graNR
        Zn1pxETOxaJ3M155dV1hyYk6JHC6O6Cwxqa6ou/7pY+nruk3mfCJL/xSU+NeujLW6XyhZM6j
        54lCtxKFDO6Jxk13mdRm7REQd+6VRPf17ecLOUOjgnyUBZYVn/0r7VocrsRSnJFoqMVcVJwI
        ABQ1dXLHAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42I5/e+xgG5O2c8og33zBC02zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsErowzk84zF8zQrej7+oexgfGDahcjJ4eEgInEjbt7WbsYuTiEBHYy
        Srz/+oANJCEk8ItR4mhjJojNJmAlMbF9FSOILSLgJjFryR9GkAZmgamMEpM/nQJq4OAQFoiX
        eLEcrJ5FQFVi5oZVrCA2r4CnxNTJ79ghlslJnDw2GSzOCRTf0P4SapeHxO3fLWwTGHkWMDKs
        YpRMLSjOTc8tNiowykst1ytOzC0uzUvXS87P3cQIDKJth7X6dzA+XhJ/iFGAg1GJhzdg+Y8o
        IdbEsuLK3EOMEhzMSiK8u41+RgnxpiRWVqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5Ykpqd
        mlqQWgSTZeLglGpgPGvq/WSFycTPXzenCnrHHWI18Qt0+VfTLNC9wWJ630az2Ac/o9e/PfYv
        oiGxwr2w8mHSjX0RdscctDS2rL61JNE3LGOrlPvj1dLy4j+s0w7yr1yQ+cC0jnlZ4LxPqnlV
        G/cFBpzuse4zcfun5RVYGMNXLcjS9qdvYc1nLdNHehkPHy1eeDNAiaU4I9FQi7moOBEAcn77
        jB4CAAA=
X-CMS-MailID: 20180514114340epcas2p10a9a4aad3064ad752cd2bea456581a98
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180514114340epcas2p10a9a4aad3064ad752cd2bea456581a98
X-RootMTR: 20180514114340epcas2p10a9a4aad3064ad752cd2bea456581a98
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114340epcas2p10a9a4aad3064ad752cd2bea456581a98@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all struct temp_sensor_data instances for DRA752 are
identical so just use one common structure to avoid duplication.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    | 42 ++---------------
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 54 +++++-----------------
 2 files changed, 16 insertions(+), 80 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
index b7156bf..ac324b9 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
@@ -146,44 +146,12 @@
 #define DRA752_ADC_START_VALUE		540
 #define DRA752_ADC_END_VALUE		945
 
-/* DRA752.GPU temperature definitions */
+/* DRA752 GPU/MPU/CORE/DSPEVE/IVA temperature definitions */
 /* bandgap clock limits */
-#define DRA752_GPU_MAX_FREQ				1500000
-#define DRA752_GPU_MIN_FREQ				1000000
+#define DRA752_MAX_FREQ				1500000
+#define DRA752_MIN_FREQ				1000000
 /* interrupts thresholds */
-#define DRA752_GPU_T_HOT				800
-#define DRA752_GPU_T_COLD				795
-
-/* DRA752.MPU temperature definitions */
-/* bandgap clock limits */
-#define DRA752_MPU_MAX_FREQ				1500000
-#define DRA752_MPU_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define DRA752_MPU_T_HOT				800
-#define DRA752_MPU_T_COLD				795
-
-/* DRA752.CORE temperature definitions */
-/* bandgap clock limits */
-#define DRA752_CORE_MAX_FREQ				1500000
-#define DRA752_CORE_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define DRA752_CORE_T_HOT				800
-#define DRA752_CORE_T_COLD				795
-
-/* DRA752.DSPEVE temperature definitions */
-/* bandgap clock limits */
-#define DRA752_DSPEVE_MAX_FREQ				1500000
-#define DRA752_DSPEVE_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define DRA752_DSPEVE_T_HOT				800
-#define DRA752_DSPEVE_T_COLD				795
-
-/* DRA752.IVA temperature definitions */
-/* bandgap clock limits */
-#define DRA752_IVA_MAX_FREQ				1500000
-#define DRA752_IVA_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define DRA752_IVA_T_HOT				800
-#define DRA752_IVA_T_COLD				795
+#define DRA752_T_HOT				800
+#define DRA752_T_COLD				795
 
 #endif /* __DRA752_BANDGAP_H */
diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index a88a0e5..3372cd7 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -144,44 +144,12 @@
 	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_GPU_OFFSET,
 };
 
-/* Thresholds and limits for DRA752 MPU temperature sensor */
-static struct temp_sensor_data dra752_mpu_temp_sensor_data = {
-	.t_hot = DRA752_MPU_T_HOT,
-	.t_cold = DRA752_MPU_T_COLD,
-	.min_freq = DRA752_MPU_MIN_FREQ,
-	.max_freq = DRA752_MPU_MAX_FREQ,
-};
-
-/* Thresholds and limits for DRA752 GPU temperature sensor */
-static struct temp_sensor_data dra752_gpu_temp_sensor_data = {
-	.t_hot = DRA752_GPU_T_HOT,
-	.t_cold = DRA752_GPU_T_COLD,
-	.min_freq = DRA752_GPU_MIN_FREQ,
-	.max_freq = DRA752_GPU_MAX_FREQ,
-};
-
-/* Thresholds and limits for DRA752 CORE temperature sensor */
-static struct temp_sensor_data dra752_core_temp_sensor_data = {
-	.t_hot = DRA752_CORE_T_HOT,
-	.t_cold = DRA752_CORE_T_COLD,
-	.min_freq = DRA752_CORE_MIN_FREQ,
-	.max_freq = DRA752_CORE_MAX_FREQ,
-};
-
-/* Thresholds and limits for DRA752 DSPEVE temperature sensor */
-static struct temp_sensor_data dra752_dspeve_temp_sensor_data = {
-	.t_hot = DRA752_DSPEVE_T_HOT,
-	.t_cold = DRA752_DSPEVE_T_COLD,
-	.min_freq = DRA752_DSPEVE_MIN_FREQ,
-	.max_freq = DRA752_DSPEVE_MAX_FREQ,
-};
-
-/* Thresholds and limits for DRA752 IVA temperature sensor */
-static struct temp_sensor_data dra752_iva_temp_sensor_data = {
-	.t_hot = DRA752_IVA_T_HOT,
-	.t_cold = DRA752_IVA_T_COLD,
-	.min_freq = DRA752_IVA_MIN_FREQ,
-	.max_freq = DRA752_IVA_MAX_FREQ,
+/* Thresholds and limits for DRA752 temperature sensor */
+static struct temp_sensor_data dra752_temp_sensor_data = {
+	.t_hot = DRA752_T_HOT,
+	.t_cold = DRA752_T_COLD,
+	.min_freq = DRA752_MIN_FREQ,
+	.max_freq = DRA752_MAX_FREQ,
 };
 
 /*
@@ -329,7 +297,7 @@
 	.sensors = {
 		{
 		.registers = &dra752_mpu_temp_sensor_registers,
-		.ts_data = &dra752_mpu_temp_sensor_data,
+		.ts_data = &dra752_temp_sensor_data,
 		.domain = "cpu",
 		.register_cooling = ti_thermal_register_cpu_cooling,
 		.unregister_cooling = ti_thermal_unregister_cpu_cooling,
@@ -338,28 +306,28 @@
 		},
 		{
 		.registers = &dra752_gpu_temp_sensor_registers,
-		.ts_data = &dra752_gpu_temp_sensor_data,
+		.ts_data = &dra752_temp_sensor_data,
 		.domain = "gpu",
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
 		{
 		.registers = &dra752_core_temp_sensor_registers,
-		.ts_data = &dra752_core_temp_sensor_data,
+		.ts_data = &dra752_temp_sensor_data,
 		.domain = "core",
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
 		{
 		.registers = &dra752_dspeve_temp_sensor_registers,
-		.ts_data = &dra752_dspeve_temp_sensor_data,
+		.ts_data = &dra752_temp_sensor_data,
 		.domain = "dspeve",
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
 		{
 		.registers = &dra752_iva_temp_sensor_registers,
-		.ts_data = &dra752_iva_temp_sensor_data,
+		.ts_data = &dra752_temp_sensor_data,
 		.domain = "iva",
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
-- 
1.9.1
