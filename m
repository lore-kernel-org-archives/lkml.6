Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521499363-2-7104316676956034970
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
    t=1521499362; b=G1wrAYZc/xRT/fefPkxdo9wsVpf7+osUhI/NOxXXxoaRZ4Y
    22BqHou6yrtyjT8wRmXQyy43RWJDphKMYU1eEmG3HM9cnrx7qOPjdXEwJpLP+nxc
    jj5oKed9N7Ft6CkOpK7JmVhqV+QnrKegGCv6wmXbRuVBIa//fy76LHewITeJOKg0
    4s1obqqzZ1SmbCZ5J1sl7Gf3N0OHwGAS9NpPrJxVFB8VzKItVksmX5nFW7yYytfD
    kqwynasmRDGyrKS4F9IsnEe97cqPjpUWcJeIAsYLobhsvoBHs/mR6wjYjSY2k6iI
    B2KTtPGKDUC7Uk0MoLypVNN7dd2fAVR+EnL1/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499362; bh=oBHTya
    tAGoPmAhJTv7o2HwUEhBTRmDma4227zm5P2W4=; b=cF8fDfgP9sOcC4ybzsBDrU
    C9fk4gqMLwTp4RubE0QDuU8qIoNYPSOCPOMbyNwl7uojGHbOb/j9AiGREqj/P1O3
    HgmYKzuleyrUP68ie2GlsoehETCOt+fGXRkyAcJEoa7F2G76OxwkS0BV2fzezoNt
    seDKgP3ULX+moHd90/WUhJtfUlTQidaib/d+Lt3K0PpkDnZDYDa1mwvFkskL8EpC
    6+9TWTHdg00Eg67kC7J/PYP+Soc1SGFkDvT40yCpK3dplRftRLNIOOw5JMHTMY6Q
    Jr3Qypx7xHllmOU5b+pUTgvpRlFj62Z1mJS9nLjjjilZClbG7IVVIOU9f1b60vFQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UA/AcAoj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefvdeknecuvehluhhsthgvrhfuihiivgepheef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UA/AcAoj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefvdeknecuvehluhhsthgvrhfuihiivgepheef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755967AbeCSPrL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:47:11 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:19764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755983AbeCSPrF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 005/124] ARM: dts: ls1021a: add
 "fsl,ls1021a-esdhc" compatible string to esdhc node
Thread-Topic: [PATCH AUTOSEL for 4.15 005/124] ARM: dts: ls1021a: add
 "fsl,ls1021a-esdhc" compatible string to esdhc node
Thread-Index: AQHTv5mF4OLtXlzIxE++A1qabOz5Cw==
Date: Mon, 19 Mar 2018 15:47:01 +0000
Message-ID: <20180319154645.11350-5-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:EGkL7ZbuQDwJchdXHU05rkU1CfsfZFHsiBXk+qHx8t1Y2NjzJ2hOCXq9akZQx9EOAT4L5L3/x543VuF67eDcR8iRdBFeMpfA8fByAVKZhxljfifF/5TkGVr05aCkQLjv6QkygBMnkI0KxMAA6Fk/cMxWzO9VUFkHX8oW+JTTPGhvX4R/JaXVt3MmTzZuHKzJ1ug+5Sa0/i5nMmroLFlJGPxtXmdzJ6zHEN3/gqk+0aeItrbyIEiXfvIadUqO92Mg;20:Eb8e2A1Az0+g219R3eyoONLEBKbYbjucytbAnM53zIH2JzJQp6Ef8Ry/Kf7vH2Jxty4sRRCKgypQQ6yYLaQOCRItFbWPBOjmHqJTfv+mXiuVXjMmyTVq+1DVOygTzMIfGO5pzOa12P5qszEuZiMPT9DZY6uZrs+Pw9+O4Vnszc4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: deaeac15-9630-4ad0-95d4-08d58db0a81e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10131F62C49C096C7F20A136FBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(575784001)(59450400001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(142933001)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: VhPo/usHqiSGUFtKvFCrYGsYCPDpVo7KfjwgXg8JGKDVRjE+PrlPZW9gkOS/kRBAs8gdmdobGIqaQUmZZ1Ly2KEoq/yBbhoBTV10DFl2SIyIG+j+f9JbG063xdDtgeynguRYv5rZW3Vk6dZRD4KaTIlD642q3DfLEMaPws/7DY07KTFAE3YEvJHuMCPycbVJC+wXnRWH/a95K5fQU2XoJZ/KY/XSqlEhyGasa5VNYL3ZzUqtXkb/zt/p2RA3O8px44uuuWhtXVHOIhcmPQXSAlM/KJ/cUidqjp3CcqKYE4ZAoBj6dWy5Vp/U61c/eDgLMmYF8c2D2U+InqN9WYj6cw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deaeac15-9630-4ad0-95d4-08d58db0a81e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:01.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index 9319e1f0f1d8..379b4a03cfe2 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -155,7 +155,7 @@
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
