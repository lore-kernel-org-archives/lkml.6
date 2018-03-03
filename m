Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116255-2-419006648386991295
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
    t=1520116255; b=Nmsd2lG33Rlq815KlYJttH4l2MPI36/q3hDexBGsnMaU8lx
    +/XRWzfoktI3IROQGzZ9oqJrKpHO/8wgMNFBszXVbRDgOzf+dNRMtJJcHdEanl4h
    7QPFKvKLJIDeI21dToKqEVsOPHwy0oRdIA40sz2VZN61m29KqY01gPHFF4mUhGLo
    1INQgXYLvXwyVL57WTbL6njo6Qhz74//Y73EYQWV1BV47rdn+b+4hbQ78wPb9Aff
    DRZ27cqWhvNRDiTaAz5WnE/Gno2f6T/nQElcCClZDC50PesLYtyO1Hu8ZzK2lro4
    AtfYKaEoqw1bX2kZoGFIi2zmGBKVFFM1ip2sZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116255; bh=P53upF
    Kh6Xrw5tfdV9wPFfmmvM3JgIyz5igwkR8HJOM=; b=TT/9muXYFneWV8COYecc9Y
    BDQmiJwyc/bVq5OD33CSQRdas5m9waeGcE9RSiPsdi+y6TUH0EzOox/bgpTl/jWN
    voBVXflCqTZDvzdNH7+AlccRupz7k4GN0XCbj7c1pH6UuHVa5o+POqXo8iVq4jv1
    MKmZCfV9tk53iqGnaxxqbU/0ON7HGuGX10eVFHq54k3V5akaVCGSf8mBX9RCCjCY
    pYDM6b66noQULe1tkUVRVWzFH6kwEl6WjhIr4NBXC7p26eHL0Q9xWKFOIzFcizT5
    PWkYPwmxXTkr5NvWjaEc9b4vbVe1b46ilLU4uWOl/WsHf5F+VSpYILYECmLiDGdg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k/CSylH7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k/CSylH7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeCCWat (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:30:49 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933492AbeCCWas (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:48 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Josh Poimboeuf <jpoimboe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 69/84] powerpc/modules: Don't try to restore
 r2 after a sibling call
Thread-Topic: [PATCH AUTOSEL for 4.14 69/84] powerpc/modules: Don't try to
 restore r2 after a sibling call
Thread-Index: AQHTsz6zqZbv3h8KTkqdWrXakoBTwA==
Date: Sat, 3 Mar 2018 22:26:40 +0000
Message-ID: <20180303222518.26271-69-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;6:VnCJIT3EhnxBDc6uSO/MQeiTDUzwYLqAnoEEKWZY+nP99WT2bxA+YUesZjjZWBwmWnlT2D3aBvsG5pd/I5SchPcAA27uLwflYihrPranI28roj875v+MUoBWeAFtW9EizAeF+GII6co/XyDif0T26kAFdLP9uFNR3TH32n0JJMCQZVqvc0mOcBwgXJFD7NLdVlF6bgngzQ9+Bo+d0hUrl9KD+lPvgavx3v+uB9j6i0XhPQt++EqUIZnYTmt0+V38MFreruLUSIrU9dEXKjpZiOZRYLqz+uCDi8TjIvMhhS4ckxlvnDKhQlDRFC++4MDWACo16KlAFcpsGMQWJ6TGZ/KHcA8m/KlItCBxxXDQ9z4AbIl65e1LmpkvqKYw61xU;5:Tzi89cprW/r/QJb/Newb20cxzrV9iVFo8GVCH5pld/A5YSE9JRH0XhL21q0CdrGif6rgAnqxSkdcWG+HDpWcFG5pye2sTR2bXDiBVSPbQOLS/BXjQ3h1ykxOpXpxEiOBHx0D9AvHSRnkVmCCNsfVHeYkVvlAXv0GOH+fV/7gjw4=;24:0U0W3je0gM6IBa9/SAKvGRrSoNyBPN8vwW0VWpOxxg1BbfknnELY373HCht7p6vjkL4LwdwWDX42A0+63fay32iZvrOAyDIdX1+wlLLIePI=;7:mAGs8lLIRNiWUgkaykwv/YBSfAQIE84dA0FAE3sZtbBdNy9MMZPlXTWUF6aVE7ne1iAKoUXlNBcLYVg+fjSQBSJyKvou99ziDaQ+GLbCRhxPP/rtPlAC/njfO845b2MTpLaCOwB+Vw7XGBOAnmHjAjn8FeCbYXMbg1w5XK3pFuqi/XAubWFoIKxcGZGdVlxt77KtEejoq2P7qjnMJTDaR3ceT7Oa2Yfoxom5KvPXBPiQ3APY/GbH3pl6j3cy4iKT
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0853d3c8-e668-45d0-29ba-08d58156681a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11150486A771A0F141C70E6CFBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 4frBmZARB8MY+SEV2LM745nFcwGzaNir63fJ9GbrlinhyX2SorFMpEOjYBqChCy/MrmLw3N9eL2O9WH6w/GDLyii4rSuT38NyoBE/dUpBYBlVO0GhGigzFCC9OjPlZpGb95Uc8Y8SoLw/95hi31xiB99k3JP7f8tVSvHayOB7h4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0853d3c8-e668-45d0-29ba-08d58156681a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:40.6973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
index 0b0f89685b67..2a1b1273a312 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -486,7 +486,17 @@ static bool is_early_mcount_callsite(u32 *instruction)
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
