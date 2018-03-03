Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119387-2-7700378975455979241
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
    t=1520119386; b=QGdRD9qDS35+MzcxBEgb9dTaSjiJiAGdOkN7P08BIgj7q4M
    gExVOmwdHhwFmM6OvG7lyf1zWkghO/SwL1RRP+OUWhGZMLVPAc0I6iMCBz32cD4d
    gw3F82rQA+e0nIhBwPih5sI3gSsHwAPsVdZlvcjwRgm8dbGdfl5D6N7UcCBomV7N
    Tos7a/+wJsBjE42i3T0aLzC9lLVEwF8+Nln4oUDI8x+Fast2NO6eRWVF4RLcKpqR
    XxEAOl/8U0Mn1/YHr/N4NRNLck68ftFUYThrho3cmhEXLpb9GkSHDJcHem8GkxIX
    Qr3+N3TFldck+gPrlnclJuB3O4XEjs2zTt1inYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119386; bh=4OekRN
    5BIXJ/ljiJXWcmgnsCmQuRMOCo33Ym+GcEtKk=; b=JhNvUlMWdpZvFtwPUPkVLa
    4OjwtPSxla/o/IOOWKNEPdKrOyy7KdWS5DOOSbpyXmXMMqbVNw6qNaF1yp/1/G2G
    f3mU2pi4WhwPosXfm3Nu1l2ZFA/NU985jNnEwIvEzrkwpoVgrGwQDtGjm1wn33je
    bgf3zdfWTorVTdppTxnIYxxhO7v8Jsg0vTMNy0IxhK3bPxaruZOGRYgZWwJSmmy3
    deiIQpxVxQsT0cSZqP+79O4ucstiiDCzjGDfCI+ZW7tK+BUjkwy81W3rOW/S5nha
    7UdCSm4QwVv+i82xrBTEWko8uSEqd0VuWCgDBdMNgoXzdpSLdIE8bTLvnYfBxZPg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZIAEroBm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZIAEroBm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934728AbeCCWhw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:37:52 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932373AbeCCWht (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Josh Poimboeuf <jpoimboe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 211/219] powerpc/modules: Don't try to restore
 r2 after a sibling call
Thread-Topic: [PATCH AUTOSEL for 4.9 211/219] powerpc/modules: Don't try to
 restore r2 after a sibling call
Thread-Index: AQHTsz8piJWHAC6hfE6hnS3sQ8saBQ==
Date: Sat, 3 Mar 2018 22:29:59 +0000
Message-ID: <20180303222716.26640-211-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:NeXIYf5n/sXKSJzH7/vXjRDb8RO5oiQ4UMeuQNMN4900oPa5oEHARtV/iqjTA02MG6chmMbkj4EsQ9eRHX3oHn3rmgs4uXEUg4y52FUmqkbZJmipgwXxPHGJIcObdL1/kbPTUJThV3Nt+zsVE6drHqWeEvbOE2AdCtIIwqfChKBfT3IGxRLUDj8RODovEb59UVQPsmudw4Be4VFX1dMwU0vujZBf7vXUD1mZa70weQP7Vf1BoRySaNC257c4FD9G
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 327beb83-cab9-4e41-a21e-08d581576327
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11000F3B5AA9C39924F4B98CFBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(59450400001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: DwvRIqd/vt/YflSI15qC/dN5sbwuCyvKLy5UZ7DePaAaa2QOxkoW9PFc1jGDGRy4HCUy0SxwvlxmZYtUpUPsNd/Dpn6Vt5r4pD84rtz3Kx2DHrWaX9Ir6cX+lDxva93W3q0w2ON+IgbR11BCmh0dbwH90TMlCPCSMUeuFYIsab4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327beb83-cab9-4e41-a21e-08d581576327
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:59.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit b9eab08d012fa093947b230f9a87257c27fb829b ]

When attempting to load a livepatch module, I got the following error:

  module_64: patch_module: Expect noop after relocate, got 3c820000

The error was triggered by the following code in
unregister_netdevice_queue():

  14c:   00 00 00 48     b       14c <unregister_netdevice_queue+0x14c>
                         14c: R_PPC64_REL24      net_set_todo
  150:   00 00 82 3c     addis   r4,r2,0

GCC didn't insert a nop after the branch to net_set_todo() because it's
a sibling call, so it never returns.  The nop isn't needed after the
branch in that case.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-and-tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/include/asm/code-patching.h |  1 +
 arch/powerpc/kernel/module_64.c          | 12 +++++++++++-
 arch/powerpc/lib/code-patching.c         |  5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/includ=
e/asm/code-patching.h
index 2015b072422c..b4ab1f497335 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -30,6 +30,7 @@ int patch_branch(unsigned int *addr, unsigned long target=
, int flags);
 int patch_instruction(unsigned int *addr, unsigned int instr);
=20
 int instr_is_relative_branch(unsigned int instr);
+int instr_is_relative_link_branch(unsigned int instr);
 int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr)=
;
 unsigned long branch_target(const unsigned int *instr);
 unsigned int translate_branch(const unsigned int *dest,
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_6=
4.c
index 183368e008cf..99407cf12ad5 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -494,7 +494,17 @@ static bool is_early_mcount_callsite(u32 *instruction)
    restore r2. */
 static int restore_r2(u32 *instruction, struct module *me)
 {
-	if (is_early_mcount_callsite(instruction - 1))
+	u32 *prev_insn =3D instruction - 1;
+
+	if (is_early_mcount_callsite(prev_insn))
+		return 1;
+
+	/*
+	 * Make sure the branch isn't a sibling call.  Sibling calls aren't
+	 * "link" branches and they don't return, so they don't need the r2
+	 * restore afterwards.
+	 */
+	if (!instr_is_relative_link_branch(*prev_insn))
 		return 1;
=20
 	if (*instruction !=3D PPC_INST_NOP) {
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patch=
ing.c
index d5edbeb8eb82..753d591f1b52 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -95,6 +95,11 @@ int instr_is_relative_branch(unsigned int instr)
 	return instr_is_branch_iform(instr) || instr_is_branch_bform(instr);
 }
=20
+int instr_is_relative_link_branch(unsigned int instr)
+{
+	return instr_is_relative_branch(instr) && (instr & BRANCH_SET_LINK);
+}
+
 static unsigned long branch_iform_target(const unsigned int *instr)
 {
 	signed long imm;
--=20
2.14.1
