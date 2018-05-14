Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1006072-1526313277-2-11641163528411583793
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313277; b=CLZ7xb17bAO6rb/EVUIhsPFcmcWcVNjqcWDXqrOGTTUBGJJB1a
    45lmU5FcrdGpgyWXXWYP5MvpI/nq8axt4bs7PmgLBaISuaPXB/MLoFZCCC2Waum5
    jZ5lqEeizaJRgyqjH4SOWbz/qzaAtQ733czisQA9x0QkCiMl5Z0ELGxGEdfG20vM
    GrGA2lM6fyt84dY+U89Koe1CaTzkNKYhJqiUPGO4Xwo9GdMgLBDILgNkFjD7DqI6
    y5+1H+7iMsnLl3qjqdpoQu/EYYfJWzpq8Y1z8ry2LSD6/lQQbXPkCHLhQ1up7VJp
    grQxehSrLgpFkff3n9Mczi7+FgoAF2OSMwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313277; bh=vbBOw
    EXFwFan6r6fSdzQOo3iwnVa8Ge79mbtRpCNGjA=; b=jmlwcnob3k5XLsGOIcWBf
    GboV39IMj2i/6jyIrMpxEiDjCm25hZ062NcDVA+/g9B4qj2XRVoBTxbI31rkXOMl
    Gycwa05w0ytIG5EQdq5F0WfgENjOHNbyN17PQQ4EdZAg8SpnN8lMecHBxJdkm49C
    Ae6Mg1ZZqJCNLQb030HPY64XsLgzIc+5kKaWoqBsPANKTtptRF3UkumWcntOYZ0S
    upldUtCXjP+aMEmyo4xwrdqsmgOO/HSsXmGMnhsI3kgTRhRNB6mocaTIW4V5VT9m
    yOsMuFOIxWP9ZefsSpc6mtsMDXIbU8dy50aV6+fx98s90C5u2ubKpP7k0R/P6NjO
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=K/8t++p3 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=pMVhBNeA;
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
      header.d=gmail.com header.i=@gmail.com header.b=K/8t++p3 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=pMVhBNeA;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDIjyQ/PeOAQp4rv86m5b83oilhQFwb/6E4QriWRH9h6m+XzglL4vui1iQEbvJkym9dH8K0JmPxK+3vOSNIPzJId0czPzB/vPV6viEWRYRFRHooOzBcB
    JL7rkH6rr0pOaO/WopyAtqyqBAeJL80Z5/zvHwAYElgwvrHdpeKe/hZr5zMjax7KHa79osa2BzoQJUPqklPnoIU3dCYH4xmH1THKH8BRqdyqt2XVSQysEEwN
    Gbr5BdWCasv5QBGStq6KcA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=Ow5VXoA4M8uD5j9QLQ0A:9
    a=9zwnwFFF_nhLZQKY:21 a=vQs2kLsd4n3WDIzZ:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZr9t43jGfIUk7Sgz+yFH5zKM8VnDT6HX2Bi15fJqzU23YPB1EbMBsJhT3g2p8yOTQsSko6RbA==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 12/13] Coding style,
 removal of braces from single statement blocks
Date: Mon, 14 May 2018 16:53:17 +0100
Message-Id: <20180514155318.32195-13-johnfwhitmore@gmail.com>
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
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 742eb35ae442..af6508dfd897 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -496,9 +496,8 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 	// 2008/01/25 MH Judeg if we need to use OFDM to sned MGNT frame for broadcom AP.
 	// 2008/01/28 MH We must prevent that we select null bssid to link.
 
-	if (network->broadcom_cap_exist) {
+	if (network->broadcom_cap_exist)
 		retValue = 1;
-	}
 
 	return retValue;
 }
@@ -768,10 +767,9 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 		//legacy rate routine handled at selectedrate
 
 		//no MCS rate
-		for (i = 0; i <= 15; i++) {
+		for (i = 0; i <= 15; i++)
 			pOperateMCS[i] = 0;
-		}
-		break;
+ 		break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
 	case IEEE_N_5G:
@@ -834,8 +832,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	if (i == 16)
 		return false;
 
-	for (i = 0; i < 16; i++)
-	{
+	for (i = 0; i < 16; i++) {
 		if (availableMcsRate[i] != 0) {
 			bitMap = availableMcsRate[i];
 			for (j = 0; j < 8; j++) {
@@ -865,9 +862,8 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for (i = 0; i <= 15; i++) {
+	for (i = 0; i <= 15; i++)
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i] & pSupportMCS[i];
-	}
 
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
