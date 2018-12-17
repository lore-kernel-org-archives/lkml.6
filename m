Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECADC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE0D20643
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UI5XbSE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbeLQFWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:22:53 -0500
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:44320
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731372AbeLQFWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 00:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHdriaK00YRvkQtfAZutWZ0o6GAIkkCknWl4LBh0n+M=;
 b=UI5XbSE59NBU17djVQMYizwZWju2H0Qa8nt8glVlCz5Wy+Zhbmo/1PHLK4vZicNoCLPYUzUgonc3uqgPOdetIwAnO7HGWtU15Mbi17bLfMPPEZQsxQDovh6X6Uy0Uz34jETwsoSptVSPYml3D8oNQmq1M7ZJ4ghYU1/iFS4vd1s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3868.eurprd04.prod.outlook.com (52.134.71.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Mon, 17 Dec 2018 05:22:50 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 05:22:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 1/2] dt-bindings: iio: accel: mma8452: add power supplies
 property
Thread-Topic: [PATCH V5 1/2] dt-bindings: iio: accel: mma8452: add power
 supplies property
Thread-Index: AQHUlciNnSYHDyiV7k2ZFORBXoJjew==
Date:   Mon, 17 Dec 2018 05:22:49 +0000
Message-ID: <1545023805-31250-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3868;6:B6bdhJI1Mf7lXAJouk/M6cImAjjrkuST6NNfI01WwNbJvJTbr9HOl2+OXXp7FlKpooBU7xCZxKqWqXgxJKBmkpOLrELiCJn473orMM2fGDBrzuYK/dZZzRAve9oewLXeYD8mDhmBOfx79hgb7eLv4X2AgSSh0zVEH22TzvhiQg5l6PYTfCiB0bjCVrCNf0V4WMjvS8iDnQLVAFInZa+wDB5yE1YEhCxmoWPV5hwiRC1utXsG0ukyPYNxlCG14yiv4bgS5eGWxa+ZgGOjeOrKAqXcLSM/8sRtnxLz8tVuc/2Wx/IPD56TJTt8Ukk8womikPoa+FO5yNF6ujlvUBueBXnrZVmjRQFdiD4EDKLxOfjwJzaXtTvGyvXyDKUY8lOrAXaWVqKSZm+FuWL+NNxqvCV6qQ1I/D2fTAA0JysRy8OlzPh6tUoa3ZUHb3114N9vxIebnjiC21M9R8okbmWqlw==;5:O1T73c/eRMPsWOZBIQ72+K/5QXuZEaj88ciQqe9Z6cfJ+S32Y76teSQawtmrJw6MLSM+KcvHloGpjmPRn581+82wfKX1ndd3tWbVIU/paV/Xkp2tMxC5aoJxD7kNGh2He10sl8gc7vHp3wOskiJ6MnyWnPw4g/gTDtnB63+1gWI=;7:1VzZBmlF1SCkbkbP1EC8axwfURS/0pa66LgFtmUWawYVgvh822fJj1N8kp8cjvL1xtEn1Eum0YFs5GU79JqSr74tj7O6HWuzgA1K0L/e1wUvkJOMaKs43FLCFMjjH11EvXLUjsM6fItFOv1/QskHFg==
x-ms-office365-filtering-correlation-id: 6c72c66e-dc03-410a-72ad-08d663dfafa6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3868;
x-ms-traffictypediagnostic: DB3PR0402MB3868:
x-microsoft-antispam-prvs: <DB3PR0402MB38686EC27125EA479F2147ABF5BC0@DB3PR0402MB3868.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3868;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3868;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(256004)(386003)(99286004)(6116002)(3846002)(5660300001)(66066001)(6436002)(53936002)(2906002)(52116002)(68736007)(2616005)(86362001)(50226002)(6486002)(2501003)(476003)(8936002)(486006)(7416002)(2201001)(8676002)(97736004)(81166006)(81156014)(25786009)(316002)(106356001)(110136005)(71200400001)(4326008)(186003)(36756003)(14454004)(105586002)(6512007)(305945005)(7736002)(102836004)(39060400002)(71190400001)(478600001)(26005)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3868;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i4zipNt5p4G2l8R5FZeZe9TuN2uSNJ7SKXTeyHI0y0sF15qpeFATukANyJQ5PiL62y7A1939Zf/tgw0HeoIppnkHCO/WDGIedo1nAVvpJBwSk4/wZzpnILlL2bWlsRQUUd0pImHA3y2XYq1AAb6T925vAOsVahqx0T82jjQWI1FVF2hPOHEyxVOgP8aSOzEmHKnGHGyTaDNgiwA75Hb5yCBfcXYcx7U6Ls2t3jJ5fW+bmHs/YNZIRCgsTS2jb4z0DjpA2sBZTwDW3J95VdrAhio+BnM03v9f+mTFL+tqGy95PuuwzZUPyVNQCwNPTAjh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c72c66e-dc03-410a-72ad-08d663dfafa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 05:22:50.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accelerometer's power supplies could be controllable on some
platforms, add property "vdd/vddio" power supply to let device tree
to pass phandles to the regulators to driver.

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

