Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333170-5-8293394579617410777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333169; b=VstbDZbPi0WyqdWA7nFM/UwJrU+L2/PBNo47fu/gCWzXpf0uwd
    ErTZPIBewW3nXsu+6XsDqG1LOT+VXxgVjU0XUPz8YKWYdHqD8YC0/ChJnq2BKTb7
    CWEscvQ/UOsp2rn9UU9LkGK2sSIxtwyR+M4YsYu7OH2jrr+oK7KbkXpwV1ihKEky
    PqTzaU88qaVTZph1snfo8egf4lHicOqJmVa2q0b6QFlhrWq1d9RiOHQQ7Gzmp001
    6l0vugzxGhxgKSgHXcdDBDrKs8AzDxzpwgwL0w7HMf6FJtfCbEMzxJwDHTSLhxU7
    cjm6Btsxwg5Pl5xvusBlTJZM6JRzU9IjgcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333169; bh=MG9LX
    54QpkkpJnHd7zSCPGeWz/BtoBNHKHMPr5tdF0w=; b=M7wRUL8BSvy7SVkWVKaJY
    hdDdTwFLPcjKDul1I6RYimKjW5BlL4NqDUnaIo7OCPLVuOHC1tz2EFaa6AfmJ07G
    LKCtkxcZXFUl+9OocBXzHe+yxz1Cy9eqmaB283Q9rM/33WsltEjebe5Vmn7KcOnh
    pMsoHSkTZ5AcknBN4yU+2Z7FxiP5vgjHVrJ+/kSYk2KkKwqUe+lQpgkP6NvJeMvM
    subTY+Nmg70FQ3RtC9x8TBL8P9qlVxZ9P15DBP4L9yKKeGSnTe1jlpUfE/cUYGC5
    ZUHeBtx1yV/aJ8idSNGgf2jyWr4USae5GZBTnxtMeT/0cq6H9E/d8Rw5dcVLXq92
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=OQFX3u8E x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Obo8sZJj;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=OQFX3u8E x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Obo8sZJj;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPuXJrY8tc3Uxm3mNEMQYEZD8voEspxNf6XytPmOuGV2wLObXshNcorD9e5jjdhQf/J6D1VY5dPfhFrsJf5AFNNYGCzpEOfs1uvAVxGttuhFHgL58R6S
    mzmYfOQIu7iqvHvN4YjvCiAOzO/ttvOagsM/eH9Tm+EdbCLLLskXVuWBMHM58+TueqdkJftYSJSD6ErDyVUt2y1HWwg+sI9/VA4rnROiKwIf+ZUlIv562u8i
    UpJVQLZTuvJn53PizcPt6w==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=kU4s23jLbwnobF-mIQwA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqsD/KbdC0RFyMvgehX/XtdCtDNCjoDYKpn2+CHEvEEDB3OhEs8341Twbz+I6Z3wEcxLG1tBw==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 19/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 removed extra blank lines
Date: Mon, 14 May 2018 22:24:26 +0100
Message-Id: <20180514212434.17514-20-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514212434.17514-1-johnfwhitmore@gmail.com>
References: <20180514212434.17514-1-johnfwhitmore@gmail.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: kstewart@linuxfoundation.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>,
 colin.king@canonical.com, tglx@linutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Coding style edit to clear the checkpatch.pl check:
CHECK: Please don't use multiple blank lines

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 24 ----------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index b138057c619e..b076ff66bc8f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -266,7 +266,6 @@ u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
 }
 
-
 u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -321,8 +320,6 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 	}
 }
 
-
-
 bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
@@ -401,7 +398,6 @@ static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 	return 0;
 }
 
-
 /**
  * Function:	HTIOTActIsDisableMCS15
  *
@@ -514,7 +510,6 @@ void HTResetIOTSetting(
 	pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
 }
 
-
 /*******************************************************************************
  *function:  Construct Capablility Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
@@ -546,7 +541,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
 
-
 	//HT capability info
 	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
@@ -569,7 +563,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
-
 	//MAC HT parameters info
 	// TODO: Nedd to take care of this part
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n", pCapELE->ChlWidth, pCapELE->MaxAMSDUSize, pCapELE->DssCCk);
@@ -605,7 +598,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//Extended HT Capability Info
 	memset(&pCapELE->ExtHTCapInfo, 0, 2);
 
-
 	//TXBF Capabilities
 	memset(pCapELE->TxBFCap, 0, 4);
 
@@ -617,8 +609,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	else
 		*len = 26 + 2;
 
-
-
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, posHTCap, *len -2);
 
 	//Print each field in detail. Driver should not print out this message by default
@@ -667,7 +657,6 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 
 		memset(pHTInfoEle->BasicMSC, 0, 16);
 
-
 		*len = 22 + 2; //same above
 
 	} else {
@@ -745,7 +734,6 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 #endif
 }
 
-
 /*******************************************************************************
  *function:  Pick the right Rate Adaptive table to use
  *   input:  struct ieee80211_device*	ieee
@@ -851,8 +839,6 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	return (mcsRate|0x80);
 }
 
-
-
 /*
  *
  * 1.Filter our operation rate set with AP's rate set
@@ -924,7 +910,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	else
 		pPeerHTInfo = (PHT_INFORMATION_ELE)(pHTInfo->PeerHTInfoBuf);
 
-
 	////////////////////////////////////////////////////////
 	// Configurations:
 	////////////////////////////////////////////////////////
@@ -957,7 +942,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	pHTInfo->bCurSuppCCK = pHTInfo->bRegSuppCCK &&
 			       (pPeerHTCap->DssCCk == 1);
 
-
 	//
 	// Config and configure A-MSDU setting
 	//
@@ -970,7 +954,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	else
 		pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
 
-
 	//
 	// Config A-MPDU setting
 	//
@@ -1102,8 +1085,6 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
-
-
 	// Initialize all of the parameters related to 11n
 	memset((void *)(&(pHTInfo->SelfHTCap)), 0, sizeof(pHTInfo->SelfHTCap));
 	memset((void *)(&(pHTInfo->SelfHTInfo)), 0, sizeof(pHTInfo->SelfHTInfo));
@@ -1216,7 +1197,6 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_ALL_2SS;
 
-
 		bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
@@ -1228,8 +1208,6 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 		bIOTAction = HTIOTActIsCCDFsync(pNetwork->bssid);
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_CDD_FSYNC;
-
-
 	} else {
 		pHTInfo->bCurrentHTSupport = false;
 		pHTInfo->bCurrentRT2RTAggregation = false;
@@ -1290,8 +1268,6 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 	if (!pHTInfo->bRegBW40MHz)
 		return;
 
-
-
 	// To reduce dummy operation
 //	if((pHTInfo->bCurBW40MHz==false && Bandwidth==HT_CHANNEL_WIDTH_20) ||
 //	   (pHTInfo->bCurBW40MHz==true && Bandwidth==HT_CHANNEL_WIDTH_20_40 && Offset==pHTInfo->CurSTAExtChnlOffset))
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
