Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491346-2-527873986233474073
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
    t=1520491345; b=lQbMoyEYL5JqKaah2iZ1OWRmsJkTVdobl5+WCmnWlT1Z1N0
    K3jHl0JpXlCialNJaWH5wCX2ARW9lmH35sP+aDTXeNWbQ23irgizrEn/2Iuc63Jr
    cqvf8YKDJPZPNWD8vJBltnR2EaxvL0DpVTx9dDRkDzyx51kkR8oa8cz8BXxIlRTC
    W/ZhLdJYd/5soOqA4SwIY94V25dX3HLA13Z4+DWY1MRWKb+tJmFUNxtmqqp/mPQJ
    l3nz2wYj6cYibe/8GxwJbyPodMDlJV4TrzX/IEGPu9Qyh/e59XwlH/+8AvBJGlss
    wNdIi9iKgwKVUvX/afA1UunaIHDVH2rE+dwuq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491345; bh=4AokKI
    r66tmXAwVEyJYDUBrmRZfS6IwstzeiGnlskqc=; b=nh5zpKQaRbI1BKB0A3QxzF
    1vI7jvQ1BWjsKK3WX+8Yrpm2f1R6Gk3StKOD2CruylDi9iup+XwjVznP7WRevpRh
    Iny7Kw2e/dfjkWWEECROCsC5yPc/iEc69qV7H0P0PdTRNiq+cfKpjt9TkbiZ96UP
    myaM7i71F2+S2jsr8MG8kfgFVuSOnhLaQqQ2gOsZqvvfaUryY0JPNXkD8DjWMZK2
    Pk+q/ShgSwM0ut8jaJuKaNBF8pd2Hb87n3Ze14QCj3eeAW4QV+lzyWOIe6BPcqJU
    yEFErPSOo70kD4XY/n9sm1huIBKQtuhtryDQb70a4JZaxC3dFWLHAsQFPzAle5zA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jYmdjRsx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jYmdjRsx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935358AbeCHE7A (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:00 -0500
Received: from mail-co1nam03on0132.outbound.protection.outlook.com ([104.47.40.132]:62208
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934966AbeCHE6z (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jerome Brunet <jbrunet@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 31/67] net: phy: meson-gxl: check phy_write
 return value
Thread-Topic: [PATCH AUTOSEL for 4.14 31/67] net: phy: meson-gxl: check
 phy_write return value
Thread-Index: AQHTtpn/0rpeOFkckkCFrTyhejy4jg==
Date: Thu, 8 Mar 2018 04:57:45 +0000
Message-ID: <20180308045641.7814-31-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:+ibYY1qKdkvRtCfMEDRHcRHryI94mcyuCBLzTZBkXcAEvZ9y2XSZZtEIYqvDzCqJpPKmWJePo6JBfRea+qVBmhmxk3JsIIKjyHJWFoyqHok8fkMNtkFyPA8a3xMO9JUil9uOd/shYDMsl0z/0qCe8Dk4e/Sp9GpO2pN34j73BbD/ElPoF1gv/WUyABqCYM4eqEtlAy6k0nIMqvRerfXDSdgONUjwpphhKVyy4102IrWZ+fbhaxHe4iQagPKrdiom;20:pKDNFZxV9hZy/+L3zGb0i2Q0ktqw0LuUgdFteJtqRLMlkPZhRXr3JjE0gyK7bWWhD0QGe0BGY5hWAheP53u/R0tAv6Hb/TAdHcIJbDWcnPsz14zCHyPRknHQlNaWj4WaswPoakYLt6K27qoDvOJsxkoWVdxu3UAuXTBXDL2kT58=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1d9f7e9-04e2-4593-8efd-08d584b14a19
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0999ED263B959EAF24ED5698FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(575784001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 5EUMjFWl7AfYAHde/mfO1DiZDnIFiWlDdZZfs5k58pwusuz/X+X4/I6TuHS+2ugIXd5pxCuzX3lRpV3ifEALdEjZQYK39w3tkZetldTcSBMk/ybk9Cs1nIM9jry4rlpz04upV3DzN3A0NKOwGgl9GxzixYPb1GYSQs78909pRyGM9NxBItILH0l9EaQ98cGIhmWLTmKl+HcgAsyv/CupkmkZY0tSLBPWm6Z8uKMZUbiL8diRlZasVeKjIHUrgs/gbqGXban7fcUsR9Cue5Rw2RCVOWQ6TVBJIn5zodkKm7wrVoszWhwGqTorKo7bDiu5naGMDCzrKjYtvlXKjaZIIg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d9f7e9-04e2-4593-8efd-08d584b14a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:45.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 9042b46eda33ef5db3cdfc9e12b3c8cabb196141 ]

Always check phy_write return values. Better to be safe than sorry

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/meson-gxl.c | 50 ++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 1ea69b7585d9..7ddb709f69fc 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -25,27 +25,53 @@
=20
 static int meson_gxl_config_init(struct phy_device *phydev)
 {
+	int ret;
+
 	/* Enable Analog and DSP register Bank access by */
-	phy_write(phydev, 0x14, 0x0000);
-	phy_write(phydev, 0x14, 0x0400);
-	phy_write(phydev, 0x14, 0x0000);
-	phy_write(phydev, 0x14, 0x0400);
+	ret =3D phy_write(phydev, 0x14, 0x0000);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x0400);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x0000);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x0400);
+	if (ret)
+		return ret;
=20
 	/* Write Analog register 23 */
-	phy_write(phydev, 0x17, 0x8E0D);
-	phy_write(phydev, 0x14, 0x4417);
+	ret =3D phy_write(phydev, 0x17, 0x8E0D);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x4417);
+	if (ret)
+		return ret;
=20
 	/* Enable fractional PLL */
-	phy_write(phydev, 0x17, 0x0005);
-	phy_write(phydev, 0x14, 0x5C1B);
+	ret =3D phy_write(phydev, 0x17, 0x0005);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x5C1B);
+	if (ret)
+		return ret;
=20
 	/* Program fraction FR_PLL_DIV1 */
-	phy_write(phydev, 0x17, 0x029A);
-	phy_write(phydev, 0x14, 0x5C1D);
+	ret =3D phy_write(phydev, 0x17, 0x029A);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x5C1D);
+	if (ret)
+		return ret;
=20
 	/* Program fraction FR_PLL_DIV1 */
-	phy_write(phydev, 0x17, 0xAAAA);
-	phy_write(phydev, 0x14, 0x5C1C);
+	ret =3D phy_write(phydev, 0x17, 0xAAAA);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x5C1C);
+	if (ret)
+		return ret;
=20
 	return 0;
 }
--=20
2.14.1
