Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5BAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB98420883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="S/z9+S6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB98420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbeKHAnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:43:20 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:30594 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeKHAnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:43:20 -0500
X-IronPort-AV: E=Sophos;i="5.54,475,1534834800"; 
   d="scan'208";a="23752288"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Nov 2018 08:12:33 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 7 Nov 2018 08:12:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxc2Kpv/fnmltD7NMrLSzrAxjMtqXmDHqU7/8HHgjvo=;
 b=S/z9+S6qOyyED1XE9yBsZNB/KAnD1O0t0iQu1MR/cPMByJutxsUfcMbGGUdNKFq1BiC0i7Vy085tJ4tWCUV3qsnYJkonhShT5YtJx4diohukB/ZY5kjAduI81kil6ZfyZRo5RUYGcvfqVmbe2JtJFOjEmb0vwudLzUjTl3xgf2I=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2257.namprd11.prod.outlook.com (10.174.113.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Wed, 7 Nov 2018 15:12:32 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 15:12:32 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <Ludovic.Desroches@microchip.com>, <Cristian.Birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH 1/3] dt-bindings: gpio: add sama5d2 PIOBU support
Thread-Topic: [PATCH 1/3] dt-bindings: gpio: add sama5d2 PIOBU support
Thread-Index: AQHUdqxO5isTeHVINkW+UUYjkq2vOg==
Date:   Wed, 7 Nov 2018 15:12:32 +0000
Message-ID: <1541603580-17448-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0097.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::23) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2257;6:xBLuotJNi963WLgYS9fpaexWJQAigJMfp8KPcBqUjgVoUvIsofOH5bImPGg8Rp0JEu8XWmv0Cn9EZw0VV3JBd0u8jZolgqSXYpKBcPDHFmJsQgiTf+2tyUQhgtbLk4jAfmCDvhWltJoCK3re1POaC/XuLjJpw6WB8VWP+497PTLHaT1PO6UUiYNlud2rJEGiSNvrj6cosRceZVOuixXWXIZrT087RfcB1jPFN6a8M0hUKDExMPaWjEdQTxhYP2/crQ10K1GHmGU2b/8bzjq4sz8j5NXL5oyLJsZet5ylPheAWew3WlsIM9DFGu9okgY24a+7SyqM0qHFo7SpMg92btWl1sETpMtigFZ+dBkhIq+mJO34VVhEPiLHu61o0l381Orz5Gowaj53ag4R/m6M3d9T0MkdZdqzsIbonp675uzV+aEdePMF/jLNvlyDWe8/dRPtLngPkKG7Pa9jxxCD7w==;5:mNUxWSdJO8TbPwWwyttk+Y6c5YIz69C4ERmGXO+d3kSNdpX9BlhAtkJD/3uxbT53+sasFyG+PQKKCPuPAVdV4WceBoCB9iSeTzJPw2F0gbTm7ODzhAsvH9wIdpS7xcrxHZrNXz46Yq92e3kwPlZzdH85D1t23cqL06VN5ttwASg=;7:EZjga6qwf9SFWAmrz9kQHcVKhjYt6EGhD/Ws+H2fUdW9TxWGQB/Fa9Iqho8lx3JsIlBpdIcCnJPXoadUmY1jsfNzeuZwxemFk6ucs48Iw/8I1mggtjYqznlLtns23aWnSrsa3d9LWNOCodtxfRqnJg==
x-ms-office365-filtering-correlation-id: 14207d0f-6f6c-4303-1100-08d644c370b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2257;
x-ms-traffictypediagnostic: BN6PR1101MB2257:
x-microsoft-antispam-prvs: <BN6PR1101MB22575543329FED8E3512B7C1EDC40@BN6PR1101MB2257.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2257;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2257;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(37524003)(2501003)(5660300001)(99286004)(8936002)(4326008)(97736004)(105586002)(72206003)(386003)(102836004)(6506007)(14454004)(8676002)(26005)(81166006)(52116002)(86362001)(81156014)(2900100001)(76176011)(68736007)(106356001)(476003)(478600001)(36756003)(2616005)(53936002)(305945005)(256004)(6512007)(446003)(11346002)(71190400001)(71200400001)(7736002)(2906002)(6486002)(6436002)(186003)(3846002)(66066001)(6116002)(25786009)(486006)(107886003)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2257;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v6s6VTzguoZ5Kpm7Tqden+vz1gRP70AhRWnDq7vEXocj2JUauHxAtPyGfR9EOmsijmd9STP2Az3oLu/9+bV2E3SrXZGkS61HgQPkx2ny3ucg95WqyimvPIMJsjhRqNnxgDtqVSBDPcNWib47CAOHsjQhBWvSm9de00p4KR8QVwhHslRQDaHOX0dIZU6r0t07UnIWG9qBc6/uWbcuUEVCCB8MImSu3ER0RLZbZnDEpcTjSZxS53dXlzADMVLzcTvudhE934kN7cg+YUjbB69yQPva/e9NDcwZf7jP88jd4SAIqFN6VSmY033KTAcFXWAZ5l+UTKxIzC5XiPNgVPsREuZRN+hqOAacqKuRNhy+l9w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14207d0f-6f6c-4303-1100-08d644c370b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 15:12:32.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2257
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch describes the compatible and the device tree
bindings necessary for the sama5d2 PIOBU GPIO
controller driver.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 .../bindings/gpio/gpio-sama5d2-piobu.txt           | 23 ++++++++++++++++++=
++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sama5d2-pio=
bu.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt =
b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
new file mode 100644
index 0000000..791ac51
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
@@ -0,0 +1,23 @@
+GPIO controller for SAMA5D2 PIOBU pins.
+
+This pins have the property of not losing their voltage
+during Backup/Self-refresh mode.
+
+These bindings should be set to a node in the dtsi file.
+
+Required properties:
+- compatible:		"syscon", "microchip,sama5d2-piobu"
+- #gpio-cells:		There are 2. The pin number is the
+			first, the second represents additional
+			parameters such as GPIO_ACTIVE_HIGH/LOW.
+- gpio-controller:	Marks the port as GPIO controller.
+
+Example:
+
+	secumod@fc040000 {
+		compatible =3D "syscon", "microchip,sama5d2-piobu";
+		reg =3D <0xfc040000 0x100>;
+
+		gpio-controller;
+		#gpio-cells =3D <2>;
+	};
--=20
2.7.4

