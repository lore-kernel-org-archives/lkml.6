Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3380575-1522276003-2-11110936617228363263
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522276003; b=Py5L7fQ28ULIkAbHx9MMVmmdlnXOELz8Wbqcd6AAQiRuFbd
    mw8I9qESO3FgacbvvnOj34uIj6fy+SMcmZHWdBj7r1r9UruMhvehC9r0VGbxdXKU
    E83Ms6SugmYO4hlieZkpOil10nxjaUojQ/ABETRl9iZrwISoGZ2fPeIYUakjQ+zB
    3yzHCmUr6XN6piuzdX7lLC+jBqb46aVWTlUYDgG+1HiyR4qzacNXUWT6MRvvnT2V
    35tSnnI4wkYuwJcGmsjoJhKwZQT8KiyiM65Gp/f5YQZ7xwBAAR/OEBUbgd9mph3B
    DmgrIihsPOglITtVLLputMJX04XP6btqVXYsCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522276003; bh=R
    q5IFWmrV062cerOzbORj+lIKfqWqEC1CYQ8ay2cQUQ=; b=ICR+XIBobQCSeEExA
    cbzSdr6F9JQMgXaREHmnliXd+sIPhqA0cjF7dmuMUZeVrYse5rHUQsPXSFVU4773
    DzB7nHCjxnUoBfjmIHZxCVMy35q3j8wTNkNYbvJHIL5kagBQtb8h+NiXqc0Avc/V
    AqRqnL51TBtzs1Flz/W9++FMlQmk1L9t9MZhh8Fon9DaHqZYWCG8dWVUC88UQBsj
    wgkFfsbSyUN+lwpnaWG1LCNYTb9vC6nAoRS9jAA5L/V8pohps0yhG7/FhJXiKTt7
    mRKzkVJMt0dP294pMOLT90s3hoOkQL38PuA06DUUdN+zJEofP/k106nk2QtAkXlP
    YnA/g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WLYDrHtv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HEW+yHRt;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WLYDrHtv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HEW+yHRt;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJHYok5XKvl0V+5QRPGTwq9srgONVGNnH0LY1Iv9PXspEQbp7ODUpBJSq4ytZrTmAidi4VReAvLpLSK+21ZepFpSteljA54HwWDK6nNdn7A36wZMqVqy
    hfg4VRtt0rfHfZRP92JCmO0lX3HRV5uh8MA1fJTZ2Qpz4o62vX6uJN58IybBe9zsOxbhGUwiH5U0na5U/MCf66Hs945T5TMnU6MIwjNJwfP4sjPrtcuneX3Z
    KzQIlMpWr/L1Cf8CNVvrYQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=_n5q_SG4vf0A:10 a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=kHOcSizqr_m_CtT87Q8A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48Np2vWtKTk1ZFS3oejfPux/wQI+lPXloKeRDA3njJjATnfTazylgXOhC42UYnk9CFX0ck8sQ==
Date: Wed, 28 Mar 2018 18:26:34 -0400
From: Thomas Avery <tavery321@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 2/2] staging: rtl8723bs: Remove yield call, replace with
 cond_resched()
Message-ID: <20180328222634.eckamxkagfcimiif@debian>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove yield() call. Yield does not guarantee progress, cond_resched()
is a safer alternative

Signed-off-by: Thomas Avery <tavery321@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 4a6af72013fa..85f7769ecc2d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -701,7 +701,7 @@ void LPS_Leave_check(
 	bReady = false;
 	start_time = jiffies;
 
-	yield();
+	cond_resched();
 
 	while (1) {
 		down(&pwrpriv->lock);
-- 
2.11.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
