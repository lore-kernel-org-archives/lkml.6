Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeEGKQ1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:16:27 -0400
Received: from mail-bl2nam02on0070.outbound.protection.outlook.com ([104.47.38.70]:28592
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751889AbeEGKQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:16:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/2] ACPI: APD: Add AMD misc clock handler support
Date: Mon,  7 May 2018 18:13:33 +0800
Message-Id: <1525688013-9928-3-git-send-email-akshu.agrawal@amd.com>
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
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:qL8kwIQ6EwsdtpJlZxJeE+zQwqk/f+sxd8kDqcfPGcl/A2p9AvO4qYlMAXDk0XTDZ5N1Ryo+M4vOxIprEBT+7wEWASgoPjnGfiOOr4D6x1Ux6Kbj6RLnsImP9oDCS6Ofgn/H7dK5Q8cZBCAD3YXHM61xs7TxXQyTKOwbwgNxBMOyf3S6trPXCFYczogAlxVinyTrb5mIyEALmJIy9ThaBWDK/vCZy6+j51npckV4iLCfQcOIhKUgflmmutyQbyqP;25:YfPX5PpSzkRVitCGf7wcpcLFQZXhHlxl6BIVd7wGsGeQjmQoxF+yO/9egt8tbQ6v910ZtWHjIO1kTBuB11sfjLJHyechg4MAmLxhF8UOngWM7oRllx3lIj4VLLfjH6a/cUN5bKS+dndgU7EOYIQ8pDi2E/C8y6OtbAXlj9fsTpaxKl0LLkHCq31btrb+to4EL7OT1YzNrICFsTekazcj2T3+6wYtKPi2ZZq6o2phsMaC0fDCa5B8gDsY+f90DHYZ75rCdHgaC9/gxFiY3b4Ro6qbe1Nj4hwxbDSQPYN+FoW9MB4P+kkXV4XZbVH226U+whUFE9DWq9MFAudi2dxXBw==;31:QP3u7zsqZiSij7JMGd4I/omi8cAgVjyVmT6PliBbWRo1Lodv6bFqaRze44PJBsqZUe/XbdCVRL9sLqWyAzeEwrdBaDPZBpSQxIEA8pKclJM5Vdt1nfyCdggE6h0G3AfFaibHLWKls57igduWv5ndxWp1DCcwQE9BVqChUUlZuoPGNkr8EMcFjc2ikprUgmePqGsLS0CRmch7DkYkb4WyA6Ci5wbUif5y74+ke8LXePg=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:sF2Ze7FEqn/X7dP/Mfk+RjCZJM1kKtQSULDhTOUZt1vk2KKAohaCYmF5waePZ0s76Te8JJIhiL+CLPbOcBFWhyI5r33tuhtFYJYwwPR+AP40/HaBJ/ID6awQwNzP+hWHCtweZ419zBWQM/F0tvfBL6uf7nqDaIUQT/dUP2bLWM+jHGqUpzYz4JQKUui1VX+bSFflDMwcL//iwFvrhndpvFCKx8aLPA+nn3NXy1i9ER9htwodtqf6qrKy0SPH1nRJ06k2TS1DkNCOxBMrbxLD3Q5XuM8ye6o46BmemFoPE1JdyCcW7JmMyH/91cOhUB+/C7v+mX8GqVzQFFFXRDeminQy8VJVPu+iOfezQ80QnqApqT5G7pKGyw7J12A7DD2yfKMWqr/j2zajMaZDmpu5FMQ0KAnUULMpWZlVAPAMky1doIsGMB44kQPTZl7ez+7igDNbbpu5zXTzLaf3zFPNR2XVWbZm3L03LQmHdDYx/NWiFgUHV2cXp7ARiRjqLou1;4:pUQGEt+fcTJH9tRR5AgCPolbt9R3PQbkH09WNroKxRJA/Ivb8hoN9upjDM3Kap3tBKpPZMsxlE46fxDc01Sjz+YLuKvzgGG+wWBt6a8lKxq4uP7PTV151Kfkp0WgbDHvVumQPTdU+WYi8heYmyqQUPitv+0d6haAR9/Qvpfj46x63KCgCDMbfHXLFIT5TIhGdA8/2/UTtm8xx/7uBtjrHI+7GMMgXKEzXBloP1+GhtDRW1q1TVkeQvBwG3q+7MilfOQyOtx19WALbzYnMG1ELMzW0zG1jUoojAK4JJr1YRSt4t2nZfGP3R0BZFXW7gkFKVTIQX5n/l0YHCSof8OmMQ==
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366A4DDC01AC1AB6107ED05F89B0@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(366004)(376002)(346002)(189003)(199004)(1671002)(50466002)(8676002)(48376002)(66066001)(316002)(81166006)(186003)(81156014)(4326008)(44832011)(6116002)(69596002)(26005)(6486002)(3846002)(6666003)(8936002)(47776003)(305945005)(16586007)(25786009)(478600001)(2906002)(68736007)(50226002)(53936002)(59450400001)(36756003)(7736002)(6512007)(86362001)(105586002)(5660300001)(575784001)(52116002)(51416003)(76176011)(53416004)(476003)(386003)(6506007)(72206003)(16526019)(446003)(106356001)(11346002)(109986005)(2616005)(956004)(486006)(97736004)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2366;23:a9sGmZHWj07mohkKM5CP5WdpXAX220Aomsr22ea+y?=
 =?us-ascii?Q?v1gn9t4qbIOXYg5RXwnQqAMAeSSmVMCtU7hPN+s7yg3W/BuSG55jOpnAPSQi?=
 =?us-ascii?Q?vHY9qMT2gWfan2xt5WkIJ2g1fYumj4T/rXP2Q72VF/ZrgNi2dwNXKXE1sLyH?=
 =?us-ascii?Q?3mtRap4ES2LLlshPwPYBN3zn5QdRTmCeZGP8nsDgatUXchom9pp8EVLad4sA?=
 =?us-ascii?Q?d3JYYF2qsK3yLyx3eikucbn3iVxrS04j2704YYqH7cYazJSi0md8lzHfRUb1?=
 =?us-ascii?Q?8ZgpTa5SkxMVAi8purGvYqdrNWEHsStygtH9QL6/UMziIpF9saOt9PVmWlHB?=
 =?us-ascii?Q?dQa0DpRU9UKPXovalSLLhYHFDiLiyfrmuZHu056MtC7lAQZZpMX2EtAukfs1?=
 =?us-ascii?Q?LlRrLxl5DXqF6uno5shPTkQyIe1i5S1+bwkd7pLVT+f3/XxBpTbabWQvld5D?=
 =?us-ascii?Q?KBb7CU0kaPL9bceT8QJ85TzUkPw2tt//jf100FOXerssYXOtnKxMUdmOACnU?=
 =?us-ascii?Q?e5QRCKxFS8kR/j9gFu/yztYVlJQWJD8HuV5mh0IKYjwVmP04C47qexd5krWw?=
 =?us-ascii?Q?rT3QvKmuIOKDGDXD/ienKoAX8Rc2iCCxNXhLentyg9LWTwqcvY35nWnxVvpl?=
 =?us-ascii?Q?sKxu/Hm+5WhMqiAy2Yu4M51N2gL2tEb/4wWFPTGxKCdWW2HQxpP8Nh8qihQQ?=
 =?us-ascii?Q?OfoJfNJhhJlO8E/wGhy8N3sVnkySkfVU/CZhqNfIFN1thnOdQrIr1Gl6qAAS?=
 =?us-ascii?Q?TECBWflgu2TZnOhibZ35f9KxRX2MmqHw/BfEd3GX1+chWKcss/j1QZ0AlnyN?=
 =?us-ascii?Q?YVT9sF7srqqeCp05ufpM18BNC0SvM7FrEkV45ZTWeoKYu1V0k5NF3boSilHp?=
 =?us-ascii?Q?BTOhgXNXUNWXVccn6GUG7gPVjqVF7HgLHgvK3BKgPmuf0UiHUjKhzwFLuuZL?=
 =?us-ascii?Q?Avzy499vygZUlBUl7jxI6tcoM6TCiYbZTM6XpGcxA329tr+QHXh+R6eFZiuG?=
 =?us-ascii?Q?VgK9c0+GTtisq+UyyyKCmNImSGR2II3NQcbSzw7Upz9fAOVQzTTMiU+sh+IT?=
 =?us-ascii?Q?QEAifmFv25jTdKzmVHsLTIYn2IgsN4F2lQArZXpveKPrDRrknzLjlewN9EqQ?=
 =?us-ascii?Q?PAX8BkE6bldUUo2VXB03PUN60QjDn4/zky5geSStg4CaWuUdPMmtX0/+1pzZ?=
 =?us-ascii?Q?rvkZg8GAbYncaaydhNDVcv3ESWmeBqt74TXFlDKCikjak7Zt6qfZ5iAaeZZM?=
 =?us-ascii?Q?O/NUUm74e+RjO+SQK9ErBIKs7p4VQ0S4bMAMa5IRQ2HZ9M8jwal9SHvKa0RB?=
 =?us-ascii?Q?rrh08wds59SLoA/crtHvOfNqq/p4p/Joh7wXVsM0lib0tKrqbOZ360Ayb1yM?=
 =?us-ascii?Q?/KObA=3D=3D?=
