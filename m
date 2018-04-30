Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeD3HKB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:10:01 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:38151
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751659AbeD3HJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:09:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK)
Subject: [PATCH] clk: x86: Add ST oscout platform clock
Date: Mon, 30 Apr 2018 15:06:53 +0800
Message-Id: <1525072055-17898-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: PN1PR0101CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::26) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:25::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2368;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;3:BhYz9aXbKO1OzjOEBsZJEr7e9kuYgJtRl12dtaPUWkNOev2Glu18608uuosalOhKj/A84B7uy25YIvwLIUWu6CpBk3OdLWgC9gKMC545b1DmtvR9IyO3Dvi5EDSXfD7mZtlItC57PPCVgtYTsk8NAXyQiKOxYu71DyhkyA64IV6ntfQSykzcbP3Ux6WgnLg17EOdnqEMI0Qsz5x3z714+LYm51G44OWIh5R6gTESwbRbSrgtpSMFdAFujpSP/pFS;25:zxJsnS1A20hcKqtEOvX1vnztNXSzsOfURRelWPWtpbHwPQl+BLYygFrqQYabUvuxWEO5cNK4UExSohtHLRnNvQF2evQ4FzdzMIpjNpJtqzd82Y0ZBGh6aWDvirxvdANyP5crIIlXvGUipgMMDh8BYVTH3a0ijHu9TqP+tyZ7d1D5mP+j9IxdsyhGmKUbJHpk1vgQREHHdUKFPEAVu/HrEkSi2Zy6xJQQFOWJNJBjvcMgxBDcSuhADO2JHbGhJlYtBvXpv7t2P0BU8KJ+iv1bX2fS3zNm8Ukjm8gJTR37AwUNUn2q+jVYANg4m/KIh+Eq1aKuoOgjA8qAZanrxZ93/Q==;31:dQ+Bo1hZ0+u55/Uv/oPwti3SxLeyWVm0AsuBA8t/lWcbxef8/lIURva8d3DxXxhU/zlebxUeZUgci8Jk20XxNnyZFeaULN7c37qOTipl38am5iEBXBtVXaH/jFXveoR8UoWmqid0ceNS/9tJWv8430hCpC74KTqlB8UUris7nUh9bGqwNn0zeXSK87WA/Iezf/yHR/natdSYZy8/gSmKgcogeAMQkbcIwGj8k1jLoiU=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;20:XU6bMQsWo7ZPSiX7/U1ITMYUluOtZY8yg8qQyJF/3dRgcUqEK7G1QrwH54MgolmMlDJWescvlWUcAKZ7DVhSZMNvleDqQ4x3pbx4k+7Qirgs78LeckhZBgP8vuKJMua0ytuXjWEjOQmIZUyfLWCJ6z5pe2Gh2Q1qpORG4tGBZZu4+Yn7p/Wv1dMQpUPqkp456yhcW8kr7qAmhBvjlwLbQ+YnHtnlcW36cWRA/oI0M4tExNHOYD7Nxr7S5WOvG1jRbLzD+/TMHJ3ZXYl2oAyVR6SHaVNbaGg3zR6vqGAiPlK901sF9DmqJktMaHu0lz6WwXB24UptAyoNdZ8GHWnieA8v70yGhqZS5GQSsi9mlK4A0KDzbt5jt/yAKzEJuvahAiQ9+hKShUBPf6YuDp3tOMOeXkSHUtlM0OmnwTL42yP2y6fcStHkNVDaiFCjyzXyTcL1ib3Q3BQ5pTBHQx16iMvNxuG9YV3oYb/AiKEtmMYyN7XB2I/3pScRqLbII44p;4:HCx+8FZD5ALcbV7JPZr+NE8hiS0D8HOAm275D9gBST/Ra0dJe/x592GguxJUdzRHXZrwAHgy2PTLaBsAQ3yyhfzKqD7eqAr5b9IqoPZReZRjoEfYtL3gpyfjt73sqLQ1UKuuyIbV52GXysqQBqdZwt6CagurjHCrtRcqHz9vQF1zsqSJbsFmByGtHWRcuG8NuHnMDl0CkV2i4PRnWDZdosT6lmihwFu6qdPs+3rrqAwAWyXaXE/NNXtoZe9bhovOrEj6sqsGoXXDGJqh8NlSASnvae3VAMvdJmYpPXGUqHxWOECYY9eHBjC6npAuAiNL
X-Microsoft-Antispam-PRVS: <SN1PR12MB236862ED593B6AD9AC6FD339F8820@SN1PR12MB2368.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR12MB2368;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2368;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(6666003)(4326008)(2906002)(53416004)(69596002)(97736004)(6512007)(48376002)(575784001)(106356001)(105586002)(109986005)(53936002)(86362001)(305945005)(6116002)(72206003)(3846002)(25786009)(81166006)(7736002)(50466002)(1857600001)(956004)(44832011)(478600001)(54906003)(2616005)(16586007)(1671002)(476003)(59450400001)(5660300001)(316002)(66066001)(36756003)(8936002)(51416003)(47776003)(6506007)(386003)(16526019)(52116002)(186003)(50226002)(486006)(68736007)(6486002)(8676002)(26005)(81156014)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2368;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2368;23:CcYqcCARnXyt/gb8/MRrKuXJXCfi/xP1MGrg/joj1?=
 =?us-ascii?Q?GNgwdDB/ninq9w6/+WRl487f+GLCoyc6OJscxkccD0L8FcFQOEe3ZzN6/H7T?=
 =?us-ascii?Q?CylDdNdX0Y8vD/wzRwwQDOaTspzSPu/5qZhIMRv/bCa7fE72aM7wCtjTqDON?=
 =?us-ascii?Q?TOy8M4KgXfo3n7b+mnj/lfr5hf4k6Inv3vLAObRgAlPsYvZadyQNnNXiRQV4?=
 =?us-ascii?Q?B4LDEYTJPa9hur2OO5DSbfXKpvsOB87i5cQvUE7n8hPfD5dHm7aIGev7qHoq?=
 =?us-ascii?Q?BnhVmlo/mZxZ0OyMD8ARcC7IbqHuUR5oP8ytw82tI3bSesBOJP6hWedeOdYL?=
 =?us-ascii?Q?2LB7QcWMjsRvWOk0vr59sSoKXSf0zA/65sTehmlSyM3n9tta8iXLKOCPeE2R?=
 =?us-ascii?Q?aOM0jeMl0MwV3dz4BoehQUSllLGCZzVRwK7DGpwUQRHxAf8GK8091RI+4/2S?=
 =?us-ascii?Q?yn2M4JrAWWiuc8qS7YFupuro0r6KcOrBsy1zju9saScjdPd1ZhNkySRpX0wx?=
 =?us-ascii?Q?DK4b1qrF7vt5O/I+6FUU0wXJlJSeSvXS8XPoVouIzKKDNXVc0G5iM8JB9qpz?=
 =?us-ascii?Q?pXKLxXPtfISDObew2SL6hls+E8q77hQbTKXpZwGS6Sb1NNdaO9j2OSHAJJ8O?=
 =?us-ascii?Q?45zu/kFf8tomvVgw1DUPG2JReH4G+iOy+pPxQCVryp34koD+epC9zA16wBj0?=
 =?us-ascii?Q?u+frQWhN7LWZ10xHE+3qa5hXbHkEE060QBKUecanaHCuccipHzxjt0f35TvB?=
 =?us-ascii?Q?o0cSiRyY2tWLgXlmzy4+WZjVHriofYYnP8k+qiVEBXp4EYQb9pJqR/gbWY/h?=
 =?us-ascii?Q?ROnQfmJFwAtq11YinbtVjKmn1ETHYlpKyQv4JC4of3+CVSoNae6qU8uopzss?=
 =?us-ascii?Q?MNFX7GANHRcmWPpaGNh6LE41YW/hN3agWytT+cZZ7yHE/kFrx4xvC4C09Cst?=
 =?us-ascii?Q?GigLIcX8gTDh2prPNvjSwao/K4HjrS2K7suxYSTT3zMZPS4uAMEAZ6NWmtD+?=
 =?us-ascii?Q?7T1qeibsdxb7DpMsIPD6+blWxKzrTuKSKAUYBIQaTSYDpPXZPCInGap0UeJ+?=
 =?us-ascii?Q?PQ4eG5Vy5yiZaY7bwEnD5T/R+xsv980DYvYeytEGKGN9JE/8DU6y3N+QpRG3?=
 =?us-ascii?Q?M/dLWZ++Fhn4TiKkL/KIBE88yjL3G6BZHaP6/bH3J1e+A455eUPIDBPdtvh+?=
 =?us-ascii?Q?o/S+tZVOOAs8AiOaKhHKRpCst6ioAzWfdqlxCwO4aD5kzEZCpoAR4XkXO/dL?=
 =?us-ascii?Q?ZXCFv7vk5KxlpDCqQvhoQ4hHcvw37U4MgLgAzRu1nTOCoieDaKywT0wxAQom?=
 =?us-ascii?Q?7OX98KyGIJwgAE2FVYDBv5FoljbsrMlvYDiJ4NyFAUK?=
