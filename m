Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2282724-1524541311-2-18430810549435511144
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524541311; b=b8GYXF7sobtHiSmdKbrex3avTRwjZ7BUCylE2F0RXIhCLWbKq9
    cXWhA5fLL3dLexY5MY2P4IIncNdYjx1u8VNHNNRF4voz5Tc8Y63Av3Vb4jccp+up
    at5cr3qbR/5igki6dxlMIa60CFCQEZtzp/EUukXI8Ucglo3ifg/v+ntbtTeZFg4K
    TUtn7VwBA5o4B/ajY23Fy0kA76K3jLXWsFkHrCOmXT+fyB1mbo+QmF6uLBjObA2M
    oh1u5s5aSGei73v25vr950STB/GG+fXYgXmKraUOn2E6biu3gQ0Ltrmjt1Ly7qGC
    7FbbBAYGp8A7nqTdoqg3ZFWhxdWooKRCzIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524541311; bh=hUbYp9Chm4JeOI+ZuHllb5+HK7rEPY
    08ErRv8gUjQfw=; b=MGNTkOEiWfeZHJN54PIZ3nkwtyoRhJgnulSpIUOQ3XbhOd
    yB52iM8LvqrlHa3VfMBgDJI3VrReCT4b0aDNeAfdiOAX9D/WPB3nEK2gNVTJhYqS
    tDmweskW92iUP1+aUdCPHzEpOvQRZ/4WzeDvVHF9LTKwtNg0EQ7K9Wq6fhBPa06v
    jk5cbJGBX6NgOc7r+uztq452D/2bOgyXIPlUmdeNMh2V6KtVr/SVPnE6FATed2C3
    6UZYfbFB2vCafeGW7PbJW0FymeDfS3jcP3RUuNyEfnpbXOBNGmBau32b2hSNkin4
    JEFHt2Y3S4AJcCEzHw6oBqrVvmlRoATruIetwhlA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=ek97FEus x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=ek97FEus x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGP5ESmLspm0gtvr2qcaKtTXU8QBSel19rtzIlrl8lM5nK9RemeHDBDGLr+2OQrxGufE83V+xZEBbTmn1ZFZ4vQFgB3fY6S4S2TYumnSPYuUykIMLcS1
    u1qKEiD6AR7A6uIthwpXtpQmNUs5F899EKiJ8/KWaTH0zWZ1V1ZKd2Uwya305kobxEwtw6NLmCeKtUw2C69WFAXCx3eo0Y5mzTpRU00dI+fwTigDwwo9Q0+D
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=Kd1tUaAdevIA:10
    a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=PTbSQ8XhQ5YSPodnsGsA:9
    a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932814AbeDXDlr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 23:41:47 -0400
Received: from imap.thunk.org ([74.207.234.97]:48796 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932797AbeDXDlr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 23 Apr 2018 23:41:47 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: fix possible sleeping allocation from irq context
Date: Mon, 23 Apr 2018 23:41:38 -0400
Message-Id: <20180424034138.23994-1-tytso@mit.edu>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We can do a sleeping allocation from an irq context when CONFIG_NUMA
is enabled.  Fix this by initializing the NUMA crng instances in a
workqueue.

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot+9de458f6a5e713ee8c1a@syzkaller.appspotmail.com
Fixes: 8ef35c866f8862df ("random: set up the NUMA crng instances...")
Cc: stable@vger.kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 drivers/char/random.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3cd3aae24d6d..e182cca7e6cd 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -789,7 +789,7 @@ static void crng_initialize(struct crng_state *crng)
 }
 
 #ifdef CONFIG_NUMA
-static void numa_crng_init(void)
+static void do_numa_crng_init(struct work_struct *work)
 {
 	int i;
 	struct crng_state *crng;
@@ -810,6 +810,13 @@ static void numa_crng_init(void)
 		kfree(pool);
 	}
 }
+
+DECLARE_WORK(numa_crng_init_work, do_numa_crng_init);
+
+static void numa_crng_init(void)
+{
+	schedule_work(&numa_crng_init_work);
+}
 #else
 static void numa_crng_init(void) {}
 #endif
-- 
2.16.1.72.g5be1f00a9a
