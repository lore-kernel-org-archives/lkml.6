Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019FAC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA17222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FwOKoA6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502363AbfBNPyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:54:45 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:17442 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393216AbfBNPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:54:44 -0500
X-IronPort-AV: E=Sophos;i="5.58,369,1544511600"; 
   d="scan'208";a="23863288"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 08:54:43 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 08:54:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATHP6A5171az4nQE4H8FItr5BbagYe0Srq1cthSg0g8=;
 b=FwOKoA6Ioq2S1jIYE1uy61TV4Pacozj5t4PqQtSPY8iu+cnynhpuXfRLsyc2rMxQuzNWl/iHXx+80iC50hqePrdLR1KYKAC/+STnvMCkxd5Btuq63qVP0XSlIHZvJwZpSMCrTcj++CS1u0kByNlXHamt/E9Zzymo+2H2IW5y0Ts=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2031.namprd11.prod.outlook.com (10.169.236.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 14 Feb 2019 15:54:37 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:54:37 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 2/8] dt-bindings: arm: atmel: add binding for SAM9X60 SoC
Thread-Topic: [PATCH 2/8] dt-bindings: arm: atmel: add binding for SAM9X60 SoC
Thread-Index: AQHUxH2WFsa+KrpqTkKweEGzFLdhNA==
Date:   Thu, 14 Feb 2019 15:54:37 +0000
Message-ID: <1550159642-26878-3-git-send-email-claudiu.beznea@microchip.com>
References: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0098.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::24) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca2bb961-0adb-4f46-ae12-08d69294b864
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2031;
x-ms-traffictypediagnostic: MWHPR11MB2031:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB2031;23:vn+v05ThmpDJZmfTRGf4OcaHTW3zGT8wSzoxabZ?=
 =?iso-8859-1?Q?8g/8jPP01h433VJMUCJJh6BAcf4N8sbKseGlZL9rd0JEWMUFvjS2ju6Eg0?=
 =?iso-8859-1?Q?qR74QUpur5oMghKFaVMk7wjT7DJEVtopfIYFO4lnKZ9IiPJU/EKIWm5oNU?=
 =?iso-8859-1?Q?C5RESVgkOibq7d0PFqfv4txO5a7YmGPaHWZddxNwElcfJ4/FA9lSZJaL8T?=
 =?iso-8859-1?Q?Lwg9OSexzzgimrvIfxGLr5ObiEnQ8lbA4w+pSS6Q0tgTdfOnvByRTK/Ch4?=
 =?iso-8859-1?Q?308dmu4t9baHdvyoIz0eb5cp/L3rDtbsE+hqIBsZkUeUmy1R/S0HfIrs+p?=
 =?iso-8859-1?Q?pEsR/O3PJp9zHmOnBj/9Bf1rKEjxYrQ4KiKLgNTwiXjgz5Kn/ma+kkRflq?=
 =?iso-8859-1?Q?KiczQs/0AUboCwL2+Ymlq8ag9i1dhQxmyuIXaz97wxVlcyM07POiVPte5d?=
 =?iso-8859-1?Q?adIItgBguBFmdRJd4p9OkSPFt1cP6mctM/wkTvzsO8gtBc9wZ+86aOXDAI?=
 =?iso-8859-1?Q?giFcszMw93TLUyvNChbYJmM/bbTqHSh1ufApVgaXYJ9Gl9l6QfckH8Q7oQ?=
 =?iso-8859-1?Q?0D1O0GzZ6MMtupD0fx7kDqDRVIKkVYLo0QOljdOMOJZ3jqGA4VOM0YlV2g?=
 =?iso-8859-1?Q?PNxMontKss4tKtjITfFlo1mEA+j0yJeV3GUTs+3PMCSu6HZvst9nd26cY7?=
 =?iso-8859-1?Q?qnZrGZ2eHNMtzT0oG4i1HDY8+F9vmklB7Squp/3elKoHua6cNUOXtJd3BJ?=
 =?iso-8859-1?Q?0Gg+Zcucp9W2ETcx/Xj0KXx4EvRc804jege6YLklXXWc7Z70OBJH2AHmkj?=
 =?iso-8859-1?Q?K89lPl37M3oz0PecT5n/UniLW+4C69wb8qutpU4m/wDwsTtmI1odPNx5Kb?=
 =?iso-8859-1?Q?I/wvBCJG/DZRiMIkls7136vD9WYmMDpVMS328fsuFVNMMDPUqbmry5F92h?=
 =?iso-8859-1?Q?b8D9uYakubDhKR1T7dw3H3h0DCaMTVgKuJLJd/m/7S3pzuU0bwDLTiyalK?=
 =?iso-8859-1?Q?RbYtEwx2cKWZhlvYnM3onmbUMKSpKyssc+i/Zn0eF/Wc4EIKNZqCHjqq4N?=
 =?iso-8859-1?Q?UJss6ovsy4VlrOutRWfKw04IzNDoeNDXR0KYzyA8+vW/u5OUXzO/qw59va?=
 =?iso-8859-1?Q?KnqLwW/nJgui0/graQKGKtwiZZg/XDxCXhmeMFEaHSAdAHNtyZ9cw2aTy4?=
 =?iso-8859-1?Q?ofFU3tLko7VCGNQl+eJkPxDiy+xuN1BDBlALU0Jlrwoo+K8BHos93tp35y?=
 =?iso-8859-1?Q?dUC5qMrFzmYV38F8SXda5hegfW4nReHOQiBRgIioqU2I1Uxnvvm+GkBU9X?=
 =?iso-8859-1?Q?V1ugq/wTwNDHqafBtrkVWVQ?=
