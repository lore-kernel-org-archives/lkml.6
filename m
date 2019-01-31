Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD2AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F190B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2pKWSrey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbfAaQSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:18:38 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38524 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbfAaQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:18:27 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="23261735"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 09:18:26 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:18:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GMg+yVpiwuQ9JyQO6QIbZ921QJYFkh4TXk33lG/aT8=;
 b=2pKWSreyW67sEL8nLP0pUEXU4V7cbkJCEK8yQGAux8XKPLa4/uvfPjGFIjp94YRUjMsqPjK16FzyA6kIeCb7MpmtXmFd6FN/8l2r0DU/3nD1bIo66VLmRY6R1K37sTp1I6px4TTfwJchNiX0376tv5ObZOc5fmlL7AtjnSHpb30=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1424.namprd11.prod.outlook.com (10.169.234.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 31 Jan 2019 16:18:24 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:18:24 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 7/7] dt-bindings: add documentation for slew rate
Thread-Topic: [PATCH v2 7/7] dt-bindings: add documentation for slew rate
Thread-Index: AQHUuYCXsXLnl6cDqU6b9bkGn1Xsmg==
Date:   Thu, 31 Jan 2019 16:18:24 +0000
Message-ID: <1548951466-26297-8-git-send-email-claudiu.beznea@microchip.com>
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0116.eurprd09.prod.outlook.com
 (2603:10a6:803:78::39) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1424;6:FI/OaHOaggLV8nAk8vd+47IdDMFbi7NLIcpKk69/2ES4DbHfg1hsv0GqiKKL4dHsUtmR+lTPfjXXSi7yCqkJlXLvV0FCNE5JMgLKY9n14eCctL84VROw3AW5vz0j0r1e/Iubqk1osyur9xI1f7oMCrMj0b65QRSgt91QTX3vQTNWFcQPIMYwiHFnItAYxFY/QO7+iITnUrd49K14IOmeAg2kpLEJpTJ+PdY8xqpnr2iOD+fML7VQJWR6EzkFoVS3fhRUGGtWynB77utZzrpR8UGYiYYhi5q2tfN8MLr7O/bIsFDDm8pMjBaRYSWKFuBQRh1/Sh9QhOQ3J97yOQo/9s+3TA63dWb65aAKikQHFbQVNBKHXgtgWZ1odc6VxjgEu0c6NZz7DCt6WILr7rGnUTMz2PNsxaCHv/Y+kKOdKkV1pr5TsbSWIF+wVHnXX8uEO4XG83M9F+JcEOvnsdxEBA==;5:EjiunpUqRxjhBoLDovaoNk+wbu/SIv/trLWGcPDJ1e7matXwieGA1lNe687vLlCGLE/F/16O9ahygFI8LVUQRn3p0k/Qwcy0TNNzKPhVa4jRlsYkxVs1cFJkh6v6QdvNNdBF0NFa7FqhaBtHRYIJrE8TMuK9AMT5B+1C43HAjhuRK9ZykYp3mSB4+tCtKR+EiR4b5GZpo0YRO7OPvv2hqg==;7:lKqTAm6RWi290K0IBhG9ibi/91G7G+LXatyqqIf+EzLTrdlGVzKMIsTlPGc3YSszow10HNcmFmjtOSc0DAf/ZMfnEGI37x/8VEh5T9OGoqgv8E9Hdx5tBbRvwmUDAH1KP9ZTBNB67GWtohz7w84KJA==
x-ms-office365-filtering-correlation-id: 1d154e1a-5125-4f32-e331-08d68797b963
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1424;
x-ms-traffictypediagnostic: MWHPR11MB1424:
x-microsoft-antispam-prvs: <MWHPR11MB14241E36FE36C1165C7E887587910@MWHPR11MB1424.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(71190400001)(186003)(6116002)(81156014)(107886003)(99286004)(86362001)(446003)(8936002)(2906002)(53936002)(66066001)(305945005)(110136005)(72206003)(8676002)(68736007)(81166006)(3846002)(478600001)(25786009)(50226002)(54906003)(97736004)(4326008)(36756003)(14454004)(7736002)(316002)(52116002)(102836004)(256004)(386003)(71200400001)(26005)(6512007)(6436002)(76176011)(6486002)(2501003)(2616005)(4744005)(6506007)(476003)(11346002)(105586002)(6636002)(486006)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1424;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +fvZxNeXrDnGBQI0cyCep/t51alAChw6OpZg2u8xXR7ZBx1bTcAH+ZRG+uOdptsdsoc9i4zr2Z6KH7DsGf+8egz/8y0XT4ZVKAU+mmZlA9PHeIWpizDJ1O8/0peieodLz1OpNdVKfZEF7G3BzkIxPfg+8WKLUQx2htn8Hwu3FqVXUWuJyK1gda6A3pfvk2QDaiTnqtMBgkxIKTsi7M8B3qBzlYfIvkAmc38RKPglttw+Mbkz8vpc/QOnxmOvTZ3usMsmIHpRcJTfGrg/il040NtnVxdxgaFqwiQFYzs/qeVgLIRsC+sRQOVTypzCxSCNEdNYRjlpmFW/kV7VtjO9fSVCc2beysxQB6eg8gclKG2Udl0eBnhSVgL/OGITWeTr4MAfS08nVu43wBnAZQQRK5GsT945ELX765KjMWmGXUY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d154e1a-5125-4f32-e331-08d68797b963
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:18:21.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1424
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for slew rate.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
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

