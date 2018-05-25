Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968369AbeEYUY0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:24:26 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:55968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968071AbeEYUX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:23:57 -0400
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
Subject: [PATCHv2 1/2] crypto: ccp: Add DOWNLOAD_FIRMWARE SEV command
Date: Fri, 25 May 2018 15:23:29 -0500
Message-Id: <79f471aa1d0720e3ed5c60878122a3fe25dcc801.1527274270.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
References: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0801CA0019.namprd08.prod.outlook.com
 (2603:10b6:803:29::29) To CY4PR12MB1368.namprd12.prod.outlook.com
 (2603:10b6:903:41::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1368;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;3:jFDRAUnP88Ohroi4/vMtNv2NRS6FGVcEYnHMU5XYYyyZhOrWQsK2FIt5RpNwWKWtsjGNvaiP7cG2XodlGLaCTW4g+lynGjPXSHdHWZo3pgAgK5a4Rv84FVITZvan6iqbPhT24kHZAKYrg3S4KPiZm0MJkdIU1wKOLzQHdBcHGMVQgVMd8RT3v+9FRtDMQ+tztSdYKh/U08+TyX0NZ3tx7HmLJjOutVzc0vLv9oBdUa2mfCnuxmvXJjohrRNbe5ik;25:TQFI1bAX+P3kg1V2vT4QpHQbHlkXGHOnrXIXqcrTmV5xw18F8uMXWoyoUXgM4p6XBn1S4u+kEz3K83b65k1qOgTfEX+RcvQpoZNw8UtBj4XgpWmlEMKhA/rJSJJd6Vmhk5w07ddT97yFz9+Y77x24wx6D4nvWaDuxSxnMm28msDQuizr2pZFvSuYvvKVN5Vivgd0zQj5QwRhHxK3+N1YD5B3ZYRUs0Zc8LbkXZFTijjILqI30Ym0fsO11txs9A7EcgsWdhhmMxehqXyfxR1pmXcDrOxFOnv1+nuyscNpt2CijcQBcnLz3rC62adoMzVnHspmeew4y4cXoUHZfOaOIA==;31:ri1VtMo6/q6Xwmb3eYx6U8XWZ3toWqVbecIvLjK/Kkl77Nv5XswvRaz3jgfQ8OOw/AXl58JeKOMR7QI6ff7zHE6xUDqpR0aGW2TNbz2wUQRxmU3oLMdF1hSeZ0uaIlRRi4/jkdij+z+kShl7UboqK8pVNqCNt5mWsEkJNFZZar88pozJoSErddZXZVY0utkObKUOyrGDFhKeiRHIqxaf8+u3ZA2xk2fjszpTgL6Lhc0=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1368:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;20:/Mvs+9qSAtTKTC9FZ0w1W+SDMhgOX+fXNKytoxDJIHCrTLh3xSSg69MPpCDenXpz2cU06cpDxcuctlVpLECRbBlBqUMIfXVqPPAppyTl1eCxiGcxCzh/TOaBv5nci/AkElrIfsaYflZAHnKaWUK+Lb3RJ4Z/jdA60/tXmTraP5rGuT9cFGEBL5UR5vMyGIzfIVEcKgREMH1I2Op2IchBzNOcoM1c6iv+5r8sFKdOCxg0XC696kdtl8nmtjncZ7BAkTEkozmnjfEl/GsJhOa5LPNW+wy1esuvvMBeElWFr6b2rb9l+4jCtNuqogxO8oXaGizsYj1Ui+F/9b0PdklOtre3Y/r7KqxP//9ZqWHAnaq8t8RyNADqA44DbiMyyXKmRORksM/pGj73VF/PgaH7Axmw/4LaIDE2MNbRkE3QjR/rd8f05lNjt/emRK54eBvLSlAIC0fZ+rrql09GkScQM/4oI6jOBwy7xnlMMmOgiuPMq1kejzn+hbTfxj+4cCHj;4:afRkIo3lIrYPh9wUWqygRQkpXggKaCE3TIeNFe3aSPyRyz2MDXXCZDUNBJfiifxddPNWEUj/40sj1Xu7znTTFuqc3WHpAFWNMKjWuwWgsQmSJjxsF88QclTg/HCuE6LYAWM5eOD9DfQNZb+xLBcN7S8zl4mn4DRPfX2TYmCVFSMVe9DUz138Zj5aw1XzuTpCvaKzZ36ETO6hoLGjdbIFlkZ3nZOZigYlNCo1jdxfrqTyYPNsAFReRr9mIE0nPfOCO/9+ieComerXdXJZ9zgIv19Xb+NRu4uJoPk3iDZRaALzmJmj67WxGKCPmwdxeBY9
X-Microsoft-Antispam-PRVS: <CY4PR12MB13685E8F6A932782620AEB76E7690@CY4PR12MB1368.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1368;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1368;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(189003)(199004)(118296001)(50466002)(59450400001)(72206003)(6666003)(106356001)(68736007)(48376002)(53416004)(966005)(6306002)(2906002)(4326008)(305945005)(25786009)(6486002)(53936002)(3846002)(5660300001)(105586002)(97736004)(478600001)(7736002)(81156014)(8676002)(486006)(575784001)(36756003)(6116002)(50226002)(81166006)(54906003)(316002)(8936002)(956004)(2616005)(386003)(7696005)(446003)(51416003)(76176011)(66066001)(476003)(47776003)(16526019)(186003)(16586007)(11346002)(86362001)(26005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1368;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR12MB1368;23:a5kYlgJmisr0UvxvOUQOQ8svjlYP/ViNXjEspVueJ?=
 =?us-ascii?Q?/fFktSfjMiC1H5thVRlDLRczw31LmOD2MhojpgpSv0MOsMLSit6t0O27x8BM?=
 =?us-ascii?Q?92bl3WCZ7w8bmGP0sr3zeYQ7wZ/qIGkzOK1ccq/zsAkHYSWrg2C+oLXQPsKL?=
 =?us-ascii?Q?gCUb3KzFM1Jkilw8rM6RnqyTj4TTlaEaAb/ppyxlP8vm7eoVUzn3ePEMwYB+?=
 =?us-ascii?Q?v4DOhgsTS7L13lJKfibiZtXFlCl9jwhHx9fR01ihrcjs7Z+rpOJFrK7TmOb8?=
 =?us-ascii?Q?+LH10m+u2x9FNZO6xPf+R/NmfyHKDxc4pr76Ft19P4m3CAiC+feg5y7ktv4M?=
 =?us-ascii?Q?7nSKwNcWhF5ERG90Ufs+bZVb7IjOiAvV/HZzGaclz3lkigc3y6C7icG4YL38?=
 =?us-ascii?Q?fjmEUI90YoIWTytSQ485g+4/Pl8tmwHajnAWAP5xOQ8ZObKmrShhFj/T901u?=
 =?us-ascii?Q?gudz0NgNHK596vTELgZLuVnGIfVoPLRkGwCvVTVtSVHxUbQr+GpxHHWdKiQ+?=
 =?us-ascii?Q?S+Q2ZFf/PNMkCclJvyW8o3xv9HXd3FAGEu+1vmo36s4w1e5CCGXaDqXN746I?=
 =?us-ascii?Q?PdeJzHPllgOtSFmt0c/bc/S1P30IhAixnXJS62Ysxj1JR5P0cSsLbFQ5ZwNd?=
 =?us-ascii?Q?pd+tXz+6R6eiutWsSszXQJU4l2EVzr07o0jZ6KDRF6VFvyiMhP5gTskaxHlu?=
 =?us-ascii?Q?vreMnbbvd8tPXdcDS457z0XwpHrLBk1OQcZiQkwRdmjUBPBTvU5VxFMxnvc/?=
 =?us-ascii?Q?v3gEOpMtuXa1vRxc+AAwtbxtLbddZHGznkZFWlHHRbDAjeVKGFK1JL8BXGLM?=
 =?us-ascii?Q?1msApjnyOg48K/jFYWHYAI7qBhxZ+YLp2Skp8Dxp1jvBnXY8Fa6X2zNAydFQ?=
 =?us-ascii?Q?nJf7DHm0c7dzY+SKJdnZiAUQB/RTOHWd/gvoSMvO3HmiXPV8NLzzhBTRP4N7?=
 =?us-ascii?Q?2t+YNq3SdkmtDN96KxvZQjYjh3JdMT6IQsEiZlSrWw/yBf1a8lmOwEKt5Nw0?=
 =?us-ascii?Q?Lk3hdPj3iMVsJA/zvY/OpuT+Gd+NDgf/jKNDWFC0y2QvkWzDSH4wNCdzttnx?=
 =?us-ascii?Q?9hBMPGEU733oA5htj/l+WYN8gIGScRFcR/NW0NAF7HLy7H88D5/pBwpD+G3G?=
 =?us-ascii?Q?8tpXpDVwyqRu3fimcnhhNgexSyXuZCpMlYB/5GH/0UOgyUhWt9f0sxwiC1Xo?=
 =?us-ascii?Q?qEwq9GRF3I2Fi/m+9GPWWow8CMygPI6TZe/F2J+pA7qGnzNV3s1o5fJwXTY7?=
 =?us-ascii?Q?qnsTb8zY3zYKhl4xWotTMmRRIECTIPtnOTpZgXnulXVxJlFRuInelV34G6Vu?=
 =?us-ascii?Q?rJkWIUtoZTbevV6ZIBYdEM=3D?=
X-Microsoft-Antispam-Message-Info: sRlB5GLtwB2OPUlQ+z2MXKJzw7Z85tnpCxirSAVuGmojMtywP7Tl+ebKCsgDdPiAukSbbCyot48HZ59BjciM7iReIdlSDGgUv3qnn8sdb/WGsqIqh1v3nHpzeg2wmnpwckvigFpfONJ5AdDrJ1a7g069si+4pG/Fa7F79EEp0tpGIVWrqK/xLZO/fMMIZLb+
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;6:jdyG2AJoVPEtRvIom/fnOahR4APWwzsmerjfskI3j7IDbS0m8TwCdd4681oBekWMLm+FGj3wzOu9H8kuaczRbmSd6ce/Xl9gFw+Hen4qXAC1xKCBy1YWjqwk4MEFMRBX4/KxMYgkYKG7wMaHdCKtEtnH7BNDsn15IA/mUe/WWkfDO9bMoaOStfPf8liPDTZ9Xri2UvpWwkzCGQV4Y9zzGVMzUM2j1Wxp93Tt1z6IRqFZ8ub8/c1ombBkBZXQk9ApEInUKezYePXJY7CFr1cZRutr3kgzFss+YWL8xw8OzDfwaqlhOik7uYR9+ELO5L4iLI43lkYQYwZs1kN+0Ffxdq+X8SK56QCD6Xyl1Oj+Jva50EZXcq4ynbYfH2XXFhvxkzM+R2ZT+6ADTV+GH0bg1n6AGoG0t2b1Yt3NkeO83mpP8n+WDKJmYDIS1PQXhGFfS7/AAFgWSoPaU7OLeOCy7g==;5:2FkanFzJ5fopwK9pJ9jGxf7yqaYZPNaMYOrOqQ2Xbmo9vtDOluMOgO/D4WmoU+o6Mco6V4mXmlEvNYrFZqyni07jstsfMuHHmRKSvW08gJ+MV0SMABbkxlfphWzkYb4foEbEJ3tXfsTXM4fTxK8koRAm7QFDbiqCSdeoEjZfCJg=;24:N0fLB4BgoqYaHsGis40dSbQEUTo+D2O1Y9U3AmY8entFIqu/qlKImwvCCti/9WlcnEAL1HpbPiH/CrT2ZDjzUM5ntHxon3qWyi8F+ubvy9c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;7:J7RLGXu0eIkSOuxDgH+tjPWdLjt5r24wQ4JDCo7xZUeipBW/yFW7A7FDUeVF5frCMv4iI3tGt2BhJzE8Z/QiCLbEM44JEYzlHZYGA+t/xi4cgxHynOHw/+Bdc/zu+KVHmou4w5yPE/NBsAYbEKiMsBrwMX4CMuFTaFzzrarJN2CBWsJCFmpdNopE3YVTmbgJM/Foing8KTs/bCOYGGNJ2Lk8uiH5xgGxNp6+7RwEY7yFaFhZjAKsQetdn7AR1OCv;20:+tXqRMC9f+Qng8zjgY8uNcl2tFoWBXWrLZXmFPLH51oGBZd7BunUhZfB+5v82xQUCALT5lnv7sFW/uucR7UfDEbDtQwz6kvjBQY4FrzIsCr7hpwu6TfKK2+BkaCY1ODLQLOt2jHJHnxVzT8mqhijmx1U0lYyHbO6BQrE+MWrHPPzyD8W8lsg1hr8VT1hWlNpkJMO+MwAqZ5t1xSa5h1wfweHiezD+UvnKxh3h7w50luQtQxwof5SNzJrKKtG5g8j
X-MS-Office365-Filtering-Correlation-Id: 80985c4c-cafb-4f5e-72ae-08d5c27d6fdd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 20:23:53.7683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80985c4c-cafb-4f5e-72ae-08d5c27d6fdd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1368
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
 drivers/crypto/ccp/psp-dev.c | 99 +++++++++++++++++++++++++++++++++++++++-----
 drivers/crypto/ccp/psp-dev.h |  4 ++
 include/linux/psp-sev.h      | 12 ++++++
 3 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index d95ec52..12838b4 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -22,11 +22,17 @@
 #include <linux/delay.h>
 #include <linux/hw_random.h>
 #include <linux/ccp.h>
+#include <linux/firmware.h>
 
 #include "sp-dev.h"
 #include "psp-dev.h"
 
+#define SEV_VERSION_GREATER_OR_EQUAL(_maj, _min)	\
+		((psp_master->api_major) >= _maj &&	\
+		 (psp_master->api_minor) >= _min)
+
 #define DEVICE_NAME	"sev"
+#define SEV_FW_FILE	"amd/sev.fw"
 
 static DEFINE_MUTEX(sev_cmd_mutex);
 static struct sev_misc_dev *misc_dev;
@@ -112,6 +118,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_RECEIVE_UPDATE_DATA:	return sizeof(struct sev_data_receive_update_data);
 	case SEV_CMD_RECEIVE_UPDATE_VMSA:	return sizeof(struct sev_data_receive_update_vmsa);
 	case SEV_CMD_LAUNCH_UPDATE_SECRET:	return sizeof(struct sev_data_launch_secret);
+	case SEV_CMD_DOWNLOAD_FIRMWARE:		return sizeof(struct sev_data_download_firmware);
 	default:				return 0;
 	}
 
@@ -378,6 +385,79 @@ void *psp_copy_user_blob(u64 __user uaddr, u32 len)
 }
 EXPORT_SYMBOL_GPL(psp_copy_user_blob);
 
