Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033208AbeCAQoP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:44:15 -0500
Received: from mail-ve1eur01on0090.outbound.protection.outlook.com ([104.47.1.90]:18016
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031613AbeCAQoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:44:09 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 1/2] ARM: PLT: Move struct plt_entries definition to header
Date: Thu,  1 Mar 2018 17:43:42 +0100
Message-Id: <20180301164343.5794-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180301164343.5794-1-alexander.sverdlin@nokia.com>
References: <20180301164343.5794-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: VI1PR08CA0129.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::31) To DB5PR07MB1320.eurprd07.prod.outlook.com
 (2a01:111:e400:599b::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65d898f1-7316-46ac-8981-08d57f93a436
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7193020);SRVR:DB5PR07MB1320;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1320;3:wrCneWc0ZH0uRN2zZj43wVqQclH9ePZMHMZBM+faX1KWHUwOS8H1NjMHOOu+em9No/JAu1w7rrg9ygnceoLQCWkiOus34ZC1axm0kgWUlQUIeaqw90ShfeBETVzmx/HAC79K/GZ1yIToclX8P0+9kq4lpkK53ZEn2SqblZyn1YNZjHcmj9nLee8olXiqL3hCZKGqm8z9B4nM798LUFe+Cww7Wkl1FEuba+x6p+3AwZjVAf+HSVqym6o/g1RUp3uf;25:lUiwoBqSmUc/AfToT1LPzABxfposp+HYWHWm7QZMo1iHdW8iAmk+O4Wjfxq9sBktFttuz6OyonfooNIBdPd7oYDkQuV2wo4c3aoMcKaLNA41ktRB/Z7UpBp5q0FYu4uGBZXSJUxR/+4WGgO8qtvPZfzsaFvF7kv19AWfDa80tmp06ncP5LU2gm90g/H4GMgk4SaadXOXgBwjTg/NuHpgG6uSQOf4exgSQQ5f6tfUpvhcXQFPvuEgOptfd4RCXaRa05CqaYZPYbTaR1L6syxfrmHGpCrwcFsDWMRvjwXzJZ56pbpRyY30Ls4+CJYAHXuBYT2yfReGFSrNHicj+d+KxA==;31:vlejhQPdXGk0VlFe1fzXEXVb4fl4Iyo8WQEVAAa+C9FhzmMlHoiC2CbQ8dmrZyYHaEn9fVXXMn50US+Fx6rvuG7Mm32ds5GpGMoDBRxdLAGLlM2pZiu3RsT3cbbV8Z6qWqU4UuRR+5nggf4tS61wZ8dqOr22IBkZaHs+rBMQ3TnPQ4dv6aAoCIcK1TI/FhscF++vaSy7m9LMQ63LZUCoFEPYDVfFw0lYVPsemqCrvzk=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1320:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1320;20:UE/hJjl2BF/N8Wz15Nb/2WCJx5nIjXv+GwFdDKp5FUDYVvIcLN0i/qORtdpAsyNVxDcoswtOqml3ha9Znvh0wsjs2k0mwD61ByxfkOS+ZsJI9yNPYZZFFSySeOD1FcoAu5YE5LqwwjwZL9E5p6jTnO7aYBTR/9cXzhB0sHMdq3X9IWEx4+61QQ3sZkQhITV3by+eomAiFltMNTP52wBvCHaQrLEPlNSAXzltnLUt25xNCZJ2WyGmDGhtxotlJTY7jL02jbxhKwuIaN+jcMD9HrZOVXSb3W8R7qO8aJ7o6S/i5NN7d8GgqjkRGrvwhC/bOcxF7x0k1oXnSO17fgd2m8DaUQx5oLnrbV77SdLSRFfmlbU3KDb3IJn1LZ5tb3BZ5gIX4flW3+aRgYIESSee8GTlUNB4R24qxdBTP6arMaOUwcGeYPl0YBd82CjrkrqgfqhyBbAPykEcW+XzuOCD++tkzPokw4rf3TU7VxvUbrgl+p6fu4uiSs/hV4hh3A4/CCZVnNekukUygHN4yHnFviaZm7tuvUgi53+nzDAfX0bI4SOGZsOt9jzPgZMiay5Gwu7FpTgKZW3P/IkohjpSG+L6QjAl/ICH9gLnKrd19a0=;4:/XcHC0sPe+/K/PTWc9a82n+NqEd1cxOXrmapKUEtYs8V8bjpbg/N3hE7AKMQ1sUmM/YmBuIH6gsL+epwz2tHZyaUlMvquGD5sPLBNROq1YFB1B+N9rpmYaHkLRgo4uQT6MNDXBqoGG/cTmZqiMnnG0l2VNDvJNsMY4QwbrCUvD6I5iDHpbiBKb+iivZpC6SeJGxPq2KCBjukpVuo/FsKujOvgUbpr33kWQh7OCaUohykUs+iuLEDLnjZoOGEvO5pjFNvAIQ1YI4NxZ/CtRvqNLcYBSNqxgPmPdM3eC42GUTk1QHk5hDF6C1s8CrxkfKE
X-Microsoft-Antispam-PRVS: <DB5PR07MB1320D01225C82E918832386F88C60@DB5PR07MB1320.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231220)(11241501184)(806099)(944501229)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DB5PR07MB1320;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1320;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(366004)(39860400002)(376002)(189003)(199004)(50466002)(68736007)(25786009)(105586002)(6486002)(305945005)(575784001)(2950100002)(7736002)(6916009)(6666003)(53936002)(16526019)(478600001)(54906003)(52116002)(76176011)(26005)(16586007)(51416003)(6506007)(36756003)(386003)(5660300001)(47776003)(66066001)(106356001)(186003)(86362001)(316002)(6116002)(1076002)(81156014)(6512007)(8676002)(48376002)(97736004)(8936002)(50226002)(2351001)(2361001)(4326008)(81166006)(3846002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1320;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1320;23:cGW2CYKjw16BGxuepUI/c3CFgkRToQf/DyyR6DOd9?=
 =?us-ascii?Q?KnlriN+l15lHTw35AzehC9E3+ELoG4PSRZQ7sfGkdUNNeUiO59B/WGH7/U4n?=
 =?us-ascii?Q?mjv2UnvF6+Xbds2+fh9lhZM73B26tENekreUXR9AKpptX2WJ6MOYvpskyIQQ?=
 =?us-ascii?Q?5C7fbq2H9iKNEqs4JbcJJWAdXDT8uq1hO4YmSIEKf6pK0cdno0QxS5Ei7Mv3?=
 =?us-ascii?Q?ENTXkTghK/pJ+cclsqvi9/VwD1iYxA/Kw9KSk0oGJJ9XPb+4pONTf4PYx1t0?=
 =?us-ascii?Q?HGnlKc8DEAhBHvyZmXY+np8wCPKsn51EielTvo9DMs/Cu5XyegdxXfkENUS2?=
 =?us-ascii?Q?uR8javZD5idUWEjEEYH2IadM7XLMnqEq8MwrvKz+yHz6VgIA1hin8ICvVfkX?=
 =?us-ascii?Q?5fevIr50U40CMpV+dIwpAEUiohcsuRHKemshHM15L1tw/g5Bqp0dSkHi0wbG?=
 =?us-ascii?Q?15TH37/m8tbCc+LtHF5mygvpgtV4K5omm3Ny24+3dS+5qj+p6xMHPWULdv4Q?=
 =?us-ascii?Q?K/63hIPGpfwZeP4CcKPfsG10OlAg1bFpi91ZHGjI/AOdI/h+Xx56MPvx3MB4?=
 =?us-ascii?Q?E5X9448ZbmhMB3hXg9T4Oj+jSW3kGIamvl6fIlw6kf0ePkCepq00IqmPW7rL?=
 =?us-ascii?Q?njsZamw3EN9ce5Raf/SZ1V/PSc3/8uhWY0enxZuoIv3jGtbshpY7U5FWaaii?=
 =?us-ascii?Q?Otz9vOC+O3VR2l8T1JtJCBkstPrTMuP0FSWg/cEaOTNTG8PrF/FcW4D+TObB?=
 =?us-ascii?Q?I51kfrstxlFpQBNaPP0P9sTp4a+8L+Wqv1pLFTGdsYPr7UQgeqJNYCdqDAq+?=
 =?us-ascii?Q?+Y6KF6DO1rescxA8oeUOFKfkdnI2cJmPN28MPzPepiuRbMzyGFGr85ntHF1w?=
 =?us-ascii?Q?vHt2DdpUDorDN9PiaVA3oCkW4qJm1aPz2bxMoMW4n1T7Ap3aKUnwgGE5wOGm?=
 =?us-ascii?Q?yi6dk+Ie4ZdJVwe2HuY2o9vHiJ/3ioH2zGkPyO5kY33qlBRnkcUfpur21dRt?=
 =?us-ascii?Q?8vCh+bcwlPAwX58aCIN0yB9qq3cmi2zWcajopbBRhpRkF0fgwTVNVOhGNZ6m?=
 =?us-ascii?Q?SIBqeSG8U8/+iC8nTgA0vU3R8DMqLtwcCjwcmIy9pNuqgDINDj6IcsY/Wz8B?=
 =?us-ascii?Q?KALeOVDW+HKYczspO+/hZyG1278oaY6lB0K4211kd3aM8XVVnAVOX4xsCBS3?=
 =?us-ascii?Q?0Fo1oJiwqWxGrckQqWRoPHFbo6UYPUtDcMQ?=
X-Microsoft-Antispam-Message-Info: g5JxR4zGibonDRhsJYo7Qm7huhEOf0gI4HNpzmTIpzcUqH9o08oaY6HPQmjrktGibS7DOyRF6C3PxkuZzhrsMw==
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1320;6:g+DUxURcLuDMwLiieEw7rgzj0RqimO+qIfon5CXsYG7q4e0X9ltnJolI7XI1S+S92pBSBUYNx+wq3XwGYyEExHfPE95KNBskajQFKqwnELm6BmjciFM2R7lCjD7EKNLAPh7/nFhSxCJLYzCUwfH0zxXk3UJD3ob/QfSLJl+z8/Y/gFyOSSFwv3OlulRE9bMq6NfWTDR1o3lJdUcKtuD+OPqnvSLM3PAbhUl9MdVi3gk9nsMWbMsqy9j3URwglnCyYIR8d948jo7M0QBuwu4kFttQLVdWmk0R8XocyeXHLQd9VjCFG1OqBh2dRHX8rdRtWKqi5RKzcrz//yHB4lpdylqqNw8Si6nHOZlsSUVJFSU=;5:BuSFUSBw4eh2SPmjMhcr8GylCvCx+ezAdmxQGcc1TPUq5KrZO08e8+1DnIeGo/XGdWEzGVngmS907i3DxcZw2K5i1RVyjAWwzWRg7O45pDM8K8xsvg6s85FPQt3DTvNUBNA2D9+OnXNxsbCAd05oF0su1yuL5qsLAOLUM7Lr5x8=;24:PtBsyWH6+DfJERpp559ekJxNgyEEHyGuUfpThUrcLspti+aq39RfsVEYAyRelP1Fl9YV1hlyGdh5Ii8OUkrIZcpUTX9JDxNdm7luf5vDi+E=;7:f5mp4o3o3YGST/tala+0s4UHW6NTrT03QZ/oEcJZgbc4J22yR/Ft4TUu+AdjqjUQJ6/QDMLoYl+2lyH+SZDEzWxLf2RYMBLWJHgS21lD/SRkVI42F6ypxqz4tXw+JMtoyoe/7Ut2OU/IHBdBPEhOoFzsgJ+r+sEJKYLd+EOUjoLk2PhmKepD/+eUBAod5qbklJaZllvEkCEcfUXNbgA3lmL+mhlVJIuW9Kyi8b4CUiduh4+f1hF5Mfd6LbJj5je2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 16:44:02.5782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d898f1-7316-46ac-8981-08d57f93a436
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, later it will be re-used in several files.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/module.h | 9 +++++++++
 arch/arm/kernel/module-plts.c | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 89ad059..6996405 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -19,6 +19,15 @@ enum {
 };
 #endif
 
+#define PLT_ENT_STRIDE		L1_CACHE_BYTES
+#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
+#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
+
+struct plt_entries {
+	u32	ldr[PLT_ENT_COUNT];
+	u32	lit[PLT_ENT_COUNT];
+};
+
 struct mod_plt_sec {
 	struct elf32_shdr	*plt;
 	int			plt_count;
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 3d0c2e4..f272711 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -14,10 +14,6 @@
 #include <asm/cache.h>
 #include <asm/opcodes.h>
 
-#define PLT_ENT_STRIDE		L1_CACHE_BYTES
-#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
-#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
-
 #ifdef CONFIG_THUMB2_KERNEL
 #define PLT_ENT_LDR		__opcode_to_mem_thumb32(0xf8dff000 | \
 							(PLT_ENT_STRIDE - 4))
@@ -26,11 +22,6 @@
 						    (PLT_ENT_STRIDE - 8))
 #endif
 
-struct plt_entries {
-	u32	ldr[PLT_ENT_COUNT];
-	u32	lit[PLT_ENT_COUNT];
-};
-
 static bool in_init(const struct module *mod, unsigned long loc)
 {
 	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
-- 
2.4.6
