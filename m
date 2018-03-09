Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeCIIm1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:42:27 -0500
Received: from mail-eopbgr10123.outbound.protection.outlook.com ([40.107.1.123]:19872
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750926AbeCIImS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:42:18 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 2/2] ARM: ftrace: Add MODULE_PLTS support
Date: Fri,  9 Mar 2018 09:41:51 +0100
Message-Id: <20180309084151.2379-3-alexander.sverdlin@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a679d04-f651-4ae8-bce5-08d58599a6c0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:VI1PR07MB1328;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;3:HI36nfah/OJy8JJ1tmKODb684R3liYObcDYnO1gRp7VCf1YhNDKr0XFpqKVQP+Q6XAG629zA1UapRZE54eqoq6dQPxCJx4MRyqGcxkYGkPtf1/JQd0gNa1C/iE9GcfuLdS4MsY6ZzBk0KYWUEPjOanlE7+HHHgntlrmqFow0tLWdSPwvQAJ7oYw2vfG0PVd+uEftstMo7aPyfhj+mcMvipbXPWqT0dYdks+kCkzGKTLN7IZH5qixZj5LLZ73/cA1;25:4XsI8xX/41mSfhX/UrwxTrVHFtOGUiMrHCJz8J+/fb51WSYB/l7otv0B+ev0aFWf7Tn7mvIb7T+Aidd2LFgloBCRDVLi8T4dfAwKx38i+8II4jyCqvJbbOptZR5x4jczqxXF3kYdWr9JcNGLx+9TaifeTPHlCHxDJHAtfyIU7TrZPaynQHMMUkoe3ZyZJ/7z0tdZ5Jk8QENzsXRLBPcd7CYSsNl87AynmWwqy5rIILJz8v3QwP0h/aP+9146lj6+sCzvF+7UVgj8RfIIUw9EBCizX/AV4C7PfHyEVav7LFADWW+kKQ3tl90QxXGatMuWMn2sdxAOTouEsAVA4kNs6g==;31:r7QOWjL7uhRsiwepBfm9dv46RU+qsyQ7E/p9FW0pcFp10xCMiHQ3Y+VgPqRsyOqm5MPAUl+Hb4x/IlR/+VyR8Fs3K+HhP1M9jWNO29RNHaWdznKdYVWVtxd8t4AEYnXo+dvqvKairL9UytjTEZSwkqK4aMP+PuHQIpDRbOFX76W+aE7gKLxp1FfqHo4R31g28qRuU7wPqgTM/jNe7FqJPyjaRKNwR5dYvVJh2zBXZZQ=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1328:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;20:dyzGOwNS4Ha/eD4c0ha74ETDCLX9dHDIhGWOfvjPWYB/rlMOZ06x2/ZDJbbI+InrawyFfL2e3N4BsHYQQ+JjvP2uxloBFSCWka1PIXuJWskRrzTviDnPAoLfpAwu+COxcIzPWmk+CSYlbFnt/UMD+0FLppr7wkH/+ZNYZQs5I/y5lJdtrh3OzvkvzRe65Hr6NR9Z3waPhBTvfyJOzDdbfPg/0WNkD2gtInWkmxsFW0Vyykf6nP+KHNVhHlpqyl/2Sd8U6XAatJcuYrDMVEulr14OhGP/EHvR9sJ9xGrbxx4K1o15A9UGyB71hCSHqzicySGGVE0eGjN7NCtxcr8bHmWEW6pbWViIc1VoWPjUkFwvttacHZ4uwmEDKiuGBBGR4thqYjZg50nKSPhBrFJEQhhJYg5Mhy6PeGsGqdLBS9rlYdbEs9UHJVIhilban6ye2DTjmJ1K5MMh0TKQcArLEZzS9Tuzy6LF833KBeX4/2WR8wL32JxX9bHxr6GO3oKaxAgsY/7Lphlha62AnxOlA1/TtJ2YQqYCPOI/8axS3Nyl/Z4UCRBsXSka5ufMkfHyNNuJwOk2Bx7+H+wBgbeCtKraAC9nQnSSEns7Xt8R9Yw=;4:TVRM7LhAvGZCRq6jww9Hor5bP7i73IC5nOOZpfG94e1Z9pGoBca7Cpt9WWYbcMmSnlYJLjMmypHZHqOFru2xqbHEYyIQnScmq/eLe75fnQod6ZWryU9k0fJaPjVDz6NmdA4kVcSgMKcfHGqw8VUV3IkRkOR7mPKa5PRRCJxbCTQqFbbqe/1BojjAnvv6UgB7nHZah3ggejWuyTiAfmSkhdYDCiVcb769S7n9A9wbitNoh4+CqRtVZeDh/Hnf6fCIUGLiJtDpCX0HXhcXZF6lg305Sla89OSMhEy8dKo5jHQzhIxtbaY6+bb7vXA8PcVs
X-Microsoft-Antispam-PRVS: <VI1PR07MB13285A24F008F35A575B150088DE0@VI1PR07MB1328.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231220)(11241501184)(806099)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR07MB1328;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1328;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(39380400002)(199004)(189003)(48376002)(4326008)(36756003)(86362001)(106356001)(6486002)(25786009)(97736004)(105586002)(51416003)(16526019)(50466002)(59450400001)(50226002)(52116002)(386003)(26005)(76176011)(7736002)(305945005)(186003)(6506007)(8936002)(54906003)(3846002)(6116002)(6666003)(8676002)(16586007)(68736007)(316002)(66066001)(1076002)(2361001)(5660300001)(81166006)(6512007)(2351001)(478600001)(47776003)(2950100002)(81156014)(6916009)(2906002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1328;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1328;23:ii2rWmjN4XWAp9S0fy5dMA14MbqNJ3dYzKxViBJ+v?=
 =?us-ascii?Q?VLeH1ND1QONF/aMTC2DAVSHvUP/05Ocupnr3InW1RHWZp/zsgu5ZOL+eM3Fp?=
 =?us-ascii?Q?atBw4LE/yG4D5BV3ik8ULl1BUt+1KJ+3mByqywhHFkPogv7Tiv/PS8STuQb/?=
 =?us-ascii?Q?b7C01mT2qhC6rjAk1VMSO+PSIlNr9S5DZGc/jYxshDAgjdNi7SG8qyzcnWOn?=
 =?us-ascii?Q?+CbCy6hK+kmopBB88SaBdZ6PqngOGZESUDvXrWTw7HgjihyEwNF+1R7HGQAL?=
 =?us-ascii?Q?H8KMAIi2UtyUkMJOi6j56lURGilzlM8M6anh6F6gnZ8w7ME5/VZ7g5QpI3Nl?=
 =?us-ascii?Q?3HMdD2RUQCwz287fWT8pDhujHFIJ2f/4D4escs7QOhmMSK1APmx0ZMHPMr64?=
 =?us-ascii?Q?sPth3zaDhCJS9Aod4KFRJNpinZSuBsLCJTOjQHFKkfrO1oLRHYvESFdptBbq?=
 =?us-ascii?Q?kDOw9zoJQJ/YgG9pQ2kiq5JGISrcY1YsUwi2h3LXht9sl+s40w7iwiRoL9GP?=
 =?us-ascii?Q?5NvE+Z6129KkOYCzDBC94V2+CS4N9J0/329I4d47I921iMBgL2pjwtp0z2+A?=
 =?us-ascii?Q?6tGfIMxONcVdPdnd0znDffOeML/KYxvHXVQXy/de3hWcLcUyahvmByb+6f+X?=
 =?us-ascii?Q?EPnRW10KkpXwsVb5Y/YczD9L4y7bc5eRQbQ5XiYTB3vbPrwk1HSp5re6aKcL?=
 =?us-ascii?Q?eg0YGFLEeQRTHURo37mPamkLjjBxOF2GGcHskW/fk/21ny5GJU00nfnTS+sj?=
 =?us-ascii?Q?bz6A7TQvGOgrSrbwsgLIxXm7yz1ZsXkd6Yhw9addHhmOXCk0Go/2/PRijJgj?=
 =?us-ascii?Q?ntnY2JMcsmy7oJV1GQwPKwtwzJCgG9QWKrsYVdtfP4gU++UCIwRgZIvvOdmZ?=
 =?us-ascii?Q?rI7AyeNdwKN0sVpP6qHgc5cD6qv9JH+GiRSZ7A/hgPMwXAwB0undi7V/4klR?=
 =?us-ascii?Q?mnX4HKAk4VsruAQ2rreA5Eufe0b89J6/uOvbWfFzJOl9bg5EcdAuqTq/oPwU?=
 =?us-ascii?Q?RjSy0mND53HGYPG2hZaUJKXR9VNb3mWD8TOs/7uK/+kDeiOoo2URCKfvl+xS?=
 =?us-ascii?Q?HDADjQWHL1OHicYepC2GmAsiQg4h8oQjKX8H2OBTb4KGZbJw1xxI8ppzuuXg?=
 =?us-ascii?Q?yZYkouUME5VPoxYRfUhdrO05jIJhKhLCAxBd/bOPk5dXBeYh3r8SuPijzGdL?=
 =?us-ascii?Q?cdLFT0t4lO8Kb/LKOhQuGeWX0asv1Q914YD?=
X-Microsoft-Antispam-Message-Info: a8q6FbPH8r2hKKe9ploBlEbu79CjQlt/CKESQUHyh6zIJ8FW0M1YSnY6pEvUsprJ9J+F0Swd9Cmg5/zOi45o0Us7gTfNl7O/+TICqw90TzloGlZk+V07OAaLaMxisKQOC+yuYwDvcUaPj41Xy7XtNOdms/Ho7g5WQNf6/E6wezIBelo5hjujPwtqgcq0x4aKMyOiow41PwXrrAGoXfWP6m8QEqSH+/5RiesZuumt5tw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;6:ysvRwoVew/rIvkIMmfZgdPh3VzAxnobwBP2wxWeYirxPiNrN/6KVSIZ3Yq2+U8TNYqZGRcdpZjuQQLg/mAAuGauPm0b5irxR8KfM+comwCaLA0g6kK2TVfcLUxJ7Mn82cb+knsl+ElofvwgedZAEbFJgIM0FaAm3sr5krZdhKVG95XnB5Mbl/89NhIUgAvMXqQvtShOYKt8lAYRX4botfeW6sKbKWWlxzdKPj8tXjbDefI7sWoSsiDAtxKFkJSrh2qq09mjmwKiQYwIp3lKwQosdCGY252EyaeLFLEuD4hK7zMjIAGlgBC5hpA23W9ID4WqZqkhV9fFADiqHevoA9tDISz3OoKNZKm0PAPLpoXY=;5:ARjtLKNho/5VzVsvgmk92Y0RT+c8Is9limuHcxk+Hx9fv2ra3UKOHoRhLtcqBzgGY0ikf4A3mFVUbFk1px5gPewCREeLQD/u/WlVw0bDEKMgafZC1mnkwWf97I1AFdaGZS1EiAJHo+IVaTp71A70d8BUby9rdq3na0YJ2mXImtw=;24:NTz5gW8qGBB69lVoi13CVjKx0QqSBFo51kpukJXwsCFehV46/Z4yph/3YAsgLHKwsjmVfBy3Evy58OvnL2gb2uMqdetymvPO8y/sQDyoYzg=;7:j5dfslCjA4k2EzaXLDWM+gnPnpG5c2B9W3QbvlY2MkmVbjro+Do55c49z+sbRC3ExjZRc3bhxubUAtVWHG4+TB6+tSEVPvzaA4LKUfyZzK93IEuJNkr0RSLqKneatJgSYFo7kaod0Y6mOQBmPuijyvYWG3i4UV52LrEJYV6AOU8aXwwOWI+9U0q96aOtpTKCKoG1Uy2XQhfz204I1Gw9hyh5bkp4nGW26tJoMZD1vSPat6ZlFybx43SgGNB3P52j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 08:42:11.1038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a679d04-f651-4ae8-bce5-08d58599a6c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1328
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
 arch/arm/include/asm/ftrace.h |  3 +++
 arch/arm/include/asm/module.h |  1 +
 arch/arm/kernel/ftrace.c      | 62 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/module-plts.c | 53 +++++++++++++++++++++++++++---------
 4 files changed, 97 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 9e842ff..faeb6b1 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -19,6 +19,9 @@ struct dyn_arch_ftrace {
 #ifdef CONFIG_OLD_MCOUNT
 	bool	old_mcount;
 #endif
+#ifdef CONFIG_ARM_MODULE_PLTS
+	struct module *mod;
+#endif
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
index 5617932..b55355f 100644
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
@@ -199,20 +224,39 @@ int ftrace_make_nop(struct module *mod,
 	unsigned long new;
 	int ret;
 
-	old = ftrace_call_replace(ip, adjust_address(rec, addr));
-	new = ftrace_nop_replace(rec);
-	ret = ftrace_modify_code(ip, old, new, true);
+#ifdef CONFIG_ARM_MODULE_PLTS
+	/* mod is only supplied during module loading */
+	if (!mod)
+		mod = rec->arch.mod;
+	else
+		rec->arch.mod = mod;
+#endif
 
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
