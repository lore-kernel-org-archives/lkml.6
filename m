Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474731-2-15958997588600795909
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
    t=1521474730; b=S7N/0mYSvedJhrCntIoDVcSTHqYRexQ5dkfklZ5ElDISYVT
    +4ZGTMcop+ahh8FNXgJ89a/wuw4zJHCZS4SUt/6CmGimfJTBC+kVzprlV69usjCb
    veWiQFd1Go7dZUOS1nQJ4MozIjCaO+Ia9U+G2sDVldvOTCJqHRrOyX9W4cenaT0v
    ij4FJ4mwY+1hyfkl4A5oObxF0+U9osKO+0m+86Db7BN8FjMkUP9jpd/vXYgBFvoh
    paefeZm2FQxVTgJHRzIfDZKV77t3cFO388m0wkRb6T0dCI+zuMoyOE5/l3aVHR3R
    p8XWCvFtGZ87pOeUZ8JVlZW+gI+NyazOyzMi4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474730; bh=kHQv4x
    g3Njc8S5tHrad90KiE0vZ0Aj6ZqW8faQ4NirE=; b=AaB8IZ/TYXMJEMJ7m0BVOv
    U0HinfElOnE9u6OLdQ4D4ek28TeRU0O952HNPus2GjqFEufr9CQe7HCzZa5E1eHa
    yLc96Ehz/ioYS2V9rEN9PNGbHd5cc2tdKotgVQA0jDha0GxIrDcHAt9Gm4SKsq9x
    TfXPWTHCZ0bitbhZvOiIgAR80AI4IOpDB0bbR/CDzk29gU4Uxjj17WBXZQ6QNpkD
    rJF02yaHBi5hyt1WP5kfxghk+JSC3aUJkC1W9h0nOPEPpT81kMZmGtR5VlMyOgU6
    WKKKQDhZpmLax7T+5zj6X3an0bE9kG5/6z1u6xedF5drnvyRYFytyvZZujbU6EMg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YZInhwVH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdeftdeinecuvehluhhsthgvrhfuihiivgepudei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YZInhwVH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdeftdeinecuvehluhhsthgvrhfuihiivgepudei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934094AbeCSPu0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:50:26 -0400
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:9280
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934088AbeCSPuU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:20 -0400
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
Subject: [PATCH AUTOSEL for 4.15 120/124] signal/powerpc: Document conflicts
 with SI_USER and SIGFPE and SIGTRAP
Thread-Topic: [PATCH AUTOSEL for 4.15 120/124] signal/powerpc: Document
 conflicts with SI_USER and SIGFPE and SIGTRAP
Thread-Index: AQHTv5nW5xRLbmWqQ0m4B5eZ24XUqw==
Date: Mon, 19 Mar 2018 15:49:17 +0000
Message-ID: <20180319154645.11350-120-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:l0BqehK7jZsmnTUR+q1P40rl0n3eVZ57YXtUF/moKRActIcrJJrQph1h8SPyYp2TG+fRSeIw0TYRWJsiVLY4iBwZ+Ehe9ZATcA1qKJ3XDRWDSYfSvIXn+sMM4YHUO5lHhap6BlE5BanLjR58kCzZ71cLCu/KXBwu/3+aNrDlQ81haOd8nyrCIfZonc9Da27+hp1AFhQwvHZWwiuOu1aLoviYATOiGBGj/w6erIb6mbvzdoNUghvHmyPqtleasXHi;20:s1DeMkal64xXz5MjmRC1PQthuvVEXi/oPLfki8m0gBgA5nrtYacoSKaayCA3qWOI8ps3ynVLRkp9Oa0tLgA9AHa/ncJeA2CqIowQvReY5Q4yXW/1EemBj84a+CLFWhtggmbU0fnyg+UWDmvkJ3Jn+pDwhpdw9ij4TKcYcst3HN4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bab5f5b6-05fa-428b-7a01-08d58db116bd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109610BDA16D70A9C8F88D7FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(101931422205132)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(2906002)(14454004)(966005)(76176011)(66066001)(8666007)(6512007)(6306002)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(575784001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OdrvcxZu+ms8Iytqfa+5f8jHKkgkG9oKBTfQYc/5OoizqDSG02r5QpF6+PE3Z0LsUEMDt1VSsQ8Ykg+wvF2GsypViBxEBE902s6cDW07K+fiDliZhJQzivnjP13s4MueeHSPqi9nvNHPK+dKYFuXUPmEFjEJnl9/RqMXwvTttp2D2/hBddbW8cc+25iXxg6Oc0iAHc7ru0mIkS7rgdRdjou4DbKAXr97oxeQ5okGSnZ19PvvHW/LpirIEMRa96w+odnCQKPP+PkA55NHRw8xB2GOz5BFRy66s3aGASRpY0v1OnRW8DL6VhhNgKzh2nSF6sfM1+9odeffUYOv6cKcFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab5f5b6-05fa-428b-7a01-08d58db116bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:17.0826
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
index f3eb61be0d30..f2e6e1838952 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -917,7 +917,7 @@ void unknown_exception(struct pt_regs *regs)
 	printk("Bad trap at PC: %lx, SR: %lx, vector=3D%lx\n",
 	       regs->nip, regs->msr, regs->trap);
=20
-	_exception(SIGTRAP, regs, 0, 0);
+	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
=20
 	exception_exit(prev_state);
 }
@@ -939,7 +939,7 @@ void instruction_breakpoint_exception(struct pt_regs *r=
egs)
=20
 void RunModeException(struct pt_regs *regs)
 {
-	_exception(SIGTRAP, regs, 0, 0);
+	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
 }
=20
 void single_step_exception(struct pt_regs *regs)
@@ -978,7 +978,7 @@ static void emulate_single_step(struct pt_regs *regs)
=20
 static inline int __parse_fpscr(unsigned long fpscr)
 {
-	int ret =3D 0;
+	int ret =3D FPE_FIXME;
=20
 	/* Invalid operation */
 	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
@@ -1929,7 +1929,7 @@ void SPEFloatingPointException(struct pt_regs *regs)
 	extern int do_spe_mathemu(struct pt_regs *regs);
 	unsigned long spefscr;
 	int fpexc_mode;
-	int code =3D 0;
+	int code =3D FPE_FIXME;
 	int err;
=20
 	flush_spe_to_thread(current);
@@ -1998,7 +1998,7 @@ void SPEFloatingPointRoundException(struct pt_regs *r=
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