X-Microsoft-Antispam-Message-Info: 9fj2RAtAcfgq7xll77LsF35rXGJqB0+QnKVq1Mdnt1W0u6HRx2bvUdbsuDvLZ3POLE5ZINsHB0LxsmitkO6EH8PYUoFeCect+It90eDkiOoOb+Uk9RriZXSfWbk0VmPZANhyEmRkkgsoQoP3ArD2Ev0QHfBzXQH4ulm/VAr5sRiqqTUTv9x/tXhxVk7L0eHZ
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;6:2IIT1CjvgnHQ7Wj5tlI81yJ5BDCQaL0ORQFMJTFhjYQY/bLErMrJFAT8XvehSsp+owcQ/itxXszDlAIvhhcwGmgbLl1F8ETqeDvd4su6oa8fU5MVrE1oxmhnQN/p3KHN2SNDf7aAfSjV7IAwhR6R6QRmm7o3O6tPMXcziOovwcE8dW90UAPz95K/VDleqhmLLYv/JJ0FuqhfefoB5FXBv+/FkVmvRfXjLuTgHdlP9Ud+WpfOfrfpnNRm2n+qYV/1kT9MeREG5jWHFrQnabtEGGa6fE+UV4pLPcdzpGKSRHa5C/HObdUiaAERHbbaEUN3AHaamqENkqoS1HLDVfgGsw+eBR6VLrkIB57DjM39wU+KJ/Z8HHEm0WYaDc0OaqjAx4c9d67EB5lEzubwu9/x7AJTyPWd2nkVlJi6H0XeLgnb34sOlre3j+dTUzeGHGZ59x8Je6wIUVFyysmlwoEcsQ==;5:onmr+MtYrhP1oo8HCGgc6/CtX5NlZsrQ/nvzd4G4+5/3xKWs8DUlcTQ73+wgzoNIMJkHUV4KWKu0VxbEPhrz/HPZA/kHup7RkOwjyEGHbvb06AXE78tR0SUj8uo6MpnS3cQgZ64/qhJchNQUt7NE8XJcKieorf0dF1u29Re2u0E=;24:upkPH4K+TCPnbLXybpSkswsxAdzfbqjpjD6NHYoDNhtolx+Hb3q2FY57L7YlNeK3/E02IU7R6rW+iykaoZhLbypaVrIdZOO30IxUo+V8cng=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;7:v/b5jR97NdK55kmU6kqILmcPTDG3CBbzu/9omy/DdyXE8Eo9KS3p/HMmB7No0QajPPLm3HTAie4M5zv43cUfmzPo+YtVJ1AKGwCZhYT94JSQTzsm2L9JrJG1IDa9oaZnj84xfUgDCpr7O0oMpEozToOQwt8WXdcQEytv9v0gI/B0ynWfCUyzy1oGh9d9F9XsOv/WF1T92HnTuiDQPN+3BmESyTPnPkxYoDE64j/u4e5yKLBkcY1lY+4X7F3CbQVy;20:tUqGa/nL/NknVeJ1ZBC3sCNfuYuz5cB5dSVAbOPcgw9gUFkn+TnV/zdF0fEZ8HHUd/r/Z8NC11dmsvQHoc7E0ZllDQbp4P06ccB+6JLZXryqC2ZnPtANjzuYlaQNFAEHHi5yIU7oFyKfJgLwliqjy5We0c6/BPWTJqs3Ffil2fnnYb713kEqiu+3kpIVGS0WhfmDBRpOCOwEWwSl/BZPga6F5gIc4yDZbEWwX5KQaYkObbGZDOxPHMjXCUCQBxVK
X-MS-Office365-Filtering-Correlation-Id: 69ba1f70-e72a-423f-5a6f-08d5ae69607d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 07:09:46.6887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ba1f70-e72a-423f-5a6f-08d5ae69607d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2368
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stoney SoC provides oscout clock. This clock can support 25Mhz and
48Mhz of frequency.
The clock is available for general system use.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 drivers/clk/x86/Makefile             |  1 +
 drivers/clk/x86/clk-st.c             | 80 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-st.h | 32 +++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/clk/x86/clk-st.c
 create mode 100644 include/linux/platform_data/clk-st.h

diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
index 1367afb..f7ebae1 100644
--- a/drivers/clk/x86/Makefile
+++ b/drivers/clk/x86/Makefile
@@ -1,3 +1,4 @@
 clk-x86-lpss-objs		:= clk-lpt.o
 obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
 obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
+obj-$(CONFIG_X86)		+= clk-st.o
diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
new file mode 100644
index 0000000..6ac0dc5
--- /dev/null
+++ b/drivers/clk/x86/clk-st.c
@@ -0,0 +1,80 @@
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
+static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
+
+static int st_clk_probe(struct platform_device *pdev)
+{
+	struct st_clk_data *st_data;
+	struct clk *clk_48m;
+	struct clk *clk_25m;
+	struct clk *clk_oscout1_mux;
+	struct clk *clk_oscout1;
+
+	st_data = dev_get_platdata(&pdev->dev);
+	if (!st_data || !st_data->base)
+		return -EINVAL;
+
+	clk_48m = clk_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
+					  48000000);
+	clk_25m = clk_register_fixed_rate(NULL, "clk25MHz", NULL, 0,
+					  25000000);
+
+	clk_oscout1_mux = clk_register_mux(NULL, "oscout1_mux",
+		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
+		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
+
+	clk_set_parent(clk_oscout1_mux, clk_25m);
+
+	clk_oscout1 = clk_register_gate(NULL, "oscout1", "oscout1_mux",
+		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
+		CLK_GATE_SET_TO_DISABLE, NULL);
+
+	clk_register_clkdev(clk_oscout1, "oscout1", NULL);
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
index 0000000..5ede980
--- /dev/null
+++ b/include/linux/platform_data/clk-st.h
@@ -0,0 +1,32 @@
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
+struct st_clk_data {
+	void __iomem *base;
+};
+
+#endif /* __CLK_ST_H */
-- 
1.9.1
