Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526333138-2-15322245213030912901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333137; b=fmR/S/QUvdijwr7BKpfbQ5iauJ28VQzFNHoq2rZ9MmLmClLnuy
    1TL/dRHwkUUed47Js6hMzV/nEhVNgkDFPoNNMtNtZRu7WURimI/+sN9usArUrn+D
    eN7OEZ/MrKZQpo5vTkuVu5f5pPJr/Ms3St3l150hZH54HaRUu8WGZz3Fekd8GwCD
    RZPte+nxS5Iph2L1R7lHIhp6Av2uxY0y0tUPvE3uYLwV2GK4N7fmZrD/Hayaub5K
    bwXUiJuA1WgK70Zsuf6OxH8Ya6+M8nv0g5ZIOww+v9MNrVDcuxk7rl9fkW0VcHnH
    jeoSfmMpHNMPc6yvHPvBJQdooG1PZYp/FGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333137; bh=FmdRD
    DWsIjtgA7qxZAcx2cwU0DtiNFOtlxWuF6hp/fQ=; b=nxRkOGLaqGI7Tg3NQ4rpk
    iIYcR2EOfU87zTuf6frSTH3xD5Fa0pTBlov2PBKWjYOQHwbzwrXnxYIZT0lOQSp6
    e4CGwDnW42oLN4FJUXGzXlmhlI2bdBhl1hJLJAYKXYJ22Hsj99pM0TrdG9Wzljud
    Zo9eFMLe0ixavIM8cMuwrNvENactX810QrQj42EXZHqGEB05KV2I+q3VvgMIXm8y
    P/73J6yTNq/j1jFzJb9MJK1rkVLR3tja+nLqNXp7SuIpXryl09I2yH9mbyv0Hy0i
    KHSx9xlaabEz2pNh6LMsDbbVgmk8aiinqBoCBqqH0f2cFodj6UyfpE+AhuFE2rzq
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=jAgHD383 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=pcG+Z0fD;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=jAgHD383 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=pcG+Z0fD;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIloW77oriNj7Ja3yF/EgV/Qxgc659cusSDr+fQcnR4lGQTOsiKtF8qNX4PdlAbtrzYxdIFZ9cRKAnIWJC3LFyHbPgvVTSVYm3wuCykAVpJsNNWpP7NY
    C+HP95je+kYHfw45yFovm1JYcYKprBRQiDIen5bhc5llg7AF0DB0JXUn413MZMTyihqotbG3Sh7c9Zrm0cM207CCnrK29/bqkBW5QbINXh19vwvDpoR3IcpN
    a2UV+NvjpyUeCbdMFFYTHQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=OV7wJZRjjcgp9tdneZAA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqI6DR04lydJXKOfL7XfE3UQCCpn05Szm7Cv6L8ghE5EJxAXgFvKrF0oheM6iWSjuF9AJzXVQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 15/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc: Use
 __func__ instead of hardcoded function name
Date: Mon, 14 May 2018 22:24:22 +0100
Message-Id: <20180514212434.17514-16-johnfwhitmore@gmail.com>
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

Coding style edit to clear the checkpatch.pl warnings:
WARNING: Prefer using '"%s...", __func__' to using 'xxxx', this function's name, in a string

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 3a636807226e..8a15d1c6bffa 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -536,7 +536,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//u8 bIsDeclareMCS13;
 
 	if ((posHTCap == NULL) || (pHT == NULL)) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in HTConstructCapabilityElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in %s\n", __func__);
 		return;
 	}
 	memset(posHTCap, 0, *len);
@@ -646,7 +646,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
 
 	if ((posHTInfo == NULL) || (pHTInfoEle == NULL)) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in %s\n", __func__);
 		return;
 	}
 
@@ -712,7 +712,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
 	if (posRT2RTAgg == NULL) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in HTConstructRT2RTAggElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in %s\n", __func__);
 		return;
 	}
 	memset(posRT2RTAgg, 0, *len);
@@ -766,7 +766,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 	u8					i;
 
 	if (pOperateMCS == NULL) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in %s\n", __func__);
 		return false;
 	}
 
@@ -831,7 +831,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		availableMcsRate[16];
 
 	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in %s\n", __func__);
 		return false;
 	}
 	for (i = 0; i < 16; i++)
@@ -912,7 +912,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	static u8				EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 
 	if (!pHTInfo->bCurrentHTSupport) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== HTOnAssocRsp(): HT_DISABLE\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== %s: HT_DISABLE\n", __func__);
 		return;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "===> HTOnAssocRsp_wq(): HT_ENABLE\n");
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
