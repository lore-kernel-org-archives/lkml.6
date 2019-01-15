Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50006C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CDC20578
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfAOATF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:19:05 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37360 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbfAOATF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:19:05 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0F0GFX0025501;
        Tue, 15 Jan 2019 01:19:00 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pyc012h1g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 15 Jan 2019 01:19:00 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94C2F31;
        Tue, 15 Jan 2019 00:18:59 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node1.st.com [10.75.127.10])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D4C81130;
        Tue, 15 Jan 2019 00:18:59 +0000 (GMT)
Received: from SFHDAG2NODE1.st.com (10.75.127.4) by SFHDAG4NODE1.st.com
 (10.75.127.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 15 Jan
 2019 01:18:59 +0100
Received: from SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90]) by
 SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90%20]) with mapi id
 15.00.1347.000; Tue, 15 Jan 2019 01:18:58 +0100
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Mario Tesi <martepisa@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mario TESI <mario.tesi@st.com>
Subject: RE: [PATCH] iio:st_pressure:initial lps22hh sensor support
Thread-Topic: [PATCH] iio:st_pressure:initial lps22hh sensor support
Thread-Index: AQHUrC4eDiZaIhqSo064Gq5PC9PrK6Wvd1Ew
Date:   Tue, 15 Jan 2019 00:18:58 +0000
Message-ID: <2844d78742404a0ebea470fa5e0ec722@SFHDAG2NODE1.st.com>
References: <1547486660-15359-1-git-send-email-mario.tesi@st.com>
In-Reply-To: <1547486660-15359-1-git-send-email-mario.tesi@st.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_13:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Denis Ciocca <denis.ciocca@st.com>


-----Original Message-----
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On Behalf Of Mario Tesi
Sent: Monday, January 14, 2019 9:24 AM
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Mario TESI <mario.tesi@st.com>
Subject: [PATCH] iio:st_pressure:initial lps22hh sensor support

From: mario tesi <mario.tesi@st.com>

Initial support for ST LPS22HH pressure sensor. Datasheet:
http://www2.st.com/resource/en/datasheet/lps22hh.pdf

Features:
 * pressure, temperature data and timestamping channels
 * sampling frequency selection [1..200] Hz
 * interrupt based trigger
 * over I2C or SPI interface

Signed-off-by: mario tesi <mario.tesi@st.com>
---
 drivers/iio/pressure/Kconfig            |  2 +-
 drivers/iio/pressure/st_pressure.h      |  2 +
 drivers/iio/pressure/st_pressure_core.c | 69 +++++++++++++++++++++++++++++++++  drivers/iio/pressure/st_pressure_i2c.c  |  5 +++  drivers/iio/pressure/st_pressure_spi.c  |  5 +++
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig index eaa7cfc..efeb89f 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -165,7 +165,7 @@ config IIO_ST_PRESS
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics pressure
-	  sensors: LPS001WP, LPS25H, LPS331AP, LPS22HB.
+	  sensors: LPS001WP, LPS25H, LPS331AP, LPS22HB, LPS22HH.
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index e67eb0d..5794660 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -21,6 +21,7 @@ enum st_press_type {
 	LPS22HB,
 	LPS33HW,
 	LPS35HW,
+	LPS22HH,
 	ST_PRESS_MAX,
 };
 
@@ -30,6 +31,7 @@ enum st_press_type {
 #define LPS22HB_PRESS_DEV_NAME		"lps22hb"
 #define LPS33HW_PRESS_DEV_NAME		"lps33hw"
 #define LPS35HW_PRESS_DEV_NAME		"lps35hw"
+#define LPS22HH_PRESS_DEV_NAME		"lps22hh"
 
 /**
  * struct st_sensors_platform_data - default press platform data diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 4ddb6cf..38dcdb7 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -492,6 +492,75 @@
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
+	{
+		/*
+		 * CUSTOM VALUES FOR LPS22HH SENSOR
+		 * See LPS22HH datasheet:
+		 * http://www2.st.com/resource/en/datasheet/lps22hh.pdf
+		 */
+		.wai = 0xb3,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LPS22HH_PRESS_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_press_lps22hb_channels,
+		.num_ch = ARRAY_SIZE(st_press_lps22hb_channels),
+		.odr = {
+			.addr = 0x10,
+			.mask = 0x70,
+			.odr_avl = {
+				{ .hz = 1, .value = 0x01 },
+				{ .hz = 10, .value = 0x02 },
+				{ .hz = 25, .value = 0x03 },
+				{ .hz = 50, .value = 0x04 },
+				{ .hz = 75, .value = 0x05 },
+				{ .hz = 100, .value = 0x06 },
+				{ .hz = 200, .value = 0x07 },
+			},
+		},
+		.pw = {
+			.addr = 0x10,
+			.mask = 0x70,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.fs = {
+			.fs_avl = {
+				/*
+				 * Pressure and temperature sensitivity values
+				 * as defined in table 3 of LPS22HH datasheet.
+				 */
+				[0] = {
+					.num = ST_PRESS_FS_AVL_1260MB,
+					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
+					.gain2 = ST_PRESS_LPS22HB_LSB_PER_CELSIUS,
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x10,
+			.mask = BIT(1),
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x12,
+				.mask = BIT(2),
+				.addr_od = 0x11,
+				.mask_od = BIT(5),
+			},
+			.addr_ihl = 0x11,
+			.mask_ihl = BIT(6),
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x03,
+			},
+		},
+		.sim = {
+			.addr = 0x10,
+			.value = BIT(0),
+		},
+		.multi_read_bit = false,
+		.bootime = 2,
+	},
 };
 
 static int st_press_write_raw(struct iio_dev *indio_dev, diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 2026a10..a60849d 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -45,6 +45,10 @@
 		.compatible = "st,lps35hw",
 		.data = LPS35HW_PRESS_DEV_NAME,
 	},
+	{
+		.compatible = "st,lps22hh",
+		.data = LPS22HH_PRESS_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match); @@ -69,6 +73,7 @@
 	{ LPS22HB_PRESS_DEV_NAME, LPS22HB },
 	{ LPS33HW_PRESS_DEV_NAME, LPS33HW },
 	{ LPS35HW_PRESS_DEV_NAME, LPS35HW },
+	{ LPS22HH_PRESS_DEV_NAME, LPS22HH },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_press_id_table); diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 9a3441b..79a12ed 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -49,6 +49,10 @@
 		.compatible = "st,lps35hw",
 		.data = LPS35HW_PRESS_DEV_NAME,
 	},
+	{
+		.compatible = "st,lps22hh",
+		.data = LPS22HH_PRESS_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match); @@ -93,6 +97,7 @@ static int st_press_spi_remove(struct spi_device *spi)
 	{ LPS22HB_PRESS_DEV_NAME },
 	{ LPS33HW_PRESS_DEV_NAME },
 	{ LPS35HW_PRESS_DEV_NAME },
+	{ LPS22HH_PRESS_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_press_id_table);
--
1.9.1

