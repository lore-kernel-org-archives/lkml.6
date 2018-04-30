Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeD3HMJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:12:09 -0400
Received: from mail-bn3nam01on0051.outbound.protection.outlook.com ([104.47.33.51]:48832
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751589AbeD3HMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:12:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ACPI: APD: Add AMD misc clock handler support
Date: Mon, 30 Apr 2018 15:10:05 +0800
Message-Id: <1525072206-17956-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: BMXPR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::15) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2355;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;3:XHxvHDXQFmwwglZftnl+QZGHqARd0kxtLLVAQzIws+4ZHWmxvcBfZ/h900hzNjGq006RAMPzm+ytYZicmBMdfBXTNyUh+qZZKQgX2feca5Km4VAodKdcoxUtXUtJf0OoC8r4NMj4pWOtczwoVO1ft5wPbMhVqI6fBs0NBS9ZngIQpJ+riioBJ5+D0yAsfa4xGOftq6j87YeTNfgL+JEWm89CTPFEY6ShJO628PEwNhbdtfe4KBVFyvk23TjL2yhT;25:GIknbkIFcSztncFwBFhmmAtiePCrq+jI+VMPjjWOA9injU5TjIm+HfPHU12n/GVdOurLPMKqscSKk5euT1dxtJ5sRmnXuz0IXQIukZHjCghfxXp6VP4NzzQ0rRIlHIYsZ123plNFEv84pTRzuhOwITOKJXm9zZC2jTOeP3IggmSa3lK1VvTz9vfHgCmEcjZ85ok75VZgU4TuuSTBC60R/7sT5JSdUFWV27CIsvwu71M86gS4EEkA+5BBfR1Lu9Y+Ytj/f9XUutKKrpV80eKDhdosQogTOfMFUGy7kdSNyPtf/olRS7EEVLI6bGzf/zJO5f78V30ecGqIILDmP79c+Q==;31:Smg8lfk2EJFPkOfmSD0z3i2D4bmLuMfOokAfS00vVQVvBClUXHXBWx3N5gU93/EMeRFW/MHReHyGFMcyvpJqMPYzVVEiARD3vV8u9zDBYF9KFLAJaQK0hpJVNLeWy0+kHZBzhlQy6rsgNP8OVGHs3IPzqatxJ4bFzc1OdVcR8YqivYR+JvHh6BR//4ix00IM7Mr+1dKH/ezLfBK8X60HDnHPEiPcboruCdXmABmBQPM=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:O64jTw3/kZyajYjDVi5x62+GDQuecFfDJGYYsmDth6654tbCDI2HjhIZ56Kt00epL8z+y0RO2EQy7/KJxLVqxC0j9Q3qX7vC5S604XVOUNJM2Dp2fWC0YMc1sB5x4AEOowKn0ZLJIUGe/7aIVz5aomwIftDTudOEoiP0XfNqlM9Gv7Hd4S5R6aiDnMlg3XyKSN3BjXJfvMze1x8Y9GzKevo6B/uXMQOWjKr4kiKBjaIXWAHYRJBLPgyn4M7t9VZzr4m5nv1NxFIWLetCiHiiCbZOoTQyHOdihKmF2DYESFxd24cmzGfqbjN3jNQN746azGpCzS/3qgL08te+Dnl8aW9ww3B0T+vqKhr0xtLSs2b4uz+fx13YfHpHpyQ9UdRHsdDJtGlITR1O8CL3xRoDESZZGb/W/OVeyZ6HkmVRFncBvXDyKnsfm44P+/d1KXSqgCYfOcAB+sz4Fe2wgBj2NrS93wNoAWsQ6OKeorNvzE3ah7XVi0bObxJLqOpQLs5i;4:z2DeErWmXX3ToaYLe3NkW65BmjPsBoIBvLbzK3guOyPVR7Aw/P5ViWz0DZ5hOCxrfqdI4wKJdUk0XotHFOQTlFnMcHmI3UkDI9bmVM3Mg6P7prw0ZDVrBsZ60aWNUEdvPi5yAbJbLfkTPdZyfW7bsWoDH1AfxPxLnogs64KtQ7uoXrMDBzWUTlLgUprcxhhrE8KjqIxKmUyAUahDfvSu0+EWATYqTuSylYY7GdEUTuifRW2iILS6Idnt8VTbVGexdubw/irEDuBNdUuMwyFIgr0miT7q+wFkWOw9Cb+DvtkAvbpuOhNF83wT5PIU0WzMykwFarHrAx06bkpEQCnQuhQsYRf5vU/FUTgmrJ00I5Q=
X-Microsoft-Antispam-PRVS: <BL0PR12MB2355BA7E069750107D942C59F8820@BL0PR12MB2355.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR12MB2355;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2355;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(39380400002)(346002)(396003)(376002)(189003)(199004)(97736004)(8676002)(51416003)(36756003)(59450400001)(8936002)(72206003)(47776003)(50226002)(52116002)(69596002)(53416004)(478600001)(106356001)(105586002)(66066001)(81166006)(81156014)(54906003)(2906002)(48376002)(25786009)(316002)(16586007)(68736007)(6486002)(53936002)(16526019)(7736002)(575784001)(86362001)(1857600001)(44832011)(26005)(2616005)(6506007)(956004)(3846002)(486006)(305945005)(6512007)(476003)(5660300001)(1671002)(6116002)(109986005)(50466002)(186003)(386003)(4326008)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2355;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR12MB2355;23:J3DjOUHW693ruifHvzi3bMfCRTnfWC+lKKhySAuSu?=
 =?us-ascii?Q?OkkfuuL6/n1xkp5q35PVWeWOq92W7R5QCQuNI0o+sRHUmGp3byCrD2+dom6R?=
 =?us-ascii?Q?4aB5nE9D77uojRl7rGMbdh0NxrIG0eoAnWlo0BuQHmwwjW/c4wgY8baufjld?=
 =?us-ascii?Q?Iq1c4M1bW0siHRNBZPEcKqyoDp5cfWt3YIJhWX4ZkDgPlv8ePBRj6KWumUCB?=
 =?us-ascii?Q?5W2W6FrlaUd2mv6Jp123LgisG0mniLalarQfrzD+s7jm1i0Mhr1C6emo+d4Z?=
 =?us-ascii?Q?+dkvGc7TUYLt+an2oe6LVQsitIteYRHae+pPALVYCjOrlT+zBbBK4pxCmG9Z?=
 =?us-ascii?Q?ekaH1XO1aZyuWLSNMOZD5Ga2pue86vLhK2fLe5TLdtml1+nsUEKZldX5PBrM?=
 =?us-ascii?Q?heNNjWtxeCHKVs7qYUxzrb+1FPPVO6haUfKiUlc/hPPpijjyR/V1g+nvor4D?=
 =?us-ascii?Q?WZr6IAAxhrZpYYeQ7FLEIHrS9/wC3CuiRZdQPn4thNy7IAf2JSPyPwrDXIDL?=
 =?us-ascii?Q?LchX1Qbnw6nD+KMoFdjNHTZtMGozPKS4A8VYMR2bdZkHsU1aiVHCvx5mCA3c?=
 =?us-ascii?Q?uksMX0qBOcvj1KBqCTsd9XGwcdJffQPVcpS4CPqkWbmF89MjliFisqlyl+da?=
 =?us-ascii?Q?GhOAKStCKrV4FVn59r1dazuewPXMFfCdTkcCqNMO15T5hb//2puzKVSgU5il?=
 =?us-ascii?Q?hQxe8uz79HvkgNWZTCY57gr4NtvcCxOWGgAVXFeIoMWqeYFbZNzWUZoRya81?=
 =?us-ascii?Q?DsSREJr3V6DlOo6AFwe2RE01tVuDeB7udoe3XAXuKkTaTpgZvalNAg+XMtVJ?=
 =?us-ascii?Q?NSFeyh35xuRX296IQi7l5UBgKMKwtFN0uOSVgxtbSljp9dXWsXYeawMZVQGc?=
 =?us-ascii?Q?eRt5gYZ69Avm8+dycpjMcZi4mzDTVy+ZZ5TP5ndZiBAkvTO1gmiKVcoI3XPz?=
 =?us-ascii?Q?+ToDS9NAtgaZBLeGslkHUXefTGIVlRfpWY3LDD+IZ839gryHADgQmoB5wB/S?=
 =?us-ascii?Q?qMyXETnfvqEmU6B7pAk9ugiWaqIgCPw9SBQ2uzedjc+jaQCMu327kPF6cF7E?=
 =?us-ascii?Q?IT+Oy/NsUYFRbLejVXMkyIQPtwoS/p0iIH0KJozc0DGd5TkB4L1USaFE/Rlk?=
 =?us-ascii?Q?SxtHjofyXV0PGpWVRMwO6gPsYWhXejYCRZibZRB4QlRS6rlhjd0EcBM1FYC1?=
 =?us-ascii?Q?mK9EfUdnn+gJqc/QE09SzRvdWOfgpjCOS6PbYNpzOWFr2W9SWup6P8DnEiOO?=
 =?us-ascii?Q?JKvJOkTSqsJvgNNQdO3dSx2Mv8xUmFXrPKR12rS7DmLAb62bOSZwUkH5V7lb?=
 =?us-ascii?Q?K55boyeuc49s7igJJzM8SY=3D?=
