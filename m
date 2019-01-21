Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C44AC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2772084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oBzlO40Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfAUMau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:30:50 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:41706 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfAUMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:30:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="25752683"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Jan 2019 05:30:48 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 21 Jan 2019 05:30:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhfqjAKLj/VGpeNeDwnAwZwp1akzvIfSxWmUAhy4g5s=;
 b=oBzlO40YbwkuwD0Ey9RsbHdAuov1bvIBJr70Fga+/nFrFW4NdcWx5I0VQaayenP2ebX/foQv435g4J1ERAcev3eVMhEd1sBZShMQok2P+DrQVD973iVVXy/yHgWDcV84ljGrRSo6lPlAikv7qwd9Hke4MN5iZzNkdpsEay7Wov0=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2064.namprd11.prod.outlook.com (10.169.236.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Mon, 21 Jan 2019 12:30:46 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%8]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 12:30:45 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/4] add support for the new SAM9X60's PWM controller
Thread-Topic: [PATCH 0/4] add support for the new SAM9X60's PWM controller
Thread-Index: AQHUsYUhBAj3SDaXMU2G5JKDX4YKbw==
Date:   Mon, 21 Jan 2019 12:30:45 +0000
Message-ID: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB2064;6:hwdSvAifUZnWp3+KCYOIMC3jsjarWwj8wwixmrNUKb83XhtaKbWCH5kXUqjlICQJJRYdcGQu+OL+V0elFBrrdv8poDGaR+bcZhowWtaQBTj6faJ+oZm/MfqTJMdBYwzp8CmSgODS/CUxIuhzT5UdqUjzf+Y9i86a1ORVS65/f+3pP9+TNf74OOyeRZIw8yYgtqBSH5scJGrYkffKu6iXDBelarHOUq0T+su8bsj45WuIjm5nKznlbsvF7Jn6xbLLP3F4uUr4v2vPQoZ2+pHGzGeQBccBE2ta+7kc2WrOPYKl9z0PTgq9mexEdzgxlxal5FLKTvGzatO35tc3mxvXkBu5bl3sK7FTspuEhJeKJD3xcJqEoaDx5YlE+JdfCc7z7TlT6VkaYCGYQqR2hiQrOlIFEbyqy7GfCa0MzGRgAqlUq1g+s6A2v/WmbqyX157PJdoDW8qCa/tmFw608nQoUQ==;5:Hb82E2s0hmLAV1i06Uo+igk+FYbW6q7BnBmM4WQoTUlaZXgs2hH9WSUXsRD2RG+W1HwzJXTOVPbAlVMTcqzUXmQ4yspepc8Imyo/Uo5H6VZoT8aIoiPuQSAKQ77AHS5szuCGvM6eLP+cTEqAXCOnuO71mjoI/K5cgrfDZ7sAA31pmPjJL7ocCjC6pemkKebx7xWFLCdvqj0x+nTMmU2/Cg==;7:pbJtQ3onMFzb0YARLpA7jxfbNHczp8AWK7vOxIXoBG+fepvInlw9Hv1jgrhWjL37C9f4OQNeF4G1NqtnCCTBluWEy7D2fKNd7K10kEWd1RYzFd2IgeEquWZLMR8MI0J8/eH2cbV9/qlGMI0qFGNUgQ==
x-ms-office365-filtering-correlation-id: ab0c8179-f24f-4f5b-8cb3-08d67f9c43ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2064;
x-ms-traffictypediagnostic: MWHPR11MB2064:
x-microsoft-antispam-prvs: <MWHPR11MB20641C98801178C936F6CB46879F0@MWHPR11MB2064.namprd11.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(186003)(6436002)(6636002)(53936002)(4326008)(50226002)(6116002)(105586002)(52116002)(106356001)(97736004)(3846002)(36756003)(7736002)(305945005)(6486002)(39060400002)(316002)(26005)(6512007)(99286004)(71200400001)(107886003)(71190400001)(86362001)(25786009)(68736007)(256004)(14444005)(14454004)(8936002)(8676002)(2906002)(81156014)(386003)(6506007)(81166006)(476003)(2616005)(2501003)(54906003)(102836004)(66066001)(72206003)(478600001)(110136005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2064;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PsY1Us0T0qTPKxz+nwDdaT2vZ1mbTzfPO3Vefzzrc+BJMgRheFbeY8RTWRfX71Ui/6yyMGLLSS97fvZ090QC3gRgm/nDk2Ajw5A2/2g82xN1NWLVN9eSSa+ZJHOmsQ/i2SYfvKogE9gZ+R43zz5vNAwi1cGoaaRzGbSbjCX7/9fYNZSTIxxqmjCd0XbdJwFPE8wGMIp3Og3iRrjHaXcLkGG/+xyU+IXi5e52g9T4AV8FslcN5eYXziW+0wZK7wMklzPTYnn9f9/CBrC7wDLXvEikam0MCv22EQ4+iRJCTEs2sqp+/fXwbQaX4h+G3B0A+HXqsvnk3GjdQ3H7PEbxaHdtrxJzrE+7l4WZLRpVvETxKnCwkYSlt757Pfz0rLWTG8AJ/7LaJsO+HLaqyIx1ENe74wgFUIFxZb8jJGSZYEE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0c8179-f24f-4f5b-8cb3-08d67f9c43ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 12:30:41.5232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

This series adds support for PWM controller of the new SAM9X60. The differe=
nce
b/w this one and the provious AT91SAM9X5 is the counter size (32 bits compa=
red
with 16 bits on the previous version) thus, allowing to generate signals wi=
th
bigger periods and duty cycles. This series, modifies the driver to take in=
to
account per IP counter size by embedding this information into driver's dat=
a.

Claudiu Beznea (4):
  pwm: atmel: add struct atmel_pwm_data
  pwm: atmel: add support for controllers with 32 bit counters
  pwm: atmel: add support for SAM9X60's PWM controller
  pwm: atmel: add PWM binding for SAM9X60

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 119 ++++++++++++++---=
----
 2 files changed, 81 insertions(+), 39 deletions(-)

--=20
2.7.4