X-Microsoft-Antispam-Message-Info: Zwu56IF3Tm1AsVzS5fSHQdEyoeytUBjOFatqAGOoXVX4bZtPQ1m6OuqOIvuTt/BLVJm3pz0v+mAjaSH8kik8cumTlk32jUbJZ9KQvyIkQRxL5NQzfvPshJKPtn98fU/0SWexpAjtjA+JiYEGtlSb2xah17kMJWtkXXLsHBXFg5Uw2ydrrX+zdpfHmN1hrnie
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:tkGqwBN8MhSjibpBZN6jKMQVLnjiAJFvx0/z0ebpzsYai1JBVuvzMrazhYO/liuM64p0tXAyLpWl7DakVhkzh+W0hJQIkMx3+UCxSwkayFRQFPWlP8nMrmFVAPpUlg/4vkNrbYnmUxB9UNsbJq4vdYmdu4tpF7ag4y0RWl967ZW4/krSvQ49BvX2hBqSUs/nC+WobIyxMgEgcxT1F378DGAJi1OtJzY1d3C8we16NaMKiOAmgDPx6vVQrF8WjSdG2l+tAVJZKVImqm4YD+lUDTTEOX/N1HMI2eqOwv546dC/4yLONIoWwcbsODPAwagrjhQ3zDyFakZrGOgx3xEzte9+YCfoFdDcVnmK0HTSrS9zhYBmMV0YLJnkVfqDDp/BGIT5m7MU9WqTQCHb6P0cSWALRPTEvwL/HtKxyv2DDUcR+K6XLAYk3qGlzLFy1weWeHZwW9cm3akUQPGAvmvkfA==;5:2Lbtz4EVkwOSgaKA5agGdTI+9mRwr/1kajIRocSTN33Ze5kH8ryQTy0W+ayHdB2SrT+D2qs7HylmQkz+SP0af+JqKEeuMo+xXKGptvHRAHEMNzL/1tNcBGzs/p7KxNA8jVkfzuaDFqJyiYMyNnwoareyisH8N2p3zHBUCI7/lg4=;24:sRwHTc8TPakm8y7HjxTfkRzajuaej48uYvj3XLPWA+6XPwRfyvslxTAoKvTu6Zd7bDOeTGwFgID4qH9jzFWwFzLQpg+01r7F91kVkWBX2JI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;7:xo7mqhffEIJ6QCkwSkCv1G2doWrBzhvmr1F8sk+HdrKRbSf1ZKu+bIeGxbg8MNTl/hzbGP1vQYepm37JHyq6jbRwOGNRr0FABIpqenrra59dBN4HgDd8JuFLJXa9oeOHQLf6UM/xZQJI4Gqk0jtu+VNXXNPDJuQnG6DGn2BWXXzmRxcLaCT/cTky1e+AwIL+YHLEruFNmr7vFyi2thAjd/oRrAnKikZnPL7sxl1DPiVAyMrxVNHKVn0WP5oOtbyP;20:ff9c1FboZgZD9aV9f15NaA4VOZ6lWdtrZEjeaWzY1scBzsBlP+GHKeGuI31004DqJncHWO09kukZSGsJDaHYhEtzL10DKoLEWyal1IwM3qoGzPsi1mu2+zf7jNvBuSOUPyP5o4NbH7XoT+/mWp9VaPZ+Vjul8ymE8hymU8oEdCCaxf1QLZwFyMWMHe5RpswA4A06K/QEgkvYWSPDfTaotAzrVSqDTB30iZN6N34aBPgLf7Hej/iBpjssYkcQTw3k
X-MS-Office365-Filtering-Correlation-Id: 50026267-2f1f-49fe-1291-08d5b4038afb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 10:16:01.7019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50026267-2f1f-49fe-1291-08d5b4038afb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
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
v2: Submitted with dependent patch, removed unneeded kfree for devm_kzalloc
 drivers/acpi/acpi_apd.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index d553b00..88b8a3e 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/platform_data/clk-st.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/clkdev.h>
@@ -72,6 +73,50 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
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
+	if (ret < 0)
+		return -ENOMEM;
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
+	if (IS_ERR(clkdev))
+		return PTR_ERR(clkdev);
+
+	return 0;
+}
+
 static const struct apd_device_desc cz_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
@@ -94,6 +139,10 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 	.fixed_clk_rate = 48000000,
 	.properties = uart_properties,
 };
+
+static const struct apd_device_desc st_misc_desc = {
+	.setup = st_misc_setup,
+};
 #endif
 
 #ifdef CONFIG_ARM64
@@ -179,6 +228,7 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 	{ "AMD0020", APD_ADDR(cz_uart_desc) },
 	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
 	{ "AMD0030", },
+	{ "AMD0040", APD_ADDR(st_misc_desc)},
 #endif
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
-- 
1.9.1
