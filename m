Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeEVHc1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:32:27 -0400
Received: from mout.perfora.net ([74.208.4.196]:34957 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbeEVHcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:32:18 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 8/9] staging: rtl8723bs: Fix camel-case in 'struct rt_firmware_hdr'.
Date: Tue, 22 May 2018 00:26:36 -0700
Message-Id: <20180522072637.9782-8-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522072637.9782-1-quytelda@tamalin.org>
References: <20180522072637.9782-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:PNbeP91H3WsNFQVOGBaFB4ijKeSoJUqTJBI6ojXbAeaFpEKzne+
 +v69n6QeVz+E2kPQAx5+Z159F3m3Uu/JuRorukTCq3422ppKNyNIT4VIDWU0t0+C2w/Oka7
 9Ddy+BySMEEeF4uvTg10i2CLl1Kk6l/lNpnRfxs079Xhmh7ReQqjugl9jkbuowunFV/gfj8
 Vk1HoEVa6FspfjchDcgkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QGXPNsLT68Y=:679GigwnTgINaT8xdjRrcR
 Rix0Rm+j5cn2WMjx2gcrLP0C6CvktJU+h0RsiJr8CbJhWrKxLSCoRI3ekGSD4u7FXB6dt7iCS
 8OnFBr0NbPZYDcf45O7SdORy9DXPFLQpFYk4DbVg1CFVYdVIrOdXY8HPm5G4TfFg83/8sDtiX
 55VIiQ+LtMgspsWYz5XvkNuSMsle0ehm258yFpxneR2RrduCUkZdw1O7U4PqtzgVgdRw/dx+x
 Nt9p24IudpB1mbYRY0vwbUJJYgZ9N9ss+Na07hvJTpprdvAde9gFhN+CzJCjhbJx8ZBJrRHr5
 fzlHh1y2cqMYvfCECHhYrVbFTdZOZWmeZAnpPsDOrSoOZjWX1nMGers+5vJlcD1AHcmqs0n9b
 sjpWMofdevjf8CQL4DwE6PL+9goqKtYeAlKi0K1ulD4a66Cjh30iFETMEkUY1HbOcj3mLfjuj
 F4cEQbXlCc6O1mB3zYGpr+AwH+jantHQ2fQQrOA1/njPqz6P/k/8PL82pERvdZf+poAkZew4D
 ufidsF5dHLjTY6xTzHul2Lt3Np8w8ni7wcPpEkJIHxJaWbDsJvfyqFAwaSGTgkNOhx3XHJeOK
 DQWZwG1Y3gbTcGSqEGsXpz3dTqWh345iJ/9sfzkDQKpmehtlnGBQChfHHIKu0UiARp+CYorCj
 5QL+KXlEiGt3vZ9jSUz9AItwCCHHQRGwjFOGxNPrh1t1LdLPS/TUhLrTdpV55DcnWmkY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camel-case member names with snake-case names per the linux
kernel coding style guidelines.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 14 ++++----
 .../staging/rtl8723bs/include/rtl8723b_hal.h  | 32 +++++++++----------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 984c8b181fd4..592917fc00aa 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -445,9 +445,9 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	pFwHdr = (struct rt_firmware_hdr *)pFirmwareBuf;
 
-	pHalData->FirmwareVersion =  le16_to_cpu(pFwHdr->Version);
-	pHalData->FirmwareSubVersion = le16_to_cpu(pFwHdr->Subversion);
-	pHalData->FirmwareSignature = le16_to_cpu(pFwHdr->Signature);
+	pHalData->FirmwareVersion =  le16_to_cpu(pFwHdr->version);
+	pHalData->FirmwareSubVersion = le16_to_cpu(pFwHdr->subversion);
+	pHalData->FirmwareSignature = le16_to_cpu(pFwHdr->signature);
 
 	DBG_871X(
 		"%s: fw_ver =%x fw_subver =%04x sig = 0x%x, Month =%02x, Date =%02x, Hour =%02x, Minute =%02x\n",
@@ -455,10 +455,10 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 		pHalData->FirmwareVersion,
 		pHalData->FirmwareSubVersion,
 		pHalData->FirmwareSignature,
-		pFwHdr->Month,
-		pFwHdr->Date,
-		pFwHdr->Hour,
-		pFwHdr->Minute
+		pFwHdr->month,
+		pFwHdr->date,
+		pFwHdr->hour,
+		pFwHdr->minute
 	);
 
 	if (IS_FW_HEADER_EXIST_8723B(pFwHdr)) {
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index 8897deb963c7..946236f704fe 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -44,7 +44,7 @@
 #define FW_8723B_END_ADDRESS   0x1FFF /* 0x5FFF */
 
 #define IS_FW_HEADER_EXIST_8723B(fw_hdr) \
-	((le16_to_cpu(fw_hdr->Signature) & 0xFFF0) == 0x5300)
+	((le16_to_cpu(fw_hdr->signature) & 0xFFF0) == 0x5300)
 
 struct rt_firmware {
 	u32 fw_length;
@@ -56,31 +56,31 @@ struct rt_firmware_hdr {
 	/*  8-byte alinment required */
 
 	/*  LONG WORD 0 ---- */
-	__le16 Signature;  /* 92C0: test chip; 92C, 88C0: test chip;
+	__le16 signature;  /* 92C0: test chip; 92C, 88C0: test chip;
 			    * 88C1: MP A-cut; 92C1: MP A-cut */
-	u8 Category;	   /* AP/NIC and USB/PCI */
-	u8 Function;	   /* Reserved for different FW function indications,
+	u8 category;	   /* AP/NIC and USB/PCI */
+	u8 function;	   /* Reserved for different FW function indications,
 			    * for further use when driver needs to download
 			    * different FW in different conditions. */
-	__le16 Version;    /* FW Version */
-	__le16 Subversion; /* FW Subversion, default 0x00 */
+	__le16 version;    /* FW Version */
+	__le16 subversion; /* FW Subversion, default 0x00 */
 
 	/*  LONG WORD 1 ---- */
-	u8 Month;  /* Release time Month field */
-	u8 Date;   /* Release time Date field */
-	u8 Hour;   /* Release time Hour field */
-	u8 Minute; /* Release time Minute field */
+	u8 month;  /* Release time Month field */
+	u8 date;   /* Release time Date field */
+	u8 hour;   /* Release time Hour field */
+	u8 minute; /* Release time Minute field */
 
-	__le16 RamCodeSize; /* The size of RAM code */
-	__le16 Rsvd2;
+	__le16 ram_code_size; /* The size of RAM code */
+	__le16 rsvd2;
 
 	/*  LONG WORD 2 ---- */
-	__le32 SvnIdx;	/* The SVN entry index */
-	__le32 Rsvd3;
+	__le32 svn_idx;	/* The SVN entry index */
+	__le32 rsvd3;
 
 	/*  LONG WORD 3 ---- */
-	__le32 Rsvd4;
-	__le32 Rsvd5;
+	__le32 rsvd4;
+	__le32 rsvd5;
 };
 
 #define DRIVER_EARLY_INT_TIME_8723B  0x05
-- 
2.17.0
