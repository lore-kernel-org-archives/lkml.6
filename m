Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCF3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D5720842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="LSAm4N+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfBYQpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:45:36 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:7849 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbfBYQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:45:35 -0500
X-IronPort-AV: E=Sophos;i="5.58,411,1544511600"; 
   d="scan'208";a="24421572"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 25 Feb 2019 09:45:29 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 25 Feb 2019 09:45:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZGOSR1g9LFEuJOO+7Wvt6dIrM6mmIVE57s3Da67Kso=;
 b=LSAm4N+lQW8pIjBlRkd30IaRyeg08WxtPhIjQoc2oKUCfZJ/wPJJ1/1tuLWJ9CTnijDFVshPrrgN5mW0pIXYLo9LwnyxoGGq+dB1tGpYMCyz4lsPWQc5OKmGlToEboD0FF59qi/aFmXmfVuUqMNbX12T+KXTOBODeR+d4YXIf4s=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 16:44:49 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:44:49 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 5/5] pwm: atmel: add PWM binding for SAM9X60
Thread-Topic: [PATCH v3 5/5] pwm: atmel: add PWM binding for SAM9X60
Thread-Index: AQHUzSlrzzDAx+7tqU6t3+zL6g2t9A==
Date:   Mon, 25 Feb 2019 16:44:48 +0000
Message-ID: <1551113039-937-6-git-send-email-claudiu.beznea@microchip.com>
References: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::30) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfe0a0e9-002d-4a69-42e8-08d69b408e10
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1662;
x-ms-traffictypediagnostic: MWHPR11MB1662:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1662;23:5pnyKKdln87VdsSGsKTW8tJsidKJ9ba1KGWEPKs?=
 =?iso-8859-1?Q?m6Zd7iaZWFVuXmFGNnRozB2Vv6ZB2AoI1DYqOQ1lL0OTOdPcVUSARMJyuB?=
 =?iso-8859-1?Q?48hLWVsYAPVguEjtKF14c6WShhoeIuo+aptsyADMKLi7cijToL3WJ2z13D?=
 =?iso-8859-1?Q?SITgDg1VW45Ubb+LzVqY6cxyIVCkFznTcjplSjrvc/YP0MHgHJhrg7Dnnk?=
 =?iso-8859-1?Q?D13bSBM5pQFq9eypN2iq/apqfNtRJnQNyRlbee5axcgjgiGD119majNXPV?=
 =?iso-8859-1?Q?i1lvWHLiG/VDeySb8+wy1TVvNabV9BYdXzQTpTWthi+S1SyWsv3rb+RBxq?=
 =?iso-8859-1?Q?/cu20S0167Ru8siWrhFt/ukN/Tskt1sCJahFkCYhbbSs9b0x7v/O6ds9di?=
 =?iso-8859-1?Q?labtmrfe7DqjQWRnm84H1rYJ0stPPEal1TKWMDpqhhDZPWs9aJzVjaclkv?=
 =?iso-8859-1?Q?t88UbQRU6dO5aeTZQRTQg8N8P9hvL6QBMXtltTEuA+fMPsZqFEjoIDzzNY?=
 =?iso-8859-1?Q?ed1PKbMX8dXxsrm+rX6fSGTRdg1EOJJV5aSRXU5MyVcdNcIxR1UFuhNBAc?=
 =?iso-8859-1?Q?v+74GphdvecHHPW3FwKpUJw+I8fJUeulQYlgwtZwU3ZqjSl2PPYtfwJ4Qx?=
 =?iso-8859-1?Q?IkfvEv40lnNCpeL9KGEj089ZBCKHYByKzzUViIlKM+uGmMWJsyQ6VFa8r+?=
 =?iso-8859-1?Q?P4um6fmk7qU47Tgi09Dj2gL8MRBR8GrnxqxQTv5j6Gr1i/yVYb6o0wCQo6?=
 =?iso-8859-1?Q?Fw/EgPN5RNDF5Fo4rXSEsUoiA/e/Yi4LYMj/0Gu2QhtZKaSyr6qOtKWl50?=
 =?iso-8859-1?Q?9Pjezz9TJF52SBieiX6WqeZ50hatJ2wHI0VOaUPr2uWThJAa/hDmqdDISL?=
 =?iso-8859-1?Q?bMiAqF2Al7wRjp02lZAFKusTcnynidEAe8xJauRglthLDpa9LiYzKUA9uk?=
 =?iso-8859-1?Q?LSc+Z0BW4Uv6bhHsqEmtH3ldjc40zddJPf4KrbvFaM+K9PuUokva5FD0WY?=
 =?iso-8859-1?Q?xlhRlgejJJ7meD0KGoPQkHQFzTRQEeYtqqTMts1vFNOLYWOiTtJ5B6e30V?=
 =?iso-8859-1?Q?QKOVnxiaM4NKAvmqNIRW94QkXLxEa4AGOd3z71LbqjHegzAWPRsPkRFdD7?=
 =?iso-8859-1?Q?L+jhKB+5yU6dbECEDAyJKy0l7Sd82OEyIie7jd8h6F7sSIHRVaPAbxp+qb?=
 =?iso-8859-1?Q?3DTjp/cCGeZpKTX5miCpg+jDjcsokKRdUiGjIiA+YCaZyLnUMdd00E9hJx?=
 =?iso-8859-1?Q?tEL1gX/3UJg/mXdgfzodb48nvnSAK69Erj4IVRGGxwpZTQsBPLG2r9cP0M?=
 =?iso-8859-1?Q?7EnYXIaW77zsExGhS7igcZ96w8YbAM+9zGZz+mOFs2J9g=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB166291427154647D65033CC5877A0@MWHPR11MB1662.namprd11.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(68736007)(2501003)(97736004)(5660300002)(105586002)(106356001)(36756003)(256004)(110136005)(54906003)(4744005)(316002)(86362001)(99286004)(6636002)(52116002)(76176011)(66066001)(446003)(2616005)(476003)(72206003)(6512007)(6506007)(11346002)(386003)(6116002)(3846002)(50226002)(14454004)(478600001)(8676002)(81166006)(81156014)(486006)(8936002)(53936002)(6486002)(107886003)(305945005)(71190400001)(71200400001)(6436002)(102836004)(186003)(4326008)(25786009)(26005)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1662;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MOPjJwlzcywMBX/j9Oncftm206k/Y/6P6IXnixxjenfP035XUCoLkv8mhzu4RgeL8ouFwfrSpPWnn2sbNPJ+0F2TebkPH0TsFRK2ESlPafKKl9tYpD6cP1aTnPuSgwoiPu47mGFfJAQEFPGjjdJxJZlNmlNeK8c1S0mnzIOeqaf4n+rd+V5bP/mXQsJ8VYOzQS5BpytiNNEZtrDrCGAab12y0IUYh4zOy/QKjlHDCb8m8Pz/+S234BBDC1mAYXa7hMYw+XwgnsLiVl2+D3ObdWRFGDuEFZ+79TCoYnXZQyBwIQIRwoTrYCxnW4T5xEoY1bxMKVcWhpUDkPuQ9vGWOYQwJ/8ZqqZD4gj68oNbq9GyLagoV30crDZ6tFRAnYoNm5SZROuZJZScVGLck9uaLZQUsDgDSR1zDQBmX3SRqKw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe0a0e9-002d-4a69-42e8-08d69b408e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:44:45.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1662
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

