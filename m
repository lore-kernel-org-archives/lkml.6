Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeCWRrv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:47:51 -0400
Received: from mail-bl2nam02on0079.outbound.protection.outlook.com ([104.47.38.79]:48032
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752459AbeCWRrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:47:09 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <chinnikishore369@gmail.com>
To: <srinivas.kandagatla@linaro.org>, <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Nava kishore Manne <navam@xilinx.com>
Subject: [RFC 2/2] nvmem: zynqmp: Added zynqmp nvmem firmware driver
Date: Sat, 24 Mar 2018 23:16:38 +0530
Message-ID: <20180324174638.12621-2-chinnikishore369@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180324174638.12621-1-chinnikishore369@gmail.com>
References: <20180324174638.12621-1-chinnikishore369@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.920-7.0-31-1
X-imss-scan-details: No--6.920-7.0-31-1;No--6.920-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131663008273835896;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(346002)(2980300002)(199004)(189003)(76176011)(82202002)(87572001)(81156014)(8676002)(8936002)(81166006)(86152003)(50226002)(4326008)(76482006)(1076002)(2876002)(83322999)(51416003)(2906002)(26005)(316002)(48376002)(59450400001)(47776003)(336012)(446003)(61266001)(11346002)(55446002)(426003)(50466002)(73392003)(86362001)(2201001)(36756003)(77096007)(73972006)(105596002)(106466001)(498600001)(305945005)(356003)(9786002)(87792001)(107886003)(5660300001)(110136005)(16586007)(63266004)(6666003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2536;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT042;1:B9PZO2wPltWUJHVTLbTQbpNnnmpwWrnqymkCXtfDcvzeroWE1GBwOREM+e3ElQTzeXottXdvvLbRYcam1Vc46e8LyN7CGNwy7ieSbmdHkkUFOjV1zofQ3W6jzW0+Qond
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5506ddf8-636d-4ad6-f6de-08d590e6189e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY4PR02MB2536;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2536;3:Ct3EJpsEpti9Xgwer6U31GBTV1wNnNqxj1bE/Hl4dZ83bfbph89iOVvH0/SNxmO9f6DcmoZbTPttRDGJGFuMyoeJgQMVJ3yKV5deHuCY0l3jLEftonxwcKwDKVHpnjJBekxGI0SD7drk3oZEHiH2mzymFqoiZ+NKEekK1EQdXpbr19fXRNaw/aYmVYi1WwS+P+pb3Oxgiok7KePqWvfaPOGVvMnYraljopt8LMXxJefg+HghTqLZ9uZSfFevcrvMvyuU/4/kJDUw+5+h1tSME0h85QTpI8Xzt9bhz4cuOl/xxJon95nu7VK8Z88ZSWTFVb1wiCeHDoecDI1NRAz7IwnM++NufkakFCgfy0UCgI4=;25:5iDazfzE0UwAW+ZCdpYLjRDM0/wwh4qPukMWxcYLRE1QADwM+lNc2yh5KAzRIJVMnKNidjuufhGBjeAxkNizOdZWI6qQqok6RFvNHKZn17YbeFyVm+k/2yRjJM8WY5/tjQRta0fEwx91FFN53XyGoaA9xRrAz/y5dDq7MZlgM5NrTBF9/QAE7Rx4Td0fQ6pTmw/ROa0Sx/D7uAYUexDGGCv7fo66IJUq14kZELP7jeJOq7TG6/qs2BCROJO4va4sCYNoK5TJEN2sjpPn++oGGq3VqXNyOx/fFpebPYmHW4JVCifrmHVwlQcLFPBNf3vcjwiAJ+Osqa2ezF9PEg1YYQ==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2536:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2536;31:/v4BSvlSNaMcBpDUeu7tXLJAfkre4j1ulYVH0PVy2qq5lKyHaHz7CwjYFa/XyjGOZZsYJnTz1yKUCVGQuMQimm0FkwOSb1QCRwsH8jQjRuliT7cbHyAI3QUHJDsChNh4tiUzbT0BSdhVr9vh0/+W4jnlYiTzB0RYGmv/8fzJ9eorTzrBqiRMXLsA9+BHLxcPzsADIufYGGSYYFVfYAbAzS+2Uq/XdCScuEB98Z+44h4=;4:IFVEEzxuW4DhO3r64xDNciKIy4fAECu3kEic6Sk4vU1FYxsVH3E3qp0PITsfbjIcePy199ACbMZBHcEf5PH3ZxlSuTca3oyYzlBloHv2vpOE6uclR3HNLqveK487kTKeizohfuRS8EDYkoHa8KFsa6Pi1nEYzIfCFjpXXByO3gUC+DZTK//pSn10KqVaoXxINaG4ImAqL0NxwbK1BXlgnnXz+8jzNdL3aXG2kBBzMEN6qDEkREiYJwYxi1kHCBnBZhnfoxYt7K9TrwrMQkhKxe7EWvC0gqwfgjBw0HIpTZcKbcujF/4OwagyJVmX1sS9
X-Microsoft-Antispam-PRVS: <CY4PR02MB25361608EBADF6544CC65A718DA80@CY4PR02MB2536.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123559100)(20161123563025)(20161123556025)(20161123565025)(201708071742011);SRVR:CY4PR02MB2536;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR02MB2536;
X-Forefront-PRVS: 0620CADDF3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2536;23:Err91fwldpQNfR7nP9DWpbHy8RnoqjJu8VSuTuk42?=
 =?us-ascii?Q?Eo8FcU21+mYyQUx9bHoKBKMUchbGYNEVkB7HgFHa3n9WpXnAWnIlmaRQK/YL?=
 =?us-ascii?Q?rQ87jvPXDyL37Ffrij8hrC0da9W6uOa07BxjVuG1it1EhNWPn8QAYhNVg1zG?=
 =?us-ascii?Q?LI0M5wKSXlFdrGKeyLAHK44vbzUBYBpbY1M0MsxXjUEZQjObMkIGc5WpmXQz?=
 =?us-ascii?Q?4BWCMYlpGWY0QhUdYrBvdPVmQVy9JBQ91R1KAUmlq+ILujb44f31XunC0v9e?=
 =?us-ascii?Q?rZUM3ZNF53+EzL0KlLRQbZhrpINK0j87wtBI/bd1hZf2+mvnIBD5yn+5fB+S?=
 =?us-ascii?Q?SUqCF+r8nWPxakenhxpngcdaDE925yTCeA+hzzKF6XdfKOeNFfwXCPX9HUoB?=
 =?us-ascii?Q?X3yjXU3j2o3vAvsyygUa43zfXjLSy4e+9gSrM2iigdZWxiaY8s7BceSgPXPR?=
 =?us-ascii?Q?7DhJOh8yMddSP8bQlPgTlVmgXtSJMXxLzi2wFUEN9C84XMUQlooVTbKyFIcQ?=
 =?us-ascii?Q?koKrs16nBY2QR2w51muWEtmJrqsDJdMKJujxgUviWQpSWtphD6Mq44+AMhKk?=
 =?us-ascii?Q?LXdD8hMqy+q9dhkh65hKIVaQbdOeCGVVYiDzvD/U0DHucs6BhLjC89DAPPII?=
 =?us-ascii?Q?JVlYbqm4DYn3iVR5FQw0+zmREO/42PXOLa1Zhm9y3Tb983FblfhvXxRADt57?=
 =?us-ascii?Q?DhSh0RmuV2dVvOBsHzIsmbskkY8xVGMAnAO5O+roLLa/sFAgiLnP9CkhCrTe?=
 =?us-ascii?Q?6LjWPD8Da0E5ICny55WDMkWYcVw2OI6ZeiT3Q0FU/Fo+pqn/JduWUKWDR0Y+?=
 =?us-ascii?Q?fJ1mvRXXCGlb6lezKwSt25bV64SNQvcyVyqOJfJdbJMrtJ3w8g1VShVzd1KO?=
 =?us-ascii?Q?CnAa8W9+UPd6MLzyym7QDfyMA1zljGCij6jOdj7iTfwfVUVWsJpoSdi/Lsov?=
 =?us-ascii?Q?AjM4mKH32oRMvnVVlBsghi1cJwgUszFUT585Vs7vJ6DuzccsumynhOrqcPhO?=
 =?us-ascii?Q?O0BlGuPe029QUWGMxg3jRtZ9oIrVbwkGRr8D5ciyLWf87q+Y40XOrJU/6dIU?=
 =?us-ascii?Q?AiFoXiANaYWC0a17rjWs7LvnFUqBJqjACQOmR7bGX9s4qRWNNM10TLHe4u/R?=
 =?us-ascii?Q?hY6t1Hgkn15XIACdr40D3bzVxeQt9zrLFIlJI8J6alTvGHkfUSgi0VQwCl1u?=
 =?us-ascii?Q?9teUMU4h/7WBfD0B59VjBLnH9gUUiBmlbcYqd7+ORnNe7RUieEICPYVqqoE6?=
 =?us-ascii?Q?CxCbVDNGI4Of1ZPDVBWOW9WFXSAfei+GT/8JWbTTvWe7ykwoScGXDY4OnEnG?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: OoDe4zlje7hRhaSTg1QgdPgaPvCa4zmWoKjxFKAvhTEZkQW0XGJqpxwObn3Xc7wj2o+eyymT2BnumOmdMEEtvJQUOD6yKNLwhdrMq8+6WGDJyuCVPi1HpL3OkURYRd9HOZJeOxHIys0Sd3H/SoTdI2qOsSz4EuFRhIK5cnvlSX+AD6TxVYDPSrMvxiGHEFHL
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2536;6:lo4FvqDdXZvwVffjztczha02hsby8iUtcQAJJOiyYfQgvb89jnpTtZ8HFDt/TAtvc5LnmlgXV/oa47AYg82SYEZ6tuP1mj/XnnMOFQJhwArZ4H6my6TQ+Djqc7UO6otAz67uXvAFSx4pZ6NP7FB2W6/cFHxlHuqvgBTCrmmcCGSTbt9lmjXKuNfsD9LQj3RI8EjBpfVyWCT3CmQQStu5/QfmrDWXqndmE8qPm+DUunmi7xwoYJE9wQ6FPciLBDaqRWgU7nwiM1qeECuXNn0tm4lh2/NWGpqvfZgPLZrE3WqC2RKG5+1r9ogpku6aUP1XYgZ7nxd641jpTqzOUhQqODpZzHglJh4e4US7oRopW54=;5:ortOcIVli26usD+ZGyVO1TqT0RznpeWmG+0zOTDEEYEdpNaBkdh+dRKhoFol9ihwLloZTnqZYCt9bNwLvecsZU1NXym6ynAgwM04bYmbgaAaIZEqG7eH7KYXlKpigDPZ/qHTYZ4Rw652cgmfA3NTbBclBivRqLAejN5UCc0jI4A=;24:e8M4Wn2V9Rfn6ZqDLARi3ZkM6nNIjEyOwGOke5n7hj4Uf0NgbIRdPt3n6epb+mdnaEAS4bwCXBSbOgR34fFYeBpYM3aZNj5bB8MSL8uwjms=;7:1O04BewC2gU2LWe6CRRtpdHHqnGnwRquk3F4KJnwTjbp/aJ1PWlCjmNWflbeuuUHVXTZjstZneQCfqagFc5K7N6jCSBUR/AuPR3/vnnkQbnwSb1Ex3osSR8u52jBp424fJhAr5MADhgZhjPSB9uKl0zse0BH2nfaOCU0JqXhewxyfjg8xiemepLlTZdEPCJo2kzPV7ZuUYh3QnB2soxfAPY2i9/QT9jQieiN5NOeGIB/FrqitiQdrTbFY2OComfr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 17:47:07.1023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5506ddf8-636d-4ad6-f6de-08d590e6189e
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2536
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <navam@xilinx.com>

This patch adds zynqmp nvmem firmware driver to access the
SoC revision information from the hardware register.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
 drivers/nvmem/Kconfig        |  9 +++++
 drivers/nvmem/Makefile       |  2 ++
 drivers/nvmem/zynqmp_nvmem.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ff505af064ba..a9349281d05a 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -175,4 +175,13 @@ config NVMEM_SNVS_LPGPR
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-snvs-lpgpr.
 
+config NVMEM_ZYNQMP
+        bool "Xilinx ZYNQMP SoC nvmem firmware support"
+        depends on ARCH_ZYNQMP
+        help
+          This is a driver to access hardware related data like soc revision,
+          IDCODE... etc.
+
+          If sure, say yes. If unsure, say no.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index e54dcfa6565a..932b4cebcb6c 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -37,3 +37,5 @@ obj-$(CONFIG_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
 nvmem_meson_mx_efuse-y		:= meson-mx-efuse.o
 obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
 nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
+obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
+nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
new file mode 100644
index 000000000000..206ec9bd775d
--- /dev/null
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+#define SILICON_REVISION_MASK 0xF
+
+static int zynqmp_nvmem_read(void *context, unsigned int offset,
+					void *val, size_t bytes)
+{
+	int ret;
+	int idcode, version;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_chipid)
+		return -ENXIO;
+
+	ret = eemi_ops->get_chipid(&idcode, &version);
+	if (ret < 0)
+		return ret;
+
+	pr_debug("Read chipid val %x %x\n", idcode, version);
+	*(int *)val = version & SILICON_REVISION_MASK;
+
+	return 0;
+}
+
+static struct nvmem_config econfig = {
+	.name = "zynqmp-nvmem",
+	.owner = THIS_MODULE,
+	.word_size = 1,
+	.size = 1,
+	.read_only = true,
+};
+
+static const struct of_device_id zynqmp_nvmem_match[] = {
+	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
+
+static int zynqmp_nvmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem;
+
+	econfig.dev = &pdev->dev;
+	econfig.reg_read = zynqmp_nvmem_read;
+
+	nvmem = nvmem_register(&econfig);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	platform_set_drvdata(pdev, nvmem);
+
+	return 0;
+}
+
+static int zynqmp_nvmem_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	return nvmem_unregister(nvmem);
+}
+
+static struct platform_driver zynqmp_nvmem_driver = {
+	.probe = zynqmp_nvmem_probe,
+	.remove = zynqmp_nvmem_remove,
+	.driver = {
+		.name = "zynqmp-nvmem",
+		.of_match_table = zynqmp_nvmem_match,
+	},
+};
+
+module_platform_driver(zynqmp_nvmem_driver);
+
+MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("ZynqMP NVMEM driver");
+MODULE_LICENSE("GPL");
-- 
2.16.1
