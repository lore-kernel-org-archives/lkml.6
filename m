Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbeEHMbc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:31:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36368 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbeEHMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:31:30 -0400
X-Google-Smtp-Source: AB8JxZrPX2lC2IwAdFHCJ9GpmXzrVcFAb/2/evcqvTRTAJJua02fF5w1ouS7WsHAr9vpGA4tAHTM1Q==
From: Anders Roxell <anders.roxell@linaro.org>
To: mchehab@kernel.org, hans.verkuil@cisco.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] media: usb: cx231xx-417: include linux/slab.h header
Date: Tue,  8 May 2018 14:31:21 +0200
Message-Id: <20180508123121.6280-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cx231-417 uses kmalloc/kfree functions, so slab header needs to be
included in order to fix the following build errors:
drivers/media/usb/cx231xx/cx231xx-417.c: In function ‘cx231xx_bulk_copy’:
  CC      drivers/media/platform/qcom/venus/firmware.o
drivers/media/usb/cx231xx/cx231xx-417.c:1389:11: error: implicit declaration of function ‘kmalloc’; did you mean ‘vmalloc’? [-Werror=implicit-function-declaration]
  buffer = kmalloc(buffer_size, GFP_ATOMIC);
           ^~~~~~~
           vmalloc
drivers/media/usb/cx231xx/cx231xx-417.c:1389:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  buffer = kmalloc(buffer_size, GFP_ATOMIC);
         ^
drivers/media/usb/cx231xx/cx231xx-417.c:1400:2: error: implicit declaration of function ‘kfree’; did you mean ‘vfree’? [-Werror=implicit-function-declaration]
  kfree(buffer);
  ^~~~~
  vfree
drivers/media/usb/cx231xx/cx231xx-417.c: In function ‘mpeg_open’:
drivers/media/usb/cx231xx/cx231xx-417.c:1713:7: error: implicit declaration of function ‘kzalloc’; did you mean ‘vzalloc’? [-Werror=implicit-function-declaration]
  fh = kzalloc(sizeof(*fh), GFP_KERNEL);
       ^~~~~~~
       vzalloc
drivers/media/usb/cx231xx/cx231xx-417.c:1713:5: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  fh = kzalloc(sizeof(*fh), GFP_KERNEL);
     ^

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/media/usb/cx231xx/cx231xx-417.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index b80e6857e2eb..2f3b0564d676 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <media/v4l2-common.h>
 #include <media/v4l2-ioctl.h>
-- 
2.17.0
