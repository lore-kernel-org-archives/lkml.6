Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B7F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D8+ZTqv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B7F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeIQI1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:11 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:29664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbeIQI1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JaEh0FSzaAUmrolHlBBVfEj0hhTrNaLPCf5XBtwNws=;
 b=D8+ZTqv744uxtkN1jFx26iusG+rYrzRkzXT2E2BjCMKaMDlqu/qGNwUr/myx3opqC/j/xCXqi/XE4a//aSb3FT79NHjek3nS5XG9fP9stHPUeWh+nU+SOeBwVpqfH4IUIZopkufvWOv85u6Lv0QsMEi5frBdtYRjYkQty5g44LY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 064/136] iio: accel: adxl345: convert address
 field usage in iio_chan_spec
Thread-Topic: [PATCH AUTOSEL 4.18 064/136] iio: accel: adxl345: convert
 address field usage in iio_chan_spec
Thread-Index: AQHUTjKkLWgC6WYKyU+WhWX3bOcqzQ==
Date:   Mon, 17 Sep 2018 03:00:52 +0000
Message-ID: <20180917030006.245495-64-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:xf4ryxGoWD/+aJUx8nshOIr1PL9e36rAfFzUTGQbXQcOI27tAbv92y7pvUJez13XmuxO+cVsQZ+ZfcXs0I4oChcrnmIHUyiuCEemU79UCkQwydxpL2hNrgkalbHOEdcpXza4stzQxYn0Gwl0NhpwvxIR86uoNK0DIaaUpVMLHRU0bi0tq8IdNquDDs10iiiUoyejpUIEEXxOr8jrdlP2n/aeq0i3Td9Wve/K53Az55v7AopcgzD+4HICp+05+M/a5P6GWee9hzDrZqDKHg/Zs14XoqBbB7MVm7YG/lUbicX5EQF8q5aJCv9yaEMm1O48IFJpUI/AnVJ8JxmCd/JmrDNt21XZsg+GUsUn25cj03NjA6tvpUiQxgS9Vb5KRkFP002QaIbZKk513TsRbusd1CqT3lwlltxir8Pw1hoEK7RxobsstG2PfZ47KBdBXGeYnXoU8BTly40zdSdYPPBcpA==;5:Wgp+Sg39j+8aEk7kRKwQfqZfIrbUpb6pNyfNiNPl4Q+51kD08rn5JXsecS6SP9qglLVsJopGyzHVpqsdh7zEa9GhtTVPdN0A/ApU+OfKoZUYS7ETPxHpLq5JR/Xj/gvTgsEPsNyL8/MO2yBkTyYdgq9Bwmjp6gbQ82kai9bBmJA=;7:rwzR3ThCK55YyVxjxKEHbzYN+wJzolSExP/Jz5KFw60cln+IRDIE1QwV/slp17tMMydC/rN0GCkkIlw2DT7of4y4o5kKI3bjzyXQ+eB8Ykv4BOq7U7Lfq5sknD6oublpkORzAKupNM/hAWOvG1/zZUjWRF7kydPbD8n161D5qFR7cKX+GEZ/wIHOyzEH1nE7AVaGC89rfjzs1x8XQo9+/CRxAr7SLsyeHH0CJqObFySpdziDXaUeHuAiMPY5gWfp
x-ms-office365-filtering-correlation-id: 2073186b-63a0-413a-4788-08d61c49eaab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502336F2D0E926FE95C39FBFB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(10290500003)(39060400002)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CY1DPrM+aRtT1SgbciqES61kMfB9SAn1COvmraoCjMSvkqpcO8eGNf6oOUaEQ5JkQxF/MS9vZH8kzBFtbG7NU4qvggTYaWJy+HNo3oajC6RvQ6oIwDLMcMQ+vOwLnswHFCN9gz82MuL+2dbLTsMRtFHxL4hqv4RMCckcb7zt+DrTb5u/o8WpHjTuj71+0iht9AQy3Vg0QZ2bbfYGQLebBpngLMndNGEMz6ZRjACQmhcL2cqPsoVhRga/o69XfpenvSUOtXe959rMQRc/Oiw3VrtIQTzoLAeRdhUQt3V0rBjG87Z8DUNZ0c66Zn1z7VGSL+G6YeSmHbznKCbGnz86QTQOwrgI9z8aqBeLiK9EvYE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2073186b-63a0-413a-4788-08d61c49eaab
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:52.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 9048f1f18a70a01eaa3c8e7166fdb2538929d780 ]

Currently the address field in iio_chan_spec is filled with an accel
data register address for the corresponding axis.

In preparation for adding calibration offset support, this sets the
address field to the index of accel data registers instead of the actual
register address.

This change makes it easier to access both accel registers and
calibration offset registers with fewer lines of code as these are
located in X-axis, Y-axis, Z-axis order.

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/accel/adxl345_core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_c=
ore.c
index 7251d0e63d74..98080e05ac6d 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -21,6 +21,8 @@
 #define ADXL345_REG_DATAX0		0x32
 #define ADXL345_REG_DATAY0		0x34
 #define ADXL345_REG_DATAZ0		0x36
+#define ADXL345_REG_DATA_AXIS(index)	\
+	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
=20
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
@@ -47,19 +49,19 @@ struct adxl345_data {
 	u8 data_range;
 };
=20
-#define ADXL345_CHANNEL(reg, axis) {					\
+#define ADXL345_CHANNEL(index, axis) {					\
 	.type =3D IIO_ACCEL,						\
 	.modified =3D 1,							\
 	.channel2 =3D IIO_MOD_##axis,					\
-	.address =3D reg,							\
+	.address =3D index,						\
 	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
 }
=20
 static const struct iio_chan_spec adxl345_channels[] =3D {
-	ADXL345_CHANNEL(ADXL345_REG_DATAX0, X),
-	ADXL345_CHANNEL(ADXL345_REG_DATAY0, Y),
-	ADXL345_CHANNEL(ADXL345_REG_DATAZ0, Z),
+	ADXL345_CHANNEL(0, X),
+	ADXL345_CHANNEL(1, Y),
+	ADXL345_CHANNEL(2, Z),
 };
=20
 static int adxl345_read_raw(struct iio_dev *indio_dev,
@@ -67,7 +69,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct adxl345_data *data =3D iio_priv(indio_dev);
-	__le16 regval;
+	__le16 accel;
 	int ret;
=20
 	switch (mask) {
@@ -77,12 +79,13 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
 		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
 		 */
-		ret =3D regmap_bulk_read(data->regmap, chan->address, &regval,
-				       sizeof(regval));
+		ret =3D regmap_bulk_read(data->regmap,
+				       ADXL345_REG_DATA_AXIS(chan->address),
+				       &accel, sizeof(accel));
 		if (ret < 0)
 			return ret;
=20
-		*val =3D sign_extend32(le16_to_cpu(regval), 12);
+		*val =3D sign_extend32(le16_to_cpu(accel), 12);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val =3D 0;
--=20
2.17.1
