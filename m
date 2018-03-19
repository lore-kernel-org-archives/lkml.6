Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521480760-2-8166589635440119322
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
    t=1521480759; b=u/vRiCMfSVtlOLycBNB+4gFvbnHSzDHwnhttGK5xgaz4k7E
    s+Qmr8F1q8zOoemSmhGFLdocka9k7CCAo1uUc8ZMffazU3rNmMK0s7AB1hHB4FKp
    p3ck2R9WFJkKuiEV19kNeKORvOKyd3nd9Zc2qLw5zEpBJ8OxRU5+IFJ0Xs1VtAcz
    HPQKqmXKWjTxyeKGt/n1k8CdVEHvrfbknWLemARzq/cNgP5evI4mj+91cJBUNz/0
    A5EOUWAUMS+T93zwryZTSV4LE5jYRno8/RLgNcTDQrUZ34OO8cmbXVO0iLqMUJLM
    Sq9ZPkPw5tzrG3NpjzzcVECIXRM77+Cp/Vz+Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480759; bh=n2mGpr
    cT+5yMdJDhZ+wH3FpYDwfGOHhtk3EhxEThNGA=; b=bdJz3Z7UDO6Dl5HULpzDIA
    fF24kUmAkwduqm1fILKVaBaEMyY6J5h1H7Xsg09/eiOb4gV+unYxXqYrME0AdUGF
    EXpZ2YGvjCpQSZiQC7XcGGhYYESgMGz808zlyNl81J1eE8DmMvBDqCRU8yfJoDRH
    ZS/8TwKy9NuqzYfQ5y+tPZs8B+cCQLjiW5bA12Jre0FNRsGAftFq5se/0uGUvesC
    FF2tyLAdBawc5JxW790Nf64p5P0m9pom1PwZ2ZAGdIdXdfYKNZ0faatO35BkAENR
    Ok5iPaAzz1Kn0USddmxhvylWhx77xJY/VGKx7/ARBL2dEUxAoWg+sfn4l3B0ca2g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TWc2S0tg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeeiieenucevlhhushhtvghrufhiiigvpeejke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TWc2S0tg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeeiieenucevlhhushhtvghrufhiiigvpeejke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967759AbeCSRbV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:31:21 -0400
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:10656
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965999AbeCSQHA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 025/167] Input: elantech - force relative mode
 on a certain module
Thread-Topic: [PATCH AUTOSEL for 4.4 025/167] Input: elantech - force relative
 mode on a certain module
Thread-Index: AQHTv5wnL9uVVUKGP0yYK6MQrbuMxw==
Date: Mon, 19 Mar 2018 16:05:52 +0000
Message-ID: <20180319160513.16384-25-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:gTfhNXFoeogpuifT7F/fmYT5njy7nutJuKOTJCMHMSt10EepD59LUoQwXH4ktVK0pZ7pEP0FKfMfqLyxtyPr/HoethDbc4L/eLD3nDeQKxVzZT1tY52kvwK+AIdqNAAaZulN2I5j0uw5hQcd2IW3tFtaZoUmlDzashqPW8ncXqYJz6oOp7JJFKH7Gql/k+YU5ExaOWsj5U+XwcBL0F5+ZbeeGfGIdB1A81vrQB8hGtO2cMSzW1rlmzRaE3g23R/2;20:0rSl/8Dt8bk+7b/cHexg9swzaXLMnz0OFIVIHb+KvtfEBvkYFWwdWUenvjgwB+cDaheLxWHKwDFjm32xy7YKIyiAX5yx1QYaSNaTmpXk0OmXuTXGHp4QmXqz89xXxeE/p2UX3RE1qbn4fOlsaCPUGmZx5e20hbqmYp3/mPWvF6M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aac2b7a6-df46-4565-78c1-08d58db36e32
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109392C902BC5DEC6B271948FBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(76176011)(107886003)(2950100002)(39060400002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(575784001)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dENVIBC6Z4kQ254MkoVM/lwy4jgbSwbHyJkdE89gW6zel08fig/ArxLSsOQtdqDV7UZ7CAFn3u5c7No2l2EedK4JDuto6L5T+9eEqzzW91NM0Rri1CJDxPquBN49qG+RS4YyCTR74QzSfdSvguVAweOfnLZk+U4GO9gc8ZypY/I9gckgLHDC10fnL1RdkoZ/uNez2iCWon69aIcAiCsqRp73Cag3PuzSiWSdVYzra5E2/DieHC1sk+zRjOJxpgtTM4f/RB8S0UJcZSqcZp2nvjEhqzgvFCGvQm5sUvCM1qkhXsgDzv3Hz8fkKdNYEVYwfwCAaJGdkCUmMozlWemDjQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac2b7a6-df46-4565-78c1-08d58db36e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:52.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: KT Liao <kt.liao@emc.com.tw>

[ Upstream commit d899520b0431e70279bfb5066ecb6dc91d0b7072 ]

One of Elan modules with sample version is 0x74 and hw_version is 0x03 has
a bug in absolute mode implementation, so let it run in default PS/2
relative mode.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/mouse/elantech.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.=
c
index 51b96e9bf793..06ea28e5d7b4 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1715,6 +1715,17 @@ int elantech_init(struct psmouse *psmouse)
 			     etd->samples[0], etd->samples[1], etd->samples[2]);
 	}
=20
+	if (etd->samples[1] =3D=3D 0x74 && etd->hw_version =3D=3D 0x03) {
+		/*
+		 * This module has a bug which makes absolute mode
+		 * unusable, so let's abort so we'll be using standard
+		 * PS/2 protocol.
+		 */
+		psmouse_info(psmouse,
+			     "absolute mode broken, forcing standard PS/2 protocol\n");
+		goto init_fail;
+	}
+
 	if (elantech_set_absolute_mode(psmouse)) {
 		psmouse_err(psmouse,
 			    "failed to put touchpad into absolute mode.\n");
--=20
2.14.1
