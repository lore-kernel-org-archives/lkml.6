Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487895-2-10992330989827273218
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
    t=1520487894; b=pNhop70FQ3tdobnNSNEFWvbzfKN5sC7uK1SmugysAK1rouv
    ksoEI2Tt+qcZRND3oQk2JSgn+vtY3fJ7pooYiLsiJKCITLUJElkGS7H9o9PpcVUh
    wDqBao3xSe9xJx3jHxzWLnFjnOzkPaWnTOJNsV0r7B2m7q6RgoUzILzbJZNnXavS
    n1bc/NobF/d4G9yfJEkFwLcvrRqUgH5DGRFlM5nXUW2sWNTlbbIN5+I15MkuwGHq
    ewumL2ANMy3iC2mb15SZEU0L+JzQQPwGyvAiufzMv25sHcYotSR7NHtlX6G7Pk8y
    DvDP8eLiymrm0zSsFslaxrN0UbBHjBW9w1Lnhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487894; bh=UQNss4
    l7dxeWSOORXOsMJ1MT0/1QrmQtnCiJJuW7Opk=; b=bNhAVPbjevzON5yEYpPB++
    RXVnPyNhakIJD1tiCG3iVQZy2wVOLR6iCZ5ZHThZgjWFNcujFT6bnmQUgFwPAicr
    J81lfvelGfie2QE/QDJ8CNRn1ipabKmpgXjr5bSMMgwI1w13OhJOI/M9Tj6Y9/y7
    GfacbF6oSgwp7wXs3xcLWYRmqS/QtHMwXGiG8XiCfSkOnGV8GUgqdYlZciqAFPAo
    OO7L2VKPX+/RZuVcEb/o8QUwmphy2RSB3K3TU1FF2tCspBWVVJXLiLK4Ff7p6nWG
    hNltYWp1H57HMRdHQX149WrjPgyNAYvIrNCwzYx3g3J2uZ3O7yddbYVCgVZZbWiQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E+vEIIZX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E+vEIIZX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965631AbeCHFoi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:44:38 -0500
Received: from mail-cys01nam02on0130.outbound.protection.outlook.com ([104.47.37.130]:16451
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965970AbeCHFFP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:15 -0500
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
Subject: [PATCH AUTOSEL for 4.4 008/101] kprobes/x86: Set kprobes pages
 read-only
Thread-Topic: [PATCH AUTOSEL for 4.4 008/101] kprobes/x86: Set kprobes pages
 read-only
Thread-Index: AQHTtpp6qRX3H4Wrxka2OMHySqg0aw==
Date: Thu, 8 Mar 2018 05:01:11 +0000
Message-ID: <20180308050023.8548-8-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:W9O/rOKpvyr8iqtZ28pCtQv8YevL2V3H4+axteCGBlJJvj6AYP8W1oK+YHpwsixpMfvVKmuLj6FNGMAkjvb4E7u+fw9gT8oMXQXRE8vm8eNO0mZn1zc+b0eeNBj4N21Yoh5e6T0w9WiFlETc65NYKRssu7YdUvTvK0PURqRzm/7rDvtdiMCpiMvv3Vv1Ni+HBwv708G/dvhQkqDA/QpKEIfKWaboLdluXYtYORrcs0Bxm+s6rQVrSG/yQ5IIFh0P;20:fzvTnIG3rHgYEvVFPdJYcpvvpNKctyhsbB1QxfRdxvhod90Km2nlLKY1Ob0ZjPrGnOt+v4a632Icjl5Nc+9h3bM4GfTlQpMuHICxz1r+yqc6HmZh8WqmQYh8wsR4manCpbC8cyGf3KueDfK5MXcFYfwzgYVYjeanm6LeiQ6EXig=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4101c87e-112c-4190-cf30-08d584b228ca
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09813B078A728A3A66788917FBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(7416002)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(6666003)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(6306002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(575784001)(39060400002)(6116002)(81166006)(99286004)(72206003)(966005)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: W57IdgufAmKZtBAcrGu96c5si6G52+79k4aUNgxpUVCFEbl8+l0enBuKRCbCYsJYsfzPPXf3PG7E3mJC5gI4nuhIpLE6LiBiSRmWLnrGjj3pg4UJMiwQ3t89YGYMFJgnIpxnrx1X4GCy1WgLKh1A9NRmZInAplSTV5VoS9EqDp3ySjEhjlXYvvoZvh/UKG9h1p+jn/Hsdeb0DnmPXfYMIMU8ucbdYj+gaWRcHYtOIoFkgUqusdcCqLcWD3MBjukKw4zYut7EIbS2Ddj5F36Jsb3a3ukLuGTptw4vUNLFt9Qkgh+qqXEOlGF0vHw3qcJtBjJlGc9488zaMF9JSarGxg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4101c87e-112c-4190-cf30-08d584b228ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:11.8222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
index 5d11d01f75de..565e24e9ddf2 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -406,6 +406,8 @@ static int arch_copy_kprobe(struct kprobe *p)
 {
 	int ret;
=20
+	set_memory_rw((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
+
 	/* Copy an instruction with recovering if other optprobe modifies it.*/
 	ret =3D __copy_instruction(p->ainsn.insn, p->addr);
 	if (!ret)
@@ -420,6 +422,8 @@ static int arch_copy_kprobe(struct kprobe *p)
 	else
 		p->ainsn.boostable =3D -1;
=20
+	set_memory_ro((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
+
 	/* Check whether the instruction modifies Interrupt Flag or not */
 	p->ainsn.if_modifier =3D is_IF_modifier(p->ainsn.insn);
=20
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index ea8e2b846101..7aba9d6475a5 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -370,6 +370,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kpro=
be *op,
 	}
=20
 	buf =3D (u8 *)op->optinsn.insn;
+	set_memory_rw((unsigned long)buf & PAGE_MASK, 1);
=20
 	/* Copy instructions into the out-of-line buffer */
 	ret =3D copy_optimized_instructions(buf + TMPL_END_IDX, op->kp.addr);
@@ -392,6 +393,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kpro=
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
