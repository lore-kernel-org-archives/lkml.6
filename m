Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490588-2-7016700299140447691
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
    t=1520490587; b=eheP8ysh3tF0PtgeI8fN5rWmacFjQXU53KrOKnAC4H2EDWT
    7tbdamxLB4mam3hGwIs1P4p6oF0YN9b9m65dZNiSiTm4ARcTVLTv6KAjKbu2M25u
    4p2BuZ2b2ltOCF2fhvUvkvSP+TFovojPUGgl0o0EWliKsIrl2I8Zd7SUeUTq4h1/
    9j84FAp49WraM3pksmm1dyhqIBtMF8fHSrK5xoJZHHNpChNunS5OOG++OZ52c5vv
    bPYYOv8R3O+07Qb3N19beFfrmz3yg/UqtgG+Xn3qSBrlclkAzOZgdwXC1R81qb6a
    iAJo0oTabA9N9OyqaunQ6QNIbTjO53BKsJSUYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490587; bh=r5lySZ
    /JxXG4FNjWpHWfsxc5fE4eqJNOrCAUXyRvBn4=; b=YbDh+Rdx9LZvV606UjRIgl
    wTUAKAY6HSEmvtiNlBau+JHgBsYlwYWI6sywemAQCb2QoFGh2SuqJkJUJyWqBqvQ
    bh8L27kLIiD5loAKVlWJM7q2nMj2DAiYZuelps6Wj2jyHqnbcC1jQSVSR0pmApm9
    hUj4dAuPNrQ95maFD5zsDmIuRaQVE4Zfkd0vGhxKcg2A/wNRVDg+jO8ZdJNpxVv3
    Vea8+TkXuA2oiGDo1Jq6x4QZ5k/CsNS1cipxw111nE5FSQSq6Aufp+4+zelq4Bhk
    GTWIhJWFZXvfx7utzlJ/piMLfj5AC7wlFKsO7y4DPkFYjjvKq8DtcJUqjyTDzAGw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KI/THaAX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KI/THaAX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbeCHFAP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:00:15 -0500
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:7440
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751240AbeCHFAJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 013/190] kprobes/x86: Fix kprobe-booster not
 to boost far call instructions
Thread-Topic: [PATCH AUTOSEL for 4.9 013/190] kprobes/x86: Fix kprobe-booster
 not to boost far call instructions
Thread-Index: AQHTtpopqlzn8bBNoku+doSU0xoQOQ==
Date: Thu, 8 Mar 2018 04:58:55 +0000
Message-ID: <20180308045810.8041-13-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:jL7QdWY60ceNal1aFfjVLHVp08BlqC7KOlbvwuMyz8cOgihahV6bmHkqVNxJdqA0qdScxhOYZYNMZNgY/hyr/9L/ZdpsV0vGrBRF8MpBLUSCMbeT/bUNThSXl/J7spF8fgqXwYvJUtJPzrqEAEmR6phUYEmg9M5j7WmQ7gSLSbiYVAo+N7E0uuDHj0nOnGMxu1Eb1yiNnl+wdtPy7ily6kHU0tY2jNGBVyvrL5MYt7CHNB12e78fyWf0Fp//uQ7C;20:S4cD7fc/PX/ZB39FloNyxVXciIOoadMmplE1fL5F4XxuyaK+EugxtjcZtc8Yt76nm5V6DvtzYbFDxcdDHEUUIKGTJ6szHMuETUHz1LcoxshgtOreYz4S+vbFxBaa3u9lf6nR8cgSSggzSXiKeSYdVL9SsWd39c12RXPNmy3SNLQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cca70e53-fac1-4ff0-c948-08d584b1701d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920A12478A689A7BA343FBDFBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(966005)(478600001)(10290500003)(186003)(22452003)(68736007)(105586002)(2950100002)(106356001)(7416002)(102836004)(575784001)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(39060400002)(4326008)(66066001)(6512007)(6116002)(3280700002)(3846002)(86612001)(6306002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: YWdOcE0d3flqlLjY8BXpPA2Lz+hgtcMucMCfe8mkF9CFm4XuvE8GAWMJ3s/mBLg6okAzKVu2MCj3kHH1Rbef+vlhO0K+asApMZWE04mz3TZY/+xNc6VYddejacwRhkPcGup9DllcDZ9Dcb9PJroC4Ge+N+nTqnXTuV/QKJaMt3hUZfWetIGlnkhTfBWqATyuhw1TaF2UkqgvxzcDZA4MywH7r+xFVQP5J8R6/kBxRWoQkWDPoZx4DaNihlWz04aKtqiTs9soZ93jQSWV2Lf/A8YMt5P6e7mIu45YbIOMPsbF4eYlh5QhKl+6CDKcefDEyLbPV6y3vsU2gZBZhiqcyA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca70e53-fac1-4ff0-c948-08d584b1701d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:55.4657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit bd0b90676c30fe640e7ead919b3e38846ac88ab7 ]

Fix the kprobe-booster not to boost far call instruction,
because a call may store the address in the single-step
execution buffer to the stack, which should be modified
after single stepping.

Currently, this instruction will be filtered as not
boostable in resume_execution(), so this is not a
critical issue.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ye Xiaolong <xiaolong.ye@intel.com>
Link: http://lkml.kernel.org/r/149076340615.22469.14066273186134229909.stgi=
t@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/kprobes/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.=
c
index b55d07b9d530..808ee7f566f8 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -199,6 +199,8 @@ int can_boost(kprobe_opcode_t *opcodes, void *addr)
 		return (opcode !=3D 0x62 && opcode !=3D 0x67);
 	case 0x70:
 		return 0; /* can't boost conditional jump */
+	case 0x90:
+		return opcode !=3D 0x9a;	/* can't boost call far */
 	case 0xc0:
 		/* can't boost software-interruptions */
 		return (0xc1 < opcode && opcode < 0xcc) || opcode =3D=3D 0xcf;
--=20
2.14.1
