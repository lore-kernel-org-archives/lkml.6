Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeEDRJk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:09:40 -0400
Received: from mail-sn1nam02on0074.outbound.protection.outlook.com ([104.47.36.74]:3264
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751425AbeEDRJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:09:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 1/2] clk: x86: Add ST oscout platform clock
Date: Sat,  5 May 2018 01:07:18 +0800
Message-Id: <1525453639-30575-2-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525453639-30575-1-git-send-email-akshu.agrawal@amd.com>
References: <1525453639-30575-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::18) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2366;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:XSmsPpcPHeoCfpocsKunjHTqYXeeB6LrBq1DILN1z+Rz1SAFx/USbHHRrZXAKX871IqO+av8FMEcm2VCZoU0zdG0K8SbR7GTNXad6xFQ2Sk17ZrB+6kS2pFSgcArnGF1Hu4tpnUBGjozYwuk/kc+1UvWuFf4sfpA7EMKE8Cnz7s/W5S9PDJMT3Wgks2g6GQalqq62UGUDhPvMg97mz3/sP9jitwrmmli4sDbya3lseqsS96ZfVre44bqC6M4GHvk;25:fW75CycXUbzf14a/yw1+y9Iup4PuNNI1Ds1A32n/PukzgQbgzSYAOVsslwv18ZrGxQb+7s/l6q64BUCKTkYz8HZTeXuSACwIOXRJoflT8ASM7dr99SWZIzWNNydhwisX2UkWt79m9gmHyx0v4Ury1NFj/rOpczjtRKcu6BGwF4IaiUocCIsC7bS0h7NAjgmS00uRfvFapCMiU/fD5L1H0AOhnw19XvTYT861YdKMQSgTLdlMIrQOxXHMjC5ahY55b9/Y7+B5DSGjEd5h5s80YDmAudbyoM8njInXF6yvxS8xjYcjtBzMOckv0kRKFPbhzZLzUmnLLifMSbscLYp/ug==;31:Zgok79hOv1fQ9pK/EEb6+9LWnpuBco2yUj0nthMqTwkJc3LteZqZulYltBISt8og+Vio3BVK5VGHCtq5XQ9f8aA6gE/JOTml3FBCLgM3o4u2iHP/saUnpcnTdH/+EozQsZ9zHbDDCdidjHkbPqOUCyCNN2VI7yxBDgjR4WcfzIjp7hgMk/XsUW0zwgf9OsLE9OZ0YzHy+FIN/hbihyKbkMPKJjNti4EO1wJPuw2eyrA=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:ViOcIAkO89ekeyZq0G27bdNXpeYxmGoh0NQiLwgJggl4nVPamcNth6922EC3TMw2WyN0L0MnA5rtaGhJAMFxOG8rj+0x50/iOOP1dc85njRbLr2LvOIK9yV5VUeF1znYh2PF+PgDRBIQ8W+BOYcfElDl4W1WEGXeKyY+ca+dhriSgb82rNpzWIWVszLbdG+Oz6j094RWw+t3kfhWTE6JWCk3a5RgwVFm4O1ZQ9abZscbIcYb+RzZEjb6tGZW+/zM5xMOOKoLdIKg2RnmcDXQeEsjRp/x86l+G+jfNKw5Gfg4GYBBGjATS1D8L587zQ+gJ3nhbDGLaBNoAuuin3MWlvRxhM6GD4/+DkFRk4BGQp8+17WDWjp0DEsiVtxdDH7zwLu37s8nq7aPr+QL8sRrvl2nfvXzoVRNYeO/8hoOTTh3yPVcfMROm5Gtx92q5hXTYTfsqjH03pbpqi9oJtygybNTHOKVQJki4FbwqQ8QDQguvjqvBKDc3x3O9uPxd9Nd;4:9/tE/vAcN+LrThr6P/1GNiYwcXSeQ6WrlZohSkoK4pLtB/BRD0rWFhOYdyiUDCLN301pcDCQQrQcWWb3iTJlbiZT4OeIyEbOpwC4OCC9jYieSJPE01FTwvfLxlU0Tbsc8Fb6oNk/F5DGBtNmtDloPrOKBVrM46oBQZKio5SeP6cItH1hP03mC+sQvETlIc9DSA1NCrOVNGcOwvdOzB4Y+2UKmTyEhPYWW8ps2nbMGQwUQwckhf1VHh1FtM/O7oHNIj/fBDnnTG3IuZ59DKEdHW4bkneV589qexNdvAWTEyDDRQTXS7WoCFSItljIFdq9
X-Microsoft-Antispam-PRVS: <SN1PR12MB236616EBE95BD9EE24B64CB9F8860@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(366004)(39380400002)(199004)(189003)(26005)(11346002)(5660300001)(2906002)(50466002)(52116002)(186003)(1671002)(106356001)(68736007)(51416003)(36756003)(7696005)(105586002)(4326008)(76176011)(8936002)(48376002)(50226002)(97736004)(3846002)(44832011)(386003)(109986005)(6116002)(478600001)(72206003)(7736002)(305945005)(486006)(53416004)(16526019)(81166006)(16586007)(25786009)(8676002)(6486002)(86362001)(476003)(956004)(81156014)(316002)(53936002)(66066001)(47776003)(2616005)(6666003)(59450400001)(446003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2366;23:NLq9TOQByVcYFSaa96+pI4oT7mouoKuqGrtwrb4P6?=
 =?us-ascii?Q?4nwF5GgGvjWCyFMtpiUS0TVzWcXGPQS/uBJAPv4g6uKr6wGIwxCFnIz24Vyy?=
 =?us-ascii?Q?b6ijNIp5pDMZvVnbB4WB8pXhGHls3KUx9iCTGx6x0BXsgzrnk/GYXzabdGNr?=
 =?us-ascii?Q?ryGCiAfyWMM2AGm9ChAs5grVsKNoTPp/h2crUE7c9MQmATxNYe0Mr3FF62L6?=
 =?us-ascii?Q?Ls9Hbu76sbZpWHP93u8pGf+kPSACvy5WkHg6ibsJjNLJOaw3++bGyF4D9jGQ?=
 =?us-ascii?Q?ZrEODNRRvEV6veAiswPt7iRIq4kPQT7KP3Q4xfc80duZInMZ/0l8dXp+g/y4?=
 =?us-ascii?Q?z42B2nP7WYYeTiiGLI52g9TrvzZd93tIFAZuH+IjJPrQwueAGnh3kPN51nMW?=
 =?us-ascii?Q?Ql41umbdSWExPAZLpLKDlaoVMhHcf+6s2yEWB2AOFTJPg0pvEm/q7xg0rvpO?=
 =?us-ascii?Q?d0x+QXmy7Q8b7engsTijSiu4Jah5XsWKX+41iq6EE/fsYVYVlOHduE1zMntC?=
 =?us-ascii?Q?2uBmk4O63mVLeS67lGy00HIwRku4Bsi5yX4Q3/bq8UDq0PvQhPRIYf8ZAUZA?=
 =?us-ascii?Q?CpRO62Gp4D2iYk0s7mcX2dIzuTNEE3iX8bjtO0MRCTInOhhpOBmHSagTcsfO?=
 =?us-ascii?Q?EXg4JcbJpazQS2RBr2udelPRqbgQUapfhECesvVDqQcyibjQCGW3UIMU7wV1?=
 =?us-ascii?Q?S8yGl4S2Tv4cjp81wCxgqCUJqnYUUwlfHOTR/unsTlDVrJeSKNGjgkBPy1D2?=
 =?us-ascii?Q?QCZ+x/QPv3eryaPe5NqtpYCvh5NYC7wDq7HuMYO/rNC1w24QE0eRKn5Yr+4Q?=
 =?us-ascii?Q?3pF9Pdb0h4b1u0um/cxU+UwFZNAR0DY+qX4843vBEssLFSVNrHARG/PaT9ee?=
 =?us-ascii?Q?4n5UJFpx3AgvmcQ6a/xbmk4Eg0bKfoSWx5Hu8/qa0RksBuXZAN9OfQI706k7?=
 =?us-ascii?Q?o+93FSjbtjCxC5KLzlvYJP+tkgTcNTZmJsdyOGL1kYFPcoWVrfF4hHQZN67v?=
 =?us-ascii?Q?JnZ3cgq4ABFx5NOatdI3pz9A/+1EV9fDhMYEXAMFyybOBRn3kfIDk8AuNkXQ?=
 =?us-ascii?Q?oibVRuW/cMufiAeNymbvJ16bd8QoAr+FX60YPM3mXHoPjfKe7SYzKyx0/vTP?=
 =?us-ascii?Q?rYJ7tH8mH7Sgv78Ktdum9aHUF2PRchKDItgFcSUSzw/eX7myu+1MiSvbXbSb?=
 =?us-ascii?Q?gu6IiTe/F0GK8GVzbzxOwmLMo8PvQhVfJk13sGUVmiEMXsf52CXAOVgsxm+n?=
 =?us-ascii?Q?Tgw7xWOJVGecAqxNtqmo3qnX22lRhQmTepcBbMB8ThgDsGSfsSY1atFqXlcC?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: J5+IbFswVWsaWv+Tytr9CM2/gMoKnLycmDG7ALZgf6DjgAPcQnyFP+CMDA8VjgTq/phed724UY4wvxyJZli09jOYs0RIM0544TI+DhgWyargt2L+Od06aGa7hjOkZoFKcdh7LwyhhNxO3dz1fqmBVuOLbuA8vM2KabH9BrARYBcaI0fUEnBIdsbFhxg5ou4X
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:BJWpv7oLDthMCq27SjsMgIHnztU3E33Gj44BAX2S9qGve6cC+oH1g8t0IqvTkvStWwFKw5yuwXJKFv5Szke+9hIdpK0onFoqrUH+xFX20jNCLPYLGmFqiOUEaX14jb2gOVyzA3lNttpFMltxdKB0pWd5N3MGr/Dd+elay4YfuUpdKdNfN7HOFtUpy07B/CcSjq1ktZPGv5qGmZ9030zkRJrOKLsqik50HAx3FBhWO36Xjh7e6z74yJxmH63XX6PeWIU95rg2PJKZGT7xYUowHyDxJi/6SVbbJxXFp3X22w4fOTPDYsToiyDHDtjpGMHOpg5f4DLyNGzjYNPSXUjWMrEAgzp55ZobpQXH+VpUEFBGz4kqb+WaBzP60WFIenzhoHg8oDeHo2W1U6qkHEHxY59majbwSpaybb0pOhWUvCHELEt//zyMF/pM31GwOBbizMp2U1exQehce+OOztm1CQ==;5:NfFPeNTJWNXM80toVvILqsBVwJQPZIFVkG91kqaSjKCCp/V9Gpi4lD3gGrSdFSDy5B+vUgYA/BMhMEf2nMfddFC123D9iVmFYgqHbqKcXwpZKSI0ALej+wxd+BYr3YE8OirUm34b4+IhWAz25IIqKPP0JWIxCgL6q8NU1Khf0/w=;24:+WeGqIAHFfSiFJ8FlSIbhdu9ZVo8bCvAWIS+u1ygWsBVVW3atVAkXPUUIivgY4IiYTn9tsh8oG5d5ORRXjoks9HwVipHZiu30Y/KOMESLI8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;7:2bTcG7POFb75ElNQUeZV9XnUQ70E9679JaXZKU/ke2BLV5DyS6XUtSikz8H6Bxp+RNIKb/8KlUs+WYQauj30ik2KCfcZADTRWdAtCf77lar3eQFw1nwzXohEwbJSW0GMVHbMcig2zI0Xagks7O8RLjV5i84Mc9GCp1hJq1sw3kntvTlKc1NYPRb4x9PYSfL+Y6IjksiYUQxNa/QUbgkTeXrjlqA25d3WebDsnSBpQXX0KsmocONmjdZP/sfQYuYT;20:yhW/qIwU8v1Omr2KBBtH2LTXCDG7dH1HK4CSpu398/M/RPNJXmcN2PqnSCgNEPcqeDFwL1dRpLsRrIlgHjznLNzFHkEejvMQHcJefLIHQo+2eo22rqHG24YaJvyl9vsYkFisSgDKzz1jZsfVUS8A9XTMe+KfrfIg9O94uEvYU2aoOxJ+Pps7n8889JPWSy84Sc9POjyXHJPYEsp9SjC88kZ4BvdhQ9+2hIilQPeo+E9yE1e1t75HYXbGGVSoQPyH
X-MS-Office365-Filtering-Correlation-Id: fa231617-b849-4b0f-6baf-08d5b1e1cd33
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 17:09:27.6562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa231617-b849-4b0f-6baf-08d5b1e1cd33
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stoney SoC provides oscout clock. This clock can support 25Mhz and
48Mhz of frequency.
The clock is available for general system use.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: config change, added SPDX tag and used clk_hw_register_.
v3: Fix kbuild warning for checking of NULL pointer
 drivers/clk/x86/Makefile             |  1 +
 drivers/clk/x86/clk-st.c             | 88 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-st.h | 35 ++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/clk/x86/clk-st.c
 create mode 100644 include/linux/platform_data/clk-st.h

diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
index 1367afb..2aee002 100644
--- a/drivers/clk/x86/Makefile
+++ b/drivers/clk/x86/Makefile
@@ -1,3 +1,4 @@
 clk-x86-lpss-objs		:= clk-lpt.o
 obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
 obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
+obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
new file mode 100644
index 0000000..c3d5b84
--- /dev/null
+++ b/drivers/clk/x86/clk-st.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * clock framework for AMD Stoney based clocks
+ *
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_data/clk-st.h>
+#include <linux/platform_device.h>
+
+/* Clock Driving Strength 2 register */
+#define CLKDRVSTR2	0x28
+/* Clock Control 1 register */
+#define MISCCLKCNTL1	0x40
+/* Auxiliary clock1 enable bit */
+#define OSCCLKENB	2
+/* 25Mhz auxiliary output clock freq bit */
+#define OSCOUT1CLK25MHZ	16
+
+#define ST_CLK_48M	0
+#define ST_CLK_25M	1
+#define ST_CLK_MUX	2
+#define ST_CLK_GATE	3
+#define ST_MAX_CLKS	4
+
+static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
+
+static int st_clk_probe(struct platform_device *pdev)
+{
+	struct st_clk_data *st_data;
+	struct clk_hw **hws;
+
+	st_data = dev_get_platdata(&pdev->dev);
+	if (!st_data || !st_data->base)
+		return -EINVAL;
+
+	hws = kzalloc(sizeof(*hws) * ST_MAX_CLKS, GFP_KERNEL);
+	if (!hws)
+		return -ENOMEM;
+
+	hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
+						     48000000);
+	hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz", NULL, 0,
+						     25000000);
+
+	hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
+		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
+		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
+
+	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
+
+	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
+		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
+		CLK_GATE_SET_TO_DISABLE, NULL);
+
+	clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
+
+	return 0;
+}
+
+static struct platform_driver st_clk_driver = {
+	.driver = {
+		.name = "clk-st",
+	},
+	.probe = st_clk_probe,
+};
+builtin_platform_driver(st_clk_driver);
diff --git a/include/linux/platform_data/clk-st.h b/include/linux/platform_data/clk-st.h
new file mode 100644
index 0000000..6a992e9
--- /dev/null
+++ b/include/linux/platform_data/clk-st.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * clock framework for AMD Stoney based clock
+ *
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __CLK_ST_H
+#define __CLK_ST_H
+
+#include <linux/compiler.h>
+
+struct st_clk_data {
+	void __iomem *base;
+};
+
+#endif /* __CLK_ST_H */
-- 
1.9.1
