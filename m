Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeEBUyn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:54:43 -0400
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:32384
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750970AbeEBUyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:54:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 1/2] Add DOWNLOAD_FIRMWARE SEV command
Date: Wed,  2 May 2018 15:54:08 -0500
Message-Id: <a5a123a10172efc267d6d018094f643d373f3bb4.1525290220.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR2201CA0073.namprd22.prod.outlook.com
 (2603:10b6:301:5e::26) To DM5PR12MB1370.namprd12.prod.outlook.com
 (2603:10b6:3:76::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1370;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;3:refPqx+D0BAg9FKanypaENx2zXee3eKbpQdxViprnyXphXi9e83fxJVgpXsfkTGGvhJa/kRMQgbczwrhvArqRQIxwbREv3skAMYx/KBIJIuassUssvl5YdBZcqlS6HhQq/n/MSS2RuQuSzX+d3QttYW/5dJkSzWqqZ69n5gzBbipyBNDcTuKjWdI1t2RH7flAiUc6zcTYKwwFP/Cg8B9Vh0KXARwb7cAdMIEZMobyh54ATqS36IjVkU3LtsfMDVA;25:CatHOHOIB7DgQU3tWXYhvr2KRxthNScKHlupnsYDkc1iw/A1sMLm3UnSAGfWnOhx885c9rQRrdGe6byjbhHtnKgM8SgJHoiiE/tW6n99FSMhRQs9OFFb/V7SN4UjE9w/tSlpORRHVux1ni2ObKibUTIAFTHU81tl7RWTV3arjwSdoksIoCqCkxi5ck8ri7Es8puDXhVK1xDNZ2l410egGX+6HL3DM0HZ2hfj10p+/gMiIy/XKTVbvCIBcUmMlHXDvHSzyuxIaSPfwrqf1NicYVR7RZnHezh4+oR+lGweXITpDA4P8af/NkGrEdeMcNvKHnRvrpfgl53QOpHoag9JgA==;31:kNxeh03oGGgbsUUtKRRJzapCilKflkd9YTlEW0Pztrvq0M6rS/9FJpol0Xsc2UYdWvopCN6TZAuheJooOloDFqBOL/ByXxB2ZBtjjhY6Z4AxeMI1bNJO85WzRORBOzm4msUS9bG/zaK73Ehz3UhbFb/v8h9fl+2bc79sUWs/vkTPeVwxv27p+woB+rmHnCAM5/mEAVej9Vl7/ZgsHFzwSepmaAbQW1lo1viK1PrXsKk=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;20:CBDVpa6iSJdS7A5SqtEmistztd8o+JmVAMoWxhmTjfhc7JoBnMoXwCiRkDwhpMPKT4feciZjF0QWb763VPpMLzLZiwc6hIQegzbIX8K9I5ADlNvuAVhqhZGKZXxouHrrznJq297atp/o3qMhykc0wE4NgF5wKvH8EMfnfQOrxS93h/7YwPzB1jMwcdGjLYYVdt32u5mqkCVsqXpkHtJRFS82d/twyDgAwMBaeYPWep4qkw2PTcupW6qKdj3TyPfzSeh8gi454Mb6mW/VMFmdMBQwbPPN1DHpF/1MJEXjgCdph8i49HLpoczYJmj63M2kJYMawt1zGRP4YhfZFwrqjTn6a7fUgG3yRz2R1YhVfRb1AZJrvrhMgSEAN1XhlW2usmYI3k9uBDbclzs9hCireCwTudB+1aerIZjtzfkgrrHU9nhdRVxNvjAcujX20B8NxGuYlLi7/1YWRKfaDC0lqzeYW7/kWm+tKy93dSULQ+iFmnFqoUog93meG8PxkCXq;4:4RkmhR2/fGlZol7yLqw5jQW5bF38BmeEzU35VmPZG+Ef+F6yAuQiYTMi+MqPJY/w5oeBTB48sJ4CDRhsX4Nhn88I+D7edZ/496JKIA73PhE1m2Z+YouVJCS9B0h6XAlTodaLMADGA0LuZ6qoejQfrVbs7ii2OUsz2lmW2iXaY6+E80KScTbabvNFWwjEbDIgtCyy9htTbHJC2cpfJy0ibLXkUNJ/6j04NxHGBnl+aNh6q2NsDhceCci1Nn+rPNqGaMuU8tghioCkt4tgzGmKrLEROgQ9WZ7BUYEb90DijaO0OIuBzGNXeTfCUPT9ZZI1
X-Microsoft-Antispam-PRVS: <DM5PR12MB137030CB220575A603E398E7E7800@DM5PR12MB1370.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1370;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1370;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(25786009)(72206003)(966005)(6666003)(5660300001)(575784001)(50226002)(6486002)(50466002)(47776003)(36756003)(66066001)(6116002)(48376002)(97736004)(3846002)(6306002)(68736007)(53936002)(4326008)(478600001)(81166006)(81156014)(16586007)(16526019)(26005)(8676002)(386003)(86362001)(52116002)(59450400001)(305945005)(118296001)(476003)(186003)(105586002)(2906002)(7696005)(8936002)(956004)(316002)(2616005)(106356001)(53416004)(486006)(51416003)(54906003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1370;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1370;23:9AMKocfkhCRL1UIYyCqLGCo2yhfz9sLh1jxeThayv?=
 =?us-ascii?Q?WPbnN+9ZPJu0LRczfglYSYaOLfNKbGE4Muwk+dvj6nHFYFU8QitiTkxELbSD?=
 =?us-ascii?Q?LkUVJEyKlprqiY1gkyA4Y3xYP53vIDT9CuToIeleSDY9ofoFUCOhUHFt4EGv?=
 =?us-ascii?Q?95CfEDJwyh8gyal9yp0AC5FfGhqmHFWT5q7BqxQsZbElf78GDpzHw8NCFME0?=
 =?us-ascii?Q?s21rACh1QqCjUgc519z+vbkbbQUgpT/02JJblLnxfY9P/8uw8OGCRkR2F56b?=
 =?us-ascii?Q?FoyB9gYJlDjQI7RP5LV4QJ8tin9KHRemNg0fbVnvPeQgBmpYqh5OR2YEsYme?=
 =?us-ascii?Q?H1ggfbH2zkblsvqQODjHtUUzyq9xMPF6bOdvjK8oduKLtVOWitbqp30c4VM6?=
 =?us-ascii?Q?cK8Oo8TUuIxxjev6baSJxPOy40T4MCv6YlhGmZGZTld/Bd90i/4BOlA4Vabc?=
 =?us-ascii?Q?Dd0WojXhKtH4vXlcuAOx/rePZ9/dyzRkMRrrCPstHWrJlVpZoxo5B9786Gl0?=
 =?us-ascii?Q?lMQnLWu6kbRc9eqkaX4dUIMJRovkkdSGgQ4h6AB1ZXGD6Y11w8rw41PVp4Ne?=
 =?us-ascii?Q?u5Ysa729dPTgdCITkTAMAcAkvkAMh/1L4RL0laDBWRagnVmgbfgoA/nwQP6i?=
 =?us-ascii?Q?V7is+Fchye/fd3g0bUaqw1uOD6Ii43iX8cqjOe0vkSe7OfgpTL1n6Po7ZplC?=
 =?us-ascii?Q?uUrVamzBTqM6wkm6rtpCRm1kIzkz0BUWEb7Wp6nM+BuvHfU3f2le0BgRT+tw?=
 =?us-ascii?Q?CwhAaUwoOy+wJLyO/cZ87y2KxupDriRGThv6iv+XeONGaN2uHZdLQr3AijSW?=
 =?us-ascii?Q?2meaAEBdF4L1bVK4XlcY4wyw+/U7EqYCt3dP3kmm9DT7GXKUTnNVkyoanI7N?=
 =?us-ascii?Q?msiQ6VbuvpK5uh+x6hG9PTX7K7QZyoNQjibI4tnsra37kldOjR+22+nL1b/1?=
 =?us-ascii?Q?MnqHrF8DNLMpP+PDk/B1AddSaH14REa5N9ZYdWIcfpl2beuu3tVwOkuXQ4c4?=
 =?us-ascii?Q?tFhQYNiT7YAekkZ2DMZUp2o42fikfbtt8Q9DzfgUN++axJSla9piYiJBRXwB?=
 =?us-ascii?Q?nPMH1qIhI7D9jQTrupP2Q47lvY7IrUywLVpkTYt5GoTfaai7Y6b5aPN1jeRy?=
 =?us-ascii?Q?bz2zvDQquKmlFwGHpxS5pyEdIVLzaKks2D19Jr2vmSZrldf7Y3FkwJq9cX/u?=
 =?us-ascii?Q?8SZPEeDOFiJL8nlhHXBuP2rjK7sEiW3Js4jfw5nCvrK+m1/oblWqqWLkRVG8?=
 =?us-ascii?Q?7jdsS14039mKSyFGxU=3D?=
X-Microsoft-Antispam-Message-Info: 64Bizn51mNx6wUIIxZZ4dQgYioRFiMciZLI+KoRPTzJKFtCAsMBiZ+9otAfGqtOQMBirl/+K6+maAT7K8FrKEzFoHv1DoP+PwkV5hLw5d+ITA/GCSO5qVPjEDm95MKiblK0xMNs+BNaikjvSzeKGRas0AHO56qp1k5tRk76/AMnWCmuT94oSqcod3cuzWdY6
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;6:1E8LLmzbJ4pkfwBwGCrMMj1D3wh23QwABQIMF8zKpnxl0v8RiKqpwXer5g3b5Us+9hFw43rg788ikFEgSaVDmTOtDyqfInpEqpulMaQ++ZYQrObX/JJzf9ZtzzyNg+7rvuMsMdZEw7+C7PYBTxXHQIoP1+DeUv0BuZRoLzJDUbiSuZ/Io2H+VAhuhoXQYjFFOJv+71muIJr0azWdctx8y8lImWjxCLyR1ZoExoYPBg5eJk/EmdlUWfeFilez6WO3qJtnNzwJ8X4PWr3F/eKpgIUxznc6aX2FS/4r0PTh0EuywLhOXuVlOI1cDomnLrj8sanx5fXYuwEEuZIUuV65QWSQB5JryJ5tIYAx+nXyfLne0jgJWEQ7P5k0sHlQhCt2sTBwQglxnHOoDNkahbGVNVnTIuernin5lL0DD/dONsyR8La0giaLhWODG5+Os+GYg+iTExbcSN5u/OyJInow0Q==;5:+aIIUizjuiUWyS2kx88qRO7z9t6DSgDHi2F3nOSemRYRYX+dhNaiQFQ4xwvBAL/Alki5Uhelkzd1FHbuaAFU2s8gHbWFFsqodvQwvKGjsTJ3a8cXQg2uhd38dcNgIXtFyepb7lAXmnMNM09x+QmoW140KI4ybKPaFxWw6/ASBBw=;24:y9MVP3mjwdexBrc11/oFcOjHPpp5ly3uTYdy/1TPH6GZBlyc55xH7jaNCjY9UwNxs5mThNIgVKn7Yb0h4ohSgSHiQEDxFJw/wOH2/CoVfl8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;7:XDZp2bP7zqRsPl8SG1EieRLNn0PGV7s9iMob2ewzlgX+D58nHY7bOkfBdATWTzpReZStSw87ajHlJrPLtUv94jnBocyagJG2OMg2O8MdO1ykZaxKBibLces1ILNkIOqhvntVbxwL/3M22gDNXhmZUPFj7nhjuciMIr5bqRpFAU4N7OyjGBBgQvtNKNOENKI4xACowiPfY+DMB99EeXlNAqswbHsQITt4eWdcoByIG0A1MSgwQVj9xt8WHIpfGTbV;20:LgsDQhxe+kh2Jgu7opWNEfeyNRQb+BFtTELnVHuyhe6LZttArQ9eBOzEb4rX9+JJBouz5BfeiPO9YmCWZZYkVWslhdjYYC0N4sE7AcGTF00wMT/LNLvSJwEnaAcCoAjGkTfxdbGNBI/cMN0eeRsSbSEG/GEn279dcgAuc4N4ng/lPZoakMb+Mx3NjWSG7Up5g8nSyshv4kLFfWjDDnpJGLvMLHA0HUaGBjsOd/ai6ufpBIr6c12AIoABPbqdbj+x
X-MS-Office365-Filtering-Correlation-Id: a1951561-5c5f-4b11-6dee-08d5b06ee993
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 20:54:34.1907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1951561-5c5f-4b11-6dee-08d5b06ee993
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DOWNLOAD_FIRMWARE command, added as of SEV API v0.15, allows the OS
to install SEV firmware newer than the currently active SEV firmware.

For the new SEV firmware to be applied it must:
* Pass the validation test performed by the existing firmware.
* Be of the same build or a newer build compared to the existing firmware.

For more information please refer to "Section 5.11 DOWNLOAD_FIRMWARE" of
https://support.amd.com/TechDocs/55766_SEV-KM%20API_Specification.pdf

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 96 +++++++++++++++++++++++++++++++++++++++-----
 drivers/crypto/ccp/psp-dev.h |  4 ++
 include/linux/psp-sev.h      | 12 ++++++
 3 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index d95ec52..1c78a2e 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -22,11 +22,17 @@
 #include <linux/delay.h>
 #include <linux/hw_random.h>
 #include <linux/ccp.h>
+#include <linux/firmware.h>
 
 #include "sp-dev.h"
 #include "psp-dev.h"
 
+#define SEV_VERSION_CHECK(_maj, _min)			\
+		((psp_master->api_major) >= _maj &&	\
+		 (psp_master->api_minor) >= _min)
+
 #define DEVICE_NAME	"sev"
+#define SEV_FW_FILE	"amd-sev.fw"
 
 static DEFINE_MUTEX(sev_cmd_mutex);
 static struct sev_misc_dev *misc_dev;
@@ -112,6 +118,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_RECEIVE_UPDATE_DATA:	return sizeof(struct sev_data_receive_update_data);
 	case SEV_CMD_RECEIVE_UPDATE_VMSA:	return sizeof(struct sev_data_receive_update_vmsa);
 	case SEV_CMD_LAUNCH_UPDATE_SECRET:	return sizeof(struct sev_data_launch_secret);
+	case SEV_CMD_DOWNLOAD_FIRMWARE:		return sizeof(struct sev_data_download_firmware);
 	default:				return 0;
 	}
 
@@ -378,6 +385,77 @@ void *psp_copy_user_blob(u64 __user uaddr, u32 len)
 }
 EXPORT_SYMBOL_GPL(psp_copy_user_blob);
 
