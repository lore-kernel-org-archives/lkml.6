Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeDKG5S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:57:18 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:5872
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752491AbeDKG5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:57:13 -0400
From: Ran Wang <ran.wang_1@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>
CC: Zhao Chenhui <chenhui.zhao@freescale.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2 2/6] drivers/soc/fsl: add EPU FSM configuration for deep sleep
Date: Wed, 11 Apr 2018 14:35:47 +0800
Message-ID: <20180411063551.30368-2-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180411063551.30368-1-ran.wang_1@nxp.com>
References: <20180411063551.30368-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:192.88.158.2;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(396003)(376002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(76176011)(1076002)(305945005)(8676002)(97736004)(59450400001)(356003)(7416002)(51416003)(498600001)(4326008)(106466001)(104016004)(476003)(8656006)(36756003)(126002)(86362001)(5660300001)(110136005)(54906003)(68736007)(81156014)(81166006)(105606002)(16586007)(316002)(50226002)(8936002)(69596002)(53936002)(575784001)(6346003)(2616005)(77096007)(2906002)(486006)(11346002)(26005)(48376002)(6666003)(446003)(6636002)(50466002)(336012)(47776003)(2004002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR03MB393;H:az84smr01.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC015;1:iNaT/KGTQ1nyJshtaYgo454PyD0K6sBdZZFYFH8IaKWVf8knkFO3eB93Y9i31cLf+FjdfHum4XuB5TXnvEnu19UNUZ2V4YOV4/Hy+W7qUaZ8vPrO/P5++LkJRgL0H8yF
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328)(7153060);SRVR:BY2PR03MB393;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;3:ZBBek5D/5jxPhRyNZPNf6bokNLowO3TPy/FbTLRXoGj/vDBP8NMfr+Og6/YiJY4MKglHllUQUu1m4AtWUfE3z6OJ+3JB0GWz3kx4ByMiNirxGdLd72gfpNs8VTKMhC10JYfsqzfZSlW8Z5cxBAFum+KUnO7MFhj2IH1v54GzicP1oK4RhmcTeaAV2mUDfhmjLUjF9eZDyo0FcuCDPFn7Tw4kxW4GhveltWNMyO02uAg3Ru3prlrrsl1BZWSv/MIfdWAGROHIxdjWEvR28k8f+hmemO+O0PaxUCxJzcC7PJIWJ06OJx7hRZ+sfxig8V8zzEd2aOLHdZn8TO1URYCR7SX4NxoYqamuBlVwY4hhARs=;25:9k3aqKO4rUsSJjvvTZ0EYYxHBtBf1X2XoQWp/uvZVtmxg76Yps5TsoNmYdldHc3rwJFOTAw85TkaU/fedf0ZAtw7t6AneoqeDgi7yRI9YVibTIBxJEdNdUAsPrONEBS2y2WgpgRnqxqRT/7rpw+fFS0U5E/ill5DAn8IjKAFAdlGTwfPUz2jHZKa5uH88btCyyXvPgONtQSbpIKk+WkBb05M387ZP0CTQfKRAgCTOaw3g94+PzUfG+kaxKO/AqXIHjsML894SNc0ah4ARX141POvAUDNJlMD/PZSLdmEe4WsCoGL9kxiLNZBnoiwJSewP3ix6aQ69+wmmqDAh9nb3g==
X-MS-TrafficTypeDiagnostic: BY2PR03MB393:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;31:I4o4cVAvar9BrQbqmBfgtBT/HZQCi+Lym7MPqUizH0No6BLx92UVJbu59Dezu2E7Qe7otsdbppXhYhcs7Pb2YNgtEGt/h14QhSgE6tS6HQyaTYsCDeti24qnKw/lHOsiz/dWYPZ2jEaHR8vZUPHNFgR0dN/PI959MJuz/RtxuX2M30uvqECQmKLre+ZssJkNvwcivRyxWZAZVk1J0uo+JWm1JJDjreD7XWctWlQEdG8=;20:j8FNgRaqjzkTrmHxvWpgow8E3ODfGQni/E2h1WvpQcQWlcjsoQV8b2cd/SSuy45/dX0Xf6nOWrrpA3hRbo68jNKo4e9ioGlFUbtG0t9AWQo/gj3OydWnpJHfz3DkZlQ5UEir9gYCrAVfki4syRqguTKLo/oZQe84yoXE+U6V+gOyoYDj3Pq+xb8KSComelAsb6J0BkIKRaQgHMUYUq1JYvXgK4q+gE2QPnIdjL5s3vZSX5rpzrvZI+ZZqrPqdZNbQG67fQnRDTKrdqT4zcKyH3pMoHQCKugwkUcoFFG4O79tM6mIVYIaAJeTGMkaHuKrB+FticVo3fipNm9g33zdd8orXttKU+vKcjKZfFkB4vxV0IR7ZjyIeYIQLfSJa3Ku5I3N+QrcFlW9p4nF2d22FSINDTpP6YElxtf2o8EC9+p6BlBlh3SBaP4k5+hS/Q6XFdDB78dEkhX5ng/ouAYsuseSSlWybnjPuSXj/3h/RG4nGrrH6v1hjy00HkR2OSDGxUjptED15QY/Sps3SlEX51o5QcCJU+6N+mYS+oj9sFu1EgLZEEK1VmnHf2WGSGqM2qwwWjd03tnUfTg4NKWqK0ih2k6JRniqyNZMSgiMUOM=
X-Microsoft-Antispam-PRVS: <BY2PR03MB3934D8D1DCDFB409CC00317F1BD0@BY2PR03MB393.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR03MB393;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB393;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;4:FPUWK7paSau3FVz1pbBPZ1l0p9zAdIxwBUcRfSJXPGVMI1uu1szbIU9dA4dMeeaJukIc4CGeWAXtVYnUjcnIELRRq8tmcualSRAhUxAXOcEW9fZBPfndcRhz/6zsbzTYyBYQ2eFpCNK+dTyebdchGgCRHlwClTYA8POF/YxN8nzSgJ9x6sElCOBU+clV+W+Jv7iD81/Kyq2RVypMuZxxeXNLZ9gQPFL3mgYtJ9wm8CbeOj+8HscoPZKW17hwCeCTOXvcZMbBwm7NdUrT2OOrCmS0auelv9jCL/h+wMzcclPOyF788LeA79QgdrfM536idBx/+2cUYBwebhfafoRc/piCOsIbde4YjhxRMSObxYU=
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB393;23:C485TKB8myTXJhaCuerDXL1IjlZDZvbONFIcnnDpH9?=
 =?us-ascii?Q?fYw1uDL/sJzkVc3TPnKbK2B1iACI7mVq6bKBywWOkqcciZTv+PKtw9vaHY/d?=
 =?us-ascii?Q?82K2cHduW0WVvR/Eb7EGhShQIERCVdHqcx8be1k7InSQW3xTRVF7i3bgdTp3?=
 =?us-ascii?Q?ceCSjC9BgmynbOxnlbs1bVuVUdGY3OYwY2gweFSbHmwQyx9x4ENo3wRCm8Bl?=
 =?us-ascii?Q?nfEZzs1VmakjGtr7H3xeLo1uTeebLlK1kuZcxXHmBdhCR3XAPAZRNqt+GvF0?=
 =?us-ascii?Q?B+J8XGNqihepF6GvkFeUmHf2IrhKGi3CYhN8bQPUnO4VBXp+VQSB46kLq+CU?=
 =?us-ascii?Q?qI0ScITjzRxLBZzI2u1aHoZ2XICKtHR0ZiyqK/ceTa2BAsOTv7946cQTSn+u?=
 =?us-ascii?Q?yFa9EtPp5ALnmJe0zMupMdwxQYhPaOpKOwuZsSkhkRVtWCoHdzDj4xKltUSi?=
 =?us-ascii?Q?GHK3KKFZObGdE5Zzfe3YNkuhByLMOi2i3T/dDLjYttIhe23N+4vMbquzJWQd?=
 =?us-ascii?Q?8bnt+qhqu41ddqoDhwF7yT5yDzc5uf64AAkSFy9GKfWhB9VGH6FcR4zPOE5l?=
 =?us-ascii?Q?B3O8klzzyUPLKYYx74F9mEIG/PR3aPxh2cIp/2EMs7gOB1J81caWv+q0mwC2?=
 =?us-ascii?Q?WVxGPVon0ZUnogTy/Ftv0IlOlzULvzJU+MuiO9ZhAv28LoQkiLeACp7/9pz/?=
 =?us-ascii?Q?qpSEid+/kd8EJ9NTHX6Jveu98GESiD5rRbVNzqU8KPZwAvI7t9uqDlx7e1Xt?=
 =?us-ascii?Q?oCCNnCWcZs54i4a1ZQ5+z40lLAnJLez/I0rwfrXw6ponaeL3ET1ajO6imgFk?=
 =?us-ascii?Q?gM05hhTI9TCySNFJgDMnisqIVhIGY+LSFve2MuDFlG3eUpeu3olVdf6AQyJa?=
 =?us-ascii?Q?t4tBAehjAPN3aI5klHaA9NBYhQAnigrIf9abm7i0mhuWhsQ69IAJFcBaM15u?=
 =?us-ascii?Q?/gSMS41xfYq8UNsl0gQ5ObfIMFfpM1evjJ/gZ4xs4piddaBlLhpX2UKp5qES?=
 =?us-ascii?Q?4oJoP34HQdbDR+2UehAfF9cb3DPScRjQlzsgErAMof2w+ltbU+qvmHSh6GVI?=
 =?us-ascii?Q?PLyUYShVn46tUr385QXU0aoKM+jfCVgvmWHzOQOFoGljmHX8VS7TU47Wsmdx?=
 =?us-ascii?Q?mmQtABHXRxE+nSg9bHqBwNpC359C5TdzZxFXQuGHWyJduy//pCa7N36K5tE1?=
 =?us-ascii?Q?xDR2kfm/uW6l4JWw82BGpGLdbURdbdkG0qK3KNWMMsqJ7NaOaXXKf56OHl87?=
 =?us-ascii?Q?lK1Z/BiFvMC8wNwmWpnMr7VozXeY1yXNUMAzFcMkKA7vyi97XIAOSMfkZMPo?=
 =?us-ascii?Q?1+HJUg0vgekMj9JCqTNyzVZ0tl3QXdSe3kcCzm6OEe?=
X-Microsoft-Antispam-Message-Info: Qno9Q/SD14uVZuLB8T6zd+Y5T4HWs/HXtfJvJjckONacdoPBu3dybXFnzPsSqjo5BuMjwbj/rgkT2tDpDDvXnsE21kLsrDw9pSMeMGw8yFrWuKuYvSBXz/1Z5a9A6FCjtRNw5VuvQhUeh/IALatLyV2GQU3zU1VdnTGLspqEBfd1ksuu7bFi6TGHh1fXZPiA
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;6:VZCHXdWyiItZykKZsuQzMLFJxV1nQ8Iz4IuRPk/qt/wNM6+OMqLqm04VHnX7qJBGaSwJRuKt2sefXyWYzXjWG3Aq0QqarEu6T+zeFWb35n9C12wGALfTw+q51pdj/Tr6Oyqw0xMv+4reoyXKHxksXrXvVfZC70JXijfHTcIZzOyO59B91aT6kYjyTqRwUuXq+N18MpZeoZUCuccOamdtb0JrW1/hQSYGFUaSveBZD4zblA2TJzF4edD8P7zNfAosuifUrVoRggcxtx7ry+t7Q5zpJw1bdAd87gs9HkHqm6ZdcWlRJV6kq8itzx+mf95seKN32j41pazZBEDliTjhFfJbhyyMF7yRRWio7o/o+p12s/0hNZ//IUWt6TB6cN6dvoaVJX59kVc4ZQVBl4vQowGz5mhDFJjXRdaaicm4/5FSnziC6ASlMLyYYEx0cYNrohV5vWwRs8DLLVw9cnHTaA==;5:qMBe4S0jcnb/Me4WlqJod4TZM+IdNq4JajobqDF9EdUgeNObTFFXJd/6eJd+clMoZ0KqUthSGNPqOX1oYhOHqim3+jnGmmW5OBp8BckfSHmuW1vEJJnj5Mm/GAFcGvtogsV3DEeIZ60LhT3MvzUcvwut4VEmEBAuELkLBcdG3wI=;24:mjElXU1ecGuExvC3bHOWwvy0VSqVYX9Eh6YbS6q2lZxK6PwJCxtBVL45jOk8IYjwk08IbzxX7GdMJtqp4lwv/PX0WcoeVlcdySfxrKEtSRE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB393;7:624FsTRPTzyfTGLpd5CMZEYxLzPzXlKw9tqRhhy9ohUtHyJ/AF930qUiv6RjqnMN01IVqxiPY/q/O73B2WgOn3j6RqPYYmQpBp14xzRMuT7ayeUr+WD7+kVlTdaP5BUcMd5J6dne60zeTb4wD3ilypKTw1Fao1h10azcPljaHC9O39PRqQ0GduVs0oHYDwzgT4+5cEvyT1gm9UMDonbbwSczXyehW4OYeUqlRXcvuIyqvxJVzvz3uJurMjoESkcH
X-MS-Office365-Filtering-Correlation-Id: 23b23f56-c67f-46f8-0fb0-08d59f797198
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 06:57:08.5011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b23f56-c67f-46f8-0fb0-08d59f797198
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[192.88.158.2];Helo=[az84smr01.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB393
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the last stage of deep sleep, software will trigger a Finite
State Machine (FSM) to control the hardware procedure, such a
board isolation, killing PLLs, removing power, and so on.

When the system is waked up by an interrupt, the FSM controls
the hardware to complete the early resume procedure.

This patch configure the EPU FSM preparing for deep sleep.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - Resolve warnning of scripts/checkpatch.pl

 drivers/soc/fsl/Kconfig     |    7 +
 drivers/soc/fsl/Makefile    |    1 +
 drivers/soc/fsl/sleep_fsm.c |  279 +++++++++++++++++++++++++++++++++++++++++++
 drivers/soc/fsl/sleep_fsm.h |  130 ++++++++++++++++++++
 4 files changed, 417 insertions(+), 0 deletions(-)
 create mode 100644 drivers/soc/fsl/sleep_fsm.c
 create mode 100644 drivers/soc/fsl/sleep_fsm.h

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 7a9fb9b..4222bd5 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -16,3 +16,10 @@ config FSL_GUTS
 	  Initially only reading SVR and registering soc device are supported.
 	  Other guts accesses, such as reading RCW, should eventually be moved
 	  into this driver as well.
+
+config FSL_SLEEP_FSM
+	bool
+	help
+	  This driver configures a hardware FSM (Finite State Machine) for deep sleep.
+	  The FSM is used to finish clean-ups at the last stage of system entering deep
+	  sleep, and also wakes up system when a wake up event happens.
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 44b3beb..28c38c3 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
+obj-$(CONFIG_FSL_SLEEP_FSM)	+= sleep_fsm.o
diff --git a/drivers/soc/fsl/sleep_fsm.c b/drivers/soc/fsl/sleep_fsm.c
new file mode 100644
index 0000000..a303098
--- /dev/null
+++ b/drivers/soc/fsl/sleep_fsm.c
@@ -0,0 +1,279 @@
+/*
+ * deep sleep FSM (finite-state machine) configuration
+ *
+ * Copyright 2018 NXP
+ *
+ * Author: Hongbo Zhang <hongbo.zhang@freescale.com>
+ *         Chenhui Zhao <chenhui.zhao@freescale.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the above-listed copyright holders nor the
+ *	 names of any contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/types.h>
+
+#include "sleep_fsm.h"
+/*
+ * These values are from chip's reference manual. For example,
+ * the values for T1040 can be found in "8.4.3.8 Programming
+ * supporting deep sleep mode" of Chapter 8 "Run Control and
+ * Power Management (RCPM)".
+ * The default value can be applied to T104x, LS1021.
+ */
+struct fsm_reg_vals epu_default_val[] = {
+	/* EPGCR (Event Processor Global Control Register) */
+	{EPGCR, 0},
+	/* EPECR (Event Processor Event Control Registers) */
+	{EPECR0 + EPECR_STRIDE * 0, 0},
+	{EPECR0 + EPECR_STRIDE * 1, 0},
+	{EPECR0 + EPECR_STRIDE * 2, 0xF0004004},
+	{EPECR0 + EPECR_STRIDE * 3, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 4, 0x20000084},
+	{EPECR0 + EPECR_STRIDE * 5, 0x08000004},
+	{EPECR0 + EPECR_STRIDE * 6, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 7, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 8, 0x60000084},
+	{EPECR0 + EPECR_STRIDE * 9, 0x08000084},
+	{EPECR0 + EPECR_STRIDE * 10, 0x42000084},
+	{EPECR0 + EPECR_STRIDE * 11, 0x90000084},
+	{EPECR0 + EPECR_STRIDE * 12, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 13, 0x08000084},
+	{EPECR0 + EPECR_STRIDE * 14, 0x02000084},
+	{EPECR0 + EPECR_STRIDE * 15, 0x00000004},
+	/*
+	 * EPEVTCR (Event Processor EVT Pin Control Registers)
+	 * SCU8 triger EVT2, and SCU11 triger EVT9
+	 */
+	{EPEVTCR0 + EPEVTCR_STRIDE * 0, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 1, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 2, 0x80000001},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 3, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 4, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 5, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 6, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 7, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 8, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 9, 0xB0000001},
+	/* EPCMPR (Event Processor Counter Compare Registers) */
+	{EPCMPR0 + EPCMPR_STRIDE * 0, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 1, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 2, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 3, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 4, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 5, 0x00000020},
+	{EPCMPR0 + EPCMPR_STRIDE * 6, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 7, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 8, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 9, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 10, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 11, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 12, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 13, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 14, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 15, 0x000000FF},
+	/* EPCCR (Event Processor Counter Control Registers) */
+	{EPCCR0 + EPCCR_STRIDE * 0, 0},
+	{EPCCR0 + EPCCR_STRIDE * 1, 0},
+	{EPCCR0 + EPCCR_STRIDE * 2, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 3, 0},
+	{EPCCR0 + EPCCR_STRIDE * 4, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 5, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 6, 0},
+	{EPCCR0 + EPCCR_STRIDE * 7, 0},
+	{EPCCR0 + EPCCR_STRIDE * 8, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 9, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 10, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 11, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 12, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 13, 0},
+	{EPCCR0 + EPCCR_STRIDE * 14, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 15, 0x92840000},
+	/* EPSMCR (Event Processor SCU Mux Control Registers) */
+	{EPSMCR0 + EPSMCR_STRIDE * 0, 0},
+	{EPSMCR0 + EPSMCR_STRIDE * 1, 0},
+	{EPSMCR0 + EPSMCR_STRIDE * 2, 0x6C700000},
+	{EPSMCR0 + EPSMCR_STRIDE * 3, 0x2F000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 4, 0x002F0000},
+	{EPSMCR0 + EPSMCR_STRIDE * 5, 0x00002E00},
+	{EPSMCR0 + EPSMCR_STRIDE * 6, 0x7C000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 7, 0x30000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 8, 0x64300000},
+	{EPSMCR0 + EPSMCR_STRIDE * 9, 0x00003000},
+	{EPSMCR0 + EPSMCR_STRIDE * 10, 0x65000030},
+	{EPSMCR0 + EPSMCR_STRIDE * 11, 0x31740000},
+	{EPSMCR0 + EPSMCR_STRIDE * 12, 0x7F000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 13, 0x00003100},
+	{EPSMCR0 + EPSMCR_STRIDE * 14, 0x00000031},
+	{EPSMCR0 + EPSMCR_STRIDE * 15, 0x76000000},
+	/* EPACR (Event Processor Action Control Registers) */
+	{EPACR0 + EPACR_STRIDE * 0, 0},
+	{EPACR0 + EPACR_STRIDE * 1, 0},
+	{EPACR0 + EPACR_STRIDE * 2, 0},
+	{EPACR0 + EPACR_STRIDE * 3, 0x00000080},
+	{EPACR0 + EPACR_STRIDE * 4, 0},
+	{EPACR0 + EPACR_STRIDE * 5, 0x00000040},
+	{EPACR0 + EPACR_STRIDE * 6, 0},
+	{EPACR0 + EPACR_STRIDE * 7, 0},
+	{EPACR0 + EPACR_STRIDE * 8, 0},
+	{EPACR0 + EPACR_STRIDE * 9, 0x0000001C},
+	{EPACR0 + EPACR_STRIDE * 10, 0x00000020},
+	{EPACR0 + EPACR_STRIDE * 11, 0},
+	{EPACR0 + EPACR_STRIDE * 12, 0x00000003},
+	{EPACR0 + EPACR_STRIDE * 13, 0x06000000},
+	{EPACR0 + EPACR_STRIDE * 14, 0x04000000},
+	{EPACR0 + EPACR_STRIDE * 15, 0x02000000},
+	/* EPIMCR (Event Processor Input Mux Control Registers) */
+	{EPIMCR0 + EPIMCR_STRIDE * 0, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 1, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 2, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 3, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 4, 0x44000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 5, 0x40000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 6, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 7, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 8, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 9, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 10, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 11, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 12, 0x44000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 13, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 14, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 15, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 16, 0x6A000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 17, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 18, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 19, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 20, 0x48000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 21, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 22, 0x6C000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 23, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 24, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 25, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 26, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 27, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 28, 0x76000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 29, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 30, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 31, 0x76000000},
+	/* EPXTRIGCR (Event Processor Crosstrigger Control Register) */
+	{EPXTRIGCR, 0x0000FFDF},
+	/* end */
+	{FSM_END_FLAG, 0},
+};
+
+struct fsm_reg_vals npc_default_val[] = {
+	/* NPC triggered Memory-Mapped Access Registers */
+	{NCR, 0x80000000},
+	{MCCR1, 0},
+	{MCSR1, 0},
+	{MMAR1LO, 0},
+	{MMAR1HI, 0},
+	{MMDR1, 0},
+	{MCSR2, 0},
+	{MMAR2LO, 0},
+	{MMAR2HI, 0},
+	{MMDR2, 0},
+	{MCSR3, 0x80000000},
+	{MMAR3LO, 0x000E2130},
+	{MMAR3HI, 0x00030000},
+	{MMDR3, 0x00020000},
+	/* end */
+	{FSM_END_FLAG, 0},
+};
+
+/**
+ * fsl_fsm_setup - Configure EPU's FSM registers
+ * @base: the base address of registers
+ * @val: Pointer to address-value pairs for FSM registers
+ */
+void fsl_fsm_setup(void __iomem *base, struct fsm_reg_vals *val)
+{
+	struct fsm_reg_vals *data = val;
+
+	WARN_ON(!base || !data);
+	while (data->offset != FSM_END_FLAG) {
+		iowrite32be(data->value, base + data->offset);
+		data++;
+	}
+}
+
+void fsl_epu_setup_default(void __iomem *epu_base)
+{
+	fsl_fsm_setup(epu_base, epu_default_val);
+}
+
+void fsl_npc_setup_default(void __iomem *npc_base)
+{
+	fsl_fsm_setup(npc_base, npc_default_val);
+}
+
+void fsl_epu_clean_default(void __iomem *epu_base)
+{
+	u32 offset;
+
+	/* follow the exact sequence to clear the registers */
+	/* Clear EPACRn */
+	for (offset = EPACR0; offset <= EPACR15; offset += EPACR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPEVTCRn */
+	for (offset = EPEVTCR0; offset <= EPEVTCR9; offset += EPEVTCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPGCR */
+	iowrite32be(0, epu_base + EPGCR);
+
+	/* Clear EPSMCRn */
+	for (offset = EPSMCR0; offset <= EPSMCR15; offset += EPSMCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPCCRn */
+	for (offset = EPCCR0; offset <= EPCCR31; offset += EPCCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPCMPRn */
+	for (offset = EPCMPR0; offset <= EPCMPR31; offset += EPCMPR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPCTRn */
+	for (offset = EPCTR0; offset <= EPCTR31; offset += EPCTR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPIMCRn */
+	for (offset = EPIMCR0; offset <= EPIMCR31; offset += EPIMCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPXTRIGCRn */
+	iowrite32be(0, epu_base + EPXTRIGCR);
+
+	/* Clear EPECRn */
+	for (offset = EPECR0; offset <= EPECR15; offset += EPECR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+}
diff --git a/drivers/soc/fsl/sleep_fsm.h b/drivers/soc/fsl/sleep_fsm.h
new file mode 100644
index 0000000..e0013c0
--- /dev/null
+++ b/drivers/soc/fsl/sleep_fsm.h
@@ -0,0 +1,130 @@
+/*
+ * deep sleep FSM (finite-state machine) configuration
+ *
+ * Copyright 2018 NXP
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the above-listed copyright holders nor the
+ *	 names of any contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _FSL_SLEEP_FSM_H
+#define _FSL_SLEEP_FSM_H
+
+#define FSL_STRIDE_4B	4
+#define FSL_STRIDE_8B	8
+
+/* End flag */
+#define FSM_END_FLAG		0xFFFFFFFFUL
+
+/* Block offsets */
+#define RCPM_BLOCK_OFFSET	0x00022000
+#define EPU_BLOCK_OFFSET	0x00000000
+#define NPC_BLOCK_OFFSET	0x00001000
+
+/* EPGCR (Event Processor Global Control Register) */
+#define EPGCR		0x000
+
+/* EPEVTCR0-9 (Event Processor EVT Pin Control Registers) */
+#define EPEVTCR0	0x050
+#define EPEVTCR9	0x074
+#define EPEVTCR_STRIDE	FSL_STRIDE_4B
+
+/* EPXTRIGCR (Event Processor Crosstrigger Control Register) */
+#define EPXTRIGCR	0x090
+
+/* EPIMCR0-31 (Event Processor Input Mux Control Registers) */
+#define EPIMCR0		0x100
+#define EPIMCR31	0x17C
+#define EPIMCR_STRIDE	FSL_STRIDE_4B
+
+/* EPSMCR0-15 (Event Processor SCU Mux Control Registers) */
+#define EPSMCR0		0x200
+#define EPSMCR15	0x278
+#define EPSMCR_STRIDE	FSL_STRIDE_8B
+
+/* EPECR0-15 (Event Processor Event Control Registers) */
+#define EPECR0		0x300
+#define EPECR15		0x33C
+#define EPECR_STRIDE	FSL_STRIDE_4B
+
+/* EPACR0-15 (Event Processor Action Control Registers) */
+#define EPACR0		0x400
+#define EPACR15		0x43C
+#define EPACR_STRIDE	FSL_STRIDE_4B
+
+/* EPCCRi0-15 (Event Processor Counter Control Registers) */
+#define EPCCR0		0x800
+#define EPCCR15		0x83C
+#define EPCCR31		0x87C
+#define EPCCR_STRIDE	FSL_STRIDE_4B
+
+/* EPCMPR0-15 (Event Processor Counter Compare Registers) */
+#define EPCMPR0		0x900
+#define EPCMPR15	0x93C
+#define EPCMPR31	0x97C
+#define EPCMPR_STRIDE	FSL_STRIDE_4B
+
+/* EPCTR0-31 (Event Processor Counter Register) */
+#define EPCTR0		0xA00
+#define EPCTR31		0xA7C
+#define EPCTR_STRIDE	FSL_STRIDE_4B
+
+/* NPC triggered Memory-Mapped Access Registers */
+#define NCR		0x000
+#define MCCR1		0x0CC
+#define MCSR1		0x0D0
+#define MMAR1LO		0x0D4
+#define MMAR1HI		0x0D8
+#define MMDR1		0x0DC
+#define MCSR2		0x0E0
+#define MMAR2LO		0x0E4
+#define MMAR2HI		0x0E8
+#define MMDR2		0x0EC
+#define MCSR3		0x0F0
+#define MMAR3LO		0x0F4
+#define MMAR3HI		0x0F8
+#define MMDR3		0x0FC
+
+/* RCPM Core State Action Control Register 0 */
+#define CSTTACR0	0xB00
+
+/* RCPM Core Group 1 Configuration Register 0 */
+#define CG1CR0		0x31C
+
+struct fsm_reg_vals {
+	u32 offset;
+	u32 value;
+};
+
+void fsl_fsm_setup(void __iomem *base, struct fsm_reg_vals *val);
+void fsl_epu_setup_default(void __iomem *epu_base);
+void fsl_npc_setup_default(void __iomem *npc_base);
+void fsl_epu_clean_default(void __iomem *epu_base);
+
+#endif /* _FSL_SLEEP_FSM_H */
-- 
1.7.1
