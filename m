Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeECIeD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:34:03 -0400
Received: from mail-co1nam03on0089.outbound.protection.outlook.com ([104.47.40.89]:12791
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750849AbeECId4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:33:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>, Dave Airlie <airlied@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK)
Subject: [PATCH v2] clk: x86: Add ST oscout platform clock
Date: Thu,  3 May 2018 16:30:26 +0800
Message-Id: <1525336264-29243-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: PN1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::34) To DM5PR12MB2360.namprd12.prod.outlook.com
 (2603:10b6:4:b4::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2360;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;3:+D+M6QGuGTaFWUYBljElHPGuru1qjE2YETDyyQ84AaQzsy2dZ98h1pwP5xtekzoxEZJc+oGV7YbJ0Wy4mhLys+pqF3AnL7J0RGvWydK5QY+iI9qYilLPyY/tjMLaOIrBb3qoRAjZvWk8cLPryxCfsdrS2hhy0JHGsiyxelz66xwlhanY1xV3O+g79hZw/blSFgAUVtnnG13mm1I3NswquPUtMg9BU1IpIhEf2ZlTzh7o+//Jqzcprz8qvZHEvaxK;25:4mVVH+3UYxxZ8c8ttcOt3EzfBRfp8tXRb+xlu5DJ5MBT7NMECbo4Fcy1vhfTN8/j06P6fmEjJL6ZdJwcHN06d7lKcZimGiSQm3KkT6t5FHpAcXxlW/R7E3kkHRcalcWkoF50hVhntKy2uj10ZjBa778xEqRppAihMH3Cgg6lcl0swEefc1bGqCIFwRjxrUsnx6ndJL77LmxsgGAzPfRCDrzKKR5eC8FfHQzkUjHfjsOnuQ+kIXDIhkVorS68L0Jokg2djAqsODVOOnohIcm765n7j8fBBhEZJkkJymLEDaLar1KzIIzWa8p7X+58y1O6rI771Gnd1zRC0VzyG4biXw==;31:tuoeCGKQvlqoAfaVFsaKfQWG0MwzCAcbEUKILZal4b7GJnRvgthjEhMyHNBeNpz2x+tj8cOlXlw7qFIyf/DeOSt/YYVQEIHDNFZR7mjNEIU7ptZ5lifXa586dqJNfsgkMWtkzHH26K6fclAtv/oFiQp1Nl/R+nnSxPo5q3FwAkblOKBfnio6OuFqAmXZj/SQeOtpIr46Jlol7ZEuA992ss6Lt8jJ8aLYtZxXzxLOEs8=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;20:gyC+OcLXHH/ntJz9HnB66shWEONDp10t091Yd3cNE0th8Q1Rpj4fJkl8J8GAlXEzrP7tzBKB4CHNNGwpa0cysiYdwXMzXnP0c9qA35w+pssKvtD6VnMyaOv9ZHeTSHSqKLbfMGcC0M3C0UmswcJPIOU8+g60vYK2ilh75eP8/4hazoYdfZLbvt0qnoeGUoN182mhHzF6HChcwR+8VPOAA2NXvHhTp9FeuJHHDKkX1RjidTUOeAkM+UBgQ6h5gwTV8/7NOueY3UigWHVCPv8saL4fO8TVP8LI0NihN2OoA0s3O8nSk9SzJ1uIMDk9SxN7rAMbGsPGijKkaHGkJ5OYBn2k1Sg9SBbXVprnr6HgwbihP2B/EVhsxEKZrOsn8nBEgtzj9KTGvU0G6147svk1ixzYQPfQqT9S8KwKIV2tbTn9z3pMXuOtsdSQS4at3UrBBVDvanLGoO4A5JobtwHpFlycMwsbgeoUdQ/VRpjyDUKdLuUcgEBhcrkzJcynhJQQ;4:AHrpoZMYGGgZrsOnPb9wtGGpaaPtiesCD04aJ8UnFapCkxLAA3MxB6hdHQHu9Kf2rjp/ibcr5iDvisEPBOZt6Tqwj0AP5fx8g6FPQXU7kXMRHKHqsMPEfkkGq9tNoYUJhzbJS/WO0dOfvF5/3xE+9lfwFIJjnegoo0EdU/Lktyl1+hKLNK1uvyLSWdWEYtzhB67M/IHIuzXo+rFvBg1Vs8F+wD9FYaGpkERDXJjeFj7NNuw+1Ej1OqCK3ZX1wX/Zm3fNymlh8K6dZZz75JKTpTtGYL9uXdjxRvr6nBTbi+Ag6uYCFh9HfWAUyMpf/C4u
X-Microsoft-Antispam-PRVS: <DM5PR12MB23601E992E6E442ADE47743CF8870@DM5PR12MB2360.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2360;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2360;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(2616005)(86362001)(6506007)(36756003)(386003)(66066001)(52116002)(6486002)(53416004)(44832011)(476003)(486006)(25786009)(59450400001)(81156014)(8936002)(26005)(186003)(7736002)(50226002)(8676002)(16526019)(97736004)(81166006)(50466002)(316002)(305945005)(6116002)(105586002)(3846002)(48376002)(106356001)(51416003)(54906003)(478600001)(16586007)(72206003)(6512007)(68736007)(69596002)(4326008)(5660300001)(1671002)(109986005)(47776003)(2906002)(6666003)(53936002)(956004)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2360;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2360;23:Xsc6kYQ+yGjz72xUiS1ZROK0F85cKbLyLcKv3P1LW?=
 =?us-ascii?Q?NL0EwKalTzSgGYWpiYuGv/TMXvf5nodWgk/9q0YczY0/InliLEcxnoOaJgA8?=
 =?us-ascii?Q?6PDcjloQg9vIb2zQdh2Po3o2N4of+st6IQtEuSA/ERSfyo/td0uBXiGu9ZZW?=
 =?us-ascii?Q?argGCBBM3lVhBeOuKIbI8DC8b9zGOvTVJ4ObzY07276meB9c9dpU2L39PQeM?=
 =?us-ascii?Q?Bw5YJYHnEHoHdJB0QbOERlUQJNvwXHa5kI7NgxYjWsGYunKtHuo7W5EzkxsF?=
 =?us-ascii?Q?L+s7VEHgqDQIGlkXCoMksvPTpO5rJCiCf6xiHu/vGf4+Deq7sSUF90sCwi/r?=
 =?us-ascii?Q?eF/gHEgXYRvOEC9gPFifTe2w9ZiAvH17XV9GbMZrESBhsDN8O7/65B+lPB0I?=
 =?us-ascii?Q?rJ8VzxSBix5QO8zngXcZxmIuWhP9v5hYbFMUHr50T0NG+gIpqaAJbmI10Kr2?=
 =?us-ascii?Q?P+CoIyWM38DiCuwzhyUuVE63ejSVtOt3oe+xhiDGnPcFB4cAzh4a38KLfXMB?=
 =?us-ascii?Q?Vu4q6/73Kulku0iU+rnWWLRqoQbjJKnFrH4tBm3KvEB4SRACd259/AQbf99G?=
 =?us-ascii?Q?uiPEy6u676pHBL72k4IEu6E8YH2uv9keugVa3feHja8Df/Aien8ZFlKd9xsN?=
 =?us-ascii?Q?nAUQIGtakKayDzdSpxye1RswyRo1VeFulgMJKqvMw8MaqIRHGjriG8dwzYV/?=
 =?us-ascii?Q?j2xKAlCXGuh0exyxQtR086Od4F44vIL0uPoLeHhzYME3l3htVl8DUWEdbfdV?=
 =?us-ascii?Q?xZfsIdAAx6/NS6IO+0u5wtv4+n+l6T676AZ42kz+vzNw66bOBtKN4GNmFGyU?=
 =?us-ascii?Q?FKWovCW0Qkt12jH/kCL+SwTsoRH4eQuJ5K/JAiCjVxtbHac/0/1Xlq5tPIcu?=
 =?us-ascii?Q?WPrS09e3/UEP3zcnADhKHHMk9KyDUow7z3R5dI9NoL/NT6scqm9V+yuss72V?=
 =?us-ascii?Q?3vT4LouNuj3qqKLtKMsZJKBR1eRvtbLUTPhXKP4nE8DffgBo++lv6FEf+uii?=
 =?us-ascii?Q?VgjVZ6vyBlo3lEZ+68B9P8+2qMWmrp+9+ZwfUZPj3UgZ4sBzKtDw1gVEXJFy?=
 =?us-ascii?Q?Mc/YeJVPtq74HdfhhAC6ifqwQvxp2kMMSOBCmmrkuDKxFILfP3HV/beLavL8?=
 =?us-ascii?Q?uCKbj2rXOFlP0IdbSOUI3N18WRtibbH+1Ej77wvT22+hFnyfN2nxr6cf4mj8?=
 =?us-ascii?Q?bnj3CbGV/5H+Fk4GwDNisxx/n99WFIvKewZ3D2JNM1LlPgLCOM5M9lgw84L+?=
 =?us-ascii?Q?0En+WtRy1kREB3mhL+Go4Di5pHVRf+Do0KTf0PDDpQLmT/5BmkQBdTQhtrxC?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: qpLgflS5CeDTVYsj8oBdeNkREzYZtZi3NIPJIwouo4F4argNgXNkoxxkpMDvE1TARLjH0NP0alLasUCqltd1v0m1IuzeXfppl1qUNTMpVw4NK6SpN+xBiHGqgF+uvzNQs1cGUuthc1/O5XfcIDS7VSZLFisDRKGfKcIUgGLedReDPuV5D7rIgCsFABdawijv
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;6:GHA/Zi7px5vETm5lnl01KlyA+ToW8aO9EkYT1OyUGkt6iDCWTM5dK8eoDvPMeeH9moAA2snL5eJRYK+89hY7X8eoinOWgejAaepFBm57gs+7rSWrGP8iwzSJTnLxPTG6mn0lxy53Ptg0nLcvLwT1pTgx6pmg4OLXej4W0Qr0qpZxTGQnbCn9gewuLkx7at8ZQIifcXBtk+QkFgRJCKZVutK9Mief6gJNmJBg4rw3wD9SNAVIL0rJ4OVPv5//HF6kxD6kmTQBF+kjdByUtaFnRDmp2ZHd7oPqIN+pQeL3zjfjLmgoxtt4YUW5PTES0qvV1lBawQj3v8AcDu1ZignjPNDYLddc+WZQ8Pi6cNqHx4g1jULjjIYNExVCGM9qNZ7DMfUMc1FuR1NcmQ+w13RRl5hU4mynP2P5yJdx3boSssMjAvHdA0aAoG+pt2X8GsTlJAJvU9UEe4IEE3RjW6TWiw==;5:d0kjIVbmmQrk+n28s/CI//aeJiV+wmr+RFHFptxLGDEDOe0acMV6PGQfGy21wKJR5F1LM4xL41iVjdLBy6IJFq8Toc/dniTn0kklHcWxW2FTUE+kdFKGiJ7FeZlWyf7vSceiKAXEzpyKK9xb7HJR9ogmmzAONywZt0aJv93O/cU=;24:vNnIBSadOqspB5l10oLCnGO9XdP54Pcy35zRib9mWXaNSjksEPcpmnYuL4/1IkE2fJ/pa4c3DVepNz/MG1kYWyDQX8dbFfKxYlq0aqoJWy8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;7:CCCGkoTL4dbDpG3HNM82Xn6esyAAcUwF5Iy4lcnFEzqcHlY8aDHcR3vabNHsxAl833pOPhwCNpoAtq+rGRsMXLgFgSGx/wzpQQ/sEmB9gvMVKOVrGgSMAjDMid6onVO/gyRcbHa/0QnuQ7jAqXkmPr84rIH0sG1zQ/0HLHh7dxFGUDvikQo9N7LFyd/vDJJWek+YlE+dGZrjAT4nXOTV24lkDeJxg0l7wyb2WW210o21LsBHKRedbLH5VI938YbR;20:36J4GdgtQDPCmwgn5QiUbkWqNXP0TpbmYj9tCmx4ZxiYpCKdu4w/MZy8OV1T50sO16nNdnhoq3V6BE56oHDkAdNA5SLhVGxQ5cysrJVtJoFlaEQ00BfNrhjlsZful5f8M5MVjEDPvuoH5/DsV23vJSTh1AUsXEGw4mf6bZc0ExzwUTVPqHsC4heTGhy/rll36hHp6NooO/yd10IBcunxDNLqctYKh7m/99b4pUg9z37iR/W+NijjZ8ykB2q9IoV1
X-MS-Office365-Filtering-Correlation-Id: 02b1443b-ff2b-48a2-0588-08d5b0d09ada
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 08:33:45.7020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b1443b-ff2b-48a2-0588-08d5b0d09ada
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
 drivers/clk/x86/Makefile             |  1 +
 drivers/clk/x86/clk-st.c             | 86 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-st.h | 35 +++++++++++++++
 3 files changed, 122 insertions(+)
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
index 0000000..d8c283c
--- /dev/null
+++ b/drivers/clk/x86/clk-st.c
@@ -0,0 +1,86 @@
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
