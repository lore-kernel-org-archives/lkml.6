Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B539C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECD6208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW3vtx35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECD6208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbeGaWmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40761 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeGaWmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so5860187edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9iChcYKEC5FcPR6Ao1IVIl8lBi7ADgg+FPVxNey5lHE=;
        b=WW3vtx35OCnqBz2jO6BPpurZaLx0w8+Rr+aeU3gheJ+ZkyL5oVu4YpPV5OrIz4X9xe
         JDaUw4jXTBVnN0842wD1Tx4HdzNN16kVi8lle2RUw83Po7IGtyEW1yXKJMGN2CS8Bflg
         vxq32Yb1CBs2pxDmZQQUMHeDTry6viR9+vjM7O0e40QqnbiikyZaKH/cDn1kHdYp4AXT
         UsgWkJR45fgsTvqPm/9x6raNy13HHFuvtIu3nHhnhOBJWF38GNDdrjlbNjxGHoeD/I42
         2PNNda1NiohQ3f87nbGmQt33DI6a8xVDe/GY9pcqJQ9A0bDiiv8UMU5qH+LL7+zjUn5n
         Jn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9iChcYKEC5FcPR6Ao1IVIl8lBi7ADgg+FPVxNey5lHE=;
        b=hSEnqcZQEFwWD46ZZPDd3Z3Fxrunys9Bd/D4MuUXkgwGyqfrPpvMlGuJNHP43hnwlP
         xF2r59Vl8gF6O1Z9uxb4w92v4lPXMVE2dPV87xcFJfQNqeUTL0Cm4ypI3LjYx3FUpJeE
         bGp2aDz1HnGaSkSw3KmXfJNnE/ggaZSVYuWih/sTEO07G8ZNgsvNGlSQ7THZbm+1PStZ
         R2zflYbm9gAIj1ox1I67gy63thKnG3ZY67NwlzREa8+b4mZIRlIOoKWsBUy2BdI70nAr
         jnk1XmCywWFHu+zVetmxt1gmEjHIMmfMIShYoZeBYO7VY52F1SiYH8l41vdCUgorwMUI
         MogA==
X-Gm-Message-State: AOUpUlHOaX5w5/5Wpbl/iPklgrjQqPGPNsNMVM1aeJETXL2xI5iHKZAW
        LIAlQ/RWccN4CLfN0D74el5k7w04
X-Google-Smtp-Source: AAOMgpdnYgH4X5dOP5pzyPH+6KOfwVKipcDnXsGAWc7n8joUDgI4wYGCbuEam/hZxbDTZcyIGwBlMg==
X-Received: by 2002:a50:d65e:: with SMTP id c30-v6mr1144715edj.178.1533070843462;
        Tue, 31 Jul 2018 14:00:43 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:42 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/14] staging:rtl8192u: rename OCTET_STRING - Style
Date:   Tue, 31 Jul 2018 22:00:01 +0100
Message-Id: <20180731210005.17452-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the structure OCTET_STRING to octet_string. This is to comply
with the coding style of using lowercase for types. In addition the
typedef directive is removed to clear the checkpatch issue with
defining new types.

These are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h         | 4 ++--
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h       | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 326a1e47bade..3cfeac0d7214 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -1543,14 +1543,14 @@ typedef struct _RT_POWER_SAVE_CONTROL {
 	bool				bTmpFilterHiddenAP;
 	bool				bTmpUpdateParms;
 	u8					tmpSsidBuf[33];
-	OCTET_STRING			tmpSsid2Scan;
+	struct octet_string			tmpSsid2Scan;
 	bool				bTmpSsid2Scan;
 	u8					tmpNetworkType;
 	u8					tmpChannelNumber;
 	u16					tmpBcnPeriod;
 	u8					tmpDtimPeriod;
 	u16					tmpmCap;
-	OCTET_STRING			tmpSuppRateSet;
+	struct octet_string			tmpSuppRateSet;
 	u8					tmpSuppRateBuf[MAX_NUM_RATES];
 	bool				bTmpSuppRate;
 	IbssParms				tmpIbpm;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index ca3a35b8ac07..706b4419e643 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1063,7 +1063,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	if (beacon->bCkipSupported) {
 		static u8	AironetIeOui[] = {0x00, 0x01, 0x66}; // "4500-client"
 		u8	CcxAironetBuf[30];
-		OCTET_STRING	osCcxAironetIE;
+		struct octet_string	osCcxAironetIE;
 
 		memset(CcxAironetBuf, 0, 30);
 		osCcxAironetIE.Octet = CcxAironetBuf;
@@ -1087,7 +1087,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 
 	if (beacon->bCcxRmEnable) {
 		static u8 CcxRmCapBuf[] = {0x00, 0x40, 0x96, 0x01, 0x01, 0x00};
-		OCTET_STRING osCcxRmCap;
+		struct octet_string osCcxRmCap;
 
 		osCcxRmCap.Octet = CcxRmCapBuf;
 		osCcxRmCap.Length = sizeof(CcxRmCapBuf);
@@ -1100,7 +1100,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 
 	if (beacon->BssCcxVerNumber >= 2) {
 		u8			CcxVerNumBuf[] = {0x00, 0x40, 0x96, 0x03, 0x00};
-		OCTET_STRING	osCcxVerNum;
+		struct octet_string	osCcxVerNum;
 		CcxVerNumBuf[4] = beacon->BssCcxVerNumber;
 		osCcxVerNum.Octet = CcxVerNumBuf;
 		osCcxVerNum.Length = sizeof(CcxVerNumBuf);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index fb055a848d59..531a3e22e799 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -72,10 +72,10 @@ struct tspec_body {
 //----------------------------------------------------------------------------
 //      802.11 Management frame Status Code field
 //----------------------------------------------------------------------------
-typedef struct _OCTET_STRING {
+struct octet_string {
 	u8		*Octet;
 	u16             Length;
-} OCTET_STRING, *POCTET_STRING;
+};
 
 //Added by joseph
 //UP Mapping to AC, using in MgntQuery_SequenceNumber() and maybe for DSCP
-- 
2.18.0

