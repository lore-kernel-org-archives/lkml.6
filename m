Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122858-2-194447186741730270
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122858; b=VstoqfslDVhxEea+XX1CSpCbhAuKQFj/SJtkWpsnjJ2T3nb
    1tSbMeSCU7SGPaK/vuHGAQrkSa8Kf24F/c20AQwiKgcx3WOhMIORxAqf2+EQWDDQ
    iRwFoXxK1xae/toBhp9ImZ9GnuZFIyLge3Aj0fmwq73Q6irwpgWhrXYTseEzpcVo
    ugzxPps46mJr15EXjYnGuW1uZTQPYCo3IqXRJwXRU+v7afcvYuvEFGIOtsEDNszZ
    vrAulMtU5ZhHHLKW1z7aXotwS5tc5PGdBfaD/DaGcYkF1cjMG3p5HemfkX6LIg7J
    kZ7JmJeV9RH+9Dv2IsPE/ZvjDoJoFjteURQi+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122858; bh=IcUTtJ
    C66x6vVROkR0xvKyx1h8Mjk5tDOPNMDNn02ow=; b=cWRuc/tfn5FZf7RoF6yVp8
    6ejqbbI1idhiZU4231Y0kYZJpMn227wvzB9tCvKKvSN5jHRxavem5SYOJRue9ElE
    Lk9CoM3ADChXYlh/nXFRHmn1oOaLl8cAQS29mQ8x+ydsE3koSLP7paFVBS7qv0zv
    xvMLZg/PcRpU0vXImOzIA6fyhxcmIdqyHJ30dP8CRjTjtg8TaEImH4OQlXZTuEt9
    +C2YJxZUMuDXTuj9rnilCAtDp18nZCrh0a/MuVnbijTGTmDHGs+kLla0JU6jy2c/
    Z3WcX1/p2Isd6fu3dz/LCmzJke4YftJpSDlMqjjfutL1TRy67Fsx9yI6Ocr13bkw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=URlDxON+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=URlDxON+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932722AbeCCW3C (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:29:02 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:45301
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932402AbeCCW3A (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 37/84] iio: health: max30102: Add power
 enable parameter to get_temp function
Thread-Topic: [PATCH AUTOSEL for 4.14 37/84] iio: health: max30102: Add power
 enable parameter to get_temp function
Thread-Index: AQHTsz6n8lD1qh5cnk68zmMZDOU1XA==
Date: Sat, 3 Mar 2018 22:26:21 +0000
Message-ID: <20180303222518.26271-37-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:h6h9AJb7OhryuK9kTQZ4mkpMqzzNfOIFFocnW6PPpiY0yUWjBupK3rYBmAZLsE9AnbgSKZwlOqPJHYORR33BX14OmvGnVL3pCUDNTaUJSoWPro59AvogMWmROxb/E6VKzyblGCG/LT7m8za8IwRcjCbP2RgQBWzz0NtaBs3ugjx/Ld/JgGN09f2xNg7fT8NTTM8SXXnfEfTyS41+xIS2lPn/dm9XUYhSiNor7vi3oeLrgUc69ew8+iMK30SCV9PX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30461b5f-007f-4013-8552-08d581562718
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11157ECCCE965669828DB8B0FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: WsxNYV9UnAAZRttAa/Mgp7U4QFJ3SAznVHkgWmuT2EEEzWPzWJIzBeGREfywVopTwgy1pQ7CmZc67BP4kj9Fq85iZbC1gMR68B8Kw2jmotumtMTSLIyyicLlit4E1kfFBpE0YYd9GMVELSW22jzKbPlOdzezFA2fP24r9W9rnnQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30461b5f-007f-4013-8552-08d581562718
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:21.2911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>

[ Upstream commit a9c47abbdd71dceeaf1b923e5ce10e700e036905 ]

Chip must not be in shutdown for reading temperature, so briefly leave
shutdown if buffer is not already running

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/health/max30102.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 9fb4bc73a6bc..3ac25b21cbfc 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -329,20 +329,31 @@ static int max30102_read_temp(struct max30102_data *d=
ata, int *val)
 	return 0;
 }
=20
-static int max30102_get_temp(struct max30102_data *data, int *val)
+static int max30102_get_temp(struct max30102_data *data, int *val, bool en=
)
 {
 	int ret;
=20
+	if (en) {
+		ret =3D max30102_set_powermode(data, true);
+		if (ret)
+			return ret;
+	}
+
 	/* start acquisition */
 	ret =3D regmap_update_bits(data->regmap, MAX30102_REG_TEMP_CONFIG,
 				 MAX30102_REG_TEMP_CONFIG_TEMP_EN,
 				 MAX30102_REG_TEMP_CONFIG_TEMP_EN);
 	if (ret)
-		return ret;
+		goto out;
=20
 	msleep(35);
+	ret =3D max30102_read_temp(data, val);
+
+out:
+	if (en)
+		max30102_set_powermode(data, false);
=20
-	return max30102_read_temp(data, val);
+	return ret;
 }
=20
 static int max30102_read_raw(struct iio_dev *indio_dev,
@@ -355,20 +366,19 @@ static int max30102_read_raw(struct iio_dev *indio_de=
v,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		/*
-		 * Temperature reading can only be acquired while engine
-		 * is running
+		 * Temperature reading can only be acquired when not in
+		 * shutdown; leave shutdown briefly when buffer not running
 		 */
 		mutex_lock(&indio_dev->mlock);
-
 		if (!iio_buffer_enabled(indio_dev))
-			ret =3D -EBUSY;
-		else {
-			ret =3D max30102_get_temp(data, val);
-			if (!ret)
-				ret =3D IIO_VAL_INT;
-		}
-
+			ret =3D max30102_get_temp(data, val, true);
+		else
+			ret =3D max30102_get_temp(data, val, false);
 		mutex_unlock(&indio_dev->mlock);
+		if (ret)
+			return ret;
+
+		ret =3D IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val =3D 1000;  /* 62.5 */
--=20
2.14.1
