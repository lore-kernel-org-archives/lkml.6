Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-995127-1526313260-2-5677704464906382133
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313258; b=DHdgfFWCzjprFAKBLK04VuR475HGA9Fh0d+vNEWqeHVHLUzhu3
    UsxOiKMFA2Rnj9HMfdYEw7hEnRxDf1xrKcbWuaxelTLLkcbwXXjbL2FBMxGkBc3x
    Ae9rO6I9vhNpWw7bSeFWAM2RyAagn+L8Fs1aYFrw/ki/Y4UqgnN0aPXsnG8l30P1
    OI7ulez8UYCWc5Na2CJxxLBsVoJfxBiKpM7pHKZ0fZIP8azhWRzg//Wq5IpVKBCC
    9N2AkiL0RCp94t95Uv0ThZLxNpRZF7QoCghTSlmPs3e3zfdq71Sr4uXC74EDX1Fm
    BiI/a4mRM5VpPoa1L4ulRgMQgSMGhKVRV7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313258; bh=uK2hm
    OErXQbctxuI5b7uyMDZMuEE/oqt7/DUsyjNtLE=; b=chWFmOsLhrjEVQnpHNk2S
    vjgo2Hp1btlaqQ0Dum2fw/HpO0iB4DH+FMm8apwEuCgYhXBxAXGHypzhS4ws53sU
    x+c3nrHCXo9TdnkO23n/4TalDt4t7bp1xehJiAItswIrsWbBIbMrrvQS+ChZfLpN
    8IeD93IBbFV9FL8epz9SbqUeElzfp1v2AOrplacjFcJcpZoA1pn4zJ/WGsH5LWok
    hrLzIR1cnuCIgFJ9ZTiSmQOja5Gq828YNJJFURtw60Zt3dPN3a54g3D56184+4Q/
    SjyR45p1VvpEHiDojVIOH9j789F9TuDUq2QcT+bAIGjRKnwt+9cT/M6UZaN73ydS
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=MSrSL7Cp x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=quk4OKqy;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=MSrSL7Cp x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=quk4OKqy;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMz/ctzuqv4aGJue2zTg6n2ZbR+0Ig/d4/tcEzZSDU5KM6GHGNtbp4xFp2VZqNY6/RI66JKVmEVeeuJdQGzu5lsHsmGIuEwSD5EdoWxUtlD7RObHvFDd
    r3LAriJnDswOCAh+yrkbs0mMWlIBM6Ghvdxp3lL5UiB7rjhH3rgi8/ksW6olr9rvXlIpMXRiUznEaxGFfGnN/uU9qllZkVix7Gj9mJOsJ1FaQlw3ApXeBKCC
    VhBgf5/kSKrHlU119k/npw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=w-Pq0yr92I_JpWMH6doA:9
    a=Kdc8TZ3mODV13Xjr:21 a=2u4L7DV1LUTpWwWU:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqV4fVMOLJBpyryqiV5KlKZg31HYMF3Bsvdp+FAvCJTPPIT2LIR0edohF75ITUFCNueW7PLyA==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 01/13] Coding style changes to block comments
Date: Mon, 14 May 2018 16:53:06 +0100
Message-Id: <20180514155318.32195-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514155318.32195-1-johnfwhitmore@gmail.com>
References: <20180514155318.32195-1-johnfwhitmore@gmail.com>
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
 linux-kernel@vger.kernel.org, johnfwhitmore@gmail.com,
 colin.king@canonical.com, tglx@linutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The file drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c has a lot of
coding style issues, this will be the first of many small patches which clear
up some, if not all, of the problems with the file.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 319 ++++++++++++---------
 1 file changed, 183 insertions(+), 136 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index bf7b7122d042..17a720966253 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -42,16 +42,19 @@ static u8 AIRLINK_RALINK[3] = {0x00, 0x18, 0x02};
 //static u8 DLINK_ATHEROS[3] = {0x00, 0x1c, 0xf0};
 static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
 
