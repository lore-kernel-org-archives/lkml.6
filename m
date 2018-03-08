Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485583-2-14676749137681185604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485582; b=k+W5DR7ra393iIzdsc8bc2eswQBY094FjcDU6DmUfm+bfLv
    axLoXvUCHu8iTL9bnsvwLtdkmjfAFUpJApU3OffNw8eoTQAELLlhzDYp2eDx8db6
    3U/dIWCnReIkPy3h/O5FoJm4/naL9XKNxwf4QWbrf7KwjbrFFKfOE8dm8IMVVKYL
    yj6NmOx3sg4rXZwTnJb71zm7cOE6xAlhqXAH1XcxNbs0YenQ64HU4/jhUg169GbB
    g00F37hAZCSkVs5S1D/oe9h0Gxr9euYV3SoFjtij1JZNmkcLURM+NQpIZt4E9gND
    FI8su3WqGVmr3wgYPPrkp6QBtC6IYU0Jn2W4wIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485582; bh=OvTJSo
    bTqydvrV+e2275Kp5aomLlfE4If1nvi6jOw8k=; b=PhyzppOsthDpv+Q7tjw0+0
    ZJHagXLuwXQk1qB9rb6AJIoAtmNqEMIEX4LcF/wt0DPtnG0AHvhcpVfzVcXULJt7
    YJIRg/Vj86sD8Gye1RvDdu+5cR4cf9swS322OR1Psn6oPECngOD51Bg3JlLmBlcw
    a9GBwpXRFhCPqPJJjBQF9nQTBrvNdoMo4HkEiLqqmjaUjW9ydVqOgApyV37XIPDt
    0RNCKAyvMlB4EK+XRCxMmF7abCrI/ZsVYiTFJYP6EJ6VVH0C/qzT1AjwNuA394vp
    r/maizqFL0W+wtbIJ2BAHqeZfLyYXezQsePGogQTfbVhKQhwKBXFnoLUavycgDtQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V4bIY4iU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V4bIY4iU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966394AbeCHFGS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:18 -0500
Received: from mail-by2nam01on0131.outbound.protection.outlook.com ([104.47.34.131]:12788
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966373AbeCHFGP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shrirang Bagul <shrirang.bagul@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 051/101] iio: st_pressure: st_accel:
 Initialise sensor platform data properly
Thread-Topic: [PATCH AUTOSEL for 4.4 051/101] iio: st_pressure: st_accel:
 Initialise sensor platform data properly
Thread-Index: AQHTtpqS7+XeB6AsyEmlFDtuBhdb5Q==
Date: Thu, 8 Mar 2018 05:01:52 +0000
Message-ID: <20180308050023.8548-51-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;20:FQDOMQcjjuWnwqDqK8iFE7LAH40y0J1ukboa9KY39uiL0cGzmmR2g7UbyuIaViMKUHSUD/U/bmCOtDvngP/aItTwBf5ylJwmdsFXkCoPp8FsmurOVtSMemRsE4Dx2VO7kLoC08+6WHBs9YPRNAdaGsj57tElsghdBykDtqXx3Jw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c616c12d-7ebc-44b5-b99c-08d584b24fcd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091736F7FAAD6C8D2F7CB778FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: /rTAbZohfNCVjteIk3VH7YX776YlcmtuF/KxmZUe+1K1+sDf0A7q1sP/hR793vMT8DIX2VWAp9HrF7V617zxirLbAosuLY3DndBG/noLMxO3pYuaBTS1N2Xs11WpaS73T7kfoqHmzl5JHiUabVBgk+sI8dfefMDjY8zk8CxJIsxsZLLJMpKEMKyIoy+eYlWd3eR95EQr/Wb1n8rMkr2q77LXNL1nC9Mz0R8K0RmSinyjxel5EriBY5U2vB8chr0hNP+qd0uCD+kbn828bqqSnOekYDAM6c82gh5BhV+iIsidwMY05uTituM01s8RqR6Hok4Q0IJnEnKGE8bd/yObdQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c616c12d-7ebc-44b5-b99c-08d584b24fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:52.7782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
index 197a08b4e2f3..84ab20c6b389 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -628,6 +628,8 @@ static const struct iio_trigger_ops st_accel_trigger_op=
s =3D {
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata =3D iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =3D
+		(struct st_sensors_platform_data *)adata->dev->platform_data;
 	int irq =3D adata->get_irq_data_ready(indio_dev);
 	int err;
=20
@@ -652,9 +654,8 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
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
index 5056bd68573f..270eeac928bc 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -436,6 +436,8 @@ static const struct iio_trigger_ops st_press_trigger_op=
s =3D {
 int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data =3D iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =3D
+		(struct st_sensors_platform_data *)press_data->dev->platform_data;
 	int irq =3D press_data->get_irq_data_ready(indio_dev);
 	int err;
=20
@@ -464,10 +466,8 @@ int st_press_common_probe(struct iio_dev *indio_dev)
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