+static int get_sev_api_version(void)
+{
+	struct sev_user_data_status *status;
+	int error, ret;
+
+	status = &psp_master->status_cmd_buf;
+	ret = sev_platform_status(status, &error);
+	if (ret) {
+		dev_err(psp_master->dev,
+			"SEV: failed to get status. Error: %#x\n", error);
+		return 1;
+	}
+
+	psp_master->api_major = status->api_major;
+	psp_master->api_minor = status->api_minor;
+	psp_master->build = status->build;
+
+	return 0;
+}
+
+/* Don't fail if SEV FW couldn't be updated. Continue with existing SEV FW */
+static void sev_update_firmware(struct device *dev)
+{
+	struct sev_data_download_firmware *data;
+	const struct firmware *firmware;
+	int ret, error, order;
+	struct page *p;
+	u64 data_size;
+
+	ret = request_firmware(&firmware, SEV_FW_FILE, dev);
+	if (ret < 0)
+		return;
+
+	/*
+	 * SEV FW expects the physical address given to it to be 32
+	 * byte aligned. Memory allocated has structure placed at the
+	 * beginning followed by the firmware being passed to the SEV
+	 * FW. Allocate enough memory for data structure + alignment
+	 * padding + SEV FW.
+	 */
+	data_size = ALIGN(sizeof(struct sev_data_download_firmware), 32);
+
+	order = get_order(firmware->size + data_size);
+	p = alloc_pages(GFP_KERNEL, order);
+	if (!p)
+		goto fw_err;
+
+	/*
+	 * Copy firmware data to a kernel allocated contiguous
+	 * memory region.
+	 */
+	data = page_address(p);
+	memcpy(page_address(p) + data_size, firmware->data, firmware->size);
+
+	data->address = __psp_pa(page_address(p) + data_size);
+	data->len = firmware->size;
+
+	ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);
+	if (ret) {
+		dev_dbg(dev, "Failed to update SEV firmware: %#x\n", error);
+	} else {
+		dev_info(dev, "SEV firmware update successful\n");
+		get_sev_api_version();
+	}
+
+	__free_pages(p, order);
+
+fw_err:
+	release_firmware(firmware);
+}
+
 static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp)
 {
 	struct sev_user_data_pek_cert_import input;
@@ -750,7 +828,6 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
 
 void psp_pci_init(void)
 {
-	struct sev_user_data_status *status;
 	struct sp_device *sp;
 	int error, rc;
 
@@ -760,6 +837,12 @@ void psp_pci_init(void)
 
 	psp_master = sp->psp_data;
 
+	if (get_sev_api_version())
+		goto err;
+
+	if (SEV_VERSION_CHECK(0, 15))
+		sev_update_firmware(psp_master->dev);
+
 	/* Initialize the platform */
 	rc = sev_platform_init(&error);
 	if (rc) {
@@ -767,16 +850,9 @@ void psp_pci_init(void)
 		goto err;
 	}
 
-	/* Display SEV firmware version */
-	status = &psp_master->status_cmd_buf;
-	rc = sev_platform_status(status, &error);
-	if (rc) {
-		dev_err(sp->dev, "SEV: failed to get status error %#x\n", error);
-		goto err;
-	}
+	dev_info(sp->dev, "SEV API:%d.%d build:%d\n", psp_master->api_major,
+		 psp_master->api_minor, psp_master->build);
 
-	dev_info(sp->dev, "SEV API:%d.%d build:%d\n", status->api_major,
-		 status->api_minor, status->build);
 	return;
 
 err:
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index c81f0b1..c7e9098a 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -78,6 +78,10 @@ struct psp_device {
 	struct sev_misc_dev *sev_misc;
 	struct sev_user_data_status status_cmd_buf;
 	struct sev_data_init init_cmd_buf;
+
+	u8 api_major;
+	u8 api_minor;
+	u8 build;
 };
 
 #endif /* __PSP_DEV_H */
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 93addfa..1d24962 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -54,6 +54,7 @@ enum sev_cmd {
 	SEV_CMD_PDH_CERT_EXPORT		= 0x008,
 	SEV_CMD_PDH_GEN			= 0x009,
 	SEV_CMD_DF_FLUSH		= 0x00A,
+	SEV_CMD_DOWNLOAD_FIRMWARE	= 0x00B,
 
 	/* Guest commands */
 	SEV_CMD_DECOMMISSION		= 0x020,
@@ -130,6 +131,17 @@ struct sev_data_pek_cert_import {
 } __packed;
 
 /**
+ * struct sev_data_download_firmware - DOWNLOAD_FIRMWARE command parameters
+ *
+ * @address: physical address of firmware image
+ * @len: len of the firmware image
+ */
+struct sev_data_download_firmware {
+	u64 address;				/* In */
+	u32 len;				/* In */
+} __packed;
+
+/**
  * struct sev_data_pdh_cert_export - PDH_CERT_EXPORT command parameters
  *
  * @pdh_address: PDH certificate address
-- 
2.7.4
