Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246589-2-7095145267459838260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246589; b=Smlo/4UaHK2/xt/rlXlbsg9YcaqHSmYqAwptvs3slrLOQoWDjQ
    877sLwnWeLt9j2GcNdqxYiAhfvWEq02mDSa7IIFk2pXj2f+EJAymuvMxK7TGN6Yn
    csPcWEdM7yrCfHhnrmz2AAA/REJURrN6PneglztxbnIka7L+pQJqbfoTSspTRpZP
    bx0POVBlCyek6ppIciMnOflmGwDHfEqptHS1Y80EKXcKAAvd4uBvGWKbPjM6Zq4d
    YhiEYiI17EupRE7FoQ1Taj9OgOym3q/dkkd8jDH/p6wv0DaFlMPfHXflnnW1cTo6
    OO2sPdf2kxo75tlDIAi1y7vKUm1Bxb1zj15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246589; bh=JG699RIEHy
    mZmiXgKyZv1nvJrj7OPjOyuVlNb/h+jyM=; b=SzR4r1KGHcPaie0Pn2cgJh0Bpk
    zSpeFh7N4T9veL4wVvpggOWAANLL5JKeXmQoURb74lQy57N73bXLTWbtXtJRxSVQ
    x+Xkb118aYADaa7MsJAUwTyk1TmYvFallg6A/bAL++J6HXEB38snYuVXBfp6GMLm
    ykHZpecvRBArKpxN8z5z1K2KW26AAfdzJ0MCY1SYoivo2viTLJHeMSJAoQJdFzgl
    U25A8DpNliFqN3+kKBxCl3++L51jOoQ9/8R37/bROitjnIC1YfsgvsIjApPEkzQk
    Aq2aMVJJmBFmTmoPkEDAjv5UgJNCJe+aW0UbIjvgeZrIDwg7ThjUCXR1RCpw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jMmE3QD9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jMmE3QD9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ7gy0j5m123ef+fjvE3KVETPhwwx5oWpQJMqpe4acPfv0CNErXdKCseW5k9r/RHRkip4vLaDbPfJFrEtBU+Io41AyfTYrgbI+r4ZgZZQlmhM+lcqFtJ
    GtlPlmX2w8hwDeTZxR44KM/eKFfzHu7rqZvrN6iXQBYCjAcJeKfBIavuLhZjRNnzil5NMioYhB8DcPcJ61dvw3rNfn2BIBjX1HBhj5fj/OcUEqWIDn5qgydP
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=Uj80lEVC9qcfNJ7BfsQA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeDIECx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:02:53 -0400
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:43410
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753289AbeDIASA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 058/189] powerpc/pseries, ps3: panic flush
 kernel messages before halting system
Thread-Topic: [PATCH AUTOSEL for 4.15 058/189] powerpc/pseries, ps3: panic
 flush kernel messages before halting system
Thread-Index: AQHTz5gmQpCD1SmsmUy5EvR2hd2yFg==
Date: Mon, 9 Apr 2018 00:17:31 +0000
Message-ID: <20180409001637.162453-58-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:W8X/OEmf3zxdcD+eAVzqXFQRznxUjYThfI958yseXy36ie3kskNvp3sRAyWKiRifN+8+huTeesx7sGgzWhI/6szdydcqyLKZCWeBs5679pvZiBbkEZWCE8Spj5Upqm1s6MkYzqGYRDyuGvCXcxR7oz4pMRBiyFqq13sR4TBxzmh3/GkPFMRffARZ2tsBFrEuhnY8gwB+DZ4LwKa3QsLqBYZ+um/Pwyn4aDvSBzZdLBw0pXCg3L9DatSihsMGkYiU;20:rCaazw10wmMFPzGFkrCF7NBoBdcDY10Wsu8voKLyRX+NcKPtEG1lvIb6M3i++fk8iKIajScZCdc+OZMHufFZikk5M4EzeV5xavwdkoU3QxKlk1DMOhNolg/oaok1YSp/BBGAgE0Oml7cOyo38RGLa49BnR7lKwslJoPBGMTTOVU=
X-MS-Office365-Filtering-Correlation-Id: fd64fab9-7a88-497f-49d3-08d59daf57e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046240BAF023D7313D6C054FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(15650500001)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(39060400002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4OJGKjCs0erjVT95bRpHjdcmhjHzrO2rl0DHWKT9LDg/J26yCuNa2SKijRMaYjbR3m2JoJL9p6JOHdW755C06YtYyrLni68QXZJ8REB6VDoPqlQptzmJvRtJECLWutNgrEHqXdTTixI3vY6BTZxr95YuFTnyAkQ5NdwOxPJOWk6QhZgTRda6q9Auh0UZuFslNbcdNppUXQX0c120RRkTiyRsR6grVrXojZfMAjrn7w8nvfegd5xUGTQHzj2GjqBxV8oDM9XnfgcdlbHeJhNKpe4yhK8lr45RfnsNX6grIelnpE/AOiel+0dU05CHYsrXjbiFDcTmQnL4zxY7X3kCqpGYorLvW42+e8Hz5q9pTd7KJWzUK3nnKU65ktTQfBMsI0vqj/RK0v1+NSz7fnI/YZL0rexSw3P+lpfJJSpQr9g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd64fab9-7a88-497f-49d3-08d59daf57e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:31.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 35adacd6fc48d658419522f192a3c8b2785612da ]

