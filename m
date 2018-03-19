Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521482067-2-5275660113589697822
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
    t=1521482066; b=dZb8bz1qwp7AHlksYMBeYIIAsCwdcuE9P7AFD77Uu+flgeh
    jyY6IZGGs9nH4HdAq7dTbqRcCq15MfFRg35Hc59Y9fSp1WC3aMeUdN74CfrEovho
    mBtoXEMGSdEwnAIfCmOuz5BNfBEkeEQu2Kh0396E1AfG73dfm05VVhWtqbdj/1hK
    nKv9E0wBXmkwYu+XoyPuI7fR/BVL8rx3AKHeyvvumJ/9x8AoFS1wA4QGHFe3wRWc
    /bMDWYTOT2dVUCPODvG5QzIGeZyIQfj4JgLChXbAi0OE6wIWnlumjkCK4qge4ZlL
    LmUUo7eQOxepGfk1Z/fVi8j0Y9RiItalXIDuAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482066; bh=XEy4gj
    PgWiS/5Q/5DKhfMXzRriY1ZrbwKxAljFA+99c=; b=IJ9WtHpxyRnW7wA7+OaMI5
    Fnn7rkiOiTKt/27WATcqCYc7Up4uDQckP++Zf8vM9FxPOOv5Rv/8iuJZFLrvmy/t
    2oINXd6g2QP3e2NQASj5a66LpIqX9LjPvsGTRkqrskMxBqKwminpJCtG9IOfMGQE
    k+uunE52aJzKrFRDmM+l5hcKYNeWD35M5L6zLX+XhFpBotjUm7KQ9VPNXX8+UUD1
    ePoZBrqA5th/XiJfHoqfFJ0My002V3SDkoVVzISI9agWQjo9upZ9L0DhqQU71J/h
    i5a9twqc0OMk9fU+STQNklWB5fZ/NI5N17u3HXMOQWLk7F5U+cvkJ/JYWAgT3MAw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WqkjimBF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejiedtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WqkjimBF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejiedtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968346AbeCSRxC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:53:02 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:7948
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965705AbeCSQEu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 226/281] ARM: dts: armadillo800eva: Split LCD
 mux and gpio
Thread-Topic: [PATCH AUTOSEL for 4.9 226/281] ARM: dts: armadillo800eva: Split
 LCD mux and gpio
Thread-Index: AQHTv5upUnrHAVLnqkq5LThIKDx9tA==
Date: Mon, 19 Mar 2018 16:02:21 +0000
Message-ID: <20180319155742.13731-226-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:Gt0hnBpFn/NeqdtJHv6TqxTw1C4KzOQN1hzPKat2tD8tW+LB63tkT45/RQR/zMNdoKiC2HZakYOes+HV/LGqbF6kH1E6+0F2i05/r2C16w3s+xfHJxrMwa4y7du+8GqIc+TJOUNAWPtTbUHjjFah0UV9tfeUMeoMRrWz4IaB9108rm8TNy/sycFR+TucTLcfi+l0MdEIGXIuwh5uoUMkQrOfyPVYBPIiRPEarTirbZ83yEN9cktYjmYolbMAMQaq;20:FJrWhbjSc4GDYC6UaMBEZyStSGykMbETZS5ADgR/7PLaxfzLUrEi1IefA7p6XysxscBq8rcxADiktjodaiw5NxssPuZnSi5+TlaMmTuvg4Fze7/uZeQoGDMMVnddU7CSiy51AxZQCi3vEWc9Y0n4VaN/3dIWiaSwFlz4aOiVHyw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0888bed2-ab93-4536-3df7-08d58db3243b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08856C2B772149AAC0B6E270FBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(59450400001)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ruLD82IVfgGv2ub7hUGicJ2415C4WFQcBELOXiCdrfn4uNv1RQoDJvpPD18tYu+Dadt1gRhwp2ST4BEQvTOJX/lIF3KqL4wxrzxjZ+PC81rzZdEus2JIpcNK+KuryMXjVRWe4CbweKCaEbuX5f/EWUKeajyb9tdGrKdrPBgUIXk3p6xQ3+3MB4yE9MOeoBBS2CLqoXtTBC62aBjpDiPNJt6vvXPo5er4M8kEIhH4hFKSk7btGGZWaJiF+YMpWkcV1yeo7fNwPQGE8mqvv9e6IBNL6vjfsVou+6ExnUtMNkZ8s20K/tpjR4yr5XgObymCRVhTSiQxybatKT0S0jHJ2w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0888bed2-ab93-4536-3df7-08d58db3243b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:21.6953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 13132b3f44d3600983aceb7e9920b8ebb55a7cf8 ]

Configuration of the lcd0 pinmux group and GPIO hog for the external
GPIO mux are done using a single device node, causing the "output-high"
property to be applied to both.  This will fail for the pinmux group,
but doesn't cause any harm, as the failure is ignored silently.

However, after "pinctrl: sh-pfc: propagate errors on group config", the
failure will become fatal, leading to a broken display:

    sh-pfc e6050000.pin-controller: pin_config_group_set op failed for grou=
p 102
    sh-pfc e6050000.pin-controller: Error applying setting, reverse things =
back
    sh-pfc e6050000.pin-controller: failed to select default state

Move the GPIO hog to its own node to fix this.

Fixes: ffd2f9a5afb730b9 ("ARM: shmobile: armadillo800eva dts: Add pinctrl a=
nd gpio-hog for lcdc0")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/=
dts/r8a7740-armadillo800eva.dts
index 7885075428bb..1788e186a512 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -266,7 +266,9 @@
 	lcd0_pins: lcd0 {
 		groups =3D "lcd0_data24_0", "lcd0_lclk_1", "lcd0_sync";
 		function =3D "lcd0";
+	};
=20
+	lcd0_mux {
 		/* DBGMD/LCDC0/FSIA MUX */
 		gpio-hog;
 		gpios =3D <176 0>;
--=20
2.14.1
