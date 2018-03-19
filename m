Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496236-2-5673352343237565240
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
    t=1521496235; b=JV8fAucYyDI1Wsprj0tnqTkDEQfPu1J6fy1imWPq6+n0sXv
    Oe0uGDDNSb+TYNhDpAQRGl3VHClx/zkUiGUElmoDF7x3rpwT/vMm1+xRbGasgLkt
    tGi4F2EDoNaaypl9ozQFGU/nC507nLIKOsA/aoMqNhMb1yFjunK0zCQERyEMu52Y
    lLON0JTVIG7FF0QQk9vRKJRL1z46IgVgffz+T0qOwOfvGAMzX8WNWkiMuzz73cq0
    Jr0dKIzKaUkaKV4KuLKKpYx7hJUojtk5bl+Z3LHSbPQJgZGs8Aa89fsFe5OqJmME
    Z/iK72gPCtTnZiU+2UZwJhArvc7AyI1iM3BX7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496235; bh=Vo7VVl
    itOJLMl5EVnlXxp+Ij4c94YS5g4giOFlQmidM=; b=Y9tImI5A3MtGFhpuc7xdBw
    XjtADxxAtzre5PoQlstO/tPwDIpqtvMCg4h6CgTUw9rUMMCCOd8ycrW+2ki9DfWW
    l8XofEtiKTKXMEqlog2Iu1J1kUwR/IgutBfIs4+ihOgd3qgGPSpMYiS52JqWwDPB
    nt+mC1qdu5eNRTCYPl8aIaeF2b8+uDYCOBKeuIfnYy+6MEXq8iZKI+YwQtxtXi5Z
    D6NfV7u2tBEuE09M4oEQx9+YwrDTPLkDlRYh+qTD7L6dFlk/fp/J/oYtezyfN+Yh
    eSYjU0fejyvARUTnRXfCuA/9yrfZtrQ5dKr4oFJlRLoSRZl+qgg6BESmLlsL5/pw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cfVwBLtk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeelvddunecuvehluhhsthgvrhfuihiivgepudeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cfVwBLtk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeelvddunecuvehluhhsthgvrhfuihiivgepudeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbeCSVub (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:50:31 -0400
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:13408
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964892AbeCSP6G (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Matthias Kaehlcke <mka@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Davidson <md@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 006/281] x86/mm/kaslr: Use the _ASM_MUL macro
 for multiplication to work around Clang incompatibility
Thread-Topic: [PATCH AUTOSEL for 4.9 006/281] x86/mm/kaslr: Use the _ASM_MUL
 macro for multiplication to work around Clang incompatibility
Thread-Index: AQHTv5sL61Oujlcsc0uVTZrWFyRtQg==
Date: Mon, 19 Mar 2018 15:57:56 +0000
Message-ID: <20180319155742.13731-6-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:6zI+BPHlCU4Qrm06KTdYvi9eoxT3bHiqonYZy2KRMOg0hXdiQOEGT6TA6612j/LDemB3YcwykGoiRzqFXZH5OpPCekTWvUUIWmPXy0wl1X5UQvh5sD5YOMvuMq/MoUzjA93gt+YquU7i1+jpzbeo9GqYRm02o8wO/a6DUEINghZ5AU1md9Jl2PcCJ8E931TsBVJC/cmHXApzMSfDEHXKK79dhHuUnY01vobvjRPnNvuo/ZYFqTl87WyI+K7vjmQm;20:9A7em3qIA/7yVPDmCckmaoC/QOPk9za7d0FioLFnwp70DuQtYxDTV+Bd+LOaQwiAoBKxUuptrFW7s2i2XqLp5Rp6nPx7ezoqLrBH4LneZHk4j1HFutvk7KGq2kQgA3vXAr7feGJ+IhQleKPwh+aRXVNQnWFoC2/e9GvOffv44j0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd78b7ff-979c-4e50-5438-08d58db22e8b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933A738CF657042BA9FF000FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(7416002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(966005)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(6306002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: CEvkucKM7d6j38jOC5822KikB0JiVJf3oxRWqAp90526Bnt1jfFY4mEy7RCMlbNKurdWIEA2CRuPuUEJSq0b7ZJ6kfpD1hZ0vjjlWZP4X8xWRYaUgODdElzmhDOdYf4ktNzAgnv0VEy/R/h+eVRPwe5KDDZprJ8NaCvgoMwQr8ksFVNnw6NxWf6XgxDrTydYNtMUH+sEcDbpstvnbSmDcQLy56KQ4IBMlCMZ099fsGLpc/w4n1lhwWNmXJb3kRrXE4YPjS5XmsXE2ueLT3/XrGsIaaNsKVOj6+DEJg5V9dzVNMGKOUHLv0q6M7UvhC9Fs/QucXPqo3M5rY4GaGnzeQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd78b7ff-979c-4e50-5438-08d58db22e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:57:56.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Kaehlcke <mka@chromium.org>

[ Upstream commit 121843eb02a6e2fa30aefab64bfe183c97230c75 ]

The constraint "rm" allows the compiler to put mix_const into memory.
When the input operand is a memory location then MUL needs an operand
size suffix, since Clang can't infer the multiplication width from the
operand.

Add and use the _ASM_MUL macro which determines the operand size and
resolves to the NUL instruction with the corresponding suffix.

This fixes the following error when building with clang:

  CC      arch/x86/lib/kaslr.o
  /tmp/kaslr-dfe1ad.s: Assembler messages:
  /tmp/kaslr-dfe1ad.s:182: Error: no instruction mnemonic suffix given and =
no register operands; can't size instruction

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Davidson <md@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170501224741.133938-1-mka@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/include/asm/asm.h | 1 +
 arch/x86/lib/kaslr.c       | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index f35f246a26bf..8d8c24f3a963 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -34,6 +34,7 @@
 #define _ASM_ADD	__ASM_SIZE(add)
 #define _ASM_SUB	__ASM_SIZE(sub)
 #define _ASM_XADD	__ASM_SIZE(xadd)
+#define _ASM_MUL	__ASM_SIZE(mul)
=20
 #define _ASM_AX		__ASM_REG(ax)
 #define _ASM_BX		__ASM_REG(bx)
diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index 121f59c6ee54..0c7fe444dcdd 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -5,6 +5,7 @@
  * kernel starts. This file is included in the compressed kernel and
  * normally linked in the regular.
  */
+#include <asm/asm.h>
 #include <asm/kaslr.h>
 #include <asm/msr.h>
 #include <asm/archrandom.h>
@@ -79,7 +80,7 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	}
=20
 	/* Circular multiply for better bit diffusion */
-	asm("mul %3"
+	asm(_ASM_MUL "%3"
 	    : "=3Da" (random), "=3Dd" (raw)
 	    : "a" (random), "rm" (mix_const));
 	random +=3D raw;
--=20
2.14.1
