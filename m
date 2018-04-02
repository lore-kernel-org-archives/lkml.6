Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDBPHq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:07:46 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:48864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752472AbeDBPH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:07:27 -0400
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org,
        tony.luck@intel.com
Subject: [PATCH v4 6/8] efi: Decode additional IA32/X64 Bus Check fields
Date: Mon,  2 Apr 2018 10:06:54 -0500
Message-Id: <20180402150656.101022-7-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
References: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN7PR10CA0030.namprd10.prod.outlook.com (20.176.16.43) To
 BN6PR12MB1905.namprd12.prod.outlook.com (10.175.102.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06d56cd4-be2b-4432-cd3b-08d598ab6c4e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;3:Z49oTBD9WnxVvuc8idl1KpCV1XsT+Ess4KQYYph2m2lVURlXRWGmza4E4tL7fe5YKNXZK5Ajlq4zXlaJZMSv3H2/Hyb4XlHjQFMp7NCBzEu8YwyAl+ITy5fFj22W500hsM6tPyIAg33+d3er0LJX3g/5l246uBco8iw73S0eCr+FRej7bFw4cYXZDIvbpuv9IPC/6ymQe/4KsCM61b36peOAStpxSYGqse2Rn3a4Z2iaXl38/AFtspRoxr79yUDf;25:Vbd+4Df2AZArJ510HCk7eI3f5X7yMXZYxoeI6/jnSRKRpfSS7Nf04yXz+C76oifFPm5yaBZuYgXaswIx1/hiV2FXUVO2qMxv8Rh8nBU9YVeOQ4tHGB1F0v8vsWVkH9A7C0NTpw4t4BGGlYhQy1+X8oGyOYCq+StFs7qGiVNuAxwGdmLG6cbvqQYTRNo/Sfxmc2ZACFNfDGHKj2skDNnI7vHA05CCe1ILGWRnNb+U3u3xEWTcHMZvRs2qS8y0rpQHkvbXQQFuO2LjjEAqHrTPgllwq0g40oBnZAwu+CIqq3qsEXOdks3CDvj4CPFctqBjmyRjJmySKAGNdcwwGio7Rg==;31:2zuyubUwkNVpRvq/TLHnmNvX9h9VQ25gOBwcG2uiuux2Yf3KtxNedfPN9MxN7w/QfkV1MkU5iXBkoCCD5nTjy3+K+Sx+4jmya73y3aVXbaNVgYuKVgmdP0dVkbivP/8YtMZ+ObC17qmxm08oEgo1casH5c7D0TzYCQ4jrzpCoorK76v55cajRTHxlXLXUE65/uJmZN0EpkJ68J59YyLQLfgWuedhIwH7jQJRkp4A9X8=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;20:UqtkrddU+cu2aJHADdtaI+8/lIQjhFm4OLSxRa5SkZ2xp6adcXKC+XqhG5UQZiOgrRn7wBqwQOoRYhuE/gd8E9CHjvw1NcQBpwPePysc40zcpafooGmx0GlNTSwUeTlsG6XoBPrjlpDaTf4XkOgtcWLeQPZO4I6wUAjNytrfzWkp05G16OySGtq99cYoMgttWrBzHi+4dM15ViZkh6oaOtRmoX99z6FZUqkMmlNS9QJWRu+MJx/m6oQBISapH5jfAf+jjzYiKePqaVvzxf9UUzwBQlTpQn/PNkgxg9UE1Rz9XBUfO2Ugr431XZA2wl2p55cE3oQy3LMqaZ+7GZVp/bAxWcfgzc8XLRWrSTLGTYWtQ4aIn8SeLuSYUGaONNrMzhM+qpgqZmyC9VHwndge3Bw2cMYwoO5wT7u58EOucA3SFnKpa1l78GcwMYmNMuUeAkAM5hp7Z0WBXsHGczaFh+lWSaGYzzC7BfDdTDmtWeHG8VQ/PegS4H2Cl/iEzvRp;4:sxK4Pc9hptIxfIPQlDQgYXZthSEVu5hDrp1PmA07qehVqOEho+E2SP2weBDKvkJVzooiKFVjY2IaAidyCvpb/JZIxRi2qhypb/8WyCoUHc3RiC1DD9EycZk0Y1RZAdcdt9sMbrF7sW73Pb1etOV9LvoBgsQqoyhYFgyZKl0M9cpEsE8KGQYOJqbnehmIt5y+UTLtTKyvNiA5DnE/fcxW2M8Br2XhzAfeyvy9GB2/jjyEthiMMh3wx73fkyVcz3KlPQk0bAIG5HGo5B9fj5tAjXiraX6+sN0pS7qz2kdKk4ThZ14h00NetM5dVQnd07RkaRKyZ072I9OGyw1M2hiwGpT3ReTmdqu8QYeS5YOS4hM=
X-Microsoft-Antispam-PRVS: <BN6PR12MB1905B733748310AD5A1436ADF8A60@BN6PR12MB1905.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(2351001)(97736004)(86362001)(105586002)(25786009)(551934003)(26005)(6666003)(6486002)(8676002)(5660300001)(106356001)(50226002)(8936002)(2906002)(16526019)(81156014)(81166006)(2361001)(50466002)(11346002)(6306002)(66066001)(53936002)(386003)(48376002)(1076002)(446003)(6916009)(6116002)(52116002)(68736007)(4326008)(36756003)(3846002)(7736002)(76176011)(59450400001)(316002)(966005)(51416003)(305945005)(7696005)(47776003)(2616005)(478600001)(956004)(16586007)(186003)(53416004)(72206003)(486005)(486005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1905;23:H9+hQ4muuh/RX/XQzFdLf+bC1kfAzjVTyTJ63cIxE?=
 =?us-ascii?Q?zAHSEBQY4VKdW4pGBfWxUeYwzxShMIOvnbt/mGRTwsDUr3TTt4t+hLeC+IBQ?=
 =?us-ascii?Q?66uwfeeVGvkc99xsRcw5Udj7b+10Za/aOmDrTzxtzYv0njGq9K5gzXfu/4a/?=
 =?us-ascii?Q?mZmhLkgiwXjiF3OH/p4noYo+8VVE2yxj1HYBJJ9X7o3dITH0IZaMtvvYZcqP?=
 =?us-ascii?Q?E5VMUB9Oce0u0IyYfXb7Fv2P0nvjRYtgQyRQrbqxwf/MSp3hymv5z4IJHR2Q?=
 =?us-ascii?Q?aYzDKYK9kbPgiBDk1yvwhHTD2tvWw/QnLxstMcwYN7DuezoeSrSNLoG/DV/a?=
 =?us-ascii?Q?ak6nBPfRX9mURb8H4ncZWXbSwm29WRUfMOSKYtTFZCDGUvw3G1v84zYtuKXu?=
 =?us-ascii?Q?57Qnxkw7p/n15tZrypIfdD0BMvrtF1jH3D0/IfG5RpGau2XYs0gk9gk03wx1?=
 =?us-ascii?Q?esejrc5UACgpKahxs2zyAzHG5sx+P/77i5QcCzl47lh0PYeX0kgh8l3tUXLJ?=
 =?us-ascii?Q?Z/TiTQML0ZlzC4P9FfQBDS+CPNPHFiW3/srlIDp5bcODGFa/FYmcrn6M6DLZ?=
 =?us-ascii?Q?oTHgZ2wIfftlP/7BqmnjeGHcd6NCnBTBASU4aPHJmM8vADRma3S/F0Xt2ivx?=
 =?us-ascii?Q?54yZKkI9qd39880XCBdUwN4dDYij2CkV4DfGchvt0cCsXhE+10qWB4UjkTZX?=
 =?us-ascii?Q?Ic/L5m0gfS5bNktPSbsyk4DcisguA2LD9WiFo6o6mFQ1lCCD+rt/xacxJu4v?=
 =?us-ascii?Q?Rmc8fleweZtLwyCXGYljkqMO2BvstOkw4b3OWrpTtxiP0YQaN+gDLZrSzbgN?=
 =?us-ascii?Q?UOocIo+3pgGqKPKgGKsZfpxYlWZf+l8YDg+p3eoHJhFpZv3yumD0460UnFY0?=
 =?us-ascii?Q?Go8hskpwv/LxC5rzoYxrplLNsZcVsJwUHW/J5oOd5HoTdSasFJBwFCrDkYiM?=
 =?us-ascii?Q?QyRVlfnRHyVlnd2s0y7vqjoXc5A9e/jZyk7Mzanz9v2jGher74PH4s/j6L3+?=
 =?us-ascii?Q?P6qK2Aizua0xFXDiHwvXd1StdgFghpyrPJJWAYipU0acVihVRPhb0zLsRvQ6?=
 =?us-ascii?Q?GwUZdU19bEovOgvNT14Rsray4h/BRM9UFCry4M5/59Ziqrd1gGdsLuQxmCER?=
 =?us-ascii?Q?h8vhFmIDQOXeRLP4aVykVxPA/e9inoE7fdvEIYeDtTOh/ISPasklMMI5VCwo?=
 =?us-ascii?Q?Ps9ACgCZUBn5is1TI05019QehAuEUiM7/7gmufHhVPPlFOUDYazMNvZSVug7?=
 =?us-ascii?Q?HDttAeHj3jCI8MRGl2vdNTC8YFLxCIRq2P7WRQ9/JqSfdRs8slJUPXX6xN3o?=
 =?us-ascii?Q?UYzASA/83Q2zs/S4M9aeFcQeuWoWa7HOwqOwNl9WQ/Z9reehuFO/cfHPbd8C?=
 =?us-ascii?Q?wDWBA=3D=3D?=
X-Microsoft-Antispam-Message-Info: AAVFq+WXcBM2ffmD1i3+8wIiO6tumXLLGIvozNH/1TmwEo1zghwR0qCsD3rjdCAWYzhSfT1Dpog7B/dI+/d17sPUNAuJ4uqVyjGAvTPiUXw8b8oYT0JEFeRXcsRz2/FuY6OgI2+1nZLZpZQXh/G/SGgW0R5KWhlCWNeCsjfVQYPe7GZU7q1CqTF6DTB125Lz
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;6:sClt3/vEfzs//gkJ3ye+UPs/b1QxG+xGcYZDHWdM547z7GDCDqoxl81sFEJ6qJBmu9v8RJT/d0h1Nr8OKsjsDT4N7n5BlKXNbNJRs4fKoiDGcjeB8lXRGD1B0DHGmDIoACFOwTkNCbTmJ35NCAVj5oX3c+YQtybtJz5WzOUSAPvsxoEo3qGn7KEARiZxTJhrnPq8Dj3/0jFFPnNc56oJp7P3YGz+0LJjqXByfD/6uU6cwkU9ICPf67iEQWUETVSKBONlVsK0/lXUTojgsVzatUcHAo6AgCTVM6I4/m8lpGtZ6bLFFPo7DEI9AHagrZs0ejhXbhPIKZjzT/MZ2yTobUqgwwy1/KZYVEDPTdWd27ZeE0BQgTwbkrtIVcDC6gfLbVTIfCLJTvMhSv99wtuW/hj/PqAmUmJWh0H9YPKzjk0ipavUufySBBAx8eOV7dToFuJsPlgzPQGdyWQ994Pbyw==;5:GqNO+W3sEAKHOlZSAsyOODXx5XNqm1+zK6nREPt89OncbTmQxGD2pVfLFlNQcRWKag/8pEcvxqB3FpLkR7tK8qzRcFc28P8Gc8KkWmDtFWX/4EyULTEsoXMwcWItYObKT1Ua6daJG2R5Qo7miMoKgdcvt1Nb3+Ga3cZ8V6QflU0=;24:T51EouG6tYTw84t7PIjlCQzx7LO4E8vhZNvoaUmRcm7KVBQPrYLP4F4b5rGzJTvsRs3mpb9DY+3QAO/DpuDznwwNoZmGbsDBqvZY8cI7aS4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;7:2UEL2Vri7uzq1hk8yc8vQIxRhkh8jj7Vz6BGeCT5BMoyS+Ss+Vy2UEnxII41MFIkJ4dE+8ow66BB54bsBET9sojUqWhieqKwAcSAK6dYx57i1CdAjBaxuqlP2FX6PjFwiWBFcxELyB5tmYo5GssGFmC0J3iZCOS4tEozCzxmoFeon3SYpaUEjEFpShDXF+0fFYTl9Rpx3Vmb37TFyIEc6IE9zMPrAk2wnN0hYDvJT7eE9ruTxXOawWgB/CpY8Mcw;20:9RPH+n7rb04MYkMi9srvCdYjzKsA4qGesrACeMLao+w1T3yZJnsnYK/xo+UEJV19Oov/VzImsy60/Brlqmy9f8o1vwqskYBMMYBJqjnpNYg6LvAtK0qtI7vlPAMTo1Tuekk0vWbyjKTR7jcg/pXRvMj6UdNW035OTRRBf+4RXTZdiKs37sNzoZgErksygixsKyNNNNixkG007Ij/Nq08KOSA2TQ6R8Wc86RNvizxdP9A0I93c2KuMgEDn3y7zKJ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 15:07:16.2612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d56cd4-be2b-4432-cd3b-08d598ab6c4e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
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
https://lkml.kernel.org/r/20180324184940.19762-7-Yazen.Ghannam@amd.com

v3->v4:
* No changes.

v2->v3:
* Fix table number in commit message.

v1->v2:
* Add parantheses around "check" expression in macro.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index f70c46f7a4db..5e6716564dba 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -39,6 +39,10 @@
 #define CHECK_VALID_RESTARTABLE_IP	BIT_ULL(6)
 #define CHECK_VALID_OVERFLOW		BIT_ULL(7)
 
+#define CHECK_VALID_BUS_PART_TYPE	BIT_ULL(8)
+#define CHECK_VALID_BUS_TIME_OUT	BIT_ULL(9)
+#define CHECK_VALID_BUS_ADDR_SPACE	BIT_ULL(10)
+
 #define CHECK_VALID_BITS(check)		(((check) & GENMASK_ULL(15, 0)))
 #define CHECK_TRANS_TYPE(check)		(((check) & GENMASK_ULL(17, 16)) >> 16)
 #define CHECK_OPERATION(check)		(((check) & GENMASK_ULL(21, 18)) >> 18)
@@ -49,6 +53,10 @@
 #define CHECK_RESTARTABLE_IP		BIT_ULL(28)
 #define CHECK_OVERFLOW			BIT_ULL(29)
 
+#define CHECK_BUS_PART_TYPE(check)	(((check) & GENMASK_ULL(31, 30)) >> 30)
+#define CHECK_BUS_TIME_OUT		BIT_ULL(32)
+#define CHECK_BUS_ADDR_SPACE(check)	(((check) & GENMASK_ULL(34, 33)) >> 33)
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -89,6 +97,20 @@ static const char * const ia_check_op_strs[] = {
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
@@ -139,6 +161,28 @@ static void print_err_info(const char *pfx, u8 err_type, u64 check)
 
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
