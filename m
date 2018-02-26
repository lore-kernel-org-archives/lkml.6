Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeBZTje (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:39:34 -0500
Received: from mail-by2nam03on0055.outbound.protection.outlook.com ([104.47.42.55]:51904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751521AbeBZTja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:39:30 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH v2 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
Date: Mon, 26 Feb 2018 13:39:00 -0600
Message-Id: <20180226193904.20532-5-Yazen.Ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 07be3022-615a-409a-07e5-08d57d50a6dc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:jJTgY6xEU3yvtnHdCzU4E1IG+tL6B1zKFyL9+AVYPmCzSbz3j6Jgs1TrkuJj62dd5azTrkQ+ue/YubUgP6rowKTopPtxR65SbdDMhNraIlIzm+Qd3Lwz79NABaKttykT9hoO48qoXWoU8hhlYGeZD7WDeoY2mvVsDDzeFR9MkOZJe7OyGpObaScMynTY1OviK1yHaesqySV4w043fjuKQFnGtj6ojF7lr0PM1hJB1NaZmgVo5+Z2g/DSWqddfokE;25:MH6h8H5uXYr9+UNmvDTZHhTTRbUiqbVibTo3YuBFNdY7GX8lrYNPOOdWWfhDWnfEq4HPGWOvlw1a/kMOyUFYWf/MkWAzluLaoH7F3/fg4v1tq3mIdvDjOk14Fs7cdIeN7Y2FxeAaONyCF7PMqHc9b/iI3jHEfsiysulJr/LRxpJucBR9zeCAqRHw6dDlV+wCak9Z6q6FFzPnmVyHkTOY8OYFZGLqab2ugkoZcDCN/SKRGpETaJm+Z7JcoeYNshT6MRQaAfvq0KQagYrOxNtQzVr2GJCpRmaFGU7T4m1A2zGHvXcbV2PaT2tpYaXY9Rx79NqXJDBX0l9emEAncgeYpQ==;31:WXQuf9k7zx3pB3/G+5qoofWsDKDPWzyiJDcOKVf6IsF/+BIa29wZrHByZmm0UiKMwXb5CbPKGFrZzTnfO4pi+zicl/swIQI3aX2jQXvKp22Iwlasjcat/euB3Bf5FhqhxClF5c4SVUZ/9/jM6v8wdJWCCWhDLXTJN+SMh/XP72Eeh5209KZfuCR3siVcmtrTOk/ckMY4CsjraJNGa+zYD8YgO7/7N3AYfXu0H2IZfLg=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:4tXE4h2z0nOLMWL3kcbQ/Fbe0A6Pf4NPJl2KWtDDUdRsySNa1eexHKGWwVDeM3RbgiT9/2eXsKBEk2BT+jc3MzC7k0pwiQdb6X/wdrkeMT40zLfFp/jdSrRzLv9jzUVmMLW8bKXk4GXmdMxrSImdO9NqqU/A7MHdQVJsuM2sFmWmeiFh0TDgwsZxLN3oOSznHbEI1lk3mTtwCdkuXxvjlk1mzhLKzURx3H9yrdmfovHhswb+yWG3AhK0JtCSq6PlSWW+Yjvwtxweaop1Ui7Bej1/i0MvVvq8keOtikmWzn4MjZ+uccsojkDWAxzyX1prx01RhmocBqq8JwW/9GADU5q8wYstgoJ+trIZSi4P/ZzI9QOMOiqYnnyaNPgI+UodZznR4Qw41XrJpoDnPVQdbNEIwTACkIQoZG8vKAdOz2aTvctKDGz73z8T0FmDE9cR+VDizNQfD8DE6Oef3Ju9+yQKQjxUhfUCbgkJOMU+f09aXuPW1F3FHyliyPDCwXQU;4:tFBDH+0hZticwyF/a2TMviX354UYo6pFz74fPwR/grQFtaa/gSYqKF2PLvyjI0O5JM/Cg8MUZxonUT8E8D0Gxr+5t6QtyPGf+/9j28jnHrzsrJLPMqu/65ylClCPKhx98d0uwGqDsPR0iWxnEvFYMOZ2gpoerMlwhBFJGkrMyBbgCNKduBET7LFHU9QqYstSYLQ2lDSjOthdeCow/6g0mitT8BUcPg3PhOD0rd8N+Vk64AZjn/varLtdhYHqXPhES5mtiqEYjMPhlaVInoW0OgqfE/gOKGBJ6KzIgnFG+6BzOBOQVCuhGTiN6PKqq268/+zpEk5zxX5PZq6YQVm9ig==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1917B12E28BED3D7C6386F23F8C10@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(72206003)(2351001)(45080400002)(105586002)(386003)(16526019)(478600001)(575784001)(86362001)(25786009)(50466002)(6486002)(97736004)(36756003)(48376002)(53416004)(66066001)(106356001)(68736007)(51416003)(50226002)(47776003)(7736002)(305945005)(3846002)(6116002)(53936002)(6666003)(2950100002)(6916009)(76176011)(5660300001)(1076002)(8936002)(52116002)(7696005)(2906002)(6306002)(2361001)(8676002)(316002)(81156014)(81166006)(26005)(186003)(4326008)(16586007)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:kE28aYuBoJ7eT+Qd85fGo9IHELjlbFR1bm9yjBsGZ?=
 =?us-ascii?Q?//MZtExMCPv4d7mClCIkYwBaIM4bDn/GW6f5v54h/r6Om/fGx1Jh8WtDOuZr?=
 =?us-ascii?Q?3K/Y3ctsLtfVHbQ+8axBI4vhO4rD8kIAtK/JufPSQ/p2jVMXKUFjyXO8cdv9?=
 =?us-ascii?Q?WIsoI2bXgHb5ubXWN9rdk5pS1K3h/Veiw6AFrZhXfIZgUBTJi1gKBtQIjFlQ?=
 =?us-ascii?Q?qZFV48m+aMlFGtENe1nwCn6LB3X52OPMNDeZwr3nVAfOCdTo4k2gD+DjAQUg?=
 =?us-ascii?Q?HfVW0CGB2OVbGBlY6dDbtwvmrCbGVTSjbO6IO9W+s8s39r59nqvjzA7GDkmn?=
 =?us-ascii?Q?Q/d37BVL6I6nPa8z4eeakqyQrMaIwPcPbuTLNkZaq4/s865klhsX19ZaF0p+?=
 =?us-ascii?Q?AHPE060JuNjQesdaNB+LeQaeoQYFWHt+8CM3r+ziLwgDc9aoqp0Y7BMZVcRY?=
 =?us-ascii?Q?FhR09mVUJwr54/eXbK5HJedHyzvCKnIG4dx+oFXPq7YYZiom5fnKa9wq8bU5?=
 =?us-ascii?Q?gUpO17rtaZtiQAZTHR74cv2zniiVMd4Oo5V4kJoF4MXVn2WIA/3LJK6kdz8T?=
 =?us-ascii?Q?gEVIFcCF9QcGEO20AYTJPuwEU4V5ePTi7GWQrNJF8/sa4obHenyucXyZPkFq?=
 =?us-ascii?Q?U44UgooRKXjmKYMUYS+NVdO1TId02EqKhP7tZX7G/JMw33bmtfNHnm1afKt4?=
 =?us-ascii?Q?6XbLYvlfqVN0QXYYyDeuqWqHHPgFDxWBGkhiDK0ct6mrEb2UNQ06KcCV15fR?=
 =?us-ascii?Q?RhCTnjkHQk2tH6wQEKqbhkoNi1SCtIzLasIf6/KtMb3khe9zzMfwaM8xUAUa?=
 =?us-ascii?Q?iALAe0XVp5kB3jVdeleqhs53QKCoetwYX4cYXPS5cL46lCXn63PbLOPGhnNi?=
 =?us-ascii?Q?dvcOfZCIadaODbNCFCAffBWOmR01q80FIyG+6OAO0is49zc3VAycsvV7BsHU?=
 =?us-ascii?Q?BlNqVm19/Sdh4jA74VNzIuwOrtREGUonjwJmYMP41fdrgwwPfZESDyz4M3uK?=
 =?us-ascii?Q?CTIXlOERa+Zq9XNi9NGIfAfiC+Qx6cPfiJldyiKumtkAlX3vC/tURdNYOHox?=
 =?us-ascii?Q?j9YKRsYVJCmi8E4e2zY92ZH77jOjsVpYss+VF1b/wfGPtSqS7VHDJSpAG6dZ?=
 =?us-ascii?Q?EcJz0gWcH9jDOULGBS2LGN5Twts2otT6MfFsJ2NWgiAUBCo5NbsM/bB9lGLN?=
 =?us-ascii?Q?pAJ7JvLGYSmXQ/mbAiCSzSty8MLIKaA/NLVZ1vIuMHzEZlTZG5s0qcs3aCoR?=
 =?us-ascii?Q?USI9tsFDfny7xhF/SOjriCSccX3Kqrrh4nw0cxJ?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:UPT0gBAxxCy4oFkdZ9vBqLFITaLppaUfQ7ha+08ubN4fZxXhQvbSPagMQFfmtqGcvyXQZHGdRmTQUfWYV1vbV4X31CEgwBxa45dLXGHg28cIHdGCUMISsPdvRfeIOHfr1WFCBM42Peca9PJSazYXkTzs7zO6hvaakmMeioqLlDJtF/hj7Pdw/JE8eYchJQaSQLDsmN1xgrVX21MyoMHA7EdQP4vt6pHcsXPVLbuAs+2Jha5UnKy/kd2W1hVFN3PF0qJxnU2c562UvFrJjqjmRwMHm9QrdHCJr0dlPlDs4aNA7LU5xNKElhT0phzaj2s4+ShiO0rCy4uiJaLJQlra4/7XbTSgOa7K8osaApTdnBM=;5:THuYQE4jNYIVjCPlu4jTRL8LU6MumxcotPCSWnjMqhHhOyInSteSJciwA3arU8kvWT3/zBw+5hy9FEQbWcUPIWHkpbxAJGmZOVbsSdBG55JnBMkPPfDF6um+kW8GjFSYOuyd9L3A/DVkw3uocyOg7oNB1SuMim07/eglWhflYJs=;24:tEmpVDGCZ+RwZAeCtk1xot8KAqUf8KXWDP32lvTbPaG50v1fSAalrw75+TOFTzHCNhN7Fucj5s66Mc9kGXG+VEj00VM2QWaYK47yYC8M3Sk=;7:7+cv/VNR6bR0dLGZ+gB5GJioTz79+QHvPkZbfH5N+RAkv17ZrRqM20k8UB300L9d/4F2uzLB1lCKT+dmVVkqaQD4o46IYcJncqpurjIwFlhnPRIOWEG/Yj+mWR46COgEhIOudtc1rBpUIkjwarlNsfcSrxUo+wAIlTqs/4Ba9oDh6UGWGXYkhSKPSGOgKUwPBpmUNdDZ6lVIctiGazqlk0TbGXzFp3jWOu3+UdliKqRQBqn6MqzqliWtLtiZ5F4+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:ljeUIKqkjpFlxKCEqNHzTsWJ8DR/hLleYARbLFHevOxmCQ8g1cbEqd9HnnjZfJmJmJW3RC9J5DGFrRvej8A3cVinRpT7ud0Z08GcHIsIPUNU920rG4pONMRfPAlzVkriuvBrEALIOEby8Xo3iKUGMuAWYcuQ/uv6Uy/QmUJ/TmI/9EuGgEVf4GXpJ9ZXCneXmV4E6xNODLU62PQxzn77I9gv40Rg0bpOwGqUE78VD2BMvD3iRn1gNcLmsM6vButS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 19:39:27.9493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07be3022-615a-409a-07e5-08d57d50a6dc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

For easier handling, match the known IA32/X64 error structure GUIDs to
enums.

Also, print out the name of the matching Error Structure Type.

GUIDs taken from UEFI 2.7 section N.2.4.2.1 IA32/X64 Processor Error
Information Structure.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180223200333.6410-5-Yazen.Ghannam@amd.com

v1->v2:
* Change use of enum type to u8.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 417bd4e500a7..037986ca82dd 100644
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
 
 	printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
 
@@ -45,6 +81,11 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		printk("%sError Structure Type: %pUl\n", newpfx,
 		       &err_info->err_type);
 
+		err_type = cper_get_err_type(&err_info->err_type);
+		printk("%sError Structure Type: %s\n", newpfx,
+		       err_type < ARRAY_SIZE(cper_proc_error_type_strs) ?
+		       cper_proc_error_type_strs[err_type] : "unknown");
+
 		printk("%sValidation Bits: 0x%016llx\n",
 		       newpfx, err_info->validation_bits);
 
-- 
2.14.1
