Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-995127-1526313265-2-4056108455776984938
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313264; b=KtqKlS50G3+1MFtpt1NJnXUqj9PzKgZiVP6ZZ6Z1S+fwXwGZAl
    mo3mZrttEatwZo5W6bvt1D4XUqml0XvpUzusEdgO1+KtN+YM+5kZMg17w6/40Sss
    ngMwqDU/OG21iWzBgOHvd2/KcZx6EOVQX/BPXSKFTUx9Ml8bDCvuwmxMtnWQe9EA
    ZTQuJj/BmtDKE6NrToMysYLvblJdSHAs7v1DavKn0YN1mc+UMyRGYzsvaP+ZnkdZ
    87BHJ+jv2mWtYKt7JpF3XkkbVgL64BZgMGah4Omq/Flk5nhec5xOsyab4wblyKIC
    5sJd8hG1/lj9ys+yeiQ/dLgevR/rB8395vvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313264; bh=gUcoJ
    Ff6S4Om0piaR3bT9M2tVD62z/YtF9euHw6QdRc=; b=HFzUFRcOjxtT6Mlx3ztE2
    47hUjNUHc8yteaG1l6vQM8+3L2n0eom4biIyHBoJdF2mY2ZECOed9eAJ9feUcrVJ
    6K9hpPTdlcfU4OAjA7E/Ic3SB4JoZMt0ZOWtYb9kHnNTiKpYy8WgmVKL3gm4ZrQZ
    D+EYPFLSzklkGSlDloM+wb2qL4JR7JDBJ2dZR9GC5+odKDNMcxNLPe34sG7NE+na
    3azx9/NchwofNq650ZZj43x3NSgvMgCAdZq/U9m9vt90BzEgtSbWMl6GpKwi8CIv
    L8oY/NbND8uKuOGBQI2XaayGa6/xp0vyrA+ol/hm/SbCNEqjJhT0dzkO//nDdXsy
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=RJbzML1J x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ND4HIlcP;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=RJbzML1J x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ND4HIlcP;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHuC0xGziyEj1732HzWwuSLprVjx7RLzhxBrwLLQqSfdBK4IqydBJTDJJjeE92iEdWePI+c/f3koE4c3CCOLoxdHLNeQT0w7AoJpjKSxgeI1msoBS9UZ
    zRDTIlDY7OG8q0IlqpvKL4RPUNU3JnA19+PFNSyAVw6LpDBI+JNl+pfM1RwC0wHqDVDMX8ovyhzn59LWw8rBsq561zBKhwnxiu5TsSjo/WF2k/tR3sCUy37j
    JpIhSo378RwGJGNXQxUXmw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=26EkWuy_hZEYXS-WM60A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqB6kO1ggb1vrbRYwg4sCz0/Fr8G9KSlf1bmMGVTPuoSe35QoqQfZERnhEABCQOmCxTOKf+zw==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 06/13] Coding style, removal of redundant braces.
Date: Mon, 14 May 2018 16:53:11 +0100
Message-Id: <20180514155318.32195-7-johnfwhitmore@gmail.com>
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
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 925a8f313e9f..13f1eee7d8b1 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -544,7 +544,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (PHT_CAPABILITY_ELE) & (posHTCap[4]);
+		pCapELE = (PHT_CAPABILITY_ELE) & posHTCap[4];
 	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
@@ -1104,10 +1104,10 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
 	// Initialize all of the parameters related to 11n
-	memset((void *)(&(pHTInfo->SelfHTCap)), 0, sizeof(pHTInfo->SelfHTCap));
-	memset((void *)(&(pHTInfo->SelfHTInfo)), 0, sizeof(pHTInfo->SelfHTInfo));
-	memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0, sizeof(pHTInfo->PeerHTCapBuf));
-	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0, sizeof(pHTInfo->PeerHTInfoBuf));
+	memset((void *)(&pHTInfo->SelfHTCap), 0, sizeof(pHTInfo->SelfHTCap));
+	memset((void *)(&pHTInfo->SelfHTInfo), 0, sizeof(pHTInfo->SelfHTInfo));
+	memset((void *)(&pHTInfo->PeerHTCapBuf), 0, sizeof(pHTInfo->PeerHTCapBuf));
+	memset((void *)(&pHTInfo->PeerHTInfoBuf), 0, sizeof(pHTInfo->PeerHTInfoBuf));
 
 	pHTInfo->bSwBwInProgress = false;
 	pHTInfo->ChnlOp = CHNLOP_NONE;
@@ -1123,7 +1123,7 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 
 	//MCS rate initialized here
 	{
-		u8 *RegHTSuppRateSets = &(ieee->RegHTSuppRateSet[0]);
+		u8 *RegHTSuppRateSets = &ieee->RegHTSuppRateSet[0];
 		RegHTSuppRateSets[0] = 0xFF;	//support MCS 0~7
 		RegHTSuppRateSets[1] = 0xFF;	//support MCS 8~15
 		RegHTSuppRateSets[4] = 0x01;	//support MCS 32
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