-// 2008/04/01 MH For Cisco G mode RX TP We need to change FW duration. Should we put the
-// code in other place??
-//static u8 WIFI_CISCO_G_AP[3] = {0x00, 0x40, 0x96};
-/********************************************************************************************************************
+/*
+ * 2008/04/01 MH For Cisco G mode RX TP We need to change FW duration. Should we
+ * put the code in other place?? 
+ * static u8 WIFI_CISCO_G_AP[3] = {0x00, 0x40, 0x96};
+ */
+/*******************************************************************************
  *function:  This function update default settings in pHTInfo structure
  *   input:  PRT_HIGH_THROUGHPUT	pHTInfo
  *  output:  none
  *  return:  none
  *  notice:  These value need be modified if any changes.
- * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -114,14 +117,17 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 
 
 }
-/********************************************************************************************************************
- *function:  This function print out each field on HT capability IE mainly from (Beacon/ProbeRsp/AssocReq)
+
+/*******************************************************************************
+ *function:  This function print out each field on HT capability IE mainly 
+ *           from (Beacon/ProbeRsp/AssocReq)
  *   input:  u8*	CapIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
  *  output:  none
  *  return:  none
  *  notice:  Driver should not print out this message by default.
- * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
 {
 
@@ -151,14 +157,17 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
 	return;
 
 }
-/********************************************************************************************************************
- *function:  This function print out each field on HT Information IE mainly from (Beacon/ProbeRsp)
+
+/*******************************************************************************
+ *function:  This function print out each field on HT Information IE mainly 
+ *           from (Beacon/ProbeRsp)
  *   input:  u8*	InfoIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
  *  output:  none
  *  return:  none
  *  notice:  Driver should not print out this message by default.
- * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 {
 
@@ -218,8 +227,8 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 }
 
 /*
-*	Return:		true if station in half n mode and AP supports 40 bw
-*/
+ *	Return:		true if station in half n mode and AP supports 40 bw
+ */
 static bool IsHTHalfNmode40Bandwidth(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
@@ -290,14 +299,15 @@ u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
 }
 
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  This function returns current datarate.
  *   input:  struct ieee80211_device*	ieee
  *	     u8				nDataRate
  *  output:  none
  *  return:  tx rate
  *  notice:  quite unsure about how to use this function //wb
- * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 {
 	//PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -370,13 +380,14 @@ bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 	return retValue;
 }
 
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  This function returns peer IOT.
  *   input:  struct ieee80211_device*	ieee
  *  output:  none
  *  return:
  *  notice:
- * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -406,14 +417,16 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 
 	IEEE80211_DEBUG(IEEE80211_DL_IOT, "Joseph debug!! IOTPEER: %x\n", pHTInfo->IOTPeer);
 }
