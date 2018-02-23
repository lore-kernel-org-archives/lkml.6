Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933591AbeBWUE4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:04:56 -0500
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:12992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933270AbeBWUD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:03:57 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
Date: Fri, 23 Feb 2018 14:03:29 -0600
Message-Id: <20180223200333.6410-5-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR04CA0033.namprd04.prod.outlook.com (10.172.163.19) To
 BN6PR12MB1906.namprd12.prod.outlook.com (10.175.102.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e686fa95-de76-4b88-7a84-08d57af8916d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1906;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;3:P92js67yRMyEMbYf3EAFZY4O2llJ6PH5GuWefLmnfE+yPrb7GzASjvFYV7hITIp5B9pQIcvCX0T5jle+h7pgkaFWa3PEQW5HVhyVJBaWP6DomiFhl/oWYRygzKxknkgsYjA15b7f1nL6wvwoBWhnkOdLB5xobDLPe1428EuhMCeW1DqekM6oNNipHl4uYivQ7Enjvf3oVdukbmAd6DbgwU8TGpBlEXuKjbQGl2FvNmohj73d3EcA5waTRdn7AnkO;25:fXLn2lCZA+sUBvUfT2R0/G9CQ2wS7AX+UiwZpth/p9S2+WhC4JtrFxbeZ0ZsatsEuUXSn1WLvtDL4LNekAbgXzHovjLhSnhRvCKhz09QulDyMtX+Hw4OGEw8rRh4sqCWX4TxPZMeGAr0J0m25mlrPKbe/x8HK/nIgYl2slW/5FAZ72mm65dh0bv8iLBn5/GqzI0+PBhq6REm0ZvGt44JuZ1YSt06TBVBJOqYbmKHMkk3mwbmI7lESe1Au1CGkQ4EeiJkCzQ2ClIqLlEX8kOh+4l+RL58KuOzKNsU0R9ssRKGQ5Pp4k2DkLy/0unYP/ZtZTZ0SMBA7spjnGd/AKZf+A==;31:Ot/PMwhGij9L/wo8p8+qQsNHx7u7+uU/7/IhAyUwCQmz620sclVl2nrvsVa8lBeV09e92S/Um1T+u/nK4tYMv6IfgvGH29CJwMotmlfyiTrBjElYM5giOW9BxZGrRnonRxaHQZWBig2iy1nZKURzshvxYGMRg7NKtqU4Rev0v6AVKxzSgLqwjG9ZBODRFmemZDrQZUYJ7vcld6UoMA/5mB6Tcx4oFbXkYbJ57S5JoQ4=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1906:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:BwRFgr9YnpLg7IIRSr9quJIrf77TCep/L6G6yvyCkmAUR3Q+WBU78s9PMgzUhf+OlWeDHUw1oxFn1YmlnTyw5MiocVqzpCN0oEL3GPdQX0zQs0EQx9rnxRH1mw2gCgGqSlw/sDXrOwph+fm+IH7fBFxhqiBR7C0mChdTCiPP/7qu1WswzCAS/1PVMkY4rVSUTZydE62A14jcFYFIU2D7lw9CIW6lNtP5Tmp9/5vjKGfW3oNvl//HmgNVz+mSvwZLZ0gp5ZR9T6tTv+yKCWUjqXJ0XAj7HbTCo8uMQ4st98j4835pcFrvtaI+dVBxBa/tCQgJ7Am0OHxOLNAUZHvDeszvN0l0smj7JxQotnd64IInNTFz8Y/cKKFJCVcM5MPRxtYnCJ3hVKgKFeKjwhrsD8zKcGkbfxEmZRrbbflasyvFh/Lr3sCzDhcI/7WihevePJPMFS6HG7CveHehUJVo+AfsKgBYeWidWRjIbheCjgdRsjvGNMZKTsb6OcIOdmDR;4:jIP2NEtgBv8TrN/Fsf2mdMy5Cv12/SbBlVhvBNdc13b8FDbwy3ZD1NezoDZxQP2/RKY5mmEPmGE/w/EKduXCdEX3DOcCTcTbNF2kzUZ+wxSqIv/zuYOx96WcQR52ueECFSz2L+F3E8325U5eU+OFSP/buuRk2PahgFCzMVJXMUycLQLn6cJCYeIqf+FmAkNCiIDONxuah83WM5NIgDPlt9t5fL1o04qQljqBXf2u3PUbmURIpJmMz4BSR9rQNArK/1wnt5xsnh99C/d8knmFSHI0rkICMVFk2YoGaAOed0vls4iJ65w8CVTIwT8Vn7ybNeoZP/iDx2cHDPInu0Khmg==
X-Microsoft-Antispam-PRVS: <BN6PR12MB190629C4082C27CED8F454C2F8CC0@BN6PR12MB1906.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1906;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1906;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(39380400002)(346002)(396003)(189003)(199004)(386003)(50226002)(8676002)(478600001)(8936002)(81166006)(81156014)(106356001)(26005)(4326008)(76176011)(2361001)(53416004)(51416003)(72206003)(2351001)(68736007)(2950100002)(6116002)(6916009)(6666003)(316002)(16586007)(66066001)(25786009)(1076002)(2906002)(3846002)(47776003)(5660300001)(305945005)(7736002)(97736004)(105586002)(48376002)(7696005)(52116002)(36756003)(45080400002)(16526019)(186003)(53936002)(50466002)(86362001)(575784001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1906;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1906;23:8tYla3HMiGj//A0sVBAJNRrwvC7Mx49pssnDoZ4OR?=
 =?us-ascii?Q?VEcDODdASx0vKCfktwqr4KQmVdV9vKbAHGY4doBBeJbLJiUXMXv1VI+B+yDJ?=
 =?us-ascii?Q?QFxgjvDZmzMJwjbuR2E68wfPR1lQga439ayits+UXss6X1V+hhtgN81bGrCs?=
 =?us-ascii?Q?bsPjtYazF3LIovnI7Pk5h1Gn6074c96himE6fGWVI9AzGCjVtxA0sJZSNqY3?=
 =?us-ascii?Q?M0DmSzOXGCFn/tTOg3Rtge0aeGlVpkErdgHrNQtaD5qDW4IA07/cpN82c+P2?=
 =?us-ascii?Q?lOYd4nsxJ0eF6fy3nu/yidRKBOSEa80MJYaEjACFtAcbwnfvGUAv9+IJaDZT?=
 =?us-ascii?Q?ehqG6SgIjFnDL3YuhPDC97Y9xAoyalsF/G+jlWUPh8fS6ZQYRZVhV2/r4yY4?=
 =?us-ascii?Q?gMxYzC2vVmQdGEVeElVtCHRUSFtU0pWFUy30nYm5NPhqEFiI/UMMjH41YbIY?=
 =?us-ascii?Q?aTqRUuslXEVWG+/1STjPT9R4oMx3TLPFd5yHeErAkCOsF2RXfPGJGvBDOM6i?=
 =?us-ascii?Q?zYKouI08hRkCd08wz2mUwlP+XI4JjnpKlezSw6NZwrNlVfxz4A86NZz5iplV?=
 =?us-ascii?Q?v+htuaVjicwJtfhobLGE0w6n6Q1QVcg1CReBxCfTUyfP2rSBPPiRndbwKL/s?=
 =?us-ascii?Q?b0HWK71UVfhaejkZBEek9zYtjUS/Ns8RG+jv7RpMgw/byHhR5jSEknvg0klz?=
 =?us-ascii?Q?8CxufqpXpsOgTcmZ2jcmurkxcfTnvgUEdvFxGIOU66UJ0KhK7+ImfWOSNd1R?=
 =?us-ascii?Q?Zo+AYu6g3+2/U9mMmuxcgjMxU5tOYk4Sm8ehSXVEAZ0cX4wR28z/uZhGwpun?=
 =?us-ascii?Q?lSspie2S1LYd7Yr22eorrUxVA8a8kUuBrJwIi4ZNvOoRT+aw8DcBlefk4BhB?=
 =?us-ascii?Q?q0suZCf3FO3m21m/Fy0U9KrhJ586uMk16x/tM15M9+5Adq1HBJa+F7p9h/Ti?=
 =?us-ascii?Q?tcjCZnr6m1fe0qeNIQT8vIG6U0wJ9ThqRO/qqKhc4wul2JwRl9Z+R1wh6X6o?=
 =?us-ascii?Q?Y6zzF3SVRPkoAuYduKgvlJKuwvmYIAa/f9yNCid3NmJU/ER/CYywYlR9W+Gd?=
 =?us-ascii?Q?lgDK/uxr9hJIpPFpsKlyYNHQXZFSRjqynnDcpfZQlUvx0N2syyXphqx/6sZB?=
 =?us-ascii?Q?99HtKqs8xij9TYzqd2hyJyo5Am9cSpni3Dvu5eNdj958OnN9QnDheJkO7JnA?=
 =?us-ascii?Q?l0xNrnvKn1JZq+SGueY8e/80Ta07bAQYXmHw+XMUzsvEuFvJ9fzHzUV2g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;6:r9CjuRKvhVq/BUjGvMaYZcvk03tavP8J6jBi309UW3co1YoSzXr8jNwlZbXpegDOnFKNcXtkaoG/Q+anuBWJ6mwTXSChxOGRPxrNxk87HabK5s+pwLw3USAR+aO9feI7hfTXz33XsL62RRVG6l1T6z4OdPXW1GsrOec1z567s19oGGplSX2jhjRzSQYnyh+mWmBHh4mSF/vymcBtsO05/0kEiU3uifImALcGzvkm2eyLNOZ1eKGUTJA/1ES0f0z4cdyEM4EjXH++izlBBCPrqQYjw1vP+08NM5V3ZlzmfaeVkoaqwuvdMkRO6N0LTcFzlJEw22JpDtCOXoBEGdGLfe3HOHPNPjzRIktjPLpdR2k=;5:oe2zNccY2yKFuIg47LAJMeNmF2R5cItu5KlKwOsnUNqo0SQPCZseRDuuA3XOBXZWOHUg2EeBjqIwAjwTZ9NQe5k//lcJjGS7RB9DL++H30A89iKJUA07siP9ZkQNgt5gJswn7toIIgTnnCraj3PPK3vOouj90tRpaeBJhj/8nHs=;24:W9dOdhF4WMwe8NgfAt5QUbcW0yuaq1V6Rn63NC+Cwp+IoIiRozvVlgKCK862Jlaq3OX/c7rSyTSXEV5aMTgf7+ueqfcITlhy2PT/ROm0sdE=;7:mtWk5SNs0Ms/sNd7iI40BaXGCu7ywZnT3Kmg5hv/Nf4kuMVq2J+7arKq7EmFFWYEb6jS3+/d3aqrsgfX37d2OMKX56HAuWPk2H7RiIIDjNsD/XfqzrMibcI+TxkfBnOGmA/sSQkzGCg84ByTGr84K4Uc2dWjcUHPompajJlfJZDw+LmheQoXedo0rEvcBthDfSi7j4jb5JKNuMNOvL3q2uNonRAjOcGW6TFPTz+J7IRDzUHHtvEPMAikRDgmLN5z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:YUIzRZyd7zHwMMc7BfddgVc3KzBPDAvVNy20h3J+KeVSF14HGzwkKYN/HkiNVoJueoKMXJFHUu6Kw78q2ogkDjvyU9WjCX37Wsi2zFrcjJSuz0+ywqMrWJb6EgrYju3coYBY+iy7qVDjfPJS+rfDPg16x481j77wmhqgGguuVxM/UQb6gk5ZSC1g9Hy12+r7drpiaHe2TX92/FLA1aUWMFiMPAPC377lLfLeG9M8jJz936IXxgu6vlLPPSk6U8m0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 20:03:54.0173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e686fa95-de76-4b88-7a84-08d57af8916d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

For easier handling, match the known IA32/X64 error structure GUIDs to
enums.

Also, print out the name of the matching Error Structure Type.

GUIDs taken from UEFI 2.7 section N.2.4.2.1 IA32/X64 Processor Error
Information Structure.

Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/firmware/efi/cper-x86.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 9d608f742c98..3b86223bdb67 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -14,17 +14,53 @@
 #define VALID_CPUID_INFO		BIT_ULL(1)
 #define VALID_PROC_ERR_INFO_NUM(bits)	((bits & GENMASK_ULL(7, 2)) >> 2)
 
+#define INFO_ERR_STRUCT_TYPE_CACHE					\
+	GUID_INIT(0xA55701F5, 0xE3EF, 0x43DE, 0xAC, 0x72, 0x24, 0x9B,	\
+		  0x57, 0x3F, 0xAD, 0x2C)
+#define INFO_ERR_STRUCT_TYPE_TLB					\
+	GUID_INIT(0xFC06B535, 0x5E1F, 0x4562, 0x9F, 0x25, 0x0A, 0x3B,	\
+		  0x9A, 0xDB, 0x63, 0xC3)
+#define INFO_ERR_STRUCT_TYPE_BUS					\
+	GUID_INIT(0x1CF3F8B3, 0xC5B1, 0x49a2, 0xAA, 0x59, 0x5E, 0xEF,	\
+		  0x92, 0xFF, 0xA6, 0x3C)
+#define INFO_ERR_STRUCT_TYPE_MS						\
+	GUID_INIT(0x48AB7F57, 0xDC34, 0x4f6c, 0xA7, 0xD3, 0xB0, 0xB5,	\
+		  0xB0, 0xA7, 0x43, 0x14)
+
 #define INFO_VALID_CHECK_INFO		BIT_ULL(0)
 #define INFO_VALID_TARGET_ID		BIT_ULL(1)
 #define INFO_VALID_REQUESTOR_ID		BIT_ULL(2)
 #define INFO_VALID_RESPONDER_ID		BIT_ULL(3)
 #define INFO_VALID_IP			BIT_ULL(4)
 
+enum err_types {
+	ERR_TYPE_CACHE = 0,
+	ERR_TYPE_TLB,
+	ERR_TYPE_BUS,
+	ERR_TYPE_MS,
+	N_ERR_TYPES
+};
+
+static enum err_types cper_get_err_type(const guid_t *err_type)
+{
+	if (guid_equal(err_type, &INFO_ERR_STRUCT_TYPE_CACHE))
+		return ERR_TYPE_CACHE;
+	else if (guid_equal(err_type, &INFO_ERR_STRUCT_TYPE_TLB))
+		return ERR_TYPE_TLB;
+	else if (guid_equal(err_type, &INFO_ERR_STRUCT_TYPE_BUS))
+		return ERR_TYPE_BUS;
+	else if (guid_equal(err_type, &INFO_ERR_STRUCT_TYPE_MS))
+		return ERR_TYPE_MS;
+	else
+		return N_ERR_TYPES;
+}
+
 void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
 	int i;
 	struct cper_ia_err_info *err_info;
 	char newpfx[64];
+	enum err_types err_type;
 
 	printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
 
@@ -46,6 +82,11 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		printk("%sError Structure Type: %pUl\n", newpfx,
 			 &err_info->err_type);
 
+		err_type = cper_get_err_type(&err_info->err_type);
+		printk("%sError Structure Type: %s\n", newpfx,
+			 err_type < ARRAY_SIZE(cper_proc_error_type_strs) ?
+			 cper_proc_error_type_strs[err_type] : "unknown");
+
 		printk("%sValidation Bits: 0x%016llx\n",
 			 newpfx, err_info->validation_bits);
 
-- 
2.14.1
