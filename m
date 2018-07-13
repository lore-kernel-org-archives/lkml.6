Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFA7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3A4208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx5xaunD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3A4208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbeGMUaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:30:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33354 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731501AbeGMU3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so17324544wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=INm3HEGjDtlVQSmUqlUsIqnJz3yfy6g896BPQuPw3sA=;
        b=Gx5xaunD8ZkVaa8gsVM9ycGmMU0jlwFBOwBNMKRwadECtFXxV+JQJ8VpGj6SZSfwCz
         p5lMk4qoIywn36+cK4+YIVTasO00fVkNiHOFR5x3BsyBiprkjxle0U0J2UpOcRk1WhWX
         4Dotp2vWLUpPFe8z0w/Amx5fO2NM2LRcIHfKGw3sNpSXUG3WtteNeSZzym0SJPpeTFF2
         nue/gKsJ8fSxlM91Nb3WJ314OU3lZ/SGnM1iYopMIrPGg6ade4QDV9CKgv2w4jUhR4m+
         LdQMECCUC+VYJZ4pUQKLCNO02TXuFRMw25YcEt0t2hAUcwvH2vEyCAPQaktiU57GocGa
         WV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=INm3HEGjDtlVQSmUqlUsIqnJz3yfy6g896BPQuPw3sA=;
        b=dJ14TxhskN+M1lLu+aX2KfL2yPiAAbc8asMP2msu94op2T1ecRXuSj4oijaVHwG+pk
         9hOxtUY7mdiofoROi+vr+lkSCEeBsl1NCZu5HNHPDSQh+wHNjEsMOQvKLR6Bfs5qTGTh
         x7oLxw5Ev/llbeG4cbUEi/MuaTopstkLf0Q+wWWN6k1pDbS/ym6ncGH16Lxt7Tk2wBc3
         RdA3ZiLYHV//Eb1TdFDtPMNrznE7tcmpYgyQUZjooYDTAd8ppQ2Sp8g88ygXF3TT59IS
         fnsbw+P0jOE0FZ2w++OTvT32nbEX70dYZCf2LABwGLYQEQ6KVHK2DDft/5MrsyQ60Rph
         fAcw==
X-Gm-Message-State: AOUpUlHJj4fXAi7wHs0/wrEsf0wIqdWwvJCLGu7QnqRyJpaCLBwMVQda
        yJfifBlKCpi3mrQQJqdIknOmQeuc
X-Google-Smtp-Source: AAOMgpciFSZWpmUfvQTr6QyJZG/EQiJlUIGpfCFMSQln4kldYOJXP7Miqku4PHV9PTvmPrceiZJMag==
X-Received: by 2002:adf:aa0b:: with SMTP id p11-v6mr5611934wrd.220.1531512805876;
        Fri, 13 Jul 2018 13:13:25 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:25 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/10] staging:rtl8192u: remove typedef of enumeration TR_SELECT - Style
Date:   Fri, 13 Jul 2018 21:12:38 +0100
Message-Id: <20180713201247.21428-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To clear a checkpatch issue removed the typedef of the enumeration TR_SELECT
this should not impact runtime code as it's only a coding style change.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h      |  4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c |  6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 3b7968681f77..0fa55af7060a 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2391,7 +2391,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb);
 void TsInitAddBA(struct ieee80211_device *ieee, PTX_TS_RECORD pTS,
 		 u8 Policy, u8 bOverwritePending);
 void TsInitDelBA(struct ieee80211_device *ieee,
-		 PTS_COMMON_INFO pTsCommonInfo, TR_SELECT TxRxSelect);
+		 PTS_COMMON_INFO pTsCommonInfo, enum TR_SELECT TxRxSelect);
 void BaSetupTimeOut(struct timer_list *t);
 void TxBaInactTimeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
@@ -2402,7 +2402,7 @@ bool GetTs(
 	PTS_COMMON_INFO                 *ppTS,
 	u8                              *Addr,
 	u8                              TID,
-	TR_SELECT                       TxRxSelect,  //Rx:1, Tx:0
+	enum TR_SELECT                  TxRxSelect,  //Rx:1, Tx:0
 	bool                            bAddNewTs
 	);
 void TSInitialize(struct ieee80211_device *ieee);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 2dc4d0e93948..07d64ae12fdd 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -174,7 +174,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, P
  *function:  construct DELBA frame
  *   input:  u8*		dst	//DELBA frame's destination
  *	     PBA_RECORD		pBA	//BA_RECORD entry which stores the necessary information for BA
