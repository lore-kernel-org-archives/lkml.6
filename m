Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6C2ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF6B208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RskAMYAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF6B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeIQI4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:56:47 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:14944
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729321AbeIQI1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0OeNyVo2yxO7VJ7M6Bg2FQdIMvNPpR893wzjCHiz3E=;
 b=RskAMYAyBEDjHdI4DQuJif4oecffVAWbOwtZ5ze1GQGxy82xPj2VGYkqTaBHz6I4fdtFRuy4Gh88ixsbmOobjQgH7LRjZ4/7t/NSm8ZmZPdGwV8T9Tp86kdPoMGXQOn9QjcYzL7gD6/2e6Z/3Hz6fr6USbclEKzoXEjaK8uallk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 076/136] media: ov772x: allow i2c controllers
 without I2C_FUNC_PROTOCOL_MANGLING
Thread-Topic: [PATCH AUTOSEL 4.18 076/136] media: ov772x: allow i2c
 controllers without I2C_FUNC_PROTOCOL_MANGLING
Thread-Index: AQHUTjKpBY6WC5jwwkKUl21NBZlQYA==
Date:   Mon, 17 Sep 2018 03:00:59 +0000
Message-ID: <20180917030006.245495-76-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:m6x3vDjORZFsLkJVOWsGhR4ZANZVGszv5iHX1KrEescs/SRYwsSIs3G+UCsW5Ff3ftyLEi7iVQCRmflbSMFVzwRz1HtBw+sTpW1l1J6Vd+trSXIEwxHeKNAPj0tZvNeQ2TsJ2JjmmsOxnA5oeY5pL3ZWWC9aBzCK4EtgjOc0LF7xLnwtfdoDgxV4pK4UKZ/S+ALI2tqN5WDooYkS60Ux1dPo6+13jA/WGgkICNNrUAlscEN31C4J847tKQ2aOFl1OucI69xf/pVvC5spsc8LQQx1c8MQ/jMf/LkgvN0NVYlswcnVcbG2q98dZOVL8zKvhTVs/3tsO5ega940GtHzxrcqUwfuJ2hWleQOW3eNi80Qd2cOxlcQ2YjTaTPhyA0o+OCZjpKhQ6A91XuAzTYNVUxhgbvmi9bTri0i1rT3w8zzwnG2Gc3KLsQt5j/Gebdh38UdnUeIrr+5TYaQpNQbEw==;5:nRc5nAH3gxrG+Lb8Yiq2RHHcVH8dRZrPlUYO32eTIRbXqKrVXWLawlnT44XnedwiZKkH9Dab0iSc/kAsY0p/AkWX5sIVhikoPITQ4o3MKx5QO5h9YH/jde51W3iVcigap+h7kv7mMBHQnDJex6ZUjVWST8Qv0PhRXX05gockTIE=;7:ibhTuiOJDP1MFBwwrps0x8FXj1Z2Q3q0/Jq23OvO4H8Ix2psqjmfJaz3ijRE1dR6nmU84TQCVJfVVUoX9QS+2bxQrfd7z94vtvGYkZN+BV2mvyxE9H903PCJ9xf9oKBe+RHsQjDEZq+jJSBxf/P3FL1rA0RkgdEet1+Cmh553LI1yBdhes9lmaaGGP/Qt6bdoOSWud0rb+s3VdFu/yfsSZMpMJOApUmGvwtCPE885FPjCvG7wcNgpeYG3godoJeO
x-ms-office365-filtering-correlation-id: ffb52d34-c421-49a7-e991-08d61c49eeff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB050277FFD2F83B7976900742FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(1076002)(6116002)(3846002)(10290500003)(39060400002)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(15760500003)(102836004)(2906002)(476003)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IFavI26yUERHbm5dnwXJXq/rFyLW62/Xh16gGUySCSlhUR6lcyuDSl4GPEvLEWqrQVYcOqEJxE2HMl90anvS4aC3nv+eIFsK3x32ex8fHdZorqEFx60VcSh8Hmy2dd5IhKw/w0VgH/gfMc8BUzAmSde9xDHFxWrvohYhUQt510TQ7yqb8/mV0XO2gly00tw0cMTYV/luaedvnIJmqakZm9nAgHCCgPrHMAEGazet+3svlBNx/4Mu2kyIBsal9dxvDWIXRnGuDsOMfQMe2ieGOhLkRB4Rr7UIUR+UrYuzN+u5ig8nGfhCYM2HpVCP0akNNJK+0is7exeFM5jci7rqu9oZ+D/vVUWwrilzL7vHA9k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb52d34-c421-49a7-e991-08d61c49eeff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:59.7762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 0b964d183cbf3f95a062ad9f3eec87ffa2790558 ]

The ov772x driver only works when the i2c controller have
I2C_FUNC_PROTOCOL_MANGLING.  However, many i2c controller drivers don't
support it.

The reason that the ov772x requires I2C_FUNC_PROTOCOL_MANGLING is that
it doesn't support repeated starts.

This changes the reading ov772x register method so that it doesn't
require I2C_FUNC_PROTOCOL_MANGLING by calling two separated i2c messages.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/i2c/ov772x.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
index ef6581e56753..3fdbe644648a 100644
--- a/drivers/media/i2c/ov772x.c
+++ b/drivers/media/i2c/ov772x.c
@@ -542,9 +542,19 @@ static struct ov772x_priv *to_ov772x(struct v4l2_subde=
v *sd)
 	return container_of(sd, struct ov772x_priv, subdev);
 }
=20
-static inline int ov772x_read(struct i2c_client *client, u8 addr)
+static int ov772x_read(struct i2c_client *client, u8 addr)
 {
-	return i2c_smbus_read_byte_data(client, addr);
+	int ret;
+	u8 val;
+
+	ret =3D i2c_master_send(client, &addr, 1);
+	if (ret < 0)
+		return ret;
+	ret =3D i2c_master_recv(client, &val, 1);
+	if (ret < 0)
+		return ret;
+
+	return val;
 }
=20
 static inline int ov772x_write(struct i2c_client *client, u8 addr, u8 valu=
e)
@@ -1263,13 +1273,11 @@ static int ov772x_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
=20
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
-					      I2C_FUNC_PROTOCOL_MANGLING)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		dev_err(&adapter->dev,
-			"I2C-Adapter doesn't support SMBUS_BYTE_DATA or PROTOCOL_MANGLING\n");
+			"I2C-Adapter doesn't support SMBUS_BYTE_DATA\n");
 		return -EIO;
 	}
-	client->flags |=3D I2C_CLIENT_SCCB;
=20
 	priv =3D devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
--=20
2.17.1
