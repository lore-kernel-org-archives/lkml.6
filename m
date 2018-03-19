Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478341-2-14235400797281210537
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
    t=1521478340; b=GhHLakW0vVtZTM1k+GuLDPamkmkv6dGvM8LZjdmCdYUg0En
    fvAge2z9gdds1te1PNtS2/fXn8l0JCn+Dn0KF/E/KcV74uv65arcReFKHFU7UjF5
    jSxrgKG02Vxu8q6HY8pXBsSAfIwgWIyN0/bVrf6zuNLYt1veYgta/D6n8OCsXI7e
    fAUVP0S5RrFtb2Dt1PPCF7MihgsJ1GPfFi9Rp75GDjKQAHy7vCAsSxUEBuZrmuzY
    q4ByENaznoO/1fu/0HuCxRXIrr/J05srSufe9el6H2iRHvKLp+Xe37KjQqm+WZ5q
    QM1AuisBFgPhp0OxWtt3GNWYj6CIrwzMTobNW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478340; bh=YECdQ4
    TSWBbadiF4qyR7Cw5DdppgwGRLDQnFB6iuvHU=; b=YHXc1avnqAMLmsCE2kugDb
    X+0LQ1VUZUu6pHvkJJjPmgNkZu0x1AKxoeSDdG8EipcOtCuk8mGdYYJuEwRMqHKA
    jap9FO7uBr2bvlsXpeCuPs5JWdcu42/YZR7CqhLuZAdMTAj4F0vjWw4gR2m8MaQD
    yQJQ4vptcS3NiZLDOBsWCGheyonwU03yC2RB5ZKJzthOXVOCgwgWf+w9bACdvSpe
    niwRFIEaGGoH14nxQjqP05VMv2xT+svyk2ZWoZWyWrEQ1NwldCT+i1yQIrC5OY1x
    mhoFO0z7+gWwGnmV9mcGXuqPcwjCOSH/Pcmn1jmrS7lMA1betS1hJdqN3cp3Z6uw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dhzun0ej x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdefudehnecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dhzun0ej x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdefudehnecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967521AbeCSQwS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:52:18 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:23560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935135AbeCSQLr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:47 -0400
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
Subject: [PATCH AUTOSEL for 4.4 166/167] signal/powerpc: Document conflicts
 with SI_USER and SIGFPE and SIGTRAP
Thread-Topic: [PATCH AUTOSEL for 4.4 166/167] signal/powerpc: Document
 conflicts with SI_USER and SIGFPE and SIGTRAP
Thread-Index: AQHTv5yS/4jHJpjoKUSRENd3aaUZ0Q==
Date: Mon, 19 Mar 2018 16:08:52 +0000
Message-ID: <20180319160513.16384-166-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:BoVQ7UmXoG/xRuyP18gZsxik8b8SiOqe7gCJT0JWVwhmpEdzZ0BMxHr6AkKB80x2VQ3cgYlNAO12fDwlMgae6eebzkBuPnlZuvWZnKozgv4fH2njPzkDo+sXAm8KyOalZEpKC8j020N/uBZBFx+7BQuxtJmr5Nncr/uW7pHgPgatv/uMpYf4znkR232Byq3IPi3uA5udtAzABue+nlgTFWXo5I39IZY7gPy2Yr7JJU54xNRppJFDD29HLdY+KJyo;20:FCbLX7z58hZ7HnLuXxwEk5f5LdSQaDDRtBq00BYRJA1gOuNTJhfaQjgXaji8FKgHoy+8udcGb8/meKNltjUpVgY70Km220ZGJu3mYhUe9XlttZv4VwRN4h/ULdZO/APi4YggQmP4mZp163wnrDMp6JvU7qbKo3KOtWo8IeQxia4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c159c03c-ecd3-408f-cf6e-08d58db412a0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09842662C6BAA6A0DC2D3035FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(101931422205132)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(6306002)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(102836004)(110136005)(2906002)(107886003)(86362001)(575784001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(966005)(3846002)(66066001)(36756003)(97736004)(6116002)(8666007)(6486002)(25786009)(6666003)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qLkV/j2PlJbN3hu3/2/D/Qbxf7ntpAUrjBSqBWGtLjC2SbUfx5FqKXyqfZ/GF+RFhkCqy/r1ZmdredmDusBRWEaO83YFayEFprJAA442M66VyzwTXt/uul/XlNyctwh+R1Fab1EdxapmSRvemcnbnr8cHlq8UViOyEU5MGG2j1U738gOpKJySiEBdzRvtV6wnt8QhmzyuWVRr+TSDL9ZniuQ3qXD16XakQO/Bo7bOLj+g4Yj5KcOEEbGOwy8IYjaDcHt1zlvDpkSzXnX2ZmjNEFdvqU00pudpfkNBBY94/FVOa3cEOxqio3hE+TykwZu7plTU1tIyJooyF516B8VEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c159c03c-ecd3-408f-cf6e-08d58db412a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:52.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index e4dcb0a43e3f..9ac9dfa6f796 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -771,7 +771,7 @@ void unknown_exception(struct pt_regs *regs)
 	printk("Bad trap at PC: %lx, SR: %lx, vector=3D%lx\n",
 	       regs->nip, regs->msr, regs->trap);
=20
-	_exception(SIGTRAP, regs, 0, 0);
+	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
=20
 	exception_exit(prev_state);
 }
@@ -793,7 +793,7 @@ void instruction_breakpoint_exception(struct pt_regs *r=
egs)
=20
 void RunModeException(struct pt_regs *regs)
 {
-	_exception(SIGTRAP, regs, 0, 0);
+	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
 }
=20
 void __kprobes single_step_exception(struct pt_regs *regs)
@@ -828,7 +828,7 @@ static void emulate_single_step(struct pt_regs *regs)
=20
 static inline int __parse_fpscr(unsigned long fpscr)
 {
-	int ret =3D 0;
+	int ret =3D FPE_FIXME;
=20
 	/* Invalid operation */
 	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
@@ -1764,7 +1764,7 @@ void SPEFloatingPointException(struct pt_regs *regs)
 	extern int do_spe_mathemu(struct pt_regs *regs);
 	unsigned long spefscr;
 	int fpexc_mode;
-	int code =3D 0;
+	int code =3D FPE_FIXME;
 	int err;
=20
 	flush_spe_to_thread(current);
@@ -1833,7 +1833,7 @@ void SPEFloatingPointRoundException(struct pt_regs *r=
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
