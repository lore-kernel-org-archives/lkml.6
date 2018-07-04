Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BD5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC35208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKUaDFUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC35208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeGDOXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:23:00 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35305 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeGDOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:21:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id v3-v6so2332623wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOlTFBTyaGhwcxJj/0HUqrSZzTvIfO5U5K3mP6FlHOs=;
        b=mKUaDFUFQLdP5KokbMxyctaGC/U1zFadGcbF6NoGhpS/9mDR5PoOP1k2dCJEEK5IGE
         UaT9ECc3tprM+ZkVI0tvBvH3uaWuooMAthncXPxYgBvLg49t9P5piRO0wRW+4/SbrSSo
         LoU1vKFAG4Uz9EwUtCfC84m3yg9YNVNlal5qn2AgdoGXNV9RCr9lNgFkpK6dtCk5LucN
         PbIQRfk4HktjMJiZQ0IjcL1/Ly5uCwH6JYCGTrI3CQPXlpaOrolL/PYlTrfjr96+r6Rr
         cCH1em69ezHsyI+G4WEwSwtaDfFDNYbetD9JrDaTvrvFxQSTZm9/D1wpGMP3g/O/+G00
         cCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOlTFBTyaGhwcxJj/0HUqrSZzTvIfO5U5K3mP6FlHOs=;
        b=CSHt7Oz/7iETKUeHyE6FbS+S6tEPZcbJNaeFMF5AdUYWkjUtVts1ldg3qgHAQcY+1h
         MP3RpkNCtlebjtL9gwhs9D5F5j2IafqTKQZ7dqJCzhQxT9ssNpdOBIWSXdJIqE2/JRSs
         lu+7219a5eK84WdzoXOuqvpbWYHbGGH7yTOLrjsp1+19U1qf7Cw7QZXhJmQ54jLTOlTn
         yX8t0avIyqpWWoFC5SPXxhyiwp4Lyo8ykIFUBSbW70Ry4917Wuf/kppTV0tvQTNSfq5Q
         9aczQyYsLpVPBOxW7lPLeRG7+0Dqa7GAk7K+M7U8Vlw9qICNAkZFlnmFXTswTEIOwk1T
         v0wg==
X-Gm-Message-State: APt69E1FCc/gjgmtxP3NAaPx36ZvNw2exeKcp+hMXryDDzxKqYwcfrtc
        CvtL/59Na13zK64YNtqexLsrYE0y
X-Google-Smtp-Source: AAOMgpf9PncaVP8eC7ilkp5WZ/fkBP3t7JSsGROJYRAvHL4TMoDRqTnCqD0JaUNZfiEXM2ZnVdfvdg==
X-Received: by 2002:adf:fd12:: with SMTP id e18-v6mr1699462wrr.280.1530714069846;
        Wed, 04 Jul 2018 07:21:09 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id s41-v6sm7109142wrc.5.2018.07.04.07.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:21:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 3/9] staging: rtl8192u: Remove redundant definitions in header
Date:   Wed,  4 Jul 2018 15:20:50 +0100
Message-Id: <20180704142056.2179-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704142056.2179-1-johnfwhitmore@gmail.com>
References: <20180704142056.2179-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Truncated header file removing definitions which aren't used.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   | 117 ------------------
 1 file changed, 117 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index a85036022aa8..6abf32b142ef 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -7,21 +7,10 @@
 //	reassociation request and probe response frames
 //------------------------------------------------------------
 
-//
-// Operation mode value
-//
-#define HT_OPMODE_NO_PROTECT		0
-#define HT_OPMODE_OPTIONAL		1
-#define HT_OPMODE_40MHZ_PROTECT	2
-#define HT_OPMODE_MIXED			3
-
 //
 // MIMO Power Save Settings
 //
 #define MIMO_PS_STATIC				0
-#define MIMO_PS_DYNAMIC			1
-#define MIMO_PS_NOLIMIT			3
-
 
 //
 //	There should be 128 bits to cover all of the MCS rates. However, since
@@ -35,27 +24,6 @@
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
-
 //
 // Represent Channel Width in HT Capabilities
 //
@@ -120,28 +88,6 @@ typedef	union _HT_CAPABILITY_MACPARA{
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
-
-/* 2007/06/07 MH Define sub-carrier mode for 40MHZ. */
-typedef enum _HT_Bandwidth_40MHZ_Sub_Carrier {
-	SC_MODE_DUPLICATE = 0,
-	SC_MODE_LOWER = 1,
-	SC_MODE_UPPER = 2,
-	SC_MODE_FULL40MHZ = 3,
-}HT_BW40_SC_E;
-
 typedef	struct _HT_CAPABILITY_ELE {
 
 	//HT capability info
@@ -212,16 +158,6 @@ typedef struct _HT_INFORMATION_ELE {
 	u8	BasicMSC[16];
 } __attribute__ ((packed)) HT_INFORMATION_ELE, *PHT_INFORMATION_ELE;
 
-//
-// MIMO Power Save control field.
-// This is appear in MIMO Power Save Action Frame
-//
-typedef struct _MIMOPS_CTRL {
-	u8	MimoPsEnable:1;
-	u8	MimoPsMode:1;
-	u8	Reserved:6;
-} MIMOPS_CTRL, *PMIMOPS_CTRL;
-
 typedef enum _HT_SPEC_VER {
 	HT_SPEC_VER_IEEE = 0,
 	HT_SPEC_VER_EWC = 1,
@@ -342,37 +278,6 @@ typedef struct _RT_HIGH_THROUGHPUT {
 	u32				IOTAction;
 } __attribute__ ((packed)) RT_HIGH_THROUGHPUT, *PRT_HIGH_THROUGHPUT;
 
-
-//------------------------------------------------------------
-// The Data structure is used to keep HT related variable for "each Sta"
-// when card is configured as "AP mode"
-//------------------------------------------------------------
-
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
-
-
-
-
-
 //------------------------------------------------------------
 // The Data structure is used to keep HT related variable for "each AP"
 // when card is configured as "STA mode"
@@ -396,28 +301,6 @@ typedef struct _BSS_HT {
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
-
-typedef struct _MIMO_EVM {
-	u32	EVM1;
-	u32    EVM2;
-}MIMO_EVM, *PMIMO_EVM;
-
-typedef struct _FALSE_ALARM_STATISTICS {
-	u32	Cnt_Parity_Fail;
-	u32    Cnt_Rate_Illegal;
-	u32	Cnt_Crc8_fail;
-	u32	Cnt_all;
-}FALSE_ALARM_STATISTICS, *PFALSE_ALARM_STATISTICS;
-
-
 extern u8 MCS_FILTER_ALL[16];
 extern u8 MCS_FILTER_1SS[16];
 
-- 
2.17.1

