Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9F1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B67F20844
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iNQKwuPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBGJZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:25:15 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:4660 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfBGJZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:25:11 -0500
X-IronPort-AV: E=Sophos;i="5.58,342,1544511600"; 
   d="scan'208";a="26242029"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Feb 2019 02:25:10 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 7 Feb 2019 02:25:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLggGKG5wq3yZ79elzkDDE5+DGZEY2x72uCaCn1nlac=;
 b=iNQKwuPzTOS+fopPGy6KmlR+XGpTUYZBgsz2udjFDFh2pslWRzbNRK6aV4T3Nkiv7o1+u29CeLD+zso3RNkf+UrBiybOOxXGL0X+ZH2dsvgzz5CRr8HiX+QLus+YZdJgwmOv0CUcu5fYeaHd9FcykcIJs4+K4Lm4pal7JBnE1Bs=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1952.namprd11.prod.outlook.com (10.175.54.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:25:08 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:25:08 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 7/7] dt-bindings: add documentation for slew rate
Thread-Topic: [PATCH v3 7/7] dt-bindings: add documentation for slew rate
Thread-Index: AQHUvscEJdupxwuMJki/fNlPXGz4SA==
Date:   Thu, 7 Feb 2019 09:25:08 +0000
Message-ID: <1549531468-1676-8-git-send-email-claudiu.beznea@microchip.com>
References: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0350.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5a::26) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1952;6:apkW9nbLJ0HV68/L9jGnI8FnNFc+rYNRSA7hduUpn5eV1uxg/WL2YfspMF6laOOMs0Axxvdhz/SVMUw0SWFV0fsAEdQ0GMg+1VPwpyamYKk9Gqnmhe3a7gYzvwY0tthYyIC67g/4DRC/fptsyHNlUcla3dWwtiZYyINJeIebrMVVIszRD+EBct/PGHQtxpOgzYCmylciiji7k8cYuG+B87g6/x8ghN8sSxoqZx46oHvqqHga+u74RukGUSGyhhY/ie/H5Kfi66Sswt7DuiwMsuOj+/GeTrv0ax+FH9Xp+vFv5KaBgA9yX2xx+NYSqa6tDVfwS+nQu1Xlv6oyft9OKwyIccK9v4WfCjfpK1Jz6nI5rwSASA+B7lsPzGj9q0o8jMPjJY6MXbBlKNBFPRJ5ukExB1NcRBzYvsvh4AJkRrgrUKt4gICaHwRpbn9DFh5lxWA8X3chCjHUGhtZIPhf7g==;5:cimSB6IGYQPCCV458MxTQFzRuW2Ysivi3f+63QoE0injPTFlDqdjLlFHhOuz6pFWzL9Nu9yJE4DMo4mEQvN039XUipIN7G79k/AP1g/Bn5l9VUgEjyjTtXSONQe5aFZo0HNBaI68gnq+PNC3q2E0ItSn4lCTdlB+sIeYOuayoyz/AEtB3wrvyNQGMVRumbEUWCNs/vJGec28R6LUE4XdMQ==;7:d+YvIue1PpJrlT6wcl83sPX2TodpELSn67qx01yOFhWLGCF8F0c7Ak1QftByBfjNlpkGvTDJ/wdoyjP/VgS0n3nejsopd8ZMt4V2hOMmQVFhLCpp4k/VmBh0Q/xCkQ6pvbIFXKCtSiAvPJPkjgeUlA==
x-ms-office365-filtering-correlation-id: 42ffa1ba-1e39-4a4b-bc8a-08d68cde26c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1952;
x-ms-traffictypediagnostic: MWHPR11MB1952:
x-microsoft-antispam-prvs: <MWHPR11MB19529DF782C15DA5983C589187680@MWHPR11MB1952.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(6512007)(66066001)(486006)(2616005)(476003)(97736004)(25786009)(106356001)(6436002)(305945005)(105586002)(2501003)(53936002)(26005)(50226002)(186003)(3846002)(76176011)(6116002)(110136005)(6506007)(102836004)(2906002)(52116002)(386003)(11346002)(107886003)(4326008)(7736002)(316002)(446003)(36756003)(8936002)(81166006)(81156014)(54906003)(99286004)(6486002)(71190400001)(71200400001)(256004)(4744005)(72206003)(6636002)(478600001)(14454004)(86362001)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1952;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BB0ZWZeVpfFVkCOnQpCx31ZmHaXbbrN0WH4ktnZ9iFfjIMcae0q1ckrwD1RAIHSFARcBC/Fk6a9i1WLz1Rhbg/+1lbrPenB82FAE5udzUQBJHd4RNgOS/DjuEpFKhfttHuwm7wIgTgSXZDEh1RbExPyEIirVRoIw8F0+M2NCgXCVYoCy3Yo+HR3iNwL4nJdSvKzwcSmxfLJsRdGb+iLXfxEYIxh8P9Dx4VzSQLMvn4EXDZUSG/lv3pMjG68RZTYEOQ8VCUcLLaKWdzXuVDs0P007p5HD/LCPNY9YtrF78bpRBodVGbTPP+TpPao8TKaFHaqAWfkLuzmiTIcvc7zygVsTVh11UT9j0k95qYTCZ2A3xdAuOOU+dEES7I47plGNHeJ/un76R2Llkm0Uf5LJpfNScSR9jJI3h7l5cxScpBg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ffa1ba-1e39-4a4b-bc8a-08d68cde26c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:25:05.4214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1952
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for slew rate.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.t=
xt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index c2d51ed86d47..19c255346a49 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -100,6 +100,7 @@ DRIVE_STRENGTH (3 << 5): indicate the drive strength of=
 the pin using the
 				11 - High
 OUTPUT		(1 << 7): indicate this pin need to be configured as an output.
 OUTPUT_VAL	(1 << 8): output val (1 =3D high, 0 =3D low)
+SLEWRATE	(1 << 9): slew rate of the pin: 0 =3D disable, 1 =3D enable
 DEBOUNCE	(1 << 16): indicate this pin needs debounce.
 DEBOUNCE_VAL	(0x3fff << 17): debounce value.
=20
--=20
2.7.4

