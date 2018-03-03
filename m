Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118265-5-4317858894995482991
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
    t=1520118264; b=m4c8fhkH06graDe+vz/45JvMdSYkRKOTK9xzR4YXXRCJVk6
    nLM1QHP5B3FBGZCTG9BHgiPcRR/471Fw9PQu8weXJnJNLXlnGGsFIoIQ9Ql0+EAb
    5wU+slspioYl6CH/n5ioknGLXN/LlQceYXGCTTI3zovQoWZuNX2H/dizBJCudgo6
    +ngNnh5sAeN6dwVohvHd+0qFP6sptQr18IBcqVUWiU10U9lEm2xkpz/+jBMXr1k1
    TYVgmPbz5v0X9zX2L/KT+uaoXSXYRIFdurAewTMvfI15UjaHkRT7w7dkQh2fCwZ5
    5mDb1+U6Cy4bR0JfJoZZeFxWAI3Q+X/lzAWsAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118264; bh=s/dQlr
    shHT3Liz+O3JAlWEIg7NMfhdC8TIYc9bUj2iw=; b=bNfkSUfzP5g0ImweTfD+h7
    NF0UT8gvW726/JnJ2UCF+6ckX/Q81kqQ5SIKHlqAALP+rNNwHABb5UMd+IwoRqJ5
    7sMCZY+W9nms8b6LCYO5ySblvcwGT6EfGA8Cxiz065r61Md+FMAAgaTz6A0Zy/hv
    ehp05X3CAxJXITeXL56X4ckEQOPGTqjy5r1rr90UTTZ/ETY76Z6UTxt/RSUOGN+u
    pesG9JVY/hLjfkRIjdb8IOmxZv9q29sMe6jrtpbzjznI146k2hmDVx4P1mXhjrLL
    7BcSUlySZyYm4dNIduBkBxcUygTknNQlW5tGq6LOC15tb4Q9xvGgSwtc7T9XwJjw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gS0NfysN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gS0NfysN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbeCCXEF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:04:05 -0500
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:13952
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934692AbeCCWkO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Simon Shields <simon@lineageos.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 087/115] ARM: dts: exynos: Correct Trats2
 panel reset line
Thread-Topic: [PATCH AUTOSEL for 4.4 087/115] ARM: dts: exynos: Correct Trats2
 panel reset line
Thread-Index: AQHTsz9nMJQciR/v5Ey4PklgkXp2gg==
Date: Sat, 3 Mar 2018 22:31:41 +0000
Message-ID: <20180303223010.27106-87-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:ztxRMs4IwSIXm51Ig6M3hNZ0CgvyPDles33iOW1HceE8856xg8V/Uk2RYTfgG2duZniQMKH1ApekVcQhoFtiUqLPcBQtJY+CN6+cdJwbr5C0Xy61Vc3rDjcyp77j+GpBRkrvxupsUYn1nVFSbowPbu8NMBAvQYTh8/rXUMM4s50I6731YLBlNYHJaKT59xL10N3ujbpIS+x2ceK8X8J7REJ1+bHLNzehA//OhHjAd+08u9EZc7A2Nz4VsRIawcRO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 590f44ec-02a6-4c54-b5f1-08d58157b903
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09396474236224810D44EED6FBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(6666003)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: wS+GoVd2dLEMQInOLGU1f8JpZ7nGl57c8l9vgiPq4y7NlOa5dX/t5GjUcJrpTCbFAohrZr+50O4LUMZNk2FOK7Cun3C6ufzoNbKWKt5Q8QfxeiLGF01ZZOS8mlr1pqeNB9vxGrm2SCoNy0aBL4L4p3u5oCPMZ1NO5Jgdp5GILE4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590f44ec-02a6-4c54-b5f1-08d58157b903
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:41.7770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
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
index 40a474c4374b..4c52358734ef 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -359,7 +359,7 @@
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
