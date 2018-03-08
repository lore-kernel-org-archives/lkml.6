Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490834-2-6533687367150377256
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490833; b=fHIEBMsfmR4NHUW0E9S0ziaPGVJehL5K0SnJBvrbHM8g+Ph
    K65lQNGfD2/KyFI7l/tTRflY0H9i+Urq7JmygwXKtiVM1CtMiL8aq8q9G0gtmWx5
    p/n2BK0mgWXQf2zJPQMOkUaIbMNTohyOylwEXxRJqWTY9ae/anC/jBczd5IWt2Kr
    AuCEEcKVVgF0gMNJNYvoiyPoQuTyWLAqn+ZiEiQF3pomBO6VkG1kliENJagIzswA
    8CIpsASxLErWR3ltU4TVZGa6lvJerQGLpptz+OipqrkRy5gW/8qb6TjyQA+EhyCq
    H4WImyk7SRQPqb5vhZOZdIASl7JL2yNfc+jkbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490833; bh=d/9cMH
    W/VcPwhZQs5QUVoUZhgE4MNAxMvu6qX7VVayg=; b=HEIr7dbFRDy1PQuviJKxe7
    AecHQWU2a9Wyh1OoARG6YzbCPIVXEg/pikWT7EQWMzLKZLY/IWWDIO/dBV3Yt0yr
    qITx7Q8xX/EmGuxevs4rFLRcqILC+JODfQ+4+HMiYd4M2OesgkOUYZKrgI3Tz0Z4
    3Ow9V8shkBeAD91RqRmNmtQv0KAtJOTKQ1Sj0DvEstbkux+e0EgfiTz5GrpjzKll
    V/dHG7QVGmQQMdsp/JexJ+nBeiwYLJWPWOg3EGIgEFl6ZxHUiPQy5oZYjMzFtypO
    9nexs15jCW8fCHDuurEWmWySKefuYqBKrnHaSI6gRg6sTNHuoE1b8+HRAnWXkVcA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O/Mi2l6S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O/Mi2l6S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCHGdw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:33:52 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:44208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965531AbeCHE77 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 014/190] kprobes/x86: Set kprobes pages
 read-only
Thread-Topic: [PATCH AUTOSEL for 4.9 014/190] kprobes/x86: Set kprobes pages
 read-only
Thread-Index: AQHTtpopybCxGc/UX0uN49Yj0Nr2SA==
Date: Thu, 8 Mar 2018 04:58:56 +0000
Message-ID: <20180308045810.8041-14-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:enwYiru/0nlRvE9cZ1FlgAshvpcyuGO9RKmBVK+QVk3wv1assm9buu5p5tMn/YYyUfaT/qCJN5UsvU8yIaPacCks5480nu9/Y+VhFo9GbSjBifJx8vrPeJYgal351vE7BDDfdFT6im+wvS4Hyo88qRNntRJ3f2E0U4qsSvh8FZV2bgPBuME8blVtkhoAOgylyd9Etz71X5yetlL9voz9w3DE7s7iHFjC0MWPTdPuF80aZgBETUTXXe6YH77LPyIJ;20:ssfuistnUJceQhgFV2o5hd/hKHNgTnzwlGGYFfOIn9wfmIx9+eKIYSdmKUrgb6F+DD/YTOLilQSu4pkJINGxZJeB8LrGEs6jj1eU0O6M5v8/jx/mseLDuZiDaHic2R4ZV6j5qL8rFjoVOoR6zPDWGJQarO5z7C3Oc3SO1qHtOPw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44728613-b389-4e6a-442c-08d584b17077
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098309F6D05C477854A935C7FBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(6306002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(39060400002)(106356001)(86362001)(575784001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(7416002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(966005)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: OmiPiqUkTrXmRk6SsDjEfsV/qmVMrR8xFzGVjsynVxp5gZRSW3zLHW88BVzv+RvHjgIzO5zkaDdzjzzDKP8VcIoPewEDggsnWlAqZftBcrXgMrLIiVKkP4BwLpUISOSQvfjDfWiTkBfneyP5kWqrooqTR3pnasMgkzdLPgYfHPpOCgyaLGWmIab07WUpLh462L4YfIqOgiqtM5uzHZ9LyrYlQ3UdGS/AvBWyrILQdt4vyr1edtZIls5tgYC8U+EJY4VC0oQOquUclMWTHuEjcnijGlXUiBp+xszXwCh7opDzRIRIJbTA4TpkY9Yml54U8LTWGVWMQkhpp8osQDiQvg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44728613-b389-4e6a-442c-08d584b17077
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:56.2112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit d0381c81c2f782fa2131178d11e0cfb23d50d631 ]

Set the pages which is used for kprobes' singlestep buffer
and optprobe's trampoline instruction buffer to readonly.
This can prevent unexpected (or unintended) instruction
modification.

This also passes rodata_test as below.

Without this patch, rodata_test shows a warning:

  WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:235 note_page+0x7=
a9/0xa20
  x86/mm: Found insecure W+X mapping at address ffffffffa0000000/0xffffffff=
a0000000

With this fix, no W+X pages are found:

  x86/mm: Checked W+X mappings: passed, no W+X pages found.
  rodata_test: all tests were successful

Reported-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ye Xiaolong <xiaolong.ye@intel.com>
Link: http://lkml.kernel.org/r/149076375592.22469.14174394514338612247.stgi=
t@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/kprobes/core.c | 4 ++++
 arch/x86/kernel/kprobes/opt.c  | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.=
c
index 808ee7f566f8..b8d3f1b60331 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -409,6 +409,8 @@ static int arch_copy_kprobe(struct kprobe *p)
 {
 	int ret;
=20
+	set_memory_rw((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
+
 	/* Copy an instruction with recovering if other optprobe modifies it.*/
 	ret =3D __copy_instruction(p->ainsn.insn, p->addr);
 	if (!ret)
@@ -423,6 +425,8 @@ static int arch_copy_kprobe(struct kprobe *p)
 	else
 		p->ainsn.boostable =3D -1;
=20
+	set_memory_ro((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
+
 	/* Check whether the instruction modifies Interrupt Flag or not */
 	p->ainsn.if_modifier =3D is_IF_modifier(p->ainsn.insn);
=20
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index dc20da1c78f0..fa671b90c374 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -371,6 +371,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kpro=
be *op,
 	}
=20
 	buf =3D (u8 *)op->optinsn.insn;
+	set_memory_rw((unsigned long)buf & PAGE_MASK, 1);
=20
 	/* Copy instructions into the out-of-line buffer */
 	ret =3D copy_optimized_instructions(buf + TMPL_END_IDX, op->kp.addr);
@@ -393,6 +394,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kpro=
be *op,
 	synthesize_reljump(buf + TMPL_END_IDX + op->optinsn.size,
 			   (u8 *)op->kp.addr + op->optinsn.size);
=20
+	set_memory_ro((unsigned long)buf & PAGE_MASK, 1);
+
 	flush_icache_range((unsigned long) buf,
 			   (unsigned long) buf + TMPL_END_IDX +
 			   op->optinsn.size + RELATIVEJUMP_SIZE);
--=20
2.14.1