X-Microsoft-Antispam-Message-Info: BrxJtX7oRCIr/m2HoLghWxhWobj1WrAFgwSIrFs4eFFg4953x12v9uMaIXzYjMadUVOYMD06s1JHt/eepwgO88C9w7KXFycduZtxj3ck+2vDCSzjNCFBKa24vJS3mttJWmKJZzJYllJ2MvzzovzWSvrTQAisGnlGcBiQeVt967f2FusuIpN1PfrdtHkdxjhr
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;6:0vpi9HA64innFOl8FQN5c0n5FgqXpQOrfWgg8nnlHRn1V9w+IlFNesjagDzyX+qNizNn+7Vr0QxFAId6LsREf8ZU6zloWSEnuTIA3rPAMgtu+91yXGTz20+mCeeHM/R1FmnRsf9BFgbnd5XYjt2GnWJcnJ3uqOleb3l1j0mkq97N729+nm6C4RCyB74ztbeqtAMNne11sh42JhBssnB+VUdfV/WM8/0TOFrUt9BOqUAVa+nUajYGwUQ5lX3NnhTMWJTba0ZpRSZHxXAdB1+8Mh7akAwEs4KM2lQI53+6JGXAhaK7q4hHORhDf4Ps2hRvi4sB+R62QVoBCXXla4/aSDUKt4nEecrRW6ThhozcmTPBfGSur1s8WC5YUTG9lUzITlZ9sPUSoM9bDUSzCl0CY+yT7ebxGHbKs0PuFy9kJ3T9qEYgwYFV/1owTlJyjr+K9MaO0pjDl0yBy5ZF045m1g==;5:a2DCIat65syNZRc5hkBr9mUFvw/LaWxkeOeiwEMaad2bt6V4N+ZPtD5LVhTkJ0HTLPYwUAkf4u79ui5aNXREhmola/+9YJY+8GOdem/b0YYts9dWzTdljKWkAfe1eCN4YYtW2oidMx6obTAlNgjkvIrIpzX5GqahXCPB/WUDMWY=;24:HNyp+PH+fYo4cUzfc8DZi5XtarlvgfRnCHqMcSW+tdCnONAQUlA/BKkcNNxIdusL+BtqazScgySr0JOnckqbtckPdxKjLwox5+4fBxMaiEo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;7:W+o/XcmE5oWOsgt43cKTg0nPjKDiNcAuld+l//Y0nkAqBAMVmnhSaxJTNVLaNA1b7ZDmj1UNjD+5Unr2QNcZerM4yPlwEYW9bn0DEQPg5Z8tT79CGQLYhtkoFeX1+ZgcEjoDug+S/p8DjgOYe0mOKdZjeqCUEq05FvVhhyp6R98hWXpZNk62gQMuUPeKYEvjAFU+FfTdXu0GTCEdnyjX/ASjIWCyJCBdr5SDhOoiBFyuGc+rBhpCMdCtzLYr9p7l;20:KH9jSIqUH7Yjzx9p7juu+GMxdZlQGxYRVuHGuq57E2lRHNsbiKPhnytZsbwooODF7c+DOeqq0WfRlcuxeeqB7iI9S6BM/+2J4uHpORuu8eutDmW5L0lkBf8cWEJJcY0MPDCVsLrb0MQb/Dg+ZDb+BcY7rN9Y1Iw4qRjbhEohRSEc8rw9wfvWrqiHEGsyn4HgKWWqQptHE3V/9CGp/w8ZWjaKrv/J7sw0wI30gjeTiqhXsrzIQOFQMKB3oNzSGtPW
X-MS-Office365-Filtering-Correlation-Id: 0d493ffc-fdfe-4f21-362e-08d5ae69acb7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 07:12:01.4967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d493ffc-fdfe-4f21-362e-08d5ae69acb7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SoC exposes clock for general purpose use. The clock registration
is done in clk-st driver. The MMIO mapping are passed on to the
clock driver for accessing the registers.
The misc clock handler will create MMIO mappings to access the
clock registers and enable the clock driver to expose the clock
for use of drivers which will connect to it.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 drivers/acpi/acpi_apd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index d553b00..6328031 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/platform_data/clk-st.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/clkdev.h>
@@ -72,6 +73,54 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 }
 
 #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
