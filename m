Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333149-2-5456880900567732890
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
    1526333148; b=lBuJguQXG9Ee0EuqBLunZ880VHDfR4Cq/Z0yEdKso+88Y4uuTJ
    Oy5VdVPD6/xdfaz+rJhN1aNdeVYMbSAFbj14NjMOtlcmZSnawEWaNEkYIZqHoaUz
    N41vFciWzL73kAbm9dKjFBGdYnYU02yD6wSE9EdFQwb5vDVbJQJEMvozuln8Wb0g
    /q7YUegylbrxx29zaquL9xVs66FBDIRiMQhQcKftgOsheGgGOLre7qZkRrD7G4sk
    alqrj6uzXqz1Rl2J02TmB7WJfpoZtIjqOz4RDKv58phXcSrNEm4NLh2Uf4F6JMFA
    iMdvMKSdEnT7NmCHIAYUn3ktcsSFOtk40f3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333148; bh=LCgfB
    gy6ABVcyRwF8XP3d+8RjkDMXarw6B5tOpsloTI=; b=FDm20KXFJNmo4Ovz89dby
    sMkDqWuOu/Ifj+QhLs6ItGCwcTuTDQVkZ4NcLc0lewqXugvW3VSgXDqL9voYE589
    rNXB51Nfoap6F3mX44Br9zDZIZJPCKxL9HRIJ0iCK3I/MSKkCXX/VKsgWfpGH8EW
    mpE4/AT/Uw60WTVCrU+jM/jySLXCcCQ/3Dx7KkEcM3dUOCEomp2rIx82pP6hEhIe
    yNHnXi1rYDIGNriHvHsN8zo8NKMTzZujGl4f5lIQe2uRsqMQfhGhyw9F1e9mfFpx
    oSZGsPLAkYZs3Ykh+Vc5V2BBc8y6WZM5rlfWJeW40TND0mlk0bkfsocfdg5l7YQO
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=SX0bgKnP x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=OWyXmmdI;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=SX0bgKnP x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=OWyXmmdI;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCce2iF8DY/9/m5Ia6Tvcet+EBejc36g9+ScCahjnPOqlmT5tzZnyNxGxbRnXwi946dH3JrHkJ3MOA4zlVvjiJNlRknL1gPDvjSoD1oNdpNmnkKCuruH
    SDHGymZEPaJqZ31RgRGcPF4qLDzvkmwHTFl+1mHs06zcnagyH6Y3ylwWoPceWNnf0yMbKC3/SQNZRkPfPusBR2TGVvt0oj5ckvJaHUNE0VK26IW31dSyp7qE
    AJ/xmvepEkU54v7apypWmQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=Zt7nXTidsx-yj1oeEZUA:9
    a=dOX2qpOmrHTmZWh1:21 a=m6gOZSlYCCSSkGTR:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZr2tHkReMIgdq4f9oQUZZsKFfE8AVCDzwT+bCQrGPMCMVsO4QSV7Xhxi74PIF6jlJi/cbRDUA==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 11/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 corrected block comments
Date: Mon, 14 May 2018 22:24:18 +0100
Message-Id: <20180514212434.17514-12-johnfwhitmore@gmail.com>
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

