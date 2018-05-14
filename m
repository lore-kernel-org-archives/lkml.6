Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333119-2-13780783424396595490
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333118; b=VJoYi8I+8E+HBTYnjxrKZaCLQp8LkfskA3v33qLe4sUvz8NEjo
    4bgv8B+uU7odTL5Blpw0re2NfbIj+AkV6Arc0BG8Hc0OTfx+9LCcGfurM8IORZ33
    7FtsOW083U647vUuIMtChjgeaWGLo+uOKNHuoLCRtfSOOKfLcGIYHz5W4uoxBGZy
    hxK2tiIF3QIAaCRVFP0bzBR3h/298Lld5JBNDxPr/H4NV7LvpB7bTyR/r0pXuQJe
    ccR/KLqIcf+Y78A/nZNr/Rpoz3HOQZZWmNCUbQK9ZdF38AS+cg0Bgr3U4cb7swlt
    bczoJMPl7iZNFxEBbde/k5HMdfo7ROWXKj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333118; bh=0pMDT
    +IH3YphXfnVYZX93ZXAtBiWqCqK5T3W95TEEtA=; b=Zx7Zd8jt7pZ8wXheZUun+
    CBOrsgEZYe0MtLIqN7JBYLPt2Hj79DAgGSNonz5iTDyCKkzReVhEahx8O0duexXh
    NENQHVQ11dU3d0Dt5Kd4peub7x+ZqhU7cnYFkkoZHJg5rrCmivZUOgoVs2U52Yx7
    mbGd3NMWUMmKsX0bTKnBI+h3CdFeAQe/8j/V16CnwdWL16aPiKLTzr2P3IvKuMmr
    WA0ewrTEJmQ13dSA6bAJOFoE5fnpeW3yMXghDA3raaKBvNQbW3tykxKURovFtld/
    rMS7Ca6G7qbMZwLDPMgVwTXVzCr9qQEZOruwwZdI5SuUCb1+tIpPazT8ZA/xF6NH
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=d7iDXbmV x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=JWIQiqMx;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=d7iDXbmV x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=JWIQiqMx;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMXCwjuwCGH12tXKRVNvNta3T00P7VSegJ5lj3GOVh2dROBW/BOjyWwzBNm6BoBrJ87Jo3AXN4D2m3/0dk6eEVawWMAWKgmZ5wDLypKLLRkpEDsuxBBN
    6zFpqL6QXESqzQ606J05npSOmvzlFLjwELxJJi2+yRRiN+DaAVwRUGw5XD2fqIK6qu1GPzDnnWdD2wB5B7G2Rg/8IKKU8MjMAxyRen9XhgX8EBwuhxBqNNoq
    q0vaB3toZI1WkRLLcDMpuQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=eavOLYs280S0uPSInvcA:9
    a=b3MnSy9ce_RfsBiI:21 a=_Dpwe3p8L18iecdE:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoSBtfUVowLt05UDwvDu84EJrqz4YMdPk7H2eEZ9G9hQjQN9pvc4wKg8m6MPh0sl0mSRKMW2Q==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 04/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 correct spaces around operators
Date: Mon, 14 May 2018 22:24:11 +0100
Message-Id: <20180514212434.17514-5-johnfwhitmore@gmail.com>
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

Coding style edit to clear the checkpatch.pl errors of the type:
ERROR: spaces required around that...

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 122 ++++++++++-----------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index d4ab8481ee30..f66f181e24f2 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -60,8 +60,8 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	//printk("pHTinfo:%p, &pHTinfo:%p, mptr:%p,  offsetof:%x\n", pHTInfo, &pHTInfo, __mptr, offsetof(struct ieee80211_device, pHTInfo));
 	//printk("===>ieee:%p,\n", ieee);
 	// ShortGI support
