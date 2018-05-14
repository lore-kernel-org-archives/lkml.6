Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1006072-1526313261-3-7664287971084941408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313260; b=NTpxCV+CyfOCTNUZ5CBwWP8OfSu2F+jr6duzrDJ2e+lNPriR4D
    UBBN1BLfALvsVi94bk5Zn05Ttsjp98p7XdQwUc11cuiKbsBKvYhA306Zx2BlGitR
    jjOhzpKYG87VvlPZrEamlprMMwG0YRk2vy7zOVghelq4o4h2ZwxUbU89X7kGOU4x
    jUiR6desSxMkIWUIxgyzfROLxeHxPfsV8yL6xYW4CjgKbustBWfefkv7PSlJSrCw
    ag7ZkiF/BR490XZt1hBvmBhh8kf71SRaD3DTfgevQQgPjSoSugeVKbbHuinkDkfE
    XdkIjbfYmGE4AknjnNEN0VTmx2VLrBbOzkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313260; bh=y92Mz
    bPEQT9ZIN6PIlfVe8wbIqLIYUmPhTYxIi716d8=; b=WCKZfOrBusWLCJWOMloms
    EjQ1K6XQNlQRHm8GoTz40QvP5e4tVle6zppe0AQWox1MLXJws/mzs2sYvQcq5vqF
    JJED7eUiwQPXWLF02nMIa8HVmcPVsaJ9hEM7HRzEdW7nZ0dFWh0rnb1AS2DNP9BM
    tgIBTO14tD1DWFom9MNiMPXX1a2k827/QJvUxwVOI1270z4FWrEtZjm8bdgEaNN+
    Rerf7+X+UeAlh5q2AXn/Gsn4ffgGbUFGrujcS4Qkth1JxanfRkn1sSuxNDFsV8pi
    eYOC0Tu5j2pC5VBJJA0AfMWr/nxq9Mc8UbajwZMNhhJfna4U8VVl4kVqiVm9Rb4C
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=kPrtTbUS x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=qRaPfDHi;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=kPrtTbUS x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=qRaPfDHi;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEt4g4eCTVlWjby+JpbkCpfAL4Nn3uD4it85js2KgKtE1dVFYvElTpN0QHdyJmabqdRQT48zYLUdp2B6WAZMPA7Qs03EYOEJ7XuhhZGF52dd8QXcEOke
    fw15SbULCYXFnsEt4qllCvx+4LTyVOf0UazjOWMCLB8YWJVeGjY4QYRg2I0oMZVHwARVfCL/fcnY0sSbf/kQ2Cfud+gCtlu+9Y+/Z05auRh/rDdpc5o1sowj
    Q1pZBgfCOIT0oi/yWVbxNQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=BO2vPp5KF_I-iTR2grIA:9
    a=ed13m9nd3d4js7VU:21 a=k2O6FS5cqVtA1VSV:21 a=CjuIK1q_8ugA:10
    a=Ep1hS7IbJHIA:10 a=HqMrfUhOb-sA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZorCFXTlcUPOsJXhcvja1+OOeIsJZ0jqjA2N+v3Pt/lN7JuCDaw/KhST/CQIxidPQoPuEuuIw==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 04/13] coding style corrections, spaces around ',
 ' characters and removal of blank lines
Date: Mon, 14 May 2018 16:53:09 +0100
Message-Id: <20180514155318.32195-5-johnfwhitmore@gmail.com>
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
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 134 +++++++--------------
 1 file changed, 42 insertions(+), 92 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 9366b62343af..110fa8ba15db 100644
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
+	{	{13, 26, 39, 52, 78, 104, 117, 130, 26, 52, 78, 104, 156, 208, 234, 260,
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
@@ -44,7 +44,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
 
 /*
  * 2008/04/01 MH For Cisco G mode RX TP We need to change FW duration. Should we
- * put the code in other place?? 
+ * put the code in other place??
  * static u8 WIFI_CISCO_G_AP[3] = {0x00, 0x40, 0x96};
  */
 /*******************************************************************************
@@ -114,12 +114,10 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	pHTInfo->UsbRxFwAggrPacketNum = 8;
 	pHTInfo->UsbRxFwAggrTimeout = 16; ////usb rx FW aggregation timeout threshold.It's in units of 64us
 #endif
-
-
 }
 
 /*******************************************************************************
- *function:  This function print out each field on HT capability IE mainly 
+ *function:  This function print out each field on HT capability IE mainly
  *           from (Beacon/ProbeRsp/AssocReq)
  *   input:  u8*	CapIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
@@ -128,9 +126,8 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
  *  notice:  Driver should not print out this message by default.
  *******************************************************************************
  */
-void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
+void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 {
-
 	static u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_CAPABILITY_ELE		pCapELE;
 
@@ -141,7 +138,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
 	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[0]);
 	}
-	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString );
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString);
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth)?"20MHz": "20/40MHz");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->ShortGI20Mhz)?"YES": "NO");
@@ -154,11 +151,10 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
 	return;
