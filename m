Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7E4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044E3208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=invensense.com header.i=@invensense.com header.b="EDGHILVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044E3208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invensense.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbeGKMeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:34:03 -0400
Received: from mail-eopbgr700076.outbound.protection.outlook.com ([40.107.70.76]:39331
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732286AbeGKMeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KseVBtkbET6u3ae/+E1KD4qXaDLElSZupDOiH3JnPzg=;
 b=EDGHILVGbRxMx2cRZmodzAL0LVauvmqS5yPu7c5glj1SgugWb7MtnJfy0lnguT/8z1E2pKlu/+uflnqApn7oiXBnbt7fecrZzImUFzVR9DLAtVPbOowF9ae/8ofPDkwar7dPR+C0NYRxsC1nVa8lSoayE1YMZGAKE1ofUxsdUP4=
Received: from SN1PR12MB2525.namprd12.prod.outlook.com (52.132.196.156) by
 SN1PR12MB0349.namprd12.prod.outlook.com (10.162.4.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 12:29:33 +0000
Received: from SN1PR12MB2525.namprd12.prod.outlook.com
 ([fe80::64e2:d3c3:835e:17d0]) by SN1PR12MB2525.namprd12.prod.outlook.com
 ([fe80::64e2:d3c3:835e:17d0%6]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 12:29:33 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Brian Masney <masneyb@onstation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>
CC:     "jonathan@marek.ca" <jonathan@marek.ca>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "mkelly@xevo.com" <mkelly@xevo.com>,
        "fischerdouglasc@gmail.com" <fischerdouglasc@gmail.com>,
        "bshah@kde.org" <bshah@kde.org>,
        "ctatlor97@gmail.com" <ctatlor97@gmail.com>
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add support for regulator
 framework
Thread-Topic: [PATCH 2/3] iio: imu: mpu6050: add support for regulator
 framework
Thread-Index: AQHUGLPc4EHyBTIlJEG93uxWEJTW/aSJ8wP+
Date:   Wed, 11 Jul 2018 12:29:33 +0000
Message-ID: <SN1PR12MB2525E8A460DA734A7C6A2692C45A0@SN1PR12MB2525.namprd12.prod.outlook.com>
References: <20180711010932.20313-1-masneyb@onstation.org>,<20180711010932.20313-3-masneyb@onstation.org>
In-Reply-To: <20180711010932.20313-3-masneyb@onstation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JManeyrol@invensense.com; 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0349;7:k+Hd5+/QEPJJOZEzteLMo0kb8LjUANj7ehe72Z6USKmylhEAq6/EXZ/+eh2hsKlY7PEo9bS1b+k2fvGwLCK97G4kre48Nm1325N/kY2YB2JPS0Q2J2AHd6r7CLWP4fIdWd20rvWMefNZqiy9B0SDXdF9ApGGKrulJWdw9QfofZZYunJ+TYjvIWRl3Oz6oWMcBK9i1OQiaVV2U7aPBzzmDbFsIbJtGn9zyvDMFCSGVkLDpVXQyPqxHSgGULqmVZnt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 71074792-7c53-4a29-63f8-08d5e729f547
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0349;
x-ms-traffictypediagnostic: SN1PR12MB0349:
x-microsoft-antispam-prvs: <SN1PR12MB0349832D9E552BC6522E1EF3C45A0@SN1PR12MB0349.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(26323138287068)(9452136761055)(85827821059158)(4782527817362)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0349;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0349;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39850400004)(51914003)(52314003)(199004)(189003)(55016002)(6306002)(74316002)(106356001)(86362001)(97736004)(6246003)(2900100001)(33656002)(80792005)(99286004)(4326008)(68736007)(9686003)(7736002)(105586002)(2201001)(8936002)(305945005)(6116002)(39060400002)(6436002)(2906002)(6506007)(66066001)(54906003)(7696005)(478600001)(5660300001)(5250100002)(446003)(11346002)(81166006)(476003)(229853002)(2501003)(3846002)(81156014)(102836004)(14454004)(186003)(53936002)(7416002)(53546011)(5024004)(256004)(14444005)(26005)(966005)(316002)(72206003)(8676002)(25786009)(76176011)(110136005)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0349;H:SN1PR12MB2525.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zZ+aqShvkB0xb3hnKbG3rqVLus4/VMaY/WKTdARYcDimBs8dSsixNv8UgYiyaQk6GAzYACr0N5iRT88vkUvIw3IhaUMkwTMV+lsQQuhzyEhByoCk4INXHqhlkkBLQZfO4DypyJ4/0VgpvScHAlmVQH6Xptn/NTRxrffbUB7VwFs+SLtEljZDQ+yFWrI7i8gpkjEVw7uqk9Z5g1Adm/KImry6LsbRJ0TCJukiadW2YfvVcOe8CXzzy0ZxvGy+42/aBwBzGaEH5Q1rP6v0kFi4R4ttYq959PYPHDjsQP9K51YHiKfOo/ENsv33d5hqIzAinsjMiBftVDVdAvYW7KplWnxurRX44GjyFHmHUBUkOdM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71074792-7c53-4a29-63f8-08d5e729f547
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 12:29:33.6204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I really don't like the idea to have regulator handled inside the driver. I=
 know this was done like that before for Nexus 5, but I think now this is s=
omething that can be done using dts only.
Does anyone know if there is a way with dts to handle regulator automatical=
ly and prevent the use in the driver? That would be a good idea to search h=
ow this handled for other drivers.

Anyway, you are enforcing regulator use in your code. It doesn't seem the c=
ode will work when there is no regulator declared in the dts, which is the =
case for the majority of configurations. We should at least make it optiona=
l.

Thanks for the contribution.
JB


From: Brian Masney <masneyb@onstation.org>
Sent: Wednesday, July 11, 2018 03:09
To: jic23@kernel.org; robh+dt@kernel.org; mark.rutland@arm.com; andy.gross@=
linaro.org; david.brown@linaro.org; linux-iio@vger.kernel.org; devicetree@v=
ger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org=
; linux-soc@vger.kernel.org
Cc: jonathan@marek.ca; Jean-Baptiste Maneyrol; knaack.h@gmx.de; lars@metafo=
o.de; pmeerw@pmeerw.net; mkelly@xevo.com; fischerdouglasc@gmail.com; bshah@=
kde.org; ctatlor97@gmail.com; masneyb@onstation.org
Subject: [PATCH 2/3] iio: imu: mpu6050: add support for regulator framework
=A0=20

CAUTION: This email originated from outside of the organization. Please mak=
e sure the sender is who they say they are and do not click links or open a=
ttachments unless you recognize the sender and know the content is safe.


This patch adds support for the regulator framework to the mpu6050
driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
This is a variation of Jonathan Marek's patch from postmarketOS
https://gitlab.com/postmarketOS/linux-postmarketos/commit/b8ad1ec1859c8bbcb=
ce94944b3f4dd68f8f9fc37
with the following changes:

- Stripped out 6515 variant code. (See my previous patch in this series)
- Add the regulator to the mpu core instead of only the i2c variant.
- Add error handling.
- Release the regulator on suspend, device remove, etc.
- Device tree documentation.

=A0.../bindings/iio/imu/inv_mpu6050.txt=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0=A0=A0 | 57 +++++++++++++++=
++--
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=A0=A0=A0=A0 |=A0 2 +-
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0=A0=A0=A0 |=A0 3 +
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=A0=A0=A0=A0 |=A0 9 +++
=A05 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Do=
cumentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index b7def51c8ad9..d39907b12a46 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -21,6 +21,7 @@ Required properties:
=A0=A0 bindings.

=A0Optional properties:
+ - vddio-supply: regulator phandle for VDDIO supply
=A0 - mount-matrix: an optional 3x3 mounting rotation matrix
=A0 - i2c-gate node.=A0 These devices also support an auxiliary i2c bus.=A0=
 This is
=A0=A0=A0 simple enough to be described using the i2c-gate binding. See
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 12c1b9507007..ec276b7bcc69 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -23,6 +23,7 @@
=A0#include <linux/iio/iio.h>
=A0#include <linux/acpi.h>
=A0#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
=A0#include "inv_mpu_iio.h"

=A0/*
@@ -926,6 +927,19 @@ static int inv_check_and_setup_chip(struct inv_mpu6050=
_state *st)
=A0=A0=A0=A0=A0=A0=A0 return result;
=A0}

+static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
+{
+=A0=A0=A0=A0=A0=A0 int result;
+
+=A0=A0=A0=A0=A0=A0 result =3D regulator_enable(st->vddio_supply);
+=A0=A0=A0=A0=A0=A0 if (result =3D=3D 0) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Give the device a little bit=
 of time to start up. */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(35000, 70000);
+=A0=A0=A0=A0=A0=A0 }
+
+=A0=A0=A0=A0=A0=A0 return result;
+}
+
=A0int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int (*inv_mpu_bus_setup)(stru=
ct iio_dev *), int chip_type)
=A0{
@@ -990,15 +1004,28 @@ int inv_mpu_core_probe(struct regmap *regmap, int ir=
q, const char *name,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
=A0=A0=A0=A0=A0=A0=A0 }

+=A0=A0=A0=A0=A0=A0 st->vddio_supply =3D devm_regulator_get_optional(dev, "=
vddio");
+=A0=A0=A0=A0=A0=A0 if (IS_ERR(st->vddio_supply)) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (PTR_ERR(st->vddio_supply) !=
=3D -EPROBE_DEFER)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err=
(dev, "Failed to get vddio regulator %d\n",
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (int)PTR_ERR(st->vddio_supply));
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(st->vddio_supply=
);
+=A0=A0=A0=A0=A0=A0 }
+
+=A0=A0=A0=A0=A0=A0 result =3D inv_mpu_core_enable_regulator(st);
+=A0=A0=A0=A0=A0=A0 if (result)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
+
=A0=A0=A0=A0=A0=A0=A0 /* power is turned on inside check chip type*/
=A0=A0=A0=A0=A0=A0=A0 result =3D inv_check_and_setup_chip(st);
=A0=A0=A0=A0=A0=A0=A0 if (result)
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_disable_regulator;

=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_init_config(indio_dev);
=A0=A0=A0=A0=A0=A0=A0 if (result) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "Could not initi=
alize device.\n");
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_disable_regulator;
=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0 if (inv_mpu_bus_setup)
@@ -1023,24 +1050,34 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
rq, const char *name,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL)=
;
=A0=A0=A0=A0=A0=A0=A0 if (result) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "configure buffe=
r fail %d\n", result);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_disable_regulator;
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_probe_trigger(indio_dev, irq_t=
ype);
=A0=A0=A0=A0=A0=A0=A0 if (result) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "trigger probe f=
ail %d\n", result);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_disable_regulator;
=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0 result =3D devm_iio_device_register(dev, indio_dev);
=A0=A0=A0=A0=A0=A0=A0 if (result) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "IIO register fa=
il %d\n", result);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_disable_regulator;
=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0 return 0;
+
+out_disable_regulator:
+=A0=A0=A0=A0=A0=A0 regulator_disable(st->vddio_supply);
+=A0=A0=A0=A0=A0=A0 return result;
+
=A0}
=A0EXPORT_SYMBOL_GPL(inv_mpu_core_probe);

