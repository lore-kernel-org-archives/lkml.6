Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474740-2-8545653692149488053
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
    t=1521474739; b=N88U0ffQrQpO5etWwe3LE5Df5cG40CE+cwkZv3eGW7bPUmq
    iQD42GO8TYqetB7purk+ovG2VSHsRbamS2DOmQ3UacFZrGsiSHe1agKDn+kUOj2X
    /ZNuuGdlA0VkHWV9jX9xzXsVv7YJss3h4Qu0jb6X8ovlPnUJC38YT5uN/d6jILJW
    uv3XPVWt9clawss4C00ojzcwzvw8gery30+GgPdonzg6BKDVcfmG4pqvxBBNnVUu
    gcI4cO+HuhX+Dd1jMFtbldhOWuLVAC2CPrfPGsQMqWPM9scXp2S+Se+LlS7pbz2V
    FvFX6sk5CMzqasxyOWgpf0rX+baVvHeiSG7jIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474739; bh=7MOEwc
    O1LoLuSMyABa93Th3qwdSMb7lSSLRoSXteXPk=; b=xCJmI8N4sX9ZXe+Y/02gzC
    OGJ2O2gIFCs1NZlDlGrxr4nGNcWG52NfzWSM4UdyTwcdNiEIcfy+m0TPOKGvHHux
    aVJlOXiqiyYAS6LGkParAB2HKlP1UWIfpg85H+hFCpc0roOXKhpPQ81a01YfIQw0
    xBbBGzGlmRFLYFOHwbu6wi65CWrhnb/Fhvvan/mGeAdkRAdjFd7hHa8JSFxKV3Lj
    lwG2mzGAmIqAR02tbGqIHPKk/4A/Q2H649/zOVOqmmUQmn+iH1c/AxMZ5r6v1uf3
    tvT4y+Z/ydcXJAgbIK5u6RkLhkaUiLuc88HT7LySNlUoz58FtJphy8ztcZSuiBjw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FvNb5LW5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleeludenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FvNb5LW5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleeludenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934196AbeCSPwQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:52:16 -0400
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:9280
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934079AbeCSPuS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 118/124] signal/parisc: Document a conflict
 with SI_USER with SIGFPE
Thread-Topic: [PATCH AUTOSEL for 4.15 118/124] signal/parisc: Document a
 conflict with SI_USER with SIGFPE
Thread-Index: AQHTv5nU1jM4TEEmbE2qukzwpEcuig==
Date: Mon, 19 Mar 2018 15:49:14 +0000
Message-ID: <20180319154645.11350-118-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:w+hE0tQMAg4HJBBV3c/IqoZUZaK/NpMAp5+m3uZMTHzYNRibmpK83J1yYzUd22mki6c6MmPPzrvt9GmZsp7AngVnWr0lBSMVRbidzAliGV2rtfgqca3o+664cCUj+udS7zI7SdC3pwx5iykGTjwZiDoV37I+StQSHqUhEIrb5BuvhiAMuPPfqhg8HRCNuQPK5Nkq4k+6WO4Iuamd9vqo95VBjV+ZmPmcYqm6pilZdWoMsiTljwCjvMbXK1mBt4mX;20:6/r/2oXNpD/otaGLVcpnbF8uKHZ7XtKDXBoRHcXU9CckkAL5eTd95CngGdNBxltwbK2FQKfP5aNtfdEnW84w/fo0UmDN9bjL+x42ew1ip7bpdSfo/ZaSq8HcB1m9a4dsa7cys/rfd/BdmgI4vEahOOMzDia9MhbZ+XR+XGT9Bx8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55fa054a-03d0-46ec-1a36-08d58db11623
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11092827E5D83C01798354CCFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(9452136761055)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(14454004)(966005)(76176011)(66066001)(8666007)(6512007)(6306002)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(575784001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: nA6/g/HVO/zpIK/6UreIEVSNbSgnXnFrDCzZkD4LqunojCkO8ErZvUQ2MpB2a1v3x7SkSXIPs9UVHaws7Pja8WGynGTdLa7iL6OTW8TDfQVD3TLAo5JsHwIkNBefi2tMfw+bQdjeu36E20arN6Z/O6Rhvv+xBTc8Qjt39yYdhlNJYobmHedfh9buUut3H+3PKT7w4uNM7ro5WKc8JGJERn80p9f2miY1Df0CrohArrcWEIBiRYjZ6xu97tvxaCqSge+aYrizfA0orKtH1F5J5SWcg2g2PfeNhMt3kDl301jagnv4kqTmcQNNlkgkQ7vYiWQaLW23785mmYTSQKxp+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fa054a-03d0-46ec-1a36-08d58db11623
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:14.4447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
