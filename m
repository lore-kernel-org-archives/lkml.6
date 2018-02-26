Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeBZTkc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:40:32 -0500
Received: from mail-by2nam03on0071.outbound.protection.outlook.com ([104.47.42.71]:31392
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751919AbeBZTjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:39:32 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH v2 5/8] efi: Decode IA32/X64 Cache, TLB, and Bus Check structures
Date: Mon, 26 Feb 2018 13:39:01 -0600
Message-Id: <20180226193904.20532-6-Yazen.Ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 16f92d21-e5b9-4a2c-86ac-08d57d50a7be
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:YWlq6VqEm+ubT8uOVAke9KoO55kcgIK/hmSMnXctdoWZqXLKrF3FL9ZC0Sxo90iIMgrjcPZ6fQNJIuTNSJBY2yjMqBVxe3YU//Z70fu1qAlWh0I5k/CflE6QSz+wPeXNlWkkr6LvhjtM4oG6765VO/h9Z3nzzz5WrwW+oINW10cKK0SwFbvGlAT09HAudDxNgdLPCYexHTt7CIo78a6b/L2lk5Famg0bijXTQRJ0u16s4ubUi7FDWl94H7uDNQkn;25:DKdW61V8a7T475zZis7RyRLEQ7Ps5a1m/sToSLaKSLmn1iBTY6plmsbhGcmccP8uyrAF1hSSCNRuZ5zRw982eb8bHv+OKSbniW+YOfb+33f43voqs+QksPTxxE8GgqvRNwVNcX5N4whnRzo6lv+9xSEhjxNiCVyZfIvlJ5+8dbHsutfYaTwucLe2CC/otcbR8SCWqDOxlliN/4LIXKuXmFN6IktttHuTMasO0CuwWPgaKNrf17MD7sd9gRMOjqGGlKMSBKypH45RpJXjJRu7CyxLo4cVQ1g1rDi0pWg0EfjyyeSdEvTITT5ojxZchJPJ9GvTLkBZPErXdO8OkGWIpg==;31:tXDyqcQ/KC59AntJx7h/iSnQV6nEsKrfFc8cQkK19fSv+H1gPLsbUD9CMlbqwtKXl0lMtugJ0Qa49j1nj669qpgl29GXFuc1uqeX1Ph8qaKNplFBhQoOKx0ZExj3HoJi8ESKIZSzl2DsIKpneNNxeJ5EBuang+MrmtsalJOVk6ZrgC2yUR/+dG+MxLr5eMoOiB9avZpsmUssrgYMTpIIERMcjL8sXDIbhTcV1xgxNcY=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:KS2FnhFHm7xx6uwGoiibIP/EIt3aXUOP/HgUN9pLjakRAvKPZX3FRqt9nipRS49bV3z8KtFnM7tb547nMkkPIxDfFHXlpLlM5unH7bdZYgn9irycxHS5BdUyeGaBWjBNZJgUKUgYQ/vbR5M3nyi9tTFzRx9yIAuS86dIcZslclF2RqQHhvGzSnpJh7kgW/VoWQMcL6XBL+BTA04jpDou3BErDyXHkWUUH1iWpKkRWMGhOxTLmGPCNhGyNyCQPOz14PuwyeYFCGFxQvK0zgnK95NsMIMpU4Eai7DzKqw2GMuhAsngq0Fq/Xr0Ssfo1vSed5AfVqhdLUIXRqsbSuxy2VRAearIR7NOMSvNb1r4X/ZuCgTdtp6SZFa1HJzTt2N0pXKiNup2xqe7sz+13ZZrm8fJlNEc9W8oaPudEr5XBcBU782Lnh4RPP4t5CeNTZqZgwHb27ctsIGw9n/mNgk6QyEwB0l8pIKrsmStz3xibAf4CHy7Gotx92vvMTvpWywF;4:oLoN14Z6s4nzqXrnk/t/R7v2+R0AKyA0k9poE9te+pXDSvfOsaBH4qICefglQ9TT7p0P+3zKKeti3isgUf+OgsjdgyXG9pT8gllxqbs9U1fOtlPKze0QSvmDgRv5WxAZ1DKW8yM8c8AaZVbLM82nwF8t+jheTlKGCu282j537FTZgkD7bqNu5uvAS5rkuqOD0aBxfqPbk5yNMs+Dl7fB9WCZIJLA7UMf9fwb1gA1nrgZaJyc+qKW7Zb4o531doF82SIdG2CJRokk6yBtIz+3sHc1aOscArgjwTL59OcKz6/GcfI83UuVFRxJSp2S5AZLjLNPqPyQXNT+fAbiJ78h6A==
X-Microsoft-Antispam-PRVS: <MWHPR12MB191779C7CC49AA4D43E1F050F8C10@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(72206003)(2351001)(105586002)(386003)(16526019)(478600001)(86362001)(59450400001)(25786009)(50466002)(6486002)(97736004)(36756003)(48376002)(53416004)(66066001)(106356001)(68736007)(51416003)(50226002)(47776003)(7736002)(305945005)(3846002)(6116002)(53936002)(6666003)(2950100002)(6916009)(76176011)(5660300001)(1076002)(8936002)(52116002)(7696005)(2906002)(6306002)(2361001)(8676002)(316002)(81156014)(81166006)(26005)(186003)(4326008)(16586007)(966005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:GOIhNdqimOhNpwCko3UICmrot5/4oLM9jO0tdvPv9?=
 =?us-ascii?Q?LRkHgoCnHUOfMEK1qER/i9qE/F/+I3TjQfMIZTqIEcEzAxZ+cLI0ldaoFQfU?=
 =?us-ascii?Q?JGNEkwbVSS5AN+4bFmpvOTKVd28sVPTIiuyZs0/HkWL8PBfRJd5aPDOMB56N?=
 =?us-ascii?Q?FBFpW0BC3Tb94KVbh32LFjMJnImDb3YiSGVmfPm/G2mV0C671RDejdDfkBj3?=
 =?us-ascii?Q?9RK7IG/SFXaBy1xvDH+3rWGWzExSxxRTbX9FpWJchMwpfYCxejxAge+GlEJZ?=
 =?us-ascii?Q?JdgSByptI2CDq7GjiLNPC6kyWz2QIALCnDW87hr1LMMYf5TxZPGUWI5zbje/?=
 =?us-ascii?Q?WWnltC8V0mx46tVRt1u1A3/TNHWTfMcBHqlBKii7/cZZ+UUna4l0t66Dqvs7?=
 =?us-ascii?Q?gKp6OZ0Mg45ttqpxZruurzrogbK2ArZMUvufN4gjmtBFHsJITK2rFGtf7JMy?=
 =?us-ascii?Q?WJfhXN0wlvBktJSxDSoy0+r2RW6Rh5hhvgxPR+xNLCqLVMyQDNBYhENRmKY9?=
 =?us-ascii?Q?5IvbIdYP/G7X+CzXo7s76k/gKqn+wHkCsztOJdWgmYfE5x5AS9TYZR0VtAci?=
 =?us-ascii?Q?47kMtiYzE0lYlGx/QOSczNpcoK2i61aXRhMVoMUBthq57Bhgfubb7tPUn4dt?=
 =?us-ascii?Q?zY67WXOWzmmZVbR91u8kBN0aRxd72N8mK2VUDll8FrV79J1qDX08rpgE1+aN?=
 =?us-ascii?Q?XtIDh3Z0EXxyRY4oJjDObzBSg9E5hKYk5hNGKWzYSx64q2wl5bPTJ7rYttQs?=
 =?us-ascii?Q?rTVKpOO6IsniiZXmx+0IerVY2lUnQLe3LkinnkNib/GT7a+H7LWx92i+D3/j?=
 =?us-ascii?Q?pFCylOnAhPvsa8vp+NYbEkDSRXikP739PhByjcNW7EPO2SVjeQTLT0108Zzt?=
 =?us-ascii?Q?+c4XeGn/rsMczBLrU3mHVgXmvb8x4WfgBi8NHAIPq99P3cIqFpAbLX+Min8c?=
 =?us-ascii?Q?7rOzXHU25Ju+e0XRp2zT8TmSpm2wUz6BgRk61tq4OPOSP7RFMf7cAMpAMPce?=
 =?us-ascii?Q?3MOZ0ft//BRBp15NFTH/O7Sg2ZdweZhkLvBQHeHGqm/eikoJtc9RVHdqR3RI?=
 =?us-ascii?Q?iTckifA6RJ8X0wIbHxrlRwV0TUlGfNsMQ4DD+Z2cOC9ddtw5MPE/0z3NGcON?=
 =?us-ascii?Q?GLd7TzRBV/LJhxS1USoP0PENfjn4+rjGrcI/dZe2vU3KCqKVBiiaObdD4/07?=
 =?us-ascii?Q?hQzrz4Bez1W1AxrlBeN1IR+65UYsqYQH4zAAt4sLdtKwSfi6BLdosy6gb9K+?=
 =?us-ascii?Q?1G+eeGAp92+COrUmp5pULkvL7ZWA4PSWFtDjTfH2f8CviTbmBsKFH7HEomlB?=
 =?us-ascii?Q?CTWcg1lQMU75jyqOG5K6BQpgTjzuQrpFKmULoNs7HRI?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:JyjZXvWeQaBbwWWOqJ4kj+/gxQVXB5FK82nAhg9zVv/E7YzvEIgHKsmTWM5myVsR1pMndUPi9uJjtvpaZ+5kTC2UkRiLM7EnjxXpshV1JS4qbk/Pmms76l71SSCHk+2lzX5V1jwLdL9zR4qnYH5AaWjUN1J+0idzm8Ni0E4An7dF4F/hkYyAQRSqVkY3P5tAkvVgHW1POYVb8PvAAKszY/OYKqmWksfBWRV0w0sNYAdo8DWc8/8nQ7I124OpwtMLb4JzuZrFqlF2xn/GSu5Fv/NpDOY5fKYiRe6C7jk/Scb/l2Gq1u4NtkID9954wOeNA6APMxex14EYYRiaeUtEmaY/oZWuBeXW2SRl6CK/uXE=;5:0GY273ADTEsYCfzuhUz8xFo696p7rINLMpcLjjKM49QWSutF2j7T9cw9Jk4ODXcWYlU/IXBKfNZ1ETTzi6UH1Gl7N7zjVjZrg0lXr8hSfqBD3MtGziU1zMwD6phTHRnocR4nj0ZuUchSlrNJPEOZR6APBs3quXg87y6US0FcUWQ=;24:OAsSw2keO4BJHsk4/dqvv4sjA4dFy3gc4bIamfIYQvD14RXKaIQYpsjgiNQnT+f00m3r+TwNvecsZr+xen5Ky2a8+WywfCCEpK1dwgvhW8o=;7:KU/rYY9vQCkwiLAlcyGiiAjHCk28rXO9O+r3S0vqzzY/Dm5Z/VvdUe67DaJ4WG5v0gYfPG34nkqUDStXrmRLakvCa6zPXE3EcN7+76CEcyT0MZMWtgtOF2dFRuBQQoNXrAkg+CGc5ETI7UmWOZitv8vmxDTrVrCDH17AY/lJoBkwuFvMdjxd7nZtZgeglVb5tkWNn3C40HOZxKb+4NzlB46jdk1Ukowq/8HZHVg7HhUvbcZ9kzRRJJo8/jYn8+Fz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:MXN9LzCHowSxQrcOFTS9LHTXB/j9LuBN/OKtMCALyRcKm8xecKzcc84yeewq2mxgPvexajA9zfLydRx86YMnOqph/3T3VCPrzkzCnlUfAd0F3RPk5uoRoc23WkjB5X0gpPLroTdYo5hVPjmqJ23J7Y+YUBLToJJ6lxo393u00kMvddxdFOIG6rHyGBPCmYnuShTcNirkXFYm9JBFZCv/RwXjyOJDUV0KTFCrFiaVKPfGl4s/eNPK0VuZJb7lodQ3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 19:39:29.7461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f92d21-e5b9-4a2c-86ac-08d57d50a7be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Print the common fields of the Cache, TLB, and Bus check structures.The
fields of these three check types are the same except for a few more
fields in the Bus check structure. The remaining Bus check structure
fields will be decoded in a following patch.

Based on UEFI 2.7,
Table 257. IA32/X64 Cache Check Structure
Table 258. IA32/X64 TLB Check Structure
Table 259. IA32/X64 Bus Check Structure

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180223200333.6410-6-Yazen.Ghannam@amd.com

v1->v2:
* Add parantheses around "check" expression in macro.
* Change use of enum type to u8.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 101 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 037986ca82dd..24f62e78b6c7 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -32,6 +32,25 @@
 #define INFO_VALID_RESPONDER_ID		BIT_ULL(3)
 #define INFO_VALID_IP			BIT_ULL(4)
 
+#define CHECK_VALID_TRANS_TYPE		BIT_ULL(0)
+#define CHECK_VALID_OPERATION		BIT_ULL(1)
+#define CHECK_VALID_LEVEL		BIT_ULL(2)
+#define CHECK_VALID_PCC			BIT_ULL(3)
+#define CHECK_VALID_UNCORRECTED		BIT_ULL(4)
+#define CHECK_VALID_PRECISE_IP		BIT_ULL(5)
+#define CHECK_VALID_RESTARTABLE_IP	BIT_ULL(6)
+#define CHECK_VALID_OVERFLOW		BIT_ULL(7)
+
+#define CHECK_VALID_BITS(check)		(((check) & GENMASK_ULL(15, 0)))
+#define CHECK_TRANS_TYPE(check)		(((check) & GENMASK_ULL(17, 16)) >> 16)
+#define CHECK_OPERATION(check)		(((check) & GENMASK_ULL(21, 18)) >> 18)
+#define CHECK_LEVEL(check)		(((check) & GENMASK_ULL(24, 22)) >> 22)
+#define CHECK_PCC			BIT_ULL(25)
+#define CHECK_UNCORRECTED		BIT_ULL(26)
+#define CHECK_PRECISE_IP		BIT_ULL(27)
+#define CHECK_RESTARTABLE_IP		BIT_ULL(28)
+#define CHECK_OVERFLOW			BIT_ULL(29)
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -54,11 +73,83 @@ static enum err_types cper_get_err_type(const guid_t *err_type)
 		return N_ERR_TYPES;
 }
 
