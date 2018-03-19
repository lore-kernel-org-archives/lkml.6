Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476222-2-10344359119895920993
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
    t=1521476221; b=JhAD3Ww0CDRtRIfq/q1b3nrGKEu4bz7yEveyiHZt4roOKM/
    gdzgKuwbx/MObbB03KEr9Ya93BRmS6JJl0nQ4ixYFISfMN2dnpt2k3WGzcso6Dpx
    ELBUzTh0nYsjPaOqVTe2U7/1Mm9wr+qvOn4lteArYCqZoMtPZfmIkSZvBFNdO/cm
    KowBqZSJwjjRuss9HZ/nJg7muuzZI4seaVOPfBcv9Q1Q5uGhC/I3OmgTtCcmhn1c
    r+K0hUwKwQADNCKy3WDD7sGW3JFU0QyRZmiACax9MdOXlF2kYvTBcKbvxgYCR0OI
    YPQSpjMewu+gZDk523zZLh7SPp5fqSZrNz7CVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476221; bh=HrWoqq
    Mir0e4mhV6Buy/oPsoXFJ1TyiB12RbwmWfloM=; b=uzj6dVsJdx08sOZobqZ2Cv
    gSICsmowcu87DTSAL0r7Hmxn2eXAOHZs57GLZDZm9LtwoC9ZbTrUVfUXMcdIMeNp
    ufrZft+z81w7ixZdhXgT1h+Z+85S6EhGYeW5pmmqLakjjxARWUm+OyKvc78FmS6A
    9Uz4DpTGgpolH3s58bFYtUSJ9QekQOAGRmPNwD9vj+y0sf+LA3ZFO1M6/tvi/xWb
    h2RJehJ9R1FixjW5YEaoQsOWw3Vv+3dXHbbNJ21dAqbBGXm4lF++apMkHoPcJ5dl
    R8clX1OF5QweRh+eAiCuMbtp44K2obkixJjpjbpWvAir3cPwINyBO0rjOGasX9kA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I4fTLOxd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdefudeknecuvehluhhsthgvrhfuihiivgepudef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I4fTLOxd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdefudeknecuvehluhhsthgvrhfuihiivgepudef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeCSQQ7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:16:59 -0400
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:29327
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967038AbeCSQPC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:15:02 -0400
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
Subject: [PATCH AUTOSEL for 3.18 101/102] signal/powerpc: Document conflicts
 with SI_USER and SIGFPE and SIGTRAP
Thread-Topic: [PATCH AUTOSEL for 3.18 101/102] signal/powerpc: Document
 conflicts with SI_USER and SIGFPE and SIGTRAP
Thread-Index: AQHTv50+CC0iphbbSEqp9kGMsh+5kw==
Date: Mon, 19 Mar 2018 16:13:40 +0000
Message-ID: <20180319161117.17833-101-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:Wkk7BCLzh3E5zzI03EI0kMyz8M+vky8OVKanpe6Ys77Vxc46EE7C6ioi9EJA96wN1z54lIn4UssIxjrzsAdb+U5SfjVB40nLxA1zIodC1/h8XY5qvsstXpYFOyNiWv3ihK1HGIkv80ug8v95Q9sPsFs1FKpgWW0YMwCuCXLezLwBD9fQOrypI9tBAllx6vcrtrL8vRDPBDuH/fgKWfYKefyc9r69XaxQwvZB1JxJQCgzmNeNnETTHG4NPM52jsTU;20:E9trBUw8M507uyxySmj42c4xIRNJaUDeVRaWpiw8dKmEmtLNYsBv529SVGH3UHL3q7OCta/rdgC97grqCoxkp4Giy6aqPnv4BsX8DJlRGn9L5dMMlVYfMuGAHF4OIHHDNU8Llqngu/l7fEuiNldXHsviVvLi8uKk/M0AmyPkfbU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6763e643-f244-48ad-28ba-08d58db48be0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0869B0112E1D3D31B2DC1C9EFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(101931422205132)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(39380400002)(396003)(376002)(189003)(199004)(3846002)(6116002)(186003)(1076002)(53936002)(97736004)(26005)(86612001)(105586002)(2900100001)(575784001)(86362001)(66066001)(6512007)(81156014)(81166006)(68736007)(102836004)(8676002)(72206003)(966005)(4326008)(36756003)(6506007)(478600001)(3660700001)(316002)(8936002)(54906003)(14454004)(5660300001)(110136005)(76176011)(2906002)(6666003)(6486002)(2950100002)(25786009)(8666007)(6306002)(10090500001)(6436002)(99286004)(107886003)(10290500003)(106356001)(22452003)(2501003)(7736002)(305945005)(5250100002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0AG5S2GPJKsEYpUO6UK+FDIlYELbM/P7F8HgLmxvWpiE23R1wBa7jYpBtfpssEoH4L8TJur+IAuc1oy0kjywodwKA8qtCOK/Ht56/ekmHvBTEov6sgP74B+UMrIIWgda7qkomPa28t6KqbRXELRStIvuQzQ2pfPC4FhbgdweJQMoIghEQ1VrR5FN9XlaClFTqQXh8p1pQubJJ7rZk404iuFSRnXPEcR0mFjvbvTTlG4BhWdTRpuEewJNwYR+Up3m5JEQDur07PMCrV5aTASyfKBkF8mt8wQPIy7MWdattFoJqd8WL+XdA/4tgzztp63g3i7Lf2DJjevrzPSVLlXW5A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6763e643-f244-48ad-28ba-08d58db48be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:40.4269
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
index ccce3ef5cd86..9c437eaf7c21 100644
--- a/arch/powerpc/include/uapi/asm/siginfo.h
+++ b/arch/powerpc/include/uapi/asm/siginfo.h
@@ -17,4 +17,19 @@
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
index 0dc43f9932cf..6cc0280a8ae0 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -769,7 +769,7 @@ void unknown_exception(struct pt_regs *regs)
 	printk("Bad trap at PC: %lx, SR: %lx, vector=3D%lx\n",
 	       regs->nip, regs->msr, regs->trap);
=20
-	_exception(SIGTRAP, regs, 0, 0);
+	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
=20
 	exception_exit(prev_state);
 }
@@ -791,7 +791,7 @@ void instruction_breakpoint_exception(struct pt_regs *r=
egs)
=20
 void RunModeException(struct pt_regs *regs)
 {
-	_exception(SIGTRAP, regs, 0, 0);
+	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
 }
=20
 void __kprobes single_step_exception(struct pt_regs *regs)
@@ -826,7 +826,7 @@ static void emulate_single_step(struct pt_regs *regs)
=20
 static inline int __parse_fpscr(unsigned long fpscr)
 {
-	int ret =3D 0;
+	int ret =3D FPE_FIXME;
=20
 	/* Invalid operation */
 	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
@@ -1742,7 +1742,7 @@ void SPEFloatingPointException(struct pt_regs *regs)
 	extern int do_spe_mathemu(struct pt_regs *regs);
 	unsigned long spefscr;
 	int fpexc_mode;
-	int code =3D 0;
+	int code =3D FPE_FIXME;
 	int err;
=20
 	flush_spe_to_thread(current);
@@ -1811,7 +1811,7 @@ void SPEFloatingPointRoundException(struct pt_regs *r=
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
