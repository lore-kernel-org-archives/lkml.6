Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6491C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70802217C0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjBFtHNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70802217C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeHUUg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:36:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34610 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeHUUg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so10138462wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QHstCvhWG/Ce2OUxMTraqF9cjJFBDSBaOqILNdB0j3M=;
        b=HjBFtHNWQJMHe78CL1sT/+L/l0JseczTZDuPlIPZ2Dnqjmu2z/MSaurdycOA+0FFvm
         AJj/B/4IZ3miaF3g7z3E6aMDivY5SxLEmfdJOZQEKOv3/x54JE70Mu2Fq3In88AolOgo
         7xCklSwBW9hZ1Fv3miBTiW5KlVzlgqUrxjQfCSFzKFtX0+IULdm/mzs1qo8d497LpfzG
         HgLS0VVzOWBeEkMNTDWyEa5edhFxCy2jCesoxYhMLFM4HPGqqPUNB/sKO7ncIcNhmy+I
         UmH7PmoliZjBdEnOUnEsfx3DeJM2YC7YaGrFacW7wvs0S3u5xr0Ig0tYeX3oGu1Sttwf
         KR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QHstCvhWG/Ce2OUxMTraqF9cjJFBDSBaOqILNdB0j3M=;
        b=ZjNuJOqhu7/XVjlRwlCoKYLuyMklPLH0FKjo6+qPgilRtIea4VItpMshXQAp6QFZOw
         0XvHZ8GlK/nTrqaCh1roAiNSTSbVZj6fdGjS3l/3mGQJ/CZp1bV2JTLRjmAiLjmfR9bp
         LPtTVu7/IrXBN2TKAH16CYIt9ukOciv91/norMZyidm2hOOK8wuOGNoVJG9o/y60Wj5A
         MP2lVz1FRwTAIMTAin9Mp1ns1NK8BZivcPJCppEHJh7JBeArgcjkcQPpusiK42tc9b0y
         VE3NLOHZayanAQTJiqLnSrEL1Y7ONQLQAJ/M5+/l9A37XjrVjulDCrzVISRKIu1wbKJJ
         K94Q==
X-Gm-Message-State: APzg51C0Rt1MhRSjoDU2oI/UA41ftSw4YO2plBWFU0UfrLPIGVWRefiS
        60lihef1zM6nt+aeFe8un7daD1pbmZQ=
X-Google-Smtp-Source: ANB0VdZWtklkHNkGHvRWnLhxmIb2xIeIYNdysnjympaVpH4JYI36iaYfxjJWTfkdFXnG5m4Fi8jn4A==
X-Received: by 2002:a1c:48d:: with SMTP id 135-v6mr188795wme.128.1534871756212;
        Tue, 21 Aug 2018 10:15:56 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/17] staging:rtl8192u: Refactor struct BA_RECORD - Style
Date:   Tue, 21 Aug 2018 18:15:30 +0100
Message-Id: <20180821171537.9330-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the 'typedef' directive from the BA_RECORD structure, to clear
the checkpatch issue with defining new types.

Additionally rename the structure to lowercase to comply with the
coding style.