+static const char * const ia_check_trans_type_strs[] = {
+	"Instruction",
+	"Data Access",
+	"Generic",
+};
+
+static const char * const ia_check_op_strs[] = {
+	"generic error",
+	"generic read",
+	"generic write",
+	"data read",
+	"data write",
+	"instruction fetch",
+	"prefetch",
+	"eviction",
+	"snoop",
+};
+
+static inline void print_bool(char *str, const char *pfx, u64 check, u64 bit)
+{
+	printk("%s%s: %s\n", pfx, str, (check & bit) ? "true" : "false");
+}
+
+static void print_err_info(const char *pfx, u8 err_type, u64 check)
+{
+	u16 validation_bits = CHECK_VALID_BITS(check);
+
+	printk("%sValidation Bits: 0x%04x\n", pfx, validation_bits);
+
+	if (err_type == ERR_TYPE_MS)
+		return;
+
+	if (validation_bits & CHECK_VALID_TRANS_TYPE) {
+		u8 trans_type = CHECK_TRANS_TYPE(check);
+
+		printk("%sTransaction Type: %u, %s\n", pfx, trans_type,
+		       trans_type < ARRAY_SIZE(ia_check_trans_type_strs) ?
+		       ia_check_trans_type_strs[trans_type] : "unknown");
+	}
+
+	if (validation_bits & CHECK_VALID_OPERATION) {
+		u8 op = CHECK_OPERATION(check);
+
+		/*
+		 * CACHE has more operation types than TLB or BUS, though the
+		 * name and the order are the same.
+		 */
+		u8 max_ops = (err_type == ERR_TYPE_CACHE) ? 9 : 7;
+
+		printk("%sOperation: %u, %s\n", pfx, op,
+		       op < max_ops ? ia_check_op_strs[op] : "unknown");
+	}
+
+	if (validation_bits & CHECK_VALID_LEVEL)
+		printk("%sLevel: %llu\n", pfx, CHECK_LEVEL(check));
+
+	if (validation_bits & CHECK_VALID_PCC)
+		print_bool("Processor Context Corrupt", pfx, check, CHECK_PCC);
+
+	if (validation_bits & CHECK_VALID_UNCORRECTED)
+		print_bool("Uncorrected", pfx, check, CHECK_UNCORRECTED);
+
+	if (validation_bits & CHECK_VALID_PRECISE_IP)
+		print_bool("Precise IP", pfx, check, CHECK_PRECISE_IP);
+
+	if (validation_bits & CHECK_VALID_RESTARTABLE_IP)
+		print_bool("Restartable IP", pfx, check, CHECK_RESTARTABLE_IP);
+
+	if (validation_bits & CHECK_VALID_OVERFLOW)
+		print_bool("Overflow", pfx, check, CHECK_OVERFLOW);
+}
+
 void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
 	int i;
 	struct cper_ia_err_info *err_info;
-	char newpfx[64];
+	char newpfx[64], infopfx[64];
 	u8 err_type;
 
 	printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
@@ -92,6 +183,14 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
 			printk("%sCheck Information: 0x%016llx\n", newpfx,
 			       err_info->check_info);
+
+			if (err_type < N_ERR_TYPES) {
+				snprintf(infopfx, sizeof(infopfx), "%s%s",
+					 newpfx, INDENT_SP);
+
+				print_err_info(infopfx, err_type,
+					       err_info->check_info);
+			}
 		}
 
 		if (err_info->validation_bits & INFO_VALID_TARGET_ID) {
-- 
2.14.1