-/********************************************************************************************************************
- *function:  Check whether driver should declare received rate up to MCS13 only since some chipset is not good
- *	     at receiving MCS14~15 frame from some AP.
+/*******************************************************************************
+ *function:  Check whether driver should declare received rate up to MCS13 only
+ *           since some chipset is not good at receiving MCS14~15 frame from
+ *           some AP.
  *   input:  struct ieee80211_device*	ieee
  *	     u8 *			PeerMacAddr
  *  output:  none
  *  return:  return 1 if driver should declare MCS13 only(otherwise return 0)
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 {
 	return 0;
@@ -421,17 +434,17 @@ static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 
 
 /**
-* Function:	HTIOTActIsDisableMCS15
-*
-* Overview:	Check whether driver should declare capability of receiving MCS15
-*
-* Input:
-*			PADAPTER		Adapter,
-*
-* Output:		None
-* Return:	true if driver should disable MCS15
-* 2008.04.15	Emily
-*/
+ * Function:	HTIOTActIsDisableMCS15
+ *
+ * Overview:	Check whether driver should declare capability of receiving MCS15
+ *
+ * Input:
+ *			PADAPTER		Adapter,
+ *
+ * Output:		None
+ * Return:	true if driver should disable MCS15
+ * 2008.04.15	Emily
+ */
 static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
 {
 	bool retValue = false;
@@ -458,17 +471,18 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
 }
 
 /**
-* Function:	HTIOTActIsDisableMCSTwoSpatialStream
-*
-* Overview:	Check whether driver should declare capability of receiving All 2 ss packets
-*
-* Input:
-*			PADAPTER		Adapter,
-*
-* Output:		None
-* Return:	true if driver should disable all two spatial stream packet
-* 2008.04.21	Emily
-*/
+ * Function:	HTIOTActIsDisableMCSTwoSpatialStream
+ *
+ * Overview:	Check whether driver should declare capability of receiving
+ *               All 2 ss packets
+ *
+ * Input:
+ *			PADAPTER		Adapter,
+ *
+ * Output:		None
+ * Return:	true if driver should disable all two spatial stream packet
+ * 2008.04.21	Emily
+ */
 static bool HTIOTActIsDisableMCSTwoSpatialStream(struct ieee80211_device *ieee,
 						 u8 *PeerMacAddr)
 {
@@ -478,25 +492,29 @@ static bool HTIOTActIsDisableMCSTwoSpatialStream(struct ieee80211_device *ieee,
 	return false;
 }
 
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  Check whether driver should disable EDCA turbo mode
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			PeerMacAddr
  *  output:  none
- *  return:  return 1 if driver should disable EDCA turbo mode(otherwise return 0)
-  * *****************************************************************************************************************/
+ *  return:  return 1 if driver should disable EDCA turbo mode
+ *                    (otherwise return 0)
+ *******************************************************************************
+ */
 static u8 HTIOTActIsDisableEDCATurbo(struct ieee80211_device *ieee,
 				     u8 *PeerMacAddr)
 {	/* default enable EDCA Turbo mode. */
 	return false;
 }
 
-/********************************************************************************************************************
- *function:  Check whether we need to use OFDM to sned MGNT frame for broadcom AP
+/*******************************************************************************
+ *function:  Check whether we need to use OFDM to sned MGNT frame for 
+ *           broadcom AP
  *   input:  struct ieee80211_network *network   //current network we live
  *  output:  none
  *  return:  return 1 if true
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 {
 	u8	retValue = 0;
@@ -533,8 +551,7 @@ void HTResetIOTSetting(
 	pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
 }
 
-
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  Construct Capablility Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			posHTCap //pointer to store Capability Ele
@@ -543,7 +560,8 @@ void HTResetIOTSetting(
  *  output:  none
  *  return:  none
  *  notice:  posHTCap can't be null and should be initialized before.
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u8 *len, u8 IsEncrypt)
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
@@ -652,16 +670,20 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	return;
 
 }
-/********************************************************************************************************************
- *function:  Construct  Information Element in Beacon... if HTEnable is turned on
+
+/*******************************************************************************
+ *function:  Construct  Information Element in Beacon... if HTEnable is
+ *           turned on
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			posHTCap //pointer to store Information Ele
  *	     u8*			len   //store len of
  *	     u8				IsEncrypt //whether encrypt, needed further
  *  output:  none
  *  return:  none
- *  notice:  posHTCap can't be null and be initialized before. only AP and IBSS sta should do this
-  * *****************************************************************************************************************/
+ *  notice:  posHTCap can't be null and be initialized before.
+ *           Only AP and IBSS sta should do this
+ *******************************************************************************
+ */
 void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *len, u8 IsEncrypt)
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
@@ -708,24 +730,25 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 }
 
 /*
-  *  According to experiment, Realtek AP to STA (based on rtl8190) may achieve best performance
-  *  if both STA and AP set limitation of aggregation size to 32K, that is, set AMPDU density to 2
-  *  (Ref: IEEE 11n specification). However, if Realtek STA associates to other AP, STA should set
-  *  limitation of aggregation size to 8K, otherwise, performance of traffic stream from STA to AP
-  *  will be much less than the traffic stream from AP to STA if both of the stream runs concurrently
-  *  at the same time.
-  *
-  *  Frame Format
-  *  Element ID		Length		OUI			Type1		Reserved
-  *  1 byte			1 byte		3 bytes		1 byte		1 byte
-  *
-  *  OUI		= 0x00, 0xe0, 0x4c,
-  *  Type	= 0x02
-  *  Reserved	= 0x00
-  *
-  *  2007.8.21 by Emily
-*/
-/********************************************************************************************************************
+ * According to experiment, Realtek AP to STA (based on rtl8190) may achieve
+ * best performance if both STA and AP set limitation of aggregation size to
+ * 32K, that is, set AMPDU density to 2 (Ref: IEEE 11n specification).
+ * However, if Realtek STA associates to other AP, STA should set limitation of
+ * aggregation size to 8K, otherwise, performance of traffic stream from STA to
+ * AP will be much less than the traffic stream from AP to STA if both of the
+ * stream runs concurrently at the same time.
+ *
+ *  Frame Format
+ *  Element ID		Length		OUI		Type1		Reserved
+ *  1 byte		1 byte		3 bytes		1 byte		1 byte
+ *
+ *  OUI		= 0x00, 0xe0, 0x4c,
+ *  Type	= 0x02
+ *  Reserved	= 0x00
+ *
+ *  2007.8.21 by Emily
+ */
+/*******************************************************************************
  *function:  Construct  Information Element in Beacon... in RT2RT condition
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			posRT2RTAgg //pointer to store Information Ele
@@ -733,7 +756,8 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
  *  output:  none
  *  return:  none
  *  notice:
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
 	if (posRT2RTAgg == NULL) {
@@ -780,14 +804,14 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 
 }
 
-
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  Pick the right Rate Adaptive table to use
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			pOperateMCS //A pointer to MCS rate bitmap
  *  return:  always we return true
  *  notice:
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	u8					i;
@@ -833,24 +857,25 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 }
 
 /*
-*	Description:
-*		This function will get the highest speed rate in input MCS set.
-*
-*	/param	Adapter			Pionter to Adapter entity
-*			pMCSRateSet		Pointer to MCS rate bitmap
-*			pMCSFilter		Pointer to MCS rate filter
-*
-*	/return	Highest MCS rate included in pMCSRateSet and filtered by pMCSFilter.
-*
-*/
-/********************************************************************************************************************
+ *	Description:
+ *		This function will get the highest speed rate in input MCS set.
+ *
+ *	/param	Adapter			Pionter to Adapter entity
+ *			pMCSRateSet		Pointer to MCS rate bitmap
+ *			pMCSFilter		Pointer to MCS rate filter
+ *
+ *	/return	Highest MCS rate included in pMCSRateSet and filtered by pMCSFilter.
+ *
+ */
+/*******************************************************************************
  *function:  This function will get the highest speed rate in input MCS set.
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			pMCSRateSet //Pointer to MCS rate bitmap
  *	     u8*			pMCSFilter //Pointer to MCS rate filter
  *  return:  Highest MCS rate included in pMCSRateSet and filtered by pMCSFilter
  *  notice:
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSFilter)
 {
 	u8		i, j;
@@ -895,14 +920,14 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 
 
 /*
-**
-**1.Filter our operation rate set with AP's rate set
-**2.shall reference channel bandwidth, STBC, Antenna number
-**3.generate rate adative table for firmware
-**David 20060906
-**
-** \pHTSupportedCap: the connected STA's supported rate Capability element
-*/
+ *
+ *1.Filter our operation rate set with AP's rate set
+ *2.shall reference channel bandwidth, STBC, Antenna number
+ *3.generate rate adative table for firmware
+ *David 20060906
+ *
+ * \pHTSupportedCap: the connected STA's supported rate Capability element
+ */
 static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
