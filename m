Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756842AbeDFO0a (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:26:30 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:56317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756438AbeDFO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:26:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: sa1100/nanoengine: fix pcmcia Makefile
Date: Fri,  6 Apr 2018 16:26:00 +0200
Message-Id: <20180406142618.2176877-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:a7ORDvx7+6HJ6P+Gxz9toaalcoWj0B5Av4zbo/rGCL3CQSE4tYi
 sORbmt3P83FkbJ4tUHabVU36UW1WbUAPDnGulqYjMcrlDALuuLBzUnvdfBjePkn18vTB6+i
 5ebB1Ga9FgZKxqMl3Gq/i/A6nmBPLpX9zO4WS9h3Jh7oNtBQeTAmbtFldsgtXqGcEje67GJ
 /nnW4kql/aeCbCsnB6Ufw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g98MqfUxv5Q=:qeCKQWiXmoRf8risVKP+dr
 ulfJN6H6p9h5WzcIusXotXJ9iBT3b7Zei19OBaJ/1sr/OtaIKDPRpbtw9NzT7oPSQRHH6iS/I
 xZLfPVozzKO8OuX7quZk0A0X974a5UuFd+ryAG49GpuklRsWIM7VDag/42HWiGT5PRnvhKjw/
 bjb+TNt6zn/WVaj00h4A8eMPThtlUQ21cq5qsGoECinpKiDFcnYzeeCIad0Hkk3aZ5e3dSN1S
 +Vr3GPfVWqZA2CiiIkCrW7rj5YbJFW2+8j+KOinNI0njUFq+pKCA2NDdnqpGIBlpFRleU2e5B
 iauBydTlUhTclx2M4oIW6MCS9RekR2oNeAm5vfsFVnQchBkHIuq/Pn1/RBF0FyyXUrLmY6Bww
 asCRnKBsrVwuPU0xwlN51F6agzS3ZOIUaEruQRhIrcE5G4adxOy6HEeKQf8QCaf4yRKCAAFY/
 qwbany0qYZ403dAYikXnacyyYtd/h2e7nq6iL0Bm27LJC0Fc3ZZ04bmEDk7VeJQF/gB/mkvI6
 WZ7CmYPmVEA0+yutbdFq6BSToYCGnCjgzVuggCDpj18NzkUdw/blcfRIuDULkLfk33r6M2Ua5
 /YzO4dO+qFS8FDiCfqJoyoeFeocM7zkXcWRPdZM2jQ/sTaKvVEa6RRmLuSSjUAUjxXYCqgzwd
 Ir/yCyc5YN6W3O8l4vB0anaqwIpR944E3hBdGITw6sQYIoJgt3vb+tYUOWaONAY1GXT8BNcuq
 FSOnHFk4ivMQjUCFLUqSPnBRJ8RgzCPEUhss+Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcmcia driver got removed, but the Makefile entry for it remained,
leading to a build failure:

make[4]: *** No rule to make target 'drivers/pcmcia/sa1100_nanoengine.o', needed by 'drivers/pcmcia/built-in.a'.

This removes the now obsolete line.

Fixes: 5662b07aac49 ("ARM: sa1100/nanoengine: convert to generic CF sockets")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pcmcia/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index a45e98540dc3..28502bd159e0 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -46,7 +46,6 @@ sa1100_cs-y					+= sa1100_generic.o
 sa1100_cs-$(CONFIG_SA1100_COLLIE)		+= pxa2xx_sharpsl.o
 sa1100_cs-$(CONFIG_SA1100_H3100)		+= sa1100_h3600.o
 sa1100_cs-$(CONFIG_SA1100_H3600)		+= sa1100_h3600.o
-sa1100_cs-$(CONFIG_SA1100_NANOENGINE)		+= sa1100_nanoengine.o
 sa1100_cs-$(CONFIG_SA1100_SIMPAD)		+= sa1100_simpad.o
 
 pxa2xx_cm_x2xx_cs-y				+= pxa2xx_cm_x2xx.o pxa2xx_cm_x255.o pxa2xx_cm_x270.o
-- 
2.9.0