+
+static int misc_check_res(struct acpi_resource *ares, void *data)
+{
+	struct resource res;
+
+	return !acpi_dev_resource_memory(ares, &res);
+}
+
+static int st_misc_setup(struct apd_private_data *pdata)
+{
+	struct acpi_device *adev = pdata->adev;
+	struct platform_device *clkdev;
+	struct st_clk_data *clk_data;
+	struct resource_entry *rentry;
+	struct list_head resource_list;
+	int ret;
+
+	clk_data = devm_kzalloc(&adev->dev, sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list, misc_check_res,
+				     NULL);
+	if (ret < 0) {
+		devm_kfree(&adev->dev, clk_data);
+		return -ENOMEM;
+	}
+
+	list_for_each_entry(rentry, &resource_list, node) {
+		clk_data->base = ioremap(rentry->res->start,
+					 resource_size(rentry->res));
+		break;
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	clkdev = platform_device_register_data(&adev->dev, "clk-st",
+					       PLATFORM_DEVID_NONE, clk_data,
+					       sizeof(*clk_data));
+	if (IS_ERR(clkdev)) {
+		kfree(clk_data);
+		return PTR_ERR(clkdev);
+	}
+
+	return 0;
+}
+
 static const struct apd_device_desc cz_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
@@ -94,6 +143,10 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 	.fixed_clk_rate = 48000000,
 	.properties = uart_properties,
 };
+
+static const struct apd_device_desc st_misc_desc = {
+	.setup = st_misc_setup,
+};
 #endif
 
 #ifdef CONFIG_ARM64
@@ -179,6 +232,7 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 	{ "AMD0020", APD_ADDR(cz_uart_desc) },
 	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
 	{ "AMD0030", },
+	{ "AMD0040", APD_ADDR(st_misc_desc)},
 #endif
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
-- 
1.9.1
