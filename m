Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475473-2-16827180760698998159
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
    t=1521475472; b=FmLC+F3oLj5AlADDssptyoVq3NyE9mSP0KKIn3sJrAwFiCD
    jJiyw/62LOdmabkS/xBgD0bM2gipLdRTlsZqc4/iZwECVyQEUDfIsjWMi2c7uhMl
    9NiS8z6rzkGZtJXTqVdEuN39iM57PJxKHKN31+t8mwIqV7mHAj0NKXAAD20w025T
    Kc/zCytJHT6yPgwRIaPb7wa7eNLWKmO+6t5jOnX3O9YVOxPDQJgWDVhUulCvQjoE
    VS1PFxYSFHLJfosubZ/vn84n25BjHKkCOZTM8fySnziwYelS2bya/P2Jozkk9s8v
    dMq88VkCj5PTyoCqxcmqGKcmDT8H3Yssl/pSvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475472; bh=BClUa9
    dM7LfyTfthe9sImhhrly41KFLa5rbrA5U2XPc=; b=DsvgwMlWfTYYg1srrtAegF
    lkakA+jWtsj/x2fSM9JTrrvPJuLAeIhnJZPhoUFw4X6ULW00Qg/sN07XTazElKSD
    +KGuLQClG8E+WUvl79i0OqXjbT7suDquIcb3a8MiPv/b179IBsMVwzNyJgS47R8Y
    yTjON/qNQ4kSAm9WU2qzWnA/ILAjRiqJW9GxakXVuYM+Iza4W1ZW2J71bvyECTtp
    T9kycQORmrhNwKxEiktflxBekOTQNByvAU4/roLoxRg/zKz38AD33df2dA2j8uxu
    y06W0IEeWFPO98hO7nuGstNHKjsbNcoMZ71r5W5bdjIBtwvc59mu54IZ5A0wNMWA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bUPl54dm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegtddtnecuvehluhhsthgvrhfuihiivgepuddtle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bUPl54dm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegtddtnecuvehluhhsthgvrhfuihiivgepuddtle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935061AbeCSQE3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:04:29 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:39072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965639AbeCSQEW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christian Lamparter <chunkeey@googlemail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 209/281] ARM: dts: qcom: ipq4019: fix i2c_0
 node
Thread-Topic: [PATCH AUTOSEL for 4.9 209/281] ARM: dts: qcom: ipq4019: fix
 i2c_0 node
Thread-Index: AQHTv5udlu6DkFkR+U2rkrHNbdEhGg==
Date: Mon, 19 Mar 2018 16:02:01 +0000
Message-ID: <20180319155742.13731-209-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:vDvmUfNSoXBmrM87zeTJi2310xMcoLygo4YXMSQOdtEhD7zEwmIY+lG01zfJ9K/pm1kSQJjaGgZemwnsIJ0eobqp5y3o0j93vKScTXZ08zCFcUp/7z9osjDOg9dmRxhe0hjIgzQNW+SznAtjG0sHzbPQwhfTBOIUfx7SM+vspIQKkGD7GN5Z3B21KtHJLLdOa7QqNzwQ+4ML4Bf111OwFxPpdNkk+ZWg954IfeLWJbTHB5jy7+XOPh9bouIfkPvd;20:QSkbzJM8iRy4SREF1sFwbyb4DsdZsj5bUiuJRByVAXp5mSIG348T0BKssy21oLq0Mxe1gp+MQYRKSKQKvTm33YZfFH212TpjlseKRa+NFjCCCgKSAnJyJgOEwfN3gN/pErT63T8UUM7gcN5c5SZOJJPBGLvNL2hkZNKx24jPuPQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba3d7960-27d6-43f2-a8e3-08d58db308d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727142474A18496C625E9D2FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qFb2DopHVjSOkaYWEGiS9TqMmyL9gUnMss6+vRL46TNwppTfpxdrmWFNIwIZClC4uvbJZ9z5sQksnxYFBwhZsfSDDt8rW9RNXzo8zOpT2cumn1QnRuMYNE3Gg2FPjKXUUmBICaH6ue+D4hJ+ol2L42x98ViFUXfPdSgSrqoJQC0MKyKvobi//X8dkEEli8QSfuKpLBMTya2pL2eAvNdZmruJr/GiBKB+wI8Qci14ndFAK4lytBXgUBquKYpJkyffkLk3R4XhfGVxLiY577ujjYZOBdU0wOKh6TPPHFoEIXl1rMveInTBGf5rxUMmJg9Yb1x0wPquP8/3coTvMGVRIg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3d7960-27d6-43f2-a8e3-08d58db308d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:01.0805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christian Lamparter <chunkeey@googlemail.com>

[ Upstream commit 650df439cfb96c303328935559b2d06127a5a0b0 ]

This patch fixes two typos in the i2c_0 node for the ipq4019.
The reg property length is just 0x600. The core clock is
GCC_BLSP1_QUP1_I2C_APPS_CLK. GCC_BLSP1_QUP2_I2C_APPS_CLK is
used by the second i2c.

Fixes: e76b4284b520ba3 ("qcom: ipq4019: add i2c node to ipq4019 SoC and DK0=
1 device tree")
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-i=
pq4019.dtsi
index b7a24af8f47b..4b7d97275c62 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -154,10 +154,10 @@
=20
 		i2c_0: i2c@78b7000 {
 			compatible =3D "qcom,i2c-qup-v2.2.1";
-			reg =3D <0x78b7000 0x6000>;
+			reg =3D <0x78b7000 0x600>;
 			interrupts =3D <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+				 <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>;
 			clock-names =3D "iface", "core";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
--=20
2.14.1
