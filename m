Return-Path: <clabbe@baylibre.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519287572; cv=none;
        d=google.com; s=arc-20160816;
        b=YOhv0OO1IfI9WMo5WrfY5msREMdrGngjhtM4pxhGpMw2XV03IiDMB/Pjdn/gIYexID
         zjojGxbglnwdCfbBDulh8DVxQ6trQwfN4IJTGYHyPm52LyD6/e6ThU0IJDVbY9JXDPwU
         QmjIN+yHQhtw2O12Aqz5yGjowoxenbFZXWyybF+ipd0fCtlY+zmuHplgjL36ragRfN8C
         7f/1rvaSDMUVdLDJGUt4JaTtGtyMYkP6UbN/SE/XeT7f5Ij+U2IXQSa4uE/5ht0D9XQI
         xc1yk4h4bx1PcVLpmYmhWW0sAxnmWNIb7uvpXAHHe60VAnF/GdNHNUjgmAZbz0WhlPjP
         9VFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=tQMR2CuQ2B4vVkE68zzbCpDRmLF5Nm8pq41ugb/Bjtg=;
        b=w5vcJrJMC8Hy8/28xNG+C2ehvKc0WJFMsgbKGCvt+rwMitAy+5OYiP5rKYQ8M8QW5R
         d4S0SPH4rXl1OVn5ZFkvCNAqIQps8+RaBgqNTeS5hnl1RTkeeST+nibavsSV0gMqS6zf
         lEOIIZLz1yk3ZvPBw48NhyBGOBxkbgImCcO0u56+cOnnT8YWncraMtgvyWvwxHyRbUry
         dcdHXgkBqkAIOSVwI8eqkrIceRbRQKXIS/OfJnugif0WBrX/jZMGbguWGJuX94GeIIYe
         LpXAt7TzMTSeO3q2Zsv+H0TlJD6UI5Uk9K/fynrQWbGHscb3oAps8BXFwa2y1o5cD+dR
         VAgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=ZuGtYpSm;
       spf=softfail (google.com: domain of transitioning clabbe@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=clabbe@baylibre.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=ZuGtYpSm;
       spf=softfail (google.com: domain of transitioning clabbe@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=clabbe@baylibre.com
X-Google-Smtp-Source: AH8x227b7ZnEf+wQC9aZ02FoQR7qFRAZUAEsA8BtRq47gDSCJSB0TtUZGkyVrZuhV2aN1SrxZNBYow==
From: Corentin Labbe <clabbe@baylibre.com>
To: gregkh@linuxfoundation.org,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] staging: media: atomisp: Remove inclusion of non-existing directories
Date: Thu, 22 Feb 2018 08:19:25 +0000
Message-Id: <1519287565-28485-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593088485992638899?=
X-GMAIL-MSGID: =?utf-8?q?1593088485992638899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fix the following build warnings:
  CC [M]  drivers/staging/media/atomisp/pci/atomisp2/atomisp_drvfs.o
cc1: warning: drivers/staging/media/atomisp/pci/atomisp2/css2400/isp/kernels/bayer_ls/bayer_ls_1.0/: No such file or directory [-Wmissing-include-dirs]
cc1: warning: drivers/staging/media/atomisp/pci/atomisp2/css2400/isp/kernels/io_ls/plane_io_ls/: No such file or directory [-Wmissing-include-dirs]
cc1: warning: drivers/staging/media/atomisp/pci/atomisp2/css2400/isp/kernels/io_ls/yuv420_io_ls/: No such file or directory [-Wmissing-include-dirs]
cc1: warning: drivers/staging/media/atomisp/pci/atomisp2/css2400/isp/kernels/ipu2_io_ls/plane_io_ls/: No such file or directory [-Wmissing-include-dirs]
cc1: warning: drivers/staging/media/atomisp/pci/atomisp2/css2400/isp/kernels/ipu2_io_ls/yuv420_io_ls/: No such file or directory [-Wmissing-include-dirs]
cc1: warning: drivers/staging/media/atomisp/pci/atomisp2/css2400/isp/kernels/s3a_stat_ls/: No such file or directory [-Wmissing-include-dirs]
cc1: warning: drivers/staging/media/atomisp/pci/atomisp2/css2400/isp/kernels/scale/: No such file or directory [-Wmissing-include-dirs]
cc1: warning: drivers/staging/media/atomisp/pci/atomisp2/css2400/isp/kernels/scale/scale_1.0/: No such file or directory [-Wmissing-include-dirs]
cc1: warning: drivers/staging/media/atomisp/pci/atomisp2/css2400/isp/kernels/yuv_ls: No such file or directory [-Wmissing-include-dirs]
cc1: warning: drivers/staging/media/atomisp/pci/atomisp2/css2400/isp/kernels/yuv_ls/yuv_ls_1.0/: No such file or directory [-Wmissing-include-dirs]
by removing the inclusion of such directories

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/atomisp/pci/atomisp2/Makefile | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/Makefile b/drivers/staging/media/atomisp/pci/atomisp2/Makefile
index ac3805345f20..83f816faba1b 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/Makefile
+++ b/drivers/staging/media/atomisp/pci/atomisp2/Makefile
@@ -215,7 +215,6 @@ INCLUDES += \
 	-I$(atomisp)/css2400/isp/kernels/aa/aa_2/ \
 	-I$(atomisp)/css2400/isp/kernels/anr/anr_1.0/ \
 	-I$(atomisp)/css2400/isp/kernels/anr/anr_2/ \
-	-I$(atomisp)/css2400/isp/kernels/bayer_ls/bayer_ls_1.0/ \
 	-I$(atomisp)/css2400/isp/kernels/bh/bh_2/ \
 	-I$(atomisp)/css2400/isp/kernels/bnlm/ \
 	-I$(atomisp)/css2400/isp/kernels/bnr/ \
@@ -258,14 +257,10 @@ INCLUDES += \
 	-I$(atomisp)/css2400/isp/kernels/io_ls/ \
 	-I$(atomisp)/css2400/isp/kernels/io_ls/bayer_io_ls/ \
 	-I$(atomisp)/css2400/isp/kernels/io_ls/common/ \
-	-I$(atomisp)/css2400/isp/kernels/io_ls/plane_io_ls/ \
-	-I$(atomisp)/css2400/isp/kernels/io_ls/yuv420_io_ls/ \
 	-I$(atomisp)/css2400/isp/kernels/io_ls/yuv444_io_ls/ \
 	-I$(atomisp)/css2400/isp/kernels/ipu2_io_ls/ \
 	-I$(atomisp)/css2400/isp/kernels/ipu2_io_ls/bayer_io_ls/ \
 	-I$(atomisp)/css2400/isp/kernels/ipu2_io_ls/common/ \
-	-I$(atomisp)/css2400/isp/kernels/ipu2_io_ls/plane_io_ls/ \
-	-I$(atomisp)/css2400/isp/kernels/ipu2_io_ls/yuv420_io_ls/ \
 	-I$(atomisp)/css2400/isp/kernels/ipu2_io_ls/yuv444_io_ls/ \
 	-I$(atomisp)/css2400/isp/kernels/iterator/ \
 	-I$(atomisp)/css2400/isp/kernels/iterator/iterator_1.0/ \
@@ -289,9 +284,6 @@ INCLUDES += \
 	-I$(atomisp)/css2400/isp/kernels/ref/ref_1.0/ \
 	-I$(atomisp)/css2400/isp/kernels/s3a/ \
 	-I$(atomisp)/css2400/isp/kernels/s3a/s3a_1.0/ \
-	-I$(atomisp)/css2400/isp/kernels/s3a_stat_ls/ \
-	-I$(atomisp)/css2400/isp/kernels/scale/ \
-	-I$(atomisp)/css2400/isp/kernels/scale/scale_1.0/ \
 	-I$(atomisp)/css2400/isp/kernels/sc/ \
 	-I$(atomisp)/css2400/isp/kernels/sc/sc_1.0/ \
 	-I$(atomisp)/css2400/isp/kernels/sdis/ \
@@ -315,8 +307,6 @@ INCLUDES += \
 	-I$(atomisp)/css2400/isp/kernels/ynr/ \
 	-I$(atomisp)/css2400/isp/kernels/ynr/ynr_1.0/ \
 	-I$(atomisp)/css2400/isp/kernels/ynr/ynr_2/ \
-	-I$(atomisp)/css2400/isp/kernels/yuv_ls \
-	-I$(atomisp)/css2400/isp/kernels/yuv_ls/yuv_ls_1.0/ \
 	-I$(atomisp)/css2400/isp/modes/interface/ \
 	-I$(atomisp)/css2400/runtime/binary/interface/ \
 	-I$(atomisp)/css2400/runtime/bufq/interface/ \
-- 
2.16.1
