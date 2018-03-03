Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520123309-2-10392291323362836568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123308; b=Pptza3eZwuXyuhvXBagfv36rP+vUO9eWxgyIFMpcBjrRAiD
    pRt/QDwKckFjif2A3xr97+o2AY4hZNOpts9xrhs7LiKSdAC5IV+xsPs6Dffr3Z/D
    C5ornGQFZADQzHAIU4O/r0iszrZUrfi46P+IdKZ43FHXG6XCS9+rBdfNADdH3mWy
    jtBY75SzbNQ+fJWZ6Km2tySWAQnsvA/sNtV9yqUUlZM5sUg5ih1kwu93dxvccmar
    v8oXGz9uwhQjrZyy2grnX8TqxI1vUAWdV4iVVqY0whbx4Mo8o4vpp9FAyDdaB9i/
    0TCkhPnbKu4yvb7i9OgmFeDFYZxMt3WvCYi5ljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123308; bh=Ba0qC4
    Dv+/T1MsxqpRNxy0G7rbvmIa4de1ULS7g+K00=; b=HMhDlRXqAMJ/8JES81tusX
    reYhVugpagztmSDZiOX4Dz1GzPq+iQ/gY+kWgrhgB4RKrKsJZlurOxPUe/TnKMJg
    9zCg4jPKNB7wZcremM+Xwuu0Ev1P7t27fQ5EAWJhl0FAduP7vKAirB9HdFXbdJZb
    M+pYuKsU8dSx57wDO+q9HT5fxqWA2+WijAcbKztdFc3VRXHnDdy+lDO7xHOasofw
    lw8ySegwAeqmAEZBY4eusxE7hfnSqx1e2ZoszvhdoM4v5iJ2fnUIxhYn2ZrkHzSS
    2D6JwDcgTeEU6K4ZEoqWdTTgVj0ixp3M3ADJq5DLRD8OEVuss4V+Rg1t0WkxJn0A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hb/2bpq8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hb/2bpq8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeCDA16 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:27:58 -0500
Received: from mail-co1nam03on0110.outbound.protection.outlook.com ([104.47.40.110]:19475
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933095AbeCCW2I (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Simon Shields <simon@lineageos.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 09/84] ARM: dts: exynos: Correct Trats2 panel
 reset line
Thread-Topic: [PATCH AUTOSEL for 4.14 09/84] ARM: dts: exynos: Correct Trats2
 panel reset line
Thread-Index: AQHTsz6ea4jBHinf5UGffpJpvLDP8w==
Date: Sat, 3 Mar 2018 22:26:05 +0000
Message-ID: <20180303222518.26271-9-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:43XrDiBolsF4UVgKzenY350SDwSSutJhg9DYmXmuv1z8d1wmdgrEkNXUZcHVCiApdN78+z0hUcwgN0T8ltVThrDrLFQH6lm+pZq42HFu/wxY3XaJno87Sl/eqvSD1AC7JcfmqqnQnaH1uOs0df/AS0CnzQ6BJIWMKbIkAZSSTxZgH8xA/a9UOMBTi3/SX1inBCnkaQdTF7Uc7OTC8WRMW7FGwF4IGZ6Qq9ahb4iDqWyP3cgjEn38xdlWRGo8ZHJi
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7790969f-8107-4cb1-7f9e-08d58156094d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106799712F7553448CC7032CFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(59450400001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: QAuaOh0N8Ldb1j6eXD0OASbW3VWjzl1qdko8B8moIs3v+8Dh/gekb9DXvDTmWdi4TYWvhJ2rZ5lizRlLrHuPjJB3ktQwfkb19yjOVILNVjGjBv/iR+d6V77UDFGRMXSLlFUOHT/m0qOmLfby84p3X8wB/aMXRORHEsd2+nyuGlk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7790969f-8107-4cb1-7f9e-08d58156094d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:05.2129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Simon Shields <simon@lineageos.org>

[ Upstream commit 1b377924841df1e13ab5b225be3a83f807a92b52 ]

Trats2 uses gpf2-1 as the panel reset GPIO. gpy4-5 was only used
on early revisions of the board.

Fixes: 420ae8451a22 ("ARM: dts: exynos4412-trats2: add panel node")
Signed-off-by: Simon Shields <simon@lineageos.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/ex=
ynos4412-trats2.dts
index bceb919ac637..65602cd51a4e 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -395,7 +395,7 @@
 		reg =3D <0>;
 		vdd3-supply =3D <&lcd_vdd3_reg>;
 		vci-supply =3D <&ldo25_reg>;
-		reset-gpios =3D <&gpy4 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios =3D <&gpf2 1 GPIO_ACTIVE_HIGH>;
 		power-on-delay=3D <50>;
 		reset-delay =3D <100>;
 		init-delay =3D <100>;
--=20
2.14.1
