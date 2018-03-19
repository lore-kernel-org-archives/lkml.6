Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496437-2-16775977432502409697
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
    t=1521496437; b=uPA2iSsa3csyp9VNxEOqhLtcRFg3q0+Eq3wKQ5u52bxtuQ6
    L9+e9TZCAN69NCXzDkhDtU+KZQ1XgWP3PuKn7vSqUWnfSUWAOOrbmyxkdIE2cpto
    N8BCFL5fMMw1sW3dHdd+Had/8opSvzc724Y9mFmdJtWZJ66s8H6lgKB+JXQuRwac
    s2P2hx1fZv6Dll6jyudkRL52QnLB/xB8LdxfDxcI8SL96EIhg9EIfkmco7cHnuW5
    3c5tt1oZ+5vgyLmjkxQUqph+77C6EnYK1RyR8UNb4DfLMyHiy4cwPIA/cdZyTfOr
    0ByIcG9SKFBWEPRNezHapipNMf1ApB1IGw4k70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496437; bh=7MOEwc
    O1LoLuSMyABa93Th3qwdSMb7lSSLRoSXteXPk=; b=M9aUUKWOiX1AY7z9dskSHh
    pKuY6X02PLgS8Q8ok5RVJaIKLSQdj6/u15LZn8CYnTPTLyDr1WVzYByb5o/Z/OtM
    4uVuNZ2cLIBqRcD/deIpwEYNH13UkGNAzB2cI8CGewm/rkeGkFnjmjslZrDaLxgm
    lyNz4bn9csaYGWl/wMRa/wNjARIbILMttxRXl0HPjs/qAxwQyXIapCJAil3mQOM1
    Zy0d86iXWyxEnIQEX3KlvWrdaRS6atVf7jVVw/Qn/zAauqbfAA2sq9PRHkSFkS1N
    JF656ClKd6HkoaTnCorjVi9ouIxkJD/xtSBtF3+k49+n33vLJD0iNx74pAjkP98A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KNkjUGAN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtgedunecuvehluhhsthgvrhfuihiivgepje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KNkjUGAN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtgedunecuvehluhhsthgvrhfuihiivgepje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934405AbeCSP5d (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:57:33 -0400
Received: from mail-cys01nam02on0135.outbound.protection.outlook.com ([104.47.37.135]:19273
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934683AbeCSP51 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:57:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 91/97] signal/parisc: Document a conflict
 with SI_USER with SIGFPE
Thread-Topic: [PATCH AUTOSEL for 4.14 91/97] signal/parisc: Document a
 conflict with SI_USER with SIGFPE
Thread-Index: AQHTv5rZFLWqFTWbW0ub1xZCmJNBCg==
Date: Mon, 19 Mar 2018 15:56:31 +0000
Message-ID: <20180319155411.12348-91-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1096;7:xIbIf791jWL/gxb3kgs8FkvFp83DD2xaSXmacbNXJ2OZ6BIyZEZH6tHZKXkJmHOdW9aPzbVQjA4wA9bkTcZ0UMHeMmEzmQbWsWZLytBMfWS7dbPb15fjV47/eWyHjwd1A5jKgyxIA0w8ihI9dE6USQ6xmtUDzd7xsmM2R5/mrpLn/z5T2x5Dj/8ibgUdGwWFeOSuryQjWcVszNnzAEvRb1CKaNiDGvdKOWb85c6MSTRsu9uTKUlP4NsN/4dNfH0M;20:ib9c1zsUv+XIB8RKnDo5Qq1HeQ0fEHzs5BQs4+CKBn4q//kbMYtB20x4BJNmXOAMkK8syWJi6lm9h+edzd2DPetkBjw9Y+PQ7m7V9GqFEikg94uB6Y6WhbTV2edDAxEqCq5hWqeepdekt8HV89oh8q4+bmxT0Eq+C1ihPUZSe44=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7d93174-4bbd-4dcb-78e5-08d58db21b76
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1096;
x-ms-traffictypediagnostic: DM5PR2101MB1096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1096BD2F192B1F4A0F902881FBD40@DM5PR2101MB1096.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(9452136761055)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1096;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1096;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39860400002)(396003)(366004)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(966005)(86362001)(54906003)(575784001)(59450400001)(14454004)(53936002)(36756003)(107886003)(3280700002)(22452003)(6506007)(5660300001)(68736007)(186003)(99286004)(478600001)(76176011)(6666003)(10090500001)(102836004)(2950100002)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8936002)(8676002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(2906002)(6436002)(66066001)(6306002)(6512007)(8666007)(6486002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1096;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yQYKq/NVYDRO38SBzTOt8KwCJdD5Y93OVclmVRb1TUaNW6YMkhOM8q2Sh3w7xArC2nCd2kV/F+9qy7Ji4lMuWb+15+hHKvp/Y1JjccrIQwwjz5vG+olJ78HsX20ncrT3dMyVj9STGCjVmqp1IV1rDOw44Q4iBf3brrQWOZCeDR0uKDUOFRTlbhhWRwRW6oUyfEiRDCJoknVnb3WGmGbQm9pAJsIUNJ1AbkPvwK9+wAqBWLBmMKv8VwnrVFiCPo2uvrLIe8kORJbMawSAemq+kCGm+mVdLNmg4G5AOVL/6qQR1613IHLE9ChpIGYe05mCZevsC5l/x96N/OhGwWy9PA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d93174-4bbd-4dcb-78e5-08d58db21b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:31.7597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1096
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit b5daf2b9d1c9a2b4f03ca93f75913ba2da3b3eaa ]

Setting si_code to 0 results in a userspace seeing an si_code of 0.
This is the same si_code as SI_USER.  Posix and common sense requires
that SI_USER not be a signal specific si_code.  As such this use of 0
for the si_code is a pretty horribly broken ABI.

Further use of si_code =3D=3D 0 guaranteed that copy_siginfo_to_user saw a
value of __SI_KILL and now sees a value of SIL_KILL with the result
that uid and pid fields are copied and which might copying the si_addr
field by accident but certainly not by design.  Making this a very
flakey implementation.

Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
appropriate fields will reliably be copied.

This bug is 13 years old and parsic machines are no longer being built
so I don't know if it possible or worth fixing it.  But it is at least
worth documenting this so other architectures don't make the same
mistake.

Possible ABI fixes includee:
  - Send the signal without siginfo
  - Don't generate a signal
  - Possibly assign and use an appropriate si_code
  - Don't handle cases which can't happen

Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Ref: 313c01d3e3fd ("[PATCH] PA-RISC update for 2.6.0")
Histroy Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.=
git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/parisc/include/uapi/asm/siginfo.h | 7 +++++++
 arch/parisc/kernel/traps.c             | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/uapi/asm/siginfo.h b/arch/parisc/include/u=
api/asm/siginfo.h
index 4a1062e05aaf..be40331f757d 100644
--- a/arch/parisc/include/uapi/asm/siginfo.h
+++ b/arch/parisc/include/uapi/asm/siginfo.h
@@ -8,4 +8,11 @@
=20
 #include <asm-generic/siginfo.h>
=20
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME	0	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
 #endif
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 8453724b8009..c919e6c0a687 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -629,7 +629,7 @@ void notrace handle_interruption(int code, struct pt_re=
gs *regs)
 			si.si_signo =3D SIGFPE;
 			/* Set to zero, and let the userspace app figure it out from
 			   the insn pointed to by si_addr */
-			si.si_code =3D 0;
+			si.si_code =3D FPE_FIXME;
 			si.si_addr =3D (void __user *) regs->iaoq[0];
 			force_sig_info(SIGFPE, &si, current);
 			return;
--=20
2.14.1
