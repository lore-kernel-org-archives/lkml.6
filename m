Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489401-2-18030244349154928211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489400; b=br4wlkdbS7H9SSYUCsHwbb9W1r/aIGT307I3iq7KtCol23e
    fR6Z+kuXvP6a32vCW0uGRPSdg+25NyK5xjOJu3iqJWbgfJ+awmLqNl2xr/sxreDf
    lgEQOAAN/itR82hkfU7XNITN7vEd0d18FnmkphHshrIKCilN09hngdM7s0k0OtJR
    DSPG1f1bh4xChVNTzExw9XttiTc1LyTGwbOPxZnLS0HPdFVzb5YqPtFrQuZFCxlU
    OfKOnfBa0EMbva9p11kc4cJPRmDsQ+jOOFFfsLbs818wASS+P0WB3mNA6Ij+i3YM
    T5QQXE4Wj/3BC8ekauQkkXS1L3kBkSUhwalHrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489400; bh=hRjMwb
    xzy3lyyqUJjwoj/uVxYwOyV4X5hCMMBhkDJOk=; b=NKUgYrRzypL+/9yjBHOQuR
    5C4UQep8qjOODAIaDtZQWlo6wHXuA3SLOotdYxEFnAjoK5Xj4aB+sHBaFs/rUFnf
    fAXLd337WjuVRaoms+1rJn4jXvOfqLJKN6iTodqerZkpV2P4unQV9nhjmgqvm9CI
    en0b7NAj3dqcorT++o/XdL0+HiCnLoLnmoEenmK6B7SHvasP5Dlz+Nu9JRqE5PAV
    HkITkvV3B/nxd80mLBB9OczUg8VMZEN9z9nWS1Lt5CrNOicDJSwbdfGi2rRWdiG3
    2nWb4HJyjcBw/ht1SFs0sYs+WbSJBahK/CAfz64K8vk3n5tzHdNpEiG/jehX3oCw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WaxF7cNR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WaxF7cNR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeCHFBp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:45 -0500
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:60864
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965761AbeCHFBk (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:40 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shrirang Bagul <shrirang.bagul@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 089/190] iio: st_pressure: st_accel:
 Initialise sensor platform data properly
Thread-Topic: [PATCH AUTOSEL for 4.9 089/190] iio: st_pressure: st_accel:
 Initialise sensor platform data properly
Thread-Index: AQHTtpo+qLgOf8R2rEqaANLUS82oPQ==
Date: Thu, 8 Mar 2018 04:59:30 +0000
Message-ID: <20180308045810.8041-89-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;20:wBplaf+9/s1DQoBQPeSsJHuRTCVLA6katnhVk5eu3X260nVLouGskqXo7TsSztd71f3GBPP0kf6c6HDVsxJGfJ/F5hoeWihgs/rcujANXHbXTFQG0t73MaYiDv3iY+d4UwcXy3TGExieCZ6TSNoBSjK+YtGuDf8zZe9feNAGkYw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fee2aef-bfd2-4ece-6e72-08d584b1aac7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983B2749D1929BF15A7F160FBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(575784001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(6666003)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: bz3VKRFZrrcBPaAxEdnL14bTgWXJ7XG6C8vsShufU4lYdrttX+K2GZhXPeCd+gEqHBOTWK1RZJI48qnGquuC6uQ5lIQoElXQoaXSMgVn9/6d/p+LI9x9sDe0jlwGIRCzlgwfsvZv+Xoisvcn1+1o9Z+5yuTXi4viYzYqa4mIMs3TNdcdUzUftfPYk1USj5iRqjanuLLRLB5f+AB+7yQehkSjyOiLee3A8fU8LDs0yke4cRTlvb3vBqWg86CSGQT8BUwtZK1GR8YTMILrLCnttqCPEO8Jh+iQyG4h0Dul9ma0YuqpE3SY/qLKDOQZIJBQRHrALVtYFryDcDT3lK/etw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fee2aef-bfd2-4ece-6e72-08d584b1aac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:30.8517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shrirang Bagul <shrirang.bagul@canonical.com>

[ Upstream commit 7383d44b84c94aaca4bf695a6bd8a69f2295ef1a ]

This patch fixes the sensor platform data initialisation for st_pressure
and st_accel device drivers. Without this patch, the driver fails to
register the sensors when the user removes and re-loads the driver.

1. Unload the kernel modules for st_pressure
$ sudo rmmod st_pressure_i2c
$ sudo rmmod st_pressure

2. Re-load the driver
$ sudo insmod st_pressure
$ sudo insmod st_pressure_i2c

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/accel/st_accel_core.c       | 7 ++++---
 drivers/iio/pressure/st_pressure_core.c | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel=
_core.c
index 3a557e3181ea..fe94415a0bc7 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -827,6 +827,8 @@ static const struct iio_trigger_ops st_accel_trigger_op=
s =3D {
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata =3D iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =3D
+		(struct st_sensors_platform_data *)adata->dev->platform_data;
 	int irq =3D adata->get_irq_data_ready(indio_dev);
 	int err;
=20
@@ -853,9 +855,8 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 					&adata->sensor_settings->fs.fs_avl[0];
 	adata->odr =3D adata->sensor_settings->odr.odr_avl[0].hz;
=20
-	if (!adata->dev->platform_data)
-		adata->dev->platform_data =3D
-			(struct st_sensors_platform_data *)&default_accel_pdata;
+	if (!pdata)
+		pdata =3D (struct st_sensors_platform_data *)&default_accel_pdata;
=20
 	err =3D st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
 	if (err < 0)
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure=
/st_pressure_core.c
index 44e46c159a7e..bec60299b6ec 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -638,6 +638,8 @@ static const struct iio_trigger_ops st_press_trigger_op=
s =3D {
 int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data =3D iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =3D
+		(struct st_sensors_platform_data *)press_data->dev->platform_data;
 	int irq =3D press_data->get_irq_data_ready(indio_dev);
 	int err;
=20
@@ -673,10 +675,8 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 	press_data->odr =3D press_data->sensor_settings->odr.odr_avl[0].hz;
=20
 	/* Some devices don't support a data ready pin. */
-	if (!press_data->dev->platform_data &&
-				press_data->sensor_settings->drdy_irq.addr)
-		press_data->dev->platform_data =3D
-			(struct st_sensors_platform_data *)&default_press_pdata;
+	if (!pdata && press_data->sensor_settings->drdy_irq.addr)
+		pdata =3D	(struct st_sensors_platform_data *)&default_press_pdata;
=20
 	err =3D st_sensors_init_sensor(indio_dev, press_data->dev->platform_data)=
;
 	if (err < 0)
--=20
2.14.1
