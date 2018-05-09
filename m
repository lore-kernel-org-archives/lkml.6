Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934194AbeEIKBg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:01:36 -0400
Received: from mail-sn1nam01on0061.outbound.protection.outlook.com ([104.47.32.61]:3232
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933824AbeEIKBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:01:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v5 1/2] clk: x86: Add ST oscout platform clock
Date: Wed,  9 May 2018 17:59:00 +0800
Message-Id: <1525859941-23654-2-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
References: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::23) To MW2PR12MB2364.namprd12.prod.outlook.com
 (2603:10b6:907:8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2364;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:giue4uiKtMmuHL9n4YbMWWfPNyU7P8xkcwMLG8bgfB6jhge80K4Yt+8uwZvVQOSR/KQPRhLLLUHdz6G6crIx1q3wPSUtTyxKVwiuFBYd1KCjpQFoa0y2qFpznWI6vcpWQiqcySG7lO+EvD1RP4SdqHST85Q82sR6w3fduyF+Qnszn6lC2fbAC1NqPAJ8T286X2MTnkDL5LNC6VmkXE2R/ve2UmNACtBMI2qWfjTACozSQcdLz6vZOTGP4yO0IBjr;25:VTVAi3Mr/ZAEkGsjpj1/tV77D8vZQVRN+CgTgPDhgcGL4zYiDOnCrFJM72aVYQ4wCx7ukgrW3cDyVwLj1irQH206fQN2aW+yck9tmpzwkf6+ufq7ba/EsCe77cTARmmzPkVChxykTaEEOGMbZaXzuN6Er6iRNR+5uAZkdlxOMP+4pU4qAeBqxNC3MUekPZbpdfFuT7VOk6wEKwc/Kh1ldp1j646wmBYS1sUlzMdHnRCjcH5RvT8CLTrBUcfPq+UXE0nwz42lymH1MNm80/qht/TJNqMm2XriZEziwNg1SzHAcTSGSbDDIMTjb3qn0i26omBkaY4Zo8pjCcxx0rZGsg==;31:cCpCcdeQCd17tomVRjBqjNWSyBXm2TBc7LxC67LJpdJYes5TNx+TB/YCMiucCZMtK6hdjmiZmnq63U+dDhFNIQ4FsdlWReR0VKJok5iM6uWAfHxhnBOfZli73haXpQYDnYsL1yzGNDJfSAkwK475Gc2iLjdXfDRVlCcO4iAZbGPXPloXlUxrmbUEzZFPSEoLtDjyO+z1KJpPcWkHAaUEfoMuJ1vkelAmgFMyTcrD2vw=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:nQBY2UQukQjBruSrWcSCPQPSycY1xObMDXtawCSec9Bs3g6UldMe/oh+Z9iQdZH6SO3u9Fx2q6uDmaR3G3URP5P8+FV55nbl0zGaJMOPmGV8WrANw+q3WEpFTuhe4Nu40jNQ1Kb3q9ekqsI647YA1kcotmTLvYEjFTfnzpr8tnYeDr+U43/0uQTqUunnz2iMRJl3f39v0iTEAjB0LLnuqaEusFHAlwkM6aDTWSEDzKf2FAFRxu4WVRurmJTBi+O3HS3La5luNRiNmXf2YLBkjw6HTq1nvNNmbEbXwbpE8sTaEnx5ji+tzggbSq4I4RWM1ecpeabj016KYyTqJg7KcEUW5pewveXcJorc5f33eTbR7Ch5YdASkQSUgJSxzOM7PZxexFcZzGbBG9Gh49xqFaYmrfUoFf9JONS6a55Vm1tyXO0ABc2Oy9d8jHMuEZKD4gnXFsuHT0GlHkuqtzruAOLBJy6ioIBa997RBd5zOsDv/ZL3weg0M1hjZAi33kbh;4:hD6SiA7ko2SKgPlY1JTtVP1BG2XotDHgOXu+bgxbiGXjb4yqpTkUNu4qRiLh3Do6LpGNmmcz9skqChHGqCguUt09wVvP+6cUPJWLXOpRx/AWRoCo+0fKFS6aBhs3V6KVsSg1Nv1llKPDC6m1nRG1rZe8X6YDRKwlrTm+D7rIa3M9GSlXbfiOL5QNYvg4XNqcPI0FCNTjiZc3kjFrobnvgFZJ76WmolXcPuMcY/w+UCBOo5+ssZt2zr+4ep+45lXaA8OjhuAi0K6lMixps9uha7BZJT/NwhiP4EV7qgZBJPamoWLmmhNWXBlS1uLarIDa
X-Microsoft-Antispam-PRVS: <MW2PR12MB23645ED0CCE6D08BA6362AA1F8990@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(189003)(199004)(316002)(16526019)(305945005)(7736002)(53936002)(446003)(59450400001)(68736007)(16586007)(25786009)(50226002)(956004)(105586002)(186003)(109986005)(76176011)(2616005)(53416004)(476003)(486006)(26005)(51416003)(386003)(8936002)(8676002)(11346002)(81156014)(44832011)(7696005)(3846002)(86362001)(6486002)(52116002)(81166006)(4326008)(478600001)(66066001)(6666003)(36756003)(72206003)(48376002)(1671002)(50466002)(106356001)(97736004)(6116002)(2906002)(47776003)(5660300001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2364;23:PrM1l5LBrcVwG3EU5jPMnVIFBIGI36T4c+yfgM/Nm?=
 =?us-ascii?Q?XuiAuUKjzSIJvAIk3gLxNZBgSQ9Su9GUVvXeMCIpNV6qq9fvoQ3QuW9wwXsz?=
 =?us-ascii?Q?chycFq1M0Rvw6Wriygi26IjIo5Wi3tXhc2hn4wK5hwViJG4+qSE/GztRKWs6?=
 =?us-ascii?Q?WljBTDzMXXPgWO1l0Aq6TZAS/3eJsOMvxr8RvtjBTO/xCilLuq44Kdva43j7?=
 =?us-ascii?Q?7cxt8JD6PJjHSLxVh5vtuL/dMxpq2WKSBwb5q8pfMw2o9CbX67Q8/DNoDyOp?=
 =?us-ascii?Q?acfr9w2YcFLqhHUsfQaaGVSUCT2iudGP0TTLhM3pktfzoUe2F8dGI+AKamlf?=
 =?us-ascii?Q?gp17e3TvB8KXEIwCt0nM1iNtkLoCM8hJ3C35okVdXuaeoyntUFOEQVx/TrYG?=
 =?us-ascii?Q?Cxk1g6QokxQ9RtzfuB1oayAoaTx9ohSssMmLsWjU79b0JeL8b2x7+G/Z1HIe?=
 =?us-ascii?Q?VlrZa9NkYSdYhgtwVn43Eee24sr0BlNlgo5Xkd4hkWQNaCGvO87D9jpEwTzN?=
 =?us-ascii?Q?lly6VABhg9SGVmbIeBkhtJ6mS60Z5I/bkEkPD3JJjFU9Sapu4I8KkF+VzSMo?=
 =?us-ascii?Q?53RidmwduNebahNy0mag8Ls7fSqkCPrvde37Zi/3Cap8FB+DsJR6ZEqHzAFc?=
 =?us-ascii?Q?lAAA0ANEtBywzhmKsBkw94+36L2I/HdGjTkSKW+utCs6ORmkUb6RrqxO9+7u?=
 =?us-ascii?Q?9ybk8aXAnQqeRUP/maFdwDhoQ2zwPJS8ultXJEy8aXmmAmJz9AD0EPgmGwUm?=
 =?us-ascii?Q?JXMuUQWKnqZgesIWjlRxx80Zaz+4BHXljHDudMPKVVnpjcxyoMWVqjfLqzCC?=
 =?us-ascii?Q?cEe3mZ2vlaIDpySiQjI5hIj0fTZa4YDF2gsHVyFkYObN5JSMg1ZbRtR6yD8X?=
 =?us-ascii?Q?X6m+lDZ/4YUcPyujT6wPeNxteDaeHm8Rs0uuIv8mhs5x/eEmmmuZ+rOFAew0?=
 =?us-ascii?Q?S7/wFGAF6DAEn3B2yrKzGkorRuYec+m0VJQ2UEBHBXCQ+ARS8ozz5DDqgf2X?=
 =?us-ascii?Q?8Fbs5PRuiMxRzH3HCKoSteDSdrkS4Uot5Z5QWwII4pDxwJ6tACGbYL25TLES?=
 =?us-ascii?Q?4GPx8l8hvmC8F+B4x6YP/t4Dt8trI4yc64lo6oMLpBgoEmWYKvPaOPJ/uBDp?=
 =?us-ascii?Q?DBVjQlO52p7SLDeP4a4SqGCfgbtJv/yMZmATgj89NLTAKTT9bQnB3i8aDqVr?=
 =?us-ascii?Q?jlyWRmB7+oabtlzsMkP7zRj0/k3QsAZww+ant6ac0fSxiTlVAokYgQ33lbY/?=
 =?us-ascii?Q?jRJAS2SndzmLh6URjFaXZakX/b9/v3nMbExPrEmxYJeMJc1gDA93gFI47PtW?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: ayT5Oq2jgoH7G3Gqr0fnbbEASVfcnT1+iGyVU8J25imQB6tfyYmnywHHoQ75Iyf4Yi5YAb3uiArtT7k4vUTyjHrf+rY9ieYQT8p/ui21vkYlxu3ZleG07S+LnLfNad6ajVt28UUABoXKyHUvqsstNYkZOdtZ1ofHJo/pYWvgw+Useg0yvpj/iGWna7/pT/Lr
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:hEb1prhtcvectm7XLQmGwekyJKvET74HPGolhjBWEbS+7YOWDGtw4wU30+xqkOaF2o2bO+6BpJjMBjxQ+1pbK43yNd1rvsVC8D7yrkCTgTO0EgEqs/VTdFNl69RkV/qYHtVIko+YjROK06XKZUQ4xCoCa7TvPIB93xofq9uTB7RPSMFHFvczRRdrw9/k5e7bUKAgDqP5KuNFVMaavrl55Hl+bDv1yMhSc92HBuGCvDtLIwEQV8Kz5etwaqEU/qyX5wRQOl2640Wr8GpRVkyOVjCD39hf4jw5xwmA/RzZpAnfTR/IO34ORguMPWQxJdkZMANWSzCK2IYacr4vLrUQXgOGabRvIhis3BU4eceo3ldEGRx1HMF1k7nyodGXT3HzcRloDWgtmcadCWbcv8PPEs+gWivxlsxCpfukZW6p4QIKh7PBQr2Rrml2fSNU9giyDZ5D5WwinfTTt8vNa6wMMQ==;5:Rbi2saC5OA4iUv7IZBugRQeK4XILX0AF9BvnrJVpqJjjtv2PTuwNpISAPPwsfflWygc8bNEl59WdOTuiFjVG44nGjGbqhl4NbyfJkTJ5HvwCCd4ci7R7h6TuvJtBBJjw4wSSgOK3rdV7lzJXf99Gh5vXvlsoVQkloeUEnw4KV9c=;24:jqkfW8XOHLJZ5q6CIv65RSqeqQ14QG2o3HWRg6xjo4/IiLz4ZmB/JJs4SL2iqL3wO+Rabwnf62YkQhQ3VP8Z0FVsoGiAj8iJUHybr4l4RTg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;7:/hKi9Zciye/2ILvGjuQQyZsz/vQk4/IIL+f0Vg6zoRcQrx4DV6lEU3mSyUEkqMG0EQAQ3VHDKwqRAt5NokPQflOPfCOY62W9bU7v9qq/glgaFXzvRwd6qUlplSyo82135wReHtzmpx022Syo8pR48IlVpR9t2YzgUAFa4jYZIt6et9G2U0bx92zXuElX/fQH9SQUPMMGWn75YI01Xh6Rw+V66bXVH3cJNeJKgyANNDvdY9VRBd4IagF/f2b9HXx7;20:T8GxTDIk9Fs8b8/YWvHMy6LF+xWwkvCaqcFR1qZJKf4y2Suj00Ce95Fbhf8Y1+zn9yJPDjSsbt5EAz62CaKd8Kul/72cOn6Rnq4fioJrjJm4BYzgj6sipBMmj5mVHicV+RUoiGDgnpCO3e/vPltMafAeM96cF+K30guFJfI06gJIefLOJRtH1IZ12imht0PxIJ4n0YBQqw6Qf/PAbaOb9oRh0EHgfT9BM7XMzB5Q0myyLxmkClqYX+e7JpdZ8Rkf
X-MS-Office365-Filtering-Correlation-Id: a4b26360-2d76-4133-f3fc-08d5b593d4f7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 10:01:24.8913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b26360-2d76-4133-f3fc-08d5b593d4f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
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
v4: unregister clk_hw in driver remove, add .suppress_bind_attrs
v5: Fix license, used static array
 drivers/clk/x86/Makefile             |  3 +-
 drivers/clk/x86/clk-st.c             | 77 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-st.h | 17 ++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/x86/clk-st.c
 create mode 100644 include/linux/platform_data/clk-st.h

diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
index 1367afb..00303bc 100644
--- a/drivers/clk/x86/Makefile
+++ b/drivers/clk/x86/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
+obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
 clk-x86-lpss-objs		:= clk-lpt.o
 obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
-obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
new file mode 100644
index 0000000..fb62f39
--- /dev/null
+++ b/drivers/clk/x86/clk-st.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: MIT
+/*
+ * clock framework for AMD Stoney based clocks
+ *
+ * Copyright 2018 Advanced Micro Devices, Inc.
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
+static struct clk_hw *hws[ST_MAX_CLKS];
+
+static int st_clk_probe(struct platform_device *pdev)
+{
+	struct st_clk_data *st_data;
+
+	st_data = dev_get_platdata(&pdev->dev);
+	if (!st_data || !st_data->base)
+		return -EINVAL;
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
+static int st_clk_remove(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < ST_MAX_CLKS; i++)
+		clk_hw_unregister(hws[i]);
+	return 0;
+}
+
+static struct platform_driver st_clk_driver = {
+	.driver = {
+		.name = "clk-st",
+		.suppress_bind_attrs = true,
+	},
+	.probe = st_clk_probe,
+	.remove = st_clk_remove,
+};
+builtin_platform_driver(st_clk_driver);
diff --git a/include/linux/platform_data/clk-st.h b/include/linux/platform_data/clk-st.h
new file mode 100644
index 0000000..7cdb6a4
--- /dev/null
+++ b/include/linux/platform_data/clk-st.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * clock framework for AMD Stoney based clock
+ *
+ * Copyright 2018 Advanced Micro Devices, Inc.
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
