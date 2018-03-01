Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033233AbeCAQop (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:44:45 -0500
Received: from mail-ve1eur01on0090.outbound.protection.outlook.com ([104.47.1.90]:18016
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033049AbeCAQoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:44:12 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 2/2] ARM: ftrace: Add MODULE_PLTS support
Date: Thu,  1 Mar 2018 17:43:43 +0100
Message-Id: <20180301164343.5794-3-alexander.sverdlin@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 048ffcb4-382a-43fa-48d0-08d57f93a6e4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7193020);SRVR:DB5PR07MB1320;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1320;3:s+m0YmVHU/zV8SPN00tJopAszdj0whLiF3jLjnRQPiFRJgYcwk1Gq8lb4H2c0nr1Lo9THeuotiDru36DHPL6m1Pyqrd6AkRYfNDMM2P7n9oQZXX0cYfNmoANsSIdRB7m3j/7Wu1o561soiqfALpY4miLwToPU9932dNJZluHZQZIhXwgG/+Qb8W9Iajyyz1LOauF0nM/WD3ZLYcLTemNyWseAwE/aOiJi/ISIif2Dj7GdigSUOd6gwutKa/XNERh;25:JIrPLhLXy2uBlZZV2UD7DQoV17D3hE6tS2Gk5kMj3b1EVqV9K6MfTuT/gBuE4lSb00hKeDWKwDq+ovmqCRx+6H4gVti2Drpd4fNwRjUEBJbh2Y9t0qluDNuJC8EtG8j7CGWYmwRS/Op+CTsAeN7WNUaRVzfws1LMIqmZ5xXiGNuoK94Ja3bJfVOEz+7k1zmJSohEGNjbswcGhLLmBdORIeFwdHFi40EWo3REeiw9vHZzcGsxv37OnLP2XKAbOKGdbMPrzxBMgDdrExNce8a2jp6xtloWHcMqsghdJKvnPPDbkto8PB2bnug2mlTFL7Y1bL484UyEdt1pX9i2wUFDCw==;31:3YigjViZHH/4fQR1mPyqHrCUmDW+C7TgV9puJI5/qEFn0+CHe9B6RdocMQ27R9fxE5M4EX7Lvf1n+eK378uC47R9sP/DetJWGNi+7uYCinModHsAce8oh5qKWKtREUpIiZ+ytugevlkk6F+G0SyR9jAZccfpKcHBwDdTjIy/lxmWOMdfLWMRxmkxFZu1Z6f3Lt7FNzcliTaxlArD39A7qRYTy+FZdPSh4Pa7I9QFF30=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1320:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1320;20:anN6uuPz+c0JCkpIARbVpnEcRzjiNRiZ+i60siJZGvpj+wm5FythgFcT1TCh/b0PPaaiIDldMUddzoesLRxs79Qcp4yFXDdskgHWovi8LbpaA5ZC8umZJpTKR3Z8cDzIvMfugtkvagJGdL7Fe6raLH73oPKL+ZIX3kSU2LwXLf0cnMo/oORrSdaQ7q6/yxQ+CBB8KKODGoGMi4rhT+C7oqhiHqLSAKcSKqLzkM2dUe7eQ47rBBC1VsvWha5QAYntVl0eJHp8pE6PADBH39OMuApVRMl7mvmLCbvB9YUBx4sJ2ywfyMMj3mM8lftsTdW3Jx4pfRt5wTWYa77ZkYqZ1kn/ADjgx7VKXK4ZBrryvXskGklzc2ri3kVaLcXF2+zxP57J6nKCLkIkGXuTyUubkM3txjcOJ0fo3byeZsChs+j0JBINv8zDQ2SZoxWZl40mdUyCYRoKAmKm+AhHiCE6w0o2jjdbFbjOD2ecIXsqiD2GpdmMxEQX2/Ls5DgE08sPkeqY9vhG0YyMUD/4/akP8/akUXoDjdvs7eBYOSaK1jcZHr2EtB7NUHsJ4xgPbMjVj+4ulqG/bHJgDt/2Z0C6xOMGzhKyuB+uokBmaAthc6U=;4:kujFOLTNMOCxcpqOVhEhGYBZdXkX7Nv0lnQmJ9qYNP5UgIOzfXm28bcJfhvAxnTsSoebqNtzC3mQUO6MvVU9SAOOyiByU7yhtWn3J8crrcx1m/RutdHvux4r94xyoqtsEiGQbcW2Wa3a5+tw6fgnUtupHxVucVViM4YENwJsItectinrZpbQrDZq6F95FHgJXLqXMwepmUrQns2XkDXyW5YVdcrmxKDUVd3zwk3j9Fx3JJtLRZ47UnTXVt0TRqab2k7kOxCgr1p8bLg+RSD22Nj0XD7QEt77wt5esKe5YN7mDqDZEczyH+Enf0X7DcWT
X-Microsoft-Antispam-PRVS: <DB5PR07MB132063AA178700FEA2590E7788C60@DB5PR07MB1320.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231220)(11241501184)(806099)(944501229)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DB5PR07MB1320;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1320;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(366004)(39860400002)(376002)(189003)(199004)(50466002)(68736007)(25786009)(105586002)(6486002)(305945005)(2950100002)(7736002)(6916009)(6666003)(53936002)(16526019)(478600001)(54906003)(52116002)(76176011)(26005)(16586007)(51416003)(6506007)(36756003)(386003)(5660300001)(47776003)(66066001)(106356001)(59450400001)(186003)(86362001)(316002)(6116002)(1076002)(81156014)(6512007)(8676002)(48376002)(97736004)(8936002)(50226002)(2351001)(2361001)(4326008)(81166006)(3846002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1320;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1320;23:rjY9fx2pmXS15sUu/PtNieoDo7UAsJNqOBIM5WC1d?=
 =?us-ascii?Q?Yw1opX8PY02obOnhHPhmEyoVAVDZKIGep2EHpbnSYfSxL1qxr/tLB3VfR1jC?=
 =?us-ascii?Q?ixvIF4/tXR/H+XfvCYRjqQ7NHi/x5x+ANoFG/vytsIE+AbcIQ+eth45i4fs8?=
 =?us-ascii?Q?hxgny6jxsvO0vyK+mDacQ4mQ6Ho9gSQJSENpsA1h3Jh/GWyG8zenSOCPjTOC?=
 =?us-ascii?Q?UuDsIj20Q9EE0JEkitygYJGsajTLA6v49SF3q+iEb+Cw+VMh9B8QWlqgQ5A1?=
 =?us-ascii?Q?Kfw0IQj2vsV2Rp1wnd1W5asmO3p0QjcEpe95rCJ9c27oudzIRXiFFyzQBmTT?=
 =?us-ascii?Q?y56gN0Ow2R0y9EWZ5LzmiwgXEabIrvvwHd8mHQTFn7kUO1BTMd/8fpkTWK7d?=
 =?us-ascii?Q?hdhWTM+n09TJ2Nz2kimxnVwA3Fc2IWvpiwfB4VYV7meU5NPEt3G7h1jU0Pus?=
 =?us-ascii?Q?xyHta7utaLwYQKDCS/Nvo7VMneugQrnIWwcSJJD+XeefuAEtKXx0O7B3foKA?=
 =?us-ascii?Q?vm+pgrGegDW/7NtcAIzD0CvmK22Y/vISnqKb1Tepzm5l08IV6c2APQtOGwXr?=
 =?us-ascii?Q?Rveq1DoXVg+CrMEl34PPxTNPppKE8qAs4w3XMPhf6+bZDZ4dCYHAJezZ02Cy?=
 =?us-ascii?Q?y9oxFeuYwODZH56YI+ATzX3ZCGlpb6AgUR6j3AbQnspS/SyuDceeUIa/khjo?=
 =?us-ascii?Q?txejbJ9O8GaeO52f1oOKyqR+fS+8QNScMdwVTN1NrB2tUMmdCQTk8s4ze/o6?=
 =?us-ascii?Q?7PoJb+QEokXOyPairshSvHB2rUpgLIkelC81hA+wQr2+p04T3akLudv4nb/m?=
 =?us-ascii?Q?3mZ/uHNxjUKIKoQo7stBm0ZWIcdZZb3t6XcRdmx6AJuAf1RpNFzEvuiVuvzJ?=
 =?us-ascii?Q?pIcuVBlnCqIgxrAWWIBXR6/KZi9Gz4DMEQ6h+oWOK2pEXYE0bvx5uwY5eoJQ?=
 =?us-ascii?Q?B8EPUCyQlkX1zOyA47sgcY1Crt2F6hjTfRQITI2a6/6YY+3Ikw26oxXJLnF+?=
 =?us-ascii?Q?kSyDM9F6o1hwypiymwz5ldEAT+VgB5+9cJmFtH9XTs0Szg6ELHU9kHSeh5yO?=
 =?us-ascii?Q?kaeLNPFxVzIn17w5vLTazoLB3ei4wVpCob7sChsJzBg8wVrG5N4BZ0ArAwLq?=
 =?us-ascii?Q?LsDEVW45HGLQT4rks2lYedyMWuv7bIBkI8GVRP3GSggBNZXjB9K3xuGZKInc?=
 =?us-ascii?Q?ic7IhvFuyJzd2SpahOqUFOC3p2z5OHuLTxy?=
X-Microsoft-Antispam-Message-Info: IxbxijJEoNcLp4QVpzXa/7jFbfVfuYx81VDg3U4xaai3wBUWLVjgNhayIIyIl23YywLbs5jw2bPrMknjxlwpQg==
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1320;6:ERTJAzeYmnvJxuAhaApISk8xLbYg9U7CJzjzYdrjLtRmOY/zjU9N3eUviLGJQDlCKbwmkntID8/XoKAGzIlzDRN8kkU74aqTHWs/z9rZmvm0vxgScv7vu0KFe7fl5Ko2J9qQH9E+yL2S0cgOx1s0dGfjr1eZXsAYLqMKXywc74kz8TS32Lod8AJ7rHrxJe/yunYsdE4ovdwzIledw1FIdRLo1ueMd4gi9ntFkBIMD7rsTFthWKqumpFvJZlTyhOUf4VTYU2BOKwgHiGkGi47OaEZc1ghFErlPsS3dIYTPZaPaP1fQA9a6ufNCxXd1pRZoWl8NQ6tlvymxyNa+kyP2ecnjLBMKDIkVwcsHYJ6LUc=;5:A5ppjwNbJwM6s5F0tQuni6GPvXGbUNTCBiu4Fef+QplpotI3B9JY4z2gBT3YCRMjs5h/zJwfTRVTGjoMZbhddCJz+nGAfGgaDzTwVsOQZzirNOE27CY37Lmn1+elHNJDeNKCVSK+rDT6yHw4CLKw/3UOij3L+1K1rWhgdlsC7o0=;24:z18ziP+ZUwBkpHtxq032kC5O6CxrA5BU74ALh4vYr5DDM04IyxEHxLIwrQVb1gBZi/ton9Q1UMaAnlWZRYrRxfrRXI/DHiSGf5OLQ3/wJLo=;7:1t/6s3vhw8csMm3DwSR4JH0rKw/X5gyEFmu6thyDP9D/xTHuoyORWQcFtDE51uGRvwlKvrhYrsk/dcitFvsl3EpvWCv8LFWNra0MQy8FYCgzKBsITeKILr7pm9l/UsBNZYhW6RjAwkp70u71po97FgktHNWNqt5oiRT1z9v8TtUlczS7n/D9CcfPqNIqaDhrR3htktoOmHVIXifuRQUApgs+H/8Dp+EDgbCLJKGxa1SUiZ+PACjWgiVzig9gWesv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 16:44:07.0763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048ffcb4-382a-43fa-48d0-08d57f93a6e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach ftrace_make_call() and ftrace_make_nop() about PLTs.
Teach PLT code about FTRACE and all its callbacks.
Otherwise the following might happen:

------------[ cut here ]------------
WARNING: CPU: 14 PID: 2265 at .../arch/arm/kernel/insn.c:14 __arm_gen_branch+0x83/0x8c()
...
Hardware name: LSI Axxia AXM55XX
[<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
[<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
[<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
[<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
[<c03218f3>] (warn_slowpath_null) from [<c03143cf>] (__arm_gen_branch+0x83/0x8c)
[<c03143cf>] (__arm_gen_branch) from [<c0314337>] (ftrace_make_nop+0xf/0x24)
[<c0314337>] (ftrace_make_nop) from [<c038ebcb>] (ftrace_process_locs+0x27b/0x3e8)
[<c038ebcb>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
[<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
[<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
---[ end trace e1b64ced7a89adcc ]---
------------[ cut here ]------------
WARNING: CPU: 14 PID: 2265 at .../kernel/trace/ftrace.c:1979 ftrace_bug+0x1b1/0x234()
...
Hardware name: LSI Axxia AXM55XX
[<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
[<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
[<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
[<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
[<c03218f3>] (warn_slowpath_null) from [<c038e87d>] (ftrace_bug+0x1b1/0x234)
[<c038e87d>] (ftrace_bug) from [<c038ebd5>] (ftrace_process_locs+0x285/0x3e8)
[<c038ebd5>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
[<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
[<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
---[ end trace e1b64ced7a89adcd ]---
ftrace failed to modify [<e9ef7006>] 0xe9ef7006
actual: 02:f0:3b:fa
ftrace record flags: 0
(0) expected tramp: c0314265

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/ftrace.h |  1 +
 arch/arm/include/asm/module.h |  1 +
 arch/arm/kernel/ftrace.c      | 60 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/module-plts.c | 53 ++++++++++++++++++++++++++++----------
 4 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 9e842ff..3e663f9 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -19,6 +19,7 @@ struct dyn_arch_ftrace {
 #ifdef CONFIG_OLD_MCOUNT
 	bool	old_mcount;
 #endif
+	struct module *mod;
 };
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 6996405..e3d7a51 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -30,6 +30,7 @@ struct plt_entries {
 
 struct mod_plt_sec {
 	struct elf32_shdr	*plt;
+	struct plt_entries	*plt_ent;
 	int			plt_count;
 };
 
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 5617932..eff306c 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -98,6 +98,19 @@ int ftrace_arch_code_modify_post_process(void)
 
 static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
 {
+	s32 offset = addr - pc;
+	s32 blim = 0xfe000008;
+	s32 flim = 0x02000004;
+
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+		blim = 0xff000004;
+		flim = 0x01000002;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
+	    (offset < blim || offset > flim))
+		return 0;
+
 	return arm_gen_branch_link(pc, addr);
 }
 
@@ -166,10 +179,22 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long new, old;
 	unsigned long ip = rec->ip;
+	unsigned long aaddr = adjust_address(rec, addr);
 
 	old = ftrace_nop_replace(rec);
 
-	new = ftrace_call_replace(ip, adjust_address(rec, addr));
+	new = ftrace_call_replace(ip, aaddr);
+
+#ifdef CONFIG_ARM_MODULE_PLTS
+	if (!new) {
+		struct module *mod = rec->arch.mod;
+
+		if (mod) {
+			aaddr = get_module_plt(mod, ip, aaddr);
+			new = ftrace_call_replace(ip, aaddr);
+		}
+	}
+#endif
 
 	return ftrace_modify_code(rec->ip, old, new, true);
 }
@@ -199,20 +224,37 @@ int ftrace_make_nop(struct module *mod,
 	unsigned long new;
 	int ret;
 
-	old = ftrace_call_replace(ip, adjust_address(rec, addr));
-	new = ftrace_nop_replace(rec);
-	ret = ftrace_modify_code(ip, old, new, true);
+	/* mod is only supplied during module loading */
+	if (!mod)
+		mod = rec->arch.mod;
+	else
+		rec->arch.mod = mod;
 
-#ifdef CONFIG_OLD_MCOUNT
-	if (ret == -EINVAL && addr == MCOUNT_ADDR) {
-		rec->arch.old_mcount = true;
+	for (;;) {
+		unsigned long aaddr = adjust_address(rec, addr);
+
+		old = ftrace_call_replace(ip, aaddr);
+
+#ifdef CONFIG_ARM_MODULE_PLTS
+		if (!old && mod) {
+			aaddr = get_module_plt(mod, ip, aaddr);
+			old = ftrace_call_replace(ip, aaddr);
+		}
+#endif
 
-		old = ftrace_call_replace(ip, adjust_address(rec, addr));
 		new = ftrace_nop_replace(rec);
 		ret = ftrace_modify_code(ip, old, new, true);
-	}
+
+#ifdef CONFIG_OLD_MCOUNT
+		if (ret == -EINVAL && !rec->arch.old_mcount) {
+			rec->arch.old_mcount = true;
+			continue;
+		}
 #endif
 
+		break;
+	}
+
 	return ret;
 }
 
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index f272711..a216256 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sort.h>
@@ -22,6 +23,15 @@
 						    (PLT_ENT_STRIDE - 8))
 #endif
 
+static u32 fixed_plts[] = {
+	FTRACE_ADDR,
+	MCOUNT_ADDR,
+#ifdef CONFIG_OLD_MCOUNT
+	(unsigned long)ftrace_caller_old,
+	(unsigned long)mcount,
+#endif
+};
+
 static bool in_init(const struct module *mod, unsigned long loc)
 {
 	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
@@ -31,26 +41,43 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 {
 	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
 							  &mod->arch.init;
+	int idx;
+	struct plt_entries *plt;
+
+	/* Pre-allocate entries in the first plt */
+	if (!pltsec->plt_count) {
+		plt = (struct plt_entries *)pltsec->plt->sh_addr;
+		for (idx = 0; idx < ARRAY_SIZE(plt->ldr); ++idx)
+			plt->ldr[idx] = PLT_ENT_LDR;
+		memcpy(plt->lit, fixed_plts, sizeof(fixed_plts));
+		pltsec->plt_count = ARRAY_SIZE(fixed_plts);
+		/*
+		 * cache the address,
+		 * ELF header is available only during module load
+		 */
+		pltsec->plt_ent = plt;
+	}
+	plt = pltsec->plt_ent;
 
-	struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
-	int idx = 0;
+	idx = ARRAY_SIZE(fixed_plts);
+	while (idx)
+		if (plt->lit[--idx] == val)
+			return (u32)&plt->ldr[idx];
 
 	/*
 	 * Look for an existing entry pointing to 'val'. Given that the
 	 * relocations are sorted, this will be the last entry we allocated.
 	 * (if one exists).
 	 */
-	if (pltsec->plt_count > 0) {
-		plt += (pltsec->plt_count - 1) / PLT_ENT_COUNT;
-		idx = (pltsec->plt_count - 1) % PLT_ENT_COUNT;
+	plt += (pltsec->plt_count - 1) / PLT_ENT_COUNT;
+	idx = (pltsec->plt_count - 1) % PLT_ENT_COUNT;
 
-		if (plt->lit[idx] == val)
-			return (u32)&plt->ldr[idx];
+	if (plt->lit[idx] == val)
+		return (u32)&plt->ldr[idx];
 
-		idx = (idx + 1) % PLT_ENT_COUNT;
-		if (!idx)
-			plt++;
-	}
+	idx = (idx + 1) % PLT_ENT_COUNT;
+	if (!idx)
+		plt++;
 
 	pltsec->plt_count++;
 	BUG_ON(pltsec->plt_count * PLT_ENT_SIZE > pltsec->plt->sh_size);
@@ -182,8 +209,8 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned long core_plts = 0;
-	unsigned long init_plts = 0;
+	unsigned long core_plts = ARRAY_SIZE(fixed_plts);
+	unsigned long init_plts = ARRAY_SIZE(fixed_plts);
 	Elf32_Shdr *s, *sechdrs_end = sechdrs + ehdr->e_shnum;
 	Elf32_Sym *syms = NULL;
 
-- 
2.4.6
