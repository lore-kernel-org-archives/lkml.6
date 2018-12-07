Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851F7C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AD820892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ve/yWu73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AD820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeLGGqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:46:35 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:20454 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGGqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:46:34 -0500
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="24102308"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Dec 2018 23:46:33 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 6 Dec 2018 23:46:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKTsdZWpa62osy2QUv/EwtEeoJsEZ5aF5mcGq8G7Msc=;
 b=ve/yWu73PbGEVpOi7S2C5/xsHOtWCsJVi5vZx93Qy5m+RFe1/M0E6PXJppDmNR5Q5d4K3SfChZIqW2zxIq+mXwXkytAa8dczGcU2l9IE9WapgkAEFZQP2NHKu1eP8A+hjgjXZvpTa6GbyiyZa2yR1fSnjST+UUnsCugzM3opGPc=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2257.namprd11.prod.outlook.com (10.174.113.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 7 Dec 2018 06:46:31 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 06:46:31 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <Ludovic.Desroches@microchip.com>, <Cristian.Birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: atmel: describe SECUMOD usage as a
 GPIO controller
Thread-Topic: [PATCH v3 1/2] dt-bindings: arm: atmel: describe SECUMOD usage
 as a GPIO controller
Thread-Index: AQHUjfiWjzw/Hf8QqUO7vRXC6lr0VQ==
Date:   Fri, 7 Dec 2018 06:46:30 +0000
Message-ID: <1544165160-13653-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1544165160-13653-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544165160-13653-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0075.eurprd04.prod.outlook.com
 (2603:10a6:802:2::46) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2257;6:XybQWhikQNoGcKu7gMZ0IwxaHbd/In8gvWpWLr6kGYuQsfWG0Td4SaLQlt8KOpWLeKHdCrDwdxO9KINaNXIEz15rO8npb1AXY/l4oauzbOS4fUhtIHzWmZqwFISM7036Ofc2HDTxMKG1T3t7l3WEi3x+uDnjFfXpdfBXxA+ndoXnWU8tAj/3LVBK+bQsU5rqLBn6Xn/vaET+qZZWKIgDipLs9YOjxDNLy1X8SYp0oweiylZiakaJQR6ww7Ao3+mfVGdBBEGo2pnnpcqWjXv6LedzRlGYQtXXw0db/ONOVUCzaeJCW83AZXTQIBrGHYkhSHLj3+FDOt29kMk8NLB1B+sezKFldbntSkAyHwkMrw/dFosMYwsdRJPSVZtgKfuHaVzlqkk3/vNnnR3XDNocOxtph6rKzbhjxUtTaDAgA0JKsW/J1MDckRXN6sHsgtRZzTjJMN398lOMmanQh7bhGg==;5:4eKH5EacFmXcJXygIrI2QxspSOZDukiqslUHRpO6uSYpgl1w+TyeDC6jcC+wqNXzHYhO10dDfrcF9XF+4vwyS5yND1/6+DyU+FSaq0kExZybTWAyrbz6aonPKn2/urYyxeJ+56BSceXcudOEAwRD+6VeSWd/0wnG9tlluFO05Os=;7:9ojgSXj2gC8APhn9xl8iLqWjjRUanq1tas/MaABtJa0UwFOu5d0vH8F3xP+B4jngdWUlek2J4IlrAIvROifdhi5jJAZ23582CFMGOVF/B8L97uky1kuVDoRiVtw5hNVeG0NuEMcRih3/kM8keaCZ9w==
x-ms-office365-filtering-correlation-id: dd183977-1e61-4ac7-8a15-08d65c0fb857
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2257;
x-ms-traffictypediagnostic: BN6PR1101MB2257:
x-microsoft-antispam-prvs: <BN6PR1101MB2257C2F3653530303F97EDE5EDAA0@BN6PR1101MB2257.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2257;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2257;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(199004)(189003)(37524003)(6512007)(54906003)(110136005)(7736002)(66066001)(99286004)(102836004)(6506007)(386003)(107886003)(25786009)(52116002)(186003)(26005)(72206003)(53936002)(478600001)(76176011)(4326008)(2501003)(36756003)(14454004)(305945005)(316002)(97736004)(5660300001)(486006)(86362001)(105586002)(6486002)(68736007)(8676002)(476003)(11346002)(8936002)(2616005)(2906002)(446003)(14444005)(6116002)(256004)(71190400001)(71200400001)(3846002)(81156014)(81166006)(106356001)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2257;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q3iThTJgJ6AZN7iCLYFwFkgU8Dd1a1WgOMXoBnffKcXJCSXMbGL98rlc+ZNE7MEfo3TkfRU3pIF1p/UXTvGKIqk3nwTIMAVGgii4VpKzoj+JTwHuIX/un0g6dZh3/QHg1DWUbleFQpalJpekZ3ApeNQJ8tmP5LvVufJ9w2G7SxYxQT9emSn8Yc5fPRvhxpP0TfAXwOYiLs7Oh+vJ1mQJ+Bk09o7TjbWJ3K7PPIM1PaGIfkOY00WKJizHFe+YYl+CbqLYw7gBdDzHgzHTOhAA+5X+PbFwbSpO5cT6Kira5kfscHCDXZLsg4ALrHXyE1cMJAA8oItNlq4wuRnf9jvkZjcbiA4OrjDU7IPCQSG631c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dd183977-1e61-4ac7-8a15-08d65c0fb857
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 06:46:30.9135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2257
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch describes the Security Module's usage as a GPIO
controller for its PIOBU pins. These pins have the special
property of maintaining their voltage during suspend-to-mem.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Docu=
mentation/devicetree/bindings/arm/atmel-sysregs.txt
index 4b96608..c89db84 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -158,14 +158,24 @@ Security Module (SECUMOD)
=20
 The Security Module macrocell provides all necessary secure functions to a=
void
 voltage, temperature, frequency and mechanical attacks on the chip. It als=
o
-embeds secure memories that can be scrambled
+embeds secure memories that can be scrambled.
+
+The Security Module also offers the PIOBU pins which can be used as GPIO p=
ins.
+Note that they maintain their voltage during Backup/Self-refresh.=20
=20
 required properties:
 - compatible: Should be "atmel,<chip>-secumod", "syscon".
   <chip> can be "sama5d2".
 - reg: Should contain registers location and length
+- gpio-controller:	Marks the port as GPIO controller.
+- #gpio-cells:		There are 2. The pin number is the
+			first, the second represents additional
+			parameters such as GPIO_ACTIVE_HIGH/LOW.
+
=20
 	secumod@fc040000 {
 		compatible =3D "atmel,sama5d2-secumod", "syscon";
 		reg =3D <0xfc040000 0x100>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
 	};
--=20
2.7.4

