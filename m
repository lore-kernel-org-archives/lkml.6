Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeBZTjn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:39:43 -0500
Received: from mail-by2nam03on0053.outbound.protection.outlook.com ([104.47.42.53]:36592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751533AbeBZTjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:39:36 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH v2 7/8] efi: Decode IA32/X64 MS Check structure
Date: Mon, 26 Feb 2018 13:39:03 -0600
Message-Id: <20180226193904.20532-8-Yazen.Ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a74ca83-ce04-4f09-a0ab-08d57d50aa63
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:HTrRI/ucFmsfKVMpMihU1xz9vSM0M8B7Uy1v2rvAaNxbMk9jqdnNg5c+7LSNFucdCrtBLIi7g6g7VqxV+1149sQcZ7p4RNWqTlyk79rbfGJIVlc0CM6sFhcYDaqb3qZMJ5DdRB7tPt9ngiZoyn80xsXdPcb6pEI56eqggUeiGaJuQTzAJuqLxvyWib89vxnWAHTn8NeIv3zCAqreEa8iR/ceqnYkD4FxYOxc4m3eu0r7cWJR+AAVSxOn+DFnfQ0w;25:nwWJJXZ7TNuhevhqClmxbelBaKhT2zWpnHihuK/t4AFdL8geG1MEtpfoh0Na93un97qfQbByzBgnpD6YgYL7r+TodHZbJ+QU7vPkZA7D6t/nmZqpJCWQidIDWqcaa0lqApkJ9N2Eek/G3BIqz+jYJ0om9dnEhkxC3mH4dRSsAtoznU92IhHrFkleNofIim6HZDjqx6fWkijDY/7d/NhHSiLd6hoQAzIy2BbfY6I7ULlZcRmXJQkAd5YMhJSXSpfynWOOPQd+DJhI0WoiHDL/PmN/90+aLJgnQ55isgbKETdLl4yMlwRE/zonHIgPf7Pn5XbbZShICJUnxhty8Cyx4g==;31:7JoSw0yO9hQ2H2QVVMd+/X2km9sbYM1YFmNB7IARfBncw45H1n7kaMBWrgyDCVlzpGBzH9EV+jfvuA6w5mg8srJfU/I+7jpcEzlMFQHISUAc2Adnz7Nine9YB8kFK4AmDv3omnatBCcGafMIjgQ5rdxlQwBVfnphHTKHL+9bJSlUst+8WPdC+cQTq+UQbpvnF+qTd/1dPLSSIl22+9oW0tm0I7KJ047/Uui2OAMbM84=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:AVMqvw+CLJQIL9KcBI0RYXgqKbfI0GXmvCGsEd/lZgJ6PhUdOtkXHVKBV7JSiwhUkj8IxxVdjyQdokHOJNlwc4at+kKlXbLfBOsrCOL8reSQh7wW28tbBSuiHrTydMU4+Z9276+yuMPR4g/T06L/TFaybpwdG6TSRukhVca9sCZ2SAgllyVHohZGGIOPd8QeTUDF67y4SFvHvuDyB4bR6nxWt1wXb2CckTkoL2sGyCuLdG4y52gMyCNKoIus91jkkNZqDPpwE7mW2ziCV6hYhckND6wkTC6Csdc5CAuIH/ooaazMSiDkEa0Z16VmPQdpUt3xykOIVVe14pvL6Ld5HOyr7NecU1hcMPJf5x2/637wROH7+zaiHsGn4/uiHCKag/YxoFgXsCptNJG038ZdA34bk8EYzYgmRyx7Gm6YgbIf1CVU7fVn98k3UoedjrnWaV9gPJOOTM/hcIInoNrUeyOlELpluh+O5SQm3USfWrGr+UbzuIkceadHoAQLRbIo;4:s4hxuy3wZCKv/dkiRAl2xiicSw2TjlEVcbdlwURy7y/5YZ2cjK2AOoEQUqVGkdBQPTaReZxJHNZy+S3asMsaJteCWRV+C2Sj88XYog2Z4FBXLjvwyFtNNwMnp+WDRt39mIjeHl3euUV2TJPja5MrmFYoC5DP8qbfge+7qwAykVbgfKifvSl4gXlsA1+hNeLL3fH4Fy5sc/bFxzPlZTkQjYFcVdFvHM9c9Y+6Q7i9OgkwlfW5jGEJi90zxovMl00YjRuv3AD8MTWA7kZIE54va6ieuKfJ0uzFGRYwDIMVTrsUgReJlUd0JB4fAy9LYDw15usjkly33dPQrdnLvLYf0w==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1917AA4C754C0BFD3A863A26F8C10@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(72206003)(2351001)(105586002)(386003)(551934003)(16526019)(478600001)(86362001)(59450400001)(25786009)(50466002)(6486002)(97736004)(36756003)(48376002)(53416004)(66066001)(106356001)(68736007)(51416003)(50226002)(47776003)(7736002)(305945005)(3846002)(6116002)(53936002)(6666003)(2950100002)(6916009)(76176011)(5660300001)(1076002)(8936002)(52116002)(7696005)(2906002)(6306002)(2361001)(8676002)(316002)(81156014)(81166006)(26005)(186003)(4326008)(16586007)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:BHT7Vs3uHGcf8leLVkAMnMDTpMcN1nH5CTk/mx+AK?=
 =?us-ascii?Q?GrfdX3w42Mu1wQEhILuty/QXRaDTQDfx9tfVR4idABwmCcLNomjsL05XJLPc?=
 =?us-ascii?Q?GuOgw9oO6BB0r+qf/XrJkIKPiwuj+GFrN5N2kimzjc9fW4dyVq5XYUrY/T8I?=
 =?us-ascii?Q?9KFbU5MAXIhRkCaFidhDjrggO6osnmDajp5HFsL8klwM2bN/hlIsUGqFLUfs?=
 =?us-ascii?Q?HfihNc7rZhVCbrZklrzDI8nvVVI7zNtpLP5QcsrtLhO5T5r0wZ3gF/vDKmCt?=
 =?us-ascii?Q?d2MZfIahQKUAdTeXdrzoihxpNQX3xMHwo/zmt43dOy9f/PHrb6J9swocf6W7?=
 =?us-ascii?Q?Yg0YHvisk8qr2k76ViobK8ldgxnHFzQIugc5ZjEk/QDj4ZveE74Ii4FPso3o?=
 =?us-ascii?Q?MjfNcxd/FTu8mLkCb+WcGjk/DrPXU2cNg4oRkNf2WnKSGNpEx0SRuGMHvtXZ?=
 =?us-ascii?Q?RfRaHpcvLsKRogvGMaueWhi1EZ5ToikRZ4ORMKQe7RbfOtscE3yd5n0QOgKV?=
 =?us-ascii?Q?/u8vjtXIdX64aL2wWDGpCt/BXn+gIiEexNhQmKT2xhdsAH007lkjlQYWVglS?=
 =?us-ascii?Q?IdWBeenfsbadT6WMt6QOUqGUNwTH2uU6gMwwT2hiwjWmUMai1UyOnggAnSi+?=
 =?us-ascii?Q?de4eFosAvO5GfB5IBy+UzUTXjykmiKZodeEH2SmsfLpfZ7NEtPVj3gtkOobe?=
 =?us-ascii?Q?k0SGWFk9VeYVPACmUPIqzpPxEAewSJIyhTeCOAibboiP0kgvALeFqwtmDRzH?=
 =?us-ascii?Q?ZoKbU/f6FIu4n+YsbzDrwMi9FjzNdxpBfzGXSXPw+uZpwdB8a9ORmXMJtSX+?=
 =?us-ascii?Q?YXpGnUePgpizWaCgduOsR5csmg/7ywdyqp5gtiNn/VN+YnZh/SkVI2NPZmUJ?=
 =?us-ascii?Q?G0RidEwXGPtQBdWmENjbnFWxW6P358sACkd0xmW3mifH1GzprBM52EZnXQ0C?=
 =?us-ascii?Q?+4I05l/fHQCMEyeI0ouw3Ps13DZKOdKJONF6xzoEvIAW4dQGzXhTnnloXDnR?=
 =?us-ascii?Q?dgjcbAQTs0nCt1s0yCV0bQh71ZE/bcpsKFK+281oBi/OqOM+A3xNEQdctNGZ?=
 =?us-ascii?Q?FxXYTL+PRm8jie8qzNRGslLTb/9JQfJ7gLejfmByPhJmnhNElQDn+QsX98H6?=
 =?us-ascii?Q?TFUBCwyjy/8dRjSIPtJcQ5HzkPjV6V6SLaMP6qRwoq4QbsLpDpd7UKfElxil?=
 =?us-ascii?Q?NidX1W/9SPuXQRkf0xqPLI9Q0hcSZZd9fr9EXQ/R8YUbMy5GVt8grveHmbB7?=
 =?us-ascii?Q?fKyof14ztzOEca6YRI+jWVFfZxaVCPeI/6rSdZc?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:zMzPUpzSnZb2r+UOp0TG6k8xQvwhfPlKw8UACh7tOhoSzOaHbyMq1munCt4CsYtImYJL3qO6OOblN8Ae7btgjaMPVbRSeKmhC3mnsnJOpjbpy7lNKC+lkxdN2lL+PBkJnTADgNdGifziiGh48VQBEH/SmVxhiNQQvYj7R7cbBG+HYNQVIeE7QYz1sQkRyujaEbaN7oSXkIkjsQgjF2nauDRrM7SwXe2urJ64gF175v7pM1DYLUAWy5O3jodZCZDReM8O1/wgwprpq0Ha5aykHUQ6WsUNlXnirfwQGACdK4+4Vj0qPLjfQQLwR0lg3H0AgnkbNha4dd6d+6bm6MxNh/NXTMKo6mRqWY78QZHKMGQ=;5:t5c1BdxqMeQm+MzoEHNy7zf2zY35hjYFRbU7UPTyQcY3kR+ti7ceBQ1FL2ixo802X9ByTViWw6I8f0Y0TT76WyU/z3C+HzF+5ef9NrOTXSI4sYh43Q8L2foiGwj8xdse8F5k5U4OQvB643PiRo5C/PkmneHmcP3n3MuoY/Q8fFk=;24:vxufQ0hWlypyVdA8TB1brp2TYgUed3ZXXU9hl1H+g3LDshcJMK9DVtpvH5hGoR8AdXl0R6hzZmOyjlCw1RdjaM2fhVxRPMj7mjKAOIOsrrs=;7:nr0VtZWjHf6FF2N6b9vtt/VVNyX9v5+vuqxYJf43PMEOlW/K3Xs5HOvKmy7X5vgKH4pwdHQtMZfZbxgqExY0ZdQRWt9fa4yV2LFXD6w5yufo62oVxU0whwAXNisO4KS4Tca/McnESdql82VfP9RoRxKGorVjWu2RaKVdyGSM1fGr7+/dqloyTbSxV/TSF6Sk+VpR3itV5zNrxub3FxhCUSBD5LCZZWmQiw+EdzveyOKiSOkFcl1T9g3WPiKlo61h
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:eVAfHyhI+e7zkMfYoD2x84dN10IxMaOF44FGAneBqHe8PV13mxt4GYuwfdjimLNyzL7nawgp0oofkJP2sRjFrACuJvG6p4LjZGhhLctGc6YEx2hRVWKB4hjdGC6TRZisHnhzKlCTQJydRAyux5sHJZOp7KecDT9RsiNbMal68IvBHaI+8wrBeHW7AboliuzppZ9cim3Ww9ezstyRAV1pLGrDRMbEFHf3WnJt660hcQg8xfJJvhvxLxd/g6RSYAb5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 19:39:34.1836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a74ca83-ce04-4f09-a0ab-08d57d50aa63
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The IA32/X64 MS Check structure varies from the other Check structures
in the the bit positions of its fields, and it includes an additional
"Error Type" field.

