Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124262-2-8850955136291852156
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
    t=1520124261; b=HhMRHfqr31+1bMuaYFk6Aay2CZm3d/TjMg6gFHViIEpVBRz
    lHVUlnOmxisv5Z6oHKZy7Xqxoj8H+NiDjuYF2D5xxIrzAGAROj6ug+8lzz7L/Vpc
    AaoH4YUtPVJiDpJ5ZCGR0mFYo6d3YnYBxj8/XfrM30wFyPi85UAWL+Msrh3+ujek
    YYa2QMCEbRIwqxnTbj8Qjab4cfDP747FDdwaZoOPcuEbQi6UHY/aKdpW+qEySv0b
    CorGyF88QjAX9RUlOngdmbz2IfaZIF1B5CCbP2PKgY5Exx+mVNZb83WCWDw6udAl
    Oja9WJfngCgrQK4bFa6uFOk6ew/dPNlFZntfvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124261; bh=EwbvAw
    zoa3IX2gAS1dMDoaVM1tdy3w7UnTJNaPQiBVU=; b=aH2ksupZV4cIHORecrr0l7
    WxKJ9TmiyEenlviUohHeF6LUPIUNHl6aN8R98LQUUxdweGZLrLHGigAL3s+lpA/Z
    WJiqE/ZOqpuXCep4fvdufJLnDj6+nkD2iWwugC/q3TPCY1mHip/X5wRjGKbBkRmQ
    SKj1iZ+R+ZtCAmLE93XE3XC0RHU1JOD9p2F4eJDz6fc/ZJWosLEgn1Lc81IvIefE
    drFW7kCj5/1s528J59U49+WFDrvKrd+CcL4YWObCm+aO9iKHZoCTZdHWmD0TIQZm
    Ig2XM39anugysUwVok1dDtVf9i53MDLE04LlQAsGjTlG2XPe964Dx8FZKHL8gRvA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TsrlofEs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TsrlofEs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbeCCW0G (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:06 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932455AbeCCW0D (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 035/102] ARM: dts: am335x-pepper: Fix the
 audio CODEC's reset pin
Thread-Topic: [PATCH AUTOSEL for 4.15 035/102] ARM: dts: am335x-pepper: Fix
 the audio CODEC's reset pin
Thread-Index: AQHTsz5lt0Z0qTAQokmGnbTrnLWPbw==
Date: Sat, 3 Mar 2018 22:24:29 +0000
Message-ID: <20180303222318.26006-35-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;6:TBBxPfFTayjenXahlBbI8sEfjjPymGie57lxqocKtxma50GznIh1NXlB/DcQeAC3pLPb0IhVFgq86wWWx/hIVfIO9kE1yR0MrTSVWW4IvGyUBFr45YRzhfF81yaPSTRDJizOwHUSClfpcyAc+S5N1KUdNc0y8o1nlyV5nDfSdtRWSldJ0nli1SZuFKVJlVCspiqgE8oX+dOpUD68szloZ7F6F8NxMgsk7R/aBazYP6BxGyCjavw0BU3hSXpFWyPsTAs8dSYdMdNJfwK0PiUb1MMtjed6od2SUG8P/W1bsESp5fT0rCgFY8gUUp9eXYppmbS4CzzxbTNMKPwZWkekA+u7InQewneohdOKa+7T0iZ1ZwFWtNGAKChslBd9zZq6;5:u4LUB58H6xpwSfENwOX6mvviBgG2UrgKkJtiQK3vU8wkKViaUekiqRS7z+dzvw86Ff2/O4b1OQNCHwNSx0i5zIKtCmdATW9D/VMW5UU1WIffxVTZA3zBhMK/tj6gRNN9c7yXxh9IwokheH7vVWH8UWOyuhV+fr/Xb6CZatv8ACo=;24:W/cCAL9KazSdRw708BZKVFkHuGlR7aVMAR3ALxGnoCH6KpENPw/ELVN/ZlBeE7El6fVL5sEZk6dlNCcsChYdjpaRNebeqP47272ID7GJID4=;7:CVz+4rX1GMcVqMcTZM6NZtxY2Z4oorGUTEjsoyDXz5eAvVVgZSNqJrVBqBUw7d8ffwutAuOeqBw46QuULMevPemw5IfktVQtdwodrM3NKwTXItpRVqgR+silHfmvxWEX0307g0d1V2TwtGn+wPBJDIEqVj8yppTv3H1W9MQ5ksWiYv0fQtFJDPcxPSOSCVUKPL8w5KKOJnK2b4yl35N9HLMTuPCh9ISPHMpgzqgxuqbqAi9qP9FEY3N+EIwkFq49
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cbc2080-b216-42ee-94a5-08d58155bd80
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353D31CD19A33202202DBB8FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: GX0OH10/yWQRp2z2+5xNUkxPFq7dvO/JIeE9cSUp3s/J8m5Laz148wwr0LgtXiFTziNU8OfArSRSDgz+YT/5FmpLRkMYpwY0ip0MsRIdi7hFlTg9rYIwZR5/nSwE2By9B5oRkYA4Fb8I1cUNJ0P9BofeHQbyX7Zbs+49bWfDgYE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbc2080-b216-42ee-94a5-08d58155bd80
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:29.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
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
