Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486347-2-2634045258273141678
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
    t=1520486346; b=WfC0KeDY7PLJKXDNLoXg9ZVSyAJrEFpUmz7XxReNm3sgmds
    TcswbzxL7kpPB0tORtwqYlTb9us456EVWCcVq/blGiLqXRH+Mnx2NEsFI72bQjRh
    kA6T5Je+8NJFGZuXY6xEfBo0M2V8CK17g2o5zKHvAE+7FHKxvO6ngmEDdTydRl2t
    7ekSNOLzVxwcAMVPdedW15MyPvT7OVVVoam4E+59gKUywUVU3USo900e6e5nEEG7
    IR3ZpG9U014FfLCdJIOzZJ6JyNkFTCshU72ScFym5zmCJ55yexm44x84hKYmLQty
    63+VgCHaNKIz7IW0u9cogALC28a3LuLeCRAJ86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486346; bh=POf7Gb
    cgSw9UMwu8ywmFBH2Uh3exvydPSLqSlkOHFDo=; b=tMbsWOZusujLvQ3jC7lCJ3
    fpwIpKXFmc9RkHlJy428GQzgt+UUtMOl4NzArea6ot6X7TpiD4aR/ZJv4Y9TdJj4
    ciux0GpFG54KQHiVo6AACIwuOBPN6+YyuNihSKdLB3PK7Jk/SPI5LJXw2fk9LcHy
    ztaCq0pUlaB5VU3ty8w1PtX/7VWmsndEgpVvazDmvBO+u4TtK8dVcEOyXGE4R8f2
    OK5J0Ff1rDertVSCoU8t478ZDByzdl66QmyDqIOYQ2e4rRwoWemHyLshewC0rT3y
    oq8yRA8pLD1foT3Kjx+Kv2XbMfr3fp0AVMQlYsbU80NSih+76okQSu/IqY+fZBsQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hw+0M/I6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hw+0M/I6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966771AbeCHFSi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:18:38 -0500
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:43456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966722AbeCHFIM (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:12 -0500
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
Subject: [PATCH AUTOSEL for 3.18 06/53] kprobes/x86: Set kprobes pages
 read-only
Thread-Topic: [PATCH AUTOSEL for 3.18 06/53] kprobes/x86: Set kprobes pages
 read-only
Thread-Index: AQHTtpq/T6UWRmV9OEqfsJO0YX5kwg==
Date: Thu, 8 Mar 2018 05:03:08 +0000
Message-ID: <20180308050230.8876-6-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:TgEJKF31uwwxz+Rm4mbWSqdliOl6wobDT4eCmbI+IQ+1p7+PmwnCanZ6I9iTvEJ/ZeZWqk7XWIxft1YbmbkUU9bH2caF2eWs7lV1kP/MXTk4H+goQxY/NTN2yuaURvolBWyy/AGhmlcIfd+1+Z+A3jHY4eCfeLPL9GHk4r6UuD529XhBFUPSjsFxWCHEwuvc0hawsWUjngChcCILd1Z9diz+4Rc9eWeMBK9ZiouZO3fOA6xVsiYOFJh/XV9aF4jq;20:C2fiSReP5POZ31ldWgeD1LcMj/OwbKDaj5tER548m3h/x7zxgsOa4Hl8c/TWsZaSBYzn6CTUOuPupuIL1tsWgVjjUIjlI67+DBnGeyPGlkX3mMFbB/KvyZzljfv2UTL2Q8E86BAHh9XFx56a+NB4LULjte1p7ZpM9vDPIYmsD8I=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 707f3926-765f-4d81-7f88-08d584b291f2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07275B157E7111024F02318EFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(7416002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(6306002)(5250100002)(53936002)(107886003)(6436002)(966005)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PWGIxb5PpfAgGDGPYxrg9MASaE2FAdOBDtkbj/VCpEAdJILsLqOFYcmP52PBXcIph+R3NQvgGebBiU8MF4gopAz6pH2Qp+iutJXNWExLg1H3YHJl7ER6DdL7puq8FoCXMVAFpXc+x7Uk6/5tMUuKJIoszcvusYFi1R/oHeH0Jl9p0WomsfrxJ4A1L/eLhLVafuFNr7lbyvKSPy355bTXMBbiF0tcage99sj3sUdN3mTyKNQ9fWeKUxxUo7JTA/dHkjKRBav0R0j+RiiHKbZTSl3XPf05v3fhf/6tfqKgtBNRnKMx7uAaFeC+OL6Q0jVX8vwm+d63PZPnl9K6rqAqKw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707f3926-765f-4d81-7f88-08d584b291f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:08.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
