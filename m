Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74564C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F952133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NEE+OgSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbeLQONt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:13:49 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:38537 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733287AbeLQONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:13:47 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="24462322"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 07:13:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:13:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq2ha2Zp/A7gCczGWZsdnelFEYRsJlhMhMg3kS8FWDM=;
 b=NEE+OgSkB3+g2cfAEgcr/L8jtZc0DrzZtADLrOpvJkycukM1GIzHhDD3Oi3MAVPEDhwMpgHG3NA6BH+gj9UZsZb/Flw4CqX9zaahq+NqinTztFRMju+XM+7s1Kbh0tOgwwjLYB7B9Dhk5196BeYoaCs1Q1i012uJXLPJJcSoBWQ=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0584.namprd11.prod.outlook.com (10.163.159.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:13:44 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:13:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh@kernel.org>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v7 2/6] pwm: add PWM modes
Thread-Topic: [PATCH v7 2/6] pwm: add PWM modes
Thread-Index: AQHUlhK3V6I/hxlnQUewIiLG5Q4CBw==
Date:   Mon, 17 Dec 2018 14:13:43 +0000
Message-ID: <1545055999-23950-3-git-send-email-claudiu.beznea@microchip.com>
References: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::25) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0584;6:S0odE+pcd7XT3VCDmRezdKzkWdh1GRNekAD3wJKqO5gSSIog//uuCjCvETkAfdkKR4+B0QRmSsFRaCtuwvALfropIyliPJjgZzfXeYSfOY00r0F+/h93DT0mnlbLX7ue7mYHqElJUgRNjIwLSIPcLMd7ZRBL/PuRx1VowjZbvRc0rdn/n5KS2Sgw1PNPdCtif6uxcwHOs71Zr4mO4rvx1+1rekzB8jpSxZZPcWmVlzx57sE+vx/o+S3q66p1Q39L1J3DRAhrxUdT7W2IXsvGxctNpkjES1KW9fVwRBKoDU2XuC74pBBvEh6sqAGx0L1P8VQkaIJ/Y7wA9170KUYEIEHkTzi6zWXWblAWArSb5JYq6Btqra+WWmzFhcB8kAjlxvmwYXzIQ6qk+a4AvZjNsSiigsRZEzMOlWvgRijEu7TfQDBt9RXp4JClJF9tTDIbv/0TJH52oKHDXXPaDZngjw==;5:rICT7nZY1atqfQM9grmEIG58evq8n3egOC/omo1kqEiUdy3u9eeVsJXrOwtpX12lo4++VXUmSSa8EQaeaP4FB6+MDUeVGfbNorB9p/abGqWDdkjbrLbYdX1jFklLGApMpiBgJp3YgpR1UI7HK/2t7KlNw/Ox7v4prqsVrHOqGwA=;7:22gOiSiHYCQdEcmiOJnuC9RT2ISL+ErAnhkLP2Bmcxsdl3CrmnLrLX6ChQjocuTy2n3roLC2Ak/GxY1OT8nqYjk9CY6dlg+P0ff2PQWcLmQ4tN13P/NuR3Twt/cQ5M9GZIc2x+2Hv5HhWemiHg/UXQ==
x-ms-office365-filtering-correlation-id: 0b0ecb3d-b280-4d7b-08f6-08d66429da25
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0584;
x-ms-traffictypediagnostic: BY2PR11MB0584:
x-microsoft-antispam-prvs: <BY2PR11MB058498D0A1FFA2DE20BFDEC387BC0@BY2PR11MB0584.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0584;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0584;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(8676002)(25786009)(68736007)(6506007)(386003)(6116002)(102836004)(5660300001)(6436002)(66066001)(3846002)(39060400002)(478600001)(107886003)(71190400001)(2501003)(72206003)(256004)(305945005)(71200400001)(6486002)(7736002)(186003)(97736004)(26005)(52116002)(316002)(54906003)(476003)(4326008)(2201001)(99286004)(14444005)(14454004)(11346002)(2616005)(446003)(2906002)(76176011)(6512007)(36756003)(53936002)(110136005)(86362001)(6636002)(8936002)(81156014)(575784001)(486006)(81166006)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0584;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZbtrvEKvJ6pUGUNWbhdGtiSkSoqM2xCoK+Ry9U4ljZOuyHWGo4lcCj29LDLdZAwBtkGs5oaM1fJYl5CBi3uYzPXFJOze2zivw/0G+8sQTMxqHt1WryE0mK6oUbMMJmOCw6euZ+5PRt4NKH6+IFcs25w53DkpOKNvMAzbdWR5oTZFf+PCLHaeMKuH0En9Jbo6xcf36umoE2M9Do4bLEx6pwmhOYIFPSLRRM8yRUcb2ZuHey3dMA8cm/hUiryrN7RrsJ3LQ7a51K8mLy309/PCxWZjC6i2q39bvGicHIdYBu/u+xAZizmF6XkAUDo5Z75j
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0ecb3d-b280-4d7b-08f6-08d66429da25
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:13:43.8863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0584
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add PWM normal and complementary modes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Rob,

In prevous version I had your Acked-by tag on this patch but I removed it
in this version since there are some changes b/w the previous one and this
one. Please see bellow and let me know if you are ok with this.

Thank you,
Claudiu Beznea

Changes in v6:
- remove DT bindings since they were also removed from code
- use 1/3 duty factor ratio
- use '^' symbols to emphasize the beginning of a new period
- use PWMx_y to refrer to output y of PWM x

 Documentation/pwm.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 8fbf0aa3ba2d..669fd4c9cc8e 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -110,6 +110,28 @@ channel that was exported. The following properties wi=
ll then be available:
 	- 0 - disabled
 	- 1 - enabled
=20
+  mode
+    Get/set PWM channel working mode.
+
+    In the following description PWMx_y refers to output y of PWM with ID =
x.
+
+    Normal mode - for PWM channels with one output; this should be the
+        default working mode for every PWM channel; output waveforms looks
+        like this:
+              __      __      __      __
+    PWMx   __|  |____|  |____|  |____|  |__
+             ^       ^       ^       ^
+
+    Complementary mode - for PWM channels with two outputs; output wavefor=
ms
+        looks line this:
+              __      __      __      __
+    PWMx_0 __|  |____|  |____|  |____|  |__
+           __    ____    ____    ____    __
+    PWMx_1   |__|    |__|    |__|    |__|
+             ^       ^       ^       ^
+
+    Where '^' specifies the beginning of a period.
+
 Implementing a PWM driver
 -------------------------
=20
--=20
2.7.4

