Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C56C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DBA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W3kMv/lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DBA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLJHZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:25:27 -0500
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:59667
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbeLJHZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jI4C+5xGXDmjoZa58PO21QIejoZkAIxdFp8VYozcsI=;
 b=W3kMv/lchf38h0L0LqYoctRQdZ2rQU7spd+/EXsKnv/mG06PQ8BgKpOVhBMKpNpPOPcN8VDiW048NIu5cwfwtuJCKYro2wiTSacicjJIn+twKc+DjkHiNBmrmjVNT1rxumC+DZBk43HYpt6WwfIjg0OXW85VrCQW2tHT7qzds6k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3689.eurprd04.prod.outlook.com (52.134.69.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 07:25:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 07:25:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 1/2] dt-bindings: iio: accel: mma8452: add optional power
 supply property
Thread-Topic: [PATCH V2 1/2] dt-bindings: iio: accel: mma8452: add optional
 power supply property
Thread-Index: AQHUkFmDLsFCC/sNE0ia2w4KoCczzQ==
Date:   Mon, 10 Dec 2018 07:25:22 +0000
Message-ID: <1544426368-16415-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0033.apcprd03.prod.outlook.com
 (2603:1096:203:2f::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3689;6:H7ad6MhDjyABiS62e2LLROVhy6UisVGkjEv2e36yLe7N+mA2cqfWthxMS/WmXMjnaqOBiL1FdlhiGfD4Msa/T1kvCjsxGm63Y1KxC7DjqgkbSHQMW0dC3HU3kfY/9uFaqky3V7j9ZW4xZ49o+WCEWo3hdIqIbkpNQMie+by8KnfzuMv+tqItOJ7BJ6+g9OD2GuOwRo0EjsruTb2ZelMeu5U1D/j4T8WlHT9ntjSds5PgKDz7oVE5rQ8JwxLay4MgTSGB+5UAYiJjQiZu1w2+iVJZVxkcJQ8Ew+IROO00ApJdlO33JBBIxjBBoMESncIdU1XT+Wg3FX4nbjFHpqY+k7oSzSTKqVeCQKPf5Kp2oXnIqrVk+4QzwX5ul1g0SUvAvGNyryT/SLgtBiMLLc+6ZW9m/6ENgHmgACgz2zKTPk4A2T0oiXpb5w7y6qmUiR1PZCnxTeC+QLnoAldcinGZAg==;5:HbRwUJ+g9dwg/9wPA/cc6Ty+anEZPNo4GqBnXvwJNR+KONixP9YEuz+QWR68+rtrxsSBHwviUnccXVreIXTvb4meJ8ZevfROqKZfHVfBBVIex1mREn686SHzcAhdprbgA3QoPsrys80jLbt8ZDVF1GHfDeOhUVqBogq/fPsbpmE=;7:S5ZnVvdJ5KA1/q4g9drC7ugeZI8EBWCQH1pHD/jEH25z0i7f0wEQj4B8+S0Mrg8F59c9nYOCehc6qwBoucHMp1WXd6RFscdZREp3qigY481LdKm6NIzWzeIDFTh/qKZAkc6C1+wWAlykx97x0MmAow==
x-ms-office365-filtering-correlation-id: d2c104fb-19e9-407b-98f5-08d65e70a578
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3689;
x-ms-traffictypediagnostic: DB3PR0402MB3689:
x-microsoft-antispam-prvs: <DB3PR0402MB36894D428B492EAAF83C3D81F5A50@DB3PR0402MB3689.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3689;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3689;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(2906002)(7736002)(6116002)(305945005)(71190400001)(7416002)(39060400002)(3846002)(25786009)(4326008)(106356001)(478600001)(2501003)(53936002)(105586002)(97736004)(316002)(66066001)(6436002)(110136005)(14454004)(36756003)(6512007)(6506007)(50226002)(86362001)(386003)(26005)(71200400001)(8676002)(186003)(2616005)(486006)(99286004)(52116002)(476003)(68736007)(256004)(81156014)(2201001)(8936002)(81166006)(6486002)(102836004)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3689;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qPrp6QnSjeoO8QJcOUmHJ6bXfhv82C24iZj8E4mo3PDfciyBtV4OCK+iurWREImwhYRUqc6Awqi0UYgFOKvcS4hyx7XQEMhGKom1/TlW96l+8B05AEynR9X91J4FqH/ZBNJUwjiIa8dBgaLR/pVFBTTfMCuS5IauXJq1WBUjkEliaJi4+aclN7FbRlk89tg01Ry1ZhtH7Stgbh1dbz66yDbUsAKIdLyGIPowY6ojAp7/M32q1bOJlfaR0icSk2EfZg/VpM/U1menKqGHhGjWfwAsma++OUR6pyiclsjIkryH20r9u9YL5n36g9zAUhst
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c104fb-19e9-407b-98f5-08d65e70a578
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 07:25:22.9609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3689
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