x-microsoft-antispam-prvs: <MWHPR11MB2031604D3D54E020A115D6D587670@MWHPR11MB2031.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(366004)(189003)(199004)(97736004)(6486002)(4744005)(2906002)(72206003)(14454004)(478600001)(81156014)(36756003)(2501003)(71190400001)(71200400001)(316002)(81166006)(7416002)(110136005)(54906003)(6436002)(76176011)(66066001)(50226002)(256004)(6512007)(106356001)(8936002)(68736007)(52116002)(2201001)(26005)(186003)(446003)(53936002)(11346002)(6116002)(7736002)(3846002)(25786009)(107886003)(4326008)(305945005)(99286004)(8676002)(105586002)(486006)(86362001)(386003)(476003)(6506007)(102836004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2031;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z3m0qa/I13YuBy1PhkC19yAePXtUkK0LLLP6sPq8dS/Bao0XGE8T/rIBr5es6eNzpNnEhGnhkphueeZPVAnqQsHIvF7drhBRnm4uDhz+ziyytbDYzB+p3rs3Ww7DsmDb7oyQORSUMEOkWXv/NH8S+OBTUxHwXwPRIZYwM4eJ5makI9BmNxVDteE6LP+SMpD2g1LwgwT4WmwPETl0O1JAy1x6w43VoAr87P09FoqT5pcSjflJu/jhU8T1swHdZFSLqTqfbJhgz58JZ02hDa+65zklFOKmMjTm0ktQCgbGARWvZ7S1NE2fvNnTbz4QEIdvcRC1LgJ5PB+KE+IE03+xSo/Qgl87E5Ll2EmMSYd/CjPowwmcmhTMy0rS8bBu/9tCNwLTt/SXqDQPlC52/0KcGBjO+6D338iYOH1ZkJzxOs8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2bb961-0adb-4f46-ae12-08d69294b864
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:54:32.2069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2031
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add device tree binding for SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documen=
tation/devicetree/bindings/arm/atmel-at91.txt
index 4bf1b4da7659..99dee23c74a4 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -25,6 +25,7 @@ compatible: must be one of:
     o "atmel,at91sam9n12"
     o "atmel,at91sam9rl"
     o "atmel,at91sam9xe"
+    o "microchip,sam9x60"
  * "atmel,sama5" for SoCs using a Cortex-A5, shall be extended with the sp=
ecific
    SoC family:
     o "atmel,sama5d2" shall be extended with the specific SoC compatible:
--=20
2.7.4