Decode the MS Check structure in a separate function.

Based on UEFI 2.7 Table 260. IA32/X64 MS Check Field Description.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180223200333.6410-8-Yazen.Ghannam@amd.com

v1->v2:
* Add parantheses around "check" expression in macro.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index c5209af3514b..4c79401aace0 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -59,6 +59,20 @@
 #define CHECK_BUS_TIME_OUT		BIT_ULL(32)
 #define CHECK_BUS_ADDR_SPACE(check)	(((check) & GENMASK_ULL(34, 33)) >> 33)
 
+#define CHECK_VALID_MS_ERR_TYPE		BIT_ULL(0)
+#define CHECK_VALID_MS_PCC		BIT_ULL(1)
+#define CHECK_VALID_MS_UNCORRECTED	BIT_ULL(2)
+#define CHECK_VALID_MS_PRECISE_IP	BIT_ULL(3)
+#define CHECK_VALID_MS_RESTARTABLE_IP	BIT_ULL(4)
+#define CHECK_VALID_MS_OVERFLOW		BIT_ULL(5)
+
+#define CHECK_MS_ERR_TYPE(check)	(((check) & GENMASK_ULL(18, 16)) >> 16)
+#define CHECK_MS_PCC			BIT_ULL(19)
+#define CHECK_MS_UNCORRECTED		BIT_ULL(20)
+#define CHECK_MS_PRECISE_IP		BIT_ULL(21)
+#define CHECK_MS_RESTARTABLE_IP		BIT_ULL(22)
+#define CHECK_MS_OVERFLOW		BIT_ULL(23)
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -113,19 +127,58 @@ static const char * const ia_check_bus_addr_space_strs[] = {
 	"Other Transaction",
 };
 
