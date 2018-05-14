Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1006072-1526313263-2-14440139614283961685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313261; b=bGE+oLNZjjS3QMSc2MbKwHa2J429lU+zLnWWYUra1enpoRh3l5
    e8Cp+jISunuMDx9MsNBPZOwg7cyayGQALXgjfLsLDCImKnGsymbj575CnEFnFAyS
    AxoMdvSSIDHT2C8JMy6PI3vubwWcd4SzfeZiIEINezCRZgbw3x3t2YTE0GobzGi1
    fQvYu8wBfRt1NnXcOFX+qi5Mx66RQ+Lq9DpGlEZaj5pNndlxAJluw0ki53xehti2
    0TMDCqiuZYlIiimpJCHYc/PCTeP/duo9GBC7jAn4mO1Y2c5msrERnj7tMbZj0SH6
    3uKAE3b/3WAlDw4kutHxN3MexkyKRxpneY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313261; bh=j0gXB
    cJVYAUny5OfpgLNkPnorKAaeL/HmGuw9QZ0+so=; b=hAbEn5hZkx8csZ8QVdQtP
    M8i78OnLWy3mdUO6ulqn0qsmWExYPq3XJY4+AsEKw+7K1inAhOgw/Xxphk1dD5iZ
    6CbKcdbNlmd2qKjI9QNQLCJZCffsVJsYDp2Vqy+BYsJvGjlkjiNqBbuKgBIf574l
    K0MJVTZraSif/tuWabufHd8O+XgKUgXBHmdYsKdxmYufh7Ms37OY+p3rRaFaZq8W
    J3loEdy/4T2FJnrRi2XyDMD2+aLFfpGFrZHtmnSvlXco7U3ELzzO40V7lQYDasZb
    /qza9+Dhqr9S7uQzP8MU2D2jsB16Ilett2OTuS4JkVqKqKFxMg352BJACBkU90n+
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=nkSFBNZ+ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=oKaTJXos;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=nkSFBNZ+ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=oKaTJXos;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJhmlAOGl/GPXbzpbtV7MGGHsOSQBQ6L6DPDj9Kyc3vci6R7on2O/TCvYN8Rdu9ykE8XSLPCChgvTojzZWYbKQnkFrEG3IUmXRcEsDulRX8nlrM7RJwh
    Aq8yDrxyNckTRYNIqh0tDuRbsIGATo0ku1NibLxz1nGY3wAtdACaNIfSQdMKlKazE9WOELKMFpNKkfoxn6GyRtt3p9yb/PvI0yGl3BplbQxYqfCjG5EW+6JN
    5mDc06e3qXuXQYsYRYMXuw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=MkHXF6FIopRXmm0y-rkA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrUH9hna/oLft49eVyuBtkb13ughzBCy2vs/YxXuZYNLqkHSUBKmOk7vXoLQkSBjimwPEh96A==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 03/13] coding style corrections for if statements
Date: Mon, 14 May 2018 16:53:08 +0100
Message-Id: <20180514155318.32195-4-johnfwhitmore@gmail.com>
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

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 273 +++++++++------------
 1 file changed, 112 insertions(+), 161 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 9e596577e544..9366b62343af 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -70,7 +70,7 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	pHTInfo->bRegBW40MHz = 1;
 
 	// CCK rate support in 40MHz channel
-	if(pHTInfo->bRegBW40MHz)
+	if (pHTInfo->bRegBW40MHz)
 		pHTInfo->bRegSuppCCK = 1;
 	else
 		pHTInfo->bRegSuppCCK = true;
@@ -86,7 +86,7 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 
 	// MIMO Power Save
 	pHTInfo->SelfMimoPs = 3;// 0: Static Mimo Ps, 1: Dynamic Mimo Ps, 3: No Limitation, 2: Reserved(Set to 3 automatically.)
-	if(pHTInfo->SelfMimoPs == 2)
+	if (pHTInfo->SelfMimoPs == 2)
 		pHTInfo->SelfMimoPs = 3;
 	// 8190 only. Assign rate operation mode to firmware
 	ieee->bTxDisableRateFallBack = 0;
