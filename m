Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475065-2-1661106479547117609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, FSL_BULK_SIG 1.316,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475064; b=t4BeNuD3ev3ufL8zVd6+d2xFKa5ju0Ssumh0XpFzIZyIU0q
    xzSgPFXm3aAi9IvTHZoE9goR29cJ9UR8/G5nQhbHKA82CksgSdt9uAdatBYpP2RK
    85FfDT6iM/ESm9NxUgSnDMEEm9qK4TUpC4U/Uv3A4pDThOraaA7w7ftekjIkNA8v
    e1i7CZkWjMRDANMSg9qBD+uUESrk4NI3gKF0D9I93yzTwlUa+QAO6zmurIdOP4s3
    xY11xdcCSeAbSW1vF+mARwljWC+AkdXnA6/kSlJluhyS2iA96gYQl9Dt5Tk2UYzz
    ROTvaAZTCn4VGB+kyAiPpr5sE6h9QiWMV8q5pGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475064; bh=3NWRiB
    v4Ehbd3VyzB7UFJ+vR3s1FgfztxUe/nXkOz60=; b=IRGxWcr3aN5XfZPTWvQfOV
    4OS8OMYNOVTvZBJLxvZLj/uZcvgb+O6nY7NRC8BX2cjvGsoXqMKIIcUBSKmXRasJ
    IvS13ifnZ18GsaZ+kzaIAMN3u7Gz4lSehoYhvANrX0QsP6voN/ARwOb0L96lxxPv
    KruoVfpH51/gktH8lvZ9Q1Nksn+ezIgHVchYyABaA4Wk7uGJe+6RLOgZ34j2vflD
    absSlg4hOZ7kzAGZxZCIvLFJBgYdp+bgBc1qkPL+nO08Fvyh1KUyYaIImUTQ1Ht2
    feN/BYDOndhnhVphPTHiOc/WAyxUsh4xf8Q4/kZiy6JsKYZhJyLyQxVmF2VijVKA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QjZ2hhAR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdeftdegnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QjZ2hhAR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdeftdegnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934716AbeCSP5f (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:57:35 -0400
Received: from mail-cys01nam02on0135.outbound.protection.outlook.com ([104.47.37.135]:19273
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934696AbeCSP5c (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:57:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Paul Mackerras <paulus@samba.org>,
        Kumar Gala <kumar.gala@freescale.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 93/97] signal/powerpc: Document conflicts
 with SI_USER and SIGFPE and SIGTRAP
Thread-Topic: [PATCH AUTOSEL for 4.14 93/97] signal/powerpc: Document
 conflicts with SI_USER and SIGFPE and SIGTRAP
Thread-Index: AQHTv5rbBePkbspQaE+7wQ+kiH2pyg==
Date: Mon, 19 Mar 2018 15:56:34 +0000
Message-ID: <20180319155411.12348-93-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1096;7:sKmftt6T/KPuM8R6XGDdX5QAmW88G58WrAv95BNJA5S9VQvVZceiUHd0QXcDYcAj8WJnFkqStxwD9JWSkxC9Nh7k4mCa+wWOLGwz6lF9fOnoJ5tL1k990ksWL/tTfYHVORLAdLS2Qw6mZHMyaAYZH+gJNZD5E/91tT+feLphkjb9ygvsi/aXjJCtxmafrH4AtPWl5cmFooJbLU029ZMfA7fqLblNGmL9IN7vUfPiyJ1bs2Xjqg9B+URo04i+bXg6;20:Z8c9rcXljP5H0jUct1smhIa81BEZgTynOG5MEg57yrcXq2wn0UY5MICznkwTL6GeN91USt49/kgCGfbruJdegKppw5Cgdwpzk3Vo8nhKLMFdpXdjESFu8yU/knClbp00YXgZUiXJrwOy0nFgr70eN4l6fZsVCSZ+AsgfZAgby8I=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a78252a-e32b-40c8-ef61-08d58db21c0f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1096;
x-ms-traffictypediagnostic: DM5PR2101MB1096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1096224E94A547BE950A17B7FBD40@DM5PR2101MB1096.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(101931422205132)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1096;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1096;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(966005)(86362001)(54906003)(575784001)(14454004)(53936002)(36756003)(107886003)(3280700002)(22452003)(6506007)(5660300001)(68736007)(186003)(99286004)(478600001)(76176011)(6666003)(10090500001)(102836004)(2950100002)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8936002)(8676002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(2906002)(6436002)(66066001)(6306002)(6512007)(8666007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1096;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LRfvrJE0NBRo5Ig9tOg33zn6ekxQwWu6rFrlc08r9If7gFj3SbVMD6KkdrBBsBcFy4338Ljo10WDaZVogHLpLwjUlKjiEmo5f2z/Rn7Ww0yrzmMj180gYbE9nkQJlA3cQBeR8W/ffMNHC+Q2eEOqTM3ZC0bC/adRyLY4Kkx6bNH6UqzXWfOXCMXHc9CagBLRh31B4gGwwNX9il36OPZgou2G0Vqov9C3nIkOqVFxx9EJldDk/xR+1MGw+OUiw3uQ+gMcN6iObKPraHO4Ye6JeLn6ouIhKO6FAjLReFGxBmIqNeEmU3PEJdq+4oqhQ79sF5ZKExgsjkdwQvdjJQ7qJQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a78252a-e32b-40c8-ef61-08d58db21c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:34.8530
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

[ Upstream commit cf4674c46c66e45f238f8f7e81af2a444b970c0a ]

Setting si_code to 0 results in a userspace seeing an si_code of 0.
This is the same si_code as SI_USER.  Posix and common sense requires
that SI_USER not be a signal specific si_code.  As such this use of 0
for the si_code is a pretty horribly broken ABI.

Further use of si_code =3D=3D 0 guaranteed that copy_siginfo_to_user saw a
value of __SI_KILL and now sees a value of SIL_KILL with the result
that uid and pid fields are copied and which might copying the si_addr
field by accident but certainly not by design.  Making this a very
flakey implementation.

Utilizing FPE_FIXME and TRAP_FIXME, siginfo_layout() will now return
SIL_FAULT and the appropriate fields will be reliably copied.

Possible ABI fixes includee:
- Send the signal without siginfo
- Don't generate a signal
- Possibly assign and use an appropriate si_code
- Don't handle cases which can't happen
Cc: Paul Mackerras <paulus@samba.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:  linuxppc-dev@lists.ozlabs.org
Ref: 9bad068c24d7 ("[PATCH] ppc32: support for e500 and 85xx")
Ref: 0ed70f6105ef ("PPC32: Provide proper siginfo information on various ex=
ceptions.")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.=
git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/include/uapi/asm/siginfo.h | 15 +++++++++++++++
 arch/powerpc/kernel/traps.c             | 10 +++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/siginfo.h b/arch/powerpc/include=
/uapi/asm/siginfo.h
index 1a691141e49f..444ca6c9989a 100644
--- a/arch/powerpc/include/uapi/asm/siginfo.h
+++ b/arch/powerpc/include/uapi/asm/siginfo.h
@@ -18,4 +18,19 @@
 #undef NSIGTRAP
 #define NSIGTRAP	4
=20
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME	0	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+/*
+ * SIGTRAP si_codes
+ */
+#ifdef __KERNEL__
+#define TRAP_FIXME	0	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+
 #endif	/* _ASM_POWERPC_SIGINFO_H */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 13c9dcdcba69..f6f6d4bf147c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -720,7 +720,7 @@ void unknown_exception(struct pt_regs *regs)
 	printk("Bad trap at PC: %lx, SR: %lx, vector=3D%lx\n",
 	       regs->nip, regs->msr, regs->trap);
=20
-	_exception(SIGTRAP, regs, 0, 0);
+	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
=20
 	exception_exit(prev_state);
 }
@@ -742,7 +742,7 @@ void instruction_breakpoint_exception(struct pt_regs *r=
egs)
=20
 void RunModeException(struct pt_regs *regs)
 {
-	_exception(SIGTRAP, regs, 0, 0);
+	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
 }
=20
 void single_step_exception(struct pt_regs *regs)
@@ -781,7 +781,7 @@ static void emulate_single_step(struct pt_regs *regs)
=20
 static inline int __parse_fpscr(unsigned long fpscr)
 {
-	int ret =3D 0;
+	int ret =3D FPE_FIXME;
=20
 	/* Invalid operation */
 	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
@@ -1769,7 +1769,7 @@ void SPEFloatingPointException(struct pt_regs *regs)
 	extern int do_spe_mathemu(struct pt_regs *regs);
 	unsigned long spefscr;
 	int fpexc_mode;
-	int code =3D 0;
+	int code =3D FPE_FIXME;
 	int err;
=20
 	flush_spe_to_thread(current);
@@ -1838,7 +1838,7 @@ void SPEFloatingPointRoundException(struct pt_regs *r=
egs)
 		printk(KERN_ERR "unrecognized spe instruction "
 		       "in %s at %lx\n", current->comm, regs->nip);
 	} else {
-		_exception(SIGFPE, regs, 0, regs->nip);
+		_exception(SIGFPE, regs, FPE_FIXME, regs->nip);
 		return;
 	}
 }
--=20
2.14.1