@@ -917,18 +942,21 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
 
-	// TODO: fill suggested rate adaptive rate index and give firmware info using Tx command packet
-	// we also shall suggested the first start rate set according to our singal strength
+	/*
+	 * TODO: fill suggested rate adaptive rate index and give firmware info
+	 * using Tx command packet we also shall suggested the first start rate
+	 * set according to our singal strength
+	 */
 	HT_PickMCSRate(ieee, pOperateMCS);
 
 	// For RTL819X, if pairwisekey = wep/tkip, we support only MCS0~7.
 	if(ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pOperateMCS[1] = 0;
 
-	//
-	// For RTL819X, we support only MCS0~15.
-	// And also, we do not know how to use MCS32 now.
-	//
+	/*
+	 * For RTL819X, we support only MCS0~15.
+	 * And also, we do not know how to use MCS32 now.
+	 */
 	for(i=2; i<=15; i++)
 		pOperateMCS[i] = 0;
 
@@ -1075,14 +1103,17 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	// Rx Reorder Setting
 	pHTInfo->bCurRxReorderEnable = pHTInfo->bRegRxReorderEnable;
 
-	//
-	// Filter out unsupported HT rate for this AP
-	// Update RATR table
-	// This is only for 8190 ,8192 or later product which using firmware to handle rate adaptive mechanism.
-	//
+	/*
+	 * Filter out unsupported HT rate for this AP
+	 * Update RATR table
+	 * This is only for 8190 ,8192 or later product which using firmware to
+	 * handle rate adaptive mechanism.
+	 */
 
-	// Handle Ralink AP bad MCS rate set condition. Joseph.
-	// This fix the bug of Ralink AP. This may be removed in the future.
+	/*
+	 * Handle Ralink AP bad MCS rate set condition. Joseph.
+	 * This fix the bug of Ralink AP. This may be removed in the future.
+	 */
 	if(pPeerHTCap->MCS[0] == 0)
 		pPeerHTCap->MCS[0] = 0xff;
 
@@ -1111,21 +1142,24 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 }
 
 void HTSetConnectBwModeCallback(struct ieee80211_device *ieee);
