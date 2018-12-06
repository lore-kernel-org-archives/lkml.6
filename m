Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E24C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F9E214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EkPQMX7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F9E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeLFGXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:23:34 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:60352
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728842AbeLFGXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj+8+2ldIG6LTAvsARjZPXYcPVKSNBobfBUCgEM2i84=;
 b=EkPQMX7dTvEc0y2lefcnQDfwYa5TmSFWD4YUTMQMCnByDIltKUxAGc8RhWHC5ayq362bYABCxOx7lEVlaN/poqFZWcp6vart0WcTNqwsys8HyYDRPAO9A6z5CyB6Vq3yNCiI10JsLAwrPaGe63FQX1gNBWBqMSMfKgYeGEX0dzg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3723.eurprd04.prod.outlook.com (52.134.72.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 06:23:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 06:23:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "harinath922@gmail.com" <harinath922@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "martink@posteo.de" <martink@posteo.de>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] dt-bindings: iio: accel: mma8452: add optional vcc-supply
 property
Thread-Topic: [PATCH 1/2] dt-bindings: iio: accel: mma8452: add optional
 vcc-supply property
Thread-Index: AQHUjSwzH6lyHs8ii0yXUHutSH8ccg==
Date:   Thu, 6 Dec 2018 06:23:28 +0000
Message-ID: <1544077059-4471-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3723;6:rV/FdbDzmtt6zFExiKVHcGeRMyuE/ZurcW8PlipgPuKp6Ajaq38KPXz6iElq8j74c53HCcJ4flA0Wnm7OzBgx8UilHDOIEBB2CbyrWgogHtx8icHYazAeEqKGV/p+8p7s9ltuiV4aXIwsQuctCVN9C8eh4xEQqbB/mRb0VyBfjSTEeUI9waQYK23r9UqpU2ylkaN2Jf3F6MdAVHM8lTNJr0LE0TCHUF44aosgj3xjlYNTH8iDGvhacCALDfdFSmie2gEMnAskCLoY2sDo/aPOUzp8qXVRJ69UPY91m1vedIyUkIIHgxqE+SjMiU1acFPjXHprqDytnM19clcLas+y7snz7YOgs1cOWPjnAvQ2cJTyrzG1WBxAsytrI8/c5NZspqB0xTRyuT5EIA+6Xo0XiAN2/SEwT456PJK029g9/2erxqoJ8vdGr7xdbzN43XJ+KfjX0281xopnvZ8WDdhJw==;5:JN2t1gQTQ6m1kE2/hAif02CvXeKFP+GFwwjjM00ipaBngvz8FIdHWKEDgeo7ecLALI7Jz+LNtE0jOPanuWFicVCriQ7FsYuAK2IN+IGW+xE1Sl2Fv+nc2WeGVXTppqqABP1ppP+SZgXY0Wl4TuMh4IjMYg/scjHQj8d/4qQwfkw=;7:5yQZs2d95YjopMGZQzxM/MinUqkqXtPMW0Gzq4gU1Q2FBSzOqe55SHiuw3czkCvM7UMA+AYd2oBxajXFij5GJeJ/lxVgx2P70s9se0O4SCq4FzgH9xxQjQWcNAKnv7xrfp/OQtHp3lrihO4vHDc6Tg==
x-ms-office365-filtering-correlation-id: 63ab8a62-1ce1-43a4-08a7-08d65b43558d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3723;
x-ms-traffictypediagnostic: DB3PR0402MB3723:
x-microsoft-antispam-prvs: <DB3PR0402MB3723CF1BE347C39DC8BAC469F5A90@DB3PR0402MB3723.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3723;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3723;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(256004)(6486002)(52116002)(386003)(6506007)(86362001)(14454004)(81166006)(81156014)(8676002)(8936002)(102836004)(186003)(2201001)(26005)(71190400001)(71200400001)(6436002)(99286004)(2501003)(486006)(476003)(2616005)(5660300001)(6512007)(7416002)(305945005)(53936002)(36756003)(39060400002)(4326008)(7736002)(110136005)(66066001)(68736007)(2906002)(316002)(6116002)(50226002)(25786009)(106356001)(3846002)(478600001)(97736004)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3723;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8mMRIiP/vFQUN8zDylfPY65le16HJb3BuJWlhdu2ZZpWdVW8Zek6ocU1ZjdJP/iBnKZkOWFaHxmp2gS9h2gurpmSld76eUFp/hbfZzx75TDXKyH/YOjfjQmUK39VZvYqiDNl8QgyJNnFhf1NIs12eazC39/ezPRjbjJ0R2miRCb1pKUV8mQuXpqelhJ9mkf6KmOfE9Hlnrxzfn/PgQ/sWhtJ9Q1vtF2vFwTYJ6d++L8c47Zm8ZbeEkjv4aZSgE4HitkNu0cByMuYoIgpHjMzwrDDomVA/f9N9qMtVXdSX+f1IF0GdSCG7gO+BxLPAttRdXz74wNqAEK48qYOXtwYY/uI07xI3wFsLzNtGVB9coo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ab8a62-1ce1-43a4-08a7-08d65b43558d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 06:23:28.1740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accelerometer's power supply could be controlled by regulator
on some platforms, add optional property "vcc-supply" to let device
tree to pass phandle to the regulator to driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/iio/accel/mma8452.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Docu=
mentation/devicetree/bindings/iio/accel/mma8452.txt
index 2100e9a..410279a 100644
--- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
+++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
@@ -20,6 +20,8 @@ Optional properties:
   - interrupt-names: should contain "INT1" and/or "INT2", the acceleromete=
r's
 		     interrupt line in use.
=20
+  - vcc-supply: phandle to the regulator that provides power to the accele=
rometer.
+
 Example:
=20
 	mma8453fc@1d {
--=20
2.7.4

