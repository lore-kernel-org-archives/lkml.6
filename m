Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeEVH1f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:27:35 -0400
Received: from mout.perfora.net ([74.208.4.197]:33969 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbeEVH1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:27:12 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 6/9] staging: rtl8723bs: Fix camel-case in 'struct rt_firmware'.
Date: Tue, 22 May 2018 00:26:34 -0700
Message-Id: <20180522072637.9782-6-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522072637.9782-1-quytelda@tamalin.org>
References: <20180522072637.9782-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:j9QgLcoro7AfIzsMUavb6jrPN5ncnEFEsx5geLwoyKuNUTaEZTk
 IR0Us5qqT9+7aaginaosMa75mtwkLzac1Fzl0mONRmg4j5e86tjoLsGODz4KE/zGFO2jD8Z
 9hU4l3dbL4iJYy5hPyeEE5DeBhjuYPJOe3QHHhS2OHYSUxLrN7H8L8xNwcA8Z2NLdKNyKT6
 XESMZNUWmAOqtYVcxWrWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iJivTg53RO0=:PZmq1LYhbqESZqTTmiWFUN
 Lf5LO0J7L2osOTUp+AkZm2U24DXONABzpsecOEJ8RKjPK/l6rAhRp0OgptnJjIZu9hdBAkARS
 0UDxBkoHwDTHL8yyw4/uB+untGb5wSsVow1dtRDUY55Q60QNteXNMKmAZJUiGoGsGFQRsXYal
 9TupCx0KQQXGJ0zn0Uj2zQIXfeTVXmv/kJbKOdm+IfDkA5I57zB6BeG4WgcyC+Ye4wXo5j8fQ
 3NzRgfDinue9i+F0ytOEPJBmULIYlOEXeGEqHaiEo89TtOAOC5s4E/1xbooRLE/Y/ieRYFL0U
 jWUZOqZJ8zf3HG+QDFlnJnO/VgBkTSePrgbdY778aKhsJHfj69+OdKDPTYUzfo6dTcl8hNyXl
 cXAzet8xquo0oC5t+KeXGVfymXzBt0hncdZmyMiKJKH4p+XpMRToVxESuLajYbrf7cQWtnMct
 0JTYzUIIMPNWDnWqFa+oH+g4U25B40wT1EQ2/Qm5G7hb1zRK44B/h+hFllSCxLs7RqfoKbxvM
 e/fXWz805WbHmyvyMu86A1dyv3/9/yOStLx+22o2h+9LVnOKaM9mwFMPxAq73/albvtc416jD
 DPytdEmHET+bSR66WtBrW2kMqHKYL0Rmgwa7T0wouK/4/jtwBeDVtrCyrK2S09eBxLEbQ81FS
 Nv9E2eHg7M50EKJhhbMuKfgaYpMXSdqFih0yd9UIxBl3gIaosSgFl9rEWYJuvC7eDq18=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the members of 'struct rt_firmware' to be snake case instead
of camel-case, per the kernel coding style guide.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c    | 16 ++++++++--------
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index c877408cde50..984c8b181fd4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -425,22 +425,22 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 		goto exit;
 	}
 
-	pFirmware->szFwBuffer = kmemdup(fw->data, fw->size, GFP_KERNEL);
-	if (!pFirmware->szFwBuffer) {
+	pFirmware->fw_buffer_sz = kmemdup(fw->data, fw->size, GFP_KERNEL);
+	if (!pFirmware->fw_buffer_sz) {
 		rtStatus = _FAIL;
 		goto exit;
 	}
 
-	pFirmware->ulFwLength = fw->size;
+	pFirmware->fw_length = fw->size;
 	release_firmware(fw);
-	if (pFirmware->ulFwLength > FW_8723B_SIZE) {
+	if (pFirmware->fw_length > FW_8723B_SIZE) {
 		rtStatus = _FAIL;
-		DBG_871X_LEVEL(_drv_emerg_, "Firmware size:%u exceed %u\n", pFirmware->ulFwLength, FW_8723B_SIZE);
+		DBG_871X_LEVEL(_drv_emerg_, "Firmware size:%u exceed %u\n", pFirmware->fw_length, FW_8723B_SIZE);
 		goto release_fw1;
 	}
 
-	pFirmwareBuf = pFirmware->szFwBuffer;
-	FirmwareLen = pFirmware->ulFwLength;
+	pFirmwareBuf = pFirmware->fw_buffer_sz;
+	FirmwareLen = pFirmware->fw_length;
 
 	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	pFwHdr = (struct rt_firmware_hdr *)pFirmwareBuf;
@@ -510,7 +510,7 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 	);
 
 exit:
-	kfree(pFirmware->szFwBuffer);
+	kfree(pFirmware->fw_buffer_sz);
 	kfree(pFirmware);
 release_fw1:
 	kfree(pBTFirmware);
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index b4b54e3e6a43..42f467abc6b5 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -47,8 +47,8 @@
 	((le16_to_cpu(fw_hdr->Signature) & 0xFFF0) == 0x5300)
 
 struct rt_firmware {
-	u32 ulFwLength;
-	u8 *szFwBuffer;
+	u32 fw_length;
+	u8 *fw_buffer_sz;
 };
 
 /*  This structure must be cared byte-ordering */
-- 
2.17.0
