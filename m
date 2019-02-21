Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C649C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28BB2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="s65GQN/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfBUNqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:46:01 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:59298 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfBUNp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:45:59 -0500
X-IronPort-AV: E=Sophos;i="5.58,395,1544511600"; 
   d="scan'208";a="28085122"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 21 Feb 2019 06:45:58 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 21 Feb 2019 06:45:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jk4PKTi1QqkJsir2LKFluevQKxw3rJ1833FVyDZ3sc=;
 b=s65GQN/P19qBngsvVZWAlwWakVxEn90HdItuG3PKiVN1Y6Q017aQ4m2Ul/DnkbDExI2cECOnG2Mw6ElNg1DnM8ZZHxjuLVlW7VqXFhGR0aAkoRk6OSuI5UQThaRrhgtJvwIt/Y/LRHRfHbg3P5ebgxqZgY6hvQDRraneCSyYc/4=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1677.namprd11.prod.outlook.com (10.172.55.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 21 Feb 2019 13:45:56 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 13:45:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Topic: [PATCH v2 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Index: AQHUyevFtUOcN1p6SkmLvvq6jn45yA==
Date:   Thu, 21 Feb 2019 13:45:56 +0000
Message-ID: <1550756716-3032-4-git-send-email-claudiu.beznea@microchip.com>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::49) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 315d854b-6685-49ad-f5fb-08d69802e74c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1677;
x-ms-traffictypediagnostic: MWHPR11MB1677:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1677;23:Wp2FIwpuyleESkbkGlSy8C7whgVEffTPfGIBVEh?=
 =?iso-8859-1?Q?rvWp7/D0WAx8Sr2OT89VAZ7zylE+C80Jx5RAzHFtSpzLYJjI8XpVynQhDy?=
 =?iso-8859-1?Q?AyTS+iMypGwfJoTMhha9Rbssh6etSwejJ3CBPdW/C+XqpmrOIVC3btiM0g?=
 =?iso-8859-1?Q?YR5sW+ye/8tLZk5R791Ft4G5ZMcglV7MqUPd7wOOh6rh26EaIL7VxC3urq?=
 =?iso-8859-1?Q?NAckuNnhq1V4HnZt/p8IARhfAyDVldv77BhS730yKxvnxDTrp8MIcLz0Wo?=
 =?iso-8859-1?Q?gfiABD2ZMUT7/3pgzauAI4Bfu+mgHrEqoB7QQCeZY4EhQIsVlzJm8jm7x0?=
 =?iso-8859-1?Q?f5+B8dd4WyuyqsxBoBHaRUV+ArybFeovGh0L5rJJ2+CourrRgDjI1IkPOv?=
 =?iso-8859-1?Q?y4613TG6YRs5jVATWycZZW8vE4R4IzLFdhrYTKawmprCtoxlqEU6lIt6X3?=
 =?iso-8859-1?Q?BcyuUgUyMFaSim+5PJX0tk+RigyHYRuabFqcbz3bF4nW6jKPIlt7VgqYKi?=
 =?iso-8859-1?Q?R6rVB1Sk5EAegAXzBA0oK9zoIoAjPtOOXLe6+GVFwqPGv24/n7RXwy0Vii?=
 =?iso-8859-1?Q?yYg8tyC3iUqAOPgE2yF9KnSKBNwg3UhcJl7jbvpJEIFx/G8tczCNlLU53R?=
 =?iso-8859-1?Q?Bi5l73tFTm/SJREEsl9Y+zm3fyDssVzfoaxYOAArg83qlz5MdhivzpMp1D?=
 =?iso-8859-1?Q?fjN2yfHqoZxWtyJyy7tK4sqtHbjsgtJ78J/9DU9V4AqI8RnaZeLukFYeBd?=
 =?iso-8859-1?Q?w8XQSU/QAdrkD5mjeXtMmf+0LkEhwuarD57Hah2Ux8AKSrBjdXb69uKzrx?=
 =?iso-8859-1?Q?gi1twDrbQCvwMbGe5ESXKfXs6F8EDxRTuQu/TXeJCbSwjVeCK+EwMICbcT?=
 =?iso-8859-1?Q?u3FU+ezPGPsdYoi9/vvE61XQH9mpBfRIHy0zOoTFyrxb24G06CPkMre8s2?=
 =?iso-8859-1?Q?2gFH6B0+zvEfM8jylN2DhTrT8mhBtrh1Z+e2JON2LsBZpB+Ct75gKZC/vW?=
 =?iso-8859-1?Q?tn5BqG8jBIfBrmfbnqepWIhYJZjieNho1sGjLnADMpTK89PJgW6eymw030?=
 =?iso-8859-1?Q?RUGv6WWxgu0lkcmDAav5qj7GbiegOkjOtGfBOlysGhFQeWONCdA1F8kXkx?=
 =?iso-8859-1?Q?K+oL/YkbqIGcSEPWNNbQfsDpkMPto9+uBQy/k22vdyElkQCuFp1Blq1YeT?=
 =?iso-8859-1?Q?w3Gw4sbCtO7PJtdaBNb+TsY3pzqkq+TGtg3ZSBKpc96Ours7HOH7sxuiQF?=
 =?iso-8859-1?Q?yVArRzLBtIJquS9fVubhkQbWah/m5j3nB7Zg2ytMDuDyQ6pd9iokAmTnk2?=
 =?iso-8859-1?Q?55qLRf8qLKdv8/nJ9qnAO/X?=
x-microsoft-antispam-prvs: <MWHPR11MB1677280807219ED3ED903A0D877E0@MWHPR11MB1677.namprd11.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(6436002)(6486002)(66066001)(36756003)(107886003)(5660300002)(81166006)(97736004)(8676002)(25786009)(2501003)(4326008)(81156014)(7736002)(305945005)(8936002)(26005)(50226002)(53936002)(186003)(6506007)(386003)(102836004)(6116002)(3846002)(14454004)(316002)(478600001)(72206003)(2906002)(106356001)(14444005)(54906003)(256004)(110136005)(6512007)(486006)(71200400001)(71190400001)(68736007)(86362001)(476003)(52116002)(446003)(11346002)(99286004)(2616005)(105586002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1677;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zG1hBzXi6+RjaGARx/CNyuZtd0zKUoVsaEyPpjKshYjZEHhhy3Iyd9NHQU+wQb37EwEfMT38L9JsbEOytA3vQps6dN0agdaimarcMs0/lM4dc80RRaOWi2loyuqGnbFAXPkl8Cgk4iOvRAjO0btcFcGMtodshZNg2bOh5Pyvrw1GsUeyelH6+QT9yYqDkzr726X8RXLJ4OiEfQIIVkLaGyVnJU0jroCcAPWi/Rg3KdM4uOEL7/C+4Q0YadPLs0i1Gtg6lsBYDWwEij67bBwAx2mWXwX6b1Oo/vDhcuAAPYJQ48iYQTvrmsBwTFFPpPxSiqgWnOU5U6jxw15bJBxENQOG/LKCS9wzkg+NBnQ0UabqyT01DeNoS2HzSSxH6GRPMoLHornJ7LN53KRlhy+16t+1uFu4fm3NaOFNKFSSx70=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 315d854b-6685-49ad-f5fb-08d69802e74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 13:45:52.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1677
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for SAM9X60 shutdown controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Docu=
mentation/devicetree/bindings/arm/atmel-sysregs.txt
index 14f319f694b7..50f282ccbcb7 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -83,7 +83,7 @@ SHDWC SAMA5D2-Compatible Shutdown Controller
 1) shdwc node
=20
 required properties:
-- compatible: should be "atmel,sama5d2-shdwc".
+- compatible: should be "atmel,sama5d2-shdwc" or "microchip,sam9x60-shdwc"=
.
 - reg: should contain registers location and length
 - clocks: phandle to input clock.
 - #address-cells: should be one. The cell is the wake-up input index.
@@ -95,6 +95,9 @@ optional properties:
   microseconds. It's usually a board-related property.
 - atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
=20
+optional microchip,sam9x60-shdwc properties:
+- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
+
 The node contains child nodes for each wake-up input that the platform use=
s.
=20
 2) input nodes
--=20
2.7.4

