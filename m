Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496295-2-11841878199224052110
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
    t=1521496294; b=kZJ67pPWTXn0ulP1oEBdLX5TwSBzG0CalpLn7/dFJ2MHpu9
    p0M/VPwgnP60nMrCx5QI98w49be2FKQhxFyqsME6VRFTLoT3cKcb/p09PfKcz1mM
    PKlhBIWjrrA8M3Z7iCvLG9G07LXa8h5O3+hbeXotZXS2yzJUV66L0D5JGO3aGbye
    eTsfJf3UocrVZA9qGgxu/lQZ28TaDdrNWx6Rqga5YmInVaymKpXoPUAoM5EgUDj4
    /Rzk7+3VJtrJUwHQ5FsY+8cADzoLdFooqGrCfRyDHHurfpwa9JWwfQkuvUdFN6G0
    xMPK+gUsfX37XqoamWALDIQKFL3dMpGbJQNt9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496294; bh=EfvriC
    eqJJOpvyLlfcMx3nZTr14RoPpCxa0HZlT39T0=; b=dskY5azVo7zEoWESjbB85h
    D3BAcUstPszWqSRhAhmfau3RGb4s9+OMYtq8c6KMPxAQKtWt4xGymtHnwwcXQurY
    p0CiBSR2RaTAsMyVZN/7hZVAPe9ui5ouIw3fMseOJ+EVKi4Um8R8mryLSPhzXnyw
    KmKd5OeVYJ7kCWlX1eDHQ+cEQ8lZNeGpBhkRS1zK7yFRmiyMGOkIyOvTPa+Veh13
    Ay3be9xXmVgHPIH/q1J9BNE5EcVOCUyamvT9Ed3nOehQC4qpmBn4ynupHCSxzOxW
    R3ahw825z/PdPyz+vl806qhb6CTrPn1SZ+WIAUF+ZBXG3X9lZZ7JLKgT9aCo0mSg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LRw3IaqF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpieegrdhssgenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtudektdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LRw3IaqF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpieegrdhssgenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtudektdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965030AbeCSVvA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:51:00 -0400
Received: from mail-co1nam03on0117.outbound.protection.outlook.com ([104.47.40.117]:30064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964868AbeCSP57 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:57:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Josh Poimboeuf <jpoimboe@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlad Yasevich <vyasevich@gmail.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 005/281] x86/asm: Don't use RBP as a temporary
 register in csum_partial_copy_generic()
Thread-Topic: [PATCH AUTOSEL for 4.9 005/281] x86/asm: Don't use RBP as a
 temporary register in csum_partial_copy_generic()
