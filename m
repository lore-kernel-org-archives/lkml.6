Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481032-2-10397275682210372287
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
    t=1521481032; b=C/L+hfTRbAZTPpNfXwG44wNh0VWJ9F7KgQnmUU9DFhBOS6V
    umjqmrt1NRDhQ80nOjkBtjWlCfNMhOMtxGhlbg+gGKsKCpxo/Y/b3rzELbzf0/ct
    idbKOYwWyk88Mh5SWecCzYJX3YhMZQDQFMFWZ7YskRbkln41+7SBkuJ/RXvI1V/7
    8jB5GdtoMgLnc6WvdaMiWnrfXDR2Bdev/IiY6rLx3QiPVdSyZj4sPhS+H5w5gTDU
    ufLxj/EVR3NvsLxTZV9n25MauCSRg/ctYDWIMXukocYFH9TXQ3nLCUE3B95HiWiU
    mWf5j7p7QYZtjsAgOOcEDQLulXcTKlHgi0WvxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481032; bh=EfvriC
    eqJJOpvyLlfcMx3nZTr14RoPpCxa0HZlT39T0=; b=s5z+h2mXY3wwGB07UCw+4C
    08OHYq1CXe/ofrZ/uTVPA9sE3Hle623S6mY/PaQCYPiAkq91pI6JHK0sT1gb+Iul
    4dnxwuk/tG+muaRNBr9NsPlLTp5es4zsHCJOyxKA/2etIXzaHXU8b/6G5bQveIF9
    zVrITU1rZMJ525ckr+zCTd9/BL5XXzbo3tVRoERKL4rnK7v4SG+1A//5UFJKWVgm
    bxTZ36xZtbZHScYR3UCynFZezpaakJei9XoumlgthGXS7FFVbdEyjKy1WysoWM2L
    2d9IG9WR3A6GJP3aRMEGikk1dtBGIzSwhzFsVGIev1rAG1Vw3J8GptNEiRzNhCNQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S1jFJe9W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpieegrdhssgenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtudektdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S1jFJe9W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpieegrdhssgenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtudektdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966056AbeCSRhI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:37:08 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:31931
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965980AbeCSQGo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:44 -0400
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
Subject: [PATCH AUTOSEL for 4.4 004/167] x86/asm: Don't use RBP as a temporary
 register in csum_partial_copy_generic()
Thread-Topic: [PATCH AUTOSEL for 4.4 004/167] x86/asm: Don't use RBP as a
 temporary register in csum_partial_copy_generic()
Thread-Index: AQHTv5wXKNHIHaUiw0ykqgvjDJHxEw==
Date: Mon, 19 Mar 2018 16:05:24 +0000
Message-ID: <20180319160513.16384-4-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:Kb7lO5saU4QVYDcdez1rIhwh9fGbuivRqqXGr7ZfAkFXB9HzCMsssdooYuK9zBnNkF/AX5nOX6PXAgOvTeL2vD09hH4Q+SqArZVZGvc4p/MHJAGDvpgLnimRsJhg3yMfDqgTfaUoUY+Fy+45MXdFwBZGnw2PBIBKOeLMf5uaAwWnUY+TddiN16zSwgraIH5VZ9hFvL+JLx2jWFftbzVJdhYJeJf3WgE5ZIuqVZvfr2Ws6S4yRu8aiiYhggJGAj3e;20:9lxZn9xWdpnfVWKfldPxQd3qEr6ygQ5ijvQTyvSkwx+Bzn300Crn9bNRbfdVzlz8v3dYN0ig/9qhP1kiFgsyDE5+oU/kC8xhfC3uYwJg/EvEPbRmCsi5tH5eyLYvbzI0ofr3gtWdhcF0/pA5TCWkKfFC0xKwJZYHV94Db7/Jz7s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0eb2823-4cb7-48b9-0816-08d58db366f7
x-microsoft-antispam: UriScan:(215639381216008);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092056F61AD159E759894EAEFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(215639381216008)(89211679590171)(9452136761055)(85827821059158)(788757137089)(211936372134217)(42068640409301)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(966005)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(6306002)(8676002)(107886003)(6666003)(39060400002)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(7416002)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: haGbrXLNU8I9dLZ0Y1caV/0orcV1hvx46WbscQHgrv/tUqzXdxEUuDuSal5ZotJuxy9HoVsn3eDFZjhQQpF1HYPqhboaUeI4iHmO7bFs9YwDhXCEvQnIAkQM9PLUvQU6zENCwsAAYMfMW7hlcWNeF15SHO+n3G5ulvYK1qOuxCiNsrpTqfcTqqDO1Nslgdu2E9mBhxEo/yhMLQMDvn6Vph0OIF8vuyttREDmf8ca5dUbpYnMCeCog2iGSFJzrQw289QhMzpj5crl9oMwFzlNyA2q/An7AhJoM8X2WbYlZptwSDQhVJA4NAru4nyMrjUAyAZ0wxo7d1Xqa1VF/XQ7kA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eb2823-4cb7-48b9-0816-08d58db366f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:24.7461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
