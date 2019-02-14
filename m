Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CADDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EA22147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MRmkGK3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406914AbfBNLYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:24:24 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:37939 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389603AbfBNLYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:24:21 -0500
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; 
   d="scan'208";a="23850304"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 04:24:21 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 04:24:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RddlZD9FSGsdUFRawqDmTmpieA0j7l7dUMnuglYnEVo=;
 b=MRmkGK3Dvul5nz380yToVJifnmlrXvXkTynorA9KgEhCMLptPou3IeqXstC39cgGgsPVRX90hRZeyILr32++PKhanci4zN0umxkxsoNOHlaQQD000GRSj8n+IBhTa8enUtJfkFxkr+SAhLWapD19pdJJDKkich9fKw/raWN5QD4=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1661.namprd11.prod.outlook.com (10.172.55.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.24; Thu, 14 Feb 2019 11:24:18 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 11:24:18 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60 shutdown
 controller
Thread-Topic: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Index: AQHUxFfTL1CYZiysKUi13XXnc4JnEA==
Date:   Thu, 14 Feb 2019 11:24:18 +0000
Message-ID: <1550143407-26109-4-git-send-email-claudiu.beznea@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::45) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb04f0b4-4d49-4380-8e9a-08d6926ef53d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1661;
x-ms-traffictypediagnostic: MWHPR11MB1661:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1661;23:QNABpLDJ/PwapfY7cuTv/HEz9cMgdUdshc2uEiy?=
 =?iso-8859-1?Q?VtkyGxiy0pqhAHkm4G/PstVVkiz7niTQRrEWMP9xzyqIWApiVfCLNSmv5K?=
 =?iso-8859-1?Q?YwlGBRU3FUk1rcpHEH8aO5PDEGxUimFLKEqeBxJ7jA0ouWYL+8dqucf7Vr?=
 =?iso-8859-1?Q?YhUErcTjikxSKCcug/gMLm/ZQd5jkbN4VdFIfssMXQu0ZghI5LOp0uPwUE?=
 =?iso-8859-1?Q?Cdp3c71wt/12F/QE/SPtY4i49EKrFESi9mC0AaMkhUfZy1Ul3pK2ry66eZ?=
 =?iso-8859-1?Q?DpHdLkqubB1bOoZbXr4I+7jOroMDSKoBhdIHjCx4xwqvTU05wmHQbh3HYF?=
 =?iso-8859-1?Q?k8qWdDHqfkntQOW8V9JSd/hMAejYnJwwHFCphMibzZf03jV6RzSuklRmf5?=
 =?iso-8859-1?Q?MP9S7xhrih/CF8dU1CVyoYaRB3gZ49WggIcDnvjqVVsMK84+Xq5ZDWcJW9?=
 =?iso-8859-1?Q?42ptYR/IObUDCaEeLvR4/6ZEoSdpIVZmNkO1+flhkcFUjRdDfKgW/h5pfn?=
 =?iso-8859-1?Q?46naqipKgHcACfdfJg/1J4vc6ozcfFPxeomtQG3fcmJuaq7C0t6RItmNnT?=
 =?iso-8859-1?Q?JdLls8MwL/BLWJ4BTvkH8HPHgfLavRGE3QurXfINsk5Uh+cmOR9OZxuyR+?=
 =?iso-8859-1?Q?PAdRV3f+oden6J+2ycVk7uNSEQ3NHt0t1LSa9gwLQTxQVrAUP2HXAGlvC9?=
 =?iso-8859-1?Q?/37M/7UQkGcXeaz3LtzB0CTprGEsPvU2Isy516oP2zOrF2p+Q9kbrHT7Ou?=
 =?iso-8859-1?Q?UP7Ceqp2cWTbqh9vFdSF2MHmSHVBaqoImkMLBeK0ba41w2KOE0NSECZzxU?=
 =?iso-8859-1?Q?MvONPJA3ORau2JADSOQbt06mH05KMDPbCFtuqYf2KIoEbwwnyHbCTwjvJl?=
 =?iso-8859-1?Q?RGMukefCiIfOa8pdvUH/geU8/m59Ux4AHPJMVmBB9/ItXHZWhp7aU0xAML?=
 =?iso-8859-1?Q?2bJiQPlvHYf0HL/MCcDsl4NQYEcx0XKtJ4wE7Tk3RpdGi55Dri3uhjZKOz?=
 =?iso-8859-1?Q?6aGy2d5FBP5XGuAFK3nXPSFRTpT3B48q7Y5yoKnvzLdyZlMI3/H5lNTwKA?=
 =?iso-8859-1?Q?YqXJDrfr+lsUU2wJdB07f8oHdUm/8IbeHP5+iYckzy1g12bf64o2j49/Ks?=
 =?iso-8859-1?Q?IauWKMa45LG7fQJvFeIQPdYuICde9kzRiE0ENH0hResWGeDZDwT55mC3v0?=
 =?iso-8859-1?Q?o8Zf3XuKMdceL42L6QLmzHnCEaRAv1qlLfRgAJyKF5E8lQ3jxNgwF266gt?=
 =?iso-8859-1?Q?lr6Y27s6mgt9DnXX7CWxe8cohTByXOm1baeTi/pL8+UN3hU1hw1tAGC6zu?=
 =?iso-8859-1?Q?9s=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB1661CCF8EF1FA08506B3B6F887670@MWHPR11MB1661.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(68736007)(446003)(54906003)(386003)(105586002)(6506007)(106356001)(486006)(71190400001)(99286004)(71200400001)(478600001)(76176011)(36756003)(11346002)(72206003)(6436002)(110136005)(107886003)(14444005)(2616005)(476003)(4326008)(97736004)(86362001)(316002)(6512007)(53936002)(2906002)(2501003)(256004)(6486002)(305945005)(186003)(81156014)(50226002)(81166006)(66066001)(7736002)(8936002)(102836004)(52116002)(14454004)(3846002)(26005)(25786009)(6116002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1661;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DuAZV6eqB+6dGBvljWQHzKT129AkY9/MCC3L3Hsmw7i/ek8+LALM8eedR2gtofRaeucEZr/4gg0Dv0AoUKbE7V691Dmu8SML0fcvfq6VbcWJrNHZwiOo4BVDe73E60T+nfW5jUdM+GbknvtEsuGmYfuCT42DZZcLBpDm5NxW6+KAPvi2yqVaxyTiF06gUneL4dlZRG5fb7F/5um4iFzSkxqsx7B0yi2OGdEWsI4fePGKcWG7BvLkZM79x4YV86EV0y8uQQqFW1DCbnHu7P+4pbf62Oc3+sQSJ1kiohzirCNnmRUvvZxptakn0NsxwxJurJbsc8dlBRxJJ40OIgWXoMDE7Thyx+jgCUyHXdtEaMeCR0rnkar/NXKgcVZu4KY6fM3c6KDO/sPx8WT9w8Wa+YWk8Heb7yY3hjLBgfcK20o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eb04f0b4-4d49-4380-8e9a-08d6926ef53d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:24:13.5118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1661
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for SAM9X60 shutdown controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Docu=
mentation/devicetree/bindings/arm/atmel-sysregs.txt
index 14f319f694b7..9711052c5800 100644
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
@@ -95,6 +95,10 @@ optional properties:
   microseconds. It's usually a board-related property.
 - atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
=20
+optional properties for microchip,sam9x60-shdwc:
+- atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
+- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
+
 The node contains child nodes for each wake-up input that the platform use=
s.
=20
 2) input nodes
--=20
2.7.4

