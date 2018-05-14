Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1006072-1526313255-2-11081177283283227309
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
    1526313255; b=T3PNfCWuRun+zHWEbEqaetBtAVgZBAHT9y9+SXGOWPTBn06/w4
    0npR8oVORYlVLsHqJ7zfFYlEMmVVf1v/zpgNBJG17tqUWOH59BsljU6YRs6i+hG6
    f4E6S4IWUeMFU6v7I75TwlRAxQb9usx5/y8KK17Zg730MUD7mjox846OkcipnOxU
    TsIT6vQSkJOVpNaWAUZavGPLyD07Ib/ExUrhTl5dkBajZqGD8H0BJpSiMqFH4F2Q
    w1MDX7EBcaMCvZE8Y9SgfEPqhyunqjkAhEI56zAECFhU3DUQfZQCYzCiXj1uVjQH
    KHuY6JZkrBFvL8LEeOBlhwEZ9ePgiPmHKK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313255; bh=WrKsj
    r8yvN8QC4g0riMHkjXapHEQZkCeTSngW/UFj4M=; b=kpNwAQHZhI80BKHNIp8NG
    BRFzGUbE5KrhysChgq9EAJ1kiLNpcpy27ZM12ZbWxiCkJgHVrjaduUb5UwHu4m/3
    NY7QifnIbc2roAD7NuY/VLRVGCckgqiZGdBpufHs9F94amG3n5RGc5Z+nrCkVoid
    C06hY/NCotyLRmgT6qbxLmRBzu5cb27+rifB/EUITaRTQ7T9qcaktq5iPxKyfBZt
    +//D6FXZyc/+Z2iO14GTwic+Tjo/FwuFLNsBhmP0/znJ5Zq3Eo6R7ofQgjRjd4qw
    CUpTVnS6J8d3cG7Wa0geZ38BjhNrcNuh2vj/3EDRYdGML2FCuFqr9ddXbaK1hm0U
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=fCw+18C1 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Ubn+o+yR;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=fCw+18C1 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Ubn+o+yR;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG82qpzEBpdNWGS3/U1Z2IIuDyQvsQZrfKtkl/BI0Yli1YsQ+Z1n7ncLrT1W+vtdqfQKSmfzixXW0FF8A4SI6jETZfXI6m+5F3K1GGa6RZDkNxduE/+E
    SWFPLIfigU8jG75f/ZQEwsOH2jGMyz72W8l7gquIDVvBOpqXosk6562oZQTUjVxBnqOoq2b7AehfWgvDf/3cPBci5Jbt6+5c/B2T/WaVM3i0UYU3KQKt+he7
    NCV5ap9kLjyGxMUsScaCVA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=ICClhKE7QvobOOwaOyMA:9
    a=vfcqG2VjIht3rAmX:21 a=X3G0BAjitsYYVkfM:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrSWDeFhY9z4ot3wLs3wGN6UdgXH/NhU9E/Dl8mutt77DdE06EnEBHUacpA1Tq3CyoU+4mtCg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 02/13] coding style chages to the switch statements in the
 file.
Date: Mon, 14 May 2018 16:53:07 +0100
Message-Id: <20180514155318.32195-3-johnfwhitmore@gmail.com>
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
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 93 ++++++++++------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 17a720966253..9e596577e544 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -187,38 +187,36 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tPrimary channel = %d\n", pHTInfoEle->ControlChl);
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tSecondary channel =");
-	switch (pHTInfoEle->ExtChlOffset)
-	{
-		case 0:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Not Present\n");
-			break;
-		case 1:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Upper channel\n");
-			break;
-		case 2:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Reserved. Eooro!!!\n");
-			break;
-		case 3:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Lower Channel\n");
-			break;
+	switch (pHTInfoEle->ExtChlOffset) {
+	case 0:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Not Present\n");
+		break;
+	case 1:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Upper channel\n");
+		break;
+	case 2:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Reserved. Eooro!!!\n");
+		break;
+	case 3:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Lower Channel\n");
+		break;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth)?"20Mhz": "40Mhz");
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tOperation mode for protection = ");
-	switch (pHTInfoEle->OptMode)
-	{
-		case 0:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "No Protection\n");
-			break;
-		case 1:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "HT non-member protection mode\n");
-			break;
-		case 2:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Suggest to open protection\n");
-			break;
-		case 3:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "HT mixed mode\n");
-			break;
+	switch (pHTInfoEle->OptMode) {
+	case 0:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "No Protection\n");
+		break;
+	case 1:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "HT non-member protection mode\n");
+		break;
+	case 2:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Suggest to open protection\n");
+		break;
+	case 3:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "HT mixed mode\n");
+		break;
 	}
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tBasic MCS Rate Set = [%x][%x][%x][%x][%x]\n", pHTInfoEle->BasicMSC[0],\
@@ -821,36 +819,33 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 		return false;
 	}
 
-	switch (ieee->mode)
-	{
+	switch (ieee->mode) {
 	case IEEE_A:
 	case IEEE_B:
 	case IEEE_G:
-			//legacy rate routine handled at selectedrate
+		//legacy rate routine handled at selectedrate
 
-			//no MCS rate
-			for(i=0;i<=15;i++){
-				pOperateMCS[i] = 0;
-			}
-			break;
+		//no MCS rate
+		for(i=0;i<=15;i++){
+			pOperateMCS[i] = 0;
+		}
+		break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
 	case IEEE_N_5G:
-			// Legacy part we only use 6, 5.5,2,1 for N_24G and 6 for N_5G.
-			// Legacy part shall be handled at SelectRateSet().
-
-			//HT part
-			// TODO: may be different if we have different number of antenna
-			pOperateMCS[0] &=RATE_ADPT_1SS_MASK;	//support MCS 0~7
-			pOperateMCS[1] &=RATE_ADPT_2SS_MASK;
-			pOperateMCS[3] &=RATE_ADPT_MCS32_MASK;
-			break;
+		// Legacy part we only use 6, 5.5,2,1 for N_24G and 6 for N_5G.
+		// Legacy part shall be handled at SelectRateSet().
 
-	//should never reach here
-	default:
-
-			break;
+		//HT part
+		// TODO: may be different if we have different number of antenna
+		pOperateMCS[0] &=RATE_ADPT_1SS_MASK;	//support MCS 0~7
+		pOperateMCS[1] &=RATE_ADPT_2SS_MASK;
+		pOperateMCS[3] &=RATE_ADPT_MCS32_MASK;
+		break;
 
+		//should never reach here
+	default:
+		break;
 	}
 
 	return true;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
