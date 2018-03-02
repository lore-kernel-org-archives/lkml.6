Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2085038-1520012213-2-5427247551239168969
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520012213; b=r3AnO47hk/MLpGv4p10mqKc05clHiKjwNzgoKmF6r7etDMX
    OO2hB5vJ8A5GrTBCIGsA/H1UxYpfU9+tdKVYq18J6taPxnge7u/fOxgwlxDUO9/v
    26ub7JkOM85Y43mmDGOWYMWmZg+WzmAhsef9p76ZDx03hihdP9NF5yZjTdzq68eL
    P1EklVgt411qrFuXbDGjfLeF+pqk1VsNpPVYn0io45MVT69unlYXaggM1kv+d2HC
    Y/sKbppwXMzmezDMntQAaQWjxYAcx6MZwJ60hwb2gcSQM0r8teOhd2rn69nCSLLO
    o9K1Htc1P+gJblhKKwvXHiHTRd0tyBc7xxG+COw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520012213; bh=c
    Vnr1iKtcycv+9g0xU3ZJGhi3ou/OML+rYj43J08OnQ=; b=LjItur0GzmFGQKLlq
    2+LvZBI3Hcq4Zcyh1+B7FInokr1U0/+6DFi6p1RP5MvY5G0zqum8LGrJ6IFj5wIO
    SP7jYXFguDnzW+BJkp1eEcLPSV4FsZbbUlFppOdx7U4blhfSI38XIZUFJ1wYQXci
    a4YoujY2z4jWV379vMKhR8mEvGcygdFsZj4jhcCd55W08iusaDR8oJvzeKmOsRQh
    bjAXhiT7Dn8uLjgFyi77pd/0uv9CDWFxfuRnLIxvr3+jVaADApHaBCRcHTjuxWHP
    q2D8K5/Fx8eb/trsCTfBmuWqG3RKAL9HOWg0Bp1sZSD9LrGuyxWdHTopxTSW4WnG
    0Fr7g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bON0Q7PX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=prQu1zvF;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bON0Q7PX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=prQu1zvF;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvncZ9Njf43ajtY4qIQUNWru6fPlYsupI2Em4mIa/vs5M4nv23IkpbhNANtNKanRF7t1jt9Vg==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
X-Google-Original-From: Arushi Singhal <arushisinghal@gmail.com>
Date: Fri, 2 Mar 2018 23:06:19 +0530
To: Larry.Finger@lwfinger.net
Subject: [PATCH] staging: rtl8712: match alignment with open parenthesis
Message-ID: <20180302173619.GA8598@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 outreachy-kernel@googlegroups.com, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes the checks reported by checkpatch.pl for alignment
should match open parenthesis.

Signed-off-by: Arushi Singhal <arushisinghal@gmail.com>
---
 drivers/staging/rtl8712/mlme_linux.c | 2 +-
 drivers/staging/rtl8712/os_intfs.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
index 3c7c4a4..baaa52f 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -36,7 +36,7 @@ static void sitesurvey_ctrl_handler(struct timer_list *t)
 {
 	struct _adapter *adapter =
 		from_timer(adapter, t,
-			mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
+			   mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
 
 	_r8712_sitesurvey_ctrl_handler(adapter);
 	mod_timer(&adapter->mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer,
diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index e7df5d7..d6d27da 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -230,7 +230,7 @@ struct net_device *r8712_init_netdev(void)
 static u32 start_drv_threads(struct _adapter *padapter)
 {
 	padapter->cmdThread = kthread_run(r8712_cmd_thread, padapter, "%s",
-			      padapter->pnetdev->name);
+					  padapter->pnetdev->name);
 	if (IS_ERR(padapter->cmdThread))
 		return _FAIL;
 	return _SUCCESS;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
