Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeCJWHI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 17:07:08 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33759 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeCJWHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 17:07:04 -0500
X-Google-Smtp-Source: AG47ELsp/FHBdVBHp5Dc8CBUdumjluKlpX2b/CrAueuMd9lBJbhHyvL6YQrACBQhM4vZM29Pc7H3zA==
Message-ID: <aa5e8170ba7419318ccb34a06d2610d1ac8b7826.camel@elementarea.net>
Subject: [PATCH v2 1/2] iio: Add modifiers for ethanol and H2 gases
From: Andreas Brauchli <a.brauchli@elementarea.net>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sat, 10 Mar 2018 23:07:02 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ethanol and H2 gas modifiers:
* IIO_MOD_ETHANOL
* IIO_MOD_H2

Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++++
 include/uapi/linux/iio/types.h          | 2 ++
 tools/iio/iio_event_monitor.c           | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6a5f34b4d5b9..6856fe1c05e5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1530,6 +1530,10 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_co2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_ethanol_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_ethanol_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_h2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_h2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
 KernelVersion:	4.3
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 4213cdf88e3c..587233143e1e 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -82,6 +82,8 @@ enum iio_modifier {
 	IIO_MOD_I,
 	IIO_MOD_Q,
 	IIO_MOD_CO2,
+	IIO_MOD_ETHANOL,
+	IIO_MOD_H2,
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
 };
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b61245e1181d..a49fe0d181f7 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -111,6 +111,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_I] = "i",
 	[IIO_MOD_Q] = "q",
 	[IIO_MOD_CO2] = "co2",
+	[IIO_MOD_ETHANOL] = "ethanol",
+	[IIO_MOD_H2] = "h2",
 	[IIO_MOD_VOC] = "voc",
 };
 
@@ -193,6 +195,8 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_I:
 	case IIO_MOD_Q:
 	case IIO_MOD_CO2:
+	case IIO_MOD_ETHANOL:
+	case IIO_MOD_H2:
 	case IIO_MOD_VOC:
 		break;
 	default:
-- 
2.15.1