-	pHTInfo->bRegShortGI20MHz= 1;
-	pHTInfo->bRegShortGI40MHz= 1;
+	pHTInfo->bRegShortGI20MHz = 1;
+	pHTInfo->bRegShortGI40MHz = 1;
 
 	// 40MHz channel support
 	pHTInfo->bRegBW40MHz = 1;
@@ -137,12 +137,12 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString);
 
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth)?"20MHz": "20/40MHz");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->ShortGI20Mhz)?"YES": "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->ShortGI40Mhz)?"YES": "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport TX STBC = %s\n", (pCapELE->TxSTBC)?"YES": "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->MaxAMSDUSize)?"3839": "7935");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->DssCCk)?"YES": "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth) ? "20MHz" : "20/40MHz");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->ShortGI20Mhz) ? "YES" : "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->ShortGI40Mhz) ? "YES" : "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport TX STBC = %s\n", (pCapELE->TxSTBC) ? "YES" : "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->MaxAMSDUSize) ? "3839" : "7935");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->DssCCk) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor = %d\n", pCapELE->MaxRxAMPDUFactor);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->MPDUDensity);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
@@ -190,7 +190,7 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 			IEEE80211_DEBUG(IEEE80211_DL_HT, "Lower Channel\n");
 			break;
 	}
-	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth)?"20Mhz": "40Mhz");
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth) ? "20Mhz" : "40Mhz");
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tOperation mode for protection = ");
 	switch (pHTInfoEle->OptMode) {
@@ -266,8 +266,8 @@ u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 	u8	is40MHz;
 	u8	isShortGI;
 
-	is40MHz  =  (IsHTHalfNmode40Bandwidth(ieee))?1:0;
-	isShortGI = (IsHTHalfNmodeSGI(ieee, is40MHz))? 1:0;
+	is40MHz  =  (IsHTHalfNmode40Bandwidth(ieee)) ? 1 : 0;
+	isShortGI = (IsHTHalfNmodeSGI(ieee, is40MHz)) ? 1 : 0;
 
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
 }
@@ -277,10 +277,10 @@ u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
 
-	u8	is40MHz = (pHTInfo->bCurBW40MHz)?1:0;
-	u8	isShortGI = (pHTInfo->bCurBW40MHz)?
-						((pHTInfo->bCurShortGI40MHz)?1:0):
-						((pHTInfo->bCurShortGI20MHz)?1:0);
+	u8	is40MHz = (pHTInfo->bCurBW40MHz) ? 1 : 0;
+	u8	isShortGI = (pHTInfo->bCurBW40MHz) ?
+						((pHTInfo->bCurShortGI40MHz) ? 1 : 0) :
+						((pHTInfo->bCurShortGI20MHz) ? 1 : 0);
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
 }
 
@@ -308,7 +308,7 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 			isShortGI = 0;
 
 		      // nDataRate = nDataRate - 12;