-/********************************************************************************************************************
+
+/*******************************************************************************
  *function:  initialize HT info(struct PRT_HIGH_THROUGHPUT)
  *   input:  struct ieee80211_device*	ieee
  *  output:  none
  *  return:  none
- *  notice: This function is called when *  (1) MPInitialization Phase *  (2) Receiving of Deauthentication from AP
-********************************************************************************************************************/
+ *  notice: This function is called when *  (1) MPInitialization Phase
+ *                                       *  (2) Receiving of Deauthentication from AP
+ *******************************************************************************
+ */
 // TODO: Should this funciton be called when receiving of Disassociation?
 void HTInitializeHTInfo(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
 
-	//
-	// These parameters will be reset when receiving deauthentication packet
-	//
+	/*
+	 * These parameters will be reset when receiving deauthentication packet
+	 */
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "===========>%s()\n", __func__);
 	pHTInfo->bCurrentHTSupport = false;
 
@@ -1138,10 +1172,12 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	pHTInfo->bCurShortGI40MHz = false;
 	pHTInfo->bForcedShortGI = false;
 
-	// CCK rate support
-	// This flag is set to true to support CCK rate by default.
-	// It will be affected by "pHTInfo->bRegSuppCCK" and AP capabilities only when associate to
-	// 11N BSS.
+	/*
+	 * CCK rate support
+	 * This flag is set to true to support CCK rate by default.
+	 * It will be affected by "pHTInfo->bRegSuppCCK" and AP capabilities
+	 * only when associate to 11N BSS.
+	 */
 	pHTInfo->bCurSuppCCK = true;
 
 	// AMSDU related
@@ -1180,13 +1216,15 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 		RegHTSuppRateSets[4] = 0x01;	//support MCS 32
 	}
 }
-/********************************************************************************************************************
+
+/*******************************************************************************
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  PBSS_HT pBssHT //to be initialized
  *  output:  none
  *  return:  none
  *  notice: This function is called when initialize network structure
-********************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTInitializeBssDesc(PBSS_HT pBssHT)
 {
 
@@ -1201,14 +1239,17 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 	pBssHT->bdRT2RTAggregation = false;
 	pBssHT->bdRT2RTLongSlotTime = false;
 }
-/********************************************************************************************************************
+
+/*******************************************************************************
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  struct ieee80211_device	*ieee
- *	     struct ieee80211_network	*pNetwork //usually current network we are live in
+ *	     struct ieee80211_network	*pNetwork //usually current network we
+ *                                                  are live in
  *  output:  none
  *  return:  none
  *  notice: This function should ONLY be called before association
-********************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee80211_network *pNetwork)
 {
 	PRT_HIGH_THROUGHPUT		pHTInfo = ieee->pHTInfo;
@@ -1222,7 +1263,10 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 	//  Save Peer Setting before Association
 	//
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "==============>%s()\n", __func__);
-	/*unmark bEnableHT flag here is the same reason why unmarked in function ieee80211_softmac_new_net. WB 2008.09.10*/
+	/*
+	 * unmark bEnableHT flag here is the same reason why unmarked in
+	 * function ieee80211_softmac_new_net. WB 2008.09.10
+	 */
 //	if( pHTInfo->bEnableHT &&  pNetwork->bssht.bdSupportHT)
 	if (pNetwork->bssht.bdSupportHT)
 	{
@@ -1313,14 +1357,15 @@ void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct ieee80211_
 }
 EXPORT_SYMBOL(HTUpdateSelfAndPeerSetting);
 
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  check whether HT control field exists
  *   input:  struct ieee80211_device	*ieee
  *	     u8*			pFrame //coming skb->data
  *  output:  none
  *  return:  return true if HT control field exists(false otherwise)
  *  notice:
-********************************************************************************************************************/
+ *******************************************************************************
+ */
 u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame)
 {
 	if (ieee->pHTInfo->bCurrentHTSupport)
@@ -1333,9 +1378,9 @@ u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame)
 	return false;
 }
 
-//
-// This function set bandwidth mode in protocol layer.
-//
+/*
+ * This function set bandwidth mode in protocol layer.
+ */
 void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidth, HT_EXTCHNL_OFFSET	Offset)
 {
 	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
@@ -1376,10 +1421,12 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 
 	pHTInfo->bSwBwInProgress = true;
 
-	// TODO: 2007.7.13 by Emily Wait 2000ms  in order to guarantee that switching
-	//   bandwidth is executed after scan is finished. It is a temporal solution
-	//   because software should ganrantee the last operation of switching bandwidth
-	//   is executed properlly.
+	/*
+	 * TODO: 2007.7.13 by Emily Wait 2000ms  in order to guarantee that
+	 * switching bandwidth is executed after scan is finished. It is a
+	 * temporal solution because software should ganrantee the last
+	 * operation of switching bandwidth executed properlly.
+	 */
 	HTSetConnectBwModeCallback(ieee);
 
 //	spin_unlock_irqrestore(&(ieee->bw_spinlock), flags);
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
