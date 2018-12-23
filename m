Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54DBC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F7421917
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z3vAKiq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeLWJCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:02:36 -0500
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:47373
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726356AbeLWJCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQtd3q+WOnHOPRELO58n5Uf38E+RmYiiHWXyE5ztPvg=;
 b=Z3vAKiq6M8+UKwLpKSNuikc5Srw51NeQha9B0ZVB5tByKuzxAlbcUG09LzTsVL9nDFKXY5W1XQNOHb6dZhD/h1Vi4PiUSge8ecnPNmBT5+ky4IVMQsMDvAgF3fcg7ua+M/yIgBEyrAnPHvMyi4hRy0XPpju5cpREVy6OaWEMGrE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 09:02:27 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%5]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 09:02:27 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "martink@posteo.de" <martink@posteo.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6 1/2] dt-bindings: iio: accel: mma8452: add power supplies
 property
Thread-Topic: [PATCH V6 1/2] dt-bindings: iio: accel: mma8452: add power
 supplies property
Thread-Index: AQHUmp46DrGmM9H1ckSYehiUfd/3RA==
Date:   Sun, 23 Dec 2018 09:02:27 +0000
Message-ID: <1545555462-16121-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3772;6:JrXO7xueSSR9zwvz7M6vl6yk6UggEVdOPgeLrbyvDdoXS++HgPeU+/5LobQwtyrpB10K5EG/XKfUnaUCZUwgSVcDNQC5xcEjjYy0bActVWyoyeXsyU75xvZi5T5NQxrvAoqPl7oNTQEOla1LFdbG+ikQ+izvD+FLbiErJquanqHdRfvmwIekpdT7yfgXjiGiIp278ZONkkabJ/Z6kqg+7cvX4DfM7Y2MLBFBDbFryD5XWzwIHdoNYsB8Ty9+W5Dk1TysoDajRpD6JqtqsYXPkNoSum6KJ6owfIhU4qIUIdt9IEXjHNLB8QbEmGHTqKyEz3rsbUliFqlZP/DwXVDXLowxe1uJiOjTjNulOreDSbXxUFAKniBq+Hyq7UA0EGI+bXCaQ8NdXGQtvCbHDzskY5+Mgif23rPFzP+gKmiCwH5E31/8HoFT9ZY5Dtt+d36OdRIJDLXowTrVg7BpaqAJBg==;5:9t9iULQlYSVpEqeK8D4LyertFOebF7hCKdXJJoYCNaRgpj1pCVcZYZaWAONgxpxX5sx4UCnuSLT526abLIXFv6MmqwSztzPQEwITRv8mmRjiSnuAm6ogwNDjHIkZfLzLkaz+HBGyW3BYgOkdwD4HoQ9/51kPBc74biyKDuDik+4=;7:FOHhZL/kdcekuebRSpbJsNqLGeDn2AsQWWQQ2L+n8GwzjUHeDFbRc2EmYjGODtT1kOjhjhcqreSJhcMmTxYWXr7qfyugSD+1UjtJL+I0cjce2LLYYoyrEbIoMbRgH6kjmQ/F51hsA0hbRSvCt2SbeQ==
x-ms-office365-filtering-correlation-id: 92e86771-3e83-4cdd-93f8-08d668b55c79
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600098)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
x-microsoft-antispam-prvs: <DB3PR0402MB37723524BA1A6F3D8F7F86C6F5BA0@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3772;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3772;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(7736002)(106356001)(305945005)(102836004)(36756003)(486006)(53936002)(2906002)(256004)(66066001)(6116002)(3846002)(476003)(71190400001)(2616005)(71200400001)(52116002)(6512007)(2201001)(99286004)(110136005)(6506007)(386003)(50226002)(316002)(81156014)(81166006)(86362001)(8936002)(97736004)(8676002)(5660300001)(186003)(14454004)(6486002)(68736007)(4326008)(7416002)(25786009)(6436002)(2501003)(105586002)(26005)(478600001)(6346003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bQ812Zk8J2Q3RAAnHMJbj4uJVaq4+bJkbGq4K/+eVqCHHQkAFuNpihL5k6DLMCj9uUAcZq4idf8EIqnrb7sbWA8pOl3KgmelPuQEt7E8BQ1zmP68FUyGcR4DARXDIpbNjQ6QkYF8mUJ1snXkDQ6TW+a9mCKUhp6Nr4xvFkAy6EBaIEpWF/4QxhGz0SP0yjuPssDybpKgzAxcuDt8pH/GJns8Oek8Gh6+rQptrW6m4VvFywUAnCSbIbVq1adtWT06AFk7EFkeHyfMuPIezIDMT5Mu31W1VTKSl25/BeTj35km+242JgHOfNZDB59Dj50h
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e86771-3e83-4cdd-93f8-08d668b55c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 09:02:27.4344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accelerometer's power supplies could be controllable on some
platforms, add property "vdd/vddio" power supply to let device tree
to pass phandles to the regulators to driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V5.
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