- *	     TR_SELECT	        TxRxSelect  //TX RX direction
+ *	     enum TR_SELECT	TxRxSelect  //TX RX direction
  *	     u16		ReasonCode  //status code.
  *  output:  none
  *  return:  sk_buff*		skb     //return constructed skb to xmit
@@ -183,7 +183,7 @@ static struct sk_buff *ieee80211_DELBA(
 	struct ieee80211_device  *ieee,
 	u8		         *dst,
 	PBA_RECORD		 pBA,
-	TR_SELECT		 TxRxSelect,
+	enum TR_SELECT		 TxRxSelect,
 	u16			 ReasonCode
 	)
 {
@@ -290,14 +290,14 @@ static void ieee80211_send_ADDBARsp(struct ieee80211_device *ieee, u8 *dst,
  *function: send ADDBARSP frame out
  *   input:  u8*		dst	//DELBA frame's destination
  *	     PBA_RECORD		pBA	//BA_RECORD entry which stores the necessary information for BA
- *	     TR_SELECT          TxRxSelect //TX or RX
+ *	     enum TR_SELECT     TxRxSelect //TX or RX
  *	     u16		ReasonCode //DEL ReasonCode
  *  output:  none
  *  notice: If any possible, please hide pBA in ieee. And temporarily use Manage Queue as softmac_mgmt_xmit() usually does
  ********************************************************************************************************************/
 
 static void ieee80211_send_DELBA(struct ieee80211_device *ieee, u8 *dst,
-				 PBA_RECORD pBA, TR_SELECT TxRxSelect,
+				 PBA_RECORD pBA, enum TR_SELECT TxRxSelect,
 				 u16 ReasonCode)
 {
 	struct sk_buff *skb;
@@ -638,7 +638,7 @@ TsInitAddBA(
 }
 
 void
-TsInitDelBA(struct ieee80211_device *ieee, PTS_COMMON_INFO pTsCommonInfo, TR_SELECT TxRxSelect)
+TsInitDelBA(struct ieee80211_device *ieee, PTS_COMMON_INFO pTsCommonInfo, enum TR_SELECT TxRxSelect)
 {
 	if (TxRxSelect == TX_DIR) {
 		PTX_TS_RECORD	pTxTs = (PTX_TS_RECORD)pTsCommonInfo;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 3a0ff08c687a..3a5347818718 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -10,10 +10,10 @@
 #define TCLAS_NUM		4
 
 /*  This define the Tx/Rx directions */
-typedef enum _TR_SELECT {
+enum TR_SELECT {
 	TX_DIR = 0,
 	RX_DIR = 1,
-} TR_SELECT, *PTR_SELECT;
+};
 
 typedef struct _TS_COMMON_INFO {
 	struct list_head		List;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index e60a26250682..75d269a7bf09 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -204,7 +204,7 @@ static void AdmitTS(struct ieee80211_device *ieee,
 
 static PTS_COMMON_INFO SearchAdmitTRStream(struct ieee80211_device *ieee,
 					   u8 *Addr, u8 TID,
-					   TR_SELECT TxRxSelect)
+					   enum TR_SELECT TxRxSelect)
 {
 	//DIRECTION_VALUE	dir;
 	u8	dir;
@@ -291,7 +291,7 @@ bool GetTs(
 	PTS_COMMON_INFO			*ppTS,
 	u8				*Addr,
 	u8				TID,
-	TR_SELECT			TxRxSelect,  //Rx:1, Tx:0
+	enum TR_SELECT			TxRxSelect,  //Rx:1, Tx:0
 	bool				bAddNewTs
 	)
 {
@@ -408,7 +408,7 @@ bool GetTs(
 }
 
 static void RemoveTsEntry(struct ieee80211_device *ieee, PTS_COMMON_INFO pTs,
-			  TR_SELECT TxRxSelect)
+			  enum TR_SELECT TxRxSelect)
 {
 	//u32 flags = 0;
 	unsigned long flags = 0;
-- 
2.18.0

