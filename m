Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479943-2-970968728536320965
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
    t=1521479942; b=YGUK0BJQaZxTy1vK/HFipS0WCdqVQLJ6eKG03N/lVw0yIcO
    DQ9SxCE8Zt+RGg0Gkrb0Uf+ZI3ahOt5uJGktSY194CoPhXR/u2uGhDfaUnkrp0JJ
    RjGJO3AXWTLcznrzotGqQeqqgpzSAsdSQZtZqH+pb32/UDI5XhEczmIrSFzbxE/U
    rQRc8Yl3a03ZeB250b15/RcByGsaRlQL7iK70BimRMLKeC7W26Tc7B6ElS/k8jtj
    73L5cm+gSsB301ZODmWbsrZrpIlxq1L+q9GNfBSqnYHYWrMN859nOYDfQKJTfCLC
    i7+ddtlgt99wpVTGxuvmhQp2jvaEwH4/UYTr5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479942; bh=3usOAo
    toOhzpD8+dQrbeZGD8Cr0Li6buJCXAgK3Dh9o=; b=qzRn0bAeRDw6InXn+wg2gJ
    mnMcieqo9mhJ5+WEHyiiNVgqctmdu0Vai35LMhL0thKmrLwZee0F5wSeqwFXJFCD
    ye3Fb0gp8ZN6L2EsMDlFg7RUbX5awchAXSKvEUUybNBpWuTsx6eFlv33ymM90+2P
    8ko7yZdCIW+iXM+a9DIg5GNakzwy/fhMZkJnA3kKWllW5Q7WMV6u2AKLjh/TJh1S
    FrK/W22AutlwS+en/Udy1cXINddiFbJK+/U54uvIoZXu4JvgxO3i4kQYXBEFb82x
    SSRuWwrRx4PduknYq4ddNliZGaJCutQmQebEvD+aP1Kk/PxCm9nDOXT+AyYnOcRw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LkS5/9xT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvudegnecuvehluhhsthgvrhfuihiivgepiedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LkS5/9xT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvudegnecuvehluhhsthgvrhfuihiivgepiedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966455AbeCSQJY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:24 -0400
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com ([104.47.33.106]:7584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966404AbeCSQJK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 082/167] ARM: dts: ls1021a: add
 "fsl,ls1021a-esdhc" compatible string to esdhc node
Thread-Topic: [PATCH AUTOSEL for 4.4 082/167] ARM: dts: ls1021a: add
 "fsl,ls1021a-esdhc" compatible string to esdhc node
Thread-Index: AQHTv5xSrjV9LvSvE02wpUXCVRAraA==
Date: Mon, 19 Mar 2018 16:07:05 +0000
Message-ID: <20180319160513.16384-82-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:4pBE0PR/vjnCqTAVk7tc5xCbxA6J5f9r7/QLrLJfNSbpB5uhsPG6XdPYNobdnK6iH5u7940jvtmGJ/2T4NRShWlVVwMdpyWX9Eu0QZ0OA+C2FZSA4sMUlwmFvXJue2Uoz2oSrQqxs4DXqZwxKBaj2cUCm8JjrnGbEN2KI6f9B0qHtMGOSh4eSAOqP0MKtgmuAZYRSgp9FdtpMF5JTWD4hu8ymTGXJn1zuzZ3/y0dTEyYhUUQTxSZkxyHY1J84wHy;20:1xg2BctE09lz2HoXqBTakyb5j9fX9ki+8GnJHAz6dMXPYhhp9VzswEz7vMvK4gPOhU+jUDZyCBnd6kjiaBpksvuFYRo1rVrefxtlJOKSD2EE/tNj+Ei1ep4SDkzUjCco057MCljXRKpMCT6lBBTat/vZ3j/GAnp4DiuVSDf92Uo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b179009c-73ac-4194-5b64-08d58db3bd02
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095BB9C80B487887C74C33DFBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(5250100002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SiICRPF6dBoAfJBZRU2mFznX5f76cBjP/orMi/m5SL0JGDsAFMJ9TIr3k0mAGj86pTHqHLp2I2BuyrG54FraJm5P/sk9qFZaZxzJ8JCZdfqRwjeX5Kp6Weqi7rKc8wRLBi1xeRsTfeZq8jgGOBIGt4v6qYW424zrX9daX3XV3+kOgT2kZOhBU5yG1zUrQ1DIZt+ORwuvHElBaQ6RLFXOEqGCHIyPfFdBgUbMuTSKFEW99YgocUCld5hrKXOm6YXcvPV42pn3ckGkY7gnruCaHQw+q7X4X9sAxM3EiQNDKhkV5YOjp2LTbR9Kn3TGxgkI7qggI8ar9VfXAkZlE2tu6Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b179009c-73ac-4194-5b64-08d58db3bd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:05.0632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

[ Upstream commit d5c7b4d5ac2237a6da7ced3adfe6b8bf769f8cc6 ]

Commit a22950c888e3 (mmc: sdhci-of-esdhc: add quirk
SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for ls1021a) added logic to the driver to
enable the broken timeout val quirk for ls1021a, but did not add the
corresponding compatible string to the device tree, so it didn't really
have any effect. Fix that.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dts=
i
index 9430a9928199..00de37fe5f8a 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -132,7 +132,7 @@
 		};
=20
 		esdhc: esdhc@1560000 {
-			compatible =3D "fsl,esdhc";
+			compatible =3D "fsl,ls1021a-esdhc", "fsl,esdhc";
 			reg =3D <0x0 0x1560000 0x0 0x10000>;
 			interrupts =3D <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency =3D <0>;
--=20
2.14.1
