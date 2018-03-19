Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481078-2-12473020296420874629
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
    t=1521481078; b=SMwLH1OHobmHjIdNXLhY3zMaiSdvV6+zPZZLFEyHVA08X/u
    Wj8mt3/3Kx6TDGL6efGMZaUUCEZgkEoL4Z4tSs1OEPFPj/Z3aPI5WAxy0nTDDKTA
    Inlj+BOXk4LAznJeEZ+TUdVU0GLpM6FL9Qe8CJsNAN6GN5mJ4/xXC9SAhDMQefGF
    awVRfpBZLhVK+LLTocL0D7gYs6vi+ojII5jkWi4kvG+U7/cqChZC9APnjVmbfK8B
    a4Sd/aLHYLLo1tk3/xCUEkJJmMkCKwgBVSqFE4KOiedyeR4oVzgYqZt46Xcb0LPN
    rsnsoS3NwgW7L4V89hzhuiBSYTN+ULrPCZume2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481078; bh=sf6NNe
    k+vVyMBS1jMlefAiE3gQE+lvGm7GUctHmXceI=; b=WfS8rdUj9M164/XO6zU0qM
    zC0a/b0SqnLaObTrJ40pcL2r/NVMBjmkBhEqqzzgE5Kt3MHC2s8/Pfl18k5uXkIA
    nJUfUo4NGqIELqiviZbCa9aXIdY3+DNip0LC7bW5ODNIClI4dtN6TTZ4F/1bnNiK
    ZgD15bG4RIT0aUG5rS2XWy4KkDe4DKDxSHvS23oXRak3U47LjRtYm9zlnphFRBhu
    U1xjAH8J6nW6P9hGtwRnXv0KuMGmLPW4vxjXoLRe9Wuscee8kqwO/DHkNn67LTTW
    1Y6veWmzWXyO9CFkGFKErW7DHUNDthnz3FDvsbqqM8pPEM9juV95qXT+IWCND+cg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O0BSMcG1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtfedtieenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O0BSMcG1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtfedtieenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967507AbeCSRhP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:37:15 -0400
Received: from mail-sn1nam02on0103.outbound.protection.outlook.com ([104.47.36.103]:60917
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965973AbeCSQGn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:43 -0400
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
Subject: [PATCH AUTOSEL for 4.9 279/281] signal/powerpc: Document conflicts
 with SI_USER and SIGFPE and SIGTRAP
Thread-Topic: [PATCH AUTOSEL for 4.9 279/281] signal/powerpc: Document
 conflicts with SI_USER and SIGFPE and SIGTRAP
Thread-Index: AQHTv5vQDL36gzrybkG1qKWZGFmRsQ==
Date: Mon, 19 Mar 2018 16:03:26 +0000
Message-ID: <20180319155742.13731-279-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:D5hC2hLs4ihv5tss0q7g/ZDHj8eh25Rw0n4eQ9Xo2eChbCd2J3t3rOE8RSYFYJAZlRhHsFIq1pewlllyXp7OU8LO5YLxH1AvNkM4EA3jz0j/00E4Ijr/R4BMHb68gwyPqFea/3l6LD1GFEqAcfrQaWP1TiZ1gMk5qpzH6UZCXL2Cqbcaw3vZyteizuAJE3UCOvM6Z200hg8xT5X3kp6vbHGkR9O6eEGSo9VWV9AYmBFTfC5X3kVSphR6AX7D1GIs;20:qC+6GqJXV6KcO7IJq7K9pCr9KRYtwKnntbivaKrbu/NCi5QSmVQYFLER+YvMj49yuBWScxjiCepx4eOyOQfl/lA4aubcPc64hJnHoPB1i+ofO0hUBMQFTd7DE96GBXxQeXWsiwdXJOIkP6yRlcMYNc7W7pVqDC0kcRLNENpGgMQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1bac99cd-1e70-45d0-69ab-08d58db364e4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072882C82EA92A2E15ADF0F3FBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(101931422205132)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(575784001)(478600001)(53936002)(107886003)(966005)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(8666007)(6512007)(6116002)(6486002)(6306002)(106356001)(3846002)(22452003)(3660700001)(186003)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jl265l1mymNmKWiFw2LJ12n3YBeUS6iYGDmMwupRuluiBwJ0/aKSzFD8cVSeBc4qH7CTRDQnNv6yHwY1OkBLJ6mDVbRDkGX+DRkemi/oQw9bvVVJ5xi/3c6ipYaRVxDv05s3/EJcCs9RG/NFFBoNsHkPCL90OvO3g/GBGtfB1iTKs4PTZJwiCoDebcDAUx87/FPXqcKG+PtAjyTZl2xVFm+YJpljCASMRQrPSZSxJ2geHeaEotdh8VlWOlK2h3Gcvkm3/OBzSvS9W0v3ZDAoLIBjRyJCMrrDFZsbI/OcqmcOdAV8ESYSZvMPRnwJSKBILJLZOZRvxcK7mAsR2Ta+Hw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bac99cd-1e70-45d0-69ab-08d58db364e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:26.5274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
index 43021f8e47a6..7e5b0bbbe4c8 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -793,7 +793,7 @@ void unknown_exception(struct pt_regs *regs)
 	printk("Bad trap at PC: %lx, SR: %lx, vector=3D%lx\n",
 	       regs->nip, regs->msr, regs->trap);
=20
-	_exception(SIGTRAP, regs, 0, 0);
+	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
=20
 	exception_exit(prev_state);
 }
@@ -815,7 +815,7 @@ void instruction_breakpoint_exception(struct pt_regs *r=
egs)
=20
 void RunModeException(struct pt_regs *regs)
 {
-	_exception(SIGTRAP, regs, 0, 0);
+	_exception(SIGTRAP, regs, TRAP_FIXME, 0);
 }
=20
 void single_step_exception(struct pt_regs *regs)
@@ -851,7 +851,7 @@ static void emulate_single_step(struct pt_regs *regs)
=20
 static inline int __parse_fpscr(unsigned long fpscr)
 {
-	int ret =3D 0;
+	int ret =3D FPE_FIXME;
=20
 	/* Invalid operation */
 	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
@@ -1855,7 +1855,7 @@ void SPEFloatingPointException(struct pt_regs *regs)
 	extern int do_spe_mathemu(struct pt_regs *regs);
 	unsigned long spefscr;
 	int fpexc_mode;
-	int code =3D 0;
+	int code =3D FPE_FIXME;
 	int err;
=20
 	flush_spe_to_thread(current);
@@ -1924,7 +1924,7 @@ void SPEFloatingPointRoundException(struct pt_regs *r=
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
