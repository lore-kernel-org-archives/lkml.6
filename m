Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeBZTku (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:40:50 -0500
Received: from mail-by2nam03on0055.outbound.protection.outlook.com ([104.47.42.55]:51904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751882AbeBZTj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:39:29 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH v2 3/8] efi: Decode IA32/X64 Processor Error Info Structure
Date: Mon, 26 Feb 2018 13:38:59 -0600
Message-Id: <20180226193904.20532-4-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To MWHPR12MB1917.namprd12.prod.outlook.com
 (2603:10b6:300:114::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e78cefca-0dfc-4ec5-6398-08d57d50a5d3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:W3YySaTGwH5w1HQkVQQX0iWRh73Fn/PsdFjBtonvCtCKGEAcWPFc1ni0aDzhyydjU9vTV31VhYIvEXdqjtBQiixcW58j0v+DgrtSpRHUTwpe6Pe0CmDIR3ERHbOLF880UdfiuMyc6SoT7svshf+VRMOhvc1vuH/Ixxga5ewVmWkvjXUZY0GFXfs2UhS3/WzMHOP5h/c6pw3GQB/8aDVo19srMiHEeYZfccKsU21vVtzySGCyac0ov6DbPtjmdCve;25:teJ3ILPZD2emwB/vchYy87Yg45TRH9xGXQ4EFVet9XqEXkyfhvQ73NKqwKwW6PTptNDHV/1g6sjCQ4VDqE8AU6wO/s2DbhqfHyim7LRhfZUAkexKc5wM2yWB1FW73Jfcwq+DQLynHHAvNjFRZpL4630j8pm1vL29yimX+18nd71GDcqk6Nkj8SS1SvXOxv4jHrR0PSWuk1WBxpji1pMNgQz5l0x0Tl31+QtrLOpf+5MGtIAKHPBEMt8gI6gf1tiqm9gnAxcWl4UAIJWlJNOsgtpXXEA1l9X9E2K4zoA7rDjtPzMt0a6mn86bIko/xj8++sEOh0Bm5m6LiXIBftV1kg==;31:KHOv3dR+GGV3yXpztA6yRj4bhWBC0Mii0e1er6t5l0sLXL3PE2BlUiFHKw81Vhv5NlD+lF2AwJBJ2IfttTgGAcKtwoyJfsSD/nu8yv7Sbsg0W7hWUJmIo+XDC0UvYl98Uo3R1NJptSYGHxrxDTA/c0fBBCIYhMxht1db3kpwaFNY5P6rEXNhK0ovoLtjr17Y4mfuih9AXYWIKlwTRWJhgKEgKrt+Oh3zKiBRbWKuJ1I=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:jOgz8iV3pboDDGCzXe4yShQD3IAsWtNYDStqPZivUw9mIrTXQyIP7Nq4ptPK9A6MQ2++yU0WmTZcWwAtnmLRTsZTKMtto1NpYtW6VF28BLEtwphWn2/b9V83neJVTpR6YpQMiKnMbb/+azszKPM/ylZx2JcZ9CXtf33gvCLKD6HJcGZFB/KQDRFX/9cwdaDGVx57QQxt8zr9XBmRWMJDDZsABMBOHaHr2PyoIEcuoqRltyngYQeeEnendtjJKIQr/b8+6HdQVC+/f3MBCOX+zEAoaxR039Gb2GCERw7tafMDO1SA9NijNDFbuQr1n4nmsUriFTQWJFMkzK+CwQxE4kmPCy531DrCsJpEKTpOgnVqu1ZbIRcYMnK5I4n9hT8V1llVmD96FAkq7TNNxf9bJe5XCKdgNKqH+sSlYOfOH7Rlkfp5ChoSXQKwkpUSJSni7vyHuT+AgjykidGGLTXec+EFUkQPPTYEid22ChIWHTj+NWvnyefX+blk1Vfgta/J;4:/hSuRmswMycUF5y9JdCrOp877MkQDtKT2yb7ngRx/ozWS6+tEGUSq7QukImFB/5IilcFeGoF2cAnfVW5bPd+Zia8fJSVPYUnEVHTRhBVDrbXkAjxkm9KFuTQUgqzCUryzVXHuabVbaOBiBnNHQYHZ6kRRt4pNVRftc6w6TYcRmay7TbeLNmXvOOlVONVkYNYFqzBif7se9QC/yYJklY2CCHcbQpPiXiGmTsKqnCaBTpAXbIft48nE/2ivIQ3/W/ggSETzsUG0aSCxI9iZ554P5EYz26MKvQ51i1i3PWbZgsAkFYaWlU3nE1TUJBRKIKD31w6oqTZB+nfjU67nQvV7A==
X-Microsoft-Antispam-PRVS: <MWHPR12MB19179C906DD35009D3D447D6F8C10@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(72206003)(2351001)(105586002)(386003)(16526019)(478600001)(575784001)(86362001)(25786009)(50466002)(6486002)(97736004)(36756003)(48376002)(53416004)(66066001)(106356001)(68736007)(51416003)(50226002)(47776003)(7736002)(305945005)(3846002)(6116002)(53936002)(6666003)(2950100002)(6916009)(76176011)(5660300001)(1076002)(8936002)(52116002)(7696005)(2906002)(6306002)(2361001)(8676002)(316002)(81156014)(81166006)(26005)(186003)(4326008)(16586007)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:0XRTDgoM+IbmMm1Y5Y2GgHNls4FIrWMzn9OYsN5VV?=
 =?us-ascii?Q?d6In4bX58xnG2tWvHUC1fkk7No4Pg6ANcTqmNqAY53uihUCHT0XUCIDNJPQQ?=
 =?us-ascii?Q?4JevmKwQQ74AXcxJhhCSbahvGpSZulXtMTtqWu0LA5ZEug9+52muEq4R9f4h?=
 =?us-ascii?Q?sMwFOtalE1wk/qcaS2iWlJOfvQKl3sSc5IKO7mg+dvHpiQVcc6g2I/dqyTqp?=
 =?us-ascii?Q?cgffPkCnb5xeTSVl3fo1rcE97fjCZA9RYf94cn3/BxsFd6xg0vENJrxug8j5?=
 =?us-ascii?Q?pzV2XAsEA1I2KnvYf2WPZDtuOG6NvnlOxavyAKRGn9YIj6u15UrcXHqRRJb4?=
 =?us-ascii?Q?Xc2+10o5Od4vHr8NVdiBtvLYdGksILM5RxwRGjTPHxUZAV1JC1y/5oBREqpv?=
 =?us-ascii?Q?eVHxFJPONr6pNs3EYx8LNn8n6yJdwsD/sx4ehChMCr7soYfR3x4+Wxm7e0lQ?=
 =?us-ascii?Q?2JaP9RsWfPOAlO9D74wzlGUkSyC/ra2F0spPVYKglx7XlARFopWp9l6BO2hN?=
 =?us-ascii?Q?HTvG0wINGRVfziBtoHtY8Q7WcEc3d5nrZyn8w75c3QdBq3IZjXHWWITbllkO?=
 =?us-ascii?Q?YjCSx/17dozLwuQmyuR2dIr6QGnLyYoSxQ0mD8o30J7mSCLaqCP+rCDfKI4M?=
 =?us-ascii?Q?5qb0SMimklbaRJ9ZOIZuaYSmi+SikmXqP7RuobQRZdqazwubCm1IS+XzcyNe?=
 =?us-ascii?Q?a88ZjKUsm/c2V8r0oBFaSzOIqb/5r0r2+uZEvccF9b6Iej0a/YEw/SBsNVX2?=
 =?us-ascii?Q?zE22P/MjS5DYASmI+Kh8GQLyWaN7ntDTqbKldDqVS0gD7BbwZedHFU7vrZVM?=
 =?us-ascii?Q?he0qGsG4J1/8AtIeWrlT4AuiE1ITfygfgrLVXhqjobh/FIJ8Orpn1H2wFQLn?=
 =?us-ascii?Q?E7k8ftAi5ta5+iwt/Z5zBGWgNaqArJjAtGvRgbS1iWOhC6RBog6N99lh/dOf?=
 =?us-ascii?Q?k9pTV9nsQgApi0KHgw3yQVpbBxwsK8MLHkacQPQNZKrxwgtbhJ8cAafQ/7K+?=
 =?us-ascii?Q?2s5HpXHDiZUvbNb+32mUadZU92VJpVS/K17fXfJl5/3nMocH/RClxj4+ldNN?=
 =?us-ascii?Q?9A9DpJqg0+kgo+4AG+4qK/q/E8j9Fq7I9Xkcct4AIQ3G1Qn3Ty6NGiDlS6Le?=
 =?us-ascii?Q?Wf4xBo2wjEKdzDQZiO61OHS7ZfE162CQVOoBikA6o5cnfKIO6sz0TWE+PDNn?=
 =?us-ascii?Q?fR2y1rAbU0yrAIZ7+qn2Py8tQyI2GWTa1g7yXwH2hDpNKqgwz/af1sLI5k2E?=
 =?us-ascii?Q?wKtr33YcKpum+E2MXc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:WLuh7a6t03bX40uQRPSUcIxeiZHYZNFaKeSzJ9Vm4oskpXej0C7MQ0N/b7nXmrb1D4rmZpYVncwcZ3ZzqTM4q4jZqY0yVl6P6paZ8AOrai2a9PKOSJiDsgpKO65smAs5L29huI0e4yQdtKE2Hh/rjKB60uIuwTms+Vne9JT+ItghByZpKvWMbbjFlr6aXnMMvA6E669TytkQvoWjAEddxqUo4nKZWzOv5QKm+xHQpVMtbe06+3A3tCWKSl//a0t1V547YAZbXtURHIDVC/CmbVDtye4Tuf3MoIJMz5pcjP7rY9A6gfzdPZa7z2iPImYoc6vx898dBXoAWN2viMu6LNMyS+TR83aqTyKAE6gLBRw=;5:R2rf6locnPzn8GK0YIHkVpwMuTW9x6OWrJfvm0zTfVRYNP1KfO1tTlRjCJG8jBTV+TXSEIrCwJflSntSEabFwt5FEHELHtH7LosN9GzWngOZSi8lOwZH+oE7lKGcWo3+g0Q+WJMKgo3r9+EsaMX6kpwTXtr2OCULozSxkVb5PrU=;24:xlvTCGDQYqeA3EZ0j/M2drqYq5sAlU3BvLxJYq5bNKfJVhvGmqq7X9xCOouDdsNI1bod3k/ibOZAKOeu7u7yF52EwCSf5imGlqSCNLagO+w=;7:ThEdAC/+DdSuLR80llAg6pOMgkq5ptdOi7jZtLlasQjk7zrxSNxnCMLaWvEZkVqfqyy5Qm8eHdAdmGeCuLbq0DIaiKxw2jA8RYAKl2H4b3v5on2TqGaiUSrlaK+vwrKnjbyMl++eLO9TGqm5mu2Ee2idJ8bsIhs1YjpnP6A44gLyc5xJmKyCBPNtxxZpXFLIhd6iT3Mzv/I+qW2c7eFinisT/XpDaU9Kz+dnqnH4X+TmubREYlCghPC1WhnEXIZI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:D/SgqmgLAajb+sKx7q9QlmXg6c+Z1qblNOY1K4pQRuSQcvqT9lNzIwSi8s9Ra/nj1zXgADpQn+aaI80qAq4MnXgfvk9JJsG5BkCMDTQqOoJGb9utbuPZdnNACBCXSC53Qc6XFmthuw5XzQUvUxpxIdQtAwAjVd+30enQyVMkvJO4AzF/sTwEIXRDSZMZBjHEsp6msXl8cD8azTR/5QYSBL9pELLWoTIdpguC8cDmq/joctjAYTxFvrvMCu1pMlEm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 19:39:26.5274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e78cefca-0dfc-4ec5-6398-08d57d50a5d3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Print the fields in the IA32/X64 Processor Error Info Structure.

Based on UEFI 2.7 Table 256. IA32/X64 Processor Error Information
Structure.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180223200333.6410-4-Yazen.Ghannam@amd.com

v1->v2:
* Add parantheses around "bits" expression in macro.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 9da0d981178f..417bd4e500a7 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -3,15 +3,28 @@
 
 #include <linux/cper.h>
 
+#define INDENT_SP	" "
+
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
  * This will save us a lot of line space.
  */
 #define VALID_LAPIC_ID			BIT_ULL(0)
 #define VALID_CPUID_INFO		BIT_ULL(1)
+#define VALID_PROC_ERR_INFO_NUM(bits)	(((bits) & GENMASK_ULL(7, 2)) >> 2)
+
+#define INFO_VALID_CHECK_INFO		BIT_ULL(0)
+#define INFO_VALID_TARGET_ID		BIT_ULL(1)
+#define INFO_VALID_REQUESTOR_ID		BIT_ULL(2)
+#define INFO_VALID_RESPONDER_ID		BIT_ULL(3)
+#define INFO_VALID_IP			BIT_ULL(4)
 
 void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
+	int i;
+	struct cper_ia_err_info *err_info;
+	char newpfx[64];
+
 	printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
 
 	if (proc->validation_bits & VALID_LAPIC_ID)
@@ -22,4 +35,44 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
 			       sizeof(proc->cpuid), 0);
 	}
+
+	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
+
+	err_info = (struct cper_ia_err_info *)(proc + 1);
+	for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++) {
+		printk("%sError Information Structure %d:\n", pfx, i);
+
+		printk("%sError Structure Type: %pUl\n", newpfx,
+		       &err_info->err_type);
+
+		printk("%sValidation Bits: 0x%016llx\n",
+		       newpfx, err_info->validation_bits);
+
+		if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
+			printk("%sCheck Information: 0x%016llx\n", newpfx,
+			       err_info->check_info);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_TARGET_ID) {
+			printk("%sTarget Identifier: 0x%016llx\n",
+			       newpfx, err_info->target_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_REQUESTOR_ID) {
+			printk("%sRequestor Identifier: 0x%016llx\n",
+			       newpfx, err_info->requestor_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_RESPONDER_ID) {
+			printk("%sResponder Identifier: 0x%016llx\n",
+			       newpfx, err_info->responder_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_IP) {
+			printk("%sInstruction Pointer: 0x%016llx\n",
+			       newpfx, err_info->ip);
+		}
+
+		err_info++;
+	}
 }
-- 
2.14.1
