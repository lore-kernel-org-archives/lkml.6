Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333122-2-5395155446657298140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333121; b=MvGA1XlzifbhRP1g72fqLj02RYyyMISEKLPQ4VrTYTBdMvpyIe
    DVxTRsm5DybsOBjJup98W0UYKoHRBRr6/+KMDOFUsQNyDBsbM7pyuGgvL4Qe+ky4
    hlzn6bt/YHTGelzdt4fRQGpRQAcmM7oBsceNCdcHVbAQ/XrB9vId+OALyWQxj3db
    bty85HgMUJov2vZthbCzTC1QoSJgjD+4qmjT6B4lyczy/PTGY7iCUuTo5OdgTWGL
    jAfLXLzmVwcdONFFQSfb0kVwNp4IaTvIiV9l+s1Cq4AEUTS8A9QpkYsS70bCvua6
    NhT44nBpziPSbDK88d/AyhlOyodObdmDnAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333121; bh=zr03l
    KWSlzigYNM5BDZHZ8Um93Nsoi/TpYbM3IjaUGQ=; b=WHUPEyXS78DMB58x3wiFq
    fGh1/QZoKrEgN7rEbI+Sq/garvqDB53nw/G/dVeWvRzV/oUBgTTIUeEuGp6VsS1e
    15yO+I1QLnYmFrtgc261ZxqPRdtxy8KrfDVE2npmx4AulGCM3rJIBsOTkM5uy/2r
    ifw748DWofvpHoi5ox7eLCH65Gihe2xSN26+cQrzzGTAbfjbtwaw9eO9AXSB/xkU
    Z2cwXpfgEScxBWEeMvsMH1hokmS6CEukrAfJ4JBYjiIzebQ4jWwzJCNY6DOfgvja
    4buQAX/nh65JrGPPRaDVDnLCKIYN0V4fD2FoOk9lOtPM7iyeGh6XltgxGDUjpuqz
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=DlNqic/o x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=fyi2FmaV;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=DlNqic/o x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=fyi2FmaV;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNka3HYlppfAGqGCvZB4/P4kv6y8NxNMwIFQ6dxHc1yePVfEehL4IbX3kod/lLS9HqeiMGkWdIH+IKpitPu5Lp+Nab7qUbffrmNSgWxrwfOPr7ZqVQaI
    +ScadwzLou5vgQ0OMKg1y4o92HcO9a/7xGrNzmZnrSsW76rx0i4MXi7wBLMdeGWwi/5Kn/mFufCfTyVE3X+K9gFdvvZzJR1O5iDTee1clcABA5U0jYwuenQ9
    dW6e1D/JzfCnkyo1EoyFCQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=X4ZTu7L3KnXVeuKjgzEA:9 a=CjuIK1q_8ugA:10
    a=Ep1hS7IbJHIA:10 a=HqMrfUhOb-sA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpfZZZIlE96SDNMU4wUAv5pkfm9c9nLhqlUT5C7S/+0W8AZ0SAa8jSLEj9xgu+lSuzLw0Tn/w==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 01/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 correct braces