These changes are purely coding style changes which should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_BA.h   |  4 +-
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       | 48 +++++++++----------
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  6 +--
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 3cfeac0d7214..c1d34d9ef2e5 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2395,7 +2395,7 @@ void TsInitDelBA(struct ieee80211_device *ieee,
 void BaSetupTimeOut(struct timer_list *t);
 void TxBaInactTimeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
-void ResetBaEntry(PBA_RECORD pBA);
+void ResetBaEntry(struct ba_record *pBA);
 //function in TS.c
 bool GetTs(
 	struct ieee80211_device		*ieee,
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 008fe722af03..b1697cb483ff 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -49,13 +49,13 @@ union delba_param_set {
 	} field;
 };
 
-typedef struct _BA_RECORD {
+struct ba_record {
 	struct timer_list		Timer;
 	u8				bValid;
 	u8				DialogToken;
 	union ba_param_set		BaParamSet;
 	u16				BaTimeoutValue;
 	union sequence_control	BaStartSeqCtrl;
-} BA_RECORD, *PBA_RECORD;
+};
 
 #endif //end _BATYPE_H_
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index e504d1eb2ccf..cb84335468ab 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -12,11 +12,11 @@
 
 /********************************************************************************************************************
  *function:  Activate BA entry. And if Time is nozero, start timer.
- *   input:  PBA_RECORD			pBA  //BA entry to be enabled
+ *   input:  struct ba_record          *pBA  //BA entry to be enabled
  *	     u16			Time //indicate time delay.
  *  output:  none
  ********************************************************************************************************************/
-static void ActivateBAEntry(struct ieee80211_device *ieee, PBA_RECORD pBA, u16 Time)
+static void ActivateBAEntry(struct ieee80211_device *ieee, struct ba_record *pBA, u16 Time)
 {
 	pBA->bValid = true;
 	if (Time != 0)
@@ -25,10 +25,10 @@ static void ActivateBAEntry(struct ieee80211_device *ieee, PBA_RECORD pBA, u16 T
 
 /********************************************************************************************************************
  *function:  deactivate BA entry, including its timer.
- *   input:  PBA_RECORD			pBA  //BA entry to be disabled
+ *   input:  struct ba_record       *pBA  //BA entry to be disabled
  *  output:  none
  ********************************************************************************************************************/
-static void DeActivateBAEntry(struct ieee80211_device *ieee, PBA_RECORD pBA)
+static void DeActivateBAEntry(struct ieee80211_device *ieee, struct ba_record *pBA)
 {
 	pBA->bValid = false;
 	del_timer_sync(&pBA->Timer);
@@ -42,8 +42,8 @@ static void DeActivateBAEntry(struct ieee80211_device *ieee, PBA_RECORD pBA)
  ********************************************************************************************************************/
 static u8 TxTsDeleteBA(struct ieee80211_device *ieee, struct tx_ts_record *pTxTs)
 {
-	PBA_RECORD		pAdmittedBa = &pTxTs->tx_admitted_ba_record;  //These two BA entries must exist in TS structure
-	PBA_RECORD		pPendingBa = &pTxTs->tx_pending_ba_record;
+	struct ba_record *pAdmittedBa = &pTxTs->tx_admitted_ba_record;  //These two BA entries must exist in TS structure
+	struct ba_record *pPendingBa = &pTxTs->tx_pending_ba_record;
 	u8			bSendDELBA = false;
 
 	// Delete pending BA
@@ -70,7 +70,7 @@ static u8 TxTsDeleteBA(struct ieee80211_device *ieee, struct tx_ts_record *pTxTs
  ********************************************************************************************************************/
 static u8 RxTsDeleteBA(struct ieee80211_device *ieee, struct rx_ts_record *pRxTs)
 {
-	PBA_RECORD		pBa = &pRxTs->rx_admitted_ba_record;
+	struct ba_record       *pBa = &pRxTs->rx_admitted_ba_record;
 	u8			bSendDELBA = false;
 
 	if (pBa->bValid) {
@@ -84,10 +84,10 @@ static u8 RxTsDeleteBA(struct ieee80211_device *ieee, struct rx_ts_record *pRxTs
 /********************************************************************************************************************
  *function: reset BA entry
  *   input:
- *	     PBA_RECORD		pBA //entry to be reset
+ *	     struct ba_record *pBA //entry to be reset
  *  output:  none
  ********************************************************************************************************************/
-void ResetBaEntry(PBA_RECORD pBA)
+void ResetBaEntry(struct ba_record *pBA)
 {
 	pBA->bValid			= false;
 	pBA->BaParamSet.short_data	= 0;
@@ -99,13 +99,13 @@ void ResetBaEntry(PBA_RECORD pBA)
 /*******************************************************************************************************************************
  *function:  construct ADDBAREQ and ADDBARSP frame here together.
  *   input:  u8*		Dst	//ADDBA frame's destination
- *	     PBA_RECORD		pBA	//BA_RECORD entry which stores the necessary information for BA.
+ *	     struct ba_record  *pBA	//BA_RECORD entry which stores the necessary information for BA.
  *	     u16		StatusCode  //status code in RSP and I will use it to indicate whether it's RSP or REQ(will I?)
  *	     u8			type	//indicate whether it's RSP(ACT_ADDBARSP) ow REQ(ACT_ADDBAREQ)
  *  output:  none
  *  return:  sk_buff*		skb     //return constructed skb to xmit
  *******************************************************************************************************************************/
-static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, PBA_RECORD pBA, u16 StatusCode, u8 type)
+static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, struct ba_record *pBA, u16 StatusCode, u8 type)
 {
 	struct sk_buff *skb = NULL;
 	 struct rtl_80211_hdr_3addr *BAReq = NULL;
@@ -173,7 +173,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, P
 /********************************************************************************************************************
  *function:  construct DELBA frame
  *   input:  u8*		dst	//DELBA frame's destination
- *	     PBA_RECORD		pBA	//BA_RECORD entry which stores the necessary information for BA
+ *	     struct ba_record  *pBA	//BA_RECORD entry which stores the necessary information for BA
  *	     enum tr_select	TxRxSelect  //TX RX direction
  *	     u16		ReasonCode  //status code.
  *  output:  none
@@ -182,7 +182,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, P
 static struct sk_buff *ieee80211_DELBA(
 	struct ieee80211_device  *ieee,
 	u8		         *dst,
-	PBA_RECORD		 pBA,
+	struct ba_record         *pBA,
 	enum tr_select		 TxRxSelect,
 	u16			 ReasonCode
 	)
@@ -243,12 +243,12 @@ static struct sk_buff *ieee80211_DELBA(
 /********************************************************************************************************************
  *function: send ADDBAReq frame out
  *   input:  u8*		dst	//ADDBAReq frame's destination
- *	     PBA_RECORD		pBA	//BA_RECORD entry which stores the necessary information for BA
+ *	     struct ba_record  *pBA	//BA_RECORD entry which stores the necessary information for BA
  *  output:  none
  *  notice: If any possible, please hide pBA in ieee. And temporarily use Manage Queue as softmac_mgmt_xmit() usually does
  ********************************************************************************************************************/
 static void ieee80211_send_ADDBAReq(struct ieee80211_device *ieee,
-				    u8 *dst, PBA_RECORD pBA)
+				    u8 *dst, struct ba_record *pBA)
 {
 	struct sk_buff *skb;
 	skb = ieee80211_ADDBA(ieee, dst, pBA, 0, ACT_ADDBAREQ); //construct ACT_ADDBAREQ frames so set statuscode zero.
@@ -266,13 +266,13 @@ static void ieee80211_send_ADDBAReq(struct ieee80211_device *ieee,
 /********************************************************************************************************************
  *function: send ADDBARSP frame out
  *   input:  u8*		dst	//DELBA frame's destination
- *	     PBA_RECORD		pBA	//BA_RECORD entry which stores the necessary information for BA
+ *	     struct ba_record  *pBA	//BA_RECORD entry which stores the necessary information for BA
  *	     u16		StatusCode //RSP StatusCode
  *  output:  none
  *  notice: If any possible, please hide pBA in ieee. And temporarily use Manage Queue as softmac_mgmt_xmit() usually does
  ********************************************************************************************************************/
 static void ieee80211_send_ADDBARsp(struct ieee80211_device *ieee, u8 *dst,
-				    PBA_RECORD pBA, u16 StatusCode)
+				    struct ba_record *pBA, u16 StatusCode)
 {
 	struct sk_buff *skb;
 	skb = ieee80211_ADDBA(ieee, dst, pBA, StatusCode, ACT_ADDBARSP); //construct ACT_ADDBARSP frames
@@ -289,7 +289,7 @@ static void ieee80211_send_ADDBARsp(struct ieee80211_device *ieee, u8 *dst,
 /********************************************************************************************************************
  *function: send ADDBARSP frame out
  *   input:  u8*		dst	//DELBA frame's destination
- *	     PBA_RECORD		pBA	//BA_RECORD entry which stores the necessary information for BA
+ *	     struct ba_record  *pBA	//BA_RECORD entry which stores the necessary information for BA
  *	     enum tr_select     TxRxSelect //TX or RX
  *	     u16		ReasonCode //DEL ReasonCode
  *  output:  none
@@ -297,7 +297,7 @@ static void ieee80211_send_ADDBARsp(struct ieee80211_device *ieee, u8 *dst,
  ********************************************************************************************************************/
 
 static void ieee80211_send_DELBA(struct ieee80211_device *ieee, u8 *dst,
-				 PBA_RECORD pBA, enum tr_select TxRxSelect,
+				 struct ba_record *pBA, enum tr_select TxRxSelect,
 				 u16 ReasonCode)
 {
 	struct sk_buff *skb;
@@ -321,7 +321,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	 struct rtl_80211_hdr_3addr *req = NULL;
 	u16 rc = 0;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
-	PBA_RECORD pBA = NULL;
+	struct ba_record *pBA = NULL;
 	union ba_param_set     *pBaParamSet = NULL;
 	u16 *pBaTimeoutVal = NULL;
 	union sequence_control *pBaStartSeqCtrl = NULL;
@@ -399,7 +399,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 
 OnADDBAReq_Fail:
 	{
-		BA_RECORD	BA;
+		struct ba_record	BA;
 		BA.BaParamSet = *pBaParamSet;
 		BA.BaTimeoutValue = *pBaTimeoutVal;
 		BA.DialogToken = *pDialogToken;
@@ -419,7 +419,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 {
 	 struct rtl_80211_hdr_3addr *rsp = NULL;
-	PBA_RECORD		pPendingBA, pAdmittedBA;
+	struct ba_record        *pPendingBA, *pAdmittedBA;
 	struct tx_ts_record     *pTS = NULL;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
 	u16 *pStatusCode = NULL, *pBaTimeoutVal = NULL;
@@ -526,7 +526,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 
 OnADDBARsp_Reject:
 	{
-		BA_RECORD	BA;
+		struct ba_record	BA;
 		BA.BaParamSet = *pBaParamSet;
 		ieee80211_send_DELBA(ieee, dst, &BA, TX_DIR, ReasonCode);
 		return 0;
@@ -615,7 +615,7 @@ TsInitAddBA(
 	u8		bOverwritePending
 	)
 {
-	PBA_RECORD			pBA = &pTS->tx_pending_ba_record;
+	struct ba_record *pBA = &pTS->tx_pending_ba_record;
 
 	if (pBA->bValid && !bOverwritePending)
 		return;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 924d4b373099..7ed140009760 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -78,8 +78,8 @@ struct ts_common_info {
 struct tx_ts_record {
 	struct ts_common_info		ts_common_info;
 	u16				tx_cur_seq;
-	BA_RECORD			tx_pending_ba_record;
-	BA_RECORD			tx_admitted_ba_record;
+	struct ba_record		tx_pending_ba_record;
+	struct ba_record		tx_admitted_ba_record;
 	u8				add_ba_req_in_progress;
 	u8				add_ba_req_delayed;
 	u8				using_ba;
@@ -93,7 +93,7 @@ struct rx_ts_record {
 	u16				rx_timeout_indicate_seq;
 	struct list_head		rx_pending_pkt_list;
 	struct timer_list		rx_pkt_pending_timer;
-	BA_RECORD			rx_admitted_ba_record;
+	struct ba_record		rx_admitted_ba_record;
 	u16				rx_last_seq_num;
 	u8				rx_last_frag_num;
 	u8				num;
-- 
2.18.0

