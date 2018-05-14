Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526333115-2-2308785640864558092
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333114; b=kWQR/yWu+UKO1ISLC8szOiiQg4vkCEIgdaB/MEnq8RrZbygTLV
    2itL/gB+RhT6bmxDIJlXP6wOkL6N19esr55gN81P1R40OSHWfBNovRMH7WzJIvyk
    vN+ly0DURdlFJzkkODkNr9GzqHJQPzkSeItlxKGChvzsjtzXpO/39W2FuvPoBSmr
    eMpz1euDVZ5aFDjiXpH/cDUJocKIpzgBEUgQbGLUwlAfo6Uhf2bHyAdxZHV1/zQ4
    N6+0viPZc6SeNfdVw78FWpEkwFKJSUI2wy4sH1xRRrszEynahx1eJAduLuwVYCBm
    uJteOUP4rvhvx7EXS8QVQqy13Hu7RdHh1+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333114; bh=o40CU
    idiy79oun1i294tiafKZDekw8mD7DdzmyvH3rc=; b=lsco2e93WuAQhhP7+IK9d
    M2JllTOhDZ4ZzVHeWsdh1+SKrQsHmGpEdp1/lljZx/RnymxpVyNxrUirWNh4fkNh
    H//uGN2wxzTqp7ZATkjZvOCfHUzYLbVCwWc8+n//xKHgI6ZBEocjFYoc1CD9Wfmn
    2bZ9GlwWmR5p6WSm7iiXyc5LYJ9lfxtAEwlHbDZggqZB/JT2hf75CiKcmxSnQNh9
    BJRg1OyoaU9vGAfhc46BM2/ghpmK7eZ2jFxXr/BEv94GLGj8GM0rfn8AwXYVraxP
    exYSeFrFLucM15Z01BpIFyfqjSb8m5c5oj5ZyeHwpeV38+/tTY5Z+tk9zpQBlOVh
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=buDMP8Nx x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Y/0BxXCj;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=buDMP8Nx x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Y/0BxXCj;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIaNHEG5hMe7yIKAo2NgYeRt3ICMYSzcBP7f6DEnZ3WcFGnj3iZOj1YS7pW7cxn7/5RwXtn/jS+dDLH6PIuzowu+RF5OdFJaYo2R20+xe8RSNoHjzQnq
    wakFMwtlO/N+00pdo15v+IOvs1Gi5J4mdIGpuYiBZECOQoGAvqFBufPUbny+8MAGjDF+tQEwBNe36at5HR8ZYpciEyJ8g2M1Fbd8FhZW5mj9FUaWheMsM+Im
    7ExxUJzthndJtPZdkFt3ZA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=BPP2wtXPxORLcxt8zBEA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZq9IfajQOICjn6XggVdoxEJGrjIg9TeCtdjL45vxpoczHxYJ4I2YHjcDRtNgRvHkcZOyCHByQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 02/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 space before ', '
Date: Mon, 14 May 2018 22:24:09 +0100
Message-Id: <20180514212434.17514-3-johnfwhitmore@gmail.com>
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

Coding style edit to clear the checkpatch.pl errors of the type:
ERROR: space prohibited before that ','

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index c116bd895b50..065ede61a3cb 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -8,7 +8,7 @@ u8 MCS_FILTER_ALL[16] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0
 u8 MCS_FILTER_1SS[16] = {0xff, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
 u16 MCS_DATA_RATE[2][2][77] = {
-	{	{13, 26, 39, 52, 78, 104, 117, 130, 26, 52, 78 ,104, 156, 208, 234, 260,
+	{	{13, 26, 39, 52, 78, 104, 117, 130, 26, 52, 78, 104, 156, 208, 234, 260,
 		 39, 78, 117, 234, 312, 351, 390, 52, 104, 156, 208, 312, 416, 468, 520,
 		 0, 78, 104, 130, 117, 156, 195, 104, 130, 130, 156, 182, 182, 208, 156, 195,
 		 195, 234, 273, 273, 312, 130, 156, 181, 156, 181, 208, 234, 208, 234, 260, 260,
@@ -295,7 +295,7 @@ u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 {
 	//PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
-	u16		CCKOFDMRate[12] = {0x02 , 0x04 , 0x0b , 0x16 , 0x0c , 0x12 , 0x18 , 0x24 , 0x30 , 0x48 , 0x60 , 0x6c};
+	u16		CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18, 0x24, 0x30, 0x48, 0x60, 0x6c};
 	u8	is40MHz = 0;
 	u8	isShortGI = 0;
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
