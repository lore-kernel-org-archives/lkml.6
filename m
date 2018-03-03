Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119761-2-7294871796080775704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119760; b=cPcPdIJ0ra3bJ9btYN1Rseb1339WRqUnBP0KJ1rN1fnvZHd
    efmsxyZvhExe/hP4cJ7NiaQ30BBOcSAv2Em45HmFmcaWwjXKU6plI0cgS31+E2lJ
    YEju2Q+Rzxb8gXdPEUvKEFDz7cig4rVKNGivRTKPopirDp0mLO4ejR0Oe3XYVqk+
    MtDoQjbspoZY0RAj03r7hoX+oFPFeyZdk5WoOZGG4Rfdyu94ZfUM7WTNt+qVgi96
    G7LRRmjj3s95rfzD5BJDumYNssgKIm9WLYLnVezDvOCW1AIzUAHyGocjgf+M7HKP
    6hIL8rjVwdmJZQHSwAl1Il2hoekXUWMNdjVAkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119760; bh=v3p+U+
    rwRKWWd9vp6AWEKlp83MLxVDWh0LrBXhHwFDc=; b=PQ/E9H2QhwVR9CcLs6Dj0K
    5glWoBkU6HDyBIbZoZszAybJvd6UudGMdoqYr1EkExuPHk2iiYJBuatjuLAbykvN
    bvCxbERCAuWQFovScLVz5E0izzpLDOvYYg97xvjZ/TnS8GnuN/WFTmbkDGqhpeua
    zHDuos0AOhZ1pri4bqy0wP4SAM3NE7/IE5czgq4QPZ0+4G1fT75OCpuayc2vJdcc
    CdMCtSINBdLD6bfFIJpp5ocwGHh0S9o9S7qS1UjrPZbbKDLh6a8kHIKd9EYarviU
    86gL6Ler3cFtqKmZW1mXCILr2JqNgFQ81gaYl5kosxN7pLBGN8/kJXOXhSRSn49g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kN92ycXl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kN92ycXl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934606AbeCCWgr (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:36:47 -0500
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:41088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934588AbeCCWgp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 185/219] ARM: dts: am335x-pepper: Fix the
 audio CODEC's reset pin
Thread-Topic: [PATCH AUTOSEL for 4.9 185/219] ARM: dts: am335x-pepper: Fix the
 audio CODEC's reset pin
Thread-Index: AQHTsz8hMlu+vEulyECfMw69/EiKTg==
Date: Sat, 3 Mar 2018 22:29:44 +0000
Message-ID: <20180303222716.26640-185-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:Q1C7ogv9MvDEjur8bofdjptIrliKixKEKUHx8oRVZ+rosoRwvjJNjSzo646K/hpLsIqt+mV9M+du5eRxJ9wdDaudV4HfU7at+XDbwlAqCR1OdF7z3f0c+jaYEuJUFG9UHZTZyS15KgYFRbZRMiOPHOpCmrvUXWc74817KiHPdiJ0gAdrSbZWXVWvtiVEdXWPtn7I8zycs7gn2hfxJ1834oI2tTvylrsbB/F3AmWrqWGPxKIEm4D0p3RJZwg8i5gR
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77f4495a-74ac-4612-7dc1-08d581573ca2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1020D2439F4251C76A1797AFFBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(59450400001)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 1iQ8Lq7NpBqueIjlYqKCOfYuUtl0xc0ByCo/RUQP936m7pMfKCF9Ym3kOjdh6RU8FK5K2U5RNMUeIxYnYA8uHyTzhHi7pK+sku0xzqgZc/zyc+Tl0S8DaFyR4sk3eG9WXgjwkkGiK/icDce3qUgIlPeWF7d8ePQDx5MIxXB5NJ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f4495a-74ac-4612-7dc1-08d581573ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:44.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Andrew F. Davis" <afd@ti.com>

[ Upstream commit e153db03c6b7a035c797bcdf35262586f003ee93 ]

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Fixes: 4341881d0562 ("ARM: dts: Add devicetree for Gumstix Pepper board")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/am335x-pepper.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x=
-pepper.dts
index 30e2f8770aaf..42b62f54e4b7 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -139,7 +139,7 @@
 &audio_codec {
 	status =3D "okay";
=20
-	gpio-reset =3D <&gpio1 16 GPIO_ACTIVE_LOW>;
+	reset-gpios =3D <&gpio1 16 GPIO_ACTIVE_LOW>;
 	AVDD-supply =3D <&ldo3_reg>;
 	IOVDD-supply =3D <&ldo3_reg>;
 	DRVDD-supply =3D <&ldo3_reg>;
--=20
2.14.1
