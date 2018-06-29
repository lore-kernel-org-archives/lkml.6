Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF6FC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BA827A62
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP/L7FgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BA827A62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965208AbeF2SLG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:11:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54008 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964881AbeF2SLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:11:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so3079784wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RkuWZZv0RcKDcr3vc9tn3cPCnzANQBT+vn5buo5Ni2M=;
        b=WP/L7FgYXGZic0PTT6+MjOxrr22q5F9q3I59S3HL6atqSRYyERaWMRRIWyCjniunIS
         BYR1+YC/OevSgJmbGFEprG6+p8ozOu0XAQ5RLD7QWg9+XDbCR32amj6pNdKXm4UjHubx
         Pv/H1XUDU9YiX0fh3lydH4ADKuNIM09XPq1kX/EyssDB5YzItOhyiAzKQEsJt6BWSbHL
         tIUGPzPrza5ZqIRDRQw9ktWkGNNU01HXfRHY2yX7j8auKniZbVkBLpD6Qe9UgXnBCrEz
         oeVBJYAuFVMJVLk8uwK2/eshogkEfXt0SnUM4/NRWHmIIhLOaI1djcaSd/vbMEpZSvLB
         5G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RkuWZZv0RcKDcr3vc9tn3cPCnzANQBT+vn5buo5Ni2M=;
        b=pUbU0nxqeNEt3yPxfP9DYQ6JCFNbH6ir4qlfrKgMkBnyDuTGC6jOoA0QolSyThYSal
         WnPAU5TXjxYWEfFbehTf5jFvu3ihZgIpdhCYxKqwfQzoCLHu/8K3qKo8XqkZAt9LBMKr
         P8vwB1YhUiIURJYl/vlsLnhSrWRIvXwCNi3P/LULAUFCOlKhJjkaraJKDxAt4qVjts6l
         pUs1m8e18C8YR4jociY6ijO5DTM1N24LL6kT7MsmvbhiKATlPo6FRsPgWqKsa+uoSp9i
         2bAglK56vJnMyFaQ66hyA+H5Nj+bkysNMJCDanfcax6XdN6Ni698U611LixgEEyCf8e/
         5DuA==
X-Gm-Message-State: APt69E30X4NZ3+znApr1UzyPvchYUuZS3ivtEPXqJQDWxicLRlE3qCdl
        aoNJj9gydcHAzGY1DQCMM1o=
X-Google-Smtp-Source: AAOMgpe4z9dEM7xGbqsUO1CMimxjxZ5vDAb4EMByPUWmblO41KqgPrfdrM2QnFs8GTMJBp6IaV1O+g==
X-Received: by 2002:a1c:7f95:: with SMTP id a143-v6mr2391042wmd.108.1530295859542;
        Fri, 29 Jun 2018 11:10:59 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id t10-v6sm11071491wrq.74.2018.06.29.11.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 11:10:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 3/3] staging: rtl8192u: Prune the rtl819x_HT.h file of unused definitions.
Date:   Fri, 29 Jun 2018 19:10:07 +0100
Message-Id: <20180629181007.18071-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629181007.18071-1-johnfwhitmore@gmail.com>
References: <20180629181007.18071-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two files named "rtl819x_HT.h"

$ find . -name rtl819x_HT.h -print
./drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
./drivers/staging/rtl8192e/rtl819x_HT.h

The two files are very similar but differ slightly. Unsed definitions have
been removed from "drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h" as a first
step towards possibly merging the two files into one.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   | 190 +++++++++---------
 1 file changed, 93 insertions(+), 97 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index a85036022aa8..30a00c73dd06 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -10,17 +10,17 @@
 //
 // Operation mode value
 //
-#define HT_OPMODE_NO_PROTECT		0
-#define HT_OPMODE_OPTIONAL		1
-#define HT_OPMODE_40MHZ_PROTECT	2
-#define HT_OPMODE_MIXED			3
+//#define HT_OPMODE_NO_PROTECT		0
+//#define HT_OPMODE_OPTIONAL		1
+//#define HT_OPMODE_40MHZ_PROTECT	2
+//#define HT_OPMODE_MIXED			3
 
 //
 // MIMO Power Save Settings
 //
 #define MIMO_PS_STATIC				0
-#define MIMO_PS_DYNAMIC			1
-#define MIMO_PS_NOLIMIT			3
+//#define MIMO_PS_DYNAMIC			1
+//#define MIMO_PS_NOLIMIT			3
 
 
 //
@@ -35,26 +35,25 @@
 #define HT_SUPPORTED_MCS_2SS_BITMAP					0x0000ff00
 #define HT_SUPPORTED_MCS_1SS_2SS_BITMAP			HT_MCS_1SS_BITMAP|HT_MCS_1SS_2SS_BITMAP
 
