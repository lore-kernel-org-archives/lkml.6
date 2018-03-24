Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeCXSuL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 14:50:11 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:57948
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752783AbeCXSuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 14:50:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org, bp@suse.de,
        tony.luck@intel.com
Subject: [PATCH v3 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
Date: Sat, 24 Mar 2018 13:49:36 -0500
Message-Id: <20180324184940.19762-5-Yazen.Ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1229fbea-b676-45e5-924c-08d591b80d7c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1919;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;3:1bvDxSLenwReC5b8xrLvG79sHto4LcReZ4gPbfl8uc4ApzIW/+6h5IphrtGoItDXQ3EMTiPuEbQBV1DgYdjkB8e+ourYkz6Q1hy8xyMckPlE1HIzHL9RuKBzLWHxxzzxvxKZgkzesFOnHwTRnYNv/JLJWY5KQHZ2YkRg1kthSOFOQV8Ag3qRljJO0nXNVxlsX71940jcGndpq6ku0Tgd/HCG6DtiNAt21CGes8xlTt1qCGuBdQ+ANV05l9RuSVed;25:sJmp2NzFyg7FIhPqiX/K+PUlXOWNoQCRxrWTi246sehMjfuwfxwktxNO0jgfJ2LFzfo09MEbB5d26uCUYDfs/lhIyZJq4va6xObeyK4jvshHWJAtzglyBXQh8LY3q0nMDxKMIPf7cAlTkZRaoh5cn6gMntk4PV2S3O0q0ZMPf4KQgmdcD7mP1C5pcsUauXlmf8KEkfNlTNR3tN060WbVkBsP1ckndQy7+bYg2ehc7Ruse+Fp+udA1I7+oI4xBfkZPoTxR+VYFfeqIm0eY81H4pktgmXSsoxnWPzE/uDiW1foSCDp4hUhAG7gagAh7db4gSC+tyvMIbokQRkRb7xQQQ==;31:Pr3/uMApFZOwJISYPoF4AZNDyt16XwRfM2NRmGhKoukcB16Dvp31rfD6GwOlVmV9mXlXrPc6N3v6zfXm5pqrZaV4PMtYWsS146O33DCDY/5NPOFdpo1NRBG1NgHs80xaWnB4jkgT0ncCHyxD0RvkzFqtXpAXRghRy+Jf74YJBXUg15TB6cLL2yMjdA8T2Db1DxVLC7TZjGD+r5kYsea20HJhMEXU0dalFJYwPMKVAfs=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1919:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;20:0/xeXvdlXT74RaFEcszZ20chqP6CjeoqC0/TUZkEVDQZ+R1MrZwJb66yYCq3cCddOqU51WkuRafBOC0sW9RkEwjWywCDQZ7ayCaB83V9DGEsA3aR3RgOsLxg3SNna2qXMNBJOGL9a4dsqBUVo+LVbISxPi3K9okUbeaMVP9IExgEg7LcVgtTQ9/w3aizbLyROrUE4cFRhCroIdemb9PU22R5qpsl2ZK/Kj/m9QHfpCi6SWVKC2aVUgOKiZq+F8OaCO584a6P3sxNDePL2RttGKGapUKU2dcF6HgmeLBUU31EE8xboi/o3S8In27dbTl31AI9L3wcGn5p1REZub+pS7/GZhMy955LDSpCMuKMh14PWbvdhARRsjr/009jiu6qTXs1gR+Fs3q5tapq3YjCbojGjvDE6PWLUU0wRU+Y8hcvbFvIkhI9cFml1eDqyq54Vd2krNfcr+gHqZ0t99ZHCvJkTyyrBnQNgMJdZQlKkimr7BRi+joF0Mmwjo/bxQb+;4:Pfb07wY34A2mHxaHKktiSabQ3iJ+XUrwhpskRWjPV75BxSdrhwAyQ6/EHJuBTsupZU0P260AavlbPH9/dA2YXnEPBPU8afD1wgH2oizZK66nkDPV3tcjkRxOR1Bj9BYqTE5GTDkhPEDpDCBQ66vW7PSIPEzytVfPB+raIL4B7iYE9SMhTXH4QeefqHotvO568u06Eug/TaktgoTDCHHgEnWVHavZ7MIwvY6qRgypN4VZpVAqscGWY2m8NFf6EMbG1KoB0u8tcVv7YFjcbeygxtf5o3DfbYxBQu7TG8KIVbExqjypn0wRSpuLhPGM3mwlse01AFVaZNTvIsKo+O5wEg==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1919C44DD375D97808860DBEF8AF0@MWHPR12MB1919.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1919;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1919;
X-Forefront-PRVS: 0621E7E436
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(39380400002)(199004)(189003)(2351001)(2906002)(66066001)(36756003)(52116002)(316002)(4326008)(51416003)(25786009)(7696005)(53416004)(97736004)(5660300001)(106356001)(16586007)(76176011)(68736007)(11346002)(2616005)(386003)(956004)(7736002)(86362001)(47776003)(575784001)(305945005)(446003)(45080400002)(966005)(186003)(2361001)(48376002)(72206003)(53936002)(1076002)(6116002)(6306002)(3846002)(16526019)(26005)(6486002)(50466002)(105586002)(81156014)(6916009)(8676002)(478600001)(50226002)(8936002)(81166006)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1919;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1919;23:OBQ+cjJHURJNb44Z6cDbqWi8ANKLGBK1HFT55m+Ex?=
 =?us-ascii?Q?htbtwRjnrRo4QPkOBxuwQGwANFunNKLyaD6k7q0y5fRr/xtmgUzQZ0DmOCaO?=
 =?us-ascii?Q?1Dt1l7F3YEKZjOVSIyHogkx8N9cB102NeWwNTgYA/Dyry8Dcp8Sr+g9fll/s?=
 =?us-ascii?Q?s656PLy4WmYd5xmDve1RjzwkqLsiTAFLsw7D6bM3it7TU+KafFbX56NoSwJe?=
 =?us-ascii?Q?eieeTnooTidqxNuiIgyVLPWsI6BNqvK2xiz8pQKO4ixX9Ymo5GCkRmD7RXOC?=
 =?us-ascii?Q?u4ItlMVBCK62h0MegGrVm9uUEAnxFry0O1BcRq5i2aW+EDnZ83b1s6Fk0QeP?=
 =?us-ascii?Q?0LfxhUtfOrZUELTs0cU6Ys255mNWKOF9tsMt5CWLIeUxKFjL5QvwVjKyaqk2?=
 =?us-ascii?Q?CIhdDjEJyqsnOkC7jo+pA6iqvUhqxgHKrlEcXziiK6yXsKT00IGJYosIvF4q?=
 =?us-ascii?Q?BNzQrL+da+EA6vCeuDDs5uSgXW2WCxjic/WJmIzVwStyULiCylch+ZYhFE8D?=
 =?us-ascii?Q?dpTal1YILwd5fjabL6E4a0yOlm/Bu7Mn2slHlAIW+3/eYuybNWDKj6P8e5r9?=
 =?us-ascii?Q?hYI6e1acv7OFG+foAX3MNh5PMQNNG/EDY+S7Thp8kcdSSX8lCgMcKdAwfNOg?=
 =?us-ascii?Q?3pB7iKKNoJGjympfmdkoPbBpsqF+nWvyQoWDxvFEF24Uq1wsNty9L9QpVp9p?=
 =?us-ascii?Q?pm+CI/Og6YwD2JhKrlF6GZOZu0hcklw1fE9bs68G4UxNohhOawKHsvDZYNSa?=
 =?us-ascii?Q?8qdyLP6v/utvfNAunULs2M9Djsbg76xw/KlyXm05Sm1ZIVFJwv2BcPuI4spU?=
 =?us-ascii?Q?5cTxAYTm4JHV2yKwU+sRXcbTIWj5FN9fVMExO/rmyjUfHEUhXVOFenQWy5Ih?=
 =?us-ascii?Q?Sfe/4F02vtxze34RXPvor7EDhetsTzoZzB/H02GGcVIPP5Rbe26ShvCVFB7q?=
 =?us-ascii?Q?PSvJNKv9FYrdw7ep6yJBfO9dter/eYJdxMmGTlOfBbZ59ic+B4F77sgZGQxM?=
 =?us-ascii?Q?eo6kUJc0FAmG/qPhsPc0FxXVTlOAwEkXviUFo9Q51vcCsO2gogCFHVLTWNRI?=
 =?us-ascii?Q?o1+gkS5vF9j43rJTDl994k4ruLtooe6HxOZljBB57v7Lt9GsRCJfwAB3gDr3?=
 =?us-ascii?Q?u3lLdNYd/mxll1CVh/CeF6SKJGFl8wGEhvbUQ/yg8hJnVZLdF7CnV5VxvtYq?=
 =?us-ascii?Q?4AZEAl7GBtx+o7KMIU7bcybjtsjqIL20Su8HIrfVGmhPfh2qNN/ujtCs33yg?=
 =?us-ascii?Q?cCiy24I6dNsh5tsSCTLk68TJ7ckbvde25Muuz2JB2Z3E7kOJ3epvZWxk5SLF?=
 =?us-ascii?Q?2N5ESPsVrGTTILxf4869/E=3D?=
X-Microsoft-Antispam-Message-Info: 0rneGJe8oGj5vubFwgYBkv4FlYeYykMzsx4hLdOe3eAarM+yXYHsNfj6PdrytXgzhflvYXYwmZ0DwNmM+Kh+pVmWUa/HUSvVWWywokHSO1MgLFzDtKoVON6Q6qxodUs7BHf8HgTI66O5spBeAV+AfBPETfGSl8k+MDuzfXzSacDjqbT2ecKLp+8HVbYEe166
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;6:Kk9S4yuMNpjP1DhvLcdPCmtnWS+3wVZOhbWD21ar6pHQ+XLri9KsSJkJuv28m9mTTgqgCPcgcVfPo4aJsRJabU63vJzd0+NPr3T+NNT3643rakJrJEqY1hl1JpSVo7nmS9lQzMMFMYNg+nqiQjY+8RlLZ6Tr2mW+9L/cv4FXDk/W+Fv4D6VXuxmkWe3iakFu0+TbuBeRscsPHPUFSF5aJ4z32aK33shWVs5RUlRUuf4OzBcsUiTxwsNcgCZZbmlbQ58dYkbo87HlZhBZ0X08+Av+4IARqMTwmZCtghV86OqPFjcHcC1EA959s7XxVLClxrJqH9P2TrXKVFEv8im0QJ5VjmijL8jqfnAuS8Ob716jnZson7+GP9PQ2Yhj3fJYMB1UQDAlnXGUDQhFEnjCtSBfOrmHwfof8VJISOTYNUeSTxrHjAKPIP8k8oMgCjZdYx+2snTygtSJP4/l8eHWzw==;5:bWxCTNS+9Ji1ByTcprfJwymxln42TvkfYbwFBIr+qL3oqqlcPdfvgYq6/fUbWKIBQXRVryjnkKWrUJxJcKQ0StKX55MKPqghgkRj4LOJ8U2DRhGlTbZFDl4ByLYIkZN6JLbgVHKj/JTkpznbO6FLKWjhdvOl07/AHTKCxN6mTmI=;24:EwxJ0ocSTpGoqEC1YN+AEiXJSOW36PQQ/LREsCxS5iA8snjFaT2azKMRKnkGjbf+OMFv9aYkurgfdQflWRJCEtPx6IcjnDh88flRgW9cleE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;7:azAHfQBxl9FpxEHdt0QtzTYp+64O/sFr61CVP8iysIql/ozVKd31eDme38VAuyO2qf2ZBhWvGI+PVGC0SVxe+VlZ4d5rqdAcyCkEcQzZRimxsh2BOvEQsHkaa9dlyZItDZXBHk7k7s7L3JApS4/WFIUuhGvec4dbNmHzPkwcO4/uxPuqgzH9tftYC9SXZcGh1qTRYdv/FzGkJX/eAw/UBItVQ11cD7ByJRqmWINJSfV3c0E43IDvcr3j1C3uYP38;20:umIww7gKWt6sZWKyvIcGqTe1zUm9OaXTzvNEue0ZIK7/QEgE53eru3nby8cUxbo83L3z/fMUtTcZup9uny3SIKDxdvAodxXclDCkyhhUPYepx2FWB2Iib9JgQ1zneBttINrjY1rIV58VmD6pGT0qdonHn4kfGeNJF0DoQ7BpiNv61ywm8uvArEd22G8Pwk9LTI6GpAFNH0+MQjtZbinf3Q3PS+lgB7ITLEMlvHmrM5NXEVJh6IzdHl+HT8k0Lkyt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2018 18:50:01.7977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1229fbea-b676-45e5-924c-08d591b80d7c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1919
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

For easier handling, match the known IA32/X64 error structure GUIDs to
enums.

Also, print out the name of the matching Error Structure Type.

Only print the GUID for unknown types.

GUIDs taken from UEFI 2.7 section N.2.4.2.1 IA32/X64 Processor Error
Information Structure.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180226193904.20532-5-Yazen.Ghannam@amd.com

v2->v3:
* Only print raw GUID for unknown error types.

v1->v2:
* Change use of enum type to u8.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 47 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index a9ab3bbf7986..57fbea5b3a8c 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -13,17 +13,53 @@
 #define VALID_CPUID_INFO		BIT_ULL(1)
 #define VALID_PROC_ERR_INFO_NUM(bits)	(((bits) & GENMASK_ULL(7, 2)) >> 2)
 
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
+	u8 err_type;
 
 	if (proc->validation_bits & VALID_LAPIC_ID)
 		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
@@ -40,8 +76,15 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 	for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++) {
 		printk("%sError Information Structure %d:\n", pfx, i);
 
-		printk("%sError Structure Type: %pUl\n", newpfx,
-		       &err_info->err_type);
+		err_type = cper_get_err_type(&err_info->err_type);
+		printk("%sError Structure Type: %s\n", newpfx,
+		       err_type < ARRAY_SIZE(cper_proc_error_type_strs) ?
+		       cper_proc_error_type_strs[err_type] : "unknown");
+
+		if (err_type >= N_ERR_TYPES) {
+			printk("%sError Structure Type: %pUl\n", newpfx,
+			       &err_info->err_type);
+		}
 
 		if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
 			printk("%sCheck Information: 0x%016llx\n", newpfx,
-- 
2.14.1
