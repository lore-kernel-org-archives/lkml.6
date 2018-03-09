Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeCIImQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:42:16 -0500
Received: from mail-eopbgr10123.outbound.protection.outlook.com ([40.107.1.123]:19872
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750926AbeCIImO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:42:14 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 1/2] ARM: PLT: Move struct plt_entries definition to header
Date: Fri,  9 Mar 2018 09:41:50 +0100
Message-Id: <20180309084151.2379-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180309084151.2379-1-alexander.sverdlin@nokia.com>
References: <20180309084151.2379-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: HE1P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::28)
 To VI1PR07MB1328.eurprd07.prod.outlook.com (2a01:111:e400:5a03::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8949ed4c-ce24-40ae-0908-08d58599a631
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:VI1PR07MB1328;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;3:TBUyWxZ34t65SZTN2ebiMismxN0TI8DfoE0Rlmmzr+2n5soYM4bW4Opm824AZDsPzGiuT0qiPjAhPNeSRkCA2qRIMrUe7vujtnpGJppNiY1rK7+pCMubpOB/ezsFuWHpi31whXdQ9fvEj0OP+epcm0Ft+Ng+pnAyUZExQuCXP0SMdWIJadPodV59s9xH6J9OF+A/W5QGmN5ZpmjRngmG/pkWF2tihHqEIhO0MYwoWD4W7vICCMUYexTpdg6PQI6J;25:fB4KxbTxXnGAosNHHgs2eMYQuwBxHEsvESDr6HjeS+HreKcsmzA2samxM2J/dKuMDcJfG6z+0ztuz0B9V469uj4rMNqd6pjsNsJ9uxKPS0cIxXAxNjcjbjtknFt1KbYIvO/zjrhpE82X5dDWDzJxPo8sctTiaK21y/HNmv09+2f1qqnDTMNnNJYI7Szc6AbNY2T+SlpAcLpXKZpo4BU88uhN16+iFQIDQ/pjvsi2uw/61xONho5lU2wiI6ydEYg4AD/lppuleXjZYHiOJA6a1pI/86zzsLEeTmWGZDAWt+JxXI/Qo77EnyMstJ2Zipz+6DfglU3eds/4ye4QNn3jgQ==;31:f+RobvAJINA3vyV1kM8BO+TgjPXEeN9yZqAnKOs7VZfZN2/C55CB6gIjPHj50YpWDS4SFh44xur7ibPKUNibNOENJ/wCvJaWynhov3JJ3QLH9C3Fx0eBxeLxjyfqD0+tH83A8iQdNagQrcjlmz8UEKcVfkHyrFfcTLaTu+wvf0PSZ0h6PRUHCZpN5YmW4PCxHLZVUJsK/yfDVsL3cSm1stTVjwlaxtww29FzYs4vNJM=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1328:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;20:PFyDVpQv1XlLopnKODV76abjgz6ghh94wOYII4Q64RKBByhSy2Yc6NITgfIeRAD/2XfNJYkLN0AdY8NWwYa2zlnkjn6az1wVF7SrEwjVxGCPvAKrgrZCkLbD9p2Ku4BiXzIcAgnYz1jPywpRqYXFQSth9Z6YLrekQ4C8yH16C8wEbfxRzALM6IgzuvhNyPAJyQOEs8tzBDO1xykKpHdrdljkXcALpZ/0PjECSUXvYTi5NTT7wCDhG2SCxiX6u5buqJXbnQvNA6+3Iknry7KEDiM0PpQhekmq/JgReS/FbvJcHq8w3tjzaanLYJc+GHS7TO4CzaVjqOMTOARGYGooJRt8pgNvhNNdrQ2UQWKfAg3w/JwOkm0nWqbLHDE63vXbMo3GMAGw7QX/lF7e1t+qjo1E96oJhECJrP3svtbTNt6SjW/KhM8efGBOrRbkTaB/vjWzxWW4saP8ZKScrr7w5NQLTKZJIquUbz7QAg2GePT/FENy1dQ5HcahckhomG6Jl13p9x1YNTWGawlKtQYV0JhMK1tsNrv4JzuDNqnLQWZnTZ07fhiB2MVpaa6AMPfrJn5d29DbmSwUgH7ggRPGgGWNvDbT+0f/5HmywJFB4LQ=;4:VDhLt/8WxQuf5+ctXV9ve/LcVy4o0wnUvSyKMJyjj2YBAgg/Aqrnh1ryb333qWlKWSD0QTNlWNCrzlB0RFogaROr7brgGKtKs6GUYPooXkbbaQlxaeuhO9dwp1reh/Hb3WsqR75pz/SDmcr19uD7s2dmmsHfJTrbLrPlRlKpJle4BGUdOow/CNJzymT3lw9X1NJyKujDoIcGwbPby8B/ZTobEBDMOO0Q8kHtLITc7/xeq+808YKO1hNn+fZh/TFxkyfVKX1rxu1u/+5o3wknD7eqjpLtDKwimtnJizSJvlLOyX9oS5ZtSttaeD7uciaI
X-Microsoft-Antispam-PRVS: <VI1PR07MB13283E1863EFCB982507043E88DE0@VI1PR07MB1328.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231220)(11241501184)(806099)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR07MB1328;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1328;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(39380400002)(199004)(189003)(48376002)(4326008)(575784001)(36756003)(86362001)(106356001)(6486002)(25786009)(97736004)(105586002)(51416003)(16526019)(50466002)(50226002)(52116002)(386003)(26005)(76176011)(7736002)(305945005)(186003)(6506007)(8936002)(54906003)(3846002)(6116002)(6666003)(8676002)(16586007)(68736007)(316002)(66066001)(1076002)(2361001)(5660300001)(81166006)(6512007)(2351001)(478600001)(47776003)(2950100002)(81156014)(6916009)(2906002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1328;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1328;23:WUW2pIJpEVreFf/RhVon3Xd3DQWfK2bAb1TCTHQ1P?=
 =?us-ascii?Q?g/Cucva29FjgQFMp9Mh8oF2xKSPrn/8tQXcjWAEcP/Sh6Ph/WGjyLQQlaP+h?=
 =?us-ascii?Q?UV54ip5+pRIF1Zf19N3JSF7a9X6B6meMTXMcNBkhWAEUnG2QPYTtLhK+/47q?=
 =?us-ascii?Q?uB4ysgjYfrpESOi4TO6cTM6oWgdxu6t0WkH9cCE2D+Lt/Fv7mdjeeS4kv3sS?=
 =?us-ascii?Q?XiLLQE32JI+2uqvzpM/8HcceQflRmlhLAOEWexX3/x2VVlJsqiVNdPqsAKnl?=
 =?us-ascii?Q?eKQujZ5nip9wKCRqqkGCWWWiAKwTecV5xCo91jpPb/8mdui7yqeiodixPk7N?=
 =?us-ascii?Q?33csNoHXF8CyIaSMQXcsYGC1293MoUMpmOgJsJ/NLBLHevPuUm7F09XoX3cW?=
 =?us-ascii?Q?a/KCOepZxUlknwaHpGKPXLSFWCXjJeYBltLpyaKyWjsUos+i1KOny99lRtpu?=
 =?us-ascii?Q?TO+qqm4ZeVzm+UERkwrMyMVJkA0a2GNJAO8XSXBJfc6OlAHhOONRGNDe3Ttd?=
 =?us-ascii?Q?VnzKoz2gmG3LjKA5cq5CRRlnKKD8MbL8GR8r8Ga0fTmTQ3SviD9Yn82wQUiv?=
 =?us-ascii?Q?Py3DHmbdkMceTyuuu4474uQhCogyiUDum6bgcQtM+4Z77VDbMYZZlnestMXA?=
 =?us-ascii?Q?nsHG24jHl6u0DHvZjLWW+poM617mL0rc+U49iZnVV1L93LdmOHlgsL6jebRZ?=
 =?us-ascii?Q?jfVaUjGKDvmKjhWoM1pE9bnHMY9be+gwhr5X2rfHvwcJ4ht3ZZAp/djb3fiO?=
 =?us-ascii?Q?qGYhRKjci1wb/DrAHnZQeUXdkkxxofcOSOa6ZQ4GUTcVgpR056OJ/S9cr+J5?=
 =?us-ascii?Q?X90Lql0roK/UBB/NDZdVsyAnkacGWm27aEPPdAggh2a+xnV9FgGOh+t6Kma1?=
 =?us-ascii?Q?R6MLd1wIf9tOqK0HxD3JRC4zMOPSfuzFhnCLDAhAsE/oJypd4t+U8G9+i5y/?=
 =?us-ascii?Q?jJYMq4FHij2iQ/+djZxQYQR3EQBwLo6wrbEVzPc9OmK99Hpj8GJA7nUWPlQB?=
 =?us-ascii?Q?GvTLJfo04/TGgwcAcK/o+cWc3QETdzoHZorlztkt3D0rDJnbCXfsYJ+TXa9I?=
 =?us-ascii?Q?Td8m5amkuIuOAB01/aLoyfkXNr9oJc3FpzdiGwosc3cxyidVYickACfUAbSw?=
 =?us-ascii?Q?DGMeS6wSbTOsdkxoUhDANZ4ePUm7spMO2RoHWpYzkaBMmiBtQ7ePX1aAIoIO?=
 =?us-ascii?Q?EsVg3EKdu9h52bzFLe3rVm4IyseRxo6Y38Q?=
X-Microsoft-Antispam-Message-Info: 0jTQdoUrDdQaBlTnb7eFimoRd/N8Nt1Dur0wYgQFznr8u4al6xmkxjD8w2KtBbWgBc2xTU5mJ+/BrcoRRTRQiWK3hxrP81vhZ7iCTYyATqD0gWlN7cIt1PZ+NFd+Z2oDCIK8NYVQ/N1RezUzg9w4s7IiO+s3v8figu5D4XdCgz7wXV7ebSF4UXOjZXurOQfKJR6c/CpsSV7B5IyyTqQ+POwTWIq7L0m1wv6FD22T9vc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;6:vZ8mJmAh+Ops9wtuaxFAW8jQy1l5CaYHeqoM6eRuRlDvJvunPEL3L3Lnrw6qACQ1/OPbxvyZruvoJfKrjmc1Tj+cUAwASVvYbsK9vJM2VUgucwn9vDgEZ8DEMGpXXT1R7JPuYQHuP85B5L60nPF1Q9mRrxknG3UlVHk7807tmMlas0dMOXniVg+ZrzkVq8h+35OQhTAQfccN+U60cIyr/r34M97jlc61F5EewRK1ZBg6pX9xRh8tblgFkbRubJrjXg21wOKFcQLBaruWbywZnyjNvCMLrR6lHRAw1Tla6U99JPvTnLeoD/qUH7p4zCNzBMB6GbyRd2K4rxm7rqevWWEythI5BVkJGiT/yPbsjRo=;5:1acWoF8x3iVpxKLe4zv5oFTBSWa3fy3uxcK/nLqTKYPUCsPRNKjGDgSkNsuL1dJpUuG5xz26GBAfHEAzNQijjnsE/SA6e57/pxvTJ1Uc3vzHR0+XI3cXsAmOKyqPwk/tRWN8P8dzaZpmQhbgri22zE1CNB5KOMXfa690yuwEI3w=;24:b4JVz63Ay09eGICQBl0hbOD0vFamTHUwxVbQmLdOpcLWgo48OenvwU0uD34IlyxhgnQ1wsqwUvzoXP8nF9eBmyIBUd0M9iJGb1au0zB9lSI=;7:/M8miAuKqu6InC5xqA328bXwIUfzs1OlfxS9flukMG78GMXsghOOtP1gSkvKpPDAV5h067GhPcikeflsyaTBaVwPAm8FbbCQ0tZUgpash7ouMuUK1A5tneK6fWvs0ZNX7X1JxBg3uqRFONvG3jNsnWeGsGoFLs6taViRtceZ2BD0OTazsUP0mTLGxrrLb2Vd1wB4CcBhIffDASM6iGq9pQ3Ge9YTkdrZwtPNKHgwMn0qbVN+JuQhyeSYG0wi4MVR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 08:42:10.1640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8949ed4c-ce24-40ae-0908-08d58599a631
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1328
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, later it will be re-used in several files.

Change-Id: Icfa32669b3582d713b3ad680c25620d3d4844bdd
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
