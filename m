Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeDBPHb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:07:31 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:48864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752318AbeDBPHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:07:18 -0400
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org,
        tony.luck@intel.com
Subject: [PATCH v4 3/8] efi: Decode IA32/X64 Processor Error Info Structure
Date: Mon,  2 Apr 2018 10:06:51 -0500
Message-Id: <20180402150656.101022-4-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
References: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN7PR10CA0030.namprd10.prod.outlook.com (20.176.16.43) To
 BN6PR12MB1905.namprd12.prod.outlook.com (10.175.102.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adceb542-3be6-422d-2ff9-08d598ab6ad8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;3:F+udd3zZa2PnzjUj4/yWiCdn81v3uJv6opIrFHCPtkGVUHjgpUagX/P21cJmxLCN5JQtbtacBvtamHwruSHOptV1oapdezU9ENqKXHvg1EFBkNLbWKZqPr6xRDS379meHUus+B/yWQYny1sAWBMvsAqjpecNGRkLFnYWqyuoy2jBwoJkBewX4yhpDmpm29JJ3ekyht4q8u42ls6oLQ+ETpkAe/W4MT14UubXR7C5huWbwjZJT3MFDhC+KshCrihN;25:UMAX+HdW4jqmi9+59j4kUqgi0oKJaFxaws9jPbRes3227bgvLjqdYqEchNvtg7FU39iaboMqerMbclvT7b5+BUyIryi8rlphsB5dipWT8ZqxOxbWxvnmuhRvzH/Nu9/ej+5RtNbbJhtvlwDOP8sYk/WTqEG3qAW15wUstRbv4ghmVq8NC97UiIgHBnZkpK9B94SBr4MSQn42A3iRKwSdi91y2vIKRXRpJLT9Z/8J9LFfTVrZb/Si88jqn1auuUKWOHsYe/3kwAAIFcqwOAcuy6m1RCyyaMLREwpIFDA1oCMjtzcXICww93dowom0dfJ204cMK5tWd9YmPHfgR5N41A==;31:jlC+krPZa2VEn9vEhfIuD1sxQaVm50HGHeQoeTQLX8uLDmGjqMDCUEky0WZKlA+rfjSpB4ZU9kO3FGBeP4Yq3aZFmePoTXvGpsFb3N6CPeP96t1sQd4pjkim2F9gNseodEISWjq829tkrEjtpvZGVQiLkuTB/7bM74O+HyeHh3iTGKNygHMYHAVwAZZ1TbfaRGm66KU1qu9pRMM1Fnc84Jzvfi1nmb2DMhrREkgAQz4=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;20:WUQ+7w6iq2KLuX2e3/yPE6m7S0tZ4029S/0IIizeSgSBG9aYIkX0tJy8z22I149eeKiox/z2FXdKamAt1Gb+P9fqUn/sBr9f0V7fbjtsjcSK1hzo+8Ydk49MvPaNj6uI7wTROKr5yS3JPreo4JVEdYrCDCcHyPGN6DMkzkE//20W7XZmXnuKIvwVk6PHBn4mb/1pGr+7tl/9GOBYYZCma47kURbBUPyzAhrprXjn5ZihDEI5U7+MziQ6vRKf+Mn6u3xlzz5WT2/5f8aSE6TTaWop26agiRDYg9P71ncszM9ESVhm4Pu/CaXLzxc9MkxVy4Zj/5HSi608zsbwiOSd66TgeSbVQ913DpY4lQbIJub4svSRCJTTkA4Sb8tkzwwCSFsBUutUJyRv4HpHn8CnWbA1wBuDodkrzDIRvq/GrR1X1NdiJSQcDuNA78KehGlSV6DmLQ/HU+UkC2yBSkW3GinOjw8K3ZvnJrwpGdpQi31RAX85Yw+ihAYyncoEjvyT;4:dDvf6PE9lYweZQ64iO2XGIqoOQOR3hV0iVcQ8EnpPkToyYBclq9PWxC1QlVuU6pzKF4f1IkPOIlISTqttOQEukM1HDRiPJLwrS4WlK8nPWzn4O8egG9leiY209eWwKxyvC8G63BhpK+ud2JuwQ69ubeslKNSyF4qWyLIaeTYQNDi3r8XbvDg/ugYFRrsogX90OyUr5r/6HxLNrZ3mfnnbN7d9RKSpZYD/Mepbrs57uus1iSyXQ9qsQm2ONdM6fGpG2cUwNnTIYcbby0xsOLm8WS+dcxWE8E8Nif29vWUCHqGe9h7AFhOLWwjlFntkL3L3hKdNDjtHwYuBhW5YWSmXFurVj3WJUgHOthEc83HmsE=
X-Microsoft-Antispam-PRVS: <BN6PR12MB1905865D41AC7AD1D71AC6C7F8A60@BN6PR12MB1905.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(2351001)(97736004)(86362001)(575784001)(105586002)(25786009)(26005)(6666003)(6486002)(8676002)(5660300001)(106356001)(50226002)(8936002)(2906002)(16526019)(81156014)(81166006)(2361001)(50466002)(11346002)(6306002)(66066001)(53936002)(386003)(48376002)(1076002)(446003)(6916009)(6116002)(52116002)(68736007)(4326008)(36756003)(3846002)(7736002)(76176011)(316002)(966005)(51416003)(305945005)(7696005)(47776003)(2616005)(478600001)(956004)(16586007)(186003)(53416004)(72206003)(486005)(486005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1905;23:cei2ef3XQBj+PfmphEiblQoJEPVEUNN+fHXpGNVwF?=
 =?us-ascii?Q?PYBKwlt+buMcC+L0bi1enHRvDR43ZY+AmGj2R1zevgJFfTlZt/W6WCQw+L8j?=
 =?us-ascii?Q?8TwhDQQbGxoiDEY2Denuk6TTiyptc//4+40J3QzM+2JjUp23hUexCWDX5Y5/?=
 =?us-ascii?Q?xR4BsijPmsHKjO12ukOGJ/wnF6ckWLiVfq8G1xtlCA3jjhwbOZgcoyPwWNJl?=
 =?us-ascii?Q?2aNqF10HzPAnDjM7DGO7+z7VOqS1GInsdlTeQ68NRf/6UAmtG9iWaiHZNZDc?=
 =?us-ascii?Q?ByiFNJCmYy8ust+X/fjeiQvYvGwm7B59JX3QJnobN6bqvUkVtaUAoxyTtW1L?=
 =?us-ascii?Q?+stsrkO6mfKxlj0Gt/ubye/PZRyIEvcr2yBBbu/7h/wKNNX8YCDCtOxJQDap?=
 =?us-ascii?Q?68rY90cxrcOsttylrD3ShUKD9zvtCqOkLwH+uHFL5UjbYW8pSXIWwiGxTV8D?=
 =?us-ascii?Q?+HMMh6sRxdcdi+NXvjOfQ5aVLrbP97x5nuDOV32uOvFlgXCmu7CZbTQDuYbZ?=
 =?us-ascii?Q?agtZH3uvchwphCWIWShMGrJKHdfr+ldMTxxtwvcKECFQzG6MzELm8iEom0Xw?=
 =?us-ascii?Q?X9wN5DORkIZ4yWA9jQR6RBQq3Y3up7qaBlTxXySFmb9nD/43/S/1ZWxpyZos?=
 =?us-ascii?Q?rakqJV29gMdQxPh3VVJnM2QmEENJoxdQuu4LqAcuyB5Eq0vjcTfS/6e9qp2R?=
 =?us-ascii?Q?+njcSmxL1cY+8eh9hm8s5nVCx75GruaSGCi62xOI8ogvhAf1oFfEgoem73Ey?=
 =?us-ascii?Q?yfh9v6e1nrYRXy1mXgccCqTmGuVlJ1V6etvrVoq3b34zGq/xv7aLdLybJ7m7?=
 =?us-ascii?Q?AL+QhDxAA4CBWchG+qE/j5AZjmvHGArGSvvnRKRygjzn/rnsHzFzpJy5Xckh?=
 =?us-ascii?Q?aXP/0cw94tLnfvMcMeFwvAdYlNIF10Pny52XVTssn7kZiRN96UwBgkwEXQ5p?=
 =?us-ascii?Q?kjKywUlPxa9kTgfbah/+d7Ji8ehkE3Hz1xFhVZRgdqTXHZGU0YMz1BFUsdNa?=
 =?us-ascii?Q?9ySurN2AVR0dFrS+wbq8aSldhMedHUXqONkOgHj5XWfg4H3nCXM/TSYFNwB8?=
 =?us-ascii?Q?WyV6Knhs6KaSbmZXnGk5AAeni+HK9GhDREDN80BM+rVbZnp9EuYByY65VMuG?=
 =?us-ascii?Q?RrtJH4PTC+fLUNDf7DZJVHHzQytp2rvsypbIg70+wq0ebocmw0djJxxYADGf?=
 =?us-ascii?Q?j65GgBhRzgXRCjJVyhfoLEFhBhmn23ZmiovIBjUI0NnLMoAcV0DGnINW4arC?=
 =?us-ascii?Q?ja5Fl/9U2y6YGP7UtBtAm/fzEgkng+qT1Xc0WdNQi87nNGNilXEFVCfGGrmH?=
 =?us-ascii?Q?sAWel1a71hzkfAbi2fnQ+eo0+8YIxgzYVPoJTG0mtPy?=
X-Microsoft-Antispam-Message-Info: BMY1Ya739e5TT9jlBiHBzrhv0ucFYXI90TKcuyRNzHB1zR8GXmIMCDDfSzaN2QIjfdsPMpnuzNG2oVJ6ZTytf6L7t4B+UyqpWTWAHhDMZ/HNyk7yJXv8SZm33L6ngCmGhERWf+h2rpejWVPc0J/qrgAdH8et4RbpTuS45HpkDHM+p4MiOGAswC2Mbmb2tv/r
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;6:QM/iti3rJ0ThhQigG9A8KDBNYanlQFKZPsthhOOtxROzw9gVcGslJr0wFoWCD+esMdGhVpAe8wKu8tabGHoxJrP1q580aGF8USCWTS+w2kPJcqvAyGoq3NmizMVIJjCD1A7zx5zZXd/JovIvpUuKB0qcirCnup1U91zu3a9ZRBsWL1pYnfXk1MFzhu9czmM5KwyoTHKSLhhpr8BEllO+XFvKrRNwg8SDH5yLCf24LuBytMNWWjlPdJKGGqx+flETq91+SWRpauFTrxhSA8Xy1Fl7s1ta2candm+tFvXbsbZLMNER8JChP8akrhMAf+acmcjRQ4SpyHrvTEajmh6WOW2eshbdX8O3g2R/4TRxyItA5oxobJRgPLOP/jvvgA0vfYs2pfdty93UHD9nqCMzsJLJK1zOaqGwgkjagzlNuel8Nf21Bjm9/2iyfeA8usNyX1OdA8ov/G6MBGjz/vby3g==;5:Bo3i7jBMzIgymsW8n9u9cQHeNRwonivqeon6cFd1j0L/sPHPTeKMh3gzopeYXhNj2L2Gsdjc+6G14Ue1ljkl//xLG3Ni9hdR99Das7eLDVZ1elSkK4DoUi+HV0+0vCHmXBkcCSSXQ4wVNrPtplZ2Hir02AdmYJP/vi1CtbCk7Yk=;24:rbvloS89nkNZlwFaiZMIS6rcxSwRsm0Rae1wL2xpt+uCEtaEDkC8FLY1ZEagMhTQ3Su+hhoHW8CvIyCa38vnqRR/VcHh3MRi+h9pCeGDVb4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;7:XbkDnqcBClTk96fG26d5NnldqibMMVJ7UzMBW/Du+G+SggDtH2ovNOPSrrP/DOD/eMPrVNcy8V+FDYVVDbuvQku7M67aqiqOqZh3VaxXf455Rt6FEu411qBK3Xpzni9WsZTA1KZ4ppynB4uY43g9XtsKHNW7A4rRW92CVRqnWebwm9qFhPbnBHhReLn6LwtxJHYKWOWpBTtHgMBP1o7KYH8mHYuh33T2gYwjpNe36b6fdsE0oDl4inD7Qg8WycRx;20:kbnuKG8OBFY2eqUc891bQTU9q5DqttrB8Kt+ED7LEbM4NJtdABYlRKOTiu94kuXhuT7xzir+4U8vQUqWuIvfVye0fqvwZqF7E/BjbDYJNgbmOw9+Fa8ucRjPnIR+yLsXNFbFseNbn6eKlwyntXOvtNiIJPHvbdwd6CD5WWk8VaHx+/PoATEKR7izC1Se2ErIqU41XF149TAjT8Qe4mXvb54Vm9qGcs5O0CHPeGrFtdd3rVQLYBEaNOEHm9/+gfUS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 15:07:13.8072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adceb542-3be6-422d-2ff9-08d598ab6ad8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Print the fields in the IA32/X64 Processor Error Info Structure.

Based on UEFI 2.7 Table 253. IA32/X64 Processor Error Information
Structure.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180324184940.19762-4-Yazen.Ghannam@amd.com

v3->v4:
* Drop INDENT_SP use.

v2->v3:
* Fix table number in commit message.
* Don't print raw validation bits.

v1->v2:
* Add parantheses around "bits" expression in macro.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 863f0cd2a0ff..e0633a103fcf 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -9,9 +9,20 @@
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
 	if (proc->validation_bits & VALID_LAPIC_ID)
 		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
 
@@ -20,4 +31,41 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
 			       sizeof(proc->cpuid), 0);
 	}
+
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+
+	err_info = (struct cper_ia_err_info *)(proc + 1);
+	for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++) {
+		printk("%sError Information Structure %d:\n", pfx, i);
+
+		printk("%sError Structure Type: %pUl\n", newpfx,
+		       &err_info->err_type);
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
