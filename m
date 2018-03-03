Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118093-2-5481690683536126339
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118092; b=qKKPDi+vM2paEWKs56YzWuChfevjC24ZMLRi/s8ZIJkMsE+
    a2nuWSqm2qi+l1qNWi2335s1E7/My/HgPa8tsxEqsxr5Cn3KWKZY62M3gsWTc97x
    PK2y+YQzhUt/cyDQIq+5KtJD+XrRtOm2Nx3XRgDr9EyZgXPEd+6Shv/ma6fzgWVe
    CpWfGGVGt0yLraGzurbHNSiZXwcUaPPzS8EWNm2HDeY0KJWmdAkyFWdvE2TcLoQY
    5FPtUdMmYfXcK0QMDX6EN35U/nuLFYTEHWFlYd5q5R7Y/UgSTDqmkuaq9KeuRwis
    dde6pr0trLVJOulOfeibqInTL3G94pOBJOFwjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118092; bh=K0L9Li
    9TmUmXqgbDEiYJYcv68fWbN5TrOD4YLrG58Q0=; b=RqrPJn2is7NtN0huxsmwFv
    8pKM62r9lsjhKyZiqU2sHHm02fjZyBHbNj8jU6nyFiLY/69iFnR3IwSUvubXJDiG
    d8xzsVLPi2SWOwT2uzDPzWid0C3Rn0tH6J0hz57f7NBMqH4488aXu2Cu+SnuuGCe
    qaKOcECfC4ujmID9n7NWzE6smNykSFaDT3a9G031UjJrU6efxlLpzoarhYnwHDam
    AOxtx+06aRKyaJSIMAIKNhKJ0/qTON7XMeyrUO6IMEiQgnjof+JijHlcFILPgW6C
    tWX0PgqZdWwpT2eGk6nCGZIQnAzuLK1CR++2uGpfuj0qk92ETzYMfWuf9UeTqy3Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EYkt5qbF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EYkt5qbF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934795AbeCCWkt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:40:49 -0500
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:9680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933998AbeCCWkr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 093/115] ARM: dts: am335x-pepper: Fix the
 audio CODEC's reset pin
Thread-Topic: [PATCH AUTOSEL for 4.4 093/115] ARM: dts: am335x-pepper: Fix the
 audio CODEC's reset pin
Thread-Index: AQHTsz9pqY2Uh1oyRki1v0RVN+2E9w==
Date: Sat, 3 Mar 2018 22:31:45 +0000
Message-ID: <20180303223010.27106-93-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:MQht+rBqYOURSiCuHUw7ZGHyuw/GU8gL7d+Lg8QZwU3ymMmc4frlZkrSVQsS5zhgMMIv9joxSh0PgpqjYobs1eKyp2d2q6OeYbpwSAGOrXr+BO4P21LmQVUij6C7NBx+4EbbQIWjXSX256tD73RrElDC5YFUSZw063WHiG1RcyOTVEL6E1cHalSuFzSR//ZwZK4Pd1cUGDH45nWdMaU5c6r3iLE3vsUshiikSLWcCMYruFikk6VFO7hFUWlC4t5E
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99aef3b1-b04d-4280-ef58-08d58157cc75
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB093964D332FAC819857A45C7FBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 7a7bXV+Yzsprs17UzTbCNVKMYmIgMSr6A5rKxwGvtzmT3k5UTSNymCduDjlw/TgwCzotJj0fiqDCB2xTVcSZByXvEY5ApoiX6r8Upu0TjJpvZDnccn4bVKQiiPAY3nsj5Ycos0c4FkAIYIX7qnP9J/VMc63GhctpCzKR6VPqNd0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99aef3b1-b04d-4280-ef58-08d58157cc75
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:45.1208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
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
index 7106114c7464..2dbe13a3d89b 100644
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
