Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123588-2-13551050249172337836
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
    t=1520123588; b=eFnEc6vK5+Yt/A8f6USLi0WB4AUHj4t0NuRhvq0mnstECOy
    kO7n2vsx/nLNU9uJiSVEpw8Oi5NZFrwylAN2sDC01HjBML5sKnwYn7TwdyeWhiQv
    5EHlwMiKVUKskcUSu4BFRShhyN52tmNQJiiFOQN2/KPlH99j90rKNwH4e4fE5UkS
    iC1wHCYjWEP9fTMZ2i3L8sfN2K8ggq2xX2cJD2vcGir812YsFfwKdSJlf8vMeOV0
    jF258Whv2Iaw1qXQ1H8S7opRUpFoRAMe9X9NCRMeXnbVNnnlpAU4UekJFXWIOUFb
    3bjAg0ynwyPuU4dMniOlPXsCidyubPL/ux/pbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123588; bh=qAm/uG
    QwnbgsNYjTmfzv1C+q6vkL2vTuHhZOlAvK0RM=; b=Jq/ZEiJv7mImDP7PJ/5szC
    1ZXqPF4qeAz4ZMXcWGpL3AXIUnBEenq1OH6+q9L/zRjIRp0LCNRvnaBPGs/iKCuE
    NISULU4x/W8axz1OD1m0P8Kb2VbnMIG/j5SSetlSHUA6J0UXx8ZxhH7eppSKOQsQ
    sSiVVjjMYhdajJbVSZxywyX3DkZZggbCRF7yu9COyX2Ivps/X0643hhYVco8BP6Y
    r4xmgyoM2AiUsCCcU3FDpEDG1224f3Ut9BW8KkkA4Inuo22r5OH/uEJiczQoVuMd
    rW+nUfynlx96gKhdD0QT4/pbFpU7Bk9ccX6bWIkQT6TqfZuSdTpGFU4Vm0Lz0Qgg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bYKZqw5h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bYKZqw5h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeCDAdB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:33:01 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:19488
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932667AbeCCW1S (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Josh Poimboeuf <jpoimboe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 087/102] powerpc/modules: Don't try to
 restore r2 after a sibling call
Thread-Topic: [PATCH AUTOSEL for 4.15 087/102] powerpc/modules: Don't try to
 restore r2 after a sibling call
Thread-Index: AQHTsz53Oiax7DvYGEy6s5xTlhDpaw==
Date: Sat, 3 Mar 2018 22:25:00 +0000
Message-ID: <20180303222318.26006-87-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:N75chv78qolZnPEzJvirxJMRTjJUwXSnqp/WpE/An4TN8K1f+IPmvBFAJWQRvWO+YiDhxFk808WBCLpmcqbKgMMTKk8YcsjjMspJa2lnvNKsJi+gjgU/aTGkwxJDecm3oXikPNppSmCRf9nCtTQ7u7kcwol+T0ohcaxdtftN6sBTvnyGmgNyokUuta7GXL7silNSaQZeO75uIK0H9nDqNf//9xrU79bn422O1g7MclBlgA1VZpZdtKXtCW2q2Tor
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 560eef2e-c180-4eff-998c-08d58155ea7e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970AFFC242476E15FD69296FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: hjgTuOrPobhNIekayM/WRwhI7WgcIFQZYXZJ+6np9AUTR8ICjSllvbgYH6ZrDc0lwWUTn2A6hGjceZREla4aqJk33KoUIZisiBhXfD4ykQ9P/nl3if1i7q2nXKVF0vMSlFOgaA9mSTs5KNtmP5c++WE9vP8bqQkIy+1WIt2suGI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560eef2e-c180-4eff-998c-08d58155ea7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:00.3066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index abef812de7f8..2c895e8d07f7 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -33,6 +33,7 @@ int patch_branch(unsigned int *addr, unsigned long target=
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
index 759104b99f9f..180c16f04063 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -487,7 +487,17 @@ static bool is_early_mcount_callsite(u32 *instruction)
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
index d469224c4ada..096d4e4d31e6 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -302,6 +302,11 @@ int instr_is_relative_branch(unsigned int instr)
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
