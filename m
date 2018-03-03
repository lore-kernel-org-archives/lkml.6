Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520123059-2-17649538031622462399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123058; b=kIYcfysQHTYhg9+JPCDkNhmRKZ0o/xjwxCY7UpNQdPgNUxR
    kUA5J9LP0n1X07PCbLXe6uVuVgXHz1jw56yGqJYv8/+k+CSoMSpc9FrYvVtTyYwG
    7pJxL5aDdHhq7COkEnc3IzRVRDX92iRHY2hsN97hXAo3cB8/nUOJzE3oS8TWCbYV
    HN7rwxhrdUxe9A0cT5M6UkSwtqQmYgNykAE5FK+TQMBiRldHM7a6OHuml8QAhcBV
    WkQlrUu0ZeGn27bjIvzS+9xezc/P/f290gzfkNAx8ty0Q9vPqfdF/yXBeAqsIOhO
    0Af3j0uRYhWi/Wdv9mExu1nt3+NnTurWXYXw0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123058; bh=EwbvAw
    zoa3IX2gAS1dMDoaVM1tdy3w7UnTJNaPQiBVU=; b=ZyWn+vbHaMK3Z7K7bqheDL
    EeBV405guEo5FgDlYpVWSeN6jBB7NDOMBHWY0+Np5yPrbVHNtRr7B/d6vkpA/j+d
    LtAXVyJWYmWxyeg08UX8OiaN19k+ixnwsypESxPCERIEb4sx6fVZMbr+LOBReYUv
    NlV/QckAh9Vhw2eNJi68uUWfYv72cHM3zINhYSbdU94rThwXeuzFhJs/9gKo5Z4J
    WapU3c+yyAlpr26H+gb4W04Y+L4+ynkdNUWuYYJPmZtOd+nPnvOnz6jCKCk6FD1t
    AhTVSFFd1hv4R0Ok0wQEZHROBCuomBII5z/x2V5yTKLiMH0ESTqU1sGUToUvgDZg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FXdyKAek x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FXdyKAek x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeCDAXp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:23:45 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933207AbeCCW2W (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 25/84] ARM: dts: am335x-pepper: Fix the audio
 CODEC's reset pin
Thread-Topic: [PATCH AUTOSEL for 4.14 25/84] ARM: dts: am335x-pepper: Fix the
 audio CODEC's reset pin
Thread-Index: AQHTsz6j7OP0ADJNukWHD0IAa48BXg==
Date: Sat, 3 Mar 2018 22:26:14 +0000
Message-ID: <20180303222518.26271-25-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;6:ZMMW2e+rtOLJIBIaRnL5Q1gvuVdRkXcvUDtnIIbBFkMq0Lh1CgjetvJxWr+EqSAtzW/4kfe4g9zpz7xtDise8EsCywZdk12/MDJOfdbPu10Gdu1mxAgYiU09n5NcbP80fcG8QSc+HvRkwkPQCtqkSi8p8kOHwWtHyaMNlBS13QKSsLAaKlUcSe6rGNZ9d+hWcS2797vdbKO4Fft3uBADzOUa9UOPJuKh96/RDLt2FH4fKBItBOLR2peU3zs+zkjqgTynMD66+UF1UiJO9yUcp1VmMSsh8wtokl1nkHRGBWV7ugYDvNTX4qCoRPHjVyh/7fhQ/NGXU5d2RVPz9I5Ss58XsEvJBz8TVjRRpsa02SKdS80WSMaGb4zoTOTsJBpv;5:F7aOto0d/sDXplSqsea5zo3W3+9XOlVmydfljhD26gWYDwjSXhy/v4ZZRupDVn/P7PPMVSGS53IXPTRGYsTnWNGT+hdA2+eRqQNHR6jhxsNbAokKsOLCWq9qAFqdl0NGR2inlheAVx9O3hKJYDa4/YaA0Us8ykq2lE3HMOF7k9A=;24:dWmpK9OnNeZq+FdWfwgvHuX9hhQOAcZfzrXmuV9Oi53ipVJnYOvxM6W3wjay6FsjW/gkz9b7TTiZi5/iq/yj7Kj7suXo+7P7HTjcm9QwZ/I=;7:8gjwtnMM3rzZTB+EdxDRUc9+CGdnxktDsUiah5vo902FG1M5e3MpxvT7YwHEzYzWjf05EyQL2IZ+JIKcSxKJwemXQK4FJZjb/uviBMeZ15b/VYxS784MSuV6v2OihBM5Dwgzs+8cWS9cExTMCSljosBxwvAq1Wi6OCPrJDAd0HQTmy3jk9Pq6knJaLIikwfaDQbiO4tP+76UyR3+yGfCmF2yfcwwHosQDTkdppwHC/BAMSHrmXjSP9KWpXc2y7Rp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df5979ad-ad1f-4647-eb03-08d5815610f2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115E105CA4FC13841A6C326FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: zge7NQgD3hQ8k+wXPtJfk78oVAijDZ2K5h91UbYyousmgFMaOXB01ODMKBV3u0c7e0CR/g7xAKu8wshTKTezbJ4T8ne1gmjcDqFf5EXyUx1lSYVl53cYZEP2V30eTEXU15k6FT4/0V5pl88IU/gQxl0aQ889IGqLIa2YOnHkI+c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5979ad-ad1f-4647-eb03-08d5815610f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:14.5098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
index 03c7d77023c6..9fb7426070ce 100644
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