@@ -134,14 +134,13 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
 	static u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_CAPABILITY_ELE		pCapELE;
 
-	if(!memcmp(CapIE, EWC11NHTCap, sizeof(EWC11NHTCap)))
-	{
+	if (!memcmp(CapIE, EWC11NHTCap, sizeof(EWC11NHTCap))) {
 		//EWC IE
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "EWC IE in %s()\n", __func__);
 		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[4]);
-	}else
+	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[0]);
-
+	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString );
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth)?"20MHz": "20/40MHz");
@@ -174,14 +173,13 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 	static u8	EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_INFORMATION_ELE		pHTInfoEle;
 
-	if(!memcmp(InfoIE, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
-	{
+	if (!memcmp(InfoIE, EWC11NHTInfo, sizeof(EWC11NHTInfo))) {
 		// Not EWC IE
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "EWC IE in %s()\n", __func__);
 		pHTInfoEle = (PHT_INFORMATION_ELE)(&InfoIE[4]);
-	}else
+	} else {
 		pHTInfoEle = (PHT_INFORMATION_ELE)(&InfoIE[0]);
-
+	}
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Information Element>. Called by %s\n", TitleString);
 
@@ -232,13 +230,13 @@ static bool IsHTHalfNmode40Bandwidth(struct ieee80211_device *ieee)
 	bool			retValue = false;
 	PRT_HIGH_THROUGHPUT	 pHTInfo = ieee->pHTInfo;
 
-	if(!pHTInfo->bCurrentHTSupport)		// wireless is n mode
+	if (!pHTInfo->bCurrentHTSupport)		// wireless is n mode
 		retValue = false;
-	else if(!pHTInfo->bRegBW40MHz)		// station supports 40 bw
+	else if (!pHTInfo->bRegBW40MHz)		// station supports 40 bw
 		retValue = false;
-	else if(!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
+	else if (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
 		retValue = false;
-	else if(((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ChlWidth) // ap support 40 bw
+	else if (((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ChlWidth) // ap support 40 bw
 		retValue = true;
 	else
 		retValue = false;
@@ -251,20 +249,17 @@ static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
 	bool			retValue = false;
 	PRT_HIGH_THROUGHPUT	 pHTInfo = ieee->pHTInfo;
 
-	if(!pHTInfo->bCurrentHTSupport)		// wireless is n mode
+	if (!pHTInfo->bCurrentHTSupport)		// wireless is n mode
 		retValue = false;
-	else if(!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
+	else if (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
 		retValue = false;
-	else if(is40MHz) // ap support 40 bw
-	{
-		if(((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ShortGI40Mhz) // ap support 40 bw short GI
+	else if (is40MHz) { // ap support 40 bw
+		if (((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ShortGI40Mhz) // ap support 40 bw short GI
 			retValue = true;
 		else
 			retValue = false;
-	}
-	else
-	{
-		if(((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ShortGI20Mhz) // ap support 40 bw short GI
+	} else {
+		if (((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ShortGI20Mhz) // ap support 40 bw short GI
 			retValue = true;
 		else
 			retValue = false;
@@ -313,35 +308,25 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 	u8	is40MHz = 0;
 	u8	isShortGI = 0;
 
-	if(nDataRate < 12)
-	{
+	if (nDataRate < 12) {
 		return CCKOFDMRate[nDataRate];
-	}
-	else
-	{
-		if (nDataRate >= 0x10 && nDataRate <= 0x1f)//if(nDataRate > 11 && nDataRate < 28 )
-		{
+	} else {
+		if (nDataRate >= 0x10 && nDataRate <= 0x1f) { //if(nDataRate > 11 && nDataRate < 28 )
 			is40MHz = 0;
 			isShortGI = 0;
 
 		      // nDataRate = nDataRate - 12;
-		}
-		else if(nDataRate >=0x20  && nDataRate <= 0x2f ) //(27, 44)
-		{
+		} else if (nDataRate >=0x20  && nDataRate <= 0x2f ) { //(27, 44)
 			is40MHz = 1;
 			isShortGI = 0;
 
 			//nDataRate = nDataRate - 28;
-		}
-		else if(nDataRate >= 0x30  && nDataRate <= 0x3f )  //(43, 60)
-		{
+		} else if (nDataRate >= 0x30  && nDataRate <= 0x3f ) { //(43, 60)
 			is40MHz = 0;
 			isShortGI = 1;
 
 			//nDataRate = nDataRate - 44;
-		}
-		else if(nDataRate >= 0x40  && nDataRate <= 0x4f ) //(59, 76)
-		{
+		} else if(nDataRate >= 0x40  && nDataRate <= 0x4f ) { //(59, 76)
 			is40MHz = 1;
 			isShortGI = 1;
 
@@ -357,20 +342,20 @@ bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
 	struct ieee80211_network *net = &ieee->current_network;
-	if((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
-		     (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
-		     (memcmp(net->bssid, PCI_RALINK, 3)==0) ||
-		     (memcmp(net->bssid, EDIMAX_RALINK, 3)==0) ||
-		     (memcmp(net->bssid, AIRLINK_RALINK, 3)==0) ||
-		     (net->ralink_cap_exist))
+	if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
+	    (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
+	    (memcmp(net->bssid, PCI_RALINK, 3)==0) ||
+	    (memcmp(net->bssid, EDIMAX_RALINK, 3)==0) ||
+	    (memcmp(net->bssid, AIRLINK_RALINK, 3)==0) ||
+	    (net->ralink_cap_exist))
 		retValue = true;
-	else if((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
-		    (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
-		    (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
-		    (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0) ||
-		    (net->broadcom_cap_exist))
+	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
+		 (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
+		 (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
+		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0) ||
+		 (net->broadcom_cap_exist))
 		  retValue = true;
-	else if(net->bssht.bdRT2RTAggregation)
+	else if (net->bssht.bdRT2RTAggregation)
 		retValue = true;
 	else
 		retValue = false;
@@ -390,25 +375,25 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
 	struct ieee80211_network *net = &ieee->current_network;
-	if(net->bssht.bdRT2RTAggregation)
+	if (net->bssht.bdRT2RTAggregation)
 		pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK;
-	else if(net->broadcom_cap_exist)
+	else if (net->broadcom_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	else if((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
-			(memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
-			(memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
-			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0) )
+	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
+		 (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
+		 (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
+		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0) )
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	else if((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
-			(memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
-			(memcmp(net->bssid, PCI_RALINK, 3)==0) ||
-			(memcmp(net->bssid, EDIMAX_RALINK, 3)==0) ||
-			(memcmp(net->bssid, AIRLINK_RALINK, 3)==0) ||
-			 net->ralink_cap_exist)
+	else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
+		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
+		 (memcmp(net->bssid, PCI_RALINK, 3)==0) ||
+		 (memcmp(net->bssid, EDIMAX_RALINK, 3)==0) ||
+		 (memcmp(net->bssid, AIRLINK_RALINK, 3)==0) ||
+		 net->ralink_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
-	else if(net->atheros_cap_exist)
+	else if (net->atheros_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
-	else if(memcmp(net->bssid, CISCO_BROADCOM, 3)==0)
+	else if (memcmp(net->bssid, CISCO_BROADCOM, 3)==0)
 		pHTInfo->IOTPeer = HT_IOT_PEER_CISCO;
 	else
 		pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
@@ -520,8 +505,7 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 	// 2008/01/25 MH Judeg if we need to use OFDM to sned MGNT frame for broadcom AP.
 	// 2008/01/28 MH We must prevent that we select null bssid to link.
 
-	if (network->broadcom_cap_exist)
-	{
+	if (network->broadcom_cap_exist) {
 		retValue = 1;
 	}
 
@@ -531,10 +515,9 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 {
 	u8	retValue = 0;
-	if(	(memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3)==0) ||
-		(memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0) ||
-		(memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ==0))
-	{
+	if ((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3)==0) ||
+	    (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0) ||
+	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ==0)) {
 		retValue = 1;
 	}
 
@@ -566,14 +549,12 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	PHT_CAPABILITY_ELE	pCapELE = NULL;
 	//u8 bIsDeclareMCS13;
 
-	if ((posHTCap == NULL) || (pHT == NULL))
-	{
+	if ((posHTCap == NULL) || (pHT == NULL)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in HTConstructCapabilityElement()\n");
 		return;
 	}
 	memset(posHTCap, 0, *len);
-	if(pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)
-	{
+	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE = (PHT_CAPABILITY_ELE)&(posHTCap[4]);
@@ -585,14 +566,10 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	//HT capability info
 	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
-	if(ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-	{
+	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth = 0;
-	}
 	else
-	{
 		pCapELE->ChlWidth = (pHT->bRegBW40MHz?1:0);
-	}
 
 //	pCapELE->ChlWidth		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->MimoPwrSave		= pHT->SelfMimoPs;
@@ -617,28 +594,25 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	if (IsEncrypt) {
 		pCapELE->MPDUDensity	= 7; // 8us
 		pCapELE->MaxRxAMPDUFactor	= 2; // 2 is for 32 K and 3 is 64K
-	}
-	else
-	{
+	} else {
 		pCapELE->MaxRxAMPDUFactor	= 3; // 2 is for 32 K and 3 is 64K
 		pCapELE->MPDUDensity	= 0; // no density
 	}
 
 	//Supported MCS set
 	memcpy(pCapELE->MCS, ieee->Regdot11HTOperationalRateSet, 16);
-	if(pHT->IOTAction & HT_IOT_ACT_DISABLE_MCS15)
+	if (pHT->IOTAction & HT_IOT_ACT_DISABLE_MCS15)
 		pCapELE->MCS[1] &= 0x7f;
 
-	if(pHT->IOTAction & HT_IOT_ACT_DISABLE_MCS14)
+	if (pHT->IOTAction & HT_IOT_ACT_DISABLE_MCS14)
 		pCapELE->MCS[1] &= 0xbf;
 
-	if(pHT->IOTAction & HT_IOT_ACT_DISABLE_ALL_2SS)
+	if (pHT->IOTAction & HT_IOT_ACT_DISABLE_ALL_2SS)
 		pCapELE->MCS[1] &= 0x00;
 
 	// 2008.06.12
 	// For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-	{
+	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
 		for(i = 1; i< 16; i++)
 			pCapELE->MCS[i] = 0;
@@ -654,7 +628,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//Antenna Selection Capabilities
 	pCapELE->ASCap = 0;
 //add 2 to give space for element ID and len when construct frames
-	if(pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)
+	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)
 		*len = 30 + 2;
 	else
 		*len = 26 + 2;
@@ -686,15 +660,13 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
-	if ((posHTInfo == NULL) || (pHTInfoEle == NULL))
-	{
+	if ((posHTInfo == NULL) || (pHTInfoEle == NULL)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
 		return;
 	}
 
 	memset(posHTInfo, 0, *len);
-	if ( (ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) //ap mode is not currently supported
-	{
+	if ( (ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) { //ap mode is not currently supported
 		pHTInfoEle->ControlChl			= ieee->current_network.channel;
 		pHTInfoEle->ExtChlOffset			= ((!pHT->bRegBW40MHz)?HT_EXTCHNL_OFFSET_NO_EXT:
 											(ieee->current_network.channel<=6)?
@@ -716,9 +688,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 
 		*len = 22 + 2; //same above
 
-	}
-	else
-	{
+	} else {
 		//STA should not generate High Throughput Information Element
 		*len = 0;
 	}
@@ -770,9 +740,8 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	*posRT2RTAgg++ = 0x01;
 	*posRT2RTAgg = 0x10;//*posRT2RTAgg = 0x02;
 
-	if (ieee->bSupportRemoteWakeUp) {
+	if (ieee->bSupportRemoteWakeUp)
 		*posRT2RTAgg |= 0x08;//RT_HT_CAP_USE_WOW;
-	}
 
 	*len = 6 + 2;
 	return;
@@ -813,8 +782,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	u8					i;
-	if (pOperateMCS == NULL)
-	{
+	if (pOperateMCS == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
 		return false;
 	}
@@ -877,8 +845,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		bitMap;
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
-	if (pMCSRateSet == NULL || pMCSFilter == NULL)
-	{
+	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
 	}
@@ -887,22 +854,20 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 
 	for(i = 0; i < 16; i++)
 	{
-		if(availableMcsRate[i] != 0)
+		if (availableMcsRate[i] != 0)
 			break;
 	}
-	if(i == 16)
+	if (i == 16)
 		return false;
 
 	for(i = 0; i < 16; i++)
 	{
-		if (availableMcsRate[i] != 0)
-		{
+		if (availableMcsRate[i] != 0) {
 			bitMap = availableMcsRate[i];
 			for(j = 0; j < 8; j++)
 			{
-				if ((bitMap%2) != 0)
-				{
-					if(HTMcsToDataRate(ieee, (8*i+j)) > HTMcsToDataRate(ieee, mcsRate))
+				if ((bitMap%2) != 0) {
+					if (HTMcsToDataRate(ieee, (8*i+j)) > HTMcsToDataRate(ieee, mcsRate))
 						mcsRate = (8*i+j);
 				}
 				bitMap >>= 1;
@@ -945,7 +910,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	HT_PickMCSRate(ieee, pOperateMCS);
 
 	// For RTL819X, if pairwisekey = wep/tkip, we support only MCS0~7.
-	if(ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
+	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pOperateMCS[1] = 0;
 
 	/*
@@ -985,7 +950,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	else
 		pPeerHTCap = (PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf);
 
-	if(!memcmp(pHTInfo->PeerHTInfoBuf, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
+	if (!memcmp(pHTInfo->PeerHTInfoBuf, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
 		pPeerHTInfo = (PHT_INFORMATION_ELE)(&pHTInfo->PeerHTInfoBuf[4]);
 	else
 		pPeerHTInfo = (PHT_INFORMATION_ELE)(pHTInfo->PeerHTInfoBuf);
@@ -1031,7 +996,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize==0)?3839:7935;
 
-	if(pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize )
+	if (pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize )
 		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
 	else
 		pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
@@ -1045,28 +1010,24 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	// <1> Decide AMPDU Factor
 
 	// By Emily
-	if(!pHTInfo->bRegRT2RTAggregation)
-	{
+	if (!pHTInfo->bRegRT2RTAggregation) {
 		// Decide AMPDU Factor according to protocol handshake
-		if(pHTInfo->AMPDU_Factor > pPeerHTCap->MaxRxAMPDUFactor)
+		if (pHTInfo->AMPDU_Factor > pPeerHTCap->MaxRxAMPDUFactor)
 			pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
 		else
 			pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
-	}else
-	{
+	} else {
 		// Set MPDU density to 2 to Realtek AP, and set it to 0 for others
 		// Replace MPDU factor declared in original association response frame format. 2007.08.20 by Emily
-		if (ieee->current_network.bssht.bdRT2RTAggregation)
-		{
+		if (ieee->current_network.bssht.bdRT2RTAggregation) {
 			if (ieee->pairwise_key_type != KEY_TYPE_NA)
 				// Realtek may set 32k in security mode and 64k for others
 				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
 			else
 				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
-		}else
-		{
-			if(pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
+		} else {
+			if (pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
 				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
 			else
 				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_32K;
@@ -1075,22 +1036,20 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 
 	// <2> Set AMPDU Minimum MPDU Start Spacing
 	// 802.11n 3.0 section 9.7d.3
-	if(pHTInfo->MPDU_Density > pPeerHTCap->MPDUDensity)
+	if (pHTInfo->MPDU_Density > pPeerHTCap->MPDUDensity)
 		pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	else
 		pHTInfo->CurrentMPDUDensity = pPeerHTCap->MPDUDensity;
-	if(ieee->pairwise_key_type != KEY_TYPE_NA )
+	if (ieee->pairwise_key_type != KEY_TYPE_NA )
 		pHTInfo->CurrentMPDUDensity	= 7; // 8us
 	// Force TX AMSDU
 
 	// Lanhsin: mark for tmp to avoid deauth by ap from  s3
 	//if(memcmp(pMgntInfo->Bssid, NETGEAR834Bv2_BROADCOM, 3)==0)
-	if (0)
-		{
-
-			pHTInfo->bCurrentAMPDUEnable = false;
-			pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
-			pHTInfo->ForcedAMSDUMaxSize = 7935;
+	if (0){
+		pHTInfo->bCurrentAMPDUEnable = false;
+		pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
+		pHTInfo->ForcedAMSDUMaxSize = 7935;
 
 		pHTInfo->IOTAction |=  HT_IOT_ACT_TX_USE_AMSDU_8K;
 	}
@@ -1109,7 +1068,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	 * Handle Ralink AP bad MCS rate set condition. Joseph.
 	 * This fix the bug of Ralink AP. This may be removed in the future.
 	 */
-	if(pPeerHTCap->MCS[0] == 0)
+	if (pPeerHTCap->MCS[0] == 0)
 		pPeerHTCap->MCS[0] = 0xff;
 
 	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11HTOperationalRateSet);
@@ -1118,7 +1077,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	// Config MIMO Power Save setting
 	//
 	pHTInfo->PeerMimoPs = pPeerHTCap->MimoPwrSave;
-	if(pHTInfo->PeerMimoPs == MIMO_PS_STATIC)
+	if (pHTInfo->PeerMimoPs == MIMO_PS_STATIC)
 		pMcsFilter = MCS_FILTER_1SS;
 	else
 		pMcsFilter = MCS_FILTER_ALL;
@@ -1263,26 +1222,22 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 	 * function ieee80211_softmac_new_net. WB 2008.09.10
 	 */
 //	if( pHTInfo->bEnableHT &&  pNetwork->bssht.bdSupportHT)
-	if (pNetwork->bssht.bdSupportHT)
-	{
+	if (pNetwork->bssht.bdSupportHT) {
 		pHTInfo->bCurrentHTSupport = true;
 		pHTInfo->ePeerHTSpecVer = pNetwork->bssht.bdHTSpecVer;
 
 		// Save HTCap and HTInfo information Element
-		if(pNetwork->bssht.bdHTCapLen > 0 &&	pNetwork->bssht.bdHTCapLen <= sizeof(pHTInfo->PeerHTCapBuf))
+		if (pNetwork->bssht.bdHTCapLen > 0 &&	pNetwork->bssht.bdHTCapLen <= sizeof(pHTInfo->PeerHTCapBuf))
 			memcpy(pHTInfo->PeerHTCapBuf, pNetwork->bssht.bdHTCapBuf, pNetwork->bssht.bdHTCapLen);
 
-		if(pNetwork->bssht.bdHTInfoLen > 0 && pNetwork->bssht.bdHTInfoLen <= sizeof(pHTInfo->PeerHTInfoBuf))
+		if (pNetwork->bssht.bdHTInfoLen > 0 && pNetwork->bssht.bdHTInfoLen <= sizeof(pHTInfo->PeerHTInfoBuf))
 			memcpy(pHTInfo->PeerHTInfoBuf, pNetwork->bssht.bdHTInfoBuf, pNetwork->bssht.bdHTInfoLen);
 
 		// Check whether RT to RT aggregation mode is enabled
-		if(pHTInfo->bRegRT2RTAggregation)
-		{
+		if (pHTInfo->bRegRT2RTAggregation) {
 			pHTInfo->bCurrentRT2RTAggregation = pNetwork->bssht.bdRT2RTAggregation;
 			pHTInfo->bCurrentRT2RTLongSlotTime = pNetwork->bssht.bdRT2RTLongSlotTime;
-		}
-		else
-		{
+		} else {
 			pHTInfo->bCurrentRT2RTAggregation = false;
 			pHTInfo->bCurrentRT2RTLongSlotTime = false;
 		}
@@ -1294,28 +1249,28 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 		// Must be called after the parameter of pHTInfo->bCurrentRT2RTAggregation is decided
 		pHTInfo->IOTAction = 0;
 		bIOTAction = HTIOTActIsDisableMCS14(ieee, pNetwork->bssid);
-		if(bIOTAction)
+		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_MCS14;
 
 		bIOTAction = HTIOTActIsDisableMCS15(ieee);
-		if(bIOTAction)
+		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_MCS15;
 
 		bIOTAction = HTIOTActIsDisableMCSTwoSpatialStream(ieee, pNetwork->bssid);
-		if(bIOTAction)
+		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_ALL_2SS;
 
 
 		bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
-		if(bIOTAction)
+		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
 
 		bIOTAction = HTIOTActIsMgntUseCCK6M(pNetwork);
-		if(bIOTAction)
+		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_MGNT_USE_CCK_6M;
 
 		bIOTAction = HTIOTActIsCCDFsync(pNetwork->bssid);
-		if(bIOTAction)
+		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_CDD_FSYNC;
 
 
@@ -1337,12 +1292,11 @@ void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct ieee80211_
 //	PHT_CAPABILITY_ELE		pPeerHTCap = (PHT_CAPABILITY_ELE)pNetwork->bssht.bdHTCapBuf;
 	PHT_INFORMATION_ELE		pPeerHTInfo = (PHT_INFORMATION_ELE)pNetwork->bssht.bdHTInfoBuf;
 
-	if (pHTInfo->bCurrentHTSupport)
-	{
+	if (pHTInfo->bCurrentHTSupport) {
 		//
 		// Config current operation mode.
 		//
-		if(pNetwork->bssht.bdHTInfoLen != 0)
+		if (pNetwork->bssht.bdHTInfoLen != 0)
 			pHTInfo->CurrentOpMode = pPeerHTInfo->OptMode;
 
 		//
@@ -1363,8 +1317,7 @@ EXPORT_SYMBOL(HTUpdateSelfAndPeerSetting);
  */
 u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame)
 {
-	if (ieee->pHTInfo->bCurrentHTSupport)
-	{
+	if (ieee->pHTInfo->bCurrentHTSupport) {
 		if ((IsQoSDataFrame(pFrame) && Frame_Order(pFrame)) == 1) {
 			IEEE80211_DEBUG(IEEE80211_DL_HT, "HT CONTROL FILED EXIST!!\n");
 			return true;
@@ -1381,7 +1334,7 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
 //	u32 flags = 0;
 
-	if(!pHTInfo->bRegBW40MHz)
+	if (!pHTInfo->bRegBW40MHz)
 		return;
 
 
@@ -1397,12 +1350,11 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 		return;
 	}
 	//if in half N mode, set to 20M bandwidth please 09.08.2008 WB.
-	if(Bandwidth==HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)))
-	 {
+	if (Bandwidth==HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))) {
 			// Handle Illegal extension channel offset!!
-		if(ieee->current_network.channel<2 && Offset==HT_EXTCHNL_OFFSET_LOWER)
+		if (ieee->current_network.channel<2 && Offset==HT_EXTCHNL_OFFSET_LOWER)
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
-		if(Offset==HT_EXTCHNL_OFFSET_UPPER || Offset==HT_EXTCHNL_OFFSET_LOWER) {
+		if (Offset==HT_EXTCHNL_OFFSET_UPPER || Offset==HT_EXTCHNL_OFFSET_LOWER) {
 			pHTInfo->bCurBW40MHz = true;
 			pHTInfo->CurSTAExtChnlOffset = Offset;
 		} else {
@@ -1433,11 +1385,10 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee)
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "======>%s()\n", __func__);
 
-	if(pHTInfo->bCurBW40MHz)
-	{
-		if(pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_UPPER)
+	if (pHTInfo->bCurBW40MHz) {
+		if (pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev, ieee->current_network.channel+2);
-		else if(pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_LOWER)
+		else if (pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_LOWER)
 			ieee->set_chan(ieee->dev, ieee->current_network.channel-2);
 		else
 			ieee->set_chan(ieee->dev, ieee->current_network.channel);
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
