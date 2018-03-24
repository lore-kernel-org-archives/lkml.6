Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeCXSuQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 14:50:16 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:57948
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752783AbeCXSuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 14:50:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org, bp@suse.de,
        tony.luck@intel.com
Subject: [PATCH v3 7/8] efi: Decode IA32/X64 MS Check structure
Date: Sat, 24 Mar 2018 13:49:39 -0500
Message-Id: <20180324184940.19762-8-Yazen.Ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b04f974a-3999-4a84-947e-08d591b8106b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1919;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;3:GANDbr/VGtBtIC5IH6v2Y3Pszs4eLsGMH+7zw+x1xTTPRruywqqWrMtHZuwqXQ1TzKpqB66IceR+Qgy157rSSBbGCRF5UY8rDCuY6Rc1EAvdNnimFMxcWfHbFkg4aX96Xp70fHoOzb1OKGAFhLlF80ekkG82/WYduWjcvAXKfrUtiVDqEav2UBUW0Hu9zP9OpfGtyPa+TgX/btFltmdAdXY5nWmECw/l/xyWUSTVShNqI39BHwU2Wt6Lx3oNqp8c;25:TGWDtPAAiE6Yce1th3ewbiM5ZEUgA3NrdoUag2BkePxVmUBNLHuOV6O4vlF0BpNOFLm5hZ2Nl9rDMxMVOVCWeuub3Z4Z1AXLpmaEcsCFSzVBkMz2FPQIuWJYzUUzwB7cdpoeLi4JzaHXtUec/VbVfpwrQXxPuAuEpn2hQ3X7J7cTL6xE2+vkkKsLeKm25xfxR07Dys4xyzyO8dWWInb1DT+N1p8hob6Ic1ET1TDvDvM9LBF9E0UsmF5LPwOFFBmaZY76YTdhYz/DTfxinsPrMYC4tg+S3OmhwlPKa99Ao71LHycVegLX3x2gmxXuLu1XUVINTiT4veQ+jPbHMeYK4w==;31:Uuad1KQiC4heIPdnFSxD6hyjECGLM3SxSJUpns+srhFAqS4Zg/cz6wBChryrtYKU/u9CrWQ5y0lqk4JzBK5XIR/mnT8y/Qaoym0Ng47hL6LCu+BBxI15pAERpvZdbd1pVCBhIz45nHxfGdcaoYP0j4q4MHk+lJTGdeJ6Ojig1JtZaAhitp3+V/u8qVbsBuO+o4BOc2/pQcAGQsuZuvbNmtwyPVST2HIUFm45HpqjKTE=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1919:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;20:cxXXiXdFTbj37Xg3B8Q29MHJUWX6gOpvgUpKNaAIvMdsEjxysp39lvxGs5KBYnM7lh+qKpHqFkTEBsFY769CI5HaCw3qXYdd9VSy2ScXnbuhpp+ny3+Eb2AnA35iWZ1s2qZwdMgnEZCTnrhd5XBO8EufQfXx50YfOCAEaz29IQQKmxzDEoLnnxj9c97thpQ4yqHOF2m3kshcEAsY1PUrxuCknqNfGG1txuiFcDx/BozjGLMDKDqHxX7y/xDiWjAZbzmcH2vTnEo+5eOMydi7wSwp8f7oltQZeStfBDaIOcvN33K8JA1VDm0h0kzKdBdboZqjdwuDr+knCmok4sBpM09Xsoa0XIAe5CQwkl8Ti3EH7emycvOGRg7TJTKwNis0ppZw4n4uon+JqPRW3anw8CYPGuSuu9OuDpwwlIaKndaHoMRUIXT/vHv/ZnWUsp1Meedf8j6EU5BWwtFUrTOPw2/FWZuSmBzNB9loLcNaOrzR/cwHVUPcRCvGmrM1wl09;4:I6JycloIoOEISx6YJ3QHNTiogja6vZLW2qS/+lpfkyEUMyybVHnnzfGu8u5T0cxeZhTnIMBwKVomnopyEd3JHehXBTpcFkoy/yqRFPNhrKG70LylqdPwhZN/kQAEAKaGLWScKJx7Wj8Dw52ujHtjNDwS1pIGAobu1owtJCXm4QEWWGy9xQc8KCyvyuvyhDZo2MTgiSuSshR9ClUUPkzIAbkf0v6JEWuL1rMp7bC/v/TrdcEnvYGRQQ/5epVHzlFM1FSbvubdJymQVPH4JOJsCPrTmF5yox6y0B0hYvlh7kGMdJnXmZnfvV6cLRerQmV4DizIGlqYq1woh0e7Iw07/ewaN7EBKlAWxAuPibPRAf8=
X-Microsoft-Antispam-PRVS: <MWHPR12MB19197C448D0502B942DB055DF8AF0@MWHPR12MB1919.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1919;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1919;
X-Forefront-PRVS: 0621E7E436
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(39380400002)(199004)(189003)(2351001)(2906002)(66066001)(36756003)(52116002)(316002)(4326008)(51416003)(25786009)(7696005)(53416004)(97736004)(5660300001)(106356001)(16586007)(76176011)(68736007)(59450400001)(11346002)(551934003)(2616005)(386003)(956004)(7736002)(86362001)(47776003)(305945005)(446003)(966005)(186003)(2361001)(48376002)(72206003)(53936002)(1076002)(6116002)(6306002)(3846002)(16526019)(26005)(6486002)(50466002)(105586002)(81156014)(6916009)(8676002)(478600001)(50226002)(8936002)(81166006)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1919;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1919;23:EiRabZAnzRmTVlUeLVio4oyq/Er3YMjrEaDXzcfyZ?=
 =?us-ascii?Q?+//Jr5v7yDK4sK/bjDoOUmvNvS9UpJdjTJ06BpINch5xfRSTK+Pqt1u+o70A?=
 =?us-ascii?Q?qdQesJaKfJxqu9jJlxQYKCQPlf9KboPLvA7ykGekciZ3AcS4ZpHQJBu57VBv?=
 =?us-ascii?Q?G9ComnLGxOthn+nasD6bSJT8LuBgz944vFIqQdyplC52oQjdWebwvr5kpfR7?=
 =?us-ascii?Q?aKahS0Tj7aU5Oafl4Zbe9P4mfA0s77Aw5Fkj2CncJZbmqRPbgBpV6cc6Pczw?=
 =?us-ascii?Q?I9q9FwBb3Cd2j0mfwxrIDfCMcqdw6iLxffDIZsAe40wh3TDDWP9r/m18/Qem?=
 =?us-ascii?Q?3JhyAUEdt52vxSciLGySR20+xz50JVAEQ9uyZwsp8FruJ5xsQ64xUGR+z7Zp?=
 =?us-ascii?Q?t33Rkj2oFAZxthHv09nmIVHwHW58JIz7OuG3BOzsgv/mldniKev3tyLOy1LM?=
 =?us-ascii?Q?uNo2nWi6bpEjnHnOTx8WXPF0FEeuJo7o6lC2uNOynDDe5RfRP8SY89RjmXaQ?=
 =?us-ascii?Q?vQGphi8ud5S0UxOg7MdxukHgvPI2qtlo/zv1G5mqQejoluJSNlsTi3Uvb41m?=
 =?us-ascii?Q?9i/bfStwVz6jDoN2997dgvond+gBRsln16GwJGnaLJxOm6Pq56XF5dcADeZ1?=
 =?us-ascii?Q?WmTGgdprnwvknDhxkxYFaGkgLjQ4I+Jl6zDpcM4sgeVenQek4abBq/yjoHEK?=
 =?us-ascii?Q?577jAlKyBRTO69k1h/CtyTz8EsH597FTheu7GwtnptWUkwtjhcydrWlFwcnz?=
 =?us-ascii?Q?ZwlMThj/NIHZoMyOSRBXJMmD7MToOxXwdCwfKYRKkSBu6rjskhI5aDPqd8nj?=
 =?us-ascii?Q?dEEnNBBC5HzRxRjCAYLOh6MLGoo5bKmBbtjdkNig/P37Saqkd9WHGyfsxAw3?=
 =?us-ascii?Q?bsLQkyQ5Nc/cfCD9Q6Os5Rcqr3JqkliLTevgTZ5K2EvWVQSxggTYzhEuOpqH?=
 =?us-ascii?Q?ckVDikBNqn+b5WOnBqDGWrh65FIr4M2QtNy/ArLDCKIE1V+aBooV/eauWGYU?=
 =?us-ascii?Q?CA2fTFV4AHtUsSJvPH16JwjxOkJLsYtu1whqIOOp1WWGy7KlCkM+pL3zyXzz?=
 =?us-ascii?Q?UPR1irWOQzg0dA/posgI6/yLgl5LYarqwIhjizim81i2MnJp5z8EaDFTzgYl?=
 =?us-ascii?Q?rAmgkTaNG+NGMn2PbmdDXngFKZ+kG8itT6MeiDQEunaFLNusQT+nH0Rox9ws?=
 =?us-ascii?Q?xY3/TVoBxlCMBZGrF4LYhBzkCeCuKWN1whUmuypXiEmQmCrCp6SrsvDKzEIi?=
 =?us-ascii?Q?OtXCKisrNZ036S8XTeF4IhIQs1rlOzflQb+HY5O41oj3wG4arczsDgWrEom8?=
 =?us-ascii?Q?RbjDTIhnuF7jg3bkpQP+kA=3D?=
