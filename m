Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487908-2-14545405463304006260
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
    t=1520487907; b=gzR62BItnNksxLXyFgFw8tSdSCBMwAoaufVNKjqF1yebs15
    bPRdab9J7Zml926sMxg7JVSoBBLA//VmoxfczS722eqy4j0ZTPKtrXwyr1S35SA7
    Cn/K6PMHO40d2A+DJZEAt+8gFOGZvCOuM+CF1BQFsd525/TyrSEJmfjnXnZ4mdOW
    WWqh79SB0txX/OLnEMMe9li3c82oi1QXZSFXUiv0rlv++YIt1/p4vY3Sw40mru8F
    ngNN/9zUhtczjD0Hm/JUSJQ0c7UjJB6eAIE/+qoDm8X2bkmsjElT5r+wgbUA+5rY
    +14v/6iSokD2NqxduvDKYM4KoWbmfXkUVllD3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487907; bh=RK9DSG
    14F0H7E/f9RA1ZRdNkvAYex6Bo3kv6YZU74e8=; b=RTlSmNkfzVDkOlQqcrutk3
    A4u+OxRhF59nfhLin9CaDg1v3nYTmXILUhxt9784TS+rLdLmxVAW0B2EEiSIvTMm
    vDzhO4isrgWr3rjKABcbAcm+URrTAOvOXZLEIghK5INOc7amtT57TUlyFPa4zvzo
    hzyQdwXnBQp/oV2c+RzXCcJgPoCwK+kmYnxJkFZQBpT+BOLxtAv4dCYzZGYRLEh0
    jW7ntH+NEOlpEvoPdBb7I36s39gggkwKq4Q6DVrPImNvHJBEqiyM3ddGS6vzAVQp
    Erqe3ZADvbbimvoovGtJILPJp2Pl9CvhgJ0mnGir7+5PxzYo9eu1NX76YlKpgYkA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xfo2tdWR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xfo2tdWR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966211AbeCHFox (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:44:53 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966182AbeCHFFP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:15 -0500
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
Subject: [PATCH AUTOSEL for 4.4 007/101] kprobes/x86: Fix kprobe-booster not
 to boost far call instructions
Thread-Topic: [PATCH AUTOSEL for 4.4 007/101] kprobes/x86: Fix kprobe-booster
 not to boost far call instructions
Thread-Index: AQHTtpp5jVWYNFSCTk2E+F1HhrvHig==
Date: Thu, 8 Mar 2018 05:01:11 +0000
Message-ID: <20180308050023.8548-7-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:OHamhND9+xm1zmrv31SUVf24icvtGFW49kJdKH2sPX8pF035DXA2PUc6MI8L0rrg4uhgtAGn5+Z5DTFrxEf3Sj7zPuqUHihNUsY7WF4Boc+xg7sIzoXb7ijbai8WZTErWTOLRSEvzEFYds3tujhRpvuc6b0GgQU4JzZhaiQHu0NIaoRCgcTEVtQEqEqLtAp/KJINV1MzSfUTIXOpACbfiWnKtWWWz5ed8Z0PegZq2AIFc+NVoGwWv3k9kr9mM+F9;20:uNz+aueYaZ/uhQ8cB6bgQvlelyoACtdhbRDXs3H8iiPB32SOVlra/AvPkWuHFt6j6Xd8VsNhEWAYbqtGCcxL+lpeqdT8dspUL9pe8Mxu+wLcPEjSz6XcIXLalinjlQkhqUV/ceOCWtl9EDkkYQPboWcKvE5ypSDzndOSAplcPSw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20b46150-c380-4c7c-47a1-08d584b22863
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981245E08D0E8F4F7040B5AFBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(7416002)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(6666003)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(6306002)(107886003)(25786009)(8936002)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(575784001)(39060400002)(6116002)(81166006)(99286004)(72206003)(966005)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: vov1J/PphpqzvN5bEUCc3E3B7Z2JK8Hey1P0/NNrn+Jp5tXFJTnJOLm2atDgPYWk8hut79gRQ/5yQj3/Uzip+vxfbS4WVIwtj9RAKS/laxHJiBXZJh1K9OOOK55sbWfSKau/xBufXUkeJo0/brYEuv8qHG6gs/32CQSiJRFrL5kRDX5rPnKuWN2W5AfrqjsNk74oly9WbZyRg/5J73XFTJl95aC4m/0HCVp7Rn7oHXBCHSOpa4vPW1Oe8g3hKA8M02DYtfB6CITwCkiOloY2Eh4+w66IlbvOt87MloC86xwLC4xA8o/8DhKeUZoj47FTXjgXePSeKBermYZyrKb5eA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b46150-c380-4c7c-47a1-08d584b22863
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:11.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
index 99d293ea2b49..5d11d01f75de 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -196,6 +196,8 @@ int can_boost(kprobe_opcode_t *opcodes, void *addr)
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
