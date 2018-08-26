Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA1AC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1CC2170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0raNGoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1CC2170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeH0A6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45111 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeH0A6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id p52-v6so9085461eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jHwPXp5PSkSOslvS+nYlBvK5CbsGpXBd/ELIWvR1eA4=;
        b=g0raNGoBbKxx32aD4zslfh8ekNiUkLu4zIPPvNDUVoPZotfv1VQYN7MIqPcBOUe9Lh
         4MzxzWRmI5r2E0R7XTTJ/kBBX0Ihg7ni1fX9LDOpqkDplNGHeI6BL3Q6rhdikCaqyMR6
         W180pTwnBX9sHFw6K2nj6XcWduAvTuXFEYCR2/WDWhSP59OjGgSpNLWHtoH28Z55XeGa
         mtWfENjNFIWJ5ZBVTaqlTo826ofbR8QD8dUjjRMvUMZ57jbZN7Ssivte2ab7gjglPXs7
         xgo3XDYVExVU7gB16td5o7PUp6g8KDFOCF/gZQIpUrqkEMsN8sVqJMMwt89wffwQ7mLF
         EzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jHwPXp5PSkSOslvS+nYlBvK5CbsGpXBd/ELIWvR1eA4=;
        b=RCxsEPhM4Dr+wvyFjrqglMt35hqtyPF8IeT8cFB67ldEGbCyIeCkReD5JMV8g5Ej2X
         S8Y3yKT3nZZ23y9hp/dvkpk8f8cOCzaxanpctcq2lTChIMUhW3Jn7aUawqqDu1gazcQh
         /0Q/UWw0xHylifuZfWFiqAGYGgLLyeG3uDSwuY+UhGpK7Rhu5bCgWoSJYU4w0Dudi2zC
         uM8z3NjJA6zsyy0mtv/HTHVFrqWpqJWE4R50hi8WH8umRaFTZ1HXyb1yB+qw3HxSTjnA
         Qq0bKsppnREtHMHYgzURn87a2Wd0iikrUjUEfSTLa7U+9wgKwhuLdgKOGEM7r8LXDbpU
         o09Q==
X-Gm-Message-State: APzg51DG6Rlk5XM00pBM7UqGcxdeKMrtJhxzEawQyaF2xi0Jc+NhNmhk
        AqTSptZWpaBsDieIqFQXdjhVD420
X-Google-Smtp-Source: ANB0VdaYBSZBWv1RSZ367lpYFJohDO1L6NFJhf1g66e9/bMbYG8j1XsFDy1mf4VCt22Fu9Cp7220+w==
X-Received: by 2002:a50:a186:: with SMTP id 6-v6mr13947704edk.12.1535318102700;
        Sun, 26 Aug 2018 14:15:02 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/21] staging:rtl8192u: Remove unused definitions - Style
Date:   Sun, 26 Aug 2018 22:14:23 +0100
Message-Id: <20180826211439.14326-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused definitions from the r8192U_hw.h header file.

These are coding style changes which should not impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_hw.h | 149 +--------------------------
 1 file changed, 1 insertion(+), 148 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 0b5fb42e5427..ddb88fa098d5 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -29,24 +29,9 @@
 #define MAX_RX_URB 16
 
 #define R8180_MAX_RETRY 255
-//#define MAX_RX_NORMAL_URB 3
-//#define MAX_RX_COMMAND_URB 2
-#define RX_URB_SIZE 9100
-
-#define BB_ANTATTEN_CHAN14	0x0c
-#define BB_ANTENNA_B 0x40
 
-#define BB_HOST_BANG		BIT(30)
-#define BB_HOST_BANG_EN		BIT(2)
-#define BB_HOST_BANG_CLK	BIT(1)
-#define BB_HOST_BANG_RW		BIT(3)
-#define BB_HOST_BANG_DATA	 1
+#define RX_URB_SIZE 9100
 
-//#if (RTL819X_FPGA_VER & RTL819X_FPGA_VIVI_070920)
-#define AFR			0x010
-#define AFR_CardBEn		BIT(0)
-#define AFR_CLKRUN_SEL		BIT(1)
-#define AFR_FuncRegEn		BIT(2)
 #define RTL8190_EEPROM_ID	0x8129
 #define EEPROM_VID		0x02
 #define EEPROM_PID		0x04
