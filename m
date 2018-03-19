Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475352-2-10465469318208362687
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
    t=1521475351; b=puXKliNioKqHCXcD5+y659e4niyo3tc2W6mUJLXwIXYKgfW
    i8gwXJyZy74GMKk+WdIBvP69zhWH/EJExf30G9gSAs/zSDMEMRPjtvkOod1PAx5z
    F1j3Ww7L6PiUdYge63k7LphEbjSrn0Op8CyUIgvAVmXz8GEWQAkvVz8uMOhiDYbf
    yL4NVdOR2y9ebhj2EutzLUZ8UFzuQhuJxJh9bdO5lrGr2ERYa0Pe0kbi5hxZXVZ+
    AC/+lND5lEd1xpxWPn3mo96XYubILhqn+fNTor4f2bwAVeYtAzziS5jbD3xrKGKX
    TMCVoZ6V9NRbBCwex9tqdisMpwvGWpCOGDxjC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475351; bh=zQvPZB
    qAriV73DZCCFuQJVpLRmZmKjClVzxcy6ICDyE=; b=jN5nf3CGLO052Y/H2AF1aB
    2/Hkm2aDyEpaC45xKfURv8PWQ2pylYkbaW3m42mlUx6kcoxow7w77zUBxJcipsBm
    hjtoDxfYvdSb190wB1Oj+DBBWrogBwP7DvRg5028y4DD38vKtUL30/wE96ikak52
    eItWao5nuhmCKDMECd2m4qLihiq6YUyagAGJFynhM7ez1dwQ6aHpot+UTwSUAheE
    ixO4hGJDdZFdhW/el05ervbw5/JNy0ARAxuxahv93eD0NxhzbWXZJ3PtSADp1m2O
    E6yiOOXuJckOGL+i33B0XHZg4Noohi1wG8qX3U5Zg2OxMSaNQNb1ikAxTccDsV5A
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EStCunAK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvvdeinecuvehluhhsthgvrhfuihiivgepudehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EStCunAK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvvdeinecuvehluhhsthgvrhfuihiivgepudehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934984AbeCSQCA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:02:00 -0400
Received: from mail-bn3nam01on0114.outbound.protection.outlook.com ([104.47.33.114]:25993
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934946AbeCSQBp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 123/281] ARM: dts: ls1021a: add
 "fsl,ls1021a-esdhc" compatible string to esdhc node
Thread-Topic: [PATCH AUTOSEL for 4.9 123/281] ARM: dts: ls1021a: add
 "fsl,ls1021a-esdhc" compatible string to esdhc node
Thread-Index: AQHTv5th7/EgaqqpvUmpTXBP8vfmkg==
Date: Mon, 19 Mar 2018 16:00:19 +0000
Message-ID: <20180319155742.13731-123-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:PpeEUWTjsCoU+UEMoyP9ENM4CNxTeUQpMSkMWz0Gw6M1/Jt3MowhU2YFLw7U6xutKDUnHH9+sEwntLAwuXQfDR9R4khv39FFT7dQDNS3KfJVEkkqVgaBYeofHg1NWdXfXhNblJ//rU41fJNqc8f95dmjoAyzWsRAaay3CVd7npZjCMmds7s3hXhgSau0G7olXJNkyWQCCETtLpF5rXCFB72ncvpqQs3kD3tPdPLFZfXSDjhr1CpcsaGCnxBW/aSP;20:HS02qk1wGwgoYaJmzsvXeQ7yOAMONZ3olwWq4JPGn0Q7ch9mT4wjDSgoOoHxAPEELDTHUZgHqXti6Tf0QBqSlENG3Az+8LseiVvj8nF8eVG5iB0PypdQ96cEPjV1uJd48nDi4z7OFT4MK0qmXaXpVVURjgx2FiIzWv4vMTiBUJw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1687ddc3-2867-4b7c-ad95-08d58db2b457
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09030331078FAC6A24B08D89FBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(6666003)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(3660700001)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(8936002)(68736007)(6506007)(76176011)(14454004)(59450400001)(4326008)(2900100001)(3280700002)(25786009)(86362001)(6436002)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fpppW2Tc//YjMUxMyuUaCzrI0A81RqIOn8U/S+yWIb5wLbMp21vhLMx29LtiLGVFUynQYTMMpuyV4p+SdjIkfKXJ6BKq2ti7vBpvgZOHcD3w1zzjqyTAqUpWozem7jH4B7r1uVzl/NDfLpcYQg/E26mkQ/xflpftp/3tQORaKV85Xo9BUZQXRc1KcZvLPN017LMSpiA1JuXqs+vrcELMZkdv53w4AZshp1719Q0Yg/MuXAQzRIq7o41s5EQ1xfeMMWTB0XGbVD4hRkCrU0TOESjPn4O8FmY7va9eyDTUG5+7VdMVP4mUl3l5Ia5h6aASFYZdPl5hfKJt4UU2xeQ2OA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1687ddc3-2867-4b7c-ad95-08d58db2b457
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:19.4456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
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
index 368e21934285..825f6eae3d1c 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -146,7 +146,7 @@
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