Platforms with a panic handler that halts the system can have problems
getting kernel messages out, because the panic notifiers are called
before kernel/panic.c does its flushing of printk buffers an console
etc.

This was attempted to be solved with commit a3b2cb30f252 ("powerpc: Do
not call ppc_md.panic in fadump panic notifier"), but that wasn't the
right approach and caused other problems, and was reverted by commit
ab9dbf771ff9.

Instead, the powernv shutdown paths have already had a similar
problem, fixed by taking the message flushing sequence from
kernel/panic.c. That's a little bit ugly, but while we have the code
duplicated, it will work for this case as well. So have ppc panic
handlers do the same flushing before they terminate.

Without this patch, a qemu pseries_le_defconfig guest stops silently
when issued the nmi command when xmon is off and no crash dumpers
enabled. Afterwards, an oops is printed by each CPU as expected.

Fixes: ab9dbf771ff9 ("Revert "powerpc: Do not call ppc_md.panic in fadump p=
anic notifier"")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/include/asm/bug.h         |  3 ++-
 arch/powerpc/kernel/traps.c            | 24 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c  | 18 ++++--------------
 arch/powerpc/platforms/ps3/setup.c     |  1 +
 arch/powerpc/platforms/pseries/setup.c |  8 +++++++-
 5 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.=
h
index 3c04249bcf39..bca101ee1f32 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -135,7 +135,8 @@ extern void bad_page_fault(struct pt_regs *, unsigned l=
ong, int);
 extern void _exception(int, struct pt_regs *, int, unsigned long);
 extern void die(const char *, struct pt_regs *, long);
 extern bool die_will_crash(void);
-
+extern void panic_flush_kmsg_start(void);
+extern void panic_flush_kmsg_end(void);
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 109989676776..37c1ea9b0642 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -38,6 +38,8 @@
 #include <linux/ratelimit.h>
 #include <linux/context_tracking.h>
 #include <linux/smp.h>
+#include <linux/console.h>
+#include <linux/kmsg_dump.h>
=20
 #include <asm/emulated_ops.h>
 #include <asm/pgtable.h>
@@ -142,6 +144,28 @@ static int die_owner =3D -1;
 static unsigned int die_nest_count;
 static int die_counter;
=20
+extern void panic_flush_kmsg_start(void)
+{
+	/*
+	 * These are mostly taken from kernel/panic.c, but tries to do
+	 * relatively minimal work. Don't use delay functions (TB may
+	 * be broken), don't crash dump (need to set a firmware log),
+	 * don't run notifiers. We do want to get some information to
+	 * Linux console.
+	 */
+	console_verbose();
+	bust_spinlocks(1);
+}
+
+extern void panic_flush_kmsg_end(void)
+{
+	printk_safe_flush_on_panic();
+	kmsg_dump(KMSG_DUMP_PANIC);
+	bust_spinlocks(0);
+	debug_locks_off();
+	console_flush_on_panic();
+}
+
 static unsigned long oops_begin(struct pt_regs *regs)
 {
 	int cpu;
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms=
/powernv/opal.c
index 041ddbd1fc57..c23a9cca6268 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -461,24 +461,14 @@ static int opal_recover_mce(struct pt_regs *regs,
=20
 void pnv_platform_error_reboot(struct pt_regs *regs, const char *msg)
 {
-	/*
-	 * This is mostly taken from kernel/panic.c, but tries to do
-	 * relatively minimal work. Don't use delay functions (TB may
-	 * be broken), don't crash dump (need to set a firmware log),
-	 * don't run notifiers. We do want to get some information to
-	 * Linux console.
-	 */
-	console_verbose();
-	bust_spinlocks(1);
+	panic_flush_kmsg_start();
+
 	pr_emerg("Hardware platform error: %s\n", msg);
 	if (regs)
 		show_regs(regs);
 	smp_send_stop();
-	printk_safe_flush_on_panic();
-	kmsg_dump(KMSG_DUMP_PANIC);
-	bust_spinlocks(0);
-	debug_locks_off();
-	console_flush_on_panic();
+
+	panic_flush_kmsg_end();
=20
 	/*
 	 * Don't bother to shut things down because this will
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps=
3/setup.c
index 6244bc849469..77a37520068d 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -113,6 +113,7 @@ static void ps3_panic(char *str)
 	printk("   System does not reboot automatically.\n");
 	printk("   Please press POWER button.\n");
 	printk("\n");
+	panic_flush_kmsg_end();
=20
 	while(1)
 		lv1_pause(1);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platform=
s/pseries/setup.c
index ae4f596273b5..69d11ecd45e1 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -533,6 +533,12 @@ static void __init pSeries_setup_arch(void)
 	ppc_md.pcibios_root_bridge_prepare =3D pseries_root_bridge_prepare;
 }
=20
+static void pseries_panic(char *str)
+{
+	panic_flush_kmsg_end();
+	rtas_os_term(str);
+}
+
 static int __init pSeries_init_panel(void)
 {
 	/* Manually leave the kernel version on the panel. */
@@ -761,7 +767,7 @@ define_machine(pseries) {
 	.pcibios_fixup		=3D pSeries_final_fixup,
 	.restart		=3D rtas_restart,
 	.halt			=3D rtas_halt,
-	.panic			=3D rtas_os_term,
+	.panic			=3D pseries_panic,
 	.get_boot_time		=3D rtas_get_boot_time,
 	.get_rtc_time		=3D rtas_get_rtc_time,
 	.set_rtc_time		=3D rtas_set_rtc_time,
--=20
2.15.1