-
-typedef enum _HT_MCS_RATE {
-	HT_MCS0   = 0x00000001,
-	HT_MCS1   = 0x00000002,
-	HT_MCS2   = 0x00000004,
-	HT_MCS3   = 0x00000008,
-	HT_MCS4   = 0x00000010,
-	HT_MCS5   = 0x00000020,
-	HT_MCS6   = 0x00000040,
-	HT_MCS7   = 0x00000080,
-	HT_MCS8   = 0x00000100,
-	HT_MCS9   = 0x00000200,
-	HT_MCS10 = 0x00000400,
-	HT_MCS11 = 0x00000800,
-	HT_MCS12 = 0x00001000,
-	HT_MCS13 = 0x00002000,
-	HT_MCS14 = 0x00004000,
-	HT_MCS15 = 0x00008000,
-	// Do not define MCS32 here although 8190 support MCS32
-} HT_MCS_RATE, *PHT_MCS_RATE;
+//typedef enum _HT_MCS_RATE {
+//	HT_MCS0   = 0x00000001,
+//	HT_MCS1   = 0x00000002,
+//	HT_MCS2   = 0x00000004,
+//	HT_MCS3   = 0x00000008,
+//	HT_MCS4   = 0x00000010,
+//	HT_MCS5   = 0x00000020,
+//	HT_MCS6   = 0x00000040,
+//	HT_MCS7   = 0x00000080,
+//	HT_MCS8   = 0x00000100,
+//	HT_MCS9   = 0x00000200,
+//	HT_MCS10 = 0x00000400,
+//	HT_MCS11 = 0x00000800,
+//	HT_MCS12 = 0x00001000,
+//	HT_MCS13 = 0x00002000,
+//	HT_MCS14 = 0x00004000,
+//	HT_MCS15 = 0x00008000,
+//	// Do not define MCS32 here although 8190 support MCS32
+//} HT_MCS_RATE, *PHT_MCS_RATE;
 
 //
 // Represent Channel Width in HT Capabilities
@@ -120,27 +119,26 @@ typedef	union _HT_CAPABILITY_MACPARA{
 }HT_CAPABILITY_MACPARA, *PHT_CAPABILITY_MACPARA;
 */
 
-typedef enum _HT_ACTION {
-	ACT_RECOMMAND_WIDTH		= 0,
-	ACT_MIMO_PWR_SAVE		= 1,
-	ACT_PSMP					= 2,
-	ACT_SET_PCO_PHASE		= 3,
-	ACT_MIMO_CHL_MEASURE	= 4,
-	ACT_RECIPROCITY_CORRECT	= 5,
-	ACT_MIMO_CSI_MATRICS		= 6,
-	ACT_MIMO_NOCOMPR_STEER	= 7,
-	ACT_MIMO_COMPR_STEER		= 8,
-	ACT_ANTENNA_SELECT		= 9,
-} HT_ACTION, *PHT_ACTION;
-
+//typedef enum _HT_ACTION {
+//	ACT_RECOMMAND_WIDTH		= 0,
+//	ACT_MIMO_PWR_SAVE		= 1,
+//	ACT_PSMP					= 2,
+//	ACT_SET_PCO_PHASE		= 3,
+//	ACT_MIMO_CHL_MEASURE	= 4,
+//	ACT_RECIPROCITY_CORRECT	= 5,
+//	ACT_MIMO_CSI_MATRICS		= 6,
+//	ACT_MIMO_NOCOMPR_STEER	= 7,
+//	ACT_MIMO_COMPR_STEER		= 8,
+//	ACT_ANTENNA_SELECT		= 9,
+//} HT_ACTION, *PHT_ACTION;
 
 /* 2007/06/07 MH Define sub-carrier mode for 40MHZ. */
