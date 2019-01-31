Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7750CC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9D12087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="az3qsUk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbfAaM3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:29:45 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62229 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:29:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="24062169"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 05:29:42 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 05:29:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYqspmNFAUbFySL0s4zvp/ZRaf1bSegw+rvJX47QWyM=;
 b=az3qsUk8b0RQMrcoNzNX9Wh0VySzW9M1R0qwsrYjZgh8zsMitqnzUGJYErvUEMthRDk00PHRm/1LmpfFT9oxw70JNf3Ky0TFhbwAYvddEqZrUOadHujXLsLUEqcenbza2kCKMza97a1a//CF3aut0FzgcU6cFLXalOG9IlLpyT4=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHSPR00MB253.namprd11.prod.outlook.com (10.173.106.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 12:29:40 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 12:29:40 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 5/7] dt-bindings: add bindings for SAM9X60
Thread-Topic: [PATCH 5/7] dt-bindings: add bindings for SAM9X60
Thread-Index: AQHUuWCir7og2SWDnkSGJmoyxHy/zg==
Date:   Thu, 31 Jan 2019 12:29:40 +0000
Message-ID: <1548937733-20189-6-git-send-email-claudiu.beznea@microchip.com>
References: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0036.eurprd07.prod.outlook.com
 (2603:10a6:800:90::22) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR00MB253;6:DUjCeE2vLGDg9MoEPo5IydgRYXCLSA75Z9reyaK7fGqCgXa4s7OTvXxfiKclgV+bBmqAOSWdZNtm3EcCtJF2dcTUuKaNPubgP3xu1tDpmg5RQJGLCSOTXTxwklqmxW/+KDdsKxyKc+9TPF+dVqzQ7oz0wRNd5x/0stTdMQpwiVEjx+kxOgOiFbncl5VymizsFIBOQ49MK6FtmTPLFuPx3SNJW9Fx8VjK0a+6PkjHjGtFiiUaz6M67XVId3IZl7VPJnb5h0MpQjNAmhwe3EDolXt+R7tiE7T+hQZ9V6nJd7J1id06lTiS811cVNHvep2HLffvJmFgWYO1MZ93pB8yBHk89xDWoNsfFmfm8ZtOBmUqNXJ/CK++M/BrQW4s6iGIU/PnC4mEGPPcEMnob6Iv7HPwapN90itOzWrncoWmTBmAzkiO0xemaUwPZlBO5QQG5qBnqBNJPO+26z5PnHQ7pg==;5:Hq6HCgLDNwG1TVg0mG8dNhNaLV+ss52wVtfjjaWfpWXkNJqmaR1kqkZLY4M/dU/JUvoqrFjkfz4khDWku+L8EH/k4HT1sZN/s4zFXpjj9dhCU3Js1otQgrVd/OYQHSOPGHLslT9kCvJlLB8rerEHMjXOzLtppbITz4FtmYQNialuVlqIYf0tWAUQQgNGSN/+2eRv2fEIuB45dkCPpb2dfA==;7:8hOKcTErpXLxX31I6muh3/FoWA/lxADL4HvzMu+kGsMvHc8UCKKXi3sxB2TB35AQo51sAGfizmFUxV4wpwr1YT3zDOIpvMa0EZkiXL/xn2lUl45ZGvq+CXmSkWcI1wxaw2YYF7cXqSmlGnIqh5/QDQ==
x-ms-office365-filtering-correlation-id: 4ff7a7e6-a3e5-40e9-bdcb-08d68777c532
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHSPR00MB253;
x-ms-traffictypediagnostic: MWHSPR00MB253:
x-microsoft-antispam-prvs: <MWHSPR00MB2535C49958A1CD80E1072F787910@MWHSPR00MB253.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(86362001)(14454004)(106356001)(8936002)(186003)(8676002)(50226002)(36756003)(6512007)(478600001)(72206003)(105586002)(68736007)(25786009)(81156014)(81166006)(256004)(53936002)(6116002)(3846002)(4326008)(54906003)(107886003)(110136005)(97736004)(2501003)(71190400001)(76176011)(386003)(6506007)(99286004)(26005)(102836004)(71200400001)(11346002)(7736002)(486006)(52116002)(6436002)(446003)(6486002)(316002)(2616005)(305945005)(476003)(66066001)(2906002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHSPR00MB253;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VLGaT/TM3cV/dIRuyEgBG7JN9/jLpPA0J9yeYUYMY4xYGLgXA+M9SZ7i3P29qsyaZwI8F40siVgp/5cAmxqN8+j8Uvkk8M+zQJuFjJoZmzXi0w77GZCCC37V/Heu84znoR94d4bJ/ekxE/ly1BQ86tbfXm5vjVCUFhe0s+/yquQmhn6X9APf+BcqllIHw9zgTDskGAFoQ8zvfTIv4xkX3RfHP+kuw6q2/N1A72ZxqfwX/BBRMkXob1blNd0CBj6o5zPPDkmYkqHoi0NN8wpEXyWKuHNUtLyiGvOP6kCHvQamtxEvMDAxPqKk0viNWi8FE5uq/lDnqhwXceWvtCqrfoTR1BouTjlPHsLVEAxp0R+6p8LOlyQEedPvvMZhFp1SmYP2rb70TXEx+JV0KXGhK9Jig/kytN+enXNFbGB79PU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff7a7e6-a3e5-40e9-bdcb-08d68777c532
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:29:36.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR00MB253
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add device tree binding for SAM9X60 pin controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.t=
xt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index 40e33dfc36fd..c2d51ed86d47 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -19,7 +19,7 @@ such as pull-up, multi drive, etc.
=20
 Required properties for iomux controller:
 - compatible: "atmel,at91rm9200-pinctrl" or "atmel,at91sam9x5-pinctrl"
-		or "atmel,sama5d3-pinctrl"
+		or "atmel,sama5d3-pinctrl" or "microchip,sam9x60-pictrl"
 - atmel,mux-mask: array of mask (periph per bank) to describe if a pin can=
 be
   configured in this periph mode. All the periph and bank need to be descr=
ibe.
=20
@@ -117,7 +117,8 @@ Some requirements for using atmel,at91rm9200-pinctrl bi=
nding:
 4. The gpio controller must be describe in the pinctrl simple-bus.
=20
 For each bank the required properties are:
-- compatible: "atmel,at91sam9x5-gpio" or "atmel,at91rm9200-gpio"
+- compatible: "atmel,at91sam9x5-gpio" or "atmel,at91rm9200-gpio" or
+  "microchip,sam9x60-gpio"
 - reg: physical base address and length of the controller's registers
 - interrupts: interrupt outputs from the controller
 - interrupt-controller: marks the device node as an interrupt controller
--=20
2.7.4

