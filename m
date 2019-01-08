Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D37DC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613D02089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a611tJaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfAHJOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:14:06 -0500
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:44192
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbfAHJOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHdriaK00YRvkQtfAZutWZ0o6GAIkkCknWl4LBh0n+M=;
 b=a611tJaFwcHsJSe3uj7GGxwMmMXaaBtKQ9cvn3aLPP6J8qHo5XyCee6Mif6lPoZwfenCLkpK9HyAAmoHunVtlrjK6LUlyJpnBExGwzureOvneXAztG2YSTSpC5s4aQsFTs2tpNhxvXLuxtIlRMjyd2O/pX/7WWrQ1GDBOOMLD7k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3834.eurprd04.prod.outlook.com (52.134.71.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 09:14:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:14:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 1/2] dt-bindings: iio: accel: mma8452: add power supplies
 property
Thread-Topic: [PATCH V7 1/2] dt-bindings: iio: accel: mma8452: add power
 supplies property
Thread-Index: AQHUpzJ+Vb5wRoMLKUCKHhiL5tiu6g==
Date:   Tue, 8 Jan 2019 09:14:01 +0000
Message-ID: <1546938556-26969-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:203:2e::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3834;6:q10dnE4G5GgNBWRP2H94BrzMP6ilWn/+31ZlvW60o0hM+lNyUCtkEuHQEXF0GBpXW/Ew0CccROUx6OuVF8XMELYzrZMNACZCBpZpCBxLuurW7JVolxGL5766NvRa10ZV+8vW1WIxslEkR6+PT4ODzFT0Dn4IZWvzEdZXh+WZd4U/9i0I1WJk7HtOnQZGwHFAanAUEv00TuoCKx3lUkEJQRuge0b0/0Z+2y+xv4D5iJbDQDHO2nUL6Bzvng0LXDCgjprHxo2T6LsSFOFvYR84hFf2J7B3kP3WD7XZ4knhNsQf0L9MPmblW7lW5Pc+kjMdDIpJYKvRYfjcoGy+8yoF+TKt2JWYxaZauZtJlydvWPfswo3QI5j5QlUBhyvZ1GEeLCEHwmzNLU+vvBKhan89fXqsfJ6CReMAkG/7a09LgLuKcXTi+V4CJD7K4p9wV3LVhThVE8RDumI+J3CH2WtwQw==;5:Z4j9Ii3tQIzLnAxU62V+P0RQjR+OBKIvgLgzxTpWCD5kfYZksZf7ygPJ9rLK5DazQ69S6J+LhAbI/MVNzPsrpOh1yUuZ/rGmrldJQ0HwOxZFB5KzCksdlRmBXXduWKRRCChHgsiKk6xgneBKXm3RtPVZ0KtHM/Abhmb65uHD729X4FgFA1nXSXNcVkrT/5bIHKUnUTgnJIaKSIpk0coy+A==;7:0aKkZ+XlcfQJh+zuoxpCk9+9UhFXscW5kN2KLzwEycAO1Y7XkITYymtzmIjOR2B2YWCmP6gFJ/u0SNz+flK/wf1DSbbXzu1YRSYMdvp6FL5oMmUoJmZz3w0Zw8nFfaTuD9prsHFsTQCMMtZFBTvv5A==
x-ms-office365-filtering-correlation-id: 92ee1801-ea54-48db-1f4e-08d67549a0d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3834;
x-ms-traffictypediagnostic: DB3PR0402MB3834:
x-microsoft-antispam-prvs: <DB3PR0402MB383431A8696C8CBCE34926F4F58A0@DB3PR0402MB3834.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3834;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3834;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(6486002)(68736007)(6436002)(2906002)(3846002)(50226002)(86362001)(6506007)(386003)(102836004)(6512007)(6116002)(186003)(53936002)(26005)(8936002)(71200400001)(52116002)(99286004)(2201001)(8676002)(110136005)(305945005)(4326008)(316002)(25786009)(7736002)(486006)(81156014)(36756003)(478600001)(66066001)(2501003)(14454004)(256004)(81166006)(97736004)(105586002)(106356001)(5660300001)(2616005)(476003)(71190400001)(7416002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3834;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EEob70KNXY74LGiYtl/SJfSHN3fj4p7o/DYyCSmeHmdokQJYNFt4N1WzjYT1HrLDEY8nQYpYz5igmkzfVk76XjCd37gOsxDOHBTD6xsBYatP3Jz+8TZ5BkIJly7OSMEoNY3lPqElp6v+lpUlOj8PbseA9xx9uUbka4unMJ9I/52fvn6caPxI2w/PR32jwl1JPhSIJjsfCWdDan3hiyw63BAtRjOdLFZvd2GtjTbhW5SGbFgzjMJwvEQ8fkUv30dkF2mjgA62b/5+bRTaDDyP7oEcz80aNb8n4Q7TLvNvaDq98wgPuHkT/2aQY3ky/nxm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ee1801-ea54-48db-1f4e-08d67549a0d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:13:56.3010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3834
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