+static int sev_get_api_version(void)
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
+static int sev_update_firmware(struct device *dev)
+{
+	struct sev_data_download_firmware *data;
+	const struct firmware *firmware;
+	int ret, error, order;
+	struct page *p;
+	u64 data_size;
+
+	ret = request_firmware(&firmware, SEV_FW_FILE, dev);
+	if (ret < 0)
+		return -1;
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
+	if (!p) {
+		ret = -1;
+		goto fw_err;
+	}
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
+	if (ret)
+		dev_dbg(dev, "Failed to update SEV firmware: %#x\n", error);
+	else
+		dev_info(dev, "SEV firmware update successful\n");
+
+	__free_pages(p, order);
+
+fw_err:
+	release_firmware(firmware);
+
+	return ret;
+}
+
 static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp)
 {
 	struct sev_user_data_pek_cert_import input;
@@ -750,7 +830,6 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
 
 void psp_pci_init(void)
 {
-	struct sev_user_data_status *status;
 	struct sp_device *sp;
 	int error, rc;
 
@@ -760,6 +839,13 @@ void psp_pci_init(void)
 
 	psp_master = sp->psp_data;
 
+	if (sev_get_api_version())
+		goto err;
+
+	if (SEV_VERSION_GREATER_OR_EQUAL(0, 15) &&
+	    sev_update_firmware(psp_master->dev) == 0)
+		sev_get_api_version();
+
 	/* Initialize the platform */
 	rc = sev_platform_init(&error);
 	if (rc) {
@@ -767,16 +853,9 @@ void psp_pci_init(void)
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