+static const char * const ia_check_ms_error_type_strs[] = {
+	"No Error",
+	"Unclassified",
+	"Microcode ROM Parity Error",
+	"External Error",
+	"FRC Error",
+	"Internal Unclassified",
+};
+
 static inline void print_bool(char *str, const char *pfx, u64 check, u64 bit)
 {
 	printk("%s%s: %s\n", pfx, str, (check & bit) ? "true" : "false");
 }
 
+static void print_err_info_ms(const char *pfx, u16 validation_bits, u64 check)
+{
+	if (validation_bits & CHECK_VALID_MS_ERR_TYPE) {
+		u8 err_type = CHECK_MS_ERR_TYPE(check);
+
+		printk("%sError Type: %u, %s\n", pfx, err_type,
+		       err_type < ARRAY_SIZE(ia_check_ms_error_type_strs) ?
+		       ia_check_ms_error_type_strs[err_type] : "unknown");
+	}
+
+	if (validation_bits & CHECK_VALID_MS_PCC)
+		print_bool("Processor Context Corrupt", pfx, check, CHECK_MS_PCC);
+
+	if (validation_bits & CHECK_VALID_MS_UNCORRECTED)
+		print_bool("Uncorrected", pfx, check, CHECK_MS_UNCORRECTED);
+
+	if (validation_bits & CHECK_VALID_MS_PRECISE_IP)
+		print_bool("Precise IP", pfx, check, CHECK_MS_PRECISE_IP);
+
+	if (validation_bits & CHECK_VALID_MS_RESTARTABLE_IP)
+		print_bool("Restartable IP", pfx, check, CHECK_MS_RESTARTABLE_IP);
+
+	if (validation_bits & CHECK_VALID_MS_OVERFLOW)
+		print_bool("Overflow", pfx, check, CHECK_MS_OVERFLOW);
+}
+
 static void print_err_info(const char *pfx, u8 err_type, u64 check)
 {
 	u16 validation_bits = CHECK_VALID_BITS(check);
 
 	printk("%sValidation Bits: 0x%04x\n", pfx, validation_bits);
 
+	/*
+	 * The MS Check structure varies a lot from the others, so use a
+	 * separate function for decoding.
+	 */
 	if (err_type == ERR_TYPE_MS)
-		return;
+		return print_err_info_ms(pfx, validation_bits, check);
 
 	if (validation_bits & CHECK_VALID_TRANS_TYPE) {
 		u8 trans_type = CHECK_TRANS_TYPE(check);
-- 
2.14.1
