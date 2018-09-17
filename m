Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA66FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B14D208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="l3enWboV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B14D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbeIQIrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:47:14 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730251AbeIQI3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr/Rz7VkihAAAacPAxwzVG6GIfnY/9pnrIud8pecgjY=;
 b=l3enWboVtQ1hHQYvJ0qIF3ikqTyOsRbTX4ekz28ir4qFN/NdLXL17XibMmAvyXfEgD6tMkRkFXh0KYPCgae8gAXGEU9hFCckyrz10Q8DihORjNK45cMuJdjKf2IMlVYZ7yIhUHzBjsKmHy/X7wTRlJocE9hxi5Qh+Cgsv6it86Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 48/87] iio: accel: adxl345: convert address field
 usage in iio_chan_spec
Thread-Topic: [PATCH AUTOSEL 4.14 48/87] iio: accel: adxl345: convert address
 field usage in iio_chan_spec
Thread-Index: AQHUTjLt2RVavBmWY0eIkXJnoD4P4A==
Date:   Mon, 17 Sep 2018 03:02:53 +0000
Message-ID: <20180917030220.245686-48-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:p/QWCDJlbPDq1tS2ZMK/A4RiOncxs8MZh2YUbi64jVRZt6Wwnf4GE90HTchKAEXhmo/EpDmu+swwwd2gW6ccMxuEOszXZ6Hpr+AwNgn9QAPROsstffADLgoveJQrFoBeaCFuJ6wHwmuxnkKNo9esc+jWsGzlkg0jKYJNf1qydx/hvdnM3g8QB/Jy0BZHp5hZqh3E3TIwGQolXJE1W8MSTiIrzQqG66jz8SZbgJqABEhJn+jl8J67BtAOzqMUKNcu70Rrjn0FCmVoCVloypv+ag0xMaEPLOEWtvryU2MgTmJlI7b1iv3v+8RQyI3cKCD0WvMKz+uE4oyeAZB2j6I+ddVwqhuZ9IjO0EyYeY51SILr11BTWGVG1ZjI9nKG+LqNdnivCqJTyXah0RDGhuDqaeKI3OnddYh3OzCIvCePodJYvT6m0MxbmtjSHXqkRf+GR2SQtpkeZOEZ7LiKfo6FSw==;5:bh7g2SBEaURudl9diUsAnS+2RFIZdJift3zUPs8zMNgxArNChhc7MeEa20lMjuuhiaYrhSKjXx4znHcC/07ZOXoBdptONy9jKMzT0nk1xRpmDPYrBQ9gOVulkpY/6iiJKKoOWN8r+TOBqPM4D5onMMLhyH8r1O97Vwheo1CnufQ=;7:PYsPwWt7wHZqAkpchLlRPthSWK8u9NZL+ICF01Wyq2aAqRUTN/3S7GNkKaSNYIMJy80lBsVm5uY/G79QP4LtP/TOrgHYefq4yq18BXq8LEdR4FsVoSdfgdFRv21FOS5e9ucETF/vYwLhHdccXgvyKkS0Z5qkSJyM29GmPVDUtJ3v7Zfyj2SaXjCY/sJEkTp8fpqCqrszrsNgTmZHGBmA9lVt3XYnFrH/23d3PrNsm38sNeh0TTEArm/QZcQ+fMKt
x-ms-office365-filtering-correlation-id: 184a3b39-1008-4061-5a14-08d61c4a4255
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776B706C3ABBE898E0BFA6AFB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(575784001)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(39060400002)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: x3pufQ7/n+AOhggKj5qrBYl3EpFSueuraZZvBVvYyWggPmXMnJMFe+UXO6HK5yiQicPg/Z5ftwy3IqCa6CqObOuJryeGaWqBGmHZjajaVIyjAAmX+D1tu4uPx1aosOvlabg/HRm0EXLAMYiwE6uDx1+nl5PBdj4+cXw/JnttU11ymczlfNgMBJu+3krzOBRW8wPwqODw6VZYOU6UfHRicpgmXTiNCuLeB904E9K75yloLAv7WM+ayCHeTyF2iS/7pdtski8/tOWxb8i+9AfiRNl2ZY8CxERf7lApE9YBMOjprHsGTMKaGaFBu/U85PE7I8jZuCcQdLkEH83DgAFIkgTafznZKetrWo4agvezF7Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184a3b39-1008-4061-5a14-08d61c4a4255
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:53.5717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
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
index 9ccb5828db98..3dda7afe8a11 100644
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
