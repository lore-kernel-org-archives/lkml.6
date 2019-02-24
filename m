Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E98C00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D135F206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfBXQXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:23:16 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:59143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfBXQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 11:23:15 -0500
Received: from localhost ([2.174.161.193]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N63JO-1h4Occ0TdI-016R6o; Sun, 24 Feb 2019 17:22:42 +0100
Date:   Sun, 24 Feb 2019 17:22:36 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     afaerber@suse.de, arnd@arndb.de, davem@davemloft.net,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        jic23@kernel.org, johan@kernel.org, khilman@baylibre.com,
        knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh+dt@kernel.org, robh@kernel.org,
        songqiang1304521@gmail.com, treding@nvidia.com
Subject: [PATCH 2/4] iio/proximity: add mb12x2 driver to Kconfig and Makefile
Message-ID: <20190224162235.7kidyum2dwg5bua5@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:E7kcApNw4Eh13VjApBByHDs1XwRPO1F7KNFpJvv+fMgVkEs/YPE
 Kn+aQhDJSjEe3TJEK8CfNZsMvBrJge/G9OdYm8B+YPOGU8Xg2XC+Tb6bH8xwlT0QDGQC8xv
 QoJrqLWjDuIqbmLQE+Q8JYOcKuHKsimb5YQhbdfed41KLDuZ6EV1xScPhNdJaCDJ3AGXK7c
 +Iv7NTqqOqLDPEpFruP+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zM4P4lWYHOo=:fnNUriC1ASnbO5iN7dRAN+
 kVol5z/z+GR/wV9gAfnqeHb6hRcm/dNyHhQU+wzzLG2o5uFwsoV7D4EXOIWVNxkYecLF3dag+
 NLAEcBxOjAh/tt2DO4HZwwxETTdKX2zJ4ehNIqI8iSDGWZOK2D4jgGoil3B5ixGh8bixxfZwb
 NiyZ+/kMKqZ4Dosnd1kX0DuPfK6YZ6ehFbvZ2km62yJ7GN+Myy5nFwPIC8lwfghQz4LCaHKHM
 hOrKw9p9gv0gEBlY2kpUfs1V2S8HyxEoOhVtcgoMyQd0wV1y0Gy7wCTaTdLZ/nByWdJNM3K85
 VNJsGZhw8Oq1E/OG6bpqi18qyNWy7O1006bOlxQq0+0WRJvluzMNlmxlRu6ffl+eisoBJZ4G5
 FyVqTiFd621YCrO9zcxYN9PPaBR0Qghbl2BT4k5S+2EaMGnuTPS48SsfPJ/21jPNmLKi35Adu
 NSbcQAO6C/QEskK4+AU3gTBdJ5p3xNqpltMI8D3HUJpjMfdrmIa5UtuPADBFCjblzrsYkVDBp
 +xdeLZxvCY2uwMok4My6Y38nneGjI+cEek7JnfcEtjsbEbEfXhTJn7BBu3sJQCj4j4QnpaKt3
 oXn3osmhWGqeuRbbJO/Lohq5M1iXkEfaeb6CLxu4neWggrp3ZpaWKi96kUYGFf9g/C4Y1jMeI
 /q/qXKQA1yfzG2WACEKSHRgSxIy24qqZttdXTVTy8THxddwnu+vm1rvx7L2PvBXYYcVI+4iGY
 fX578EuCxVHqhB5oKVvs7/AxfJuYJCYiGEzYpw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makefile and Kconfig: add configuration for mb12x2 ultrasonic proximity
driver

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/Kconfig  | 11 +++++++++++
 drivers/iio/proximity/Makefile |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index b99367a89f81..5d57ca44e30d 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -45,6 +45,17 @@ config LIDAR_LITE_V2
 	  To compile this driver as a module, choose M here: the
 	  module will be called pulsedlight-lite-v2
 
+config MB12X2
+	tristate "MaxSonar MB12X2 family ultrasonic sensors"
+	depends on I2C
+	help
+	  Say Y to build a driver for the ultrasonic sensors of MaxSonar
+	  with i2c interface. It can be used to measure the distance of
+	  objects.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mb12x2.
+
 config RFD77402
 	tristate "RFD77402 ToF sensor"
 	depends on I2C
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 6d031f903c4c..c56b72a8be87 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AS3935)		+= as3935.o
 obj-$(CONFIG_ISL29501)		+= isl29501.o
+obj-$(CONFIG_MB12X2)		+= mb12x2.o
 obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
 obj-$(CONFIG_RFD77402)		+= rfd77402.o
 obj-$(CONFIG_SRF04)		+= srf04.o
-- 
2.11.0
