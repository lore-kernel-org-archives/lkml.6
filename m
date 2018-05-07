Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeEGKRN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:17:13 -0400
Received: from mail-bl2nam02on0075.outbound.protection.outlook.com ([104.47.38.75]:42592
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752003AbeEGKQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:16:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
Date: Mon,  7 May 2018 18:13:32 +0800
Message-Id: <1525688013-9928-2-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525688013-9928-1-git-send-email-akshu.agrawal@amd.com>
References: <1525688013-9928-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::15) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2366;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:I7GE0pXtKVkH2fNk4qI5osDQVNB25IV03JhKC9xNtso3tC7iAYZ0hIwnHYw/R4k6bEBoDt/ISvypx1qweWuGnSrj+znLFLL6oHNbt17Tn5vZMNXOIHdFbWF0S2c+hcyQw2KjbQvDPzWhxTLM/cIzkjeih7aiGFkQsczEWGkN8smZ/3WF5WDBXu0WdoRRLsXWmEMVhvXMKZ7TAWwNA6KVyaiMhzLZBesfGVGzCggrLxB2aqOBFad47RZmHHmxHm2p;25:Iz3xfomFdf411ralPkzy+uzWxIpM2GuToMiXNF7NkP9CgoWKfDzINGIhgf5tYNBJdZyAEpRwrntfTjaI0cZv22HktEx6eA9EOaIF050C1pFaznEZ3ev7ntTKPO0NlOxWEO1bTW1rkMxmKXKNNZ+2T6gX1f26iRKjqQaGPtQhLjlx9f9ooHVHslY7i59Ca01QBMmmWlH2O6u+uMlu3v+oYxDkQFxN8SYRh/dW3iH3cA1Y7XjuqZHFbVVDVL20mwBoq1qozme1nkiQevEB+Mzbh8DaZs2VZXdjCROgpBQrREZqkpuMnNnGqrcWtEILRN+JvJgz5+QarstPeb6j7a43PQ==;31:6KpDwCJpfnKnmZUQ0GqpWrw58B1JoyO5Tk4twzQhO8wiXQXU1bNSaggfdosXwQko507wih4Qj1RQo3tC1EVpQtyS4W5EKK39yhsPEHGGwI5dTgFNOcrCqwSww94SNHoQYU3BeUp4owfwNNj8l9aZr0/c6tRumGoiatfc5hxubzEz6Os4RNmaL2jC1Os3sfcV4CyyuVDPJqp2KJj29Dwy3Z5z4uLLyYdDxjIP2GnrB6M=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:m2XtOXPQkOWfic2lGNtXtr7BY2Jt4URlnvxkRkQtNp8sDhCA0OuWK9JcdBL4mrz4WfQUpbs7hRaBgLFDC0WpeNMsqoKzCjxODVMjXDMCX+J1kj9AAYYuOM8rZZzvXXykqUmijXFjkBffXkef9Hkdr1M866t2trqV6Jbfnjj0f6/nbo+Ku9OfkjmQM9rVYMoii2opJbckiWUBu/hrZBeG49i70LH7DHlFN3d57SqKAWKiLm+KLbE/V350lbZfNhJgQI1XU40/Ff73bg7Bncj7IM8duVlA0ItwSFnBIxv3uBC36fazqGuAADWzQXRHuYfDI9dVDmxu3d81xC/8n4/XHeY+H/hPH029KA/NlApKlo22mvmH9QtPD6t/ePTicRttBFYmT0pDoYIRMEXqvOnOs0SVy+e+nIWdPvQFCSBJ16CNdJ4rawPrEAl6AbFZ0xe+eHEti1YuNBUysVMUmdqs9PG7WuxHZFCnXiUksNkYGmzEK6yZptlMKyCTo19jyM/5;4:dMAz+lFfrgKeXWUMiahngD049KRG+PUxEpsfZYbzxKEYXL3pwLuwFbhW/eIwVzmk41RZI6fP+JLsa7aME4fmq+6sWvJCX7O3VYYrBL9xtzrHNPHiJ6W99y2cDYk9C8I+KXaWU6xKqfxWBywjeVRK/3lhBLH6t5CQoSNjf6M6nRR3BXa47n5Skb5iFl2PZE59X6uQ715+oWQzYHCiBu2jD5HMG3R0ljCYB8/XJnBJB8S3s3Y2vUtyO1w2Ky8k7Up466H6dwaOcd5ADGX2Jr7ZFR9o9QAPst3KkEHjsEPQRa3GmkqXSoR1EhrD9aQOtsjJ
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366DCEBB20231F28D4B0335F89B0@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(366004)(376002)(346002)(189003)(199004)(1671002)(50466002)(8676002)(48376002)(66066001)(316002)(81166006)(186003)(81156014)(4326008)(44832011)(6116002)(69596002)(26005)(6486002)(3846002)(6666003)(8936002)(47776003)(305945005)(16586007)(25786009)(478600001)(2906002)(68736007)(50226002)(53936002)(59450400001)(36756003)(7736002)(6512007)(86362001)(105586002)(5660300001)(52116002)(51416003)(76176011)(53416004)(476003)(386003)(6506007)(72206003)(16526019)(446003)(106356001)(11346002)(109986005)(2616005)(956004)(486006)(97736004)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2366;23:oteH3m1PQw7x+pJWCsQIVL582nNQvVKD3mhgs//iS?=
 =?us-ascii?Q?XksD8Ix1XqvY6RlssdjHtlqNTVVaFTRR1JjR1isauDiAVYTmg+kEsgTC+aAK?=
 =?us-ascii?Q?s7RYwNz5kmnQqyM89urb/p1U0k4yeAX5GiJI7nkQunFb0X86OztE3bO5juov?=
 =?us-ascii?Q?S91+Wq2d6an7McnaldT9KNZ5BY0Wktw8nVbXXfPiwMaIMp5/AvdPloycK/ov?=
 =?us-ascii?Q?DXtzyg79UVRO4IvuxvHx/aaOioduZiKpHpn0kroXnA1td7DFIkjChQl9kFKe?=
 =?us-ascii?Q?1pyZU3IxEeWlG1WbLLelKRJn3D2AdDJmBV59NCb5afB+FxmSL7ZcTfu+2z/o?=
 =?us-ascii?Q?aXR3qbaJSd9dT/Gi1bttbnJWdIf/8hOgjLDIjwGfy87/witDVirrC5jWPRxg?=
 =?us-ascii?Q?vJ8sYwu/Ns73xOBLE/Tb5Gz2y/Wo6VFJmKXeAQGX4FzJGdFEkNLaPRpX33ix?=
 =?us-ascii?Q?D3dCyXGdRtRh0n7rkNUTwjFHxTj9dnMrs5Ht1urdbS9bSftGJbOGzg5fY4ZA?=
 =?us-ascii?Q?YdnsVe997W9F2IbsbCctgeMdmMvD5KnoPvOZfKNu1xi2xupKFdcDHt8T6TPy?=
 =?us-ascii?Q?4GxHLia9n+QfOul8ZhDDR3P+uTxUIrmXxnQMZ4egUlrWJ/iKxDe2hXfmuhrf?=
 =?us-ascii?Q?M8dkLW1f+5ZSl3JLgKUsD4r8e0PxenPdg1xq6g4PAkxf//ZatLKgq2W/f+8e?=
 =?us-ascii?Q?mcECNUPNRPentzKHDCU9EUeUMtEsZjwLB0nMXPqI/mgcUsYXYxOwunU1ECAU?=
 =?us-ascii?Q?cgTvqAJoDsrbR6fXV1BmZvXp7PIg6qwGhSndnPTP6Wvu6fKX3m6hAzI+Fhv8?=
 =?us-ascii?Q?7k2geiguNZeGPsyB4248yqsATdXmLtO1WpZK/z73vheQExDrLNbct8goEph0?=
 =?us-ascii?Q?LL107nTCsOp4Gwbto/PXVqwNrNBaOG2g5epof8X0XPUIwFCQmkAYXfvuoj21?=
 =?us-ascii?Q?uM+nU/s06WK3fuYnUjvll+eg+ujvmKK4fEI2kzPC8ZTtvVPyIIkVMXO6tWyC?=
 =?us-ascii?Q?APxP/Avx9tMO1f3jFMaVSg05gpKmHaWBy7/ALnQpPBlZJYNF77ABRJplomph?=
 =?us-ascii?Q?8HI4MBYdfxy6/s/cJkyn0vXdK1syXyaJqzFaGDmsNI3RzyqRZyn+IrqXQkMU?=
 =?us-ascii?Q?GzJba60or5flm/68IMu3Mm6bTH2JdFsMuYBJgKWuTSpmE9XBi0rfV5Uaoiuu?=
 =?us-ascii?Q?FY5B3evbYY+C6ZgT5mhHH4ZT+unoj4n3StImpYoteIgE8xdWpSdP7vPbfurQ?=
 =?us-ascii?Q?yQKQW+UxFnszbIr8uEqqoieD7gZwP8hYw/kKTeFAbP2hZmFHSaEZWh7frfQz?=
 =?us-ascii?Q?OmoQHVNEoYncaCVDc2ZDnMektLbXyHZNRBZScCBrc4u?=
