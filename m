Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7123EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219F6208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbJBrHmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219F6208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeGPTeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33002 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbeGPTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so27092523edr.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4eb4Jb3WykGakdORN21CNONfIk85/BHh/e+DE1bS5U=;
        b=FbJBrHmR7MS42n0pWqjW1962piwgyIH6qFYnKPFtPo8Ic7RQpIDQGkeS9wjOHAvpp0
         zcsrncAYggmVTrPEJoJoGCiW4l2LB+iAnTAT5x9K6zsEgMrgStu3qnpPVgaJcEPXpOcL
         eCK13YJjcJq3ETHFkeus+IZuEXXwxlCiswvsw/Sej+fu6kWnLmkYqGsV4AlHxrsomx+7
         xYnwoPFfum1RYLKsa7KsxDpi/00C6r/l/zmZ3/nj5fFu0f3YcQMiOY9opVC8xCB/AOiQ
         9tNdg78PBRj8dD1jc5uydKkdHwOrdteC8kQIdFL8pnPVNwvkAxZNOKPRBkfIzYsSNKiK
         MIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4eb4Jb3WykGakdORN21CNONfIk85/BHh/e+DE1bS5U=;
        b=c3k1JHevW/mso8XaAtyJyrS0W4OhnnhGoW99f/7LSsZx6Y5xWkpGt68BWMaHfqwXWz
         nOAufcCBlU4DCPekN5sAhUV4uQeW0y0NVjMZsQ4ldOdPAt+V5QOV7RjqhdDWN+UCl+qn
         uS7/KG3YxBb+TeeeKHj9K3wZCJ6yp+Bva6v+pFnpwbk7tcRsyYGm056q1LwpwwxQb3SH
         qOYfjjr5hBoqSM997Sef3acAHtX1ZnTbDsOXZUVVodr7D2rh8/70IOHkJ6wfCLfLNkNs
         2EMnpb9h/NMz9OmmZ070VleyhX4GCAaSaCGg5D/TLcWnZdSz0Gb8M1mZbbnisaKlbA7C
         2ySg==
X-Gm-Message-State: AOUpUlE+F3phgoW2pRAb/oHWhvKnpJFrEtJX/vZucgxKA5hk9jXP4OqJ
        gG7jiFR3RGHONPu2FjNil6Kmkg==
X-Google-Smtp-Source: AAOMgpcrvbXo4Z5Ga3ihegjx3PSfis5Mby9XyCrXKQoj/QC4g6j+Rm+fIEMKmn2T1RqelQmOLRDxdw==
X-Received: by 2002:aa7:d6c6:: with SMTP id x6-v6mr19059176edr.148.1531767924897;
        Mon, 16 Jul 2018 12:05:24 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:24 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 01/10] staging:rtl8192u: remove typedef of enumeration TR_SELECT - Style
Date:   Mon, 16 Jul 2018 20:04:45 +0100
Message-Id: <20180716190454.31489-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716190454.31489-1-johnfwhitmore@gmail.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
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
index 3b7968681f77..e65c9967b627 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2391,7 +2391,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb);
 void TsInitAddBA(struct ieee80211_device *ieee, PTX_TS_RECORD pTS,
 		 u8 Policy, u8 bOverwritePending);
 void TsInitDelBA(struct ieee80211_device *ieee,
-		 PTS_COMMON_INFO pTsCommonInfo, TR_SELECT TxRxSelect);
+		 PTS_COMMON_INFO pTsCommonInfo, enum tr_select TxRxSelect);
 void BaSetupTimeOut(struct timer_list *t);
 void TxBaInactTimeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
@@ -2402,7 +2402,7 @@ bool GetTs(
 	PTS_COMMON_INFO                 *ppTS,
 	u8                              *Addr,
 	u8                              TID,
-	TR_SELECT                       TxRxSelect,  //Rx:1, Tx:0
+	enum tr_select                  TxRxSelect,  //Rx:1, Tx:0
 	bool                            bAddNewTs
 	);
 void TSInitialize(struct ieee80211_device *ieee);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 2dc4d0e93948..04779da803e4 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -174,7 +174,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, P
  *function:  construct DELBA frame
  *   input:  u8*		dst	//DELBA frame's destination
  *	     PBA_RECORD		pBA	//BA_RECORD entry which stores the necessary information for BA
