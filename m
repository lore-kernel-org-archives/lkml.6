Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeDBPHg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:07:36 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:48864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752093AbeDBPHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:07:20 -0400
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org,
        tony.luck@intel.com
Subject: [PATCH v4 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
Date: Mon,  2 Apr 2018 10:06:52 -0500
Message-Id: <20180402150656.101022-5-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
References: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN7PR10CA0030.namprd10.prod.outlook.com (20.176.16.43) To
 BN6PR12MB1905.namprd12.prod.outlook.com (10.175.102.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f7c2a6c-4cdf-4fab-2ca0-08d598ab6b61
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;3:wRjmHnqnF5Ru6LROWW+gXfGZRl9iJhWXCv9ZhPS2UezRrMmNhvGNg+vGJBs2czJllP1L7S7CdSdxuMopaXHLo5De4wUS+8ZG9gog7aNxt4fl7IiNiyBq4LMjN1MDzraIp8oFeG7jIXAfVbkhgNT+JDep1R9/yLR+OX39W+mwO+7LkhVcoDUnBIR/dgGBC7FtBqJboE3Ku4VAlhDvVY6MLW9EsoSf6r9tElaaidBNOLse8MHWCWGFr3swijcL2xif;25:FnSs7W2P7UoCyum85wo/VVpZOQAeLbXlZtOpAYLwLH+qz10eeNFU+hbizLlw5d5yYJfkxu4cld9kBzRvIcEErkGG7DOrIGLURjv3N5pL5uUc66phn0YuzOCCBsDhaPX1J6s9/Ste/YZSmOKHWByUaEdgkCxmiF/wValSe0FUeAfMLOVBavPAged0lRUu4YiMdwQvnEC6kPFZCf8QZMJs07sgnWO0UIZ6EvVGtuzF1UBlowe4eD5RdWABF5UT3ITGRfOK3/FHruDXwO23LG5lzLG5c5QXRwqj/h+I3Zjl3SNy75zk7yetsNpC3cWk0gmZtQPr5dp1IwUeHjndgTugMQ==;31:HtaGdyJampGbehus/kBrbYO/veDjgfi+SSzuOsprKrN/8i+0n2dr65Hr3PtHuPFrBsuQzfvQhWm4MNtrD16arwQWyaWIcO37RS1O57Nyq/E4FunBcBEM+V/JjZAHeeIbEcfYzhmIp6hRZiujt5K/k41jL9NTsUFJhNR6wczdHWgoJx4/qaD7ugY+TiJMUJ6YCNaEjsb6GLuLu8UDLAEUjOZ7V0InNlNb1B6dLNP+huU=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;20:BuEtxROWKiWgaUxtbZjod2DF5EX66NaU80WoC5uwWtRX8GgueEQq2LxHxuWaJVLN9JBPzBCOFC1CY49M6LTJ3efA6byPzoL/KMffidXGFAISdO1MFOEBkyOsNuclWVcbWnzh9T7ErlCyTLINZ7quCXxtQto+p0p6PvhMIbQzadTTTNzNvKNOctkixmfoGvhsKyXCzIuCQxFBbFFjtNDmsaoqkAwm66vEOVH1vDKFSnvoU6b5regorjBeVs6qO7F+tycmgk5AIGhgkwXawLssA9+ZEi6FSc2IvuqT+VUYzyxj51EnMduml3GEH+Ykagb4cfiNYe9M7RpOSdE7XriWNPKz8N1zpt2vNUThdQ4VLSQCGMqVdBzxNUyJAQuuaTeyKZhl5mgd6s9S4Ul4nGHpUGI5rHrP/tm/GmpF5dg+iUnX98vCoC3g1C6zuFQcXGKgKn8W2WGiCFVRJPy2XZHnrZ2yop8u9h37T1+7J2f1W2uUICDvNf/3UOb79s7159ny;4:9mf+LEOOslMkbPSH13qjiHnGe9mjuLZibYonT0RfR5q42sezC6wobp+XYDE53p2E6sQEjid8pkk/gZs0T6eAlS3THqEXLUdg1MeWwuzWCx1AxJK7wHaXhc/smzw04ndlfS5aokzIPSthGCL9neHck9IJfmoLTjhQaQTuZUZN9jjb38kPF70C960aBBHl7/3bKVFsNSuQTM4ZzgcKl2R8511jTOsSQiov4n3c9uEDfdZ2gGv/ZxQ5Qgou6b4scPZB76cGAGZH/ieJjC/bUm8p1Gzfqn9k5Uo42vDZmByrAxKO/0JnOF3VJNRYeM4PxXMp1mMtN9/9rG3W+B38eCi6gX7rgNymGvftfIj8A/Aji6g=
X-Microsoft-Antispam-PRVS: <BN6PR12MB1905C9C3EC9E8B319B59CAD5F8A60@BN6PR12MB1905.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(2351001)(97736004)(86362001)(575784001)(105586002)(25786009)(26005)(6666003)(6486002)(8676002)(5660300001)(106356001)(50226002)(8936002)(2906002)(16526019)(81156014)(81166006)(2361001)(50466002)(11346002)(6306002)(66066001)(53936002)(386003)(48376002)(45080400002)(1076002)(446003)(6916009)(6116002)(52116002)(68736007)(4326008)(36756003)(3846002)(7736002)(76176011)(316002)(966005)(51416003)(305945005)(7696005)(47776003)(2616005)(478600001)(956004)(16586007)(186003)(53416004)(72206003)(486005)(486005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1905;23:8ywj07spz6KWVmwj/BMF6n70JEfcMZHtQM1Rkmq7y?=
 =?us-ascii?Q?3XTB86e20AztMkPHvGfqK3aDKkznDucKUv0J7eiXEXeJ7OOSLo5DamfWsdxL?=
 =?us-ascii?Q?T/AFfo6qVMabyswNGiF3L8Q1QszzH/x6udxHpZtJEnQsBpXQerJ7/X/io+VM?=
 =?us-ascii?Q?bWw18WdK7HL57NYzqzqZzdkUKIOaH8q+K1/sEK8CTzLB+ijesQOTF97SvQJk?=
 =?us-ascii?Q?2tzotGx7REJt9VBW9N2a8OPywJeZ7WSz+hUb4FSjqJOdAXG5JjvSGK86nfrU?=
 =?us-ascii?Q?Iq7hcS6jik+EMy7F7wbanWfg6YtlylDkWnjs0pR4+PZVS9gqr8bFd+0BF2cH?=
 =?us-ascii?Q?KKEFU/wtcTiFDfiCJN0z922b6MD40XK+hyngtX0ngLhJwQxVn/fTWkaAfbqV?=
 =?us-ascii?Q?phBF94eQXcaP1a2H9cLIAjf5u4XtGMYUXIC6El5EBVs/PcNlIPrBpRfPh15j?=
 =?us-ascii?Q?F7ePTvccOSkFpTubj2IXQY7LJMVChZRvDucXYY4Ph3xC82glNCmi4N/UVWgX?=
 =?us-ascii?Q?l07IhpurH9KeqVVp8CFSvJXPTlcFmh7abbNnIg6GjAhbvCGiT6zgDnx9Q+Bc?=
 =?us-ascii?Q?nNprxdHAh5X94JCw7LWCC5ZfDzWv5odd2ll9hz032rdjp9kimgbtQ/HwDfKC?=
 =?us-ascii?Q?535LN/GgzIesEi15ylzMuZFwv8NX4roX8BFhYz2P+7w9dO8jUWw+tH7ZI0y2?=
 =?us-ascii?Q?bHyjcj6WuTu4Lx5BQcXVoEcTK+5MpXfkOo5oxFoDiOiFdybukTIA2a89iidp?=
 =?us-ascii?Q?CWAzEOlwzAaXHaYOa+efH69YN5cshg0Ez7Di9RbDWKqefENnGO3V0DLW5eZB?=
 =?us-ascii?Q?BirPNdjB63/bLs/3qtc7bkqxGHdw/ZC4H0EmR7GyC86Nhj31pGnfvvvk0Ugl?=
 =?us-ascii?Q?DUuCy8LwukiaBTtWiYU6gih5iRR7dVhYKYv3/yeNeiblq518n2Hjbn2EtML5?=
 =?us-ascii?Q?U1kNgpDy/7mu7ujJ0baMFM9rMq+gWsZdseJxVSLwf8sXYjnDMzGUl9Eolkb7?=
 =?us-ascii?Q?oXFdn4Q0Ep7AlPDT+2jYGw55vKbmjWgmOie5jUxFQ8AHuzfSRE6NdI4AwVnj?=
 =?us-ascii?Q?IqPGfEO9xCO2T1jTZq5yArcC5z6QUbl2pet6FwD5PlxFDPHsLh2WMVFn7YuH?=
 =?us-ascii?Q?h3uM1D85u6RcDi9fxNNGmFzpzKNYuhmC6O+OfTkunxKbeJMEGX+ouRNq+hgG?=
 =?us-ascii?Q?Aq4sq2z+sQvosqDe9TFhATHjCy+MPs/CynZu+rn740lg5s99kL1vmFOqFKly?=
 =?us-ascii?Q?azzRAYEmqUGs1fCxk/wLfA/sXgdj3v9mp3P8v0N9uCSZNY471RwpfdVdH6FG?=
 =?us-ascii?Q?2/W1uo/FX4yBgiVvHH0lubr/yIU+FL1ejm5tTt22vAzvzkwd5Pm8nCcJbxXl?=
 =?us-ascii?Q?izU5A=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ki2D7LqHbn+ZLK6Tx40bfPDK2asPu9mpi/1J7xpvErMv9sxj4vAveq5/mqunzqDrsdz3opaJytcljxaqUZduHTQtXGZ3PBDP1aASuGKzHXVIabtNH4WWFAHST16GSRObDan/oLtugjVOx23h87RdJ2AvLa/PJmzCEIyE7VVEkfaSjFdPvz2u2p+AxcAWzpZT
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;6:9UvcUL5DlDwgz3+yYr8tVXEVhjDT1ihcQVVvvw/X77WCER7nGjefyzndBg4sVmqIrcaCfB3hAt0U6BqJSRwjkzsDivT7BotqxKyQaIL0hNXiFGOZpYZERk8js1AUCgmUulRFJ/4OdluY/3CpJVne8m7Bca3MRVABxWFeUw/gZpkDHOEX1gXY4Z15DCItFgwTbjgnTcbgW1110XFOrkSb9E23twH4ARREJsoxgN5I8KEX1xi/bsY10Ri5AiEqeRE6cHeH7KClg1QUs0HnwB79ibHgmjKvMQYc2eHN4Uiqq5Ll+ILLEPqYK7Mw6mEE+fpiOi4+LzJYO9h1v+T8izRcY7+aSGGj2+71YtNTUwW1jdi+dpmLmv54vDqaaeN7P1exyHBNVwa9eUJKKgclDrLP+bzb7jMMI2EkpFQ2WPSgUdDmsdbld0Dddm6//GnGDpW4qrqw8JR9mnQaVyZB+Ab7Yg==;5:eOs04Gukm3ImPbQmQ70xSm8TOYH1tJAkYVzqlkNVU51xyidJuN1ZyxvYC49oy0Orl+6xopY0sgWiQrMJfSQGkEQBfoDXamWCWCGTqS64EG8Ak2323AuJx7m8Wp+cIlUWpNYj+D2BUNUk5BCc/uA72V30AboDEdaZsncd4wZeEIM=;24:4JLOGu0oB2jlqLXIgXJhF2BPORFP0AbWYGL0bEV6QCMlNJFCeUBmahZPJf2zv9HhH4y/y7ogWOlg5zNp8nmdkrRrjvO9cFJ3GIykcSgY60s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;7:o9JwHCZfeU9n3Tejnq/y7juYVw91DHJYvjGPDtYgIuvEybp3lmngGbsE+epnaQUHfYP7OnDEHGCLa34yFML8uLU+f8vUUjkA4o3UtzjEEgJAvHRcTzpzJ2YnxLb4ZbhT/0l0RZ+RT2oHDO1FEdaSOWCFL88GkX9VGQf9kaMA5MyGnD9CqvzppQcGXd4s9d0Cc73DPQeeXThrpPiN1nQzkcSuuVYfhOQ45pLK3KjsLzmz5GzvzIP+H+emwuMp6IL9;20:H7y6FFKM+RPpXf5vArixeDBJXpScSWGm6UGw773hhJTBTQvKydXhFWAFw216uFqcicaBKervPCNqGOhhTb0MKPjTxEw9y6dsGo5Axju4r7i1ufTMylZCOUsoI4fJmGKoLnQxBHMzRbL+WOgIUgrt9TRikIOFvw+4o9ZLefQ34GDQxsyYB+T9ihecCVks2pNylXhRMdH9AEQPdbB5EjJ/DJFfMwbNJ3nMKgqdGWGxHVwPNwPK//QAre+XOLvBqoAB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 15:07:14.6829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7c2a6c-4cdf-4fab-2ca0-08d598ab6b61
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
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
https://lkml.kernel.org/r/20180324184940.19762-5-Yazen.Ghannam@amd.com

v3->v4:
* No changes.

v2->v3:
* Only print raw GUID for unknown error types.

v1->v2:
* Change use of enum type to u8.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 47 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index e0633a103fcf..5438097b93ac 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -11,17 +11,53 @@
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
@@ -38,8 +74,15 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
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