-		} else if(nDataRate >=0x20  && nDataRate <= 0x2f) { //(27, 44)
+		} else if(nDataRate >= 0x20  && nDataRate <= 0x2f) { //(27, 44)
 			is40MHz = 1;
 			isShortGI = 0;
 
@@ -334,17 +334,17 @@ bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
 	struct ieee80211_network *net = &ieee->current_network;
-	if((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
-		     (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
-		     (memcmp(net->bssid, PCI_RALINK, 3)==0) ||
-		     (memcmp(net->bssid, EDIMAX_RALINK, 3)==0) ||
-		     (memcmp(net->bssid, AIRLINK_RALINK, 3)==0) ||
+	if((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
+		     (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
+		     (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
+		     (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
+		     (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
 		     (net->ralink_cap_exist))
 		retValue = true;
-	else if((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
-		    (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
-		    (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
-		    (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0) ||
+	else if((memcmp(net->bssid, UNKNOWN_BORADCOM, 3) == 0) ||
+		    (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
+		    (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
+		    (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0) ||
 		    (net->broadcom_cap_exist))
 		  retValue = true;
 	else if(net->bssht.bdRT2RTAggregation)
@@ -370,21 +370,21 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 		pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK;
 	else if(net->broadcom_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	else if((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
-			(memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
-			(memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
-			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0))
+	else if((memcmp(net->bssid, UNKNOWN_BORADCOM, 3) == 0) ||
+			(memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
+			(memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
+			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0))
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	else if((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
-			(memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
-			(memcmp(net->bssid, PCI_RALINK, 3)==0) ||
-			(memcmp(net->bssid, EDIMAX_RALINK, 3)==0) ||
-			(memcmp(net->bssid, AIRLINK_RALINK, 3)==0) ||
+	else if((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
+			(memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
+			(memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
+			(memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
+			(memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
 			 net->ralink_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
 	else if(net->atheros_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
-	else if(memcmp(net->bssid, CISCO_BROADCOM, 3)==0)
+	else if(memcmp(net->bssid, CISCO_BROADCOM, 3) == 0)
 		pHTInfo->IOTPeer = HT_IOT_PEER_CISCO;
 	else
 		pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
@@ -423,7 +423,7 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
 
 #ifdef TODO
 	// Apply for 819u only
-#if (HAL_CODE_BASE==RTL8192)
+#if (HAL_CODE_BASE == RTL8192)
 
 #if (DEV_BUS_TYPE == USB_INTERFACE)
 	// Alway disable MCS15 by Jerry Chang's request.by Emily, 2008.04.15
@@ -498,9 +498,9 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 {
 	u8	retValue = 0;
-	if((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3)==0) ||
-	   (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0) ||
-	   (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ==0))
+	if((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3) == 0) ||
+	   (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
+	   (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0))
 		retValue = 1;
 
 	return retValue;
@@ -550,7 +550,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	if(ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth = 0;
 	else
-		pCapELE->ChlWidth = (pHT->bRegBW40MHz?1:0);
+		pCapELE->ChlWidth = (pHT->bRegBW40MHz ? 1 : 0);
 
 //	pCapELE->ChlWidth		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->MimoPwrSave		= pHT->SelfMimoPs;
@@ -562,8 +562,8 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->TxSTBC			= 1;
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
-	pCapELE->MaxAMSDUSize	= (MAX_RECEIVE_BUFFER_SIZE>=7935)?1:0;
-	pCapELE->DssCCk			= ((pHT->bRegBW40MHz)?(pHT->bRegSuppCCK?1:0):0);
+	pCapELE->MaxAMSDUSize	= (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
+	pCapELE->DssCCk			= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
 	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
@@ -595,7 +595,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	// For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
-		for(i = 1; i< 16; i++)
+		for(i = 1; i < 16; i++)
 			pCapELE->MCS[i] = 0;
 	}
 
@@ -645,9 +645,9 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	memset(posHTInfo, 0, *len);
 	if ( (ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) { //ap mode is not currently supported
 		pHTInfoEle->ControlChl			= ieee->current_network.channel;
-		pHTInfoEle->ExtChlOffset			= ((!pHT->bRegBW40MHz)?HT_EXTCHNL_OFFSET_NO_EXT:
-											(ieee->current_network.channel<=6)?
-												HT_EXTCHNL_OFFSET_UPPER:HT_EXTCHNL_OFFSET_LOWER);
+		pHTInfoEle->ExtChlOffset			= ((!pHT->bRegBW40MHz) ? HT_EXTCHNL_OFFSET_NO_EXT :
+											(ieee->current_network.channel <= 6) ?
+												HT_EXTCHNL_OFFSET_UPPER : HT_EXTCHNL_OFFSET_LOWER);
 		pHTInfoEle->RecommemdedTxWidth	= pHT->bRegBW40MHz;
 		pHTInfoEle->RIFS					= 0;
 		pHTInfoEle->PSMPAccessOnly		= 0;
@@ -770,7 +770,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 			//legacy rate routine handled at selectedrate
 
 			//no MCS rate
-			for(i=0;i<=15;i++) {
+			for(i = 0; i <= 15; i++) {
 				pOperateMCS[i] = 0;
 			}
 			break;
@@ -782,9 +782,9 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 
 			//HT part
 			// TODO: may be different if we have different number of antenna
-			pOperateMCS[0] &=RATE_ADPT_1SS_MASK;	//support MCS 0~7
-			pOperateMCS[1] &=RATE_ADPT_2SS_MASK;
-			pOperateMCS[3] &=RATE_ADPT_MCS32_MASK;
+			pOperateMCS[0] &= RATE_ADPT_1SS_MASK;	//support MCS 0~7
+			pOperateMCS[1] &= RATE_ADPT_2SS_MASK;
+			pOperateMCS[3] &= RATE_ADPT_MCS32_MASK;
 			break;
 
 	//should never reach here
@@ -826,7 +826,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
 	}
-	for(i=0; i<16; i++)
+	for(i = 0; i < 16; i++)
 		availableMcsRate[i] = pMCSRateSet[i] & pMCSFilter[i];
 
 	for(i = 0; i < 16; i++) {
@@ -866,10 +866,10 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
 
-	u8 i=0;
+	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for(i=0;i<=15;i++){
+	for(i = 0; i <= 15; i++){
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i]&pSupportMCS[i];
 	}
 
@@ -888,7 +888,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	// For RTL819X, we support only MCS0~15.
 	// And also, we do not know how to use MCS32 now.
 	//
-	for(i=2; i<=15; i++)
+	for(i = 2; i <= 15; i++)
 		pOperateMCS[i] = 0;
 
 	return true;
@@ -965,7 +965,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	//
 	pHTInfo->bCurrent_AMSDU_Support = pHTInfo->bAMSDU_Support;
 
-	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize==0)?3839:7935;
+	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
 
 	if(pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize)
 		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
@@ -1149,7 +1149,7 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 	memset(pBssHT->bdHTInfoBuf, 0, sizeof(pBssHT->bdHTInfoBuf));
 	pBssHT->bdHTInfoLen = 0;
 
-	pBssHT->bdHTSpecVer= HT_SPEC_VER_IEEE;
+	pBssHT->bdHTSpecVer = HT_SPEC_VER_IEEE;
 
 	pBssHT->bdRT2RTAggregation = false;
 	pBssHT->bdRT2RTLongSlotTime = false;
@@ -1302,11 +1302,11 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 		return;
 	}
 	//if in half N mode, set to 20M bandwidth please 09.08.2008 WB.
-	if(Bandwidth==HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))) {
+	if(Bandwidth == HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))) {
 			// Handle Illegal extension channel offset!!
-		if(ieee->current_network.channel<2 && Offset==HT_EXTCHNL_OFFSET_LOWER)
+		if(ieee->current_network.channel < 2 && Offset == HT_EXTCHNL_OFFSET_LOWER)
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
-		if(Offset==HT_EXTCHNL_OFFSET_UPPER || Offset==HT_EXTCHNL_OFFSET_LOWER) {
+		if(Offset == HT_EXTCHNL_OFFSET_UPPER || Offset == HT_EXTCHNL_OFFSET_LOWER) {
 			pHTInfo->bCurBW40MHz = true;
 			pHTInfo->CurSTAExtChnlOffset = Offset;
 		} else {
@@ -1336,9 +1336,9 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee)
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "======>%s()\n", __func__);
 
 	if(pHTInfo->bCurBW40MHz) {
-		if(pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_UPPER)
+		if(pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev, ieee->current_network.channel+2);
-		else if(pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_LOWER)
+		else if(pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_LOWER)
 			ieee->set_chan(ieee->dev, ieee->current_network.channel-2);
 		else
 			ieee->set_chan(ieee->dev, ieee->current_network.channel);
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
