Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeCMNyJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:54:09 -0400
Received: from mail-eopbgr20095.outbound.protection.outlook.com ([40.107.2.95]:3417
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932748AbeCMNxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:53:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 1/2] ARM: PLT: Move struct plt_entries definition to header
Date: Tue, 13 Mar 2018 14:53:13 +0100
Message-Id: <20180313135314.18780-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: HE1PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::12) To DB5PR07MB1319.eurprd07.prod.outlook.com
 (2a01:111:e400:599b::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82b6519b-7450-4df7-8ffa-08d588e9d045
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DB5PR07MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;3:v76sdmtc5EytL1uAb6r7Da59RUhk6G89l4DxaM50Mdm3ZolXw9paI0jB3znDPge8iGFMbH4Wn4KXTfeJrZSXnae/yGcIToz/LtJkyYgrEy+qH0XWIVdIwCHNHP/aRu7UYj+84NxnSe5pMxT02DbPF9wA3yAGLXnoTVw2myRYoRbMoUmCyKTiAOUCYY99bfdwMCt6QW7ciM5oNY0MGbJz+YpaRFduaLTpD6l1OF7HAxupoz6HrB3mRk5bYBcLi4eA;25:6wbZMFsOAWIlgyYc4ak8kqnjMV9qI6AzDZUU5JYUw2XIEHpIWaFdIk9ml/aiRggIGstTMv7lfY0ynX+Mf6BjIKi8OxihtPFnD9suC9ZX7erst22mtI78SzJsizzWDZ4GkTLJSYPfbphesagSmTPImR015MVZZqjapLLHzpx+bOSC7Xz1ayckXZSrzabB773+r+JrN9jzxzQeGnxTXQ7rrOwcYqT8sjf9tUma2DQjfuziF+UVv2mDOrcot5EwxRVEqSsGnLe/D5JavRNSV3y6axs/wq3TLKSNZJpuusIlHdtI+6Ivm6QC21AlanXAIfOfHn6+R+U3MWA09Bfp3QEZGw==;31:rzaHmQzGPSebZIX+xaQ2RFiXbattqsC3E3Cp/wbTCd/R5NxwXDiAh7/P1PaYH2tV2dU621e1WBkfmHfSOfFXwiNZNjVrndp4lZ2nOp7k00U6Sv1uTH7T/RdBD4XcWyMSccT9E87bAc0BnOYrRrzW4ERK8mQInc0wVYV3vT5GItZKcW2e8kpPShJcV2nEMIJv4hXxVndC6UdV0zpXXS009/RrJU6EFPtFfPLDLFLy45A=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1319:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;20:NQlljlFv13JgGpLqobpx1W7SHDuUmf9D/JIKX0uGCPSPJlncxjAr9NSZIsT5jR6KLIs45XBPVJHlOs7yYi8kpdk/opDTxbRC0lyho2hUSRuz5UFgbXKhMTIjfnbRSJOC6OZagzaiZ5mSYIXTrIAt3rMBY1y1ob3nc0Il6Dr6RaW96fw5wFvKRDonETl1WUKfN8GqNHIntMRk3+Xz1xWrASrqimQLl4nBP4COsO2PYeuMK44+RZnLi5s3xncowFjBnySU8FYZODw0P/zF7F1s49XTVolBPALUO/Jowls/KbgRIneS9BYhNFPID72ChzKd007zndWPc+ZcUmKiMUf+H/XGLpo+ptZYbVZCP07C5NlejsrMMdeH8URwjflPxku0Jn/oFgPT0Pvdss6kqQRIcbKPRy0SN7vT3uyxdicR8bPooKgcgcDf3gVD/05hxNEvwpOZ0xBPdSr1lxNjqu8KM1sqUUuoM/ZdzEwZqmIlKgb8n0OVY0u2iOqu+JGQsoNSbdl8dKHauVHab5peIScqVr09HOZuvSLd3gIJaA6R80sJtl6blk9azmV52qSutWo86ZTrnLSScjDI8rX0NnTrzWcqCEd3qYPGgX37c2QfC1A=;4:Ptt6XmNIR7snyR/yanZzCe36cltfRkcRCZ4dwJiiQwhq+lujU04nzPULBtUTEClcgu44sZLlJnR2EjAlIfHiKWxmO8ClTEch6yG22ipebVmqesL9osDijDLUcdFRYI3gL9YwK9YTOQ1S44ljxeeE3gG0gGfEX2jH3p6Secwy4uHVOAp3x6R0OT5sTRYyo9t5uuY31DquTbvWgLVIgMyqR+msjrLd9J2xKJVkYy/UtySXxwdYXxAPLdaW/qY/rhkEDHe/AIwvYzTfDeDR06MqiJO6GIDwVFzl3LSJrtyW3tPEHlb8OdNO3yskJxNsFEqN
X-Microsoft-Antispam-PRVS: <DB5PR07MB13191AE20CDE0139B54FD8D888D20@DB5PR07MB1319.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(11241501184)(806099)(944501244)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR07MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1319;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(16526019)(53936002)(2950100002)(52116002)(186003)(76176011)(2361001)(2351001)(47776003)(36756003)(86362001)(575784001)(54906003)(81156014)(81166006)(8676002)(6916009)(7736002)(6666003)(6486002)(6512007)(97736004)(50226002)(2906002)(105586002)(16586007)(305945005)(48376002)(8936002)(4326008)(5660300001)(25786009)(26005)(106356001)(51416003)(386003)(6506007)(50466002)(478600001)(316002)(1076002)(66066001)(3846002)(68736007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1319;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1319;23:rYbBEitra/q6YDLtnLvwp/1shI82XGiU27xGGNf6U?=
 =?us-ascii?Q?ywVGVFIAxDmtOShYVtubXm8ZpZkJ3DduydDCKfIFvV/EPbQm65MSkWU2pJBQ?=
 =?us-ascii?Q?iPTA4c6WQJg4ZMpxbDQBbPBIpug/ujIKV4p+JcsCU8a0d/cDYIZwqAlR+fVU?=
 =?us-ascii?Q?/P65PkoHzFOevTp+gV3L71qwHMngjDoUX/t6Ix4bAgvR0XxDcHuZIJusTWVo?=
 =?us-ascii?Q?wQkgiFiAWvDcu+lFOnaMiTjV7Iifny1aoZkGbNGtfcccbSAlQAUOVDffVsAb?=
 =?us-ascii?Q?pZjFHy2dP9yZhxIBFQD5qeXl58wugkEbdYtjTzTBRZiEc112ZCiJDflCKLjE?=
 =?us-ascii?Q?g2REIxWxw8oCBv6dWj/JOSAWqolednteQUsqkZruwSM2kNDN+YWcvMw8H5py?=
 =?us-ascii?Q?FlMynBvQ0kkrnEw6cII9eLmnHk7J/cO6DBiGsbpcIfTXm+Di9BqTlZbZvk3y?=
 =?us-ascii?Q?cABnT7755T3HNVPsR+Tj+0LlV24IMYSpP3lsEg0YE4cDXjkuTqj/IT3Rmeo0?=
 =?us-ascii?Q?RP/JEvBQ9Lfs7zcLKMdtyztuDaG8pQ6P2lmok8OBhGcaTb2k+hpg/8S9js+2?=
 =?us-ascii?Q?KuhbVM0S8JyH6hwbQXCMLrL0obOlrXtHKic7WKuqCftChEIHPfy90DeXRi+N?=
 =?us-ascii?Q?EiLkT6GqK3OOfNXNqS+fB1FFnmq1+hLH+6hNnnnQbqbj35A9cErblb7aGVp0?=
 =?us-ascii?Q?x3rHsz4RzcnJGecDkjw8SYpMt/2yT5fYOnxrUaV6c6FUfAnrD0fx0E/gfP4Y?=
 =?us-ascii?Q?wUt1ZEmA0oIgam4UHI69oP73TyKHI60b6l7ZiJlmEQdbJeffwvBMxQbjqAM1?=
 =?us-ascii?Q?2Zuq3onqdrt0S8OQL2U3Jy6ShMq3W7uhzNC3LI2TdohqOV3zz9ohsb8MXW+7?=
 =?us-ascii?Q?8QLCn2yAeXBvJ1Dq94uSZqbZT/5IYz/07vbSA8alXVjPYUO4ml9mODqdnj/X?=
 =?us-ascii?Q?xCW37vI72iT2AXTjKvuM3ktz7cOS5Fe6WX/HrVTKk+CNwVHhYJXQ51wU33m6?=
 =?us-ascii?Q?VUdz/XiNKgg23tZ+0vLTFCgNTIfJ7DE2uSVO1Yh7JCHWK3LXlz5rfhJhamQk?=
 =?us-ascii?Q?eXpnuYdvS6gWYM6/X3/n0cjP/ufuaheN8xm+tF/pp/jF7JVdYN2+MpwCrANA?=
 =?us-ascii?Q?JGrwaLCuWaJ3UFuunB+NKyBd9L9tlThznNP3UGyOS439vfFlcYVPDfoC8wpS?=
 =?us-ascii?Q?PxPVwAbK2ko9GlshaUICgVHS4VN6aPVBNjZ?=
X-Microsoft-Antispam-Message-Info: AqVbJMeSFWJT/e+AhVMPWS23/mcGkxEco+w8UruSZLxg6bkaPne67neDZL0IHpTYOyYG42CLeQ+vwe3rm9XN2XaP8S6OczCklKaedOHB8pbTgwL5AWtmaI6RLTmmRDZ6rgkeSb+KwoD/eOLJxF8hdl64ZiNcougT2hZXtObhVSw66UB63WwVt6QWTnJ6i12g0DKyL92Z8bFl/7tSOYLz20OaWd/U06qyTIWsremYBk8=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;6:Cj9smgy5XoUEJGVjSScKME6h+6mWQa6BIhtfQijAZn9CwW7+Zsmx2ILd7skWDn/qRUMwkNkvysbifiDNZtItz6ciu1AV34gdcRSTbP27hmd7ED1GNf89SpinVygOLtWx6TEe8LdPmjTiVxqwIRxeLWe5w+DdBZnAPQT2RAlET4VFSDfz81sB51Jhk15MTGW3EDxJQL1t1yYY1E3tRXMjywj9iL6Ih1A6F+gdl1V3lZ5VvwLv5/Uxraxupkf3oB2X5FafwjfailRrjbTgRTOxXnPXj4vIO603+nMJYug70VFtcVYHWBAKL9rqk+AumiL68FVqANJ8CaNRY/DqIWd1ysKUd0fXz/ypr6DLJjZ/4Mo=;5:oi9/XdAOTAKPbhSzBXaNN9680Mczjs5UL7Ken715OLHVlhKdHVGeA55lHfF1UBN2Gr84x/unKmCNncGD1VLcyWFYq7ga5kVfGqUGqxAEzaRZDzFH8kR1OEZ0Uec6iXa2Tq84P4kHDNJLl7lXO32VDNZS0VIvtmMqy3I+InHTYuA=;24:RT3gwiJAeXVXdwC3Fj5j0n80+4H7K7sM8ziOc7jTOA5uECGg1C0rkd4GNlEE3ozckbAncFFce5c15M7VSaEeYroa/XamRELP1h1W3BPisew=;7:/vW8G0UWIX/mg6P6KPQXPvKPGVnXb3fgt8kJz/mrfL/pp3quYEJCCu4lnJK9mUhCh12/BjqpWDWSr4/kmjhwFF4E1pUu6aDcFuevFbeNQb7xNYWuCGb2uuj6Fm8uVQmza/yz4ALJAKx2QMdzYo4KPPSBHAWlpvIKsLDNQJox5AFAJ2eyzenb1QuOEBuosBPjIg9LIXReGoJmnEnJIyg96gOu6Mxg9GCv1u0UMvO45w1eppitUEVEaZXZiX/ubeR2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 13:53:33.8163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b6519b-7450-4df7-8ffa-08d588e9d045
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1319
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
