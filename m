Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032922AbeBONuk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:50:40 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:37367 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032842AbeBONui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:50:38 -0500
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        it+linux-input@molgen.mpg.de
From: Paul Menzel <pmenzel+linux-input@molgen.mpg.de>
Subject: [PATCH] input/mouse/synaptics: Add SYN1217 to PNP detection list
Message-ID: <a157ea03-b7ca-9a20-308d-70b0504d0c83@molgen.mpg.de>
Date: Thu, 15 Feb 2018 14:50:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Wed, 14 Feb 2018 18:16:43 +0100

On the TUXEDO Book BU1406, since Linux 4.12, the Linux kernel logs the 
message
below.

```
kernel: psmouse serio1: synaptics: Your touchpad (PNP: SYN1217 PNP0f13) 
says it can support a different bus. If i2c-hid and hid-rmi are not 
used, you might want to try setting psmouse.synaptics_intertouch to 1 
and report this to linux-input@vger.kernel.org.
```

Booting with `psmouse.synaptics_intertouch=1`, the touchpad continues to
work, so add the ID of the device to the list of IDs, whose devices
support I2C mode.

CC: stable@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
  drivers/input/mouse/synaptics.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c 
b/drivers/input/mouse/synaptics.c
index 3d2e23a0ae39..80ddbb966d83 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -178,6 +178,7 @@ static const char * const smbus_pnp_ids[] = {
  };

  static const char * const forcepad_pnp_ids[] = {
+	"SYN1217",
  	"SYN300D",
  	"SYN3014",
  	NULL
-- 
2.14.1
