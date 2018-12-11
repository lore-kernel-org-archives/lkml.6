Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BDAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667E22081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q274xAHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667E22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeLKFNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:13:19 -0500
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:25676
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbeLKFNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jI4C+5xGXDmjoZa58PO21QIejoZkAIxdFp8VYozcsI=;
 b=q274xAHaRtDgS0UNe8KDUJoC1kRpdl782ZJQeLDodDwfuq7+N3MbrWG0beFtFd8K7N/Ud5ogaTYgUnaNjpuYHhrDa9JP2Y70d4mlj5ZUDleklaoDAfLu2GsQJNOh7Jr2+UC4uEfUe8q9vG3Rc1K5rh/9JfDuZCN5UCumS+K9/I8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3868.eurprd04.prod.outlook.com (52.134.71.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 05:13:14 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 05:13:14 +0000
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
Subject: [PATCH V4 1/2] dt-bindings: iio: accel: mma8452: add optional power
 supply property
Thread-Topic: [PATCH V4 1/2] dt-bindings: iio: accel: mma8452: add optional
 power supply property
Thread-Index: AQHUkRA4dxx72hqNAU+qHe784LeveA==
Date:   Tue, 11 Dec 2018 05:13:14 +0000
Message-ID: <1544504839-10958-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0066.apcprd04.prod.outlook.com
 (2603:1096:202:14::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3868;6:YOz31ypEpn6cOhnEblEdVO28j/HwxZA0eyip0KdIiQzevg/8txcuktzwrJ5NsCRanR49OcMJbEZcrF0RGOlfi/S2GPRxEDuKYWWOcQHhbM3aItd83uuhv95cqwLjDkaAG2dWPf7d2i8GGSjWVexxUunELjOLgFkRaQOcA5rpD1DCNJH31zew2JwlI1EjNDdQQ00xp645nHklF6i/J7JVO6+1K8UQ/1bj5JRHmdcKtNMXlcF/s0J4XRKigno9HssOZf4iboIlHJfaI4/WjHO62zr687C3P1N/Lbc9IYGoUI/lxgJm0u4O5Geqal+zgVNnBRFyQaQ0YO6JyChK069xIB+1vY6Je/JutBnEOkCiEPx8DbXJgeduBhlssZs2OOdMlK13WXFk5qdwtSVY8tapmPkhvKzn6PNs7D7qY3/pvj4Ch04iPq4hcW3DYfg/W7JciFnKaqoUsJiEu5YT7psLlw==;5:LyYVlax58nFyFBXJg8XoZhm4jLRHTdv2hlPgsNQI8Cox9O+KVxry+O+To5XrA+4E2630xOvZclf+nk8XGRivEDQlwbyLTPSbu2cZRhC0jvh0ZA57yjJ4xYuMhCd7UGmcImErmKZ+oimPQ9DSPGHQSEqGY09SdGHHKWPLZczRciY=;7:VyUZdypppg5LdE/kmOdJjhHwX4cHm8tFggOBkM+GW4eCBRXtw4oWxRWkoWRaTx6L8g9Sqcd4JFlMwNvTj1TsEO0KNfBYYRhWz9cKa6GjpX+gu0qDzw96+w5K+gRJHLMMgJx9WDaDQwmcoz8eJUriIQ==
x-ms-office365-filtering-correlation-id: a96672df-5512-42fd-76ce-08d65f275a49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3868;
x-ms-traffictypediagnostic: DB3PR0402MB3868:
x-microsoft-antispam-prvs: <DB3PR0402MB3868A6B95A829564A1FF544CF5A60@DB3PR0402MB3868.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3868;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3868;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(8676002)(2201001)(186003)(6436002)(14454004)(8936002)(102836004)(6116002)(478600001)(71200400001)(86362001)(81166006)(81156014)(68736007)(26005)(3846002)(2906002)(71190400001)(50226002)(25786009)(5660300001)(386003)(6506007)(316002)(39060400002)(110136005)(66066001)(7416002)(2616005)(6512007)(99286004)(2501003)(305945005)(476003)(97736004)(6486002)(256004)(486006)(52116002)(36756003)(106356001)(105586002)(4326008)(53936002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3868;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: imEkcKmU4CuAS1bMtrs51mvwyph6oWFHsAVlFqmkA5BZxrzOJxiKs+9fIsJqkBvtAVhJqqiUyim86Cqc7zbyk2v03t55vmjnRSG88NhA3eoGCzyUQkmtR7VYBwAk8f1JiN7LH/CvztXLvID3JIvC8K7eIn4R7NNVnm+HzmUXlB1tlhtx2UgTgbqDtIr6FbcjqWAjNQYGVutwHBdYbwAl8enLvQZqa8OnLkARqAMEkl5o56U2EVF3oPsAsp+i13LFTANJR5xdwz2xG5i7YS/rb2jil2oZG72U1Lk6wtfCThst75Xhyu5U1YHpdXKyTkjA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96672df-5512-42fd-76ce-08d65f275a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 05:13:14.7514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3868
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

