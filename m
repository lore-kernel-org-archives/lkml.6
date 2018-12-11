Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAA7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38EC20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L6OGvuYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38EC20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeLKDeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:34:22 -0500
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:5696
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729975AbeLKDeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jI4C+5xGXDmjoZa58PO21QIejoZkAIxdFp8VYozcsI=;
 b=L6OGvuYi3GxH2ErXrW8oYqiLrMzypcVtij8yF5QyiJgVJVfIqVRCE9q7TmpMmC9G+IwKIlCYNWFZLnWzn2BG+W9XiFfOIp6F25/T32w/bDY9GrvdPJykyQySKWoEXHVlAdXuccUARmRtrqawDzQ7k+YOkOVIqEZJkEqgEXHnWLQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 03:34:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 03:34:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "martink@posteo.de" <martink@posteo.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 1/2] dt-bindings: iio: accel: mma8452: add optional power
 supply property
Thread-Topic: [PATCH V3 1/2] dt-bindings: iio: accel: mma8452: add optional
 power supply property
Thread-Index: AQHUkQJlUYA+xQy/D0enlT0sHZgzvw==
Date:   Tue, 11 Dec 2018 03:34:17 +0000
Message-ID: <1544498901-8744-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3674;6:3J6s/G2vQwd1qqZDo5SKKembdw1Sg60rA3Dj6lBltc7cHIxNX8XyhGV/eX+1fuom8eyY3OymdJdjXX6ycgWJ7qw+bCkBdIkKbeXKlj0FmAMs65K/NrUxuZZOkWioyAhH5YXOCVZtj9LkQiZpUQSG5uEn67ss/exLQC47t8rOlQDX8T2gwdNoM3uKPP7SSwXkT4QUUc0nncfsNeLM9mqVoeNppWDkXoC54hxnWHBVqHz1NX527M09sa+76lzaGS8bc9GOmQmsSwrVJZuDp1GxSt81kFaM6pF1ihxdusGaAh+nRewDRv/VFPDZGqe/jOhqOyxi/7NkJI1pAwOtm5kTmRh4kGHY3A3aykQrFn/NeQBIBnTwFCATnxgYIfgJy/VlSe9Dgr5UyEmL298R2uqvM/mV7FaAAfExzM7jvUPeDGrkejONxiW9N9BiIzGyzRUU6eXapAjIQ5fkWLTf5rAFpg==;5:EtTUp0OV/jLb8ElZzNu11sJpiLziw/5KklYQpLVhF1+MczPvABC3uLnFxUZRX1EHKzTHN+5KHIh2sP3623Z+V5El7+CLet9XZs4Pumj2GlsFNo1AX83yv8ZSN5/ezGWymkW7W2/XhrNudSmtqFoFsVhbOpLDx9gEz+O9T34+YMQ=;7:RYXioR5Zweoy6KMVI0IsigeGrsvjErBbsSfcJgddrxGB7Ez9EKqTuOj1zM60klhVtcQoAtgc11Rk/Q3QB7w2iJXk76mmLg2nwm7srEq9stgUu8wFw7MhrIim2OVyh2zSL0cpx04zXjy7MpBXW+PjxA==
x-ms-office365-filtering-correlation-id: 2193c9d7-88ec-4bc4-75a0-08d65f19874b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-microsoft-antispam-prvs: <DB3PR0402MB36747D256FBC22338A1B8482F5A60@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3674;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3674;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(6512007)(478600001)(4326008)(86362001)(5660300001)(53936002)(256004)(6486002)(316002)(8676002)(8936002)(50226002)(7416002)(2201001)(39060400002)(81166006)(486006)(97736004)(81156014)(476003)(2616005)(2906002)(25786009)(106356001)(2501003)(105586002)(386003)(71190400001)(14454004)(71200400001)(186003)(110136005)(66066001)(52116002)(102836004)(26005)(7736002)(99286004)(36756003)(3846002)(68736007)(6116002)(305945005)(6436002)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2omsoTwa2U/qwFyqLcHE0SM8Msdafmcna7S2D62suuhSuuFl1Z+nfoSieenW6IZngYU7N/BsQqguOY14dV6TctINKY+mCDpVGpv/dbgesW94u8zir1mMRvykhVBxDoLXpq3Ho0t7XhrmqxBe2im5ggnKihXHECWUhoHmwHQd8wtqpPtKsyccoYTZ6QgrBXoB/BR+lxJnB/CdetRTgNGjS6b/qVolbTfXLThrB1AKOruHTo0uxeJ5ODkUSvTD4s6EgFLcc55Ytayi2Zz5/HERrWu/V2W8l1vztXCVrY4DUPT/jVq03q/1GgpxP/Ltd5N/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2193c9d7-88ec-4bc4-75a0-08d65f19874b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 03:34:17.2927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accelerometer's power supply could be controlled by regulator
on some platforms, add optional property "vdd/vddio" power supply
to let device tree to pass phandles to the regulators to driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/iio/accel/mma8452.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Docu=
mentation/devicetree/bindings/iio/accel/mma8452.txt
index 2100e9a..e132394 100644
--- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
+++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
@@ -20,6 +20,10 @@ Optional properties:
   - interrupt-names: should contain "INT1" and/or "INT2", the acceleromete=
r's
 		     interrupt line in use.
=20
+  - vdd-supply: phandle to the regulator that provides vdd power to the ac=
celerometer.
+
+  - vddio-supply: phandle to the regulator that provides vddio power to th=
e accelerometer.
+
 Example:
=20
 	mma8453fc@1d {
--=20
2.7.4