Coding style edit to clear the checkpatch.pl Warnings:
WARNING: Block comments should align the * on each line

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 181 +++++++++++----------
 1 file changed, 97 insertions(+), 84 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 3342c9ccec3f..425ea1279b87 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -213,8 +213,8 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 }
 
 /*
-*	Return:		true if station in half n mode and AP supports 40 bw
-*/
+ *	Return:		true if station in half n mode and AP supports 40 bw
+ */
 static bool IsHTHalfNmode40Bandwidth(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
@@ -390,14 +390,15 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 
 	IEEE80211_DEBUG(IEEE80211_DL_IOT, "Joseph debug!! IOTPEER: %x\n", pHTInfo->IOTPeer);
 }
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  Check whether driver should declare received rate up to MCS13 only since some chipset is not good
  *	     at receiving MCS14~15 frame from some AP.
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
@@ -405,17 +406,17 @@ static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 
 
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
@@ -442,17 +443,17 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
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
+ * Overview:	Check whether driver should declare capability of receiving All 2 ss packets
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
@@ -462,25 +463,27 @@ static bool HTIOTActIsDisableMCSTwoSpatialStream(struct ieee80211_device *ieee,
 	return false;
 }
 
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  Check whether driver should disable EDCA turbo mode
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			PeerMacAddr
  *  output:  none
  *  return:  return 1 if driver should disable EDCA turbo mode(otherwise return 0)
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 static u8 HTIOTActIsDisableEDCATurbo(struct ieee80211_device *ieee,
 				     u8 *PeerMacAddr)
 {	/* default enable EDCA Turbo mode. */
 	return false;
 }
 
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  Check whether we need to use OFDM to sned MGNT frame for broadcom AP
  *   input:  struct ieee80211_network *network   //current network we live
  *  output:  none
  *  return:  return 1 if true
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 {
 	u8	retValue = 0;
@@ -515,7 +518,7 @@ void HTResetIOTSetting(
 }
 
 
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  Construct Capablility Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			posHTCap //pointer to store Capability Ele
@@ -524,7 +527,8 @@ void HTResetIOTSetting(
  *  output:  none
  *  return:  none
  *  notice:  posHTCap can't be null and should be initialized before.
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u8 *len, u8 IsEncrypt)
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
@@ -625,7 +629,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	return;
 
 }
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  Construct  Information Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			posHTCap //pointer to store Information Ele
@@ -634,7 +638,8 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
  *  output:  none
  *  return:  none
  *  notice:  posHTCap can't be null and be initialized before. only AP and IBSS sta should do this
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *len, u8 IsEncrypt)
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
@@ -677,24 +682,24 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
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
+ *  According to experiment, Realtek AP to STA (based on rtl8190) may achieve best performance
+ *  if both STA and AP set limitation of aggregation size to 32K, that is, set AMPDU density to 2
+ *  (Ref: IEEE 11n specification). However, if Realtek STA associates to other AP, STA should set
+ *  limitation of aggregation size to 8K, otherwise, performance of traffic stream from STA to AP
+ *  will be much less than the traffic stream from AP to STA if both of the stream runs concurrently
+ *  at the same time.
+ *
+ *  Frame Format
+ *  Element ID		Length		OUI			Type1		Reserved
+ *  1 byte			1 byte		3 bytes		1 byte		1 byte
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
@@ -702,7 +707,8 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
  *  output:  none
  *  return:  none
  *  notice:
-  * *****************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
 	if (posRT2RTAgg == NULL) {
@@ -750,13 +756,14 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 }
 
 
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
@@ -801,24 +808,25 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
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
@@ -858,14 +866,14 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 
 
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
+ * 1.Filter our operation rate set with AP's rate set
+ * 2.shall reference channel bandwidth, STBC, Antenna number
+ * 3.generate rate adative table for firmware
+ * David 20060906
+ *
+ * \pHTSupportedCap: the connected STA's supported rate Capability element
+ */
 static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
@@ -1068,13 +1076,15 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 }
 
 void HTSetConnectBwModeCallback(struct ieee80211_device *ieee);
-/********************************************************************************************************************
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
@@ -1138,13 +1148,14 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 		RegHTSuppRateSets[4] = 0x01;	//support MCS 32
 	}
 }
-/********************************************************************************************************************
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
 
@@ -1159,14 +1170,15 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 	pBssHT->bdRT2RTAggregation = false;
 	pBssHT->bdRT2RTLongSlotTime = false;
 }
-/********************************************************************************************************************
+/*******************************************************************************
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  struct ieee80211_device	*ieee
  *	     struct ieee80211_network	*pNetwork //usually current network we are live in
  *  output:  none
  *  return:  none
  *  notice: This function should ONLY be called before association
-********************************************************************************************************************/
+ *******************************************************************************
+ */
 void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee80211_network *pNetwork)
 {
 	PRT_HIGH_THROUGHPUT		pHTInfo = ieee->pHTInfo;
@@ -1264,14 +1276,15 @@ void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct ieee80211_
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
 	if (ieee->pHTInfo->bCurrentHTSupport) {
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
