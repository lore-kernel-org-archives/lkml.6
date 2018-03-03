Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118450-2-14222388240272334307
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118450; b=S850KepDS/oOAAuKUx3quCOUQo8vgirsHogzyyaCDIr49Yd
    GSOVSotBzEWrMyGmB7+sVTJSMfH5FETZcMpBQeEUZj+Dx23BsD2E6IBr54P6lctV
    3naKt2Gu5+we4kZIBDiDCXdsxuXo67/hQ959UQZjoJLqDs8oPkvZToql42vrfqmZ
    sqoI//VkDFRefEjD02ecjPt1h759LLXm7WMDwqVGzj6J6X3WW77OhvGig0dxwNYx
    gsXO0LSqiJCGC9P6RxzFxOIBUrIsdKqaKkDCFHV1QPkJeekuSQOWjDEI7t08rQ0s
    hcyHp3WqKibVDBAj4aLSWHThsi8jZDOkadm4brA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118450; bh=x/S8aV
    6b4xZ2g9SX2IIRFqSycCyLC90T+LX2YZLwjUw=; b=GJS47x6uCszJOk0Y5cZXEO
    M4ErnuTo5zf7WxgPXaTKa1WykGXD68gFD2sHtIqgOwESnIGmibh5KUy6ZJAUTmSk
    3xm621bSq90BlpGgwuAgJgnJRJgW85HIKG6iE+tpUtpspqCWsLTggXYZoCk4XTtW
    tNaWtjgAKJMuygK9FPxldiK83455iFe4vNp4EKhIwU4jik/X5Dtek9SWbPw0NMgY
    +k386jTEKDbc1qAoYExXy8AmLtrFK0ZO8NCrRh1n2y8TauP+XY1V5cMJVj5/R+ch
    UKX/w8sXRXr+zbtItpWrG5aTxH4EJqRCKtqtUDXf+ueCcrAjPHgJ1RWC0Bwhmibw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L8SpumTZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L8SpumTZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934050AbeCCXF4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:05:56 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:62880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935149AbeCCWkN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:13 -0500
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
Subject: [PATCH AUTOSEL for 4.4 080/115] kprobes/x86: Fix kprobe-booster not
 to boost far call instructions
Thread-Topic: [PATCH AUTOSEL for 4.4 080/115] kprobes/x86: Fix kprobe-booster
 not to boost far call instructions
Thread-Index: AQHTsz9kwIs6tMkPbkqubUObXgXf6w==
Date: Sat, 3 Mar 2018 22:31:37 +0000
Message-ID: <20180303223010.27106-80-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:l/U6zq5HxOP6yzZDd/+q5K3rLmD1Ximd4F9VR7wwZ4e/kP7UhdFxGtRa074XP8qOHGtBPN+M1zjMxiUOgRgXZX/7lqjzBQFYc2CXCuy6lIEqgKKxw71Qz0nu7j6mFAU4gViJd0fe7hH7CmVMYxZS4AxnaVoXzVYpyhZUV1tbDQAocVP6Z/3SxWl77rK1u5FNroc9bDsBTHvbzrbTmxU2jHpeSxYQn9MspE2IyQ9tA99+LgccSbSaJO0CyiCDswYx
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f96ceb5c-7dd9-422f-09b2-08d58157b6d1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10332882C6C7CF405EF473BDFBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6306002)(6512007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(966005)(7416002)(66066001)(14454004)(39060400002)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jJa1vGHOyDzusrxJfjyARKhuw5GnfW1yg0ilUPsw+5IR10SGA5V54Ogws7HMBoU87XL+FLu4O2G4p60eUD72RbcjGgblTn/uyTODqOlSmlLYMWCgUpJhlYl+3pWiiexz5LWm4tcGobMkEqKXWmGOSKfV4MQ6dQ/y5Nc8mGgr5dQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96ceb5c-7dd9-422f-09b2-08d58157b6d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:37.0582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
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
@@ -196,6 +196,8 @@ retry:
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
