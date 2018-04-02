Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeDBPIk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:08:40 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:48864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752604AbeDBPH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:07:29 -0400
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org,
        tony.luck@intel.com
Subject: [PATCH v4 7/8] efi: Decode IA32/X64 MS Check structure
Date: Mon,  2 Apr 2018 10:06:55 -0500
Message-Id: <20180402150656.101022-8-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
References: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN7PR10CA0030.namprd10.prod.outlook.com (20.176.16.43) To
 BN6PR12MB1905.namprd12.prod.outlook.com (10.175.102.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af7993e8-28b3-4301-90c3-08d598ab6cb7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;3:tcgpM4hvpznYevD2+pUk1101CD9Ql6dsGZAxBty5FEX8sbxgzDLD57S2TxGWn0UMpQIXeJjZYhBIzUgqF8NMryIOAnY/0oe0OkEIFt00XoGISsmutU5r1Z0gSRSI3k2i7PXootIqBbE21hPy1LZRkc3rtaGirV7b/k2dQwmUyRwbdb8/6XC2ke7ECeo7Wx8qK5MsKX7l5jRkZOe4ydzg80+/dAs6aAKq4AqcTlpXIcmH0tzRdoQ3N82kk6UWgRay;25:nuZIwehTJ2M+E1UdEwnyyW/Csp2Iwn+lUSm1xH1Qag337talBvtgmcV25a9JLsE75+r7pUOOT07qSXLLuIg7iM41zTr5xr3yejtFvuLL43tDwh3kghyC0uLSlhpsC8T/QX9LyAM0zpVRR8IhYRtQT5GkopVFE287wwTEHibrvIYTfQ1sRxZBh9+mFBPBG+nYWeNFrhqzD0GWD+jeYTN+UlyrVAuawhUsiAwBjvu/b2HXxH53fKmO+O77z93CjhyWUSYpYcXVeEpr9206H8QJHEL/WXveU1VEHj3YvXAhWXmnPNJ1h+6mMrSp0O9X2kkVBQ+OzTQETHyYXNQ8a8badA==;31:1+Kizi44a/JO0pF3tE70zaxB2YNnGnKM7uVZZ6utYcmnTlNoaBgU8rdonZPRAlunAnI2XtloPO1MJ6Go8rhMXMIQp14X0kz9bRf9eDvtvDigqH2awZXYgS0sG8icc6PwIOdwimITbicA6Aj7dlKTA20lHo7Ur7k/Y1fVk3gsJJzL8yXb3RpJ6IBvD3V7TOL7JWkqYDBFM4FJT5++8X1po1pZpqjgFtFTCputlCBzIvk=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;20:UmLOL7dKtHAkT1t1D/RhU7FI/dar5E0pu7iQ0H0XjdVLTavxG38YaLMxRNO/dqQSzHdLTsqQlSK1Y3SW5WqAlpvFOILENxuZzQeEx3WbtF5d4agjVFukQ5NXUmCe0NKdbKENT/VyXdivaCeTMw/uV9fQZid40h3SQWy7Q1kwQCVWWhsfC1rSZkUuhJeYegtCB99zGA/VlgN9zMAgn3rMAu+6TxgC/4QsVs+Gv14vyw8Z+SHxLJ/EAezrdwV2A0/C95tpjkN9FFoA85UABMWnoqfAc5IR9KliVJn8tKsno6o4zNkSNm232Px9QlXDc5/Y3EHhAOAjXjKd4fQnlGymAKp6FGP1SGU0oU4Nd/w8dCBlOpx2L+r+qwZsq5BckzFpKSos1GzCuX9ADmATGh9Xc/ZXj7quSg6DboT95eBAn9zlFyU55bLH0qUAGxq/kBV6pIzAm0LDMEd+HS5AMYb8yp70o/4Nqc8YzFCef5sOLAwsupMGh2ObgBGxsvR4+pDE;4:DS0Ahk6WNZG7pRcDsHMzx/QHff+OqVjF5U2C57DHZm4fvTH/ZE7v2wdVz9GGqUrFsjrJVxEmXmGtrLc1fEfK+dA2tePezeKzgmLD/4zqSb+OdW3dWmRFYgp1VNGUg9o6uSBGOEvWM9W1fX3GO9162d8Xh4SOth/FDbPYF0Z0iJTm2zdlYn3OX+WTQlWowMlNTgt4qEgFBr7rQ48N+59saIEr2yiKLCix8W/H1lb82MGeqfXKyJKAfJHFxDMlloXnzhjDWcdVzo8FwfODRBoZJhdML3OQwnd7FglRuX+uvzaL0Omq0Bet9bdg/mLQXiFv2b4Puta7nfMfa1yDgKH9dPynUoE4Y3SymZ1+RcZg7KQ=
X-Microsoft-Antispam-PRVS: <BN6PR12MB190506F25FAC6E3F4D08248CF8A60@BN6PR12MB1905.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(2351001)(97736004)(86362001)(105586002)(25786009)(551934003)(26005)(6666003)(6486002)(8676002)(5660300001)(106356001)(50226002)(8936002)(2906002)(16526019)(81156014)(81166006)(2361001)(50466002)(11346002)(6306002)(66066001)(53936002)(386003)(48376002)(1076002)(446003)(6916009)(6116002)(52116002)(68736007)(4326008)(36756003)(3846002)(7736002)(76176011)(59450400001)(316002)(966005)(51416003)(305945005)(7696005)(47776003)(2616005)(478600001)(956004)(16586007)(186003)(53416004)(72206003)(486005)(486005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1905;23:CmEI/N/W1Ls/R3S/poZ0Q8+51FS6wNE7A8RT+Gd29?=
 =?us-ascii?Q?GkYsKeIoetA1Zmh4UGFs/NEOAOZAgcxApmmT0YZX5FTWkeuL2SCvULUnjUuh?=
 =?us-ascii?Q?1IQnELT1BsqyLliPxQxvkuEsGAdlYd2n3tdYUYlvAXUV9M0rfZwoxamm1Mt1?=
 =?us-ascii?Q?yR9WcnLYGEyb/6XowpvdymsafE9IS6XnGkXCaz8rT0vb029naCz77Jh/1PKh?=
 =?us-ascii?Q?REJ/24+MPq3/gJ272fvIc776KeAnP2miqYL/nSd1MvwfB3UU9RJfPkjlKwct?=
 =?us-ascii?Q?yYNqf84RXSyuvv1PxNakPDpjL0o/lk2eMZ5nSSeojCjcY3J6xd8T9FqZufxV?=
 =?us-ascii?Q?UL8KSHoUznKkhqIEI8wgYxtx7Cu+VScELmN2NJJI1Y4H64Bz9cI68R39eEVf?=
 =?us-ascii?Q?25VG4Xi6mE5RwhN+g20zq+rCEv2LbZF/vpf5QSIBOKvL9rsafP9KSFnz6Azq?=
 =?us-ascii?Q?O7hWNifk+ZHo+/h2+EfxOBSvdK6ZPzCUmsXBbGiVo+aYF+hv+MMA0mRY6+j8?=
 =?us-ascii?Q?xpdE+P5vHqWbqXqoUzfjPySxEMgyjL1jfd0AvNBxTRPzkVNT6Pu/V+a0nPZA?=
 =?us-ascii?Q?emMFfsTPSZ7dnaQSLbSLPjzbSjTeh8FYE3QtvcSQUW02dxLcITksiZ9JUGrT?=
 =?us-ascii?Q?XO7J6rodrswXwuQemXzZ+5JbrKjYeyVRQ8ASYPTSbYcg0VIQHqI3/Va5yyYK?=
 =?us-ascii?Q?wNjce7lOTnVjbFcndEK+TBAOowVU/LEBGBmkuOWFety8g6MXIcogavNpi3PR?=
 =?us-ascii?Q?k7ReZLQxXThWULq5hrV2vx8+CPuFFmmih5feqW5q9iE1G3jX/kVx2ZYvZyVK?=
 =?us-ascii?Q?oeEBXD5YHThBawEQyjNJEKFG8sBjZDvfwn/EYBdGYDLAkWfzOnqwunmBqsxV?=
 =?us-ascii?Q?ZnpbEdQc3XcwTqScspwxOdPzBT5oSHLhYkO/Mw/JUMept9XV0mk4A6ci+d7w?=
 =?us-ascii?Q?1TuTdcD/Z27dUm8+tRkbViTaSSbIbDIv01YJXAWSRvx6VJMHZgpdN3ar3aoG?=
 =?us-ascii?Q?PJ0NhEVah4+EDSz/liK6bmJ+iB/1U8NxXzJGs8ASu9jB4unPGdu+dhBZGDt5?=
 =?us-ascii?Q?CIEqQFzW2EvbL+bJBVNOt3OE1pUx3JB2JItIGQWfr2lwZcN6YPZdnvW8ji4u?=
 =?us-ascii?Q?KGux/zJQILzD35NIjAkiTp2HQ4npPxsCez8/MurzdEkIscNgtSa/pMbC1KNs?=
 =?us-ascii?Q?iiuznwKrgfs/cX5XI9MNI94EdD7xc+Tw/g7KNeU2kniA7n3BN7099ewQHmdM?=
 =?us-ascii?Q?Fw6SFigl255Ab1vnQTMx8Xf1kzOMYRCze8G/fKPYgr/guvoSc9RHthc3PIB+?=
 =?us-ascii?Q?u/s1mkLCOggykV3DI6V/gHo49efnsyntpr+ntJ8ZpekcGsAWrxc8kH8vNbTM?=
 =?us-ascii?Q?O5zqg=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ed2+RxvaM2UlmTSwxcm4Kt8rSjIVdp2FPj0+uESk5zrqLNEiZMRjBcgskEn4opNGdum0TAqln1vNE9EMRdqSwFPtIFjbeM+fMYax6xBNPP+uykF8/OfvPGz5AB0lGUtxP5CS3rBwVnIV+89+1vW3sKwEUa9X0wdxmK5FhBNFF2jHRTe3wlVhGC6HtIIVz2+/
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;6:Xstl+m6ew1DQ/gVzk+oMvkzAzfL+Fym7HhZSTcRuwzZ3MD02o3XRRTjjba6YvRUnGXo/GMCVwiRmUXavJoZyX1ubfxAUlx7ECECS8cOLjbOX2hCPa/XtDgaa/MfWAwGOlRQYQRisFjpI6/sn/UfCTJSd7SU0YeH+8EDgSh8bC88wAGebxD2mjDv05aVEG399Zuos6RyQ7TYdurWha6yrkLtXoXoDl26hr8cr7zLErY8d6hAWYnavdDoMiYLdGaLAHtLTEw6iVe3VlbvxvVRiFQuQ43kRU7YDiUlB5/JRezWL0MSBbvHV0zG4AhKeJSfseUsZgOuHTRPDBLKQjfVIRE2Zdbi1W6zGQd37mk6joDTvFffTKIAHTDYJBQMNuTvU4JSxmvCpiHmRlmUythont3YbkUGHoDOTrrWeLXWySET3I8dsU79XHxe5wL2+5cNF0y684ix4bfo6Ad+9riaeIg==;5:Qok+Mt5Sj8FPAyCdiEvOdb9DfUW8AHTA+lS8BumkS1Z+VuzSHRHqolN/3T5rQ0wnkPg/Pe8rV2qG/Ll1ygDTzj2zKGlAjPw5qPIaT2JQwmV4QFkHYxMKC9+PIEIVBDJ0t5cvvQK863HkGrm0rXS7WMu5VAvtQCb5EgRuAqcnqFI=;24:xt/ky7uD6E6+DVMr7yHsGMA7WNT+rgUvpyKeGrSTKi44qkq9OpuiORpvc2TDq4CZiCKgFOCMrSlI6+GO3Vp5Hg6S1aCzvpyNuPOnqQnUcYA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;7:jR0QTCjYf6d/e1C/uGKyl5luPiz69Voygt6MF5RUiYpNgW2zAaN0ZT+pGvNp3SzEhQfYfEkRlq2guROBl2wb9dGNqX3TVq7ABiVVVoRcnNrCvDkW9YZfAQ25kJHtJTNl5CUBcnCqh4XgcOgnaYPiHUkwpmorHlN7zlfhPQahyID+LE+i9m5eIpv7umnPj1xO8FhNfOCsSBh0fPui0nhSBKEVEhLvxqmCN0TG9FfESS8WX3ftqSEfQGhtCYt03kCr;20:0JOwNmaV+2h/OHPDRgZT2hNqXp/VhyMcVhBeZHB0OJE6aR412YrnVZtOx6gjHf1MfiLQCATLhAz5m6lH1wjzN1B5UWLKwc33cELkYumeIaozej4kfiHa9Ez9oT1PxDWDMmWPaSHvUGcrP1hu8YY0DbBTkf8zJIgK4Xylv6tN8Bot8peYfENUIDi6j0jHnd1tQlcymgGehBwcYoCE3oghWiO0+09Dm2dAdVX+1bIhNuLyBZuYFACjgPCvl0/AI879
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 15:07:16.9498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af7993e8-28b3-4301-90c3-08d598ab6cb7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The IA32/X64 MS Check structure varies from the other Check structures
in the the bit positions of its fields, and it includes an additional
"Error Type" field.

Decode the MS Check structure in a separate function.

Based on UEFI 2.7 Table 257. IA32/X64 MS Check Field Description.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180324184940.19762-8-Yazen.Ghannam@amd.com

v3->v4:
* No changes.

v2->v3:
* Fix table number in commit message.

v1->v2:
* Add parantheses around "check" expression in macro.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 5e6716564dba..356b8d326219 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -57,6 +57,20 @@
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
@@ -111,17 +125,56 @@ static const char * const ia_check_bus_addr_space_strs[] = {
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
