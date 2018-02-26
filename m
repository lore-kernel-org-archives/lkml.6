Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeBZTjk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:39:40 -0500
Received: from mail-by2nam03on0053.outbound.protection.outlook.com ([104.47.42.53]:36592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751521AbeBZTjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:39:35 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH v2 6/8] efi: Decode additional IA32/X64 Bus Check fields
Date: Mon, 26 Feb 2018 13:39:02 -0600
Message-Id: <20180226193904.20532-7-Yazen.Ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0300dbaf-aeac-4f65-bf8f-08d57d50a97e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:vI5zuNAytdJ395n0Np0zuYTLga3kM7yqtlIeCDUutGstaWCPSAnWg8YvvaDLhu47hV1ITDH0MCad7tjvIpEI3GUsXEz6Ez4SqLHH2wh/waNd9pDL3EpVWiaigyUYIyD+mONPvP41hi1cFtGxGCJSF678Na+g6UTIhYJaZrkJ1eGiZX7cGwNvTspeAA5oWRQihbetFf1tbnVr2nKyuENrVxr5/aQjDp5DOvGiZqWIaHul8cRYkRS/qqM1EOfOkLzT;25:xGGB9iIO3P2CiwtfgRLg28RDzFnHUpOwkiRsC1LQs7qdcJuZVpHbOvYmG2qgye73lk5Z9KBnrvcbkL7asBXvvTh7wBEfOCN2Cudht4FGw9Mcov7kD/dDW44Tu5aQD5/h2pKFt0lZULw5PnuvzLIShah1888uPFwdeq3jL97+8/OdeYnU6XOO8x3+p3d6ZHNMxVlf/XzNO9VR1jrEteygYcC8fTjAKWBn3up7kIOc6rLxqVDiLT3tUlId3ZWj+Po2JWqcnRP9uOGOI5VeJGLMVsDQ0z0ZkluwElwjsgOO3KX1kta9QjHJZ9RzohpIuY8NKIjhp1dNf390HzNdQYMcFA==;31:RlaCc2sJnK8qBS+LysiQAD2eRDQec8FtKPCjYDjTAr8g2Vs4Zqjo/Vc8iFkSnMToIHpBXZNtU0Y7awqVgnLF6OYgHXRLx3RkUrE1Tlh6IXNweYNkf4dX+EXu2pFq7XswubXOpRmf4N7i/gpSU9iO0SbIwMty6dTCAQZoaJ8OOk8P5CXLUI9VkF6IMUh7217SEYA+P0P9MrcsT0QK34OliTj+DGOcgXiSDB1C3z5B6V4=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:Z3D0xeY6uAX8+ehKB1h+NC11Bv4K707ZC+DHVRcn7FOdrhsqLNr/wyiHxD4MbEzTLi/YgOb7PJpujcn5qsK13g3vbSswYBOnx17Hl3cGoR8qNDGRINQTUV//IB+fOq4X6qiKriinJX/OJVzQ/b1So/9+TaaDa7+985smb+EI5b3ICxupoL1jHkGqQilgFd1uNG1i82xBs9rLlGCEjz9qa9RYIHCl58ILzwQWK6iNvkr93lg3bFkK+b2rV3hfR2dMYtrWAHndzR/32/iZzlbKTNSVCIvUNEcseP4iSKTL5KdswKQf4nrbmiEoCt484xkVvhkk+AmWIafxxyf8pMY6ZJd0iqSNlOkTCHbDFGGeLnjcdM0YItIjJYC+RrZGXV9xsUcVbjr0TnR+bk/vUxE21JOOcUE+fp5NmvxddAMRcPgytkMoQV8/wQHZqMclvYisNrg2uzVST8dLejlA/ATYAAK7tCjRNM008V9fFLE3S6rNiL3nfDvhUIpvu+wKwew4;4:e1xOqIVH1L7eBbXXOPf7Iq0Tsc8JNvGbjQhJR8rKyae79WmncKEvXAxxawQG1Xkdixs3QiLrFpCM3PF2HTBOf9gf0hO07ZP5mQLDpQLzfBDW7SVEE804N0ARW7CQuQ8jKZ5GRV8zGZ8vPdig9howVwjW0LT68CwwBsFVv1t4x8eT9EVOIvaNgz0kXcqrGXxsV4MrpGaABwRk24ptPQYLeMPKBkyUD81G9sZKJ2Sgn5hbR+y9/p+RdSRQMlLq+uGeAoPQknGBU/f5xUlHIRCXqXjReGxWJGFxRL/3i+Ibn9wvEM5oSL4wawCbFOCm11tXlSStfzX2GZNsP56113XDkg==
X-Microsoft-Antispam-PRVS: <MWHPR12MB19173CB6E9AC6470180A664AF8C10@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(72206003)(2351001)(105586002)(386003)(551934003)(16526019)(478600001)(86362001)(59450400001)(25786009)(50466002)(6486002)(97736004)(36756003)(48376002)(53416004)(66066001)(106356001)(68736007)(51416003)(50226002)(47776003)(7736002)(305945005)(3846002)(6116002)(53936002)(6666003)(2950100002)(6916009)(76176011)(5660300001)(1076002)(8936002)(52116002)(7696005)(2906002)(6306002)(2361001)(8676002)(316002)(81156014)(81166006)(26005)(186003)(4326008)(16586007)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:SwSaYkgoisOJhRGJ4ij5ITkNxCPCAGtmmA/V17q/m?=
 =?us-ascii?Q?zLl9gwzz9pDKXZlwcEMtAuPlFT8MT8jKMXzCfJnocbjSpa0pOEhyFtefh3BM?=
 =?us-ascii?Q?olF4PHvnUq7/bYV8ZyRZWFHv0+UELdku+PxtepovQB5HI6rJ84+8bFbubuNf?=
 =?us-ascii?Q?kXnEEgCicsLZUXLj1PjxeuNJwgBDODEsCaj8dQ1D5y6NfK5/fNrcaCJL/7GZ?=
 =?us-ascii?Q?jPrRAM+RxHBeslRfdjdDt8qWrVnAxrh7vyyM21Nd6QXYZPlwgrtamlxowc3N?=
 =?us-ascii?Q?8gPcrnCmd0RibTsbDBWOZ3NZsffqfBK0vJiBtMedci+E5xVXotMRDvUX1hBM?=
 =?us-ascii?Q?XY7p4+d5xpexSOJVBd3mA4zIjysPfFZ9itQzUFQubY6hv6D5q4nvZg9CUMpf?=
 =?us-ascii?Q?ZkWwJ8fWu6TJHM90kmyL1ufCFW8YgyynRPQzZjGds4/YFl33/U9cwIPar1+5?=
 =?us-ascii?Q?XUCovmNhXT6s9nC5HO5c7x4BOgMc683PJWTgkj0DDpk/vL8WikzfHDNl0H8C?=
 =?us-ascii?Q?E+lGUpDG9hLf6ov789XoIUqPX0br74k15pjef2fKdhvnomxxYGLlfnF0WeZQ?=
 =?us-ascii?Q?tbbV8qoD0Fz/ykB17b1BVcE+EwxtsPMlmflaupBrTAqxRw/abL/gayL7l9wZ?=
 =?us-ascii?Q?c8VC1hgX/FedXJtiWNRq+L4VfNePfQOd/puMm3Is9m9J4bIOIF4uU0tzZTFe?=
 =?us-ascii?Q?vTmlIIkAyDmF9hjK4Zwj3xmuWB+JmWLK+3dFkYcdrxsUwTFJHs3d5uugfXyL?=
 =?us-ascii?Q?qPtu2raaO8w87lJhK7IWEPW/a4EciqRQp1Rkdlw8XaddzpIP12VTCGHSr2S8?=
 =?us-ascii?Q?whn3BFk6vubzGEtZojiZ32vfDbadPopG4mMkmnMUGkpuEIAnnA894+zm0gpR?=
 =?us-ascii?Q?whFMvkMYWR1jgw34m9kRn43kf2Or1k2Bg6WMfWpmm5j+r8kt0ArNP05iWUmd?=
 =?us-ascii?Q?ef59TGnFhwst1JO8YJ4h+Usqms7tzYsIeZLf9CdW5hbAPukOhFPD8YsYSi1d?=
 =?us-ascii?Q?dhK66vIBwSoBkoNJnfAK7h8UkzH4zPqdWI6ipjhL82HJG0nV0TKhxuLWiZuw?=
 =?us-ascii?Q?ccOJewgqVUZjVNyP9YaQKn8x5G4Ou0xTlw8cbVsuNteLEH7mIuUr3GFRrXhY?=
 =?us-ascii?Q?eozss7RnsyXGgFeYoihe9zznYxxaOtl21WJHzADZlR6Hpngkhle+g/YyKumx?=
 =?us-ascii?Q?Xx3tSV2FqtWuDDPU3ot/H386MGtn8MbqlYG9hO09BhRYOSeo4Jh8d+dip7I3?=
 =?us-ascii?Q?V0ctKcg+fkNVBR9EC5QCcyU8Jl6dMEzA8k4Ukxm?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:I4WKaZmvcy0YNv6ksY8l3Tsiv9CT+5YXsucrHv+OmlexRvFAjIkHOB0Q4gFzSqbHXYvSrf7T98+Sy199HAWrmO+DpXrglSrZ/st7p9XWRTZaNoo8GL8Qz0Ple9TjfuLhf/KPzzew8j0rI10HtTSCUOgcrRAZ1fWgyVlik5Ha8YH1nsCNOBejSNjyYEuAxcMnxx65Lw1PmI3mu7V26nOBoNnmqP0ZkJVVP+Q11pahBKm6qjlJZANUqyBNLV3QUaL8vKtGbTIiU5XZQGGtDYswONJqBjccksWi8XniEPHAFZFOo1JOrtUMvzTnQxvCyC8ilPz/ovXH7ACeWPyrusLETKbn74F2Hd8Pjtp4B/sDvXk=;5:nRHtB0p5/bjJVd2cQN9XRvVVniq1IPKqHUIxGZEL9sWnl96T87NaBDrtrxBKSUhp4Ilm35lyQUCwCDw7Fb6Lo6VTKHnlgu1DNf74QzU2LmzMKRtjX3+Math2Ci5OD4IpAQ6xC8yWWxAtozQDU5fU6Nebq9lHvuLiHmt5sg4Bb0s=;24:fHhSi0EFzqFPbjGP9pZyfate8SYInJGprYJlLCdVj1CCNJueeR32YBlV5FmPTaH6006HwUzdTuXennuuot82f0hNqNS/htOmIEv9uKzK26s=;7:GHwKxq4DSmvmB4hMqD0zmASG3s+CD9LLq0cs/cx3yqMa3QW0T0v94T5qrPd1ochqxiuEJjtQrRkTYY1FG9cloqSe/fy04Ly0+KqvKRwtr4rEAV9OL/hNT98qZn2lqB/ziP8z/tnygBr1Ci9C9MwrfYdlalbWhjeKnvFAiTh+/joMvh1eiq/vDZEuyv+gSYXZQgli4AjY5Dsz2I/r5Y8xncgS52ZIHjrZv2Qj07CIOuWY7d7rqHND9cH5GZ8QpGxb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:wC7MlVFIQhTsu4m/dPYnYyKIve6sByBt+9CBEB4T7oljMVvgqpoXHa3Q2TdwTD1V1iqHFifrF8Q43Ng0/omIDCXvzLRxSRG8HSzVkZtmHSHNX81vLYlhXwfAtuyuM9DuB5kHYXjXwV4h7N0Wdrb/ebSUvCxAaWdHeM8E12LWAete392bRxwCQFJkfMwZUg8InkibBVsV0OQ1Ry8iStgvhjgQFRf49sbmpUsvdHs/1QEsKIxfJkLtOpTYi0uEE/uj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 19:39:31.1680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0300dbaf-aeac-4f65-bf8f-08d57d50a97e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The "Participation Type", "Time Out", and "Address Space" fields are
unique to the IA32/X64 Bus Check structure. Print these fields.

Based on UEFI 2.7 Table 259. IA32/X64 Bus Check Structure

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180223200333.6410-7-Yazen.Ghannam@amd.com

v1->v2:
* Add parantheses around "check" expression in macro.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 24f62e78b6c7..c5209af3514b 100644
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
@@ -143,6 +165,28 @@ static void print_err_info(const char *pfx, u8 err_type, u64 check)
 
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
