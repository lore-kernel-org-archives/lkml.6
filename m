Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526333142-2-11378458040783543523
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333141; b=U5XO/RzyPanu7msdpQ81l9+xIppq4S4JT7MmgjR1N18S9FAiW+
    b+a4H6ce8fv8rLgyR7Bpn/0uxJSJIMjFSHXaZPbx7u1zsJX1Rztgl+QLrtumw18B
    X99NwEnxpEcWepzJAsR/nhb69PXRP7acMVjKBVYVf7CRsMQqfixREdcs7NMTm2UO
    xK5wGw5jMYPFQbhr4GwIIuw8CseNmdssxH0Sl9oRQBG0xHVwjuEbAlb0ra0R1CeW
    yfqtVuNzDOSWe2+xuNT2XQheof+9il14kNd9YJsUBewgjlpbL3kqk1HaynO5V5aj
    jSLNaefanOxrYWZOIwuSgfcszFDkw4ZJXKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333141; bh=76zGp
    LemQEwrodohLTK7FIvATSrQXQ1y5P35Q2pqcUA=; b=TKIbQRt1t2eXBtcuUl/JF
    KixD/Y61wjfGEzJN83HNpV1YHbVItGpGYhQLMcvbbiHjngHwQ2XSfndArovhJnoU
    r6q9stsRkl1d5HPkexIreG+HtSu1agiuXGrE2vak49qiVqnVtfNGWCtdA29XgZD+
    /hrC8cDEseBhQyrpy1K8VM6qD2yLouGIBrvge+Pyh18xtAU4xjtXOsbebAiFni9v
    EAQPqEqAic69SPeP/evMBDFjVsIT8lGWj3WZDkLOw5UWzoa5N3dsrmMaHDcpJ6kg
    EMADNqxxFW709viWOISbZMYCMblbMmExPbcsXpoI/lQ0PjgMaJm+vrj2mqEDaABF
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=ASzglE/w x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=dOo9q0He;
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
      header.d=gmail.com header.i=@gmail.com header.b=ASzglE/w x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=dOo9q0He;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLgoQUeSwP+jf2oaxOkrQug0GScGnAEG5JroLbFuwjRuW4PKbb3kLVbeXEjRkOM7HgUIGK06j7N0lZ2tiWyfYp7HmZiPhhVNwCxCLE5sQGrMs0fhLYex
    TCV/Sj50+fj8g81lFhMZrMmth1TAWKDQM1oNb4ABYjhvGllmdSfQ2MitI5swBsJ8eA0+RVMOkDPq2AoZjlnRe3afgX+bgWmsfrG62qnQDxY9n1dHOgl6ge78
    GBPvx/UFxOB8hfY26SCQZA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=auCq11gC2fwDePslAVUA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqjbtJ5GGwxIOewcm1i0k/53WZg1RORvAKaL2LClXotJzn4ZS+Tz6qrnhQZM7yAO7y2Tc/nTw==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 18/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 Removed blank lines after opening brace
Date: Mon, 14 May 2018 22:24:25 +0100
Message-Id: <20180514212434.17514-19-johnfwhitmore@gmail.com>
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
CHECK: Blank lines aren't necessary after an open brace '{'

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 9dd025b22ac4..b138057c619e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -123,7 +123,6 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
  * *****************************************************************************************************************/
 void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 {
-
 	static u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_CAPABILITY_ELE		pCapELE;
 
@@ -159,7 +158,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
  * *****************************************************************************************************************/
 void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 {
-
 	static u8	EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_INFORMATION_ELE		pHTInfoEle;
 
@@ -259,7 +257,6 @@ static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
 
 u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 {
-
 	u8	is40MHz;
 	u8	isShortGI;
 
@@ -868,7 +865,6 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
-
 	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
@@ -1146,7 +1142,6 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
  */
 void HTInitializeBssDesc(PBSS_HT pBssHT)
 {
-
 	pBssHT->bdSupportHT = false;
 	memset(pBssHT->bdHTCapBuf, 0, sizeof(pBssHT->bdHTCapBuf));
 	pBssHT->bdHTCapLen = 0;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