-typedef enum _HT_Bandwidth_40MHZ_Sub_Carrier {
-	SC_MODE_DUPLICATE = 0,
-	SC_MODE_LOWER = 1,
-	SC_MODE_UPPER = 2,
-	SC_MODE_FULL40MHZ = 3,
-}HT_BW40_SC_E;
+//typedef enum _HT_Bandwidth_40MHZ_Sub_Carrier {
+//	SC_MODE_DUPLICATE = 0,
+//	SC_MODE_LOWER = 1,
+//	SC_MODE_UPPER = 2,
+//	SC_MODE_FULL40MHZ = 3,
+//}HT_BW40_SC_E;
 
 typedef	struct _HT_CAPABILITY_ELE {
 
@@ -216,11 +214,11 @@ typedef struct _HT_INFORMATION_ELE {
 // MIMO Power Save control field.
 // This is appear in MIMO Power Save Action Frame
 //
-typedef struct _MIMOPS_CTRL {
-	u8	MimoPsEnable:1;
-	u8	MimoPsMode:1;
-	u8	Reserved:6;
-} MIMOPS_CTRL, *PMIMOPS_CTRL;
+//typedef struct _MIMOPS_CTRL {
+//	u8	MimoPsEnable:1;
+//	u8	MimoPsMode:1;
+//	u8	Reserved:6;
+//} MIMOPS_CTRL, *PMIMOPS_CTRL;
 
 typedef enum _HT_SPEC_VER {
 	HT_SPEC_VER_IEEE = 0,
@@ -348,26 +346,26 @@ typedef struct _RT_HIGH_THROUGHPUT {
 // when card is configured as "AP mode"
 //------------------------------------------------------------
 
-typedef struct _RT_HTINFO_STA_ENTRY {
-	u8			bEnableHT;
-
-	u8			bSupportCck;
-
-	u16			AMSDU_MaxSize;
-
-	u8			AMPDU_Factor;
-	u8			MPDU_Density;
-
-	u8			HTHighestOperaRate;
-
-	u8			bBw40MHz;
-
-	u8			MimoPs;
-
-	u8			McsRateSet[16];
-
-
-}RT_HTINFO_STA_ENTRY, *PRT_HTINFO_STA_ENTRY;
+//typedef struct _RT_HTINFO_STA_ENTRY {
+//	u8			bEnableHT;
+//
+//	u8			bSupportCck;
+//
+//	u16			AMSDU_MaxSize;
+//
+//	u8			AMPDU_Factor;
+//	u8			MPDU_Density;
+//
+//	u8			HTHighestOperaRate;
+//
+//	u8			bBw40MHz;
+//
+//	u8			MimoPs;
+//
+//	u8			McsRateSet[16];
+//
+//
+//}RT_HTINFO_STA_ENTRY, *PRT_HTINFO_STA_ENTRY;
 
 
 
@@ -396,26 +394,26 @@ typedef struct _BSS_HT {
 	u8					bdRT2RTLongSlotTime;
 } __attribute__ ((packed)) BSS_HT, *PBSS_HT;
 
-typedef struct _MIMO_RSSI {
-	u32	EnableAntenna;
-	u32	AntennaA;
-	u32	AntennaB;
-	u32	AntennaC;
-	u32	AntennaD;
-	u32	Average;
-}MIMO_RSSI, *PMIMO_RSSI;
+//typedef struct _MIMO_RSSI {
+//	u32	EnableAntenna;
+//	u32	AntennaA;
+//	u32	AntennaB;
+//	u32	AntennaC;
+//	u32	AntennaD;
+//	u32	Average;
+//}MIMO_RSSI, *PMIMO_RSSI;
 
-typedef struct _MIMO_EVM {
-	u32	EVM1;
-	u32    EVM2;
-}MIMO_EVM, *PMIMO_EVM;
+//typedef struct _MIMO_EVM {
+//	u32	EVM1;
+//	u32    EVM2;
+//}MIMO_EVM, *PMIMO_EVM;
 
-typedef struct _FALSE_ALARM_STATISTICS {
-	u32	Cnt_Parity_Fail;
-	u32    Cnt_Rate_Illegal;
-	u32	Cnt_Crc8_fail;
-	u32	Cnt_all;
-}FALSE_ALARM_STATISTICS, *PFALSE_ALARM_STATISTICS;
+//typedef struct _FALSE_ALARM_STATISTICS {
+//	u32	Cnt_Parity_Fail;
+//	u32    Cnt_Rate_Illegal;
+//	u32	Cnt_Crc8_fail;
+//	u32	Cnt_all;
+//}FALSE_ALARM_STATISTICS, *PFALSE_ALARM_STATISTICS;
 
 
 extern u8 MCS_FILTER_ALL[16];
@@ -424,16 +422,14 @@ extern u8 MCS_FILTER_1SS[16];
 /* 2007/07/11 MH Modify the macro. Becaus STA may link with a N-AP. If we set
    STA in A/B/G mode and AP is still in N mode. The macro will be wrong. We have
    to add a macro to judge wireless mode. */
-#define PICK_RATE(_nLegacyRate, _nMcsRate)	\
-		(_nMcsRate==0)?(_nLegacyRate&0x7f):(_nMcsRate)
+#define PICK_RATE(_nLegacyRate, _nMcsRate)     \
+               (_nMcsRate==0)?(_nLegacyRate&0x7f):(_nMcsRate)
 /* 2007/07/12 MH We only define legacy and HT wireless mode now. */
 #define	LEGACY_WIRELESS_MODE	IEEE_MODE_MASK
-
-#define CURRENT_RATE(WirelessMode, LegacyRate, HTRate)	\
-					((WirelessMode & (LEGACY_WIRELESS_MODE))!=0)?\
-						(LegacyRate):\
-						(PICK_RATE(LegacyRate, HTRate))
-
+#define CURRENT_RATE(WirelessMode, LegacyRate, HTRate)		\
+					((WirelessMode & (LEGACY_WIRELESS_MODE))!=0)? \
+					(LegacyRate):			\
+					(PICK_RATE(LegacyRate, HTRate))
 
 
 // MCS Bw 40 {1~7, 12~15,32}
@@ -441,7 +437,7 @@ extern u8 MCS_FILTER_1SS[16];
 #define	RATE_ADPT_2SS_MASK		0xF0 //Skip MCS8~11 because mcs7 > mcs6, 9, 10, 11. 2007.01.16 by Emily
 #define	RATE_ADPT_MCS32_MASK		0x01
 
-#define		IS_11N_MCS_RATE(rate)		(rate&0x80)
+//#define		IS_11N_MCS_RATE(rate)		(rate&0x80)
 
 typedef enum _HT_AGGRE_SIZE {
 	HT_AGG_SIZE_8K = 0,
-- 
2.17.1

