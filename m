Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333148-5-2458659053259021908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333148; b=DlXzrAau3OiB3IFxfcFRvOhrH9sGmZoyxeNEFPg2N1gA87Yv0R
    nOzoXqanJwp8lZnmqaXW/PAk4t1+mg+gLUOnLpm4VGRhQT2bokTREW2Yr2qkplS6
    An2/BubQ/WdaUOL+q3MkG5YNnilyIk/8CnOnYXYtmdGMePkbdETXV+cmqRqZSeW9
    12IgluInUSXwnEIMemfjafCkyU6NFhGXUGA3RJ3SNMbgV9QoUVv37YyA3cIoZ20n
    T4MHFe6fYqJy19gnnj6tDdjYrLSuOcy/V3Wb+OwbRGFubzItjabqUOuVyWHpbCg8
    SCGAPKB7IklDjsIedIKv+URNCKeL6Qwt/JdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333148; bh=YiuTb
    zaZpn0OvkI5vxGuZv7x54lquEyFPoTyskb57I4=; b=gai/OItWxpkVfjiq+SDMt
    HVmb78BIDniYw3g00k0hpNOf8e7qNqY3H5ERL0w3k3hdicUpzPUx6qkItr8WnuvJ
    FMgPexbLDFVP+kubk4c6wTNPkXEh0CbuSbtGjhPCu95JjoyxsRLgSTunvyEckmtQ
    Wlh82b3SuggD1i0MXyrrfP8iQrQ82W6tvLkNyd41F61fGPruLTXJ0obx7rcp5xW1
    mygGWzEkzFTWV+BGAgYmU7A8Ke+CPLkvxCfoJa5PGI+S34BJahzUJuUPaKJZ7Ie2
    EYuIk4ALYMjuvn5Fuh08iShcz/1vbsDoWVpkR/MVyZ+4sZtPUM95z9aImqEMEV1Z
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=cVj5iXcQ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=RQlECFNY;
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
      header.d=gmail.com header.i=@gmail.com header.b=cVj5iXcQ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=RQlECFNY;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH+e5QC6Kqhh+mPvxwblrOaTmHwt4X1LBdVOX6Wsp/kLn9RU+cxuW8k35pcdFJ1/q9BAo6Ses0m/qPmhpJzpUwleBAeErZEKrg+wfRrpHjHWCbF7Ur4S
    PH95/6bCRaHKGLOZRVlLOM3a2rVFBKZR8KsBcu8Z+rS+zkWb3ygPeg4gD+8r3s+KdMq7xXlPfUP6zsNhNiH1g7+K5BAhaFn8ruKjuRLy1JtCQpuQYYG7+vCq
    ZVct/bqYRQjoJ3wAtbNNlg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=26EkWuy_hZEYXS-WM60A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZp84gAny05WdglW04MgTw19Q5mVJkIHEk87Jcsbd047ryBsNR2q/53NiMXYzNdFPwzug6fqnQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 24/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 coding style correction of NULL tests
Date: Mon, 14 May 2018 22:24:31 +0100
Message-Id: <20180514212434.17514-25-johnfwhitmore@gmail.com>
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
CHECK: Comparison to NULL could be written "!..."

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 86507155a54b..d2a5ce5549d5 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -525,7 +525,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	PHT_CAPABILITY_ELE	pCapELE = NULL;
 	//u8 bIsDeclareMCS13;
 
-	if ((posHTCap == NULL) || (pHT == NULL)) {
+	if (!posHTCap || !pHT) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in %s\n", __func__);
 		return;
 	}
@@ -630,7 +630,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
 
-	if ((posHTInfo == NULL) || (pHTInfoEle == NULL)) {
+	if (!posHTInfo || !pHTInfoEle) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in %s\n", __func__);
 		return;
 	}
@@ -695,7 +695,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
  */
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
-	if (posRT2RTAgg == NULL) {
+	if (!posRT2RTAgg) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in %s\n", __func__);
 		return;
 	}
@@ -744,7 +744,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	u8					i;
 
-	if (pOperateMCS == NULL) {
+	if (!pOperateMCS) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in %s\n", __func__);
 		return false;
 	}
@@ -808,7 +808,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
 
-	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
+	if (!pMCSRateSet || !pMCSFilter) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in %s\n", __func__);
 		return false;
 	}
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