+int inv_mpu_core_remove(struct inv_mpu6050_state *st)
+{
+=A0=A0=A0=A0=A0=A0 return regulator_disable(st->vddio_supply);
+}
+
=A0#ifdef CONFIG_PM_SLEEP

=A0static int inv_mpu_resume(struct device *dev)
@@ -1050,6 +1087,11 @@ static int inv_mpu_resume(struct device *dev)

=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);
=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);
+=A0=A0=A0=A0=A0=A0 if (result)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;
+
+=A0=A0=A0=A0=A0=A0 result =3D inv_mpu_core_enable_regulator(st);
+out_unlock:
=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);

=A0=A0=A0=A0=A0=A0=A0 return result;
@@ -1062,6 +1104,11 @@ static int inv_mpu_suspend(struct device *dev)

=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);
=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, false);
+=A0=A0=A0=A0=A0=A0 if (result)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;
+
+=A0=A0=A0=A0=A0=A0 result =3D regulator_disable(st->vddio_supply);
+out_unlock:
=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);

=A0=A0=A0=A0=A0=A0=A0 return result;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c
index dd758e3d403d..ce227038c61c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -164,7 +164,7 @@ static int inv_mpu_remove(struct i2c_client *client)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c_mux_del_adapters(st->muxc=
);
=A0=A0=A0=A0=A0=A0=A0 }