@@ -63,24 +48,14 @@
 #define EEPROM_TxPwIndex_OFDM_24G_V1	0x2C	//0x2C~0x2E
 #define EEPROM_TxPwIndex_Ver		0x27	//0x27
 
-#define EEPROM_Default_TxPowerDiff		0x0
 #define EEPROM_Default_ThermalMeter		0x7
 #define EEPROM_Default_PwDiff			0x4
 #define EEPROM_Default_CrystalCap		0x5
 #define EEPROM_Default_TxPower			0x1010
 #define EEPROM_Customer_ID			0x7B	//0x7B:CustomerID
 #define EEPROM_ChannelPlan			0x16	//0x7C
-#define EEPROM_IC_VER				0x7d	//0x7D
-#define EEPROM_CRC				0x7e	//0x7E~0x7F
 
-#define EEPROM_CID_DEFAULT			0x0
-#define EEPROM_CID_CAMEO				0x1
 #define EEPROM_CID_RUNTOP				0x2
-#define EEPROM_CID_Senao				0x3
-#define EEPROM_CID_TOSHIBA				0x4	// Toshiba setting, Merge by Jacken, 2008/01/31
-#define EEPROM_CID_NetCore				0x5
-#define EEPROM_CID_Nettronix			0x6
-#define EEPROM_CID_Pronet				0x7
 #define EEPROM_CID_DLINK				0x8
 
 #define AC_PARAM_TXOP_LIMIT_OFFSET	16
