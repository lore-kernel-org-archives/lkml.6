Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495463-2-13463082634930698687
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521495462; b=d2FALHbatV5uTsveV0mDeBd5ppDGoEOyf6TEI3WCAsJleup
    asU7Q9YNiDTAGRQOjTORtINGFIXGy9pS5pUSd4Q7YMtAGZVJ4s5UxQa1/OVuIbr+
    LlAXln2tP975pvg8iCbmZCXIwkAMXT+7AYBK5yqCh16cHCpOgZIEijV+78DJcWUx
    pEAYQXUBMO4kAwJnrRO8MKLuR2rcHBK2kQq1xFw/3ZnIYaXiucFYh6Eb+j7SW1qu
    5ZbXFlGdhx7Y2FdLTUOyvEOHffeQn6nNyo8hT0+DzNS12+Kz9XYJruB3JdAVg25E
    jOdKrFDuxpybx5hL+Yvioz17KPgVUWm2eQGnW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495462; bh=VqX+yI
    zDN3+TVRYcpNNJ1iyIO4T0mkno1F12c7XZqbg=; b=pJZBtpm1SxJo8pKsAvKxKy
    Jkyq/amkr/ACFYg08lwWo8AAt6bEqBC2X4T4ZTbPIMn6AlxEns+Pn4tNB0D2MPEz
    /5R48FOclHjjzxM0SQ/sPncbbW9LfMg7nGJchq8PQVuUF9DqYu6eThuZB5NarPVf
    vWWTutj6qoRUZ5oho82pYGdQInWObNYAjr1flzcbkS4DdE/672pElzyu/2xtcDHg
    KD+JQBgeyPWeMFWan/khswP4qUoozFJPnDjJRYon1AvoEID36HdUK0fpfoZdg/v8
    bTONH6sVZ6Y+E7VtarTW3u5u2JJ6rLkeeTqZ7s6XTtnTTg8kin7rGmU8N8nJgc9Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jRb32XF+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdeijeenucevlhhushhtvghrufhiiigvpeefge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jRb32XF+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdeijeenucevlhhushhtvghrufhiiigvpeefge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971234AbeCSVhB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:37:01 -0400
Received: from mail-bl2nam02on0101.outbound.protection.outlook.com ([104.47.38.101]:39744
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965100AbeCSP7X (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 050/281] ARM: dts: imx6qdl-wandboard: Fix
 audio channel swap
Thread-Topic: [PATCH AUTOSEL for 4.9 050/281] ARM: dts: imx6qdl-wandboard: Fix
 audio channel swap
Thread-Index: AQHTv5srWeEL7x2pRkab87MUSpEUqw==
Date: Mon, 19 Mar 2018 15:58:49 +0000
Message-ID: <20180319155742.13731-50-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:4mO702cqVKHAZWPLLuOIChq9EyGZJF3P+bTI8rBe2lkolcC71Sf35QIbKL/WaAFG5nF8DLgWiI0aciPY4EzUFoIRp5uC6QmSO8tSpGZblJjmnQM6+74WbDrl6fZOC5T2o2P3ZdKsYHe/NdtQkCCBSaYGaiaSlGQf30aZqUluH0TQPU2FGM8TYxnPYn1Hcj8HOz2GLM9lheEchBRx8KcyOSGjwefBT3QPtTwX/LMzjYFCGNsVbfCC523m5/2m2+mc;20:jMMkQfWJxeXTfT+tRjCT/73GsVuvqDORrLJB93kivhWM3IbDT2s/oJrfawQ0M8W9N9dTAIzePeJ1eDUkXhXjNZoPe6FdiQoRPdSCpW4pxqGYenYHxqMQ90ZymS35TzNC37xL/+E2+5S0EzLlA4/gDXyLG/igxnra4WNfZ2W6nGs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e3c74d0-79a8-4035-cd92-08d58db25ece
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109A8256A93153E4FAEA664FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(8656006)(4326008)(25786009)(86612001)(5660300001)(575784001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QYZ8q90ZuuupiIr0rd7h+vuwei+4spwPJJnVoX+yV5a45t1h1kru4XuAohLAUmjjG+2mWkOoPDSWzEOaI0jJUB7ckDxik+EUSVtVbAY1dQ2EuVbvOFiqVqvHxvjLE0lyJB9pF/QGukdMp7k/+iB2TaNxwTVT9lpUqqMGn1l7ce5cq7Tp+QLJKrOZeWpQhXjmHEzGiVVk39RGLOUu6Dfjq06q8SkLu3aiAA03IYTeDpSmZ08ol15JfBHyjmTnLXWfGu/uK1oitMYkP2M6qswLhXzKl8RrKSsXTqSU3zF0/TPty35dYEaLooSQ2DbpqZH/2+HojOg6BOK++8Du6t7JcA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3c74d0-79a8-4035-cd92-08d58db25ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:49.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit 79935915300c5eb88a0e94fa9148a7505c14a02a ]

When running a stress playback/stop loop test on a mx6wandboard channel
swaps can be noticed randomly.

Increasing the SGTL5000 LRCLK pad strength to its maximum value fixes
the issue, so add the 'lrclk-strength' property to avoid the audio
channel swaps.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/i=
mx6qdl-wandboard.dtsi
index 2b9c2be436f9..47c955458a77 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -88,6 +88,7 @@
 		clocks =3D <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply =3D <&reg_2p5v>;
 		VDDIO-supply =3D <&reg_3p3v>;
+		lrclk-strength =3D <3>;
 	};
 };
=20
--=20
2.14.1