-=A0=A0=A0=A0=A0=A0 return 0;
+=A0=A0=A0=A0=A0=A0 return inv_mpu_core_remove(st);
=A0}

=A0/*
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index e69a59659dbc..0289615a6135 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -129,6 +129,7 @@ struct inv_mpu6050_hw {
=A0 *=A0 @chip_period:=A0=A0=A0=A0=A0 chip internal period estimation (~1kH=
z).
=A0 *=A0 @it_timestamp:=A0=A0=A0=A0 timestamp from previous interrupt.
=A0 *=A0 @data_timestamp:=A0=A0 timestamp for next data sample.
+ *=A0 @vddio_supply=A0=A0=A0=A0=A0 voltage regulator for the chip.
=A0 */
=A0struct inv_mpu6050_state {
=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;
@@ -149,6 +150,7 @@ struct inv_mpu6050_state {
=A0=A0=A0=A0=A0=A0=A0 s64 chip_period;
=A0=A0=A0=A0=A0=A0=A0 s64 it_timestamp;
=A0=A0=A0=A0=A0=A0=A0 s64 data_timestamp;
+=A0=A0=A0=A0=A0=A0 struct regulator *vddio_supply;
=A0};

=A0/*register and associated bit definition*/
@@ -321,4 +323,5 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *c=
lient);
=A0void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
=A0int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int (*inv_mpu_bus_setup)(stru=
ct iio_dev *), int chip_type);
+int inv_mpu_core_remove(struct inv_mpu6050_state *st);
=A0extern const struct dev_pm_ops inv_mpu_pmops;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_spi.c
index 227f50afff22..fce935f8f1e4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -70,6 +70,14 @@ static int inv_mpu_probe(struct spi_device *spi)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 inv_mpu_i2c_disable, chip_type);
=A0}

+static int inv_mpu_remove(struct spi_device *spi)
+{
+=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
+=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+
+=A0=A0=A0=A0=A0=A0 return inv_mpu_core_remove(st);
+}
+
=A0/*
=A0 * device id table is used to identify what device can be
=A0 * supported by this driver
@@ -94,6 +102,7 @@ MODULE_DEVICE_TABLE(acpi, inv_acpi_match);

=A0static struct spi_driver inv_mpu_driver =3D {
=A0=A0=A0=A0=A0=A0=A0 .probe=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=A0=A0=A0=A0=A0=
=A0 inv_mpu_probe,
+=A0=A0=A0=A0=A0=A0 .remove=A0=A0=A0=A0=A0=A0=A0=A0 =3D=A0=A0=A0=A0=A0=A0 i=
nv_mpu_remove,
=A0=A0=A0=A0=A0=A0=A0 .id_table=A0=A0=A0=A0=A0=A0 =3D=A0=A0=A0=A0=A0=A0 inv=
_mpu_id,
=A0=A0=A0=A0=A0=A0=A0 .driver =3D {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .acpi_match_table =3D ACPI_PT=
R(inv_acpi_match),
--
2.17.1

    =
