Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526333129-2-3995369142631503467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333128; b=MA5hclg0oMcmFsrjVl0rOUUlelfq5mVkLbooFTBSizQQMnbPvq
    OgsD6d/XUxvPkG+Fd7u1UagFYndY8T3B2b+EnfxQ44ZHiXGhC9tVES8IuzFdOFi2
    GZxJrzLGu3VNawqnDl2C1OHIm9BlcVqkaJLPTqAvRNMWqwMHx812N6wLHf9X3RPA
    id02JyhX0lBqKJWepBpga3wb19rbVHoAJs38Shd8YkwNy1rTq+u7HgYwwrmvgiKN
    A0Lv8y4x157Nvi0YPd7NTnzdw+VOBExkJKZ6yvzTLSt1eAHiBlWZiA0GnkqXykmI
    Ix9mOeZwKHZmyrZs/WboF4ILs6hEa6t3AIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333128; bh=zuG5w
    PJOCgPpuc6/gB1tzVqsvtwB9FNn6P09dPt5Kbc=; b=hMb5T5/AXwkBCnJbtLXqN
    U1Jntc2ALQHkZyfVVyPXrG7VhrOqCuLgkqbuaPU/igpEGKGaby0jd4m6oqKOvFkJ
    6tvDY8F8shuXAD8rfijQBSsYadpDtch4J7qKvtQvARjIB+I2XKSS0F0xdcfvHx2d
    +Su4zkAt9U7Xnz1WUj2/TSBBmJ8t11nc3uQBVWg0pQxOETQjdSDNLyEs4b2WZdio
    Rjd7RBmxOfavt/V2DppEr3XYhbFzQVJ7fqID/ViujFyG2LEkwZDHyhImA6bhvSvR
    psFcnMhY6/5HTuB+FOLrHlnbcOhceZxIBFwDO9oazlGx+Om0J8HBiGZoMlP177sx
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=vTEZrD9r x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=aSLzefIm;
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
      header.d=gmail.com header.i=@gmail.com header.b=vTEZrD9r x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=aSLzefIm;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEGEFS87WAOE51t/TueDdXhSvme5DPVYt+JAujxbIs9sp4ee5qcUuKFyE+vExRbmTnqdEpbKA3tPw0d6Y35tR/pfJUWnXu49/IoSsKYn6ZHs71n+phwM
    r+7yvjxelEKSxTlaafZvsoD6xHiFiCguoN9KJzOKzLUAj07IC+C38NUooNJ2Ty0lJXL2Id1q1XM8XGmhgrFEl1ZpMXpjg8+scPYVUNWS82z7YY5VnvKAhny0
    qgLOZZA8YlJzpEGQXQYL+w==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=39JwvMfCM79tpJhhDJoA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpMZuuRkYhfJvPUw1kRlVTRGmxzg9PM6CtxfljxXN7Wo3LMK/NAL+pL68d5Ryp20dzxb6PN0w==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 10/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 Added missing blank line after declarations.
Date: Mon, 14 May 2018 22:24:17 +0100
Message-Id: <20180514212434.17514-11-johnfwhitmore@gmail.com>
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
WARNING: Missing a blank line after declarations

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 44a3b5a69a48..3342c9ccec3f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -331,6 +331,7 @@ bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
 	struct ieee80211_network *net = &ieee->current_network;
+
 	if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
 	    (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
 	    (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
@@ -363,6 +364,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
 	struct ieee80211_network *net = &ieee->current_network;
+
 	if (net->bssht.bdRT2RTAggregation)
 		pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK;
 	else if (net->broadcom_cap_exist)
@@ -495,6 +497,7 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 {
 	u8	retValue = 0;
+
 	if ((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3) == 0) ||
 	    (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
 	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0))
@@ -535,6 +538,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	memset(posHTCap, 0, *len);
 	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
+
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE = (PHT_CAPABILITY_ELE)&(posHTCap[4]);
 	} else {
@@ -592,6 +596,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	// For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
+
 		for (i = 1; i < 16; i++)
 			pCapELE->MCS[i] = 0;
 	}
@@ -634,6 +639,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
+
 	if ((posHTInfo == NULL) || (pHTInfoEle == NULL)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
 		return;
@@ -754,6 +760,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	u8					i;
+
 	if (pOperateMCS == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
 		return false;
@@ -818,6 +825,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		bitMap;
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
+
 	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
@@ -1124,6 +1132,7 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	//MCS rate initialized here
 	{
 		u8 *RegHTSuppRateSets = &(ieee->RegHTSuppRateSet[0]);
+
 		RegHTSuppRateSets[0] = 0xFF;	//support MCS 0~7
 		RegHTSuppRateSets[1] = 0xFF;	//support MCS 8~15
 		RegHTSuppRateSets[4] = 0x01;	//support MCS 32
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
