Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117235-2-11860202883554931559
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117234; b=TMv3y+EplIP+efSuUXUMMdk0vXNLz/XS4V5XE75emUkal2w
    15uzyOuxxhUdwajgET7TWnmZ9ei00/KzjDPub6rsc0PBkl7SwEhmJRq8Ty9TVFns
    ak89mI2yXoillZtLut1obdOjZpf/xpN/edbdgqQuyFYsCmBpS5ZiYhdxwiXEzhaA
    cX4PITmzBqXf0HwvpD0jXxwSSpfrl84ZVto6RrRb22FiWxCqA3KlzWM3LlpIHoTK
    0lE3SBzaNxWNCfXHQKdQMKy9uytfngsNNjN6K+ER/h6YMqNv0En76N1mzEcF4Js3
    nhD/dPJEFaiqP973vuCqhYfodByHbCSmgjcOREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117234; bh=POf7Gb
    cgSw9UMwu8ywmFBH2Uh3exvydPSLqSlkOHFDo=; b=UkZQF3pET7iX+X4QUI1gj2
    jEZYWHs8mXL2VH6r1/31IfSnKCYEfG2PlRij05WwW4xYzlVpIrQBPkAuJUA7pSVE
    aek/mldIdL8Lo3enPt0gGz0AvtU7W3KNjsVBDyRxTyqADz6u12rsvkHR4uhnz1TL
    P8IWuVRz01stjlHQ1RjzUlkml02bCKPjgk+QiKO1gK6jKvd5nIXSgx3USLOad0xb
    elzOi4NQVvPhtcSxbgwwRLUZJInclq7GW02C/TXIQX53UHwSXIikLiiVCsnyGa/7
    vuIZScqo4JNiGqKhw+pe+yk5jxgIlMbNQJf7rRGzU+EXlAAaSkUtc8sy5LPWXO9A
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ixblyXW4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ixblyXW4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935281AbeCCWl5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:41:57 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:59904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934705AbeCCWlz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:55 -0500
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
Subject: [PATCH AUTOSEL for 3.18 45/63] kprobes/x86: Set kprobes pages
 read-only
Thread-Topic: [PATCH AUTOSEL for 3.18 45/63] kprobes/x86: Set kprobes pages
 read-only
Thread-Index: AQHTsz+seNqkWxUnJEeaFSy5kFzL0A==
Date: Sat, 3 Mar 2018 22:33:38 +0000
Message-ID: <20180303223228.27323-45-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:y9N+ztsjOFHRhx4mo7MWnvTpWDv+FUWQ/pZlpaU93PG/a6GypMzzuJqpFhHYenbHbAUdrK7ALyE44G9BZPlVVacTWLLhsqOj62DqSyP3lZCbvzV0Ep14jZVib0iJ1MsnLlpHjIrCo+R3De8lOxufC3W+urgJr48rq0BJ9img7zmW2IjDMVS4/vPzMh76KkEH5PXq/n6uiw1r7BkNaM1R1wEDWxtpfO2O3O4RjWhzmMX7wGk7s57kOWOYSyB/cUMs
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32d2c1e8-7f8c-40a2-aac6-08d58157f5a9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB10184F87BC970E7EEE49D9F0FBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(39060400002)(7416002)(81156014)(5660300001)(8676002)(6306002)(6512007)(2950100002)(59450400001)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(575784001)(86362001)(102836004)(966005)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: eXkCWIcrTC/7DW5DU8/MX8r8pOOrAuFn7aNA0jdmb6PL/Wyb8MNYz2Z7HZtKmbxa31aXLu8Yw3CCECYs3xu4IGFBHaEoJvcVk06IohZERLbjuBRYedooOpVVrNi5wYqboYBbC7RKCYk26ScEPnW6J6E5u2zm/xchjyHyXgvLxrc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d2c1e8-7f8c-40a2-aac6-08d58157f5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:38.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
index 422b76ab0374..78f221ab8593 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -378,6 +378,8 @@ static int arch_copy_kprobe(struct kprobe *p)
 {
 	int ret;
=20
+	set_memory_rw((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
+
 	/* Copy an instruction with recovering if other optprobe modifies it.*/
 	ret =3D __copy_instruction(p->ainsn.insn, p->addr);
 	if (!ret)
@@ -392,6 +394,8 @@ static int arch_copy_kprobe(struct kprobe *p)
 	else
 		p->ainsn.boostable =3D -1;
=20
+	set_memory_ro((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
+
 	/* Check whether the instruction modifies Interrupt Flag or not */
 	p->ainsn.if_modifier =3D is_IF_modifier(p->ainsn.insn);
=20
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index cdb672c3049b..aec5dfa8b7e1 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -344,6 +344,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kpro=
be *op)
 	}
=20
 	buf =3D (u8 *)op->optinsn.insn;
+	set_memory_rw((unsigned long)buf & PAGE_MASK, 1);
=20
 	/* Copy instructions into the out-of-line buffer */
 	ret =3D copy_optimized_instructions(buf + TMPL_END_IDX, op->kp.addr);
@@ -366,6 +367,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kpro=
be *op)
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
