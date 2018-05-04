Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeEDIhz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:37:55 -0400
Received: from mail-co1nam03on0058.outbound.protection.outlook.com ([104.47.40.58]:10240
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751316AbeEDIhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:37:53 -0400
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
Subject: [PATCH v3 1/2] clk: x86: Add ST oscout platform clock
Date: Fri,  4 May 2018 16:34:43 +0800
Message-Id: <1525422930-27826-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::18) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:PYhEpPFQNJGHu+eJpm5UhdvoPPY2TU3xpqsuxX5EH+AdmgC/2xVJYcJrEU1efdW85g5G1IU361C/M3/1W0XXKESWat+1BtGCTlaih5cOXFX4LslqNnNADaP/DGYxLPy7ovOJv/ztwrxNkTmjlgFTSqRtaJgS3XFtHjITdHRGW9vfS6IMrt81YDns0hFW9mDQTuKwYuRCnufuTGtKXLTaTK7VHO9U3b2ThVW7JTytvWyTOsdO7EmCxf0DikDpMI6E;25:I3QFxwgB0olM5QLBNGC5CKRBLo1d/eaOLWEF8PYg0c6zJ8TXdmgLmvyado8oEU69VgcFx3E1XlfaF5ByfEkQLLbv74bXnAXm4o0WqevF4L4rTZxmd+SZI+hgbhlG2LvHmLSsL0jszKNix2Dk5/pAecnjU52fUrQpF9fAfMZ7/39DFHgNMunhO6DTz4UK6Tw9CaPByIMgjFu/PfgoAuRJzqkFl0rYL7mYi0dpSnf55W3aGJYZYy4oRobnx6Kq7snb1Fw5LvCQOe+pcTYrQDICgfJi5Bs+lJq2nTnsv/0bBUcPI6vL9mKbYQcR/mLlZalicuyYMJkaQCZ5QZeaxyErcA==;31:8CDhmVJDc36Oi5C4D/OPdhMZfVdrb06f+kxrpnJLUgBnrPB/E1SLKv62Sa97wNznTDz7+MsWMqxzQMhPH+PThZN0Tc64Yk+ruy3D0UG+Uf+EiR6qQyKt5pVNb0xx9+/kP31DTwQ24hWMAQVOqRd45SdpAE5Bi6L+TMrTBJ3hIbhIKGQXDNOZt584YPEghjZdgMJZhtwkgZAAi0o2VIZvNDhFv32RBVU/j/L84IIEGxQ=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:crJuGhMYEEQ5i3o9Puvch7AnXrp1vfBRHkwtJPXfxxA7AbxcrRjwb8IonD4ZdY2UhbjZBiISUzlrMpl9/MgRa/kepH//otsKuOfwV9yrSaS20tyeeX/Em3jtrcN5z8Nl/CRgfF/WCD4GgBQV7+HTf+SaAvclDa5SqHGmc85ewG7EXV88yeLykzTOUf41tPcLmdp9nrQpNAEEiQQk9rpwsiICd2Eby31OBGp5kbdF9oeYaY+UVGuQoQXn2gcNt/oVG/0qoffaxW5VYsMkxy0vysuozMvEAl+mkKaQd6D91wumbZ48N2hL32QPStQVXGNJJ+CtJmltul81biVsRE0FJAqm1+LImJdNlLp26jQMq/2Iwpd+nZ3bw4qlzdlssV2fLuneksZ/MJp3kbSLnlk3ozniftYJryTDQkOfhJvq3F3GU6ha2vtSPJwtqMoYmqi2vG1VB4IzwcrvNoqVMGM1TkrP+/lMvXhXWs+XERfEztvoRJ+k/4XbR6f297bCDBWI;4:xA3+oZW052a92+L5e0Yq4qYRyEVyKF3fL9Xlv5FPLsWwEUBSJCdVSrRC7MeswYEwr5pHYJUQiCGHrIbG/qL4g0C/Hlp5J2Uu2zkuH8XSPWvyhTYnZKaDBrtScvGJnm3rqIDXdVm9XqD/8B7BFEL6KTNXhU6VRYlDg4Bl7PF+mj+3jm/gO2T7vAmuhV9+rUfPAuVWjh5zFBkWMaPSHJ/hIiZO+3me2zIDcqEJ3gjTkx6jyOE7UzkdZiHpRRRk4uYk6MaJyO+me3XXP1MBFa5K5TUFEzqhQy0i6sNJsjVBTSsHg0/qagl78jXnLV9j5tmT
X-Microsoft-Antispam-PRVS: <DM5PR12MB23591FC3B47AC28FAFA4EFB4F8860@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(366004)(39860400002)(376002)(189003)(199004)(305945005)(5660300001)(109986005)(7736002)(97736004)(4326008)(36756003)(106356001)(53416004)(105586002)(50226002)(81166006)(8676002)(81156014)(66066001)(54906003)(16526019)(50466002)(478600001)(1671002)(316002)(69596002)(86362001)(186003)(26005)(47776003)(16586007)(25786009)(48376002)(6506007)(52116002)(2906002)(44832011)(59450400001)(68736007)(72206003)(2616005)(476003)(386003)(956004)(51416003)(6116002)(486006)(53936002)(8936002)(3846002)(6512007)(6486002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2359;23:pJMmpwuBtVN992VW3zo+8pTCxJmumG1E5aXA57U2a?=
 =?us-ascii?Q?NkcOZC5TZvxIWZMNLa51tlL9mtSuo3IExdcRK8HJLmKZUiPrCfEWB4TlymuW?=
 =?us-ascii?Q?IIHo2geiht0SuNlzeps4JBHFnUyZ0gNqS6dz6fanm11B5u0jIs9NzfaFXqZq?=
 =?us-ascii?Q?irmhfUvQAotQ/bt8nbEZxrUWuwzN7EqSUTg4dnY521s+b5GsEU/4W7VHyL8U?=
 =?us-ascii?Q?rKv46wo79NsnlgFKriP8ia5tCOtrbuCt2bJ70WTe6/x5rUd4Z1NjS7jZ9gG2?=
 =?us-ascii?Q?7AwrVPgAmk5y6W5976fTu+CKqzK6bNY2oBpJ5+Ky9EET0pIeHrJw4oVUqjs9?=
 =?us-ascii?Q?XYbgsZveXUR56qF9QJTBA7itNFr4ou0cH7xLiJpT5atgUpm1M8kGW6UVHEWs?=
 =?us-ascii?Q?WX9vOnpu9rVUUu2/nl8Iaoy/d/CBp5X5glnxVY4zyBx7bKirHNcJg0yTPU0W?=
 =?us-ascii?Q?Ys7UrFTi331j19dSuekNAl3D6HpuXiPJP6uvUbIinM4ykpL+gX9Q5nD7Vu9p?=
 =?us-ascii?Q?4PW0pUpw3967ULg0KNquknkuoTqvKTExLPDLSLbiwVGCgEMCsamXJc2RrJdo?=
 =?us-ascii?Q?N+Zzf05XFGWoIGFMjeRQOkkau5k6Kff8Qxwr1VNH3zMroDbYElL63CWZRF9F?=
 =?us-ascii?Q?8A34fDMhPlCFJ2EDmkCEb0WaxebycRtxvGzA10nHMjuFt7oKu/2rx6A3nIkb?=
 =?us-ascii?Q?G+9tl82dsISY9oCc0MWx/c8K5/DsP+JxdFc/OSz3cfVjlS34wyOdTAyOyBWz?=
 =?us-ascii?Q?g7J+BZHu7Z38+9KPxSYxo6qH2bK2WdIPa6rbztvvqO9SiPMxq/g2lXuTIpgp?=
 =?us-ascii?Q?5SMLggeqbqQjKUbZUWfGdbbtN0iDiIIOrrF6GA7JXskXqIYlxIKNbczmR8Hp?=
 =?us-ascii?Q?GOTO6hrpdbLzQf64X6bg9gvj/5BDhDqh0vc6waUUab18YFmsshSJwRaHWBuR?=
 =?us-ascii?Q?LLTdjUFE1+VbrBVVlRt6FxITev3xBzCtr1EbuFfueqMOs5IuffmumamHJY+s?=
 =?us-ascii?Q?32xP8e4YBM304f/wHMnzmToeJghVmiua+911AChUHZNl6mmrJF4JVX/MYP0/?=
 =?us-ascii?Q?ZiCdaVisVKil8gPd/8ml2HbN+0hLnFpWBEAjHWHwzp7YICrVFaAICGdjpw98?=
 =?us-ascii?Q?rnc2ea9ok3ewl7Y2PZlN2I3MKcDiMPeN6ov1R3iIsomLNBAhGqRS39smMuzR?=
 =?us-ascii?Q?QiBabxLej/MjLPvZlRK3L/1JKnKcZsfE3EAmkyEhRV1NYzQfMnTJ3fMpkE+X?=
 =?us-ascii?Q?0RuLbSJbbCz22Xf+RnL0doLNX/ZYCoT4j5l2C03?=
X-Microsoft-Antispam-Message-Info: njZUS4p+dc1/V6SFYd3/lhplt/gnietCXE4gh3yu+US/ffgrbEgo3Q+HjZsH8rvyHr8pDiadE0c+QwZAvl2eHdF4ahF+r7SiyNFDMkDipCSCekYkmcbqvktuwoV4ZR9aPmF11AG8d41bnr34S9wJuLfXMdOXASuuXQfxTyPj+ih5pCgPXjKG9XrKgBf8qFbH
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:x95Ych/t6T0Q5gNHHcjHjZbJlaEzbLoXlTP5F+x6ZIJA0fQsZNIHqa7qOHTIqVqWmKYEMeHcjBpXyV2NB4qqZ1vt89sOjbxAuUsqnRyD4OARwYdU+tFGSVTBEberxOY0HApTWppXC9ADAQXSCRTWlIDO1i3g2jBiaM991/DsIi3vJJS2aTOf2QXFy72XsKNn/XvAIBn7Sp79rE+Mk7JRTWCwzlYKINg/Beq425f5CK8Wa24HpjfOBzamB+gFVY18+YYIu3Jg5UoPMQYLZrzhOPbbE6/JCp0u2a+W1hlzOsDYjxzMoc9FArUU99pf7WjBxN0oVlwim3kwtw63EFSY64VyKM5cb24Tmy1d/JD9SBJOuBUWLDy+I5qhQ/ul3mgQTxbudnXIt21WBFbFibbnK439Ur8heDHbMaIficgOP6QioUhB6ivdVdDcyoUe/Y82ejYBVx4UyasM5U37CKNfFA==;5:UNqW/cVt9e5HLDNqxzmvmF+nQFIFikqCUP2cez7Y++85gkWsSSFdidVa9jKoJ6tk9QczUcqu0xS9UqQG8WmxZFZ3s+Pjpdqs9TFqs0RG8ooebxntN3rs1ejP9LLQYhWCsf9gajFB7yN5j+VqE7try6MPI2MbRQy77GcbELZTW3k=;24:YiDQSPT1wuOzOGHWfpfgmeesWdSgzt7ZvpTGxU551ALyg0glK805HMmBJplmA6ytbovKcmd2F3O27dbIaELlRN/Vgg/GrG5XpEtdNQkoldM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;7:14zEuQJVIpFlffwcRdlDLYfhptod9Z6EKqKYDcypU6nVn4YI3txBImmSxmxf1PiM4aj206scwfNrs5qYrTiOoik0g4THF6pMRihbuDLr1SLxUnzoFbGcKb3fMgx3IrY/IYRoNDPM8trdsopgWpF5Gy7nhgIn1cC/UZngq9KOtdCg/R7LJm21e07R9OtD1GcXOBePpCFLz9HNdT3kliVipqfm80TDjejxH/8hrAzA2E8kqpWDvtBwZrESA9qXOuBg;20:tQmqYbrwbpfYh/Nqznlzjf3Zx2Xi+O2SzlkoNh8vxn8VYu2VMS5PsyVgxgzeP1Zdl68GQwZufzKwas/iC/2XASbf+V4Omzo1LvbiMfHQBnBtvWTxtN+/szyfZXSFrBJ1BqtKdBpgxPjbpgO8cP+QQvolMQn7WqMhKwVOl61j1Xail/e/VSXqhlsK56z3BypdfugkRnRTcMI5XaSTPUcIh4UoFd1R0GCpQANWP+fr7dZ+9xZJlg88gVMrjtnaw3GB
X-MS-Office365-Filtering-Correlation-Id: a400b79b-3e33-43bf-9147-08d5b19a522c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 08:37:42.2336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a400b79b-3e33-43bf-9147-08d5b19a522c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
