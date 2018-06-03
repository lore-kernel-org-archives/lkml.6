Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeFCMFO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:05:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33891 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeFCMFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:05:11 -0400
X-Google-Smtp-Source: ADUXVKJ2N/aSsnSb+Q+yCtmcaoFgeW5cYDLzAEInSpvwwVsscnEjGEc0MMuzvn5Ye+pty6pZ7YXW+Q==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org, colin.king@canonical.com,
        pombredanne@nexb.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v5 7/8] staging: rtl8192e: Optimise Comparison to NULL tests - Coding Style
Date: Sun,  3 Jun 2018 13:04:12 +0100
Message-Id: <20180603120413.13042-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180603120413.13042-1-johnfwhitmore@gmail.com>
References: <20180603120413.13042-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change comparison to NULL to better adhere to coding standard.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 7ea516609d4c..9cca4a8f1cf5 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -520,7 +520,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	PHT_CAPABILITY_ELE	pCapELE = NULL;
 	//u8 bIsDeclareMCS13;
 
-	if ((posHTCap == NULL) || (pHT == NULL)) {
+	if (!posHTCap || !pHT) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in HTConstructCapabilityElement()\n");
 		return;
 	}
@@ -624,7 +624,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
 
-	if ((posHTInfo == NULL) || (pHTInfoEle == NULL)) {
+	if (!posHTInfo || !pHTInfoEle) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
 		return;
 	}
@@ -687,7 +687,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
   * *****************************************************************************************************************/
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
-	if (posRT2RTAgg == NULL) {
+	if (!posRT2RTAgg) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in HTConstructRT2RTAggElement()\n");
 		return;
 	}
@@ -737,7 +737,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	u8					i;
 
-	if (pOperateMCS == NULL) {
+	if (!pOperateMCS) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
 		return false;
 	}
@@ -799,7 +799,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
 
-	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
+	if (!pMCSRateSet || !pMCSFilter) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
 	}
-- 
2.17.0
