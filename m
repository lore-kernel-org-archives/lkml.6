Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A0C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD8A21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MB3byvLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfBSKJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:09:07 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23915 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfBSKJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:09:05 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; 
   d="scan'208";a="26786216"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 19 Feb 2019 03:09:04 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 03:09:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZGOSR1g9LFEuJOO+7Wvt6dIrM6mmIVE57s3Da67Kso=;
 b=MB3byvLg67iid78B4iPxVGDkxe2M6oCBpw6uUjBDLfNhHjTWih+kLRe5TF+F5V077H7RbhaFkRztYBVzIbCn0aXeC9EIhM4Uekg6l8D8NCN7yRDohHxpz/pAiZkwTViKYofSFDQ2N8neTpVi+NOvBOsaa/4SS9hTJUR+D3bDmYA=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1831.namprd11.prod.outlook.com (10.175.60.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 10:09:03 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 10:09:03 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 4/4] pwm: atmel: add PWM binding for SAM9X60
Thread-Topic: [PATCH v2 4/4] pwm: atmel: add PWM binding for SAM9X60
Thread-Index: AQHUyDskV5cnHEUXUk+WmXSCtX3J5A==
Date:   Tue, 19 Feb 2019 10:09:03 +0000
Message-ID: <1550570914-26391-5-git-send-email-claudiu.beznea@microchip.com>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0090.eurprd09.prod.outlook.com
 (2603:10a6:802:29::34) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 400c3b3d-4b1a-4521-6710-08d69652464f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1831;