X-Microsoft-Antispam-Message-Info: 9fkaqoEvWQT+tc+ieWjNZNVMtgqvo3OY/FAlRKiAGllJkuZhjRpS0gZAkDHWFjG2QRRcIj4iyFcPKbdDappapV4kECDGY4ywTmR51u9k5wWHom51V4jZqRRFVXN+eqjNlfQ64ldVc+GrgnVGU4ngn5v/N4gL6a6Ii2kllhPvGfYOVn+oIb+8NCwRjEBNx7AG
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:TysjRAybF5/oEO3u7gZpnDkVBgCzLdCeuBLzcSS6wZllOAOHklrAAhSgrgA0kVCWnU9qzpVZWRtHl6WRowKtVFdudJcT8m3svXk8QQxWZLmn0HR873WsdQ2L2ypWSJ/OxgEsw888ZFDGXjDZQF57QBC9zPfMTbz9US3Zrc1K7AMRosL7uyOshSanIjCQ1/QZ4vY8SOgcXzUKbT5gxYlxguJkLNW/+hxJhY604n+Ilgpe5eXjO5QA4l1Msvq6E+E6/Fko2ETSEM6UHL5gH/+hFpO0vI2E2M0xbV9YoT5eJluhpOmxzWJpeyyt8SuUtnDw4h+XoQN1frDBwaC/8XweQsVuhGvNWrhXMxKKJ6eszM4bwxmOndt3k780m4PCDJOF1QhEiad7LY+GoVqPNUfc/28+gUtYinMoBunXqc6YvdEpJk6uIrMz8/5qWtbDN/uby/MA+p5dYFIScMEnjlY8dQ==;5:eMOoLXASBwzuwTJnzfWmDv5CZuTxFXc4hObxHFI3mgWNYUkTBrZ6j0vpjfZZKOahNzMZa4kZX2/1APxf9ux4DT2huJZ1AUHEpoJazmXHpsuvvKdP69W0Fu/z3FuOr+v8sc5SpTS7/gXh4wJuV6PbqNnq2hoAbKNqLgB8NXJcqBE=;24:DV9Z6XX37CgX4uT1IvRADY+ByDDd7tscre9Rj36xBh57L1yLY++XlTiwYhkTvGR+7FD8dZSdSj/gjueLV6IE/2lUJHS+X5SFarOoPpBcDgs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;7:qvW7mvXiGRzKg0VGhAHxssHmIKmGOhUl2Fd57npGYv4A/YC6L1axuauZJRSfPWSd0qzZmFoz8IFSaSi1+2C0WW13Gr28c8tFdof1KICT/1kmfi/0qr4e5Vzcp/5bf3oc3fgzj49t9KKdqvAPSGPBYBQDbZqoZV0iX9T/Ixsga4Qitw3FIx4kEH5/0I9IqhFemQFzE0Zw0db5U8yAmZTMTwTNGNDFw38fHCh9Z5lbwBPfSy8sZ65YlsQGya24mv6w;20:x8km512fqpdcqh+H6/xGE1tAlAUhwSEzzK+ima74OqeAx5m3HNpMIkgECiByv5phN8WABCZOltAatVPmI82lS0MMdlNybo6zAVBL43lkeKUlK8TzUki3nrNmHiPeUHBpZjhcpAFgHgWXx61FtCcV1XE3KV0DCHwie3HLoBVJshiP40LeibTYlG6eCaVS4CdZVBByVXvDdCxOtmtznEQ7TNu2B+0I8wSet2nWLJgIyt40taRWtmWB+dOM5oireGgE
X-MS-Office365-Filtering-Correlation-Id: 1882ac0f-1086-4c11-df59-08d5b4038891
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 10:15:57.6500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1882ac0f-1086-4c11-df59-08d5b4038891
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
v4: unregister clk_hw in driver remove, add .suppress_bind_attrs
 drivers/clk/x86/Makefile             |  3 +-
 drivers/clk/x86/clk-st.c             | 85 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-st.h | 17 ++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)
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
index 0000000..8a7795c
--- /dev/null
+++ b/drivers/clk/x86/clk-st.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
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
+	hws = devm_kzalloc(&pdev->dev, sizeof(*hws) * ST_MAX_CLKS, GFP_KERNEL);
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
+	platform_set_drvdata(pdev, hws);
+	return 0;
+}
+
+static int st_clk_remove(struct platform_device *pdev)
+{
+	struct clk_hw **hws;
+	int i;
+
+	hws = platform_get_drvdata(pdev);
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
index 0000000..188184d
--- /dev/null
+++ b/include/linux/platform_data/clk-st.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
