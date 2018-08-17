Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7333AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9552187B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfhXPuji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9552187B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeHQVj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32770 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id i134-v6so2045713wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0QOIdYb7P+qZ/ikjFmiLmHaz0mElNu4/ey57SviZhwA=;
        b=TfhXPujiQegPzYMiUns4bDZEoXI6jl/VCRzUKuARO8UlMCvr2cVQDRTUG2ZyHAAbwU
         4rTY0VqI/RUvGoAWkhLRFldy2b84v/GdH7k4fEp82a6BnskS1E+9v30exCfmWX4+sRoe
         zSrvb4wcYRQt/8qRW52us6D/BQ9JGrM7ceNqyr9JQD4xJYAJhpyUdNmFWviwRdovw//T
         IrNuLC9fHWwRZ2mU9MeaDPPmtn1FPZ62Z5Rhl5CyEPMMdAVLmSoxr/We/eND6LfOzosN
         BhkC8+M4hZ8hDmU6S2vDyvjV3Tq8rbACNc2t6KIXrbYmKKhutersKzVdrCJcdHBkxF9H
         b3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0QOIdYb7P+qZ/ikjFmiLmHaz0mElNu4/ey57SviZhwA=;
        b=B58C4I1M/rP59LHW3ZlUyiSPb6VxuusKGzHaQmL9335+w+kK2IfY6Civu2Aqv+A6wB
         zecaab8hPB0If5KMVRhRVajoqQdrPlTnKNEl0guRLh/c5wS04/SP8toErG2eAemdUMoE
         C4X55tALGakCaAOJOsUDeBIBvWVGr4O+hs5CiUvfnpsoGTGDZzMXQ4QJE0bOjfYRqTQ7
         6k5VkmXSXbMRnFgWyZvLWPiABZGgKeSkVevrt2/xl3xBwOD6pQtijClyrfKDl5YnyFBj
         mDt4GGI69qk66/CEInS2Vxk6meqDdL04kFKK1P7b2eyy2lO+PA/B834dhT2LUcCFIutu
         SiLw==
X-Gm-Message-State: AOUpUlHKy9WwgIiYLsLo6l/meeMACf617FqYnm/ts/fXXZs0gKZugYmf
        CU7ULPBhlb48h0iZdf9k0b/X62zhSIs=
X-Google-Smtp-Source: AA+uWPydANrjSF0Xz11p+Q0Er2H+Gu6nZ73K+NHY/eFt6Tov4Qkx5BSNV1mTiFKKjdl81CcUcrSAnw==
X-Received: by 2002:a1c:6d17:: with SMTP id i23-v6mr20648563wmc.139.1534530899132;
        Fri, 17 Aug 2018 11:34:59 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:34:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/10] staging:rtl8192u: Remove unnecessary blank lines - Style
Date:   Fri, 17 Aug 2018 19:34:40 +0100
Message-Id: <20180817183447.15993-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817183447.15993-1-johnfwhitmore@gmail.com>
References: <20180817183447.15993-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed blank lines which cause checkpatch issues.

This is a simple coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 0c6d6b352497..69cb5884bbc4 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -18,7 +18,6 @@
  */
 #define HTCLNG	4
 
-
 #define HT_SUPPORTED_MCS_1SS_BITMAP					0x000000ff
 #define HT_SUPPORTED_MCS_2SS_BITMAP					0x0000ff00
 #define HT_SUPPORTED_MCS_1SS_2SS_BITMAP			HT_MCS_1SS_BITMAP|HT_MCS_1SS_2SS_BITMAP
@@ -88,7 +87,6 @@ typedef	union _HT_CAPABILITY_MACPARA{
 */
 
 typedef	struct _HT_CAPABILITY_ELE {
-
 	//HT capability info
 	u8	AdvCoding:1;
 	u8	ChlWidth:1;
@@ -113,7 +111,6 @@ typedef	struct _HT_CAPABILITY_ELE {
 	//Supported MCS set
 	u8	MCS[16];
 
-
 	//Extended HT Capability Info
 	u16	ExtHTCapInfo;
 
@@ -193,7 +190,6 @@ typedef struct _RT_HIGH_THROUGHPUT {
 	// 802.11n spec version for "peer"
 	HT_SPEC_VER			ePeerHTSpecVer;
 
-
 	// HT related information for "Self"
 	HT_CAPABILITY_ELE	SelfHTCap;		// This is HT cap element sent to peer STA, which also indicate HT Rx capabilities.
 	HT_INFORMATION_ELE	SelfHTInfo;		// This is HT info element sent to peer STA, which also indicate HT Rx capabilities.
@@ -202,14 +198,12 @@ typedef struct _RT_HIGH_THROUGHPUT {
 	u8				PeerHTCapBuf[32];
 	u8				PeerHTInfoBuf[32];
 
-
 	// A-MSDU related
 	u8				bAMSDU_Support;			// This indicates Tx A-MSDU capability
 	u16				nAMSDU_MaxSize;			// This indicates Tx A-MSDU capability
 	u8				bCurrent_AMSDU_Support;	// This indicates Tx A-MSDU capability
 	u16				nCurrent_AMSDU_MaxSize;	// This indicates Tx A-MSDU capability
 
-
 	// AMPDU  related <2006.08.10 Emily>
 	u8				bAMPDUEnable;				// This indicate Tx A-MPDU capability
 	u8				bCurrentAMPDUEnable;		// This indicate Tx A-MPDU capability
@@ -283,7 +277,6 @@ typedef struct _RT_HIGH_THROUGHPUT {
 //------------------------------------------------------------
 
 typedef struct _BSS_HT {
-
 	u8				bdSupportHT;
 
 	// HT related elements
@@ -316,8 +309,6 @@ extern u8 MCS_FILTER_1SS[16];
 						(LegacyRate):\
 						(PICK_RATE(LegacyRate, HTRate))
 
-
-
 // MCS Bw 40 {1~7, 12~15,32}
 #define	RATE_ADPT_1SS_MASK		0xFF
 #define	RATE_ADPT_2SS_MASK		0xF0 //Skip MCS8~11 because mcs7 > mcs6, 9, 10, 11. 2007.01.16 by Emily
-- 
2.18.0

