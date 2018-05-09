Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965433AbeEIQSu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:18:50 -0400
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:32352
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965130AbeEIQSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:18:47 -0400
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
Subject: [PATCH RESEND 1/2] Add DOWNLOAD_FIRMWARE SEV command
Date: Wed,  9 May 2018 11:18:27 -0500
Message-Id: <8adf44db473ccda6ca626ecdaa058d524af189b7.1525881878.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:404:121::16) To BN6PR12MB1361.namprd12.prod.outlook.com
 (2603:10b6:404:1e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1361;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1361;3:EMqRiov2U2G1aNr687uvMtvlMvlrA6mwX/CN/mUxd/w6TOZBKPV+9PII2z83O8WZCbuun5csxtG5o/as4IFrDcXi8g//9LCdUSPMeVP/yruH2Pw4nBxFni+Ojg+tob0H0QrfBXkelf0G5Mbx6bYaYiNg2uU9eSeGO79vVn9qvK4ygWyJ4HKDRl/5yLuUOc/bM4BDAKPPolIv1GfT8LtEmyTigiy9xqStUp+cLZECcsHzynn8VcRQA3DiG3Va5I+H;25:48+NpOztMNccfoR4MxOJjJkRz3nIccXuzD1bGhHvkEf1Wy8033iEgvikW33BHYtLg7lS7nz9hKwOjHrJ1Akh2dSr1yDNYIMu4bJl6sTu9uvuT+eI7/pr7OPQNNAUphUC7fH93Y48qOY/nRwANovd+aZgamksG4M8QDhbgA7fo/7un1+KltvmfAtJnxwWcSBMMnpIdpXj0A9i+BxhvY0+cTpI8DXrcH2pU0yd6pJiZyLY8PM29arg+F81LZYASrQwoiJ7r/uvV6Y5V/ZiFkE3OqPhkBQDaBmjFDYmjH5mwTIVZ172uRjHYwFQ6NQwS1vOWWPv3QzK2U9aGKPS4XlEFQ==;31:yNSuD158fJ9RyfUzdoHBwjh9tdGbb90uTtPuuS6/VYzSZxV+LyTb6TKJP688Z7JnSQUj3vAEOG3IWBw6YSIHZvoenlbc21o+9QzzGxzrQ9nx6RrgrEldJzLx9XTDVxOQNj21B2Xd03RQBGTQzDHTQaMvutc7T9MLsJnoz2ULFFUYf4pj9MmMKZZKMjkGfnUa1DJxROeOCVIGAnsUkuvbmb1IA6i9vEMMeGOPRHeMOC8=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1361:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1361;20:oAtH0i+vR4lhsfnnrJstF14PpyxszdjV+psgw/CdR6fYDvzPWG4elqIEJc1gJbpqrVWKZwQqCRCh++zBCW9sOUVhKtIxoLxod/ON8Rnt5XLLVlvSkvDNf6/VTWz0u0PHeEiCjVCwO956OnFioF0eAoOJOr27h3D9PlSv+kQbU+IjVRgg0gkvA8NIyJCIrdXQGs8MlOhV3EKTJ2+D4iU9wD3DtBIhS/KmhrNvkk1aCjnK14Jd82bQk4VwY9QgCJsQnI1WpU1HvcFVlk2wICl0zNSZhETb6t9W34nG890wTG5EqYOQ4VEfZPmVtEEzKykrlANn1yO2nR15veFEOCCGQs8Z95Tn9G0h1/nIIuOwMFB2bMtC+512neQWaEw7jv0tybmnTt6c+iBgrjF7cNTxcSWyeSO/kiZFMJl6SBKR0rW39RWuOtURB3YmxJC+Vq8xz5I1Kot9TVIpXT3Ib1knbodmQ9ruwi4mf6bFK/awizqThkqeVDGZxCxr+Mre+ZI8;4:gqY6qrx1DBlA2ILItvjEYLr3CmfNN66v+NJF58Own90joGSn6f39salyWG58Qs9rA6tWJutL/ipKqtufPXfkUYznyhvlC8Y9T0G3mVuHFgFZ/3MKD6iteCYenACeuAKeudwKkBXeYc1MJDiZvSzrepamPipUIctVIO3yLk0GZYqFJTHQUw+Tkof+mYUFl5f6KPsASy2sA3IWFTU2mdQHawsuOjmDwNlotA6jVppDP4pDn5W7ik2WxokEHVuou0LNY6m6ODAWhN/MVafLThOhHMRsZqB81EuG5ybKWwS4MEQWwtdN42wCyj+K4E/EO92v
X-Microsoft-Antispam-PRVS: <BN6PR12MB1361DD8CA1D47C5641363316E7990@BN6PR12MB1361.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1361;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1361;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(39380400002)(199004)(189003)(72206003)(52116002)(956004)(50466002)(59450400001)(5660300001)(305945005)(25786009)(6486002)(97736004)(53416004)(48376002)(386003)(6666003)(105586002)(51416003)(7696005)(106356001)(16586007)(3846002)(478600001)(6306002)(966005)(8676002)(316002)(81166006)(68736007)(81156014)(53936002)(16526019)(6116002)(47776003)(50226002)(66066001)(8936002)(54906003)(86362001)(486006)(36756003)(575784001)(186003)(2906002)(26005)(118296001)(4326008)(7736002)(2616005)(476003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1361;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1361;23:zlDOsqPYThVVePHl5As0N6Y+GjDXh60+2/Hlyj/uv?=
 =?us-ascii?Q?iBClyBRD1Boaryt5bg6jBI9vQ3fA+5clv1FgJRkknyzRDde7Pb6Nlpq30HzB?=
 =?us-ascii?Q?zXz8FGbiCIRMtWYs4ZppuN45nf1QY+lZcqhWxxcTglYA0saXVx0GygK7rz03?=
 =?us-ascii?Q?s7c4bx4JqsgMF20fVgYASddzEmBfNhuedp3jWGfw1oSaajYn7IMuy+xJ4qY8?=
 =?us-ascii?Q?k23GeRIar7qv47ZGfTwappPh6SBNt36NuBaw5Dt2txpzaNonEIHKqNlYk3Gi?=
 =?us-ascii?Q?tQO1oQNy4487QmJUkcVVd2EgzYKO9M4r2RhNlOAVnGWUYNUP6PqIxwfi/Xq1?=
 =?us-ascii?Q?gSmItvIFec6a0rwc2Xji9lBoHSCDfsbcLBE5o5S3ZIi3phZPI/0BpsgvSFId?=
 =?us-ascii?Q?8Vy84qour6sCldrgUfzSawKmEF9Uquiws+S7JpbS6vLUfs9hdpVNbg6w1eVB?=
 =?us-ascii?Q?Q2422qlbZPcdfyIALJ8idrE2Ysvc7di70XTA88j5V3HqppvVrKNmURbt6qA6?=
 =?us-ascii?Q?qVw1o1myfUJ1M+hiWJoONIwAKDTSvczqmZR+L+5vZlqM3eqGCj2Pr091IcJa?=
 =?us-ascii?Q?5L70meSM2TWuA9kuE8WdUmH8Yx2tVIOadY2T06tE/LXYZsSCZ2wXSAlhJLNL?=
 =?us-ascii?Q?gZ3VLzJGJVLZta+eSwdWMD8ORAOLqDtDUl4FaDz1NWyOb3t4svW0+iun3TM/?=
 =?us-ascii?Q?bndhw6Rf4tOgR9D/kIpHeMTogj99jq+IoCZY0BwGfj/2iHg8Lx/crW218aB0?=
 =?us-ascii?Q?VNF59NnehnIiXumw0Jr/1uCj/UFnBm38XPiI2NU0Ekol+vGZA1nP7n7I1U4E?=
 =?us-ascii?Q?t28tFTUt7URhQASXIG8aNWpGowXiaX3WoAGe+o4uB4kOgIjOszVBLMXYybqI?=
 =?us-ascii?Q?yqOrbZU1kYwnU7ItCRb+D1/92oL/EZzX9DiC7TjLQgRZfEoIEnjKx+4FVO5o?=
 =?us-ascii?Q?j8fsewvbotl2SjJL13rtV9Sz+gnOzb3U8D8A7rkPK/1N2yetxk0aff3VoN5n?=
 =?us-ascii?Q?yM8ReGIW6+Z/buaz1Z6ABLz9DhOyWXSdyPtuU02JGwQ0Kna/JBh5qng0gX/9?=
 =?us-ascii?Q?8n4YRFw63pqueGcmPNr9rWIGvimpziLLnbOMnzAe2f1xJw4S2pBlazbyPMR5?=
 =?us-ascii?Q?0mudagc/I7Z24wbv5Evv3j0VNgIlPduIwoygy2a/ak44HpOmtwyc6DXGWuK9?=
 =?us-ascii?Q?iIaCeVDsn7sO1rW8KptIZ0P2xcxDs0r9Ib9SPUuAbLcHnpP08k+wlTmNYh2d?=
 =?us-ascii?Q?eHuVmGofG0g6x6h2Fu6IZKd6dhjDhh0yRnW+fsk?=
X-Microsoft-Antispam-Message-Info: DqX6RuQfFEaZpRrl5p6e0WsMz2zlGniuuiJouPgnK/+MeFzBs0IHlBsG/mWnTFL/7NFUz6xqK5lnHYIN2XFcDca6rW/bdMiSPuCOXhD7HuflXQX84FbKrIBhwHW8kH8TFarvuXYliWL+nJ3f+WJc9rbYLF4BJdugyx8GpL9lVQ9optpUaikO/WbacCiNwRp/
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1361;6:mGm8dEiblu6KP82irCUHHJsyWxo8sg9nfav1FBrqyVPbI0H7lY8v00pzTN1AMMrPACFdwB0A7MgfYfma8xhcfRRDsRdRFiH+4CyBaAiNA3lIf9E0v8vLGaWvB5gV5FarsnvEAQwCyqg41F2/RL52zDcrzXAMFhf08u6LylTSSnd1uGth6fS8wjCl5nxUeZ5bqdl3ZIN2VvAZdmNxhZP23f3fQxDkEsa1OBDAqLe5t2mhrNA+v4nd/fbProR7ODH0Idj/g9ZexyaYbjIuSiQmxpB040rFyo5j7oR2LBkh+7e8U0i84LQTkJdnW2SW8QF/gGVTuBy9e/AgTXBuD5A8hP0rh/WeISIIdtpEzk+yK6jf7PCtZvA7kJUxtrEoJOaTXGE5rPz5u7ELn6495Q7yRonN8eYLKrHxAntlog99NmkJvS9LRtejfnGSxGgQVjt+rZFiv2FyOcrJrNoSPVi9Yg==;5:bNkza90kUbBUjkLqf5kgLO+D8HfHrGHIbX5EwG/rqbdHmM5h0EL+ctmwo41IC++rRFtf/XZIr5CtNYlsB/5B1OjxGdK8fBlnh1zYmQQpZVc0m1BPeOuXuO+t9ieFidbU43+9ymcxl9nyCtypnsJBiCy1+c29Msmc+7x5rzH1Xeo=;24:52klhqPda89YfAGeTaZoTCD9gihAo0Gpgerb20tR0sakPce4dE/9/BZRjbOFgmRoWVupORN5VdbTcyHB+P+qBsP4gPeoG65gseIjQVyvsEI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1361;7:oF+6TDc7xQUhPUEFvD+0tvQb7kyicG6w4RS/Ja/7IYP3G66vjoqIFNn8zg1JrLz3KesvHoujho+i32bnVMw3eUrazmDY+nrOlUbnOiY0Tiwaxq6RxOvusK1PrXu21+lU686FdPLSboIDlV9wjUbZu4xuPq6Dp1yZO/HHIRCysTewcNGqJhqfuLgnMJh9obdjUu1zKQwt84ptt6t3YgaTZUSpdEqHB+6zfI6BXIPKhfEVQ14DOKkMq4WScQ/jYFER;20:pU5jGUzqSEMajO1dDWB6gXwuem8+RplVoZatEqMKoNC0Q5CbMSb/HaXxaBuCJpP/ELbZ0BBd0vYkgJAqLZjcUEpK3QFzp7uj2Bl8iHumyMUlp5ZxM8AjvqGUshB/FBSEP9j4/8AuZdCJVgo+E6+xe6nCR0javKqIhZDgWK9FJRz6cLOB7n2Bm/CN1ZA5fLDwoTe+gx8YCLsLlUyW+/aihzgxpUzZ7/JIeSGeBcKCO5kq83WzgevlXci8xqbr2zch
X-MS-Office365-Filtering-Correlation-Id: 33dc3d1e-7c6f-479c-4b98-08d5b5c889e6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 16:18:44.8726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dc3d1e-7c6f-479c-4b98-08d5b5c889e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1361
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