-
 }
 
 /*******************************************************************************
- *function:  This function print out each field on HT Information IE mainly 
+ *function:  This function print out each field on HT Information IE mainly
  *           from (Beacon/ProbeRsp)
  *   input:  u8*	InfoIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
@@ -169,7 +165,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
  */
 void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 {
-
 	static u8	EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_INFORMATION_ELE		pHTInfoEle;
 
@@ -270,7 +265,6 @@ static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
 
 u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 {
-
 	u8	is40MHz;
 	u8	isShortGI;
 
@@ -280,7 +274,6 @@ u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
 }
 
-
 u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -304,7 +297,7 @@ u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 {
 	//PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
-	u16		CCKOFDMRate[12] = {0x02 , 0x04 , 0x0b , 0x16 , 0x0c , 0x12 , 0x18 , 0x24 , 0x30 , 0x48 , 0x60 , 0x6c};
+	u16		CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18, 0x24, 0x30, 0x48, 0x60, 0x6c};
 	u8	is40MHz = 0;
 	u8	isShortGI = 0;
 
@@ -316,17 +309,17 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 			isShortGI = 0;
 
 		      // nDataRate = nDataRate - 12;
-		} else if (nDataRate >=0x20  && nDataRate <= 0x2f ) { //(27, 44)
+		} else if (nDataRate >=0x20  && nDataRate <= 0x2f) { //(27, 44)
 			is40MHz = 1;
 			isShortGI = 0;
 
 			//nDataRate = nDataRate - 28;
-		} else if (nDataRate >= 0x30  && nDataRate <= 0x3f ) { //(43, 60)
+		} else if (nDataRate >= 0x30  && nDataRate <= 0x3f) { //(43, 60)
 			is40MHz = 0;
 			isShortGI = 1;
 
 			//nDataRate = nDataRate - 44;
-		} else if(nDataRate >= 0x40  && nDataRate <= 0x4f ) { //(59, 76)
+		} else if (nDataRate >= 0x40  && nDataRate <= 0x4f) { //(59, 76)
 			is40MHz = 1;
 			isShortGI = 1;
 
@@ -336,8 +329,6 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 	}
 }
 
-
-
 bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
@@ -382,7 +373,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
 		 (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
 		 (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
-		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0) )
+		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0))
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
 	else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
 		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
@@ -413,8 +404,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 {
 	return 0;
- }
-
+}
 
 /**
  * Function:	HTIOTActIsDisableMCS15
@@ -517,16 +507,13 @@ static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 	u8	retValue = 0;
 	if ((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3)==0) ||
 	    (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0) ||
-	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ==0)) {
+	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ==0))
 		retValue = 1;
-	}
 
 	return retValue;
 }
 
-void HTResetIOTSetting(
-	PRT_HIGH_THROUGHPUT		pHTInfo
-)
+void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo)
 {
 	pHTInfo->IOTAction = 0;
 	pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
@@ -558,12 +545,10 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE = (PHT_CAPABILITY_ELE)&(posHTCap[4]);
-	}else
-	{
+	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
 
-
 	//HT capability info
 	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
@@ -586,7 +571,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
-
 	//MAC HT parameters info
 	// TODO: Nedd to take care of this part
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n", pCapELE->ChlWidth, pCapELE->MaxAMSDUSize, pCapELE->DssCCk);
@@ -621,7 +605,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//Extended HT Capability Info
 	memset(&pCapELE->ExtHTCapInfo, 0, 2);
 
-
 	//TXBF Capabilities
 	memset(pCapELE->TxBFCap, 0, 4);
 
@@ -633,14 +616,11 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	else
 		*len = 26 + 2;
 
-
-
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, posHTCap, *len -2);
 
 	//Print each field in detail. Driver should not print out this message by default
 //	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
 	return;
-
 }
 
 /*******************************************************************************
@@ -668,26 +648,24 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	memset(posHTInfo, 0, *len);
 	if ( (ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) { //ap mode is not currently supported
 		pHTInfoEle->ControlChl			= ieee->current_network.channel;
-		pHTInfoEle->ExtChlOffset			= ((!pHT->bRegBW40MHz)?HT_EXTCHNL_OFFSET_NO_EXT:
+		pHTInfoEle->ExtChlOffset		= ((!pHT->bRegBW40MHz)?HT_EXTCHNL_OFFSET_NO_EXT:
 											(ieee->current_network.channel<=6)?
 												HT_EXTCHNL_OFFSET_UPPER:HT_EXTCHNL_OFFSET_LOWER);
 		pHTInfoEle->RecommemdedTxWidth	= pHT->bRegBW40MHz;
-		pHTInfoEle->RIFS					= 0;
+		pHTInfoEle->RIFS			= 0;
 		pHTInfoEle->PSMPAccessOnly		= 0;
 		pHTInfoEle->SrvIntGranularity		= 0;
-		pHTInfoEle->OptMode				= pHT->CurrentOpMode;
+		pHTInfoEle->OptMode			= pHT->CurrentOpMode;
 		pHTInfoEle->NonGFDevPresent		= 0;
 		pHTInfoEle->DualBeacon			= 0;
 		pHTInfoEle->SecondaryBeacon		= 0;
 		pHTInfoEle->LSigTxopProtectFull		= 0;
-		pHTInfoEle->PcoActive				= 0;
-		pHTInfoEle->PcoPhase				= 0;
+		pHTInfoEle->PcoActive			= 0;
+		pHTInfoEle->PcoPhase			= 0;
 
 		memset(pHTInfoEle->BasicMSC, 0, 16);
 
-
 		*len = 22 + 2; //same above
-
 	} else {
 		//STA should not generate High Throughput Information Element
 		*len = 0;
@@ -758,17 +736,11 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 		posRT2RTAgg->Octet[5] &= 0xfb;
 	}
 	*/
