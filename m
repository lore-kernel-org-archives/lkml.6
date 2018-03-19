Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480498-2-10126069286449928390
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
    t=1521480497; b=VOf6TPj6NSn3kLyoBma6DG1hygMxguTEENzhio3Q2iqj4w9
    3NP7ZR1fGhOWS35BcAndYgMA2o8R374Rm5JKDOB+weGdM5gVtOc9yE+JuftyT7Qh
    JmmA2Z3QlsGVqj8MN7NZI8Fwt1ofy3Ojgp93G6THFtgsrhoLV6HmBU0t8J+6zbcP
    oLRskBDApHQCQD+6Nc1xjxksvzXjVOZm+D9iQpr/uFZtdei3qFRJ7H/R7gRJsCJB
    nJLOtr5TML6dL48ewQPHoYSECBiXuQbd6bxCtm094i5PzeQ0+fOCF5gpT94pSvSb
    WwyvcVFaAlD2g0u8mXRC7MCjSi3PAYHgLX1MfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480497; bh=64SsvC
    31Zpvr57a1ysySrcuGTurIn3TyVrrLKCq1A1Y=; b=LWAuixvcosmZR/DqPRrtPY
    EaaqmRBT1EYA+VgKstHp00KIJW3JGrHiead6tvZ28/VlchdwLx66oSZXoHTr6tY8
    vyjPpKx9rWLLaQTjsXqUmsUQT/r2LDCZzFxDlfm8p+gXan7goGR8vL6i9zST4ctz
    R4j5bz5YTCwq+julri9Vcyo5pzB4XZiQlqqu8E/QuaHZLSDLI932UIc/qqt4oQh2
    Zo0+OW+JFZUpf0alewwQycNEVAKCyfSyoW/7vnDtGafcT+8S0p3zxYwQ5a3nMdlH
    wyHR5i5EDC0SgWsSD2RgdlhVqpTEtriJwGjpRke2dVGhz+Qnu1+ZhYyMd3ZhTs/w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EW5zy3RG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtieenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EW5zy3RG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtieenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966203AbeCSQHo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:07:44 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:54368
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966196AbeCSQHl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 035/167] x86/tsc: Provide 'tsc=unstable' boot
 parameter
Thread-Topic: [PATCH AUTOSEL for 4.4 035/167] x86/tsc: Provide 'tsc=unstable'
 boot parameter
Thread-Index: AQHTv5wvmqoBNhCYCUGeYuCJNLHczA==
Date: Mon, 19 Mar 2018 16:06:05 +0000
Message-ID: <20180319160513.16384-35-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:qZA7Rb9mwDGRyweJxvk11t+2wD0cxuVuJltqleibB0970CKjZknF7T4lY2z6FLIuUPN8Hz9w7CjqMp2XRBks0Lckm51ZVu49sMop9YO3+itcKFMgQPvsn1t5VpKrojP990endPsobvRoscRvqxc8GT1mzwN5u78sCCqpMHo3MnW26Dw2bCyczCrEYxHkdZVnjhZYujMMC/c3wEupGHc+c5oONs1ZxRuf9JB+orL9MY+ELvMPNJP0wsDz7JleRYQh;20:9eeJaf4wVZPZg+TDXEQeuP2QmOpDmtxEW1MePsZZASN/JMq7Ed2aKpEnRXtPrp44rMyDKqYQLmhvG8sc3CSUBDsWQ/YyRyDfrWgscDnXXnpTNy3Y2qDO56gWALFgoqJ9k5HKIXWZUeg+q4PF7noG/XB/lKWi6eS1m5WUI/ixG7s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 709746d2-0e06-48cf-3ea9-08d58db38816
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092058566E3E1F79F8CC8BB2FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(9452136761055)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(8666007)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: EsXbJtUWlahIga0dpMTwUQQXf4gzkQw0NoIDjShTk9hq+zn4TFICio2J+bmx9olQxncrIW2Y6yAC3Dd8mA3k4mLozczps9tc0btAtBwYkE1vM36E7T3FW3IIzkU3XcGTv8sUZ9GImQmzzZqXO116zSIgSfPfbFDgEsA1FuDEBUQdpIeIDKMk8XSRpMiBrEbxFBnrr1FeLBlBMoUMez3QmYLdynG34b3UueGdivrpdGap/APRKOF7QeIN8BUEg4obqUZmddT9Qw89nRujb44ecg16t9h2q5ZebYLWZ3+0r+U9A6esfD0sCDi+f3Be1KjmGUlmEC7NDK0BqKgf53fMLQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709746d2-0e06-48cf-3ea9-08d58db38816
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:05.2558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 8309f86cd41e8714526867177facf7a316d9be53 ]

Since the clocksource watchdog will only detect broken TSC after the
fact, all TSC based clocks will likely have observed non-continuous
values before/when switching away from TSC.

Therefore only thing to fully avoid random clock movement when your
BIOS randomly mucks with TSC values from SMI handlers is reporting the
TSC as unstable at boot.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/tsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c7c4d9c51e99..eb02087650d2 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -365,6 +365,8 @@ static int __init tsc_setup(char *str)
 		tsc_clocksource_reliable =3D 1;
 	if (!strncmp(str, "noirqtime", 9))
 		no_sched_irq_time =3D 1;
+	if (!strcmp(str, "unstable"))
+		mark_tsc_unstable("boot parameter");
 	return 1;
 }
=20
--=20
2.14.1
