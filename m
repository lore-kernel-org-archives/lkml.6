Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeCXSuy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 14:50:54 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:57948
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752785AbeCXSuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 14:50:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org, bp@suse.de,
        tony.luck@intel.com
Subject: [PATCH v3 6/8] efi: Decode additional IA32/X64 Bus Check fields
Date: Sat, 24 Mar 2018 13:49:38 -0500
Message-Id: <20180324184940.19762-7-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
References: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:404:13f::22) To MWHPR12MB1919.namprd12.prod.outlook.com
 (2603:10b6:300:114::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4bdbde0-9ac4-419e-c7cd-08d591b80f7a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1919;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;3:ShTpEe5dUrQoRGGCa/B/AifD7BcQOzsoAVAtDnUfbSrRdQ2KwNSNq7S8DvzeWd5Rs1TwptPbflB920Z/I/QQlsMyAFQjHKyU4f/knnZ/Pyf2B/SiHp5qef3e/4HTCOy6o4mXC9TpqAiCVVVqZPiNNsNTpl29TCsxD41TlnRXG5/uaYuulZ0r0gcibDv9WqDIKV6tEwJ/lBIUieFtcPP/pV2zodUlLOWC8BJvSNuwC0H1oJx/bK++RHgpU0qFo4pa;25:nyyi/2SC/xmHlRrRpGvDFqvZJk4LjBML92I0YL2zyLrMtSwuTA+G0gkLdw2GAEb9izODlAFBgXw4ZGSE7OFqwDK+tk7orvSJ1713llsoEBX/CE4nK7v4N6ltRMDnEWnZ6QKuespBgkOz/wPeYBWYgLtf5dfNokQVh0o3tWn6dYC1j35I3Va9HTdtHcSzPaTs0Ta3sTVpOAb47zdUeK7X7JXJFe2DXI33ORjlou/n/x0mfVgZisJ9hY7trYtweJn7K3m/f+MkdzzpKRvhXtA07r5xpQNP86FyZlRkaBimFzAxyw3dmXIu3WdULc+TLwPtgzt7xAo3ClFAua778cHaZQ==;31:vVq1cmFCpjpMwDuqTEtmGsz0UKPKu97ScaFB2FVGoC69tXVIwwUF4QgtlRyHNTn3/KIOO5rTJh0hNvwfxQNPQgGONj1M9nAb2ZMSaHls7ShdqyqVjUIjXTLbau+3nMEajIS+tVMSKJo03ntZt1pbLhXJSwQSgeeD+C5kbszRd5Pf/JkCyV4ENoZVqN2r0c9QMvFwCwNmslgd5F7T9wd1bXAR6C/Eyscupd+83G88OKI=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1919:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;20:jBsUIl/pJIuVQRfDUM/3alVdcRDN5AuhI9l+zbRdg320PpTbx/yfDuTswvLdPFYt+L1kmxA0TTpe6l4v5x1DG35NBUpas80a9ZNzUfXGqbAknBNdc3KMk/hSQ2Ub1Plj7IBLeachvoAzG0WCJiC40HCCX8lc0oH2vtbNf7gRkU52Mz0jXpzlZEYyaMSkJammUSvexaK10CU/65AbUl+dqbzyQNUeIYdFEi/iZyOtuluxvjM39yhTY7WWGCCGnYCYnrMw67r2TU/JIi6BXbujgNQn8qaspxrChrbXbdvaFl2l+U7EIYV8/zczWpRpkS7TjDfYxKVh/+er6P9q6gLVN5Kq5s5ssqMUKWA3sGPQAuBReXWoYYQfihxYyVgto5aLi9toAJdmrDeS40uh0mpWQIXL6me77rUPuMjGMs+mxfPNaLZnDN2aJDO8ZC0zix/zGh2rUHefFkLMNiIne3rxAizfsZBo1JkEqwUAJCVvZGWwQAKFn9v21Ytu3qzHl/Lt;4:BS1IRh5BHTdK6Ws3nu+iA5RCwuTQpVoZ9Z7XqFn060rJrh5rIcpqUD9JUHtr3Qg98UlfyNMar03tlRqgup00fOk6fj6zuvTQHQmPlguR1WKcZ6WuKph9BDIjWdMOgKUxbtvPavL7hLK89ah8Ct3+f0ZiPxLtjMdkMw37y2MXeWzMIpDoHX67t8aGOeb6CyjTh4BNgMCKC6U64jJ8bZ5CbTQZhTj9DxDGsifBE/BLB22nY40DORcGHk/F4t01+DhkUc2q7Im1seDK/9SclJhZ7tisLTORbEgTmZwIMKbb7XuxrHteuSfMP35DbfOFcCupR9RO8jZlK10e85L0POYEA7rMX6BxLW3+h90wdr+yN3Y=
X-Microsoft-Antispam-PRVS: <MWHPR12MB191998CF29F45CD4C4D813C9F8AF0@MWHPR12MB1919.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1919;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1919;
X-Forefront-PRVS: 0621E7E436
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(39380400002)(199004)(189003)(2351001)(2906002)(66066001)(36756003)(52116002)(316002)(4326008)(51416003)(25786009)(7696005)(53416004)(97736004)(5660300001)(106356001)(16586007)(76176011)(68736007)(59450400001)(11346002)(551934003)(2616005)(386003)(956004)(7736002)(86362001)(47776003)(305945005)(446003)(966005)(186003)(2361001)(48376002)(72206003)(53936002)(1076002)(6116002)(6306002)(3846002)(16526019)(26005)(6486002)(50466002)(105586002)(81156014)(6916009)(8676002)(478600001)(50226002)(8936002)(81166006)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1919;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1919;23:lFXa9g+ZTm7qE+ZYq9GQ4syPXfaY1Zmu1Z2hMWrx/?=
 =?us-ascii?Q?ynhTZWuUYjsD9wdsceP8FK3WKIb+jdgQTdZYxxPLbdQVgxJvXcouYaM1xRgi?=
 =?us-ascii?Q?Ey9YOIiL7qpCH3cp7M85MWUai34pfFSf6Hn3SdhiqMGDEOtdi1E+BDQCUwI1?=
 =?us-ascii?Q?YTLdYdhIgd3MuAFvPvDEptp82KLxhb1CXuWuHCTbIOrTl5Byrur/27+34EyN?=
 =?us-ascii?Q?iRFkewH4en2t1T98nhTreLQ5hR7DxEYw8/cw8BEgFF+AN0xIO1IGoeTioKXJ?=
 =?us-ascii?Q?IF/LJwXYWvShFnVxXuQBOzzaWM5cUQqghCYhV3PFwMD3P0L9xuHwOV0wg+J0?=
 =?us-ascii?Q?6WlAea50KrJLO/cuZU38a/lvJyKub2UVDTyL1v5X+nJ8ywKLyddk7/LD9A4m?=
 =?us-ascii?Q?1TUWlsmIWvabDe9v+wCou4Vt+1la8w5j3Cmz5eLMU8Bu4sa5+oYd27xJmFXu?=
 =?us-ascii?Q?9SFQUvzwcOxnyNTsfpBispGvudvgJTmZpbqQ5or6QKWZlb8EbmS2iHoQ8sF6?=
 =?us-ascii?Q?rgwEHe7bK715avZwbeQjSnLlqe8g/e3OvWnabpk5z2jCrPYZRQfV+002tOcF?=
 =?us-ascii?Q?ZHr61eS7iI7E2TJxyarghXayuY8YZAn95A+39ATuqtoOBfAooeX540TzrLOk?=
 =?us-ascii?Q?B7Hf/TScRhCMSk0PHrEwxaBf2YLZqDWluOlaS311Pq+bnqDH3N0DXPUlZFlf?=
 =?us-ascii?Q?GhkrGLyVt38K/qzJF6Nq5t90fwWXK+QHJ6afNObV0cnShL8bAFJWZsjIa4NY?=
 =?us-ascii?Q?FNmDD//AveFKmDrGunqlkumjF/lTTVqHrAGmxCLBKRSBKGYlEiBs4bhQQOdJ?=
 =?us-ascii?Q?nWmEAybQO9gGma5ftMc9LKvOzcqSO4V442HA2eWUXeGA7musGV3hxEdlKzVi?=
 =?us-ascii?Q?1hGEypM6baVUsNUCP7Z4skdO7bGW30S1lxevh/8QBdb3AqtJ3EHdUdmXEkkI?=
 =?us-ascii?Q?rk/QeF5wtZQDWtTF9onxPtlPl9Pj4O79sOvrivsb7CB95l7RctD9UekTGWLu?=
 =?us-ascii?Q?RcLSv55fLV6ZJLZ2qk3aJEZiy7v8VwLxOBhkx+ePJZgSbbL+hOp8SX+6uf9N?=
 =?us-ascii?Q?jQSN0CoFQ5583BnILg/S23eUA39pupPtwPXvvK5gEZElwUzr5vbwnGPbZyd7?=
 =?us-ascii?Q?tHqsdvqvrOn1ys4uD06sPWiVaeUc6DsCLdYp4s1SoqWiAJV0FgK5hGKHK25a?=
 =?us-ascii?Q?QkvyQqJQ8VaaK3K9eBKD8gEUJfRvKVa5W5vBYiVtoOriNeYJhxvsgztc1Q4h?=
 =?us-ascii?Q?xRrSo4BZenrZ8CTqPmoGM00fka1RdMBcJe0y8VG6jD43M2fRwLMW/C+FGR4O?=
 =?us-ascii?Q?8xApyLGZ4d5BzF0ZpgT9io=3D?=
X-Microsoft-Antispam-Message-Info: KPyCv9bidVmStHA8Q7KKD2E+88Gdj6rt7ymatb43wp1n+SQFERCUbVcwyhZxDrxJifkO5SjbyXEGWN6Umipsxq41tBSWp/9Ho3MbmbIBqx2yhkYatmPlGp8kGNvoS6eYwxOCrmSLg9cUX3elHkOTtmO4fF4lfAKuHEc87Zbq6KlZB+aW14VLq/pBYW5wTyHf
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;6:GJ9BPmJfzEk7qSiboWbfkCD8oWqCnJNeS8n5umD3G1npZwgQ/isfk+96erCcQDWZTb8H2Uy0gaFgvig5o5hPxtLRY6G7CSJvTLbMSLXgobd/6iV+2k2agYCxwCroA8XEfgnM/LOjPWC1u06tZS9vvL264LQ0tiRlSZE0wjg1KxmskebeEBPgPbe/Uu2YAh2H9FApws4+A24z/h/U0ItP5/YWwFXZNL7jvee70Wtr/2mlAsqLMvObTa9dT4NYTjcQ2iRyfNgfNXa5W3eCpJwXwNsVtpH7JuuUBXpMcHg+qfrHr/4B6BZwBZbwItEOqsKeiTH7n0AwntbNgn9BSt/eQyWNLgV0f2O/dFC0JN3MziXKZ+IYM9FVP2NlYKeokYUzf0/LSVgx+iF/51d6wa+If2A8FbbBfsjaeUqmMHzxn3kaPhyh1wQeQdkApcgm7b0tp/Vm45OV36N+VMPY4Dkisw==;5:cttB9SMr8s/4xYkJ+oyG5SN+/2lYECIMwrlCDFmn4InE6Xe3UcA6Jm3ArgyowN+idYIdiWPZ5mRE1uao9gi4HhpOue5nN8l2ZZmwK1KwwKMoxV4ShUe5RwwaPA9xHu4erq5sts+4zH/BEYypAKPcxh7pwQjTOo+DbVsrFHKtarg=;24:MaVsCiFpKN31TUcV7d0dtlB859YETZWIB327fHxyQb0uvsCpUV9+JBY4GsfynjLvbgAEhJ/l5dA53+XqoprT13AOotHOBnPn6bteVqjNBWw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;7:VlCH2ymw//ztYYos0QcbiMVlCT2Avk+3WEnM8RPrsXyumFkovWHTOC1xuL2xX4JSgzkZW1MgTp+bDUfhC84fvxGrsM50PHVltoQMprc2DMEj3ioPAKMnSpzNldYN1/M84bU8S9WREDxLoAAVCb1gythnw5QJBYyGO/zq1UzpxsnYPx+EcHyUGAl+ueVg+R0HdH20PBAREJ3BtbIWdqmNVpL2mm/aZ5vmTt6Drir40Lq83jDGhILkd9+gzajAHuta;20:itZGY/+49sh3XA0EnHs6qLbEEnNPXX5uRmzpipIrl24/gmFvoyMti3eAufXRfcPne558OWAPWZ98mQoeoug5u4KnApfuwUUKYQnLqMcu7aU3pvNFeuH9+Au6JghSPRwILBrdx4mqa0wjABbvxOfYicJt+VknGn35U1WVzNuOZJhb0JxRVKpzZ6+8YvSqUTggZLbdmYQ4EDxFf5dJB+Z4PYl0f1/Gh6daI3a5Zw5/SvHD66VmIxjpIeZxLnhDgfcu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2018 18:50:05.1414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bdbde0-9ac4-419e-c7cd-08d591b80f7a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1919
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The "Participation Type", "Time Out", and "Address Space" fields are
unique to the IA32/X64 Bus Check structure. Print these fields.

Based on UEFI 2.7 Table 256. IA32/X64 Bus Check Structure

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180226193904.20532-7-Yazen.Ghannam@amd.com

v2->v3:
* Fix table number in commit message.

v1->v2:
* Add parantheses around "check" expression in macro.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 260e4bf7773c..54bd32d241b7 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -41,6 +41,10 @@
 #define CHECK_VALID_RESTARTABLE_IP	BIT_ULL(6)
 #define CHECK_VALID_OVERFLOW		BIT_ULL(7)
 
+#define CHECK_VALID_BUS_PART_TYPE	BIT_ULL(8)
+#define CHECK_VALID_BUS_TIME_OUT	BIT_ULL(9)
+#define CHECK_VALID_BUS_ADDR_SPACE	BIT_ULL(10)
+
 #define CHECK_VALID_BITS(check)		(((check) & GENMASK_ULL(15, 0)))
 #define CHECK_TRANS_TYPE(check)		(((check) & GENMASK_ULL(17, 16)) >> 16)
 #define CHECK_OPERATION(check)		(((check) & GENMASK_ULL(21, 18)) >> 18)
@@ -51,6 +55,10 @@
 #define CHECK_RESTARTABLE_IP		BIT_ULL(28)
 #define CHECK_OVERFLOW			BIT_ULL(29)
 
+#define CHECK_BUS_PART_TYPE(check)	(((check) & GENMASK_ULL(31, 30)) >> 30)
+#define CHECK_BUS_TIME_OUT		BIT_ULL(32)
+#define CHECK_BUS_ADDR_SPACE(check)	(((check) & GENMASK_ULL(34, 33)) >> 33)
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -91,6 +99,20 @@ static const char * const ia_check_op_strs[] = {
 	"snoop",
 };
 
+static const char * const ia_check_bus_part_type_strs[] = {
+	"Local Processor originated request",
+	"Local Processor responded to request",
+	"Local Processor observed",
+	"Generic",
+};
+
+static const char * const ia_check_bus_addr_space_strs[] = {
+	"Memory Access",
+	"Reserved",
+	"I/O",
+	"Other Transaction",
+};
+
 static inline void print_bool(char *str, const char *pfx, u64 check, u64 bit)
 {
 	printk("%s%s: %s\n", pfx, str, (check & bit) ? "true" : "false");
@@ -141,6 +163,28 @@ static void print_err_info(const char *pfx, u8 err_type, u64 check)
 
 	if (validation_bits & CHECK_VALID_OVERFLOW)
 		print_bool("Overflow", pfx, check, CHECK_OVERFLOW);
+
+	if (err_type != ERR_TYPE_BUS)
+		return;
+
+	if (validation_bits & CHECK_VALID_BUS_PART_TYPE) {
+		u8 part_type = CHECK_BUS_PART_TYPE(check);
+
+		printk("%sParticipation Type: %u, %s\n", pfx, part_type,
+		       part_type < ARRAY_SIZE(ia_check_bus_part_type_strs) ?
+		       ia_check_bus_part_type_strs[part_type] : "unknown");
+	}
+
+	if (validation_bits & CHECK_VALID_BUS_TIME_OUT)
+		print_bool("Time Out", pfx, check, CHECK_BUS_TIME_OUT);
+
+	if (validation_bits & CHECK_VALID_BUS_ADDR_SPACE) {
+		u8 addr_space = CHECK_BUS_ADDR_SPACE(check);
+
+		printk("%sAddress Space: %u, %s\n", pfx, addr_space,
+		       addr_space < ARRAY_SIZE(ia_check_bus_addr_space_strs) ?
+		       ia_check_bus_addr_space_strs[addr_space] : "unknown");
+	}
 }
 
 void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
-- 
2.14.1
