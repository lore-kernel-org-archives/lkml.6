Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeBWRAX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:00:23 -0500
Received: from mail-eopbgr30114.outbound.protection.outlook.com ([40.107.3.114]:45087
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751825AbeBWRAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:00:16 -0500
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
Subject: [PATCH 3/3] ftrace: Add MODULE_PLTS support
Date: Fri, 23 Feb 2018 17:58:49 +0100
Message-Id: <20180223165849.16388-4-alexander.sverdlin@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad8ab03b-157a-48eb-3c85-08d57adee6e4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7193020);SRVR:AM4PR07MB1316;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;3:ZU7++AHDVV8eQYPq8iXhvsiDsMT7OHbkQC7fjSfVnGrdRSm2PEPuTW4R7tcKr23it+j+m86d20v1FzWJ8QGlYhF6yGNlZkHvHLjmQeHf44xVjqsWFGryqXI2PO0jxIflkXZaa+ge3/t2aSFx1Wdbxv/PYNoABWK1xXev5CjOtOoJqCmaprT94GdGgH5w1Gm5NzEmEYm6pjwnpxJWm74+jAaaUQkBpXp67yDQqfjRZEoJPn+GeXDUSQRsXy4AkNNs;25:xf/uVsHx5xTTcLcaV7gPTo0Ge0nLi9XMEwucFD8TkvyklLOs4yGzGp+ZGswBXbVv8EzfscBHJokuGV7IlF33p26jSTjQZHQATn0avmnFi+UNYPPdjE5nmBUhwI/kaWhiHZEeCSjq0kDVv2j4bAr3e9/kYAN/Vws6NcTvzFcCsqQ9GQtRBxwsu2pfhjZgC7kc22bLqmE192Imv5pJAANPEDFSrIm6OgK1Mnhq8ynVWjtpaKObqzAcKJEPUQDNNezMkzB6IU4hZMhccLIZ/2Y9E2U+6njJrm5Y1Fm/crFgWJ6ptIEG9oGO/+6nzLSlbh22nDxdJIZliKkP++MZX0F5rw==;31:uPgiGPAkMjhxm0F6PbRZJv+iztDSiP/MpkiyM51UxmikpfRUjkY8kyLX6GkralDjXCOpebI85hP2miBvTxQ0dN3fzPwrEcBSH99G1ry3c9Y3ewC7uCpbDs5comp4sgeHW25OJtawCt10YnW84ICGCNYk6I4HsiRBQOVBqQcP8GQHxKJkr6+2GdRzV1kt2D8p2lHp5ZTYpQqIXh4DuOn6xZ3uN4CttwgIRydkF0nM3Vw=
X-MS-TrafficTypeDiagnostic: AM4PR07MB1316:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;20:gY74JIjsr10Kf6EGTYKQ72zXIHeIF/mYu4sS2sX4Ktj3BvfGVVzUFLX3jC9Y1lw4QKcGBlKINy71SVuEQZv8cBqQjE3a4KpJf0A2Ot+bl2FlmmRw5q8W6C3GvcmigS5MuLdHEjZJcJ0dBA5ChQte4IV/fkBMPfMB+eDlkTliI5tyXxAPoOCWFtt4zXM2PqMHgikf4dd0+QoZ2t6TjXX0buvt1SWlb3u+y+R8U7c9wtNLb2VpZY3su4Smfge/qEANlvvQfBrAYWSKSSIari5CvSsJxrFiXhb2czY61LPnZVg94exV5HnuIV3PrR6XKVTkthcfrwkcEGKBkjRxsigRd70nFMaBBpzJAjjmdqfIDOGW6QEVrXtcL/8JoYal8fx6C9gi9R3h9Ot8VSxlCL+1s2ualzQBQ0fyTvrPQCASufGZpOd15ApnyLHXKHwMcEahZAk39SzY4+wIVX92U5nGFDbmNE1cIXk9k36ZztptpOQQK0WgKE/GU76Qdfj/KKXiZVEYujwVHdtalWXidnGDIx0sKlvou1nx7qMfhXUn3T8ALmilKvIyUV7xT5PZZ6I9ahdlKLAR7XXsNrAjNX96LbwmUYwcY1x+vack9Uswce0=;4:7oZ0K/nBw16mh6R2Up/Wz1lOStmIv4NEiPq61hCBjHVyAgxWWOeyaW3I4hvqees2FfeJ4O/vo8Qug0NzJPeysn3CtB/j4z0TB2iht92u11UHqz1iqsfN2syS6t3mKHMz2icn/KC786d8ePJvFKMVf3HTGRRkt3tSo+GaQ9ajRUd8Grc5crl5pS8l+YMVHa0eNL7FMmyJAag7x8JgSzwVfzxqsiw+HdEzY8jWVyaXpbkapkroYTnMOElKJVpEV/LvYcmINgej1LPesexrz1grA/YQmBTllNECP0az+20Vzh4P/qeYGN6iFDRTJgI8stmD
X-Microsoft-Antispam-PRVS: <AM4PR07MB131608FCDBF556A19A0E672288CC0@AM4PR07MB1316.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231192)(11241501184)(806099)(944501161)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR07MB1316;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB1316;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(52116002)(6506007)(386003)(7736002)(305945005)(2950100002)(76176011)(1076002)(7406005)(7416002)(97736004)(5660300001)(6666003)(6116002)(59450400001)(39060400002)(3846002)(16526019)(186003)(50226002)(105586002)(478600001)(106356001)(81166006)(81156014)(66066001)(6346003)(8936002)(47776003)(68736007)(26005)(8676002)(86362001)(575784001)(50466002)(4326008)(53936002)(51416003)(25786009)(6486002)(48376002)(54906003)(110136005)(16586007)(6512007)(316002)(2906002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR07MB1316;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR07MB1316;23:zPwnB84J8MIwli2yRrwsWlLtSSCv/Wx7yoKpkSJzu?=
 =?us-ascii?Q?MKmqs2GeybZMTTZxcX7+ySr2XKgkVnuPi1OlGpmzq/IFwaQUQfcXvakeYhqk?=
 =?us-ascii?Q?EC2gG7+PPT8UIZtn+GPKbmanMB0bSnmSHrRVY8MnMRFzeK8m7GMNvTc5oVT4?=
 =?us-ascii?Q?BeAjnckTI37RzxL+mIB2021MQBut+S4AbcFRc9B/KlLnFVddqxLlXb6cfaT/?=
 =?us-ascii?Q?Q3XHvyXgPrb57Up0QXl8rgYmisuOdWwwHxYPHqm8h7OMINNZHHP5m/sDQoXE?=
 =?us-ascii?Q?XKCa0JSz4wC3Df8nO8vDOak1dguVY2566DvT0Lg35hvifaPHGqDY9Qioxg23?=
 =?us-ascii?Q?ClFfsE8us6CDBXD8BcvYE0akJJgf8Hso4ZvSQo1fWZeEX0R5mx/NtecgrKKC?=
 =?us-ascii?Q?wKxGKQIewFxzIGB/TtdICabdOTYKmVraBfOIucBn2dK8kXsFx/vx05AcX/tr?=
 =?us-ascii?Q?85ljjKJ4kavkk7kNKOl+h0ZzElVLhD5HuwMJu2w18Jf9DS3lZS9CA2ycTNij?=
 =?us-ascii?Q?nMOauEkNFxBB1zcwYj6AExVBc/1rRpExNfUOFa4sOOceyCIRNzchRa6fr2xs?=
 =?us-ascii?Q?e0CN7Yl2Umt58IUTsTpYiWCnlsjP5RoenpEXaLrYlniHhE1Ld3f9PG53LHFS?=
 =?us-ascii?Q?eTIHSuOCTnKWgyqnKG8XO8QN4JbeokwWL096vsSrzkhz+DuAlhlFFhQVGTcR?=
 =?us-ascii?Q?A7vG3RwG6BW7DTj8Pu8KmkOjf6VEhQja0n9HPRdN90A4boVLq8uMp0X2NLtt?=
 =?us-ascii?Q?bqGwz+46msBuVtDCo6Lj9kUfFrTiyRbRo36sstKvAw6KReLDfLo1l5USU4ti?=
 =?us-ascii?Q?/i8Ban8i5nO1RoTRfI/apDBwag6YLP5HVLQoTmfRS7AtL1IP8L6rMKvUwk0B?=
 =?us-ascii?Q?6PIUkui0nkteSsmXpKX6McZmFIO4rIb3j+GsxrhFqTUDwMBfB8PbJ1FhI1Z5?=
 =?us-ascii?Q?iFSly48le0wJnV6oTA8Ie5xWIN12vJGqOqDYZYjZpc4QGzBb69CbpRX3PhGl?=
 =?us-ascii?Q?/91QXgEzqhBFTPTjr/7RL5ZHcMf0IZROLAYPdAb4IrnDctAARQTdYnzAQJNq?=
 =?us-ascii?Q?CEXQjK7kx2fiRow+P/H7j4cI61IWDQgp+/d8z3MkLj357BzOn7Y0d3uul8nV?=
 =?us-ascii?Q?JQkspHW7lxyKWPj0E1aovC3taWJ2LFUHjhuN/DUjGCLJ03fNSRQY8GYtRm+P?=
 =?us-ascii?Q?n5I1kPkaagF9cHcXgc3u6qDFM2IBEY6eiyoKXinIjvyBT9vfRDODUgefHRUP?=
 =?us-ascii?Q?7WPXJCDtzRwuk3X9nN2Ojw/1zgSmOP8d9zjiEun?=
X-Microsoft-Antispam-Message-Info: 8CeGaz9UXEEDCj7kxcwydKgGBEwKun2zebrqB+doT0QRoqSHLwDypqgXQmUI+44nGa2F5mqVv4qbXYaNurdOow==
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;6:Y/rpW58nS0YTD7q50lt0PxgYSUhx3i5a8UccKNi9G4Ev/Y+nb9kee3U/UOP8Vpq3pwP/pIbO0v3kKuVGeKmcBcPJVgIOP9EVykbicvHXpb3nKj2LiGzoDO6MFrWy8oVKiOrvD91nC3BpdHc2bN0i/oio84nCW5bL77dNPIG6w94WrtADVC1WrPK1mwpwvnLplJOoyaTiQmN5HVTzTf1t73u0lS7AlszEhsNLY4jZ75sHne3S4qBY8SZeb4xp9FlCdBvRbJw0r0vz5Qc75g4Yu/uFup/aNf79AkBTgRiiakUO9vD+wiwwYZv4W5TXGzEDDtx3lP5ksYmkFMtOfxCp8X/2Azbehk2JQzeyPiWkTRk=;5:tfj3FOJ4uyajhYKSrVxSng+yFyX2EK1x86XXqFORIYVl8+jot/bbLjyf97Dfcb2yo2ntkXwX6aVhrbtYXF0AtURDBuK4QBDaaODjdhVtaavrVDyCi0XUMkhYN2ch+jN5Q3Hrqj7biIbK9XllKX/cW55N3HychgqRIpEhgLZDw1A=;24:PPsFI/2HJAaQmE5uvtflCnEff1mVHlZ+VUD/NLtRs1hvkS5F0FY89bWsKEScsbFVS0VRjFMzkZIDdedt9WsteqkepYW6kcsJNcPHFtLXIzU=;7:523f2042B0LVzaDqujB0cB4kiqsv9sy6hH86jCENqfFIei38HCr0lNI9j2s6kS/t2GzKfixx8L0dbeYpX0OH6P4rIaY44CKjqQB1klNI25/hmvw3ZHWUormM7OAYVn/+C1IbnJYz7qOyxDOR9ecuxprW4QqD2hhRLWzK7NWR3vusNxA6o4Dpz6ivkqTYqN9nxxt7CIiLfpIHb8iZLzgmv/ulodQNAlx5OP0JaWXSG2WhxSpm5Rp2QJ3E04QUZGEo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 17:00:08.2849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8ab03b-157a-48eb-3c85-08d57adee6e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB1316
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
 arch/arm/include/asm/module.h |  1 +
 arch/arm/kernel/ftrace.c      | 70 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/module-plts.c | 53 ++++++++++++++++++++++++--------
 3 files changed, 101 insertions(+), 23 deletions(-)

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
index be20adc..0a0da25 100644
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
 
@@ -167,10 +180,27 @@ int ftrace_make_call(struct module *mod, struct dyn_ftrace *rec,
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
+		/*
+		 * mod is only supplied during module loading, later we have to
+		 * search for it
+		 */
+		if (!mod)
+			mod = __module_address(ip);
+
+		if (mod) {
+			aaddr = get_module_plt(mod, ip, aaddr);
+			new = ftrace_call_replace(ip, aaddr);
+		}
+	}
+#endif
 
 	return ftrace_modify_code(rec->ip, old, new, true);
 }
@@ -200,20 +230,40 @@ int ftrace_make_nop(struct module *mod,
 	unsigned long new;
 	int ret;
 
-	old = ftrace_call_replace(ip, adjust_address(rec, addr));
-	new = ftrace_nop_replace(rec);
-	ret = ftrace_modify_code(ip, old, new, true);
-
-#ifdef CONFIG_OLD_MCOUNT
-	if (ret == -EINVAL && addr == MCOUNT_ADDR) {
-		rec->arch.old_mcount = true;
+	for (;;) {
+		unsigned long aaddr = adjust_address(rec, addr);
+
+		old = ftrace_call_replace(ip, aaddr);
+
+#ifdef CONFIG_ARM_MODULE_PLTS
+		if (!old) {
+			/*
+			 * mod is only supplied during module loading, later we
+			 * have to search for it
+			 */
+			if (!mod)
+				mod = __module_address(ip);
+
+			if (mod) {
+				aaddr = get_module_plt(mod, ip, aaddr);
+				old = ftrace_call_replace(ip, aaddr);
+			}
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
