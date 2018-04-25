Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeDYJBu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:01:50 -0400
Received: from mail-co1nam03on0049.outbound.protection.outlook.com ([104.47.40.49]:30016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751705AbeDYJBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:01:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com;
From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Will.Deacon@arm.com, mark.rutland@arm.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
Date: Wed, 25 Apr 2018 14:30:47 +0530
Message-Id: <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: PN1PR01CA0108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::24)
 To CO2PR0701MB743.namprd07.prod.outlook.com (2a01:111:e400:142f::17)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB743;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;3:298ppPw1CBjklE0G5MHgHnn8+nds/R76A908AxZG1XAVuRF2wWlao+QHmnZonpie6f5kkrDN6jILNdIcZYcnBCYs1dwXKqLnASSutdRwZfmEFiol3A6Ug1uB0CkqhVKsZSBHy2vEcHhy8nM/Y+9hn+EMIAgciaovqyU74KiXSWbJHBjxe6vprv9Jrvyuf9z5vU+PnEqr7dU8+pFydTHGmuT+gtSahQRHz7y+ttONJBOx+u4JeCrJ6SgoH0f9Sw6F;25:vmVlNCDVqFmOc91GDQXzJpolKwcw2crM4vtapVPcci1ARc/EAcMoBtyf2qKmEvkEZP/MPv3gIujAYeORGT/6jlFsq3TXBy5uWY3JybldiTYeFRfmEs0obOqO1tCIaU4qJc61RGjfoQDnD2R4hdO9H70djzDhTDERjvZ+B4G335S94Edc7LX+u5yiqNkE1N03GPC1XISakyTASz721abWe/NAdR4luhyXYoLeZ2c8nWb0M2kg679fKag9g7iUckLeQ5O3x6WSU1BA1wi106u8WJYf4sJDUd56Yy8Ko+pWXSFdbCivpb2FQ3xHVBVWty/WpsPVb/E49nX1uB7KcxDhAw==;31:GfZzGHV4BopW72OjVU8Dtq3UIMED2PGY6BVSaBC47gWlxSUdQVtt+2yHY0NRYKQs8wZAUHW1Zc4JwldlC2shKn3ZMinETjFliCpf/A7yw1ycuEjAyEPHwzO0oh7aQi3Lr6Br95v8hW5VZ6BZw8R8lbf3aH9rlD8Qm3tpCefgvxpyGftehypHcxCsHqLRxYgqWmkda1TaEryczSR6rzAWTRImoLj1p2ortD/iE1uuiIw=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB743:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;20:0vXHw9fQun0VvDQT8AaFtQFWA8cinPACgEjldltf/TVFL+PIYpYSp8oR6FBTseQJRFSWDaQ6YmfhrswUOMwY4jPXwAtmiUoXgQ5tK8mY1Uk7hHkQPcufLiu4Or2YXPIRlwe7b0+ZUPKOQFf2QA8AKUOas/tZthGNrHMHAmMCEdoQ07/OvGaI28yRA4Y78BF9BgM9UKtzUAmcIta6cDL4jPc0jEgt/TDnCzztQ6KNJsK4TuGVOstIMyZdPG2pkQUzAH6mTRKlT378YDE/jLmrhFaKr/C7hgoGYdxK+8cU9fyZsDhm8YgAlzg2tD0A5yymDU1+jYn4vV97xapq4z4BPGWah6eED+FwvN0y36EKi2ZMQlUwv+0Kg9PBi5QUsvCZyLuzTs2vD4gN74sNHQZ7wB//36l7znZnIdNZLg4EMM4qq33bwzLK8JGFZyZZGZr8V6jQ/MzZm5SVxZlVz+tJwRkhWzv/NH/YHox/PDw7o2ADKm+Y5qJvqSR0sQmVscmp;4:+UuHznCPK826AFTrPO0uX1Qfk4lOAVKOMXlf5s/s1YCtTLZO9zl2FJT0alSVMTrLKYvLb7QaduqC3RCBzl+0GcFZrEdCz/9mcEDvxhjUA9bwsgnIxUCjr/wOiXwEUwD1Ldxz/J8qhj2cwAtM/3mMvmI9ufX2xLLZLCNybXAMoKlOuACF0NRJKcbCPI21ytDFwVCG6/v7YWIVR3iHqbXEyOlsGxpz7f9VZIbTa5jGk1hhTW7fMrG7IlvGUHuJKLAPJTOS7l/OUj+1WCXd42uTqy0qLKxDRcb8VmLMYC1PT0+QmUGjshY0rk1vShxq4PGUKhx45G/ZJkmxYvM3n8IWmlohajphKM64BINIHPQ6qvu/3rFKYfKfzjZDqb958+WQ5Bb0fjRqxrvMH/aY0w6Skq0GGNb1xqWMHkKc+59U6F8=
