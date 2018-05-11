Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeEKOeT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:34:19 -0400
Received: from mail-dm3nam03on0087.outbound.protection.outlook.com ([104.47.41.87]:64732
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753191AbeEKOeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:34:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v6 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Fri, 11 May 2018 09:34:11 -0500
Message-ID: <152604925157.106201.5299224478351644530.stgit@sosxen2.amd.com>
In-Reply-To: <152604905217.106201.15533883255216330970.stgit@sosxen2.amd.com>
References: <152604905217.106201.15533883255216330970.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN2PR01CA0038.prod.exchangelabs.com (2603:10b6:804:2::48)
 To DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1451;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;3:hWNqP3peOqabVMdAsLGtOSPW7cvdlSnz0u12t31x4eIfvrKkDw/u+7XwB4tkOQP+Lx3vYwDugsyCVavAVQpw64I7yPm7zyxajQAJ8Z+0/TlCVNEbtZNymEZ5Sre5hWq8DGqc+jViA0KYAnSg9cJk+u6Ouj85LaNQVvhMKyKvmdIViNJxjA/GRHNJBsW6m4sv+WJtcbzROCbdFwTRZHJJjQnZ80LDmGSLpcyJQKqWZ7VvH86/K6Sdk3OS6WFjFzTe;25:SYI+SzTw+9b/pp+ZJGqjrT5RiuBuzVpKEagwYnRhflMJLbRFO0LjGh3UbVa8lrjWwrtp4wWr3jjm5qqVx/f/yeGTE6UZVMolSdLX/i7tC5mPWr6fH8vkA1MT8puMw6P2MD0rHh42qIRlO3IxDaVmXLGB+2NvvXswF4YwF+HI7wTMHRUTXi4YWmeAto4pNu144t7FREkV03d+DBMKP4xZuY4Tttel8QKQhdGcpF93avBb9ArtTMzOuG+MQ/HEZiPOBFzcBBqMx3ztjDymnpBp2MwFnuhnuPISUKcSh04Bm5ju/bL+Ee0Q2CF2G2lLgjlj3TVFmka/FTMobl6v4H85qw==;31:Q3iqucoQ8DI+p60iIS3y+pwVN7O6yn1MottidYgo8LfjkQI8idbfA408wjYsyPx4hJk+pJNyqHjDzvJUluv/fQDWr+v6nn54DSKu1TEDLhBbbennHWDomyStVYYJjl5WzsjQuihOgrFUhLGDKUVvHp3fC7cqqUkfj7FR756hbHwslZe+7qzHYzyRQh4uJ6Dp1A/EvrmaXMLgFlvGAivZX70J8fAPMAIfew4Bb9b3Z4c=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;20:6JcMbDDWZ1b7oHcWa5N77b5WxGb3YVU6wj9Zag70HSVb8qql+qRI2Di/vhDGNu5O4Eftezz0HoHH5JSgBjaMVNOoQ8qI9xdu8oIIKltQUjH31TVyg8mTJyyegYCncjQVm8vLuHvu+7QjOCAlJl7jlT19GM1Esb6TRwB9/mcmlg/ueyiMW31GoFEKSdlcBV+G1HssaCrPJRrHqWgJ3I9Q2of0qUsvTImoQXBFH+JCOfVjk/JvpZbXmYmtFqHZjtwUNGmS0i+wdFj4vJ9d55LNKutv/Pj0vdDUkAgh9asEat9qrje5y8N9QNqjrSsVaun3qe2Egkx7++RyLc2x9gNffpBlBX75zLp7xgvwqy6cC4eoZY+YUytBydx4YBpmhqwfZ6Kz2HkD8DqlQppljdoltJc15kRyv59VhaYsvDDwrqOWUQrWeD7ekEHSYzNmour5FYNY3f0MyLv4arGUuzOwoar1xKuIhXmy7V/nY6DJJOJ3lCbJnsJIOhAHsR5GK2jO;4:h4fzJtKTaEJ3ruWWSMeZ0MMsokdzw67HT2Xjdyu+Xcoeqfq2nH+iJhooVU1EzFvLb4upVEZJcdZoYX6kgyRGuDocoYdbzSnzKEfKFqtTS0m9r6RDT5YT1wuTznt0atFORy6a91n3ISJQhdQiA6OsbcFSPgm08SBNW/+n6AwFPxxtVNXL+WoiuK/vGolNMdD/U6aZAvv6Gw6PvhouTDNnZkTlue5L4faCt6iclEwlp9ogOzm2WMLjB/KakaGdDKgJMyvri5+MrHynJgPgteo9sj+CSRsm3tmDJjgtWJ+jMGP2uWdzHe8JBufaQBNUjnfpUzDIWKM2177bnwK0iPNMipCdLQ61wGtXbxpB8OGOpcQ=
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451CCF6778C2F7E72964B74FD9F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB1451;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1451;
X-Forefront-PRVS: 06691A4183
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39380400002)(39860400002)(189003)(199004)(6666003)(86362001)(478600001)(7736002)(53416004)(2351001)(305945005)(2361001)(105586002)(2486003)(76176011)(25786009)(23676004)(106356001)(47776003)(66066001)(53936002)(575784001)(446003)(11346002)(476003)(55016002)(486006)(956004)(5660300001)(6916009)(72206003)(97736004)(4326008)(16526019)(186003)(58126008)(2906002)(26005)(316002)(8936002)(59450400001)(81156014)(7696005)(52116002)(8676002)(81166006)(68736007)(103116003)(6116002)(50466002)(3846002)(386003)(230700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1451;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDUxOzIzOk1XODM3UXN3bFQ1aFMwQTQ0cWdmWEE0TXA0?=
 =?utf-8?B?enYxa2FUUlRmbnJ1dnVyMGtCblo1TzRUWGhIdHJ1WkFVc2p4bjNuQTJGYjRv?=
 =?utf-8?B?aUtud1M5MXU3M1dCRXMzdzVRNFlxaXpjS2F5WFBhc1JlajNocVdiSGZGNnk4?=
 =?utf-8?B?Z2dyazBHcVRUOXUxMzBtL2lzY25oaWtoVTNaQlBWUmtKNm0xWEtaZkx4RjJF?=
 =?utf-8?B?UTJZMjBIdklBMnIrMmM4a1VWWHdmSGM5NXNudEV2NkNJYkNEdW9veHphQXZ4?=
 =?utf-8?B?SHNJemJjOTVEMlRLYXV0b1BwSUJZdnQzVmlkYjMzTUx5emN1TmdXMWx3ZkdL?=
 =?utf-8?B?ajcwMXdzemRrWFlqVWdPYVA1SkFveHFIMXNSOXFlZlVjOVIzZTMyNkFiaEJm?=
 =?utf-8?B?bnYzUys4dzZ0d3FwR3Irdkw0bFA4TEV3VDN1a1F4akpXbmkvT3ZQdlVFK29H?=
 =?utf-8?B?V2hLUUJYY0FHc1NhTVR6T0lPWDFReHliVS91Kzk0cnYvU2MrNEYwTVh6YWZG?=
 =?utf-8?B?R04yYmsrQk5EbXFMTFBLWmIrT3VBV0xiV1p1V0tXWk9lT3NWK29UejBhT0Z1?=
 =?utf-8?B?bk1nMU9yMm1kbkVwZ3FlYW1zd1dQNlNGa2FUTmdkdE12N2l4MFladkYrcWwr?=
 =?utf-8?B?Q2tmWGlGZnR5YWNEN1luMktnZmlybHAzT0ExZnQweUc3RVpld2x4cGhHcmtw?=
 =?utf-8?B?THo4bFc3a20vNU85T2ZQRDFpd2NaTDJyckNwTWtxZWVzd1JGYkFRTCs4a1Fj?=
 =?utf-8?B?dWZ4akZoWnRpYW9yVFVpc3hBM28wdC91MVFFcWJnakN2ZGFlZDd3MXgyc1Za?=
 =?utf-8?B?MFdISDhLRjdlZDBaajM3Nk5ZTkVhSHY0ZUhaY0IvNXY3bUZyNHBHa0JFdzdk?=
 =?utf-8?B?dnByOC9qMmMvSW81czVWREhGQlNQK3V3Z3FWNzZadmd3eUEzOFdaQmpuRjI3?=
 =?utf-8?B?YTZmY0czVWtJMW5URjVlNWc5RVJzVVV3enlUNS9IZWhXVFVUamZMN1B2MVho?=
 =?utf-8?B?aDlQcVdrVlVmaDZnMlhrZXNYUkE1TUhlU0FyRXd1c3hXdVhpdkpJYVY5UDBk?=
 =?utf-8?B?bURTajlUZ3NkYWhnOW82M09OUHM2YXk1b0lDWnBncmh3MXlZN3k2NEZjQzJ0?=
 =?utf-8?B?MVJWQWVQS05aZG5RRHVnQ3UxNE91NS9yTTk2UlFsUnNDY2lnblpLWmplNVB2?=
 =?utf-8?B?TUtQV2NhOVR3RVQzVE9taEo2SkdLYXdENGRnS2JyQmlpQzd6cnlmVGhBbjJW?=
 =?utf-8?B?WkR3N3QvQ3ZoSFgwNkt0M3RLbEc4QVQvZnVkNytwT3hia1ZiVE9yNmV4QWRi?=
 =?utf-8?B?bnd6NzBYem9rVjlLR3g2SWs0QmxNdEJlV25Fd3MzMmg5ZUFoMGxhWTV5SU1K?=
 =?utf-8?B?Ui9nbnF0d3FMQzBlZk0yMzVMVDVaV0ErZ0JZMzJlbEcvT0pDMVBNL1hBMHRz?=
 =?utf-8?B?a0NkbVN1aWp6ZTBYSUZOWllrek94YlV1eXR5bjhTNVU0SXRIT1BzNDFVU0pp?=
 =?utf-8?B?SEpWcElyTDNwY3J4Nk0zODQwMXorczVpNXhWSWdHSWZ2UDRCNjhIVm1MVFR4?=
 =?utf-8?B?VVpvYTZVa28zWnJlU09SRS9rdmk2UjA4a0dtaUJtYU02NEh2RFl4MjNRZHRo?=
 =?utf-8?B?M1NlN2hVQXdhQXhzbnkrMHVVOWgwTG5oM3VWM0lZM3daSlg1Q1ZLWWFKVTBn?=
 =?utf-8?Q?OI5lQdqNtMFEx6NPbCF/uP5cPOtoBukN5lv1+3C?=
X-Microsoft-Antispam-Message-Info: AcWaCj6nqelwbQ6v5//+646o03s6CtYDdhFnGxF797WGK57Aqwl5X/mzoKLESaehVFmIUyluu+HY67UvaFvcw8PrNApELt20mUmZnSFZd8cxEaJq/58cMbq+XivG2xbXfvntoAWuM+Sfd0jjrAaehrZvMSgsMvYwE+eR6yJ5hYOuSgPjV+j8oXijoG5vGyvH
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;6:sOhKxDMfYrk4IFX14TgUa3tPG3f+k8IqKGryyUrCK42oznqyrOWv9goqvsU7vCK4b/bphDWO5GJMEbK/mqVTtAYTHoT5Xw3Q+cCtHwPCq/vFEsu8A02ZOpduooHr3otrmOspxiE7MP1AQwCY/xwYyF4JFjutVWT9mR47JNV0AUAtfqG4abTRFZeJZoi+SpPsT2Rn6xjaT5Ev4pGsQStIZroUrXv66gLdG9UXUatMm2vigDSm9g1R5Ww1gBvIoMpmR+3Y+Zh4TzHT9Z53M0bz0MBSgTVLEH3y3AWl7jCvQFiDkszi/Jdq1zhGK0USxMK/GOrVwBFbtT22FVR057rh0raYoxMepfgmb3zmulkpfPQLxLYL23IADVNwtW9two6D8+FZT7UHzXsjs7txcUHaMDG+cuIyX6RUJDsQreBa17VxBIMcQ6VuMnAwPR8b41CV7rAgx2Jdpr5ccfC3IiHSIQ==;5:Ww/fMDlBz+iHpVTVppSR8iCvUcfEH/wyRvWedLD9U2JQoa323x0fG10FbITv+EPgz7CVk8tHvpHW87ePmQsJmMf8Ydax1BP9aoWkLtbFZnSmS+X2DspIrScQVMXuL0mLX+0MqVfQSXshydTv72+tKBNwpXYIib6zylXNLYpsRXk=;24:Qgr5ggmiGkLm/destBxk6tzHjj5Ini6ioTEHC5RhT4qi+DXL3WxZkNfva29+snfht0oUyEhdpwCIFG7kscussDtpfyR0PEPK7HFefzPrOVI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;7:8nBXtDHy4vsXbYLBljVvywgfO7/rewuM2xhWBj66+s0xPb1B/CRqkNF4gfTaCP0Cn+/wH0/z19SLKbUMvlK0TtxPrg60FrgY/ecfVEQsT/jmuiOhCfD/q3c6jk+q/+BrRFLiYXR+ELZT/KvLbWp2VxkzYVxfSjwGwAGNgFkSXZ3lg0a/Aq34XaGuTyOzXHBISg8skV01qjE9fb4JXDesmbLkl2lOptIAgI/EzVkZ57SbNroeIt6/ZMESLT1/P1KB;20:tBTzES8JJXpSINpR4Ll30k6RDOJnkBxfrdWv93sH3wr16W8pnVzLYgF5d3GuXDqVqDeBmC+zAybA53XEhaElQJ3LtzR0FcvxNiSkmEz0aHRA79R2JDcKhmQ8qosIloULyI0SZMqHB25tfFF0SVB0tzd4LG0QxgScxV647rUcH+HAUdWMEfjVR8v99fsqxe7vnFZm1QjiUt11ZSRQC9CuyZP4jNOkZ1w0OnVPlNPZKTv25yGAZhoYIDCSp0VUZPWo
X-MS-Office365-Filtering-Correlation-Id: bea04374-2edc-4919-b004-08d5b74c455d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 14:34:14.8677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea04374-2edc-4919-b004-08d5b74c455d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide base enablement for using debugfs to expose internal data of an
IOMMU driver. When called, create the /sys/kernel/debug/iommu directory.

Emit a strong warning at boot time to indicate that this feature is
enabled.

This function is called from iommu_init, and creates the initial DebugFS
directory. Drivers may then call iommu_debugfs_new_driver_dir() to
instantiate a device-specific directory to expose internal data.
It will return a pointer to the new dentry structure created in
/sys/kernel/debug/iommu, or NULL in the event of a failure.

Since the IOMMU driver can not be removed from the running system, there
is no need for an "off" function.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig         |   11 ++++++
 drivers/iommu/Makefile        |    1 +
 drivers/iommu/iommu-debugfs.c |   70 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |    2 +
 include/linux/iommu.h         |   10 ++++++
 5 files changed, 94 insertions(+)
 create mode 100644 drivers/iommu/iommu-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..ff511fa8ca7d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEBUGFS
+	bool "Export IOMMU internals in DebugFS"
+	depends on DEBUG_FS
+	default n
+	help
+	  Allows exposure of IOMMU device internals. This option enables
+	  the use of debugfs by IOMMU drivers as required. Devices can,
+	  at initialization time, cause the IOMMU code to create a top-level
+	  debug/iommu directory, and then populate a subdirectory with
+	  entries as required.
+
 config IOMMU_IOVA
 	tristate
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb695854809..74cfbc392862 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
+obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
new file mode 100644
index 000000000000..9df3b44aef55
--- /dev/null
+++ b/drivers/iommu/iommu-debugfs.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU driver
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/debugfs.h>
+
+static struct dentry *iommu_debugfs_dir;
+
+/**
+ * iommu_debugfs_setup - create the top-level iommu directory in debugfs
+ *
+ * Provide base enablement for using debugfs to expose internal data of an
+ * IOMMU driver. When called, this function creates the
+ * /sys/kernel/debug/iommu directory.
+ *
+ * Emit a strong warning at boot time to indicate that this feature is
+ * enabled.
+ *
+ * This function is called from iommu_init; drivers may then call
+ * iommu_debugfs_new_driver_dir() to instantiate a vendor-specific
+ * directory to be used to expose internal data.
+ */
+void iommu_debugfs_setup(void)
+{
+	if (!iommu_debugfs_dir) {
+		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
+		if (iommu_debugfs_dir) {
+			pr_warn("\n");
+			pr_warn("*************************************************************\n");
+			pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("**  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("** This means that this kernel is built to expose internal **\n");
+			pr_warn("** IOMMU data structures, which may compromise security on **\n");
+			pr_warn("** your system.                                            **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("** If you see this message and you are not debugging the   **\n");
+			pr_warn("** kernel, report this immediately to your vendor!         **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
+			pr_warn("*************************************************************\n");
+		}
+	}
+}
+
+/**
+ * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
+ * @vendor: name of the vendor-specific subdirectory to create
+ *
+ * This function is called by an IOMMU driver to create the top-level debugfs
+ * directory for that driver. The return value is the dentry for the requested
+ * vendor directory, or NULL in case of failure.
+ */
+struct dentry *iommu_debugfs_new_driver_dir(char *vendor)
+{
+	struct dentry *d_new;
+
+	d_new = debugfs_create_dir(vendor, iommu_debugfs_dir);
+
+	return d_new;
+}
+EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d2aa23202bb9..350819f1c5e1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1747,6 +1747,8 @@ static int __init iommu_init(void)
 					       NULL, kernel_kobj);
 	BUG_ON(!iommu_group_kset);
 
+	iommu_debugfs_setup();
+
 	return 0;
 }
 core_initcall(iommu_init);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..25018ac0fdab 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -698,4 +698,14 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+void iommu_debugfs_setup(void);
+struct dentry *iommu_debugfs_new_driver_dir(char *vendor);
+#else
+static inline void iommu_debugfs_setup(void) {}
+static inline struct dentry *iommu_debugfs_new_driver_dir(char *vendor) { \
+	return NULL; \
+}
+#endif
+
 #endif /* __LINUX_IOMMU_H */
