Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478573-2-10625006569946981555
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
    t=1521478572; b=Vp15+uwvN8aCX8q1hJZXCbszoRUZOEUCjf2GofTtF2zI644
    nxJi1ClUau8QlUH+3NHBRUr6dfDa/O6HnO8Qjqlsl2xwFoblbYSviypOv+QTioAv
    W08DuaRur3cUC5pazP9gru+7sstBVWsWuvG4C1ppjDRJeYynTKDnFiknagRONNlj
    VKNbOLe7h2DYzOI4PU1nIr5UFCUzqyuXtVbKWM1edrdykivc85ULDmV16gpTW1cn
    YnBNygIFDCjk+R+ZZkrhb4GuYUOqqeSH23cpehwfNCZmHbnNZU23zREXQg2PoTbC
    GRIH99MDxpuYtACZ52SrV2SR2KPCq1BJ3lO8EEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478572; bh=LA0JZp
    TJVf8u+ADPXU3aR0FqM4FWQWux80GUrG4bS0k=; b=FP7NfeJezxjjxqZhXA7p4H
    LLqfIuVC0e/DdLLy28LFtQA5F+dF/3npYlQhaGDDBPZbrSF1HdxpUv/VhsMbVF+N
    wbqfSBYYsz47E5VHnGFpXC6zHPPxRG4Kl7JPTeCMKNvzPgI3MUy/20tWom5Vkp6L
    EP98m+L3SZjg6R9bPeEG0rf6KKpbWLW6Q++mNGl5eVm+HgrdTHRNthT0ay0rMj5f
    8oIFJrQ8NTcAfbGFuW+thnd4Sdu5NDMD1bHWGfLyItFYsSH9/la1OjP+YzlJzolV
    9dqkEFJsYCYHAhatiNreuscP2IYaMOTlulhNQtcRzdH/b7J+sDnzaAugLGp1LrJQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PJvkji8+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieejtdenucevlhhushhtvghrufhiiigvpedvke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PJvkji8+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieejtdenucevlhhushhtvghrufhiiigvpedvke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966787AbeCSQzo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:55:44 -0400
Received: from mail-dm3nam03on0111.outbound.protection.outlook.com ([104.47.41.111]:6417
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966766AbeCSQLh (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King <rmk@flint.arm.linux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 167/167] signal/arm: Document conflicts with
 SI_USER and SIGFPE
Thread-Topic: [PATCH AUTOSEL for 4.4 167/167] signal/arm: Document conflicts
 with SI_USER and SIGFPE
Thread-Index: AQHTv5yTRRjBPpkaE0C0mH9kmOWKcA==
Date: Mon, 19 Mar 2018 16:08:53 +0000
Message-ID: <20180319160513.16384-167-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:YL8wA4s9XscOQcQQtsuXT38RJJFWuEafquM1bML+b7VJ4Huu2b6uQ2ne6yg3Bai7rNvRH52kfISoNueLZhkeFCcC2OJIkzaWppoI77efL3A3i1PPyOVhSN+qFz4nzvjSVH1PdQEaDgxPRrHtGWHh3z3/3ysuDS8dl5S0bo5VIuqCW6YGwPsc44iOMAz3OHxY3Exe3EbBlpVyr5rNwoqyEkYCGWr1oprFuVvfeQMWMezWKEELO+TXxpNQugyyjgcF;20:g3zJDXaRyAJEwNc/uNN2qE8CvQyuRBHVsDNUO9i5sVSxUO5dULQthh5zuA3kulZvbhHYMmjlghULyFowb0N3ez0nT0nyxetKfFxwCW92fpkSO1gfhtZcCzzJ9QqQ0lGCLxp4vcROQY0uq+CD71lBN2jI6S6BfJk1/Ec7MIuiDLQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9f8e263-b878-45bf-6770-08d58db412f5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805CA34DE07066AC29127D5FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(258649278758335)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(966005)(316002)(54906003)(4326008)(6306002)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sVCZxc+tkXit278JZLjUSkrDZYvJNFgpInGSo2Yn9KwFgt1Su+KRb4ydDF0jF31EOpr+IFyvHDmft+onF52z9egEhxAubu85e1dZ07gkSfEMwAAj1EmunIIQNrJye+fYTiP6XZHY/wIv7afVUbSpPapv04Womq0gXyR8/OpsTYT4HIXifH/mLRBlSoztWVU9CrJSe7gHPOuREgoTlDTMEnoTdMVmojZ76bV1hV/mAqZq7TIZwfv3nKavu7mihlQ3ZaJYu0zEhHkgAl5LttTWGmpMXTdHPODPmu55UnfH5pxTDjkGuZzXZC17rgHCgSK8M00rJipZZSOUUKrbdO8Fgw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f8e263-b878-45bf-6770-08d58db412f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:53.6171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index 2a61e4b04600..333b74b7fc02 100644
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
