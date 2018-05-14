Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526333139-2-17881893628693794268
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
    1526333138; b=iA73dXW7kK9oXahuhBGtqDVsE7DW9+zw4bkLVydZIhl364wkU/
    Ok+S4UfRTdwNS+/+kPhpsyPdpY7v9X4RdZf9JDkdaaD4+d/wCqJDWO2ALTLELRJr
    mcRcCsz/ftxKxtmL22VX/NTmo1jT/UdVEhRyE2Hr5uBY7UJo/nphB2J9p7Fx6WXk
    MGaEppauvqcvVoPu3ftSyKzvXsVy7iUBWBhULN4jLg1Jt6MRwH8tRerFcVTGH9tV
    BqQhbI02lBPFJ7XlKuhtLtJMfVbcgrUBgEfhLflu+8QtjFgqk+RFM7S5tQ7v/rPD
    hk3xmgrhCohn2QXDhDOTgOO5WQMKETU38Pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333138; bh=i6/yE
    JR3M/eoVjLz7lBYa7lDm2c5w8zdxhLVIKG/l/8=; b=KRUcf7VxMy8jjQEcZvi3F
    m3vg2BaqWM/7lia962RaSAzxyP4ljuwOUtHXN7rdBqCUUrqn21StDDD3CNlXPf4b
    1Z0TXUA17DhMQDVqtmyh9iQkCk5XRVXZds/Yl2tXkWc+Nqz2448EbqSuRqNB1rxK
    FuTYUPJY6RARUBFrWH1+GxSJ8XP4PoK4y97iueio4A7glTBmRO1/kZSsmynVSwKV
    X/Ccy7WHL1J8/jQZWwK60gq8p1tYx3vCFEzAPkmK5iM0t2rtJnOGCoMb3ldZvNcI
    a6akgV04VuhoJAvNvkXRGFzsEgAyhfFkcLIuv3jNzCbQEPYJORAwvbRdg6Gjbcrq
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=hoHikdnk x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=kaHLKuga;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=hoHikdnk x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=kaHLKuga;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMcbLaTYXLrG70k6lKUV90UrOaoiQjq2fi6gtpge7QL0XC8f213qp6KiTxCKvRIjkEeLvBNJFJM2c72uJLaZl1ioeU5uBNzT6DZWDJKhrU7NFTWF+Pfz
    JDr1p9sCBYhB64ngsU1XwpAooNk532s5coB/nphGpqCt1EIEXpH1Ms3LpDF+adLrf+zLihXJ056LzyVPjV1JMBl5+NFd+FF+Z0OJtmCIl4G/p94id+HxxAyP
    L9pg3aG34ISQub7WSLBVYQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=pCj9n-6QN54DNgfV6ygA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZq++eRQ18FTMy83wzyIfNKRMejE/HBoXBS5utJpGkuPvbIYO/VJmjse5ximCxZryOcjuOPQmA==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 17/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 Added blank line after function
Date: Mon, 14 May 2018 22:24:24 +0100
Message-Id: <20180514212434.17514-18-johnfwhitmore@gmail.com>
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
CHECK: Please use a blank line after function/struct/union/enum declarations

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 169ab97458bb..9dd025b22ac4 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -112,6 +112,7 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	pHTInfo->UsbRxFwAggrTimeout = 16; ////usb rx FW aggregation timeout threshold.It's in units of 64us
 #endif
 }
+
 /********************************************************************************************************************
  *function:  This function print out each field on HT capability IE mainly from (Beacon/ProbeRsp/AssocReq)
  *   input:  u8*	CapIE       //Capability IE to be printed out
@@ -147,6 +148,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
 	return;
 }
+
 /********************************************************************************************************************
  *function:  This function print out each field on HT Information IE mainly from (Beacon/ProbeRsp)
  *   input:  u8*	InfoIE       //Capability IE to be printed out
@@ -387,6 +389,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 
 	IEEE80211_DEBUG(IEEE80211_DL_IOT, "Joseph debug!! IOTPEER: %x\n", pHTInfo->IOTPeer);
 }
+
 /*******************************************************************************
  *function:  Check whether driver should declare received rate up to MCS13 only since some chipset is not good
  *	     at receiving MCS14~15 frame from some AP.
@@ -625,6 +628,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 //	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
 	return;
 }
+
 /*******************************************************************************
  *function:  Construct  Information Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
@@ -890,6 +894,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 
 	return true;
 }
+
 void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidth, HT_EXTCHNL_OFFSET	Offset);
 void HTOnAssocRsp(struct ieee80211_device *ieee)
 {
@@ -1130,6 +1135,7 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 		RegHTSuppRateSets[4] = 0x01;	//support MCS 32
 	}
 }
+
 /*******************************************************************************
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  PBSS_HT pBssHT //to be initialized
@@ -1152,6 +1158,7 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 	pBssHT->bdRT2RTAggregation = false;
 	pBssHT->bdRT2RTLongSlotTime = false;
 }
+
 /*******************************************************************************
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  struct ieee80211_device	*ieee
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
