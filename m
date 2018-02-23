Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeBWRBB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:01:01 -0500
Received: from mail-eopbgr30108.outbound.protection.outlook.com ([40.107.3.108]:25861
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751723AbeBWRAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:00:08 -0500
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <jhogan@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, adi-buildroot-devel@lists.sourceforge.net,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 1/3] ftrace: Add module to ftrace_make_call() parameters
Date: Fri, 23 Feb 2018 17:58:47 +0100
Message-Id: <20180223165849.16388-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180223165849.16388-1-alexander.sverdlin@nokia.com>
References: <20180223165849.16388-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: VI1PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:803:14::49) To AM4PR07MB1316.eurprd07.prod.outlook.com
 (2a01:111:e400:59ec::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7422511-d0ff-4381-3814-08d57adee232
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7193020);SRVR:AM4PR07MB1316;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;3:LEmSDZ1abEfjPHTLN+JYcMS/OhJoOa9vA+Vnas9tdQYyuHyFYtXe7YzMvgq+HhLtrwZ1opalBhIDzjwOtpLLk/OsAoaQ1XOP6k7ebSDXJ2n8vu3T/yTdqMn8TkhFNgqh7VT1lpAU3eahQ27kLyun5jFguFypdLoYqRgZOXzmXeQTfSrTqB141imqVEYuEZyL1yotOFqkysd+96VWdDThbXZV1kgD4GAu62TdsSH/RK3ngGRzvSPX9jWuSslMLnoL;25:EjC2kanqYdFzGsnTwts09IGj0jZG4nly4hiLmwCOwec9bG1NGSx+JaNle3smFxYEjMBNngaOHlfskondf3+PkrT2+MHOBCQtDlJkFDjuRXNKuj9DHICpv2eYXsqZ9cUYYeP/XFA9Pz9lN0XnTxpV5Oz3pqe/L48bIBmApAdwapdOfF39wSrYeoyoBIqlO8kIeIror7xcejouW5DgnY4Lma48kO714qrXvp2jegqW1lDdOA+DoY+Gq6NM+X4RYO4dYSg3K7SrrMRZv2HtoNJYgSMPpuK4ldbmglgGXQfabwu78R8oMzjijSO2scg5wejOWokj1dWvY1wFbD3ikDpwFw==;31:InG5mBgDoIEg5n0y2owl9M29BO0sna/VP3tgYdVdFYaOk3/vTbenrEKHkYa1jrMVv0gdvAlmwnTfedBOFODcIpnR19VhOTPPw6wq/Aw/pEDK4LYRe9l8YQFodSFcOdlgWicHGf4WD8c5hfdyTnluZfXvbmdJ8OkVH/kJUYFg2u63USCzR1sKtNlVCRRmPlUSuVnI26k6Vc3zImFVD1J/ySrDMDwJOKDzy/YqYFYB3FA=
X-MS-TrafficTypeDiagnostic: AM4PR07MB1316:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;20:Ko6Zd3jh+eouqUGEwL/Of+qbPJ3ExfsQPMW5iXjdlfRwOkKthPcSlEhwjmwcFeug1Lg+MrJSuk3cJLG59I5WSmSQ/6oKZWu5nItRUrZfSqFyDKNDrH0iceBEdFidcPzBww8Wp0pszWWsR67lUjrJUIBx8Mal7cXXGuy0UPG3Wq4exJqrjKkbWmsJe0U/MskgvZ7/Qq8Q+gQVsS/HL6pd3Wu3891K4PpEmsYGc2znPuRyFX4kUBUGurUopx8j8fjoyMOXDPOQO6WcUkRb3MTIk+kHMr33yxM2X0CDBQEU6dKHjXQRquolXeIF62n+4Hb7DCwzMzYI7hRfZMgAgA9ApqsuRj4D76zS1zDBWpS1nvYxwdMKXkdLFbgF1/Qe6/RUU5GIBn/k4Jv0WvDTOuyOoIQ21Ftw+y5bwdRMKHWvw3iQOflgd/68aboR5j3uTWDb/KkNcrSFqnrGHYtI4upEUmawR+2HQNRaB2ooPX6+KPTEPckZvJDtq5eAK4o3ojm25pOuLYXE6XuH/yEcN6pDltq8XrjQscvo99cFVfEivYSw7ZZH1hLSL+3iQG6r8dMmcxhnRUwSg9oaKfAH4wjhmPTh4BBQ3c2PF/ITHhIXSOE=;4:xls9ochS3fb9m3ISYV6IWGekQ5F7Uto4U1Izkb8wY3iYWMdadbxFsztKD4Rm3B5eZpSVrOrEQY3bLeylTrilK33Pu82Ha5VUKIh82XxqPRTQBnzQIL5y7MrsGGgYEsyNYk9575N6T3WL5+qG7/deqj2RRDjGHqg58xQV/tDckrvMxuAwph0Ym3zalqTZbctnKXv8oyElhbrzsZx11JslGJulvtP0LoMdwqjBFpfdS0osUylHp2x+gAfl3/EjfinexT0l8+mk0xWu6gSPnHm5uRxWhlaO+cNBwzukbAr4cwq4Tn/YgblU7WefopOYNLOe
X-Microsoft-Antispam-PRVS: <AM4PR07MB131623FDACACEA6388FA7DB788CC0@AM4PR07MB1316.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231192)(11241501184)(806099)(944501161)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR07MB1316;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB1316;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(52116002)(6506007)(386003)(7736002)(305945005)(2950100002)(76176011)(1076002)(7406005)(7416002)(97736004)(5660300001)(6666003)(6116002)(59450400001)(39060400002)(3846002)(16526019)(186003)(50226002)(105586002)(478600001)(106356001)(81166006)(81156014)(66066001)(6346003)(8936002)(47776003)(68736007)(26005)(8676002)(86362001)(50466002)(4326008)(53936002)(51416003)(25786009)(6486002)(48376002)(54906003)(110136005)(16586007)(6512007)(316002)(2906002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR07MB1316;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR07MB1316;23:WUXkvlSFIteBK8M3r323conbNDTtSv7vyfh0+cXpD?=
 =?us-ascii?Q?qwAqTPJbQ0B4T2rls9RCsG7W5nXBrkpStybJjWW4wwLJ1dxvAAK2fAPWRKrI?=
 =?us-ascii?Q?S/2V4NxEghqoYgWlqKJ9hfqqBknlsQAYffv0gTxMC8sPUkVpuXA+rkZpWS+J?=
 =?us-ascii?Q?WxfJG+eYTnm+2gvl7OpXcu/RTGdD5myAySKbZfHsVVcFWj0XFCkn3GevXT+j?=
 =?us-ascii?Q?mJKXTz+F18a85GbwgH0NTMMwrQd+9srCeNmUUrl21QalIFXiz5G68YbsPB1p?=
 =?us-ascii?Q?ves5EF7fe3VFT4VvJ1UXNZqTkqkGVeYlHSEjlRLC+WNoVkxb3ASnlkG2VVyc?=
 =?us-ascii?Q?eG6Hq0ajcfAqUArQSAhrCeCldJiNogQDf1RezNGp/wzBM7H4jwWjp+Ly+ULi?=
 =?us-ascii?Q?ZgQ1DDTky0FEhcqdrenWJw1r+d4SL1wD4set6Fe9McXBBnBPr19ayhtVnhMn?=
 =?us-ascii?Q?LI7Xuk0JMMbY1NwPp2Oz49hbDTRdESWx0ml3vcp60b7b0H/i6n5OnLS8+qLC?=
 =?us-ascii?Q?JN2sP4wZHmdgkvdR+j22P+VPKmuPfARORl+/G7Ry/T5XuYdPo8Kl1FuMKMwo?=
 =?us-ascii?Q?g4cd4m8XBBmLuRYwAFZhjDAUocy+FtqDPVwBUDxsuhPQstBtH/wuk3gQ+l0S?=
 =?us-ascii?Q?4ZgkFVO3TpRLQ5L0VrB5Aa192GBbX05x3Hf1iqRlZUnYHE0q06f/w2o4HlGZ?=
 =?us-ascii?Q?r8Lgl3H+vbaUuyg1lBk1D01mFFehd+E5jnficYR93V5ArE+jzm8aroJbm+5S?=
 =?us-ascii?Q?+G1NHX8ot2hY8EYz4fOaejeJBE/agFiRtRZtms1ZYwQRANONnK0vKS2SBuQE?=
 =?us-ascii?Q?OO2gwPQD1GSgO2qd9W0gWQanrqWcATZ9M4m5ttJpjQUZ7dTS9lV6MPquNdB6?=
 =?us-ascii?Q?SgXcKu8Dzj292w+CBKxB1Ld3LvQFpyK6m1ZXVN11yGfIoq5gCIxG3zsm0GTi?=
 =?us-ascii?Q?uks/W2GX16WWwpqbCCroQluHb14AkS+KXeVFqQhn2t3gCCDhqkZlYh7ZGyad?=
 =?us-ascii?Q?7R2dHdvTg3biApj8mZMLScIXwLGVpzTa3UKvkF0lhZMgNMLKw9WdGkrk62pX?=
 =?us-ascii?Q?nPlvo/FLkinzTumZksntw8UAJfPaBo8IAYbUnrCzXacCZe6VUbgcB9Dvh9Wj?=
 =?us-ascii?Q?yKZXKrgmPhf1Qu8DIGfcOSPstDaGxuVLt8ssxE+fBbZMff7PEUqpSeE7NmLx?=
 =?us-ascii?Q?bkjiWctpXr55gpqRLn+WLBy14MaOftq1RSuEm66NyTK2pzyZR2ZKr97nJPN5?=
 =?us-ascii?Q?aLPzDMYzVa0lzLb+DQ=3D?=
X-Microsoft-Antispam-Message-Info: zMUsTMZHWFZ102segHExlvJiep0ngrWxoj4Bu+tYhty6SHuK2sBz+2qZpMKcnnx/yVJvVmgbI5hafa0tY9dY5A==
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;6:dsf8NICqJT/7rkmHIzzmhGryuPn4Lxu6rjB/Bt9EjpgJt2xgTA9EOgKRDX/+d1y4jjinaVqs5wVEcPVAEBGGfoWxrFbGf7KUj/K7JXGeNYo8sQCqaBithKiBRQmwUhtfmCJ1Mo23tsFswzjPPkomTcnZHR7K/OvtSO5hz9cwIB6/+q6tFM7oAYFx2w2O/SdXq4kfhIqos/LyCOEKFJK1retQJuEu0IHoQ5Y8rgbmAku0pxzUjaGGSqh7dLUwTOe3uYvCMo+o7MuOypjV4A65AiRk/U4xvuAuWMhB5yqZ7o5o1EsPDAqLoKqUqUhVR7vgVbtfPXraxbo83f774F6o4ZL/bg254bVyZsUbn0zrAIQ=;5:YWOX0CAnBWU1X5s9CpkQefBwDNe+zq7OXQ/KSx8uHjqhgluhPsw95vz+UW9O5XO4KLdVGptw4tEQc3kF6nGB7S3HEwBfqiHG2wtjVMLruHeC06FRD2u0VjkzuNiB/5djyE97w+jVNY19rlpqGpIUNyD8i+Y3kPR/lAUmYB/KxlU=;24:xYygtN2kfl3MPxK5ZeJ9krm9j7jeAPE1xlNL8pEPMvxVXMCp1k8SUsUWCm3ZxXVTtL2KX/NyEjZF+pWrhObn7xHOaNLuSI/iZTXYMngeOsM=;7:hfvXXtPYafU8UAwVTobwgCQaqgY+Pj9ppDFIDaOp4ZpiUtQ/tp5TbJuhHOb/0UGYvUkNSbScnJlzwWBYL+CmLTZGfqk2Kd5HqQUD5bHoUTIyS9mJ0GQ2sQdQABjOO9X1IUETjj2418rhCwUw1Nyk2xD2YJT2/JhP6IJ4/YBPfvG8q+UAP3Uygp/Ar2ithxMzBqdkgmPZffisBtd888YH/AusgYulpYQkG0IZwY/tSxWte7tNW1+9XoYSzvUcqIXs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 16:59:59.8059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7422511-d0ff-4381-3814-08d57adee232
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB1316
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM support for modules' PLTs will require a module pointer in
ftrace_make_call() exactly as ftrace_make_nop() has it. Change the function
signature without functional change for now.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/kernel/ftrace.c           | 3 ++-
 arch/arm64/kernel/ftrace.c         | 3 ++-
 arch/blackfin/kernel/ftrace.c      | 3 ++-
 arch/ia64/kernel/ftrace.c          | 3 ++-
 arch/metag/kernel/ftrace.c         | 3 ++-
 arch/microblaze/kernel/ftrace.c    | 3 ++-
 arch/mips/kernel/ftrace.c          | 3 ++-
 arch/powerpc/kernel/trace/ftrace.c | 3 ++-
 arch/s390/kernel/ftrace.c          | 3 ++-
 arch/sh/kernel/ftrace.c            | 3 ++-
 arch/sparc/kernel/ftrace.c         | 3 ++-
 arch/tile/kernel/ftrace.c          | 3 ++-
 arch/x86/kernel/ftrace.c           | 3 ++-
 include/linux/ftrace.h             | 4 +++-
 kernel/trace/ftrace.c              | 6 +++---
 15 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 5617932..be20adc 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -162,7 +162,8 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ret;
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	unsigned long new, old;
 	unsigned long ip = rec->ip;
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 50986e3..e3a95d3 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -68,7 +68,8 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 /*
  * Turn on the call to ftrace_caller() in instrumented function
  */
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	unsigned long pc = rec->ip;
 	u32 old, new;
diff --git a/arch/blackfin/kernel/ftrace.c b/arch/blackfin/kernel/ftrace.c
index 8dad758..61ffc99 100644
--- a/arch/blackfin/kernel/ftrace.c
+++ b/arch/blackfin/kernel/ftrace.c
@@ -45,7 +45,8 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 	return ftrace_modify_code(rec->ip, mnop, sizeof(mnop));
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	/* Restore the mcount call site */
 	unsigned char call[8];
diff --git a/arch/ia64/kernel/ftrace.c b/arch/ia64/kernel/ftrace.c
index cee411e..658a011 100644
--- a/arch/ia64/kernel/ftrace.c
+++ b/arch/ia64/kernel/ftrace.c
@@ -169,7 +169,8 @@ int ftrace_make_nop(struct module *mod,
 	return ftrace_modify_code(rec->ip, NULL, new, 0);
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	unsigned long ip = rec->ip;
 	unsigned char *old, *new;
diff --git a/arch/metag/kernel/ftrace.c b/arch/metag/kernel/ftrace.c
index f7b23d3..635652a 100644
--- a/arch/metag/kernel/ftrace.c
+++ b/arch/metag/kernel/ftrace.c
@@ -104,7 +104,8 @@ int ftrace_make_nop(struct module *mod,
 	return ftrace_modify_code(ip, old, new);
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	unsigned char *new, *old;
 	unsigned long ip = rec->ip;
diff --git a/arch/microblaze/kernel/ftrace.c b/arch/microblaze/kernel/ftrace.c
index d57563c..01b314a 100644
--- a/arch/microblaze/kernel/ftrace.c
+++ b/arch/microblaze/kernel/ftrace.c
@@ -161,7 +161,8 @@ int ftrace_make_nop(struct module *mod,
 }
 
 /* I believe that first is called ftrace_make_nop before this function */
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	int ret;
 	pr_debug("%s: addr:0x%x, rec->ip: 0x%x, imm:0x%x\n",
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 7f3dfdb..9dcec19 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -200,7 +200,8 @@ int ftrace_make_nop(struct module *mod,
 #endif
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	unsigned int new;
 	unsigned long ip = rec->ip;
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 4741fe1..b198433 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -437,7 +437,8 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 #endif /* CONFIG_PPC64 */
 #endif /* CONFIG_MODULES */
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	unsigned long ip = rec->ip;
 	unsigned int old, new;
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index dc76d81..1691d53 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -136,7 +136,8 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 	return 0;
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	struct ftrace_insn orig, new, old;
 
diff --git a/arch/sh/kernel/ftrace.c b/arch/sh/kernel/ftrace.c
index 96dd9f7..2d3cacd 100644
--- a/arch/sh/kernel/ftrace.c
+++ b/arch/sh/kernel/ftrace.c
@@ -242,7 +242,8 @@ int ftrace_make_nop(struct module *mod,
 	return ftrace_modify_code(rec->ip, old, new);
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	unsigned char *new, *old;
 	unsigned long ip = rec->ip;
diff --git a/arch/sparc/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
index 915dda4..36117b5 100644
--- a/arch/sparc/kernel/ftrace.c
+++ b/arch/sparc/kernel/ftrace.c
@@ -63,7 +63,8 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long ad
 	return ftrace_modify_code(ip, old, new);
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	unsigned long ip = rec->ip;
 	u32 old, new;
diff --git a/arch/tile/kernel/ftrace.c b/arch/tile/kernel/ftrace.c
index b827a41..749e50f 100644
--- a/arch/tile/kernel/ftrace.c
+++ b/arch/tile/kernel/ftrace.c
@@ -136,7 +136,8 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ret;
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	unsigned long new, old;
 	unsigned long ip = rec->ip;
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 01ebcb6..389f15c 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -162,7 +162,8 @@ int ftrace_make_nop(struct module *mod,
 	return -EINVAL;
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+		     unsigned long addr)
 {
 	unsigned const char *new, *old;
 	unsigned long ip = rec->ip;
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9c3c9a3..1e8c421 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -536,6 +536,7 @@ extern int ftrace_make_nop(struct module *mod,
 
 /**
  * ftrace_make_call - convert a nop call site into a call to addr
+ * @mod: module structure if called by module load initialization
  * @rec: the mcount call site record
  * @addr: the address that the call site should call
  *
@@ -554,7 +555,8 @@ extern int ftrace_make_nop(struct module *mod,
  *  -EPERM  on error writing to the location
  * Any other value will be considered a failure.
  */
-extern int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr);
+extern int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
+			    unsigned long addr);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 /**
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eac9ce2..d32f2f5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2421,7 +2421,7 @@ unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
 }
 
 static int
-__ftrace_replace_code(struct dyn_ftrace *rec, int enable)
+__ftrace_replace_code(struct module *mod, struct dyn_ftrace *rec, int enable)
 {
 	unsigned long ftrace_old_addr;
 	unsigned long ftrace_addr;
@@ -2442,7 +2442,7 @@ __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
 
 	case FTRACE_UPDATE_MAKE_CALL:
 		ftrace_bug_type = FTRACE_BUG_CALL;
-		return ftrace_make_call(rec, ftrace_addr);
+		return ftrace_make_call(mod, rec, ftrace_addr);
 
 	case FTRACE_UPDATE_MAKE_NOP:
 		ftrace_bug_type = FTRACE_BUG_NOP;
@@ -2470,7 +2470,7 @@ void __weak ftrace_replace_code(int enable)
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
 
-		failed = __ftrace_replace_code(rec, enable);
+		failed = __ftrace_replace_code(NULL, rec, enable);
 		if (failed) {
 			ftrace_bug(failed, rec);
 			/* Stop processing */
-- 
2.4.6