X-Microsoft-Antispam-PRVS: <CO2PR0701MB743DA339D2D298BCFDDEFEB838F0@CO2PR0701MB743.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(72170088055959)(22074186197030)(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CO2PR0701MB743;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB743;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(8936002)(50226002)(7736002)(1076002)(2616005)(81156014)(478600001)(72206003)(5660300001)(316002)(5009440100003)(81166006)(6666003)(3846002)(305945005)(76176011)(105586002)(6512007)(50466002)(66066001)(68736007)(6486002)(7696005)(6116002)(59450400001)(2906002)(97736004)(4326008)(25786009)(11346002)(386003)(446003)(476003)(47776003)(86362001)(575784001)(8676002)(106356001)(956004)(53936002)(5890100001)(44832011)(52116002)(6306002)(6506007)(486006)(26005)(53946003)(16586007)(48376002)(186003)(39060400002)(51416003)(16526019)(36756003)(2004002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB743;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB743;23:vn0j9pQnRe9RznhMzYRjJNcOjK4TTeGDDUXk1xzX?=
 =?us-ascii?Q?peIciaMYptiCe9KYqwNm3bVrEUuFxMznmHmgkRVurpRJSKF4P/d6AjceFi6e?=
 =?us-ascii?Q?TriZgytB8JI55QjhrNOSKrJ8NbB2gJPO8cy6SIxcTPog0bBxnrhj+8rJC0h9?=
 =?us-ascii?Q?ab/uRYpdiyRZNLIPexSRfdXS+gQfsF2Vrk3FMvVPXJJkWW/g7EqfJsY3+Fxb?=
 =?us-ascii?Q?8G8pMTcb1z87Yuq9//Coh5kPPNTZi5PpJu9Gfs8z+0HOeLPBHLTz/uhMld0v?=
 =?us-ascii?Q?vDEFruSO9Hbz3FaM8LInAEDluYwPx61yNyKQteSqs+EFbXMnJZ+F6gJZ/Ite?=
 =?us-ascii?Q?aCNntqyf3Lhd+1+mEycJyVn3PY9fFpI9F/8DCRF7MrsGQqLONO1OIDPLtiN3?=
 =?us-ascii?Q?CP7aGM1bn4df9k17cZ6BWtsyok1XoFoegk0VW4zYCINZ5EYF7NVHqhR6T8Fz?=
 =?us-ascii?Q?5H4EGEFJFOr4Ktz6tzc0W9ZTENTKQyJn7qqxvCflDrJFN9H3jFh5XpFc04lD?=
 =?us-ascii?Q?25e7QUP1Vvub+XhfX/KwMTFxbZoccTc6PRuH07yfhvZOD4N1RHvRQuPwuoXK?=
 =?us-ascii?Q?KrVhxr1fucNktshs9M91aaK1zZ1w5JYvkEbifHCm3uKSIho6ZhC/xgQYcG2l?=
 =?us-ascii?Q?h0tnBPt0+jH0lbAIcvEfdnJNbx3cgocT3ITPPbbV/HMQQUAt8OwlkNoW5WV5?=
 =?us-ascii?Q?9mJVwFEWdnW7eIp5WIy3XpcXQvgBGtslHMZ7VUVOAUNP3YtllvATuhJhgEOC?=
 =?us-ascii?Q?54axsBILPbYjbcqeW4NeeFXMaOAovRGG0GW6CAfnEKW2/8yyhPWGPqmvEDcq?=
 =?us-ascii?Q?o+96rA06ypA6PZRv9svwXwhLjHyfeDkHOGdDlnf6hk2VtZbkXK9hGAg4/6LG?=
 =?us-ascii?Q?NVCIcxu/Lrnh0/xUw/rIGakyafUSC9zlO91OfU3O53YqIQhDPmPNRFuKjHym?=
 =?us-ascii?Q?fepY04AsiBZEl5S813riLi0PPfJV4INveaDXWvTOsbGFLVicpWWzCpX0MM19?=
 =?us-ascii?Q?N6vJeLv2lcQ3yIFAvZ5O3Vp/sNiew40igMll4hQyetkeV32HFCoHYeo1LFzM?=
 =?us-ascii?Q?FnFiEknx7wsutX/2E7br1hHba/OYNHXfE7TPkUPp5aPk64bjylHolrP4Mbl9?=
 =?us-ascii?Q?9d3e2rVlCjIPCHgFKcGiSidDYKzv2317iCwKMbDKoJJ95BqPQUMe9Yvu8gSJ?=
 =?us-ascii?Q?L/BZWqHZD/J+EjsBrwF1bqLKS6m0DbqV2tQvUGe2FrWOS9roLwWEhMtkK+55?=
 =?us-ascii?Q?1YCQJetSfS7twc8rvg7hMti5C513w8507sXFw2xWdKjdEVNS6KRsf6xAgGzU?=
 =?us-ascii?Q?JpEg5+TyiY204ElTHQ1Le9Np5ilOFc51t1l8Pt1LyzAEcWkvXsutJMLBHyPt?=
 =?us-ascii?Q?P+E0NDojNk4YzrE7DrpQDOLM/7dpb2S3EgPxrwrRBfAC0/pG9kdO8QK51G0D?=
 =?us-ascii?Q?+lnYTKM2RiW0R9NxeuSJzlfEKrnGBkbN3Qcbk9y3CGP74VdP0a5T?=
X-Microsoft-Antispam-Message-Info: mUzIlg4gWsc+oS9z6EJ7MF/f5eRh0RP+BaQlVTiODD7HElR2bM56JUfx5Gz7xRPOyt7Q5WNTV58fFc65/MFuIBwxJjkKsYOMkXx/LkDNFx8UyJxMrxUuVTqDpXZ1JJ2iqLJd0Ko4xIhkV/22GMEP6Aofu1xkmmvoRZ6SPPEnQ/B6oGSyUP4TV6rtjCnG4dbb
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;6:5p5pDlMHpNCMb/d6YmiW7X0efDmjDklVJmAMzMmEKSZZiYidDoC8VFAyKkdyd13B4tvd++VuMbT2tOdZVjwWrxqhJW0smJQ9r9YAWFUim54MddE40YyFkfqghMGjy62gjZcj+sq2IkOk9EehnFEgKWmup5X65Drjb648BZAopJJNEHqxzZ4vs56KkWfW2+BOCbJNKkt50910At0F5u+4cZeALsU1DyQum6ZmJtqBLpf8NMXGq2llTAT0u7Jxf07iB94ZzwvmlQ0mrjcTQDaqs3MS+AQ6vVxFH7kPhXGhdJVEbSawh0JfyDDKR7AgMYvHNmsn+0Hrp44e0jh6WmAX+INNVKroCEc8gZ6Viy05nDAhkF/FUsXotxrV+Xe/0Zryuh9IVZ42ovYkV1fWh9UYqQVbeG5J8ZbfxfHfAdGLCVkG1c2h+3b7Pge9/o9W3mly3KehKEIpZsntkNq+GGzO8Q==;5:OfuhhouKQxB0/FzQwkbZqLIEcMjRUMjcCbncP3B7N+zX0eQ+ODoQ8S0OP2ZdnLxC79BxGBMFqJNDSDlk4PZQ53t+I6wLdtQSR/gejeOGF5Fd35pm5pHEkh1uLfW8pB5GAMBn/SUX0J3B7Gtfl5z2o3E9cO1O6ZrflOUeDbB0Bug=;24:LOFonRtGw36aLgdcFYJi6JOEAg1lGI2QTlm1aI1qj077khTF2fb3rw0cOTGy2Z9TOqFxnCcQfNI+TS9Db7Tpyvc3/sh00pBD4py4An2tF9E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB743;7:7nKEiP2nTXXOtdagUix+E7zogfy5ZaQlZDz9JznxRDbcrSF5UrITP/YSAfLvTDKHwERKT2yp6yAZFpYpWs9fabU0tM3d3pNysTE1K/JmYj1JOQf01o0QHEiXZPj1xDp6GmGWolB5c5jueGG3R9JS/HpMshBRwhBtvBikvgJOJD3ZXXio+hkjsrNc0WTaVM83h+qk16DD71SQHw+MKMgtuB4TkIcpXp0cnFOEaYHf5xCCfQfQbE3EHonBZNWj7Kg4
X-MS-Office365-Filtering-Correlation-Id: e8cf3bee-bc2f-4777-3e2b-08d5aa8b254b
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 09:01:31.2533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cf3bee-bc2f-4777-3e2b-08d5aa8b254b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB743
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
Controller(DMC) and Level 3 Cache(L3C).

ThunderX2 has 8 independent DMC PMUs to capture performance events
corresponding to 8 channels of DDR4 Memory Controller and 16 independent
L3C PMUs to capture events corresponding to 16 tiles of L3 cache.
Each PMU supports up to 4 counters. All counters lack overflow interrupt
and are sampled periodically.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 drivers/perf/Kconfig         |   8 +
 drivers/perf/Makefile        |   1 +
 drivers/perf/thunderx2_pmu.c | 958 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 967 insertions(+)
 create mode 100644 drivers/perf/thunderx2_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 28bb5a0..eafd0fc 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -85,6 +85,14 @@ config QCOM_L3_PMU
 	   Adds the L3 cache PMU into the perf events subsystem for
 	   monitoring L3 cache events.
 
+config THUNDERX2_PMU
+        bool "Cavium ThunderX2 SoC PMU UNCORE"
+        depends on ARCH_THUNDER2 && PERF_EVENTS && ACPI
+	help
+	  Provides support for ThunderX2 UNCORE events.
+	  The SoC has PMU support in its L3 cache controller (L3C) and
+	  in the DDR4 Memory Controller (DMC).
+
 config XGENE_PMU
         depends on ARCH_XGENE
         bool "APM X-Gene SoC PMU"
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index b3902bd..909f27f 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
+obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
new file mode 100644
index 0000000..92d19b5
--- /dev/null
+++ b/drivers/perf/thunderx2_pmu.c
@@ -0,0 +1,958 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CAVIUM THUNDERX2 SoC PMU UNCORE
+ *
+ * Copyright (C) 2018 Cavium Inc.
+ * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/acpi.h>
+#include <linux/arm-smccc.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+/* L3c and DMC has 16 and 8 channels per socket respectively.
+ * Each Channel supports UNCORE PMU device and consists of
+ * 4 independent programmable counters. Counters are 32 bit
+ * and does not support overflow interrupt, they needs to be
+ * sampled before overflow(i.e, at every 2 seconds).
+ */
+
+#define UNCORE_MAX_COUNTERS		4
+#define UNCORE_L3_MAX_TILES		16
+#define UNCORE_DMC_MAX_CHANNELS		8
+
+#define UNCORE_HRTIMER_INTERVAL		(2 * NSEC_PER_SEC)
+#define GET_EVENTID(ev)			((ev->hw.config) & 0x1ff)
+#define GET_COUNTERID(ev)		((ev->hw.idx) & 0xf)
+#define GET_CHANNELID(pmu_uncore)	(pmu_uncore->channel)
+
+#define DMC_COUNTER_CTL			0x234
+#define DMC_COUNTER_DATA		0x240
+#define L3C_COUNTER_CTL			0xA8
+#define L3C_COUNTER_DATA		0xAC
+
+#define THUNDERX2_SMC_CALL_ID		0xC200FF00
+#define THUNDERX2_SMC_SET_CHANNEL	0xB010
+
+
+enum thunderx2_uncore_l3_events {
+	L3_EVENT_NONE,
+	L3_EVENT_NBU_CANCEL,
+	L3_EVENT_DIB_RETRY,
+	L3_EVENT_DOB_RETRY,
+	L3_EVENT_DIB_CREDIT_RETRY,
+	L3_EVENT_DOB_CREDIT_RETRY,
+	L3_EVENT_FORCE_RETRY,
+	L3_EVENT_IDX_CONFLICT_RETRY,
+	L3_EVENT_EVICT_CONFLICT_RETRY,
+	L3_EVENT_BANK_CONFLICT_RETRY,
+	L3_EVENT_FILL_ENTRY_RETRY,
+	L3_EVENT_EVICT_NOT_READY_RETRY,
+	L3_EVENT_L3_RETRY,
+	L3_EVENT_READ_REQ,
+	L3_EVENT_WRITE_BACK_REQ,
+	L3_EVENT_INVALIDATE_NWRITE_REQ,
+	L3_EVENT_INV_REQ,
+	L3_EVENT_SELF_REQ,
+	L3_EVENT_REQ,
+	L3_EVENT_EVICT_REQ,
+	L3_EVENT_INVALIDATE_NWRITE_HIT,
+	L3_EVENT_INVALIDATE_HIT,
+	L3_EVENT_SELF_HIT,
+	L3_EVENT_READ_HIT,
+	L3_EVENT_MAX,
+};
+
+enum thunderx2_uncore_dmc_events {
+	DMC_EVENT_NONE,
+	DMC_EVENT_COUNT_CYCLES,
+	DMC_EVENT_RES2,
+	DMC_EVENT_RES3,
+	DMC_EVENT_RES4,
+	DMC_EVENT_RES5,
+	DMC_EVENT_RES6,
+	DMC_EVENT_RES7,
+	DMC_EVENT_RES8,
+	DMC_EVENT_READ_64B_TXNS,
+	DMC_EVENT_READ_BELOW_64B_TXNS,
+	DMC_EVENT_WRITE_TXNS,
+	DMC_EVENT_TXN_CYCLES,
+	DMC_EVENT_DATA_TRANSFERS,
+	DMC_EVENT_CANCELLED_READ_TXNS,
+	DMC_EVENT_CONSUMED_READ_TXNS,
+	DMC_EVENT_MAX,
+};
+
+enum thunderx2_uncore_type {
+	PMU_TYPE_L3C,
+	PMU_TYPE_DMC,
+	PMU_TYPE_INVALID,
+};
+
+struct active_timer {
+	struct perf_event *event;
+	struct hrtimer hrtimer;
+};
+
+/*
+ * pmu on each socket has 2 uncore devices(dmc and l3),
+ * each uncore device has up to 16 channels, each channel can sample
+ * events independently with counters up to 4.
+ *
+ * struct thunderx2_pmu_uncore_channel created per channel.
+ * struct thunderx2_pmu_uncore_dev per uncore device.
+ */
+struct thunderx2_pmu_uncore_channel {
+	struct thunderx2_pmu_uncore_dev *uncore_dev;
+	struct pmu pmu;
+	int counter;
+	int channel;
+	DECLARE_BITMAP(counter_mask, UNCORE_MAX_COUNTERS);
+	struct active_timer *active_timers;
+	/* to sync counter alloc/release */
+	raw_spinlock_t lock;
+};
+
+struct thunderx2_pmu_uncore_dev {
+	char *name;
+	struct device *dev;
+	enum thunderx2_uncore_type type;
+	unsigned long base;
+	int node;
+	u32    max_counters;
+	u32    max_channels;
+	u32    max_events;
+	u64 hrtimer_interval;
+	/* this lock synchronizes across channels */
+	raw_spinlock_t lock;
+	const struct attribute_group **attr_groups;
+	void	(*init_cntr_base)(struct perf_event *event,
+			struct thunderx2_pmu_uncore_dev *uncore_dev);
+	void	(*select_channel)(struct perf_event *event);
+	void	(*stop_event)(struct perf_event *event);
+	void	(*start_event)(struct perf_event *event, int flags);
+};
+
+static inline struct thunderx2_pmu_uncore_channel *
+pmu_to_thunderx2_pmu_uncore(struct pmu *pmu)
+{
+	return container_of(pmu, struct thunderx2_pmu_uncore_channel, pmu);
+}
+
+/*
+ * sysfs format attributes
+ */
+static ssize_t thunderx2_pmu_format_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+	return sprintf(buf, "%s\n", (char *) eattr->var);
+}
+
+#define FORMAT_ATTR(_name, _config) \
+	(&((struct dev_ext_attribute[]) { \
+	   { \
+	   .attr = __ATTR(_name, 0444, thunderx2_pmu_format_show, NULL), \
+	   .var = (void *) _config, \
+	   } \
+	})[0].attr.attr)
+
+static struct attribute *l3c_pmu_format_attrs[] = {
+	FORMAT_ATTR(event,	"config:0-4"),
+	NULL,
+};
+
+static struct attribute *dmc_pmu_format_attrs[] = {
+	FORMAT_ATTR(event,	"config:0-4"),
+	NULL,
+};
+
+static const struct attribute_group l3c_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = l3c_pmu_format_attrs,
+};
+
+static const struct attribute_group dmc_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = dmc_pmu_format_attrs,
+};
+
+/*
+ * sysfs event attributes
+ */
+static ssize_t thunderx2_pmu_event_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+	return sprintf(buf, "config=0x%lx\n", (unsigned long) eattr->var);
+}
+
+#define EVENT_ATTR(_name, _config) \
+	(&((struct dev_ext_attribute[]) { \
+	   { \
+	   .attr = __ATTR(_name, 0444, thunderx2_pmu_event_show, NULL), \
+	   .var = (void *) _config, \
+	   } \
+	 })[0].attr.attr)
+
+static struct attribute *l3c_pmu_events_attrs[] = {
+	EVENT_ATTR(nbu_cancel,			L3_EVENT_NBU_CANCEL),
+	EVENT_ATTR(dib_retry,			L3_EVENT_DIB_RETRY),
+	EVENT_ATTR(dob_retry,			L3_EVENT_DOB_RETRY),
+	EVENT_ATTR(dib_credit_retry,		L3_EVENT_DIB_CREDIT_RETRY),
+	EVENT_ATTR(dob_credit_retry,		L3_EVENT_DOB_CREDIT_RETRY),
+	EVENT_ATTR(force_retry,			L3_EVENT_FORCE_RETRY),
+	EVENT_ATTR(idx_conflict_retry,		L3_EVENT_IDX_CONFLICT_RETRY),
+	EVENT_ATTR(evict_conflict_retry,	L3_EVENT_EVICT_CONFLICT_RETRY),
+	EVENT_ATTR(bank_conflict_retry,		L3_EVENT_BANK_CONFLICT_RETRY),
+	EVENT_ATTR(fill_entry_retry,		L3_EVENT_FILL_ENTRY_RETRY),
+	EVENT_ATTR(evict_not_ready_retry,	L3_EVENT_EVICT_NOT_READY_RETRY),
+	EVENT_ATTR(l3_retry,			L3_EVENT_L3_RETRY),
+	EVENT_ATTR(read_request,		L3_EVENT_READ_REQ),
+	EVENT_ATTR(write_back_request,		L3_EVENT_WRITE_BACK_REQ),
+	EVENT_ATTR(inv_nwrite_request,		L3_EVENT_INVALIDATE_NWRITE_REQ),
+	EVENT_ATTR(inv_request,			L3_EVENT_INV_REQ),
+	EVENT_ATTR(self_request,		L3_EVENT_SELF_REQ),
+	EVENT_ATTR(request,			L3_EVENT_REQ),
+	EVENT_ATTR(evict_request,		L3_EVENT_EVICT_REQ),
+	EVENT_ATTR(inv_nwrite_hit,		L3_EVENT_INVALIDATE_NWRITE_HIT),
+	EVENT_ATTR(inv_hit,			L3_EVENT_INVALIDATE_HIT),
+	EVENT_ATTR(self_hit,			L3_EVENT_SELF_HIT),
+	EVENT_ATTR(read_hit,			L3_EVENT_READ_HIT),
+	NULL,
+};
+
+static struct attribute *dmc_pmu_events_attrs[] = {
+	EVENT_ATTR(cnt_cycles,			DMC_EVENT_COUNT_CYCLES),
+	EVENT_ATTR(read_64b_txns,		DMC_EVENT_READ_64B_TXNS),
+	EVENT_ATTR(read_below_64b_txns,		DMC_EVENT_READ_BELOW_64B_TXNS),
+	EVENT_ATTR(write_txns,			DMC_EVENT_WRITE_TXNS),
+	EVENT_ATTR(txn_cycles,			DMC_EVENT_TXN_CYCLES),
+	EVENT_ATTR(data_transfers,		DMC_EVENT_DATA_TRANSFERS),
+	EVENT_ATTR(cancelled_read_txns,		DMC_EVENT_CANCELLED_READ_TXNS),
+	EVENT_ATTR(consumed_read_txns,		DMC_EVENT_CONSUMED_READ_TXNS),
+	NULL,
+};
+
+static const struct attribute_group l3c_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = l3c_pmu_events_attrs,
+};
+
+static const struct attribute_group dmc_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = dmc_pmu_events_attrs,
+};
+
+/*
+ * sysfs cpumask attributes
+ */
+static ssize_t cpumask_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct cpumask cpu_mask;
+	struct thunderx2_pmu_uncore_channel *pmu_uncore =
+		pmu_to_thunderx2_pmu_uncore(dev_get_drvdata(dev));
+
+	/* Pick first online cpu from the node */
+	cpumask_clear(&cpu_mask);
+	cpumask_set_cpu(cpumask_first(
+			cpumask_of_node(pmu_uncore->uncore_dev->node)),
+			&cpu_mask);
+
+	return cpumap_print_to_pagebuf(true, buf, &cpu_mask);
+}
+
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *thunderx2_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static const struct attribute_group pmu_cpumask_attr_group = {
+	.attrs = thunderx2_pmu_cpumask_attrs,
+};
+
+/*
+ * Per PMU device attribute groups
+ */
+static const struct attribute_group *l3c_pmu_attr_groups[] = {
+	&l3c_pmu_format_attr_group,
+	&pmu_cpumask_attr_group,
+	&l3c_pmu_events_attr_group,
+	NULL
+};
+
+static const struct attribute_group *dmc_pmu_attr_groups[] = {
+	&dmc_pmu_format_attr_group,
+	&pmu_cpumask_attr_group,
+	&dmc_pmu_events_attr_group,
+	NULL
+};
+
+static inline struct active_timer *get_active_timer(struct hrtimer *hrt)
+{
+	return container_of(hrt, struct active_timer, hrtimer);
+}
+
+static inline u32 reg_readl(unsigned long addr)
+{
+	return readl((void __iomem *)addr);
+}
+
+static inline void reg_writel(u32 val, unsigned long addr)
+{
+	writel(val, (void __iomem *)addr);
+}
+
+static int alloc_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore)
+{
+	int counter;
+
+	raw_spin_lock(&pmu_uncore->lock);
+	counter = find_first_zero_bit(pmu_uncore->counter_mask,
+				pmu_uncore->uncore_dev->max_counters);
+	if (counter == pmu_uncore->uncore_dev->max_counters) {
+		raw_spin_unlock(&pmu_uncore->lock);
+		return -ENOSPC;
+	}
+	set_bit(counter, pmu_uncore->counter_mask);
+	raw_spin_unlock(&pmu_uncore->lock);
+	return counter;
+}
+
+static void free_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore,
+					int counter)
+{
+	raw_spin_lock(&pmu_uncore->lock);
+	clear_bit(counter, pmu_uncore->counter_mask);
+	raw_spin_unlock(&pmu_uncore->lock);
+}
+
+/*
+ * DMC and L3 counter interface is muxed across all channels.
+ * hence we need to select the channel before accessing counter
+ * data/control registers.
+ *
+ *  L3 Tile and DMC channel selection is through SMC call
+ *  SMC call arguments,
+ *	x0 = THUNDERX2_SMC_CALL_ID	(Vendor SMC call Id)
+ *	x1 = THUNDERX2_SMC_SET_CHANNEL	(Id to set DMC/L3C channel)
+ *	x2 = Node id
+ *	x3 = DMC(1)/L3C(0)
+ *	x4 = channel Id
+ */
+static void uncore_select_channel(struct perf_event *event)
+{
+	struct arm_smccc_res res;
+	struct thunderx2_pmu_uncore_channel *pmu_uncore =
+		pmu_to_thunderx2_pmu_uncore(event->pmu);
+
+	arm_smccc_smc(THUNDERX2_SMC_CALL_ID, THUNDERX2_SMC_SET_CHANNEL,
+			pmu_uncore->uncore_dev->node,
+			pmu_uncore->uncore_dev->type,
+			pmu_uncore->channel, 0, 0, 0, &res);
+
+}
+
+static void uncore_start_event_l3c(struct perf_event *event, int flags)
+{
+	u32 val;
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* event id encoded in bits [07:03] */
+	val = GET_EVENTID(event) << 3;
+	reg_writel(val, hwc->config_base);
+
+	if (flags & PERF_EF_RELOAD) {
+		u64 prev_raw_count =
+			local64_read(&event->hw.prev_count);
+		reg_writel(prev_raw_count, hwc->event_base);
+	}
+	local64_set(&event->hw.prev_count,
+			reg_readl(hwc->event_base));
+}
+
+static void uncore_start_event_dmc(struct perf_event *event, int flags)
+{
+	u32 val, event_shift = 8;
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* enable and start counters and read current value in prev_count */
+	val = reg_readl(hwc->config_base);
+
+	/* 8 bits for each counter,
+	 * bits [05:01] of a counter to set event type.
+	 */
+	reg_writel((val & ~(0x1f << (((GET_COUNTERID(event)) *
+		event_shift) + 1))) |
+		(GET_EVENTID(event) <<
+		 (((GET_COUNTERID(event)) * event_shift) + 1)),
+		hwc->config_base);
+
+	if (flags & PERF_EF_RELOAD) {
+		u64 prev_raw_count =
+			local64_read(&event->hw.prev_count);
+		reg_writel(prev_raw_count, hwc->event_base);
+	}
+	local64_set(&event->hw.prev_count,
+			reg_readl(hwc->event_base));
+}
+
+static void uncore_stop_event_l3c(struct perf_event *event)
+{
+	reg_writel(0, event->hw.config_base);
+}
+
+static void uncore_stop_event_dmc(struct perf_event *event)
+{
+	u32 val, event_shift = 8;
+	struct hw_perf_event *hwc = &event->hw;
+
+	val = reg_readl(hwc->config_base);
+	reg_writel((val & ~(0xff << ((GET_COUNTERID(event)) * event_shift))),
+			hwc->config_base);
+}
+
+static void init_cntr_base_l3c(struct perf_event *event,
+		struct thunderx2_pmu_uncore_dev *uncore_dev)
+{
+
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* counter ctrl/data reg offset at 8 */
+	hwc->config_base = uncore_dev->base
+		+ L3C_COUNTER_CTL + (8 * GET_COUNTERID(event));
+	hwc->event_base =  uncore_dev->base
+		+ L3C_COUNTER_DATA + (8 * GET_COUNTERID(event));
+}
+
+static void init_cntr_base_dmc(struct perf_event *event,
+		struct thunderx2_pmu_uncore_dev *uncore_dev)
+{
+
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->config_base = uncore_dev->base
+		+ DMC_COUNTER_CTL;
+	/* counter data reg offset at 0xc */
+	hwc->event_base =  uncore_dev->base
+		+ DMC_COUNTER_DATA + (0xc * GET_COUNTERID(event));
+}
+
+static void thunderx2_uncore_update(struct perf_event *event)
+{
+	s64 prev, new = 0;
+	u64 delta;
+	struct hw_perf_event *hwc = &event->hw;
+	struct thunderx2_pmu_uncore_channel *pmu_uncore;
+	enum thunderx2_uncore_type type;
+
+	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
+	type = pmu_uncore->uncore_dev->type;
+
+	if (pmu_uncore->uncore_dev->select_channel)
+		pmu_uncore->uncore_dev->select_channel(event);
+
+	new = reg_readl(hwc->event_base);
+	prev = local64_xchg(&hwc->prev_count, new);
+
+	/* handles rollover of 32 bit counter */
+	delta = (u32)(((1UL << 32) - prev) + new);
+
+	local64_add(delta, &event->count);
+}
+
+enum thunderx2_uncore_type get_uncore_device_type(struct acpi_device *adev)
+{
+	int i = 0;
+	struct acpi_uncore_device {
+		__u8 id[ACPI_ID_LEN];
+		enum thunderx2_uncore_type type;
+	} devices[] = {
+		{"CAV901D", PMU_TYPE_L3C},
+		{"CAV901F", PMU_TYPE_DMC},
+		{"", PMU_TYPE_INVALID},
+	};
+
+	while (devices[i].type != PMU_TYPE_INVALID) {
+		if (!strcmp(acpi_device_hid(adev), devices[i].id))
+			return devices[i].type;
+		i++;
+	}
+	return PMU_TYPE_INVALID;
+}
+
+/*
+ * We must NOT create groups containing events from multiple hardware PMUs,
+ * although mixing different software and hardware PMUs is allowed.
+ */
+static bool thunderx2_uncore_validate_event_group(struct perf_event *event)
+{
+	struct pmu *pmu = event->pmu;
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling;
+	int counters = 0;
+
+	if (leader->pmu != event->pmu && !is_software_event(leader))
+		return false;
+
+	counters++;
+
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (is_software_event(sibling))
+			continue;
+		if (sibling->pmu != pmu)
+			return false;
+		counters++;
+	}
+
+	/*
+	 * If the group requires more counters than the HW has,
+	 * it cannot ever be scheduled.
+	 */
+	return counters <= UNCORE_MAX_COUNTERS;
+}
+
+static int thunderx2_uncore_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct thunderx2_pmu_uncore_channel *pmu_uncore;
+
+	/* Test the event attr type check for PMU enumeration */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/*
+	 * SOC PMU counters are shared across all cores.
+	 * Therefore, it does not support per-process mode.
+	 * Also, it does not support event sampling mode.
+	 */
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EINVAL;
+
+	/* SOC counters do not have usr/os/guest/host bits */
+	if (event->attr.exclude_user || event->attr.exclude_kernel ||
+	    event->attr.exclude_host || event->attr.exclude_guest)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
+
+	if (!pmu_uncore)
+		return -ENODEV;
+
+	/* Pick first online cpu from the node */
+	event->cpu = cpumask_first(
+			cpumask_of_node(pmu_uncore->uncore_dev->node));
+
+	if (event->cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (event->attr.config >= pmu_uncore->uncore_dev->max_events)
+		return -EINVAL;
+
+	/* store event id */
+	hwc->config = event->attr.config;
+
+	/* Validate the group */
+	if (!thunderx2_uncore_validate_event_group(event))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void thunderx2_uncore_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct thunderx2_pmu_uncore_channel *pmu_uncore;
+	struct thunderx2_pmu_uncore_dev *uncore_dev;
+	unsigned long irqflags;
+	struct active_timer *active_timer;
+
+	hwc->state = 0;
+	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
+	uncore_dev = pmu_uncore->uncore_dev;
+
+	raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
+
+	if (uncore_dev->select_channel)
+		uncore_dev->select_channel(event);
+	uncore_dev->start_event(event, flags);
+	raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
+
+	perf_event_update_userpage(event);
+	active_timer = &pmu_uncore->active_timers[GET_COUNTERID(event)];
+	active_timer->event = event;
+
+	hrtimer_start(&active_timer->hrtimer,
+			ns_to_ktime(uncore_dev->hrtimer_interval),
+			HRTIMER_MODE_REL_PINNED);
+}
+
+static void thunderx2_uncore_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct thunderx2_pmu_uncore_channel *pmu_uncore;
+	struct thunderx2_pmu_uncore_dev *uncore_dev;
+	unsigned long irqflags;
+
+	if (hwc->state & PERF_HES_UPTODATE)
+		return;
+
+	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
+	uncore_dev = pmu_uncore->uncore_dev;
+
+	raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
+
+	if (uncore_dev->select_channel)
+		uncore_dev->select_channel(event);
+	uncore_dev->stop_event(event);
+
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+		thunderx2_uncore_update(event);
+		hwc->state |= PERF_HES_UPTODATE;
+	}
+	raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
+
+	hrtimer_cancel(
+		&pmu_uncore->active_timers[GET_COUNTERID(event)].hrtimer);
+	pmu_uncore->active_timers[GET_COUNTERID(event)].event = NULL;
+}
+
+static int thunderx2_uncore_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct thunderx2_pmu_uncore_channel *pmu_uncore;
+	struct thunderx2_pmu_uncore_dev *uncore_dev;
+
+	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
+	uncore_dev = pmu_uncore->uncore_dev;
+
+	/* Allocate a free counter */
+	hwc->idx  = alloc_counter(pmu_uncore);
+	if (hwc->idx < 0)
+		return -EAGAIN;
+
+	/* set counter control and data registers base address */
+	uncore_dev->init_cntr_base(event, uncore_dev);
+
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+	if (flags & PERF_EF_START)
+		thunderx2_uncore_start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+static void thunderx2_uncore_del(struct perf_event *event, int flags)
+{
+	struct thunderx2_pmu_uncore_channel *pmu_uncore =
+			pmu_to_thunderx2_pmu_uncore(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	thunderx2_uncore_stop(event, PERF_EF_UPDATE);
+
+	/* clear the assigned counter */
+	free_counter(pmu_uncore, GET_COUNTERID(event));
+
+	perf_event_update_userpage(event);
+	hwc->idx = -1;
+}
+
+static void thunderx2_uncore_read(struct perf_event *event)
+{
+	unsigned long irqflags;
+	struct thunderx2_pmu_uncore_channel *pmu_uncore =
+			pmu_to_thunderx2_pmu_uncore(event->pmu);
+
+	raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
+	thunderx2_uncore_update(event);
+	raw_spin_unlock_irqrestore(&pmu_uncore->uncore_dev->lock, irqflags);
+}
+
+static enum hrtimer_restart thunderx2_uncore_hrtimer_callback(
+		struct hrtimer *hrt)
+{
+	struct thunderx2_pmu_uncore_channel *pmu_uncore;
+	struct perf_event *event;
+	unsigned long irqflags;
+	struct active_timer *active_timer;
+
+	active_timer = get_active_timer(hrt);
+	event = active_timer->event;
+
+	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
+
+	raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
+	thunderx2_uncore_update(event);
+	raw_spin_unlock_irqrestore(&pmu_uncore->uncore_dev->lock, irqflags);
+
+	hrtimer_forward_now(hrt,
+			ns_to_ktime(
+				pmu_uncore->uncore_dev->hrtimer_interval));
+	return HRTIMER_RESTART;
+}
+
+static int thunderx2_pmu_uncore_register(
+		struct thunderx2_pmu_uncore_channel *pmu_uncore)
+{
+	struct device *dev = pmu_uncore->uncore_dev->dev;
+	char *name = pmu_uncore->uncore_dev->name;
+	int channel = pmu_uncore->channel;
+
+	/* Perf event registration */
+	pmu_uncore->pmu = (struct pmu) {
+		.attr_groups	= pmu_uncore->uncore_dev->attr_groups,
+		.task_ctx_nr	= perf_invalid_context,
+		.event_init	= thunderx2_uncore_event_init,
+		.add		= thunderx2_uncore_add,
+		.del		= thunderx2_uncore_del,
+		.start		= thunderx2_uncore_start,
+		.stop		= thunderx2_uncore_stop,
+		.read		= thunderx2_uncore_read,
+	};
+
+	pmu_uncore->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
+			"%s_%d", name, channel);
+
+	return perf_pmu_register(&pmu_uncore->pmu, pmu_uncore->pmu.name, -1);
+}
+
+static int thunderx2_pmu_uncore_add(struct thunderx2_pmu_uncore_dev *uncore_dev,
+		int channel)
+{
+	struct thunderx2_pmu_uncore_channel *pmu_uncore;
+	int ret;
+	int counter;
+
+	pmu_uncore = devm_kzalloc(uncore_dev->dev, sizeof(*pmu_uncore),
+			GFP_KERNEL);
+	if (!pmu_uncore)
+		return -ENOMEM;
+
+	pmu_uncore->uncore_dev = uncore_dev;
+	pmu_uncore->channel = channel;
+
+	/* we can run up to (max_counters * max_channels) events
+	 * simultaneously, allocate hrtimers per channel.
+	 */
+	pmu_uncore->active_timers = devm_kzalloc(uncore_dev->dev,
+			sizeof(struct active_timer) * uncore_dev->max_counters,
+			GFP_KERNEL);
+
+	for (counter = 0; counter < uncore_dev->max_counters; counter++) {
+		hrtimer_init(&pmu_uncore->active_timers[counter].hrtimer,
+				CLOCK_MONOTONIC,
+				HRTIMER_MODE_REL);
+		pmu_uncore->active_timers[counter].hrtimer.function =
+				thunderx2_uncore_hrtimer_callback;
+	}
+
+	ret = thunderx2_pmu_uncore_register(pmu_uncore);
+	if (ret) {
+		dev_err(uncore_dev->dev, "%s PMU: Failed to init driver\n",
+				uncore_dev->name);
+		return -ENODEV;
+	}
+
+	dev_dbg(uncore_dev->dev, "%s PMU UNCORE registered\n",
+			pmu_uncore->pmu.name);
+	return ret;
+}
+
+static struct thunderx2_pmu_uncore_dev *init_pmu_uncore_dev(
+		struct device *dev, acpi_handle handle,
+		struct acpi_device *adev, u32 type)
+{
+	struct thunderx2_pmu_uncore_dev *uncore_dev;
+	unsigned long base;
+	struct resource res;
+	struct resource_entry *rentry;
+	struct list_head list;
+	int ret;
+
+	INIT_LIST_HEAD(&list);
+	ret = acpi_dev_get_resources(adev, &list, NULL, NULL);
+	if (ret <= 0) {
+		dev_err(dev, "failed to parse _CRS method, error %d\n", ret);
+		return NULL;
+	}
+
+	list_for_each_entry(rentry, &list, node) {
+		if (resource_type(rentry->res) == IORESOURCE_MEM) {
+			res = *rentry->res;
+			break;
+		}
+	}
+
+	if (!rentry->res)
+		return NULL;
+
+	acpi_dev_free_resource_list(&list);
+
+	base = (unsigned long)devm_ioremap_resource(dev, &res);
+	if (IS_ERR((void *)base)) {
+		dev_err(dev, "PMU type %d: Fail to map resource\n", type);
+		return NULL;
+	}
+
+	uncore_dev = devm_kzalloc(dev, sizeof(*uncore_dev), GFP_KERNEL);
+	if (!uncore_dev)
+		return NULL;
+
+	uncore_dev->dev = dev;
+	uncore_dev->type = type;
+	uncore_dev->base = base;
+	uncore_dev->node = dev_to_node(dev);
+
+	raw_spin_lock_init(&uncore_dev->lock);
+
+	switch (uncore_dev->type) {
+	case PMU_TYPE_L3C:
+		uncore_dev->max_counters = UNCORE_MAX_COUNTERS;
+		uncore_dev->max_channels = UNCORE_L3_MAX_TILES;
+		uncore_dev->max_events = L3_EVENT_MAX;
+		uncore_dev->hrtimer_interval = UNCORE_HRTIMER_INTERVAL;
+		uncore_dev->attr_groups = l3c_pmu_attr_groups;
+		uncore_dev->name = devm_kasprintf(dev, GFP_KERNEL,
+				"uncore_l3c_%d", uncore_dev->node);
+		uncore_dev->init_cntr_base = init_cntr_base_l3c;
+		uncore_dev->start_event = uncore_start_event_l3c;
+		uncore_dev->stop_event = uncore_stop_event_l3c;
+		uncore_dev->select_channel = uncore_select_channel;
+		break;
+	case PMU_TYPE_DMC:
+		uncore_dev->max_counters = UNCORE_MAX_COUNTERS;
+		uncore_dev->max_channels = UNCORE_DMC_MAX_CHANNELS;
+		uncore_dev->max_events = DMC_EVENT_MAX;
+		uncore_dev->hrtimer_interval = UNCORE_HRTIMER_INTERVAL;
+		uncore_dev->attr_groups = dmc_pmu_attr_groups;
+		uncore_dev->name = devm_kasprintf(dev, GFP_KERNEL,
+				"uncore_dmc_%d", uncore_dev->node);
+		uncore_dev->init_cntr_base = init_cntr_base_dmc;
+		uncore_dev->start_event = uncore_start_event_dmc;
+		uncore_dev->stop_event = uncore_stop_event_dmc;
+		uncore_dev->select_channel = uncore_select_channel;
+		break;
+	case PMU_TYPE_INVALID:
+		devm_kfree(dev, uncore_dev);
+		uncore_dev = NULL;
+		break;
+	}
+
+	return uncore_dev;
+}
+
+static acpi_status thunderx2_pmu_uncore_dev_add(acpi_handle handle, u32 level,
+				    void *data, void **return_value)
+{
+	struct thunderx2_pmu_uncore_dev *uncore_dev;
+	struct acpi_device *adev;
+	enum thunderx2_uncore_type type;
+	int channel;
+
+	if (acpi_bus_get_device(handle, &adev))
+		return AE_OK;
+	if (acpi_bus_get_status(adev) || !adev->status.present)
+		return AE_OK;
+
+	type = get_uncore_device_type(adev);
+	if (type == PMU_TYPE_INVALID)
+		return AE_OK;
+
+	uncore_dev = init_pmu_uncore_dev((struct device *)data, handle,
+			adev, type);
+
+	if (!uncore_dev)
+		return AE_ERROR;
+
+	for (channel = 0; channel < uncore_dev->max_channels; channel++) {
+		if (thunderx2_pmu_uncore_add(uncore_dev, channel)) {
+			/* Can't add the PMU device, abort */
+			return AE_ERROR;
+		}
+	}
+	return AE_OK;
+}
+
+static int thunderx2_uncore_dev_probe(struct device *dev)
+{
+	acpi_handle handle;
+	acpi_status status;
+
+	if (!has_acpi_companion(dev))
+		return -ENODEV;
+
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return -EINVAL;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+				     thunderx2_pmu_uncore_dev_add,
+				     NULL, dev, NULL);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "failed to probe PMU devices\n");
+		return_ACPI_STATUS(status);
+	}
+
+	dev_info(dev, "node%d: pmu uncore registered\n", dev_to_node(dev));
+	return 0;
+}
+
+static const struct acpi_device_id thunderx2_uncore_acpi_match[] = {
+	{"CAV901C", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, thunderx2_uncore_acpi_match);
+
+static int thunderx2_uncore_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct arm_smccc_res res;
+
+	set_dev_node(dev, acpi_get_node(ACPI_HANDLE(dev)));
+
+	/* Make sure firmware supports DMC/L3C set channel smc call */
+	arm_smccc_smc(THUNDERX2_SMC_CALL_ID, THUNDERX2_SMC_SET_CHANNEL,
+			dev_to_node(dev), 0, 0, 0, 0, 0, &res);
+	if (res.a0) {
+		dev_err(dev, "No Firmware support for PMU UNCORE(%d)\n",
+				dev_to_node(dev));
+		return -ENODEV;
+	}
+
+	/* Walk through the tree for all PMU UNCORE devices */
+	return thunderx2_uncore_dev_probe(dev);
+}
+
+static struct platform_driver thunderx2_uncore_driver = {
+	.probe = thunderx2_uncore_probe,
+	.driver = {
+		.name		= "thunderx2-uncore-pmu",
+		.acpi_match_table = ACPI_PTR(thunderx2_uncore_acpi_match),
+	},
+};
+
+builtin_platform_driver(thunderx2_uncore_driver);
-- 
2.9.4