Date: Mon, 14 May 2018 22:24:08 +0100
Message-Id: <20180514212434.17514-2-johnfwhitmore@gmail.com>
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
ERROR: that open brace { should be on the previous line

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 197 ++++++++-------------
 1 file changed, 70 insertions(+), 127 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index bf7b7122d042..c116bd895b50 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -7,28 +7,28 @@ u8 MCS_FILTER_ALL[16] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0
 
 u8 MCS_FILTER_1SS[16] = {0xff, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
-u16 MCS_DATA_RATE[2][2][77] =
-	{	{	{13, 26, 39, 52, 78, 104, 117, 130, 26, 52, 78 ,104, 156, 208, 234, 260,
-			39, 78, 117, 234, 312, 351, 390, 52, 104, 156, 208, 312, 416, 468, 520,
-			0, 78, 104, 130, 117, 156, 195, 104, 130, 130, 156, 182, 182, 208, 156, 195,
-			195, 234, 273, 273, 312, 130, 156, 181, 156, 181, 208, 234, 208, 234, 260, 260,
-			286, 195, 234, 273, 234, 273, 312, 351, 312, 351, 390, 390, 429},			// Long GI, 20MHz
-			{14, 29, 43, 58, 87, 116, 130, 144, 29, 58, 87, 116, 173, 231, 260, 289,
-			43, 87, 130, 173, 260, 347, 390, 433, 58, 116, 173, 231, 347, 462, 520, 578,
-			0, 87, 116, 144, 130, 173, 217, 116, 144, 144, 173, 202, 202, 231, 173, 217,
-			217, 260, 303, 303, 347, 144, 173, 202, 173, 202, 231, 260, 231, 260, 289, 289,
-			318, 217, 260, 303, 260, 303, 347, 390, 347, 390, 433, 433, 477}	},		// Short GI, 20MHz
-		{	{27, 54, 81, 108, 162, 216, 243, 270, 54, 108, 162, 216, 324, 432, 486, 540,
-			81, 162, 243, 324, 486, 648, 729, 810, 108, 216, 324, 432, 648, 864, 972, 1080,
-			12, 162, 216, 270, 243, 324, 405, 216, 270, 270, 324, 378, 378, 432, 324, 405,
-			405, 486, 567, 567, 648, 270, 324, 378, 324, 378, 432, 486, 432, 486, 540, 540,
-			594, 405, 486, 567, 486, 567, 648, 729, 648, 729, 810, 810, 891},	// Long GI, 40MHz
-			{30, 60, 90, 120, 180, 240, 270, 300, 60, 120, 180, 240, 360, 480, 540, 600,
-			90, 180, 270, 360, 540, 720, 810, 900, 120, 240, 360, 480, 720, 960, 1080, 1200,
-			13, 180, 240, 300, 270, 360, 450, 240, 300, 300, 360, 420, 420, 480, 360, 450,
-			450, 540, 630, 630, 720, 300, 360, 420, 360, 420, 480, 540, 480, 540, 600, 600,
-			660, 450, 540, 630, 540, 630, 720, 810, 720, 810, 900, 900, 990}	}	// Short GI, 40MHz
-	};
+u16 MCS_DATA_RATE[2][2][77] = {
+	{	{13, 26, 39, 52, 78, 104, 117, 130, 26, 52, 78 ,104, 156, 208, 234, 260,
+		 39, 78, 117, 234, 312, 351, 390, 52, 104, 156, 208, 312, 416, 468, 520,
+		 0, 78, 104, 130, 117, 156, 195, 104, 130, 130, 156, 182, 182, 208, 156, 195,
+		 195, 234, 273, 273, 312, 130, 156, 181, 156, 181, 208, 234, 208, 234, 260, 260,
+		 286, 195, 234, 273, 234, 273, 312, 351, 312, 351, 390, 390, 429},			// Long GI, 20MHz
+		{14, 29, 43, 58, 87, 116, 130, 144, 29, 58, 87, 116, 173, 231, 260, 289,
+		 43, 87, 130, 173, 260, 347, 390, 433, 58, 116, 173, 231, 347, 462, 520, 578,
+		 0, 87, 116, 144, 130, 173, 217, 116, 144, 144, 173, 202, 202, 231, 173, 217,
+		 217, 260, 303, 303, 347, 144, 173, 202, 173, 202, 231, 260, 231, 260, 289, 289,
+		 318, 217, 260, 303, 260, 303, 347, 390, 347, 390, 433, 433, 477}	},		// Short GI, 20MHz
+	{	{27, 54, 81, 108, 162, 216, 243, 270, 54, 108, 162, 216, 324, 432, 486, 540,
+		 81, 162, 243, 324, 486, 648, 729, 810, 108, 216, 324, 432, 648, 864, 972, 1080,
+		 12, 162, 216, 270, 243, 324, 405, 216, 270, 270, 324, 378, 378, 432, 324, 405,
+		 405, 486, 567, 567, 648, 270, 324, 378, 324, 378, 432, 486, 432, 486, 540, 540,
+		 594, 405, 486, 567, 486, 567, 648, 729, 648, 729, 810, 810, 891},	// Long GI, 40MHz
+		{30, 60, 90, 120, 180, 240, 270, 300, 60, 120, 180, 240, 360, 480, 540, 600,
+		 90, 180, 270, 360, 540, 720, 810, 900, 120, 240, 360, 480, 720, 960, 1080, 1200,
+		 13, 180, 240, 300, 270, 360, 450, 240, 300, 300, 360, 420, 420, 480, 360, 450,
+		 450, 540, 630, 630, 720, 300, 360, 420, 360, 420, 480, 540, 480, 540, 600, 600,
+		 660, 450, 540, 630, 540, 630, 720, 810, 720, 810, 900, 900, 990}	}	// Short GI, 40MHz
+};
 
 static u8 UNKNOWN_BORADCOM[3] = {0x00, 0x14, 0xbf};
 static u8 LINKSYSWRT330_LINKSYSWRT300_BROADCOM[3] = {0x00, 0x1a, 0x70};
@@ -128,8 +128,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
 	static u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_CAPABILITY_ELE		pCapELE;
 
-	if(!memcmp(CapIE, EWC11NHTCap, sizeof(EWC11NHTCap)))
-	{
+	if(!memcmp(CapIE, EWC11NHTCap, sizeof(EWC11NHTCap))) {
 		//EWC IE
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "EWC IE in %s()\n", __func__);
 		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[4]);
@@ -165,8 +164,7 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 	static u8	EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_INFORMATION_ELE		pHTInfoEle;
 
-	if(!memcmp(InfoIE, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
-	{
+	if(!memcmp(InfoIE, EWC11NHTInfo, sizeof(EWC11NHTInfo)))	{
 		// Not EWC IE
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "EWC IE in %s()\n", __func__);
 		pHTInfoEle = (PHT_INFORMATION_ELE)(&InfoIE[4]);
@@ -178,8 +176,7 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tPrimary channel = %d\n", pHTInfoEle->ControlChl);
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tSecondary channel =");
-	switch (pHTInfoEle->ExtChlOffset)
-	{
+	switch (pHTInfoEle->ExtChlOffset) {
 		case 0:
 			IEEE80211_DEBUG(IEEE80211_DL_HT, "Not Present\n");
 			break;
@@ -196,8 +193,7 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth)?"20Mhz": "40Mhz");
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tOperation mode for protection = ");
-	switch (pHTInfoEle->OptMode)
-	{
+	switch (pHTInfoEle->OptMode) {
 		case 0:
 			IEEE80211_DEBUG(IEEE80211_DL_HT, "No Protection\n");
 			break;
@@ -248,15 +244,13 @@ static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
 		retValue = false;
 	else if(!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
 		retValue = false;
-	else if(is40MHz) // ap support 40 bw
-	{
+	else if(is40MHz) { // ap support 40 bw
 		if(((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ShortGI40Mhz) // ap support 40 bw short GI
 			retValue = true;
 		else
 			retValue = false;
 	}
-	else
-	{
+	else {
 		if(((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ShortGI20Mhz) // ap support 40 bw short GI
 			retValue = true;
 		else
@@ -305,35 +299,26 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 	u8	is40MHz = 0;
 	u8	isShortGI = 0;
 
-	if(nDataRate < 12)
-	{
+	if(nDataRate < 12) {
 		return CCKOFDMRate[nDataRate];
 	}
-	else
-	{
-		if (nDataRate >= 0x10 && nDataRate <= 0x1f)//if(nDataRate > 11 && nDataRate < 28 )
-		{
+	else {
+		if (nDataRate >= 0x10 && nDataRate <= 0x1f) {  //if(nDataRate > 11 && nDataRate < 28 ) 
 			is40MHz = 0;
 			isShortGI = 0;
 
 		      // nDataRate = nDataRate - 12;
-		}
-		else if(nDataRate >=0x20  && nDataRate <= 0x2f ) //(27, 44)
-		{
+		} else if(nDataRate >=0x20  && nDataRate <= 0x2f ) { //(27, 44)
 			is40MHz = 1;
 			isShortGI = 0;
 
 			//nDataRate = nDataRate - 28;
-		}
-		else if(nDataRate >= 0x30  && nDataRate <= 0x3f )  //(43, 60)
-		{
+		} else if(nDataRate >= 0x30  && nDataRate <= 0x3f ) { //(43, 60)
 			is40MHz = 0;
 			isShortGI = 1;
 
 			//nDataRate = nDataRate - 44;
-		}
-		else if(nDataRate >= 0x40  && nDataRate <= 0x4f ) //(59, 76)
-		{
+		} else if(nDataRate >= 0x40  && nDataRate <= 0x4f ) { //(59, 76)
 			is40MHz = 1;
 			isShortGI = 1;
 
@@ -505,9 +490,7 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 	// 2008/01/28 MH We must prevent that we select null bssid to link.
 
 	if (network->broadcom_cap_exist)
-	{
 		retValue = 1;
-	}
 
 	return retValue;
 }
@@ -515,12 +498,10 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 {
 	u8	retValue = 0;
-	if(	(memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3)==0) ||
-		(memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0) ||
-		(memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ==0))
-	{
+	if((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3)==0) ||
+	   (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0) ||
+	   (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ==0))
 		retValue = 1;
-	}
 
 	return retValue;
 }
@@ -550,19 +531,16 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
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
+	if(pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE = (PHT_CAPABILITY_ELE)&(posHTCap[4]);
-	}else
-	{
+	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
 
@@ -570,13 +548,9 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//HT capability info
 	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
 	if(ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-	{
 		pCapELE->ChlWidth = 0;
-	}
 	else
-	{
 		pCapELE->ChlWidth = (pHT->bRegBW40MHz?1:0);
-	}
 
 //	pCapELE->ChlWidth		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->MimoPwrSave		= pHT->SelfMimoPs;
@@ -601,9 +575,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
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
@@ -621,8 +593,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	// 2008.06.12
 	// For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-	{
+	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
 		for(i = 1; i< 16; i++)
 			pCapELE->MCS[i] = 0;
@@ -666,15 +637,13 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
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
@@ -696,9 +665,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 
 		*len = 22 + 2; //same above
 
-	}
-	else
-	{
+	} else {
 		//STA should not generate High Throughput Information Element
 		*len = 0;
 	}
@@ -791,21 +758,19 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	u8					i;
-	if (pOperateMCS == NULL)
-	{
+	if (pOperateMCS == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
 		return false;
 	}
 
-	switch (ieee->mode)
-	{
+	switch (ieee->mode) {
 	case IEEE_A:
 	case IEEE_B:
 	case IEEE_G:
 			//legacy rate routine handled at selectedrate
 
 			//no MCS rate
-			for(i=0;i<=15;i++){
+			for(i=0;i<=15;i++) {
 				pOperateMCS[i] = 0;
 			}
 			break;
@@ -857,31 +822,25 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		bitMap;
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
-	if (pMCSRateSet == NULL || pMCSFilter == NULL)
-	{
+	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
 	}
 	for(i=0; i<16; i++)
 		availableMcsRate[i] = pMCSRateSet[i] & pMCSFilter[i];
 
-	for(i = 0; i < 16; i++)
-	{
+	for(i = 0; i < 16; i++) {
 		if(availableMcsRate[i] != 0)
 			break;
 	}
 	if(i == 16)
 		return false;
 
-	for(i = 0; i < 16; i++)
-	{
-		if (availableMcsRate[i] != 0)
-		{
+	for(i = 0; i < 16; i++) {
+		if (availableMcsRate[i] != 0) {
 			bitMap = availableMcsRate[i];
-			for(j = 0; j < 8; j++)
-			{
-				if ((bitMap%2) != 0)
-				{
+			for(j = 0; j < 8; j++) {
+				if ((bitMap%2) != 0) {
 					if(HTMcsToDataRate(ieee, (8*i+j)) > HTMcsToDataRate(ieee, mcsRate))
 						mcsRate = (8*i+j);
 				}
@@ -1022,27 +981,23 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	// <1> Decide AMPDU Factor
 
 	// By Emily
-	if(!pHTInfo->bRegRT2RTAggregation)
-	{
+	if(!pHTInfo->bRegRT2RTAggregation) {
 		// Decide AMPDU Factor according to protocol handshake
 		if(pHTInfo->AMPDU_Factor > pPeerHTCap->MaxRxAMPDUFactor)
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
+		} else {
 			if(pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
 				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
 			else
@@ -1062,12 +1017,10 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 
 	// Lanhsin: mark for tmp to avoid deauth by ap from  s3
 	//if(memcmp(pMgntInfo->Bssid, NETGEAR834Bv2_BROADCOM, 3)==0)
-	if (0)
-		{
-
-			pHTInfo->bCurrentAMPDUEnable = false;
-			pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
-			pHTInfo->ForcedAMSDUMaxSize = 7935;
+	if (0) {
+		pHTInfo->bCurrentAMPDUEnable = false;
+		pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
+		pHTInfo->ForcedAMSDUMaxSize = 7935;
 
 		pHTInfo->IOTAction |=  HT_IOT_ACT_TX_USE_AMSDU_8K;
 	}
@@ -1224,8 +1177,7 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "==============>%s()\n", __func__);
 	/*unmark bEnableHT flag here is the same reason why unmarked in function ieee80211_softmac_new_net. WB 2008.09.10*/
 //	if( pHTInfo->bEnableHT &&  pNetwork->bssht.bdSupportHT)
-	if (pNetwork->bssht.bdSupportHT)
-	{
+	if (pNetwork->bssht.bdSupportHT) {
 		pHTInfo->bCurrentHTSupport = true;
 		pHTInfo->ePeerHTSpecVer = pNetwork->bssht.bdHTSpecVer;
 
@@ -1237,13 +1189,10 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 			memcpy(pHTInfo->PeerHTInfoBuf, pNetwork->bssht.bdHTInfoBuf, pNetwork->bssht.bdHTInfoLen);
 
 		// Check whether RT to RT aggregation mode is enabled
-		if(pHTInfo->bRegRT2RTAggregation)
-		{
+		if(pHTInfo->bRegRT2RTAggregation) {
 			pHTInfo->bCurrentRT2RTAggregation = pNetwork->bssht.bdRT2RTAggregation;
 			pHTInfo->bCurrentRT2RTLongSlotTime = pNetwork->bssht.bdRT2RTLongSlotTime;
-		}
-		else
-		{
+		} else {
 			pHTInfo->bCurrentRT2RTAggregation = false;
 			pHTInfo->bCurrentRT2RTLongSlotTime = false;
 		}
@@ -1280,9 +1229,7 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 			pHTInfo->IOTAction |= HT_IOT_ACT_CDD_FSYNC;
 
 
-	}
-	else
-	{
+	} else {
 		pHTInfo->bCurrentHTSupport = false;
 		pHTInfo->bCurrentRT2RTAggregation = false;
 		pHTInfo->bCurrentRT2RTLongSlotTime = false;
@@ -1298,8 +1245,7 @@ void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct ieee80211_
 //	PHT_CAPABILITY_ELE		pPeerHTCap = (PHT_CAPABILITY_ELE)pNetwork->bssht.bdHTCapBuf;
 	PHT_INFORMATION_ELE		pPeerHTInfo = (PHT_INFORMATION_ELE)pNetwork->bssht.bdHTInfoBuf;
 
-	if (pHTInfo->bCurrentHTSupport)
-	{
+	if (pHTInfo->bCurrentHTSupport) {
 		//
 		// Config current operation mode.
 		//
@@ -1323,8 +1269,7 @@ EXPORT_SYMBOL(HTUpdateSelfAndPeerSetting);
 ********************************************************************************************************************/
 u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame)
 {
-	if (ieee->pHTInfo->bCurrentHTSupport)
-	{
+	if (ieee->pHTInfo->bCurrentHTSupport) {
 		if ((IsQoSDataFrame(pFrame) && Frame_Order(pFrame)) == 1) {
 			IEEE80211_DEBUG(IEEE80211_DL_HT, "HT CONTROL FILED EXIST!!\n");
 			return true;
@@ -1357,8 +1302,7 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 		return;
 	}
 	//if in half N mode, set to 20M bandwidth please 09.08.2008 WB.
-	if(Bandwidth==HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)))
-	 {
+	if(Bandwidth==HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))) {
 			// Handle Illegal extension channel offset!!
 		if(ieee->current_network.channel<2 && Offset==HT_EXTCHNL_OFFSET_LOWER)
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
@@ -1391,8 +1335,7 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee)
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "======>%s()\n", __func__);
 
-	if(pHTInfo->bCurBW40MHz)
-	{
+	if(pHTInfo->bCurBW40MHz) {
 		if(pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev, ieee->current_network.channel+2);
 		else if(pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_LOWER)
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
