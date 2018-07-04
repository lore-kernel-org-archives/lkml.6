Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCEC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC95208C2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4S5zV3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC95208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934449AbeGDMAL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:00:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41165 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934033AbeGDMAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:00:04 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so5071987wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOlTFBTyaGhwcxJj/0HUqrSZzTvIfO5U5K3mP6FlHOs=;
        b=e4S5zV3FGAfG0+D9YY4M+73ya5dfVECzr74jCU7gz1CCOYgUQLj10vJJx6OMLIe0y2
         CpGzj2a01QjI9JVtQnBAvY7GXbxt4xTRVuAxGR6sFAApmx/i+LR2IypTSu0iZ5CjOI0F
         LueamZq+YBkLOMR5TvU1HmVPzVUy6X/Qq6vyGHX0l0zGQcf3eFjOTFStw1eq94YB6bBG
         UQhwlNgAgdrBTDsTLZ/PU1QTfg5w/gRvk5ueJ3064SUnRo7GnDXSAhzG0qRh6Fp07zAl
         4bQVKh1vUZ97O7yfBeRGW9+nAuza+iEdJxQgdmwraU6LKyXfTk7iQZN3BKxqCld0bhrd
         mp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOlTFBTyaGhwcxJj/0HUqrSZzTvIfO5U5K3mP6FlHOs=;
        b=aAqRjnc5Gug3HG8z8/ns4WwrnnVlKbIvWAtfpnmNf4n8v40GAUVW93xAN7M0K1Cv5z
         rbc93COI9oYrvt7NFZj4LBTf+SXNKWRP7INKN/YEu2ZSdwUiB66RgoBdH1QRlINhlRIB
         cDO03I1D/fqsXrieNOVZE9MYp9oJnrjjeY2SGjaZh6EVLfGEKUSmXBJsiZ0aYVyTBZon
         RcpEiupD8Gd8AoJQQNxmZ9uyL8z/F5Rooz2+VuyTqllHR7Yawr7SwIsMiphdQGlvR4KI
         uViSS90j9/eG7HlGciAj0Y4KY3IJ6pYBCReKCf199vcWJEqDhavbfhoOoK+I9TdBinZC
         mWQQ==
X-Gm-Message-State: APt69E0Y+2+vGWArYzDhJfUlQ15NNR0Ze29U7SFjDKs+Tj1vEC+Czydx
        tEPNHPNVyHYVFzlHba+WmCAS8Wq8
X-Google-Smtp-Source: AAOMgpfdjC6r6fthHhWeOPQWAe5w9rzeGE6YeKxaIFyBM/b8ptXCbpa5doux9g9f3oV5RyKozcxBTA==
X-Received: by 2002:adf:cd0e:: with SMTP id w14-v6mr1326047wrm.226.1530705602525;
        Wed, 04 Jul 2018 05:00:02 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6893985wmw.9.2018.07.04.04.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 05:00:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 4/5] staging: rtl8192u: Remove redundant definitions in header
Date:   Wed,  4 Jul 2018 12:59:24 +0100
Message-Id: <20180704115925.28024-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704115925.28024-1-johnfwhitmore@gmail.com>
References: <20180704115925.28024-1-johnfwhitmore@gmail.com>
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