@@ -91,17 +66,13 @@
 //#endif
 enum _RTL8192Usb_HW {
 
-	PCIF			= 0x009, // PCI Function Register 0x0009h~0x000bh
 #define	BB_GLOBAL_RESET_BIT	0x1
 	BB_GLOBAL_RESET		= 0x020, // BasebandGlobal Reset Register
 	BSSIDR			= 0x02E, // BSSID Register
 	CMDR			= 0x037, // Command register
-#define CR_RST			0x10
 #define CR_RE			0x08
 #define CR_TE			0x04
-#define CR_MulRW		0x01
 	SIFS			= 0x03E, // SIFS register
-	TCR			= 0x040, // Transmit Configuration Register
 
 #define TCR_MXDMA_2048		7
 #define TCR_LRL_OFFSET		0
@@ -114,26 +85,16 @@ enum _RTL8192Usb_HW {
 			 BIT(22) | BIT(23))
 #define RX_FIFO_THRESHOLD_MASK (BIT(13) | BIT(14) | BIT(15))
 #define RX_FIFO_THRESHOLD_SHIFT 13
-#define RX_FIFO_THRESHOLD_128 3
-#define RX_FIFO_THRESHOLD_256 4
-#define RX_FIFO_THRESHOLD_512 5
-#define RX_FIFO_THRESHOLD_1024 6
 #define RX_FIFO_THRESHOLD_NONE 7
 #define MAX_RX_DMA_MASK 	(BIT(8) | BIT(9) | BIT(10))
 #define RCR_MXDMA_OFFSET	8
 #define RCR_FIFO_OFFSET		13
 #define RCR_ONLYERLPKT		BIT(31)			// Early Receiving based on Packet Size.
-#define RCR_ENCS2		BIT(30)			// Enable Carrier Sense Detection Method 2
-#define RCR_ENCS1		BIT(29)			// Enable Carrier Sense Detection Method 1
-#define RCR_ENMBID		BIT(27)			// Enable Multiple BssId.
-#define RCR_ACKTXBW		(BIT(24) | BIT(25))	// TXBW Setting of ACK frames
 #define RCR_CBSSID		BIT(23)			// Accept BSSID match packet
 #define RCR_APWRMGT		BIT(22)			// Accept power management packet
-#define	RCR_ADD3		BIT(21)			// Accept address 3 match packet
 #define RCR_AMF			BIT(20)			// Accept management type frame
 #define RCR_ACF			BIT(19)			// Accept control type frame
 #define RCR_ADF			BIT(18)			// Accept data type frame
-#define RCR_RXFTH		BIT(13)			// Rx FIFO Threshold
 #define RCR_AICV		BIT(12)			// Accept ICV error packet
 #define	RCR_ACRC32		BIT(5)			// Accept CRC32 error packet
 #define	RCR_AB			BIT(3)			// Accept broadcast packet
@@ -142,14 +103,10 @@ enum _RTL8192Usb_HW {
 #define	RCR_AAP			BIT(0)			// Accept all unicast packet
 	SLOT_TIME		= 0x049, // Slot Time Register
 	ACK_TIMEOUT		= 0x04c, // Ack Timeout Register
-	PIFS_TIME		= 0x04d, // PIFS time
-	USTIME			= 0x04e, // Microsecond Tuning Register, Sets the microsecond time unit used by MAC clock.
 	EDCAPARA_BE		= 0x050, // EDCA Parameter of AC BE
 	EDCAPARA_BK		= 0x054, // EDCA Parameter of AC BK
 	EDCAPARA_VO		= 0x058, // EDCA Parameter of AC VO
 	EDCAPARA_VI		= 0x05C, // EDCA Parameter of AC VI
-	RFPC			= 0x05F, // Rx FIFO Packet Count
-	CWRR			= 0x060, // Contention Window Report Register
 	BCN_TCFG		= 0x062, // Beacon Time Configuration
 #define BCN_TCFG_CW_SHIFT		8
 #define BCN_TCFG_IFS			0
@@ -160,7 +117,6 @@ enum _RTL8192Usb_HW {
 	BCN_ERR_THRESH		= 0x078, // Beacon Error Threshold
 	RWCAM			= 0x0A0, //IN 8190 Data Sheet is called CAMcmd
 	WCAMI			= 0x0A4, // Software write CAM input content
-	RCAMO			= 0x0A8, // Software read/write CAM config
 	SECR			= 0x0B0, //Security Configuration Register
 #define	SCR_TxUseDK		BIT(0)			//Force Tx Use Default Key
 #define SCR_RxUseDK		BIT(1)			//Force Rx Use Default Key
@@ -168,21 +124,6 @@ enum _RTL8192Usb_HW {
 #define SCR_RxDecEnable		BIT(3)			//Enable Rx Decryption
 #define SCR_SKByA2		BIT(4)			//Search kEY BY A2
 #define SCR_NoSKMC		BIT(5)			//No Key Search for Multicast
-#define SCR_UseDK		0x01
-#define SCR_TxSecEnable		0x02
-#define SCR_RxSecEnable		0x04
-	TPPoll			= 0x0fd, // Transmit priority polling register
-	PSR			= 0x0ff, // Page Select Register
-#define CPU_CCK_LOOPBACK	0x00030000
-#define CPU_GEN_SYSTEM_RESET	0x00000001
-#define CPU_GEN_FIRMWARE_RESET	0x00000008
-#define CPU_GEN_BOOT_RDY	0x00000010
-#define CPU_GEN_FIRM_RDY	0x00000020
-#define CPU_GEN_PUT_CODE_OK	0x00000080
-#define CPU_GEN_BB_RST		0x00000100
-#define CPU_GEN_PWR_STB_CPU	0x00000004
-#define CPU_GEN_NO_LOOPBACK_MSK	0xFFF8FFFF		// Set bit18,17,16 to 0. Set bit19
-#define CPU_GEN_NO_LOOPBACK_SET	0x00080000		// Set BIT19 to 1
 
 //----------------------------------------------------------------------------
 //       8190 CPU General Register		(offset 0x100, 4 byte)
@@ -198,72 +139,20 @@ enum _RTL8192Usb_HW {
 #define CPU_GEN_NO_LOOPBACK_MSK	0xFFF8FFFF // Set bit18,17,16 to 0. Set bit19
 #define CPU_GEN_NO_LOOPBACK_SET	0x00080000 // Set BIT19 to 1
 	CPU_GEN			= 0x100, // CPU Reset Register
-	LED1Cfg			=		0x154,// LED1 Configuration Register
-	LED0Cfg			=		0x155,// LED0 Configuration Register
 
-	AcmAvg			= 0x170, // ACM Average Period Register
 	AcmHwCtrl		= 0x171, // ACM Hardware Control Register
 //----------------------------------------------------------------------------
 ////
 ////       8190 AcmHwCtrl bits                                    (offset 0x171, 1 byte)
 ////----------------------------------------------------------------------------
 //
-#define AcmHw_HwEn              BIT(0)
 #define AcmHw_BeqEn             BIT(1)
-#define AcmHw_ViqEn             BIT(2)
-#define AcmHw_VoqEn             BIT(3)
-#define AcmHw_BeqStatus         BIT(4)
-#define AcmHw_ViqStatus         BIT(5)
-#define AcmHw_VoqStatus         BIT(6)
 
-	AcmFwCtrl		= 0x172, // ACM Firmware Control Register
-	AES_11N_FIX		= 0x173,
-	VOAdmTime		= 0x174, // VO Queue Admitted Time Register
-	VIAdmTime		= 0x178, // VI Queue Admitted Time Register
-	BEAdmTime		= 0x17C, // BE Queue Admitted Time Register
 	RQPN1			= 0x180, // Reserved Queue Page Number , Vo Vi, Be, Bk
 	RQPN2			= 0x184, // Reserved Queue Page Number, HCCA, Cmd, Mgnt, High
 	RQPN3			= 0x188, // Reserved Queue Page Number, Bcn, Public,
-//	QPRR			= 0x1E0, // Queue Page Report per TID
 	QPNR			= 0x1D0, //0x1F0, // Queue Packet Number report per TID
-	BQDA			= 0x200, // Beacon Queue Descriptor Address
-	HQDA			= 0x204, // High Priority Queue Descriptor Address
-	CQDA			= 0x208, // Command Queue Descriptor Address
-	MQDA			= 0x20C, // Management Queue Descriptor Address
-	HCCAQDA			= 0x210, // HCCA Queue Descriptor Address
-	VOQDA			= 0x214, // VO Queue Descriptor Address
-	VIQDA			= 0x218, // VI Queue Descriptor Address
-	BEQDA			= 0x21C, // BE Queue Descriptor Address
-	BKQDA			= 0x220, // BK Queue Descriptor Address
-	RCQDA			= 0x224, // Receive command Queue Descriptor Address
-	RDQDA			= 0x228, // Receive Queue Descriptor Start Address
-
-	MAR0			= 0x240, // Multicast filter.
-	MAR4			= 0x244,
-
-	CCX_PERIOD		= 0x250, // CCX Measurement Period Register, in unit of TU.
-	CLM_RESULT		= 0x251, // CCA Busy fraction register.
-	NHM_PERIOD		= 0x252, // NHM Measurement Period register, in unit of TU.
 
-	NHM_THRESHOLD0		= 0x253, // Noise Histogram Meashorement0.
-	NHM_THRESHOLD1		= 0x254, // Noise Histogram Meashorement1.
-	NHM_THRESHOLD2		= 0x255, // Noise Histogram Meashorement2.
-	NHM_THRESHOLD3		= 0x256, // Noise Histogram Meashorement3.
-	NHM_THRESHOLD4		= 0x257, // Noise Histogram Meashorement4.
-	NHM_THRESHOLD5		= 0x258, // Noise Histogram Meashorement5.
-	NHM_THRESHOLD6		= 0x259, // Noise Histogram Meashorement6
-
-	MCTRL			= 0x25A, // Measurement Control
-
-	NHM_RPI_COUNTER0	= 0x264, // Noise Histogram RPI counter0, the fraction of signal strength < NHM_THRESHOLD0.
-	NHM_RPI_COUNTER1	= 0x265, // Noise Histogram RPI counter1, the fraction of signal strength in (NHM_THRESHOLD0, NHM_THRESHOLD1].
-	NHM_RPI_COUNTER2	= 0x266, // Noise Histogram RPI counter2, the fraction of signal strength in (NHM_THRESHOLD1, NHM_THRESHOLD2].
-	NHM_RPI_COUNTER3	= 0x267, // Noise Histogram RPI counter3, the fraction of signal strength in (NHM_THRESHOLD2, NHM_THRESHOLD3].
-	NHM_RPI_COUNTER4	= 0x268, // Noise Histogram RPI counter4, the fraction of signal strength in (NHM_THRESHOLD3, NHM_THRESHOLD4].
-	NHM_RPI_COUNTER5	= 0x269, // Noise Histogram RPI counter5, the fraction of signal strength in (NHM_THRESHOLD4, NHM_THRESHOLD5].
-	NHM_RPI_COUNTER6	= 0x26A, // Noise Histogram RPI counter6, the fraction of signal strength in (NHM_THRESHOLD5, NHM_THRESHOLD6].
-	NHM_RPI_COUNTER7	= 0x26B, // Noise Histogram RPI counter7, the fraction of signal strength in (NHM_THRESHOLD6, NHM_THRESHOLD7].
-#define	BW_OPMODE_11J			BIT(0)
 #define	BW_OPMODE_5G			BIT(1)
 #define	BW_OPMODE_20MHZ			BIT(2)
 	BW_OPMODE		= 0x300, // Bandwidth operation mode
@@ -274,18 +163,10 @@ enum _RTL8192Usb_HW {
 #define MSR_LINK_SHIFT     0
 #define MSR_LINK_ADHOC     1
 #define MSR_LINK_MASTER    3
-#define MSR_LINK_ENEDCA	   BIT(4)
 	RETRY_LIMIT		= 0x304, // Retry Limit [15:8]-short, [7:0]-long
 #define RETRY_LIMIT_SHORT_SHIFT 8
 #define RETRY_LIMIT_LONG_SHIFT 0
-	TSFR			= 0x308,
 	RRSR			= 0x310, // Response Rate Set
-#define RRSR_RSC_OFFSET			21
-#define RRSR_SHORT_OFFSET			23
-#define RRSR_RSC_DUPLICATE			0x600000
-#define RRSR_RSC_LOWSUBCHNL		0x400000
-#define RRSR_RSC_UPSUBCHANL		0x200000
-#define RRSR_SHORT					0x800000
 #define RRSR_1M						BIT(0)
 #define RRSR_2M						BIT(1)
 #define RRSR_5_5M					BIT(2)
@@ -298,14 +179,6 @@ enum _RTL8192Usb_HW {
 #define RRSR_36M					BIT(9)
 #define RRSR_48M					BIT(10)
 #define RRSR_54M					BIT(11)
-#define RRSR_MCS0					BIT(12)
-#define RRSR_MCS1					BIT(13)
-#define RRSR_MCS2					BIT(14)
-#define RRSR_MCS3					BIT(15)
-#define RRSR_MCS4					BIT(16)
-#define RRSR_MCS5					BIT(17)
-#define RRSR_MCS6					BIT(18)
-#define RRSR_MCS7					BIT(19)
 #define BRSR_AckShortPmb			BIT(23)		// CCK ACK: use Short Preamble or not.
 	RATR0			= 0x320, // Rate Adaptive Table register1
 	UFWP			= 0x318,
@@ -354,21 +227,10 @@ enum _RTL8192Usb_HW {
 #define RATE_ALL_OFDM_2SS	RATR_MCS8|RATR_MCS9	|RATR_MCS10|RATR_MCS11| \
 							RATR_MCS12|RATR_MCS13|RATR_MCS14|RATR_MCS15
 
-	MCS_TXAGC		= 0x340, // MCS AGC
-	CCK_TXAGC		= 0x348, // CCK AGC
-//	ISR			= 0x350, // Interrupt Status Register
-//	IMR			= 0x354, // Interrupt Mask Register
-//	IMR_POLL		= 0x360,
-	MacBlkCtrl		= 0x403, // Mac block on/off control register
-
 	EPROM_CMD		= 0xfe58,
 #define Cmd9346CR_9356SEL	BIT(4)
-#define EPROM_CMD_RESERVED_MASK BIT(5)
 #define EPROM_CMD_OPERATING_MODE_SHIFT 6
-#define EPROM_CMD_OPERATING_MODE_MASK (BIT(7) | BIT(6))
-#define EPROM_CMD_CONFIG 0x3
 #define EPROM_CMD_NORMAL 0
-#define EPROM_CMD_LOAD 1
 #define EPROM_CMD_PROGRAM 2
 #define EPROM_CS_BIT BIT(3)
 #define EPROM_CK_BIT BIT(2)
@@ -376,19 +238,10 @@ enum _RTL8192Usb_HW {
 #define EPROM_R_BIT  BIT(0)
 
 	MAC0			= 0x000,
-	MAC1			= 0x001,
-	MAC2			= 0x002,
-	MAC3			= 0x003,
 	MAC4			= 0x004,
-	MAC5			= 0x005,
-
 };
 //----------------------------------------------------------------------------
 //       818xB AnaParm & AnaParm2 Register
 //----------------------------------------------------------------------------
-//#define ANAPARM_ASIC_ON    0x45090658
-//#define ANAPARM2_ASIC_ON   0x727f3f52
 #define GPI 0x108
-#define GPO 0x109
-#define GPE 0x10a
 #endif
-- 
2.18.0

