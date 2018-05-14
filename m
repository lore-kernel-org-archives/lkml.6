Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333161-2-13253476082990313620
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
    1526333160; b=LHt6OndHLR04fBaGesCBoA21ltDnCEKkeu7VzsrHe1ZUtce+Ha
    LaxIADOw3/vXvgApuU60rshmzJ6rbe1FVZXt9zSdu8xuV9COKxSLEut+oszWnq0u
    7jvxdnqPgNHA6wbny8QrTb/ad94SEygR02iuo6GBkHJgI4Lw2MzFibd5fHW4NF/N
    CCUqo0FLtdAFYfLm8IV94Xn5I9LFIqpf57E+eZ/OWexidxUZ61ifdMOkVAYRzKat
    YTNm7vDCorCyKRrLYXAo9k36a6f2jfZEH9GrvLozVqyVG/c3rqih9yD9glrh7xTU
    yBUFNr8E+HoKlLcviT92fUY7S4S5NJg0pRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333160; bh=V7emw
    7n9K+dDiEWXjWjQM4At/kCtheFClYYUGOs4rIw=; b=ly+cfGwVy98AXBacxbtji
    WbNVqlhKmAE0Sn5d77+aYLR+UfVtP85Zgn7/wglwF3svniTaTNBWYeWHcoW8h7GA
    fY7y/kEJQ3u2+fMIf9WfWl8NdQ/ohvNhotiMl3nZbfiS5GpnJk2JxDrTpre8tLT/
    PcO+EydHVhtXaUjpMOCAHRm8OaqHvC7ZAEQM/PJ/u9qd3fvyIekGoZ1Twm6BU6Xy
    R/iIXh11GirHx69p7RWiGyAuwcPW3XVhprI0itHBgC7fW2CynOvWe9/DGIfUTki5
    pXSA+ABlKEHvoTyDddH1WKLOdIX6V7iZUazgxaxY5tCISB/Z/Bt9/Z6Rvaxn0SMf
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=UsQIe3m0 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=F394+Auu;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=UsQIe3m0 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=F394+Auu;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEFNoehjxRW1k2oJRDjlB4VIo16mZ6iF2Lhm3QzI11X5QgxxYJly+3MNf3tqrYAiMgXfsI9RBBPDeQLSORHGHIKDAj1y/F86Q4BB0+knWo0SeZa6/hs7
    RBT5StlEo27EyqhvuRsBI0fDQZm9ALJTKjP4IV/7E+T0pp6HlKoWdccWvVEGJpIEivKekLvMOKNBx5qxqP5ZS3rGfKtCi6jSKAJcqwhu5Zs7q1B+/wua87sT
    Zt3/+QdmE9uhWpcuzdNoUA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=WITqQn567fJKR0clYb8A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqGN1HLbPdBQqKY9Oud/qs0W0CFSRuYCOu/rI394GRDDlmxTinoEgtsRkh8gxlNt6Aud3JaXQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 16/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 removed blank lines before closing brace
Date: Mon, 14 May 2018 22:24:23 +0100
Message-Id: <20180514212434.17514-17-johnfwhitmore@gmail.com>
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
CHECK: Blank lines aren't necessary before a close brace '}'

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 8a15d1c6bffa..169ab97458bb 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -111,8 +111,6 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	pHTInfo->UsbRxFwAggrPacketNum = 8;
 	pHTInfo->UsbRxFwAggrTimeout = 16; ////usb rx FW aggregation timeout threshold.It's in units of 64us
 #endif
-
-
 }
 /********************************************************************************************************************
  *function:  This function print out each field on HT capability IE mainly from (Beacon/ProbeRsp/AssocReq)
@@ -148,7 +146,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
 	return;
-
 }
 /********************************************************************************************************************
  *function:  This function print out each field on HT Information IE mainly from (Beacon/ProbeRsp)
@@ -627,7 +624,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//Print each field in detail. Driver should not print out this message by default
 //	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
 	return;
-
 }
 /*******************************************************************************
  *function:  Construct  Information Element in Beacon... if HTEnable is turned on
@@ -746,10 +742,6 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 
 	posRT2RTAgg->Length = 6;
 #endif
-
-
-
-
 }
 
 
@@ -797,7 +789,6 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 	default:
 
 			break;
-
 	}
 
 	return true;
@@ -1064,9 +1055,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	// Config current operation mode.
 	//
 	pHTInfo->CurrentOpMode = pPeerHTInfo->OptMode;
-
-
-
 }
 
 void HTSetConnectBwModeCallback(struct ieee80211_device *ieee);
@@ -1247,7 +1235,6 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 
 		pHTInfo->IOTAction = 0;
 	}
-
 }
 
 void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct ieee80211_network *pNetwork)
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