- *	     TR_SELECT	        TxRxSelect  //TX RX direction
+ *	     enum tr_select	TxRxSelect  //TX RX direction
  *	     u16		ReasonCode  //status code.
  *  output:  none
  *  return:  sk_buff*		skb     //return constructed skb to xmit
@@ -183,7 +183,7 @@ static struct sk_buff *ieee80211_DELBA(
 	struct ieee80211_device  *ieee,
 	u8		         *dst,
 	PBA_RECORD		 pBA,
-	TR_SELECT		 TxRxSelect,
+	enum tr_select		 TxRxSelect,
 	u16			 ReasonCode
 	)
 {
@@ -290,14 +290,14 @@ static void ieee80211_send_ADDBARsp(struct ieee80211_device *ieee, u8 *dst,
  *function: send ADDBARSP frame out
  *   input:  u8*		dst	//DELBA frame's destination
  *	     PBA_RECORD		pBA	//BA_RECORD entry which stores the necessary information for BA
- *	     TR_SELECT          TxRxSelect //TX or RX
+ *	     enum tr_select     TxRxSelect //TX or RX
  *	     u16		ReasonCode //DEL ReasonCode
  *  output:  none
  *  notice: If any possible, please hide pBA in ieee. And temporarily use Manage Queue as softmac_mgmt_xmit() usually does
  ********************************************************************************************************************/
 
 static void ieee80211_send_DELBA(struct ieee80211_device *ieee, u8 *dst,
-				 PBA_RECORD pBA, TR_SELECT TxRxSelect,
+				 PBA_RECORD pBA, enum tr_select TxRxSelect,
 				 u16 ReasonCode)
 {
 	struct sk_buff *skb;
@@ -638,7 +638,7 @@ TsInitAddBA(
 }
 
 void
-TsInitDelBA(struct ieee80211_device *ieee, PTS_COMMON_INFO pTsCommonInfo, TR_SELECT TxRxSelect)
+TsInitDelBA(struct ieee80211_device *ieee, PTS_COMMON_INFO pTsCommonInfo, enum tr_select TxRxSelect)
 {
 	if (TxRxSelect == TX_DIR) {
 		PTX_TS_RECORD	pTxTs = (PTX_TS_RECORD)pTsCommonInfo;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 3a0ff08c687a..c6a5ac1e647c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -10,10 +10,10 @@
 #define TCLAS_NUM		4
 
 /*  This define the Tx/Rx directions */
-typedef enum _TR_SELECT {
+enum tr_select {
 	TX_DIR = 0,
 	RX_DIR = 1,
-} TR_SELECT, *PTR_SELECT;
+};
 
 typedef struct _TS_COMMON_INFO {
 	struct list_head		List;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index e60a26250682..d6ba9201028f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -204,7 +204,7 @@ static void AdmitTS(struct ieee80211_device *ieee,
 
 static PTS_COMMON_INFO SearchAdmitTRStream(struct ieee80211_device *ieee,
 					   u8 *Addr, u8 TID,
-					   TR_SELECT TxRxSelect)
+					   enum tr_select TxRxSelect)
 {
 	//DIRECTION_VALUE	dir;
 	u8	dir;
@@ -291,7 +291,7 @@ bool GetTs(
 	PTS_COMMON_INFO			*ppTS,
 	u8				*Addr,
 	u8				TID,
-	TR_SELECT			TxRxSelect,  //Rx:1, Tx:0
+	enum tr_select			TxRxSelect,  //Rx:1, Tx:0
 	bool				bAddNewTs
 	)
 {
@@ -408,7 +408,7 @@ bool GetTs(
 }
 
 static void RemoveTsEntry(struct ieee80211_device *ieee, PTS_COMMON_INFO pTs,
-			  TR_SELECT TxRxSelect)
+			  enum tr_select TxRxSelect)
 {
 	//u32 flags = 0;
 	unsigned long flags = 0;
-- 
2.18.0

