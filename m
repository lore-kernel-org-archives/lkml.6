Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934340AbeEIKBx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:01:53 -0400
Received: from mail-sn1nam01on0059.outbound.protection.outlook.com ([104.47.32.59]:12544
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934017AbeEIKBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:01:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 2/2] ACPI: APD: Add AMD misc clock handler support
Date: Wed,  9 May 2018 17:59:01 +0800
Message-Id: <1525859941-23654-3-git-send-email-akshu.agrawal@amd.com>
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
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:A9znNR8IDj57hs5hMPgb1WT+gJn9npI2Tye5GoINY2usVrRSNguwqO7ftiJzSGW5xpX7YfBkes/LYK4spfu16QxJRJWQ9SLUFVF6KzO54w7so6FrNV9SyEvgVglfuahewxcRgtjJijgWlvFyUxHzR4c+RReO/wwc63//rK64c0Gk9poYi/G71ZjJBkOobgEC/qsu/Y/NqJD4krsvIbFUcY80cqShJ31w5k48V932SFGhPh25HnCNOcgUUE0kWyT0;25:bNmNq1cP0eoUh/hga/iuHDgHBOOO/VoEyEvgTac5v7wFCkrfSZ6yC0xCA+WF0etlDJ+i+hY+yQ28TlIilCuydSaNI8yv9hES2ryfJi5mLiSR+UoFjfrd6sJObGKfwhha52Q4JkqKotCihsp76uRKYPXWFHfOEfmUHjjJheKqTp5rsOFA3s/p30ganOlDmCOkpfMSEVa9SgZT7TRPdlygqFi1M5raAL260+1wnz4PD23GXWKVJSizMniV1sQ4GSxB1h/T7nUeCI5y16o+Vd4eMKwhaKmGfk7f+C03lLiN5uIYnB7UWfs4UOhdWARGzo1yplxFZZXgZG8Scmp9bgwbXg==;31:bKa4DYz8v8XzdGuc7z71xXxGfBRbka86Q9Zk0oM04xniKiWdoXkgcQ2uuUJo6OOx/h+0/1/GUUgdWHYvvvkOwy+0Plf/8W1w0soZ9jmWZYG7I72vcjXk0fUjmZ57GD1FykF9o0Og+bpBEIrDsiMErn4WEB2RDqYOJumfXB8mfPFZbK2t7xlEKSjce1zj7erfHK7MlOlq2FrNxXZvmkerEZXG2z2UOgZOXEH0KpkCC9s=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:TpKsDuQr4AbwuMjeQxhS6nv2dMPnghiaeFif7pJ0CN4xAtvOSKxQ/HQDglTObhM0R7nENH8P6SrA9gQbC4HjH6nzc8GeyMDiOKrn/fzxYzCRqhpl2zVt7tTVFapweH4yI3utjuW7KJIDHfE0G1NFYptM3JE0pm+sPCLS00ioKPDNJrHEhC1nf/zYUP6BDO1dj5MNiHGAkJ7XGScVwiLxyMlf9zoG6Vr/PBNumagsnGbHI9ioYu1xoISCg3n29XyrFv1y26tC9tR9ZZLbWFcb+RVQ9Nkho9VJdiQVT170lIUusROgnShMXx3ruBaZPGI11cKWN2H15UVAZ0nnt5in1PbaRj0wN9aBhV0tqBg3kZSX27zISZ4KutT1eEzInziuZb4rDRbSYe6i668hbSfBi0Vf5RkuWmeYJ0lvlLm79lnusovGfoFbMhzFZDRa70rpSLf1jhVp8oDxwb+nVxEebbu/yk+xks+HpC0dTG/xOY7IKN2S+rjA3rnztaznWtIE;4:x4qAxZ/bat2zLCzgQSei2ZGfNXHM+r4feTrC/wrWsLtaLLttme/Wl7jWVgtbKO5UTNx88BYGraSqTv2JKuK4FmrWTp735RKixZ3gKvyWFdxVQ2BSYn5bl35+n8qt/H2JJ27VE9pn+JWUBAIfvqcNnVTuZJG8WkA9sz21XsTRyKAuooIL5icstkpxh2ObUwinW9wkAzlIuVow+5Ae6xlV3W73PUJRsVk+2VmtgVfyBVQzSj+rVtZ4F4jHLflJUZ4dmlRllUKNCvHuBuRbJViPSo2zD4lC0CIICiIvZ4Euc0ond7DdsRfzYSSMniDZZFCp8n7+zvL2tu+PTifxl+qgCbnryxpakht/QixsdhH6JmM=
X-Microsoft-Antispam-PRVS: <MW2PR12MB2364EA607159BA8EA90CB72FF8990@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(189003)(199004)(316002)(16526019)(305945005)(7736002)(53936002)(446003)(59450400001)(68736007)(16586007)(25786009)(50226002)(956004)(105586002)(186003)(109986005)(76176011)(2616005)(53416004)(476003)(486006)(26005)(51416003)(386003)(8936002)(8676002)(11346002)(81156014)(44832011)(7696005)(575784001)(3846002)(86362001)(6486002)(52116002)(81166006)(4326008)(478600001)(66066001)(6666003)(36756003)(72206003)(48376002)(1671002)(50466002)(106356001)(97736004)(6116002)(2906002)(47776003)(5660300001)(266003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2364;23:VlDfn2UYMtnNr/lG+F+rIM57kxI2pV+vGj89J6eZw?=
 =?us-ascii?Q?tTL3a6QNpGhOCiCChnVNhMN8TpwSVrsk37vd1ha49aYlch772Rno4GTTmFYr?=
 =?us-ascii?Q?Ss7cgo+EgSNTZ9bKbp4Lug47vmjFKFYjwrZlxS/cIPEuesIlxlG5KO+sCm0e?=
 =?us-ascii?Q?tQnckumwetvqlQGzGWWuEmHu9uYsX6SvMSh4WwaqJC9wcwD6pqqrqTIA6vrj?=
 =?us-ascii?Q?4r40LuxZeK+CkK15Y4r5cHmfuM3zGsCrfVOsHZmWhBPVK38NC6gzfDOsvroQ?=
 =?us-ascii?Q?OE9FRmrpL5JjTTo8Kwwvfx0mtiY91Q5hK76tx7zCG3Zwdcfqdap3jhh0f/tF?=
 =?us-ascii?Q?xhfFmhE0oMFWemyv18E2fDmjYbDvxggnyEjMBy7L+9kwQeZyesYlK8Rqj0nP?=
 =?us-ascii?Q?G1y/K2+sRSOn+AzmwTOWtFC+gDW7TmvHsMlxRe+7yzGXM3Sc43lswppacu2F?=
 =?us-ascii?Q?Wq5tNn5WYQYfvzuXVoJ0LicxETgm7MEH811AAPOX2Tshw787g7Kg5oKB4Rh6?=
 =?us-ascii?Q?LlgBfl3NlkliipiYoySyy5eNJ6/f2X65OFagRH44d6vNrROfwfz8f2f3JzzO?=
 =?us-ascii?Q?vy8ou/gzX0YrGftHc6EiihKwfgNcxE1VLKD0xA9foSzCeURsyZPKy0mtb0Vl?=
 =?us-ascii?Q?u9medUkRWOYVEoQjl5bvPZGxdz6LVdMOGz/M1ZWvqg+npjb2BvRnwIdBKvti?=
 =?us-ascii?Q?EDjYjpzUdoeso2DKqi+lTdXp/3u6V6Q+G+QjbAAilyh7zFdxfm27cP6talVy?=
 =?us-ascii?Q?LCv8JDPabKuMquZgJ9/6QMV4fSPzbztyY9wp0lf7hCqOyAlrEdcBqV7+8UGV?=
 =?us-ascii?Q?arYrHVcSktfMJOOqgMm+ZxY79HIVQTrhx/xZtWN0vYY67JtCzt4iJ3RQWOmo?=
 =?us-ascii?Q?gQaHXiSt6PJlQQwYf9YAOeo+pEeQZ22aaEpwNiZWGN0KIVM1K05y9a5OHkT8?=
 =?us-ascii?Q?JMK5trp0AspgggKv1+I6fq3FMzpjM1EJcg8GtndBQzXMnhWLc+5KQ9scCOTK?=
 =?us-ascii?Q?U4XXBBjYGzNxGv0Ovm9Bl8vAekiW6gyycNww3YKqE0eayLw5+Wye/tn2u11v?=
 =?us-ascii?Q?VEHmw3MM4axMYBd1kA4pJfq2AyjkjH0OwW3Q9cKM191Xqo+WvK1AswQ4JG52?=
 =?us-ascii?Q?MktRNxA6pI/cCc/P7cT78PDf3AFFaZoVC2ufacs7FWcSkTEg+JS/LQav/PAN?=
 =?us-ascii?Q?kwxQVR0R2vbQlPeVqlCD14EjTpXY/+0SMTiHMMjSr5Q4tVjHbMrAO04a+6lJ?=
 =?us-ascii?Q?teR94NwOnuELEMGxASMaNP14Qqf2fDjwwWF/+wB+SmrBrKY0E4EDZYN4DH5e?=
 =?us-ascii?Q?hfwnZPqMMxuKmMSxmepMCgFtlHQvTdKMjcGEs5gZQAq5xDj4/a5g0wHtcUT7?=
 =?us-ascii?Q?rOGa6rIP3H7a6JGT4WmYF5GXuLG7EGM7PFHYrF1Y7lnvpIE?=
X-Microsoft-Antispam-Message-Info: 9NAnk4TPbXeewjWm340CgDO0QDI4DDbs9rjD2xs2+X32rCgsza12PoOwWCiGWpHjqojusTzTEk8lOJKiOjoO1w8FX+xn5+SLvoc1amrwocZ53h6q/ZfKbyqV57f0fZ85Py4uHstvDqV2G9rP0t1JkJ7bxqVTooyuPE2ehCLYuZyH+eyYo51e8LkSeK1V/1Aa
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:72CewBogxa3CUjvMeEwAgvz84j9gqyopRLCF9NajOY5fdQgI3wM8N0PCbke52QAF0SM8BJOJVRPVlxQQSEp3+oopHS23PsloG9JMtHtrBuc1mfqOyrsD5j8eyz5yPIp5gJqYsY7DGruJ3eCC7gsAkqiiOClZ/JfMaUzdT/SAJ4B4fq/oesiOwVCvVRgafmxSSiXgmdqYdVn5JJG2EQijJANcxiD8XUcQZnnzmrW1KCWRFXNkZVawfcpHLJkvydbxuco5HDca6FOKmY9Hha9P08teIPuVKNLA0nqiHQ6Q3cS94Z3OCXtyehuojvNHeVL8TWXTbOQi1qxjpWoK6AJaS7r1y7duha3WfAiTLh6iyntwh5iG+f2bGGziW8N1VBOvzcC1Nj5qCVsDKaLyJ/DPd3mcYom3N1oXJK3/MmqUGE6fldDdlKpy+Wy4nClPWWipDz0AUZOB3GoL50zy6ICubQ==;5:JA9Xn2+A7yIuxaWCk7R7PyUIru2U0ebs+paA2bzIRgOeDRbI1Jc0c5a7AEJT/xHRVQ36ygNOVdLBi+wm8iZqMEnz838+308B6gYW7Pba3GM4LS2LAcOOl0n+Z8SJ2rYJ1FbBgAKktHeLxzieuiy/zGASc4kIM+LVWhp31nwWil4=;24:Ub56H4kFzS6UTFm0GtR9TYstqHxj0KWYG9XtcKvRiOHBcnz6wXEjDH10ig4K+Vf3p4NAWCi9YbTbjzn9wg0rxSxf3Kn9xq4neYPNeNsXWuE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;7:fr+7hk/dmeJVlcdcWMZWO+qpPGkNS0KyWO2uYwTdv6vZkiFZKtiIqhUL3MzilgG5pn8nMpUruvGDjmMvpKQUL4Gbxn0eti5iaODpVNlvjMlBNvsGnH0K+Bs6TuNGS+Dng1rKSvQGhWyZIs/YqAxbydcbmibLglKgy4Mc3na5bGAg6aa5xg6dVRDBwpfXpWPCq29ttXmB9DzAOthF2siiiiq2jEjY3xXOiaY4sZSdPwZU5m5y1nsa6OjGIzoAEY2t;20:uUmIsg4VppA9YRHeleTdqfBNTjwO5WmdRsVksG1B+7+0JrtW7elvkChIZckjCbcIBZI6VIjwO/876LRmXxfQaOQ+Xjb1G73u8mzDfUv/C0ONa5QwSZtjK+BOjCW8696iqPrZDiqAOLo/WbqoQ+0CSx5o+/z9IUL5tA3WReexdZ7HBosOm44H6CQ0u05fSArrq+IuNMYkLYVVdNBSc0YkA2JeSdP4hL2a5LZ1ksj2p21SAO8qrI/BjP4UDtsqZSWT
X-MS-Office365-Filtering-Correlation-Id: 8a2c37d6-b56f-417e-9d8b-08d5b593d768
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 10:01:28.9695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2c37d6-b56f-417e-9d8b-08d5b593d768
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
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
v3: used devm_ioremap and fix coccinelle warning
 drivers/acpi/acpi_apd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index d553b00..2664452 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/platform_data/clk-st.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/clkdev.h>
@@ -72,6 +73,47 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
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
+		return -ENOENT;
+
+	list_for_each_entry(rentry, &resource_list, node) {
+		clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
+					      resource_size(rentry->res));
+		break;
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	clkdev = platform_device_register_data(&adev->dev, "clk-st",
+					       PLATFORM_DEVID_NONE, clk_data,
+					       sizeof(*clk_data));
+	return PTR_ERR_OR_ZERO(clkdev);
+}
+
 static const struct apd_device_desc cz_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
@@ -94,6 +136,10 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 	.fixed_clk_rate = 48000000,
 	.properties = uart_properties,
 };
+
+static const struct apd_device_desc st_misc_desc = {
+	.setup = st_misc_setup,
+};
 #endif
 
 #ifdef CONFIG_ARM64
@@ -179,6 +225,7 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 	{ "AMD0020", APD_ADDR(cz_uart_desc) },
 	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
 	{ "AMD0030", },
+	{ "AMD0040", APD_ADDR(st_misc_desc)},
 #endif
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
-- 
1.9.1