x-ms-traffictypediagnostic: CY4PR11MB1831:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1831;23:bjRZdlxPn2M27JRsrXQRqNeN1+2bpJDdQDnoA2u?=
 =?iso-8859-1?Q?g5ByYq5RYMdxepT8n63vw90pKpLXQHi3xC1CTUO0MPxMbSvxz9vZhfIxl9?=
 =?iso-8859-1?Q?QHBWAhMqB7oY3eGso5FEhoyjdXXBC2DMQHpXBp8WXUaPRhQMxaLYLbWKIC?=
 =?iso-8859-1?Q?4Tdscvktoj8tf9XvYF69gGfi7CYPDPr7ljOTV9WWotLFwRwYHC40CWdV3b?=
 =?iso-8859-1?Q?nzmu9jsxvhsbXyvaHs1CgWt1Y9VNkSMuYFfBR/an0GNZQKoZnWv/G9wImd?=
 =?iso-8859-1?Q?crl9G42f9DJtp617crYxppM8DFPsPhPSuYqneoMzkXrfJ1l2BWe7zTYuzz?=
 =?iso-8859-1?Q?7iF/NY6ptjpcjR5L0yI6Ga/IsrV/nD7RBCb2joNoAg+w3u3ggPg0+GkEcS?=
 =?iso-8859-1?Q?YiZvmQeOIvWJgDhRRv9XzOkYJE/JMmm8WcHSj8rmOqpcu+BDPePP3+R4BM?=
 =?iso-8859-1?Q?i8hwVkbgBX41GzUBxT0imoK5lVKTclA2TJv3GvPcE/F5MNU0lGCW0V7ct1?=
 =?iso-8859-1?Q?JpF6Mje8OqTzJg7ojBJ3UjzEoh91Jvs/N2NCJlgG+wAgjvumK4djZJF5yF?=
 =?iso-8859-1?Q?J204A2UZ7pozoz53Rfy0IricbS+Kt5JM7qsCKfWdHj3p55i6ZtoYE10oZs?=
 =?iso-8859-1?Q?3lX20jmnO6IhOYiA8EDSWXGlGYolWtGBzxPboxdbQtacKsui1X152Mdg2+?=
 =?iso-8859-1?Q?JNm7UFyGZyu7l9NN5EXj+G13HpnahWDpFTFtU/dzTzmeGi7Yo91voZoYqz?=
 =?iso-8859-1?Q?EK8Ua03gYiudHTgMIzxTv25tZJ11FLs2ZvmXYbQ9NVBb+wh/DKwMe3z1bi?=
 =?iso-8859-1?Q?JGOBdSolpBqeBO+YupxxTBTqkhHr+GC0DAAsuL2swslzqhRxeVenBd2487?=
 =?iso-8859-1?Q?zB7FME0c03lN+h9STUnswMlbY5ojniF/GDEp6/DxCniuvbvRuOJ0yAWLBK?=
 =?iso-8859-1?Q?B2LlSAZvx3l4204LZrKfVnVfdwbA0Ogbh76V//nSQX5ZKH26vCMDvnvCmM?=
 =?iso-8859-1?Q?YGbjelFiCbNbAcwCtvhdrqmAaZFKY3TUmP6w3QjvwtG8T7OdD3coVLxxiV?=
 =?iso-8859-1?Q?8n0Rgh/xwxIy4rswewo2Lj4XXkTQ6iKIuB6hpksdFNkMVrPtofVukxm3zL?=
 =?iso-8859-1?Q?5dHs5/6eoQ96lgu3cvbJoVReuKgVsxpGyk86WfIxQwwEzztwVPcx+c4HOy?=
 =?iso-8859-1?Q?j36Dc4uGcK9Au9h74r2ryGeBi6EAVxyM1kTcft2izHYOGCVV2q70Mtqocv?=
 =?iso-8859-1?Q?idEc6lQPKrdNj/hYYpZFR143vDTYNDNYoWPgSdhhwWiITr1zNs/zx16+E/?=
 =?iso-8859-1?Q?GccTfmFyDyl9Cxdr9zTOSMgJMmO3TPqYQd+/fumNoC+2Q=3D=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB183140BFDE421CDF97D6C83E877C0@CY4PR11MB1831.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(6486002)(53936002)(446003)(11346002)(2616005)(26005)(486006)(97736004)(4326008)(76176011)(14454004)(6436002)(186003)(25786009)(2501003)(6116002)(99286004)(4744005)(6506007)(476003)(102836004)(386003)(3846002)(6512007)(52116002)(107886003)(5660300002)(71200400001)(71190400001)(305945005)(8676002)(81166006)(81156014)(36756003)(7736002)(66066001)(8936002)(106356001)(478600001)(110136005)(50226002)(54906003)(2906002)(256004)(68736007)(6636002)(105586002)(72206003)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1831;H:CY4PR11MB1909.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SK1NmSCwBCvPQ8Q1xx8onafVyItJjasBbuIUD5fnHxbNMAS0l4/EMphvmiWsZOovaMhWnxuVDVkKF/sXvIFKlGI1Oy3ThcSbXQTmY1dUmjBhm5JkcwFpK23PZHMIlWVn0L1JZrax/krbX7TIi7wRoclsf/b1szdaFSMP2xzf9qjqLvulpQ8j9n63Ac6Zjrfnc8UpLUIEwwJfvOioOK0ufhcrXzaFJogZQc5lVjElVDAXqzXj19O1g2V5xUjJyJmypHQ1yxso0XdCQtvoVrYhU1ODHTq+W+jsNv+hh4nisuxFKpVnFz1aHAhTTTRB8a9H7qCV9gCu0WMen3t5P2egTqo9X53E8XFjoe3FBRWalxVq3/+1pH+2s4wBWIhcUBNOVbCuaXUzNBs1SstYGD30vSKU54Aaw0mZOrm5pOhWYDc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 400c3b3d-4b1a-4521-6710-08d69652464f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 10:09:00.5496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1831
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add PWM binding for SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Document=
ation/devicetree/bindings/pwm/atmel-pwm.txt
index c8c831d7b0d1..591ecdd39c7b 100644
--- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
@@ -5,6 +5,7 @@ Required properties:
     - "atmel,at91sam9rl-pwm"
     - "atmel,sama5d3-pwm"
     - "atmel,sama5d2-pwm"
+    - "microchip,sam9x60-pwm"
   - reg: physical base address and length of the controller's registers
   - #pwm-cells: Should be 3. See pwm.txt in this directory for a
     description of the cells format.
--=20
2.7.4

