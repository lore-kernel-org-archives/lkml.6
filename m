Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120069-2-13999193611455399013
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
    t=1520120068; b=bRKCPPtRa9nfyrPE0zRSw0zj2FitPh+lelpJ36ibtbR+5OZ
    6copaczQvP1iThZYteTY18K4lZTPBo65qeH6sDmPE+ELVIFO74dwTYUwqfrygpU1
    sE6Ls+WB41lJDK12hLBuf4jadUqwOqAsAIBuHhGqKQwWqK0PfjJDA6HfKQOo56EI
    hTzxwAzHENq3Y6xi4fe66PbEITls3QVfTJglWGcOrwIwsY8QVvRBnMKcT34o0Ytm
    G/EkA5MTupqCfyp6Pd7eSHabhK8Guv3YA0v2wEF4EEOEWNsKO1AOxLQHvNaVwfO3
    GFPt6TS5SNOh7Z4qxanESe+jgl+I2OrAjAfOBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120068; bh=d/9cMH
    W/VcPwhZQs5QUVoUZhgE4MNAxMvu6qX7VVayg=; b=ayTPva/7l0UXwv8xvnxI8c
    7R/SnR6ZGSFwlbX/BIoGS7/Z1ukNB8uQmGuALuFx/MwYrYmBw0v9P60O10lvpy82
    R1KCMpM0iDnEdn3U2NlZ9kssyHNjKCHFskSCdn8aqP2u9d1RkfvmkNys1xnVs+1n
    91ly3qb/uhqxE4mfaqiGrxL5YFa0ANHUoxXyMbdA3DSl3ehSuwEcqH+CQ/zi/Qgm
    iAf0xXUoRQHG5P7F/qMgvAzmBo8/kNKUu+Zdmj4cmSeWTjOU0RI44BGWF0nCb3xj
    5Hkf+DC0V/NSYxgHbhHkQyzYbnyUmfGSiOkyb9DuTJ+U4oTXYDkNjCo7Y5vNVEiw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZvlZmHpY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZvlZmHpY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeCCXeY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:34:24 -0500
Received: from mail-bn3nam01on0133.outbound.protection.outlook.com ([104.47.33.133]:8222
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934465AbeCCWf5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:57 -0500
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
Subject: [PATCH AUTOSEL for 4.9 160/219] kprobes/x86: Set kprobes pages
 read-only
Thread-Topic: [PATCH AUTOSEL for 4.9 160/219] kprobes/x86: Set kprobes pages
 read-only
Thread-Index: AQHTsz8Y4AfQhNVsskWEgnG+DnslUA==
Date: Sat, 3 Mar 2018 22:29:30 +0000
Message-ID: <20180303222716.26640-160-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:hltcQjjkCgg8eTAkb2YCskf6U6740gyIA+qLRQbqON7TrhNEWuPV90bHyiBiMx+tlKdcsEbzBm5MFKZu/bqoaNy0fK9++6TnSUZ/2bzKuDPVlssIoQEgPu8U0KiVzei26NXenMIS0kJlAHN7geSxcwiXqusXasDEs16ljJJy0iWq8zWL5eArkgYKIkPwJ3Ji//PpnH6pfBlrE29TQ58ehkTFrFnfe3FxWJn8W8L7FGOW8E3HMXvWL7//zr06CMu/
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6bc87a8-d819-4b47-7dc3-08d581571a9a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1034F0251B546E463E87E628FBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(966005)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(7416002)(68736007)(575784001)(106356001)(39060400002)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(6306002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Osj3ytqcOyqwrKSd5kmDxfCgf44YhHiPX9MxywqOZcixfRrq8J+gNYpwAKIVcpOiMifv9ZXlUMPsO7u1vFXD3ezKV4TiboEIZbfW8C9MTtXwyBsfFEG6ed63SLOB0l/HZfYXTnqwDg76Wzl5+vMEm5Tfc4OubK0V0OaMAox4z1g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bc87a8-d819-4b47-7dc3-08d581571a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:30.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
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