Thread-Index: AQHTv5sKjQIotZEP+0SYyIoaGkWIEQ==
Date: Mon, 19 Mar 2018 15:57:54 +0000
Message-ID: <20180319155742.13731-5-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:hprdSMCdVZ73mSzv2kVDFZnXUsbjQtlVIE74aUkS9qPiNgBGGF35u4aqRV1uRm37Ot/SAObrze45QI8rmtY+j0kAUIAbNeSdqfvu12z4MQc1MOg8y4hh1F4wOZUoM3AQpTsLXKJk/v0xqyqeFAAXpL0c2MnzcFVIY6lub1dbnnKKy3egR4V+L8LdpzgfMfraJkFajNIn58jt79PsvScS45h6SlCH8udBJzi/0SH93NI+uA/QOyEKYZsmP9YoyzxT;20:RJ4ITic+Ed2x1lQX8duZa4S5oQ1q30p2hZt5r+OQb2kUTblmludh1TupvW6KB6eujOqXhBJ9DgyhQVUAcBJHEBrDY+to8ToiQ3xV94zIIRFAOKaTp43BpKY+AMECp/BKj6aPMSfXpN9CD1VIbo9tDjw47gF2K/8hR9YV8t+S4Gk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b56844b-2bd2-442b-07c2-08d58db22d8a
x-microsoft-antispam: UriScan:(215639381216008);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933710A91E33A19FE84DF9CFBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(215639381216008)(89211679590171)(9452136761055)(85827821059158)(788757137089)(211936372134217)(42068640409301)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(7416002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(966005)(2900100001)(25786009)(478600001)(5250100002)(26005)(39060400002)(6486002)(6436002)(6306002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: IAd1khrmgIJdQmqhPbjXW24JbMZfhHDHSjoP+wv4Eue9br3RR2QY7gi66s0mw0nzcv/VxDiPLtCodeVjdXUvxBOKL5/mN2Y1EEoRnKmr00bM9iWnDBdHknqifBvOARmtEDeWjbr8SWQXXqYHlAfjtuuP/ACOoIZXfTTCsHRf1CYq4Ev5eAP9VEflZImqMm5VOZoq07DM+/vBf3MBJ/NIPY/UOzid7rk1+xPcBJ+eFutqNt/3j4W3LfBhXqfGAK8QoWsh3Lso8jdtbgz5Hd4+PE+wYJCqY5Ryv2phS2FCUGL35RCZ57XUAwUvHewAMpevTQzOYm1Jf9Q6wuhE6LiS8w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b56844b-2bd2-442b-07c2-08d58db22d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:57:54.8697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit 42fc6c6cb1662ba2fa727dd01c9473c63be4e3b6 ]

Andrey Konovalov reported the following warning while fuzzing the kernel
with syzkaller:

  WARNING: kernel stack regs at ffff8800686869f8 in a.out:4933 has bad 'bp'=
 value c3fc855a10167ec0

The unwinder dump revealed that RBP had a bad value when an interrupt
occurred in csum_partial_copy_generic().

That function saves RBP on the stack and then overwrites it, using it as
a scratch register.  That's problematic because it breaks stack traces
if an interrupt occurs in the middle of the function.

Replace the usage of RBP with another callee-saved register (R15) so
stack traces are no longer affected.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlad Yasevich <vyasevich@gmail.com>
Cc: linux-sctp@vger.kernel.org
Cc: netdev <netdev@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>
Link: http://lkml.kernel.org/r/4b03a961efda5ec9bfe46b7b9c9ad72d1efad343.149=
3909486.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/lib/csum-copy_64.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
index 7e48807b2fa1..45a53dfe1859 100644
--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -55,7 +55,7 @@ ENTRY(csum_partial_copy_generic)
 	movq  %r12, 3*8(%rsp)
 	movq  %r14, 4*8(%rsp)
 	movq  %r13, 5*8(%rsp)
-	movq  %rbp, 6*8(%rsp)
+	movq  %r15, 6*8(%rsp)
=20
 	movq  %r8, (%rsp)
 	movq  %r9, 1*8(%rsp)
@@ -74,7 +74,7 @@ ENTRY(csum_partial_copy_generic)
 	/* main loop. clear in 64 byte blocks */
 	/* r9: zero, r8: temp2, rbx: temp1, rax: sum, rcx: saved length */
 	/* r11:	temp3, rdx: temp4, r12 loopcnt */
-	/* r10:	temp5, rbp: temp6, r14 temp7, r13 temp8 */
+	/* r10:	temp5, r15: temp6, r14 temp7, r13 temp8 */
 	.p2align 4
 .Lloop:
 	source
@@ -89,7 +89,7 @@ ENTRY(csum_partial_copy_generic)
 	source
 	movq  32(%rdi), %r10
 	source
-	movq  40(%rdi), %rbp
+	movq  40(%rdi), %r15
 	source
 	movq  48(%rdi), %r14
 	source
@@ -103,7 +103,7 @@ ENTRY(csum_partial_copy_generic)
 	adcq  %r11, %rax
 	adcq  %rdx, %rax
 	adcq  %r10, %rax
-	adcq  %rbp, %rax
+	adcq  %r15, %rax
 	adcq  %r14, %rax
 	adcq  %r13, %rax
=20
@@ -121,7 +121,7 @@ ENTRY(csum_partial_copy_generic)
 	dest
 	movq %r10, 32(%rsi)
 	dest
-	movq %rbp, 40(%rsi)
+	movq %r15, 40(%rsi)
 	dest
 	movq %r14, 48(%rsi)
 	dest
@@ -203,7 +203,7 @@ ENTRY(csum_partial_copy_generic)
 	movq 3*8(%rsp), %r12
 	movq 4*8(%rsp), %r14
 	movq 5*8(%rsp), %r13
-	movq 6*8(%rsp), %rbp
+	movq 6*8(%rsp), %r15
 	addq $7*8, %rsp
 	ret
=20
--=20
2.14.1
