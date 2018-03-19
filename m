Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476114-2-12272203772814203793
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
    t=1521476114; b=IWWt5eWqmgyeUeL4cyIl12IWxKu9fR1nKp/v0qyI5wFlmGY
    n7oaVkveLBG966gOOS13PTcGfIGic/L694JcnIc4LXxr9unA5ZRK+yB1Dpi9Ow0U
    tTlRQ0w9r+Li4YyO/Tvqh3yFzYuPqkMEUAqwstvVEz8fKkUCHrJ/Q4QULfF3wyTl
    1kqsjbj0PeL2jFvh6RoYfgklHPpMdccEoHaWxMaz0JaWYWyyRz+NOY4G+OjrGyJe
    CTBy5FO8rb5Uw7RFb+N5Tz8cOjID5foLkBhYDvszAOcsLY9FdQ0REh9qQ981j7DI
    TIGiEeqCW19zVyKAYpdyZVf4MyCYAqvva/IJ/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476114; bh=58tzf2
    iRp4fJ+BwukcCLyyKBXTNkmyQ/SkJxEKQeI24=; b=LUEFdapLosoezT9WG22N6i
    d4P8An5v3hpmY5Y50itDCksi6XuGJzJVEx4AyAN3ryyyxBwo3lld27HK91HEb2i1
    JNoGLO65gq8W/WWqgEiUdcajnYAIWDnCO18Ph0Dvemt1i0OztFzFqjSSx+Z9Dznz
    M7vFMV6+ptLV5410DaITcdX73UDgqYRRfLrRLinjrMM1O5MyCJZdcM5W7LYxTLDg
    Aa9LfbcFcCLzC+S2HIm/j0HrUtmI2cVzLQwYLQNLvaHAf1iqi6Mu9/GhJmKlKqSh
    Uy98typBC+57o+6+XLkJmXU/xT6OmaMwQiWmTfASVPwSPdMZ8s20xM9b5Kpzntqw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cG1w5nYJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieekgeenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cG1w5nYJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieekgeenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967070AbeCSQPK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:15:10 -0400
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:29327
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967057AbeCSQPF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:15:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King <rmk@flint.arm.linux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 102/102] signal/arm: Document conflicts with
 SI_USER and SIGFPE
Thread-Topic: [PATCH AUTOSEL for 3.18 102/102] signal/arm: Document conflicts
 with SI_USER and SIGFPE
Thread-Index: AQHTv50/QTxftLfaWkKDDzBuWmgfpg==
Date: Mon, 19 Mar 2018 16:13:41 +0000
Message-ID: <20180319161117.17833-102-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:bO9M2eVIpWpcSy8bXK8PXlTukXmVvgbf/KV3mestg0aZvthGkH2eVwWq5q2nJZ3vXabcMz+X6U08QMdQHsP8ednn/OYhfS5jSRm0blkfOQrFzTTO2KLFcTHXrUE8vmkFgHGnAxROnZOFuPzeqT2/tExCOi0iceAATZNCGEAQzI2a2QFCH2gEH37C6FS5OaKaxN4265nksUrW9hFG2VL+LrG4PbsOTcUwhbj9rB+rHD4HlezrBdZsa1opI7vQ1068;20:tBNF43jFNIKRxij9FSV8zcoqYolS2ShUexdG0mIPJxLHezWKT7XiQXtEqR4YrF+MlwFoIr4PXZNxx9yXRyQryHMUViJ5aGF2D0xgsuAi3eVMV12h5R3iYLkP8nKAlpsjwYF9KB87bDAduy0r2sptuuaFLhyzGIEzOG+P0ySDRFw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bda4577-e78e-4fdb-a8d7-08d58db48c2c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0869D7ACB81DBFF738E09378FBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(258649278758335)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(39380400002)(396003)(376002)(189003)(199004)(3846002)(6116002)(186003)(1076002)(53936002)(97736004)(26005)(86612001)(105586002)(2900100001)(575784001)(86362001)(66066001)(6512007)(81156014)(81166006)(68736007)(102836004)(8676002)(72206003)(966005)(4326008)(36756003)(6506007)(478600001)(3660700001)(316002)(8936002)(54906003)(14454004)(5660300001)(110136005)(76176011)(2906002)(6666003)(6486002)(2950100002)(25786009)(6306002)(10090500001)(6436002)(99286004)(107886003)(10290500003)(106356001)(22452003)(2501003)(7736002)(305945005)(59450400001)(5250100002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Jo9elsNyiHSIidEf/k4gOBFB5l4WhWatuej+F5B+Q03cYYo3UNaaAsQZehVDvqWBMDlaDJioe77sxasvya5gNSCkRDpYn56LCrmE9aaQDqFDFD67W4lmifYDi2VYirrPus7rcI00pjqW+XXRCl4iUWH3I9wQ06te15HgZeHByRsuD1hj2jaowDHSICcf0NNbY8bIQt8xXxBV/To8HguPT986phV2EReOori00rTT4t0n9t8gOMz5PzHSDsRNDA3o2VaqNx7fyZbZMv2cBJ/aIR5sYussL2MXVOtxIpoovgoBrNj2hS3F8TiPCe7DIvZUQknUO1OcXsy4F0iYVciIdw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bda4577-e78e-4fdb-a8d7-08d58db48c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:41.5427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit 7771c66457004977b616bab785209f49d164f527 ]

Setting si_code to 0 results in a userspace seeing an si_code of 0.
This is the same si_code as SI_USER.  Posix and common sense requires
that SI_USER not be a signal specific si_code.  As such this use of 0
for the si_code is a pretty horribly broken ABI.

Further use of si_code =3D=3D 0 guaranteed that copy_siginfo_to_user saw a
value of __SI_KILL and now sees a value of SIL_KILL with the result
that uid and pid fields are copied and which might copying the si_addr
field by accident but certainly not by design.  Making this a very
flakey implementation.

Utilizing FPE_FIXME, siginfo_layout will now return SIL_FAULT and the
appropriate fields will be reliably copied.

Possible ABI fixes includee:
- Send the signal without siginfo
- Don't generate a signal
- Possibly assign and use an appropriate si_code
- Don't handle cases which can't happen

Cc: Russell King <rmk@flint.arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Ref: 451436b7bbb2 ("[ARM] Add support code for ARM hardware vector floating=
 point")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.=
git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/include/uapi/asm/siginfo.h | 13 +++++++++++++
 arch/arm/vfp/vfpmodule.c            |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/uapi/asm/siginfo.h

diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/as=
m/siginfo.h
new file mode 100644
index 000000000000..d0513880be21
--- /dev/null
+++ b/arch/arm/include/uapi/asm/siginfo.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_SIGINFO_H
+#define __ASM_SIGINFO_H
+
+#include <asm-generic/siginfo.h>
+
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME	0	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+#endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2f37e1d6cb45..b646400bfb0e 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -261,7 +261,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 in=
st, u32 fpscr, struct pt_
=20
 	if (exceptions =3D=3D VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		vfp_raise_sigfpe(0, regs);
+		vfp_raise_sigfpe(FPE_FIXME, regs);
 		return;
 	}
=20
--=20
2.14.1