X-Microsoft-Antispam-Message-Info: ItDFfgluw9MM7ddyMxXn7qHqWtVHkxGBzcZhZY6lQTWE2QVqwpTdLMWHgZaCDnoYQjk1kn8JMAVfoskbRE6prF2UJOuNcf0InrSBksqbas1hZXyBVNgqBhmoqIdFfaaXaUOy1d56za6PedvFXHLFdOp5LIz27CY2j3sPpl5lHdpouydSXV/KqRouwLo+9dTe
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;6:01sw9xcDMFQR5fLLz2Bgeryc4H1lcMDEyuzvs5H6ZUAAdcYavgV9HMRs3N29e6369D03QUTjIg8rTr4inhkBwZJ5CLrUh2sMs7vhr4vtkyD26IPASBnBLN37fWoPzv/Tih2Hb0vaiE4Auo3GCLN5iCEDvhaWl4NtKdcUxhw2345Jy31hlAYu+56O/27VS5oTGfCkiSJjeqHZ28KTzCNPHOf7czcekOPmBtvQ9k8z+UEaAetsJGphuEKZKf93AtgFhKeTqGWDyZvojmzlS958RVpw1wD6cmxiO1GwnBeEPgUhh2TktacBaM26Srxq5olIxO/Afrko2XFC8DX8Z8AnvMOBDZDuPxU8DU7JbZrRc6Op+tqVtNwsVmf6Mp/pyZ6SB7m1tQ0uhcHhS9VHogkc5tLCPIO4kNIsery3h/1KNA8H36+QhIL+hL+oVbPbKxMGc2Xy4BaOfVUWp6AL2vu0IQ==;5:829qHhFTG6la38X8qFYYYbeoiZJHxEerqkUxG74MS7HmOCsmDdw2vboUsdK45JqaVRadrRTvjqf0aEQdi/4eLj3+lXhCUuEW/oXnc/WhLYR4ogJg+48ejpY2OIsu6MzickyuXmVOWfhp1fHjvcmnmYBh2tpHy6mLF/voCOou1eE=;24:tQEt7xVeW4AF6PXulfCGF2hcoXTKVaEqGz8U+sXsUKtOWEEnCfJIXPyIV4JrnpWlV+POrld4qcJFFHIOa4oelxopKb8ZDE6k7kT2+0M8XVM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;7:0Wim23xhCVMeqI0QdLI/nMNtUQHYM2QeHmIFfj+Jr/1W6GpIA0wlZNFT+Ai7DPITiBfF3w5T8f4sWkcwNQ37pjIjnfDMn7JB80Voo1BpQFJrTZC40LtSaqAFtlg2/4T4arBok7XHRKH73aDWLrlPuKGKvRoB9p04Ty9UffzSMIBCsqoJF+W7vU9r5V3HStLLGVF0kVtBjUNa5YvIh0F526TVd/uj4L7MCXgjpR9YDBXZ8LSrnjvvwzlo1s7S7dvX;20:xQ30u2T/Q4loCG+J2JsyTY/EICZ14jH+yXh99Qh9LD1S3L5OMzAVNbp4MRd1fcLlmG/Ux4eda5ICvqrcHmE5Px1L783/AyaO4+a9qQW5FV8pVqotOJAx+uAjZPhJO5oDbzRQdrypNhJJf61uwplwfEACoA876pABJ1opcMNu8TRwp21QEz4JfxFr4qD9ttHqjunRLNqVKpXb1lr283gUAF0GuQkQqOD3+WUaITjfmuUQrFmYUMpRG/9CGvcAcCFv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2018 18:50:06.7195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04f974a-3999-4a84-947e-08d591b8106b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1919
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
https://lkml.kernel.org/r/20180226193904.20532-8-Yazen.Ghannam@amd.com

v2->v3:
* Fix table number in commit message.

v1->v2:
* Add parantheses around "check" expression in macro.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 54bd32d241b7..ffc01483cac2 100644
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
@@ -113,17 +127,56 @@ static const char * const ia_check_bus_addr_space_strs[] = {
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