-
 #else
 	// Do Nothing
 #endif
-
 	posRT2RTAgg->Length = 6;
 #endif
-
-
-
-
 }
 
 /*******************************************************************************
@@ -877,8 +849,6 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	return (mcsRate|0x80);
 }
 
-
-
 /*
  *
  *1.Filter our operation rate set with AP's rate set
@@ -891,7 +861,6 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
-
 	u8 i=0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
@@ -899,7 +868,6 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i]&pSupportMCS[i];
 	}
 
-
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
 
 	/*
@@ -955,7 +923,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	else
 		pPeerHTInfo = (PHT_INFORMATION_ELE)(pHTInfo->PeerHTInfoBuf);
 
-
 	////////////////////////////////////////////////////////
 	// Configurations:
 	////////////////////////////////////////////////////////
@@ -988,7 +955,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	pHTInfo->bCurSuppCCK = pHTInfo->bRegSuppCCK &&
 			       (pPeerHTCap->DssCCk == 1);
 
-
 	//
 	// Config and configure A-MSDU setting
 	//
@@ -1001,7 +967,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	else
 		pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
 
-
 	//
 	// Config A-MPDU setting
 	//
@@ -1016,7 +981,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 			pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
 		else
 			pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
-
 	} else {
 		// Set MPDU density to 2 to Realtek AP, and set it to 0 for others
 		// Replace MPDU factor declared in original association response frame format. 2007.08.20 by Emily
@@ -1090,9 +1054,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	// Config current operation mode.
 	//
 	pHTInfo->CurrentOpMode = pPeerHTInfo->OptMode;
-
-
-
 }
 
 void HTSetConnectBwModeCallback(struct ieee80211_device *ieee);
@@ -1142,8 +1103,6 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
-
-
 	// Initialize all of the parameters related to 11n
 	memset((void *)(&(pHTInfo->SelfHTCap)), 0, sizeof(pHTInfo->SelfHTCap));
 	memset((void *)(&(pHTInfo->SelfHTInfo)), 0, sizeof(pHTInfo->SelfHTInfo));
@@ -1181,7 +1140,6 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
  */
 void HTInitializeBssDesc(PBSS_HT pBssHT)
 {
-
 	pBssHT->bdSupportHT = false;
 	memset(pBssHT->bdHTCapBuf, 0, sizeof(pBssHT->bdHTCapBuf));
 	pBssHT->bdHTCapLen = 0;
@@ -1260,7 +1218,6 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_ALL_2SS;
 
-
 		bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
@@ -1272,18 +1229,13 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 		bIOTAction = HTIOTActIsCCDFsync(pNetwork->bssid);
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_CDD_FSYNC;
-
-
-	}
-	else
-	{
+	} else {
 		pHTInfo->bCurrentHTSupport = false;
 		pHTInfo->bCurrentRT2RTAggregation = false;
 		pHTInfo->bCurrentRT2RTLongSlotTime = false;
 
 		pHTInfo->IOTAction = 0;
 	}
-
 }
 
 void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct ieee80211_network *pNetwork)
@@ -1337,8 +1289,6 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
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
