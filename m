Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4118280-1518781010-2-14600166155551587331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518781010; b=RmZaL6/xuRjWDudMWK/YD1pwEHd1xi1/n7eGZzR27qZ6GOm
    LW9bc2itj2NfjKsCLEgzsP0kfbLcvI03FcfFBH4w8bWfOqyfnS20EU7AXxu1omy5
    XSGBbSKlMZPUg2fXdLEG/eVxAWG3ldpMGDj1XY/9tFd8shZ/qLzxG9MTxIzyk/eO
    QZYlhIN7kcIXPh51vQVL7itPvbwWhKqfCf+yU+EO9NybqH2FGay2PQDTS3GWdrgU
    hOdS2jRVS8Ru4YSlDJh6ZgGhER3zzWCTfq9LpamieoW5O/jfEP+BQ25wO1sYc3Y9
    s8hHCLc9KZHKzS6TmXEOOhoSnkk64Ds7XF1oacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518781010; bh=D
    liP0i0xU5hpih8C1BOMl92nxsGrywkK6N/DPEd7mg8=; b=GZ+ZNEGhlFIk3tn+H
    XrFRpq5lpOKryt3Tz7f2OLnMK6E9r3qMIT6QSw0FwxxZPVXDOsWML2P/zvzHVLXC
    IRDUleRWLJtKskNnLTG6e4dYgW2N6+PmNP4IArHQJNG3e+xv8MFolxeZvfx9diFG
    w+nhR59eIEM9wPYcPluPtAqEJ053GRHc8hs3O3nI5tDMwXjkJh9kb2pCmfvnJOWA
    YohOhpMoVADHVNfflvnUy6mEcDEL3UB7JKvubR8AdS7l43e1gYPXUkvHPo5H8ENU
    4REjTUMD3M8zlxIHCzj9sLSPkRF8UoVC7n5T7YRO+8Ua+3ofU9BMosUqDRpZgG00
    p5aSQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hRi6YRqd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BUCA1IWD;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hRi6YRqd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BUCA1IWD;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x224/J5dqktz4xPTNKBOqbHpvNeKA530tRnMsUN4ei76qdKwMvjnieqQFyz/jopaH1EwZ866w/A==
From: Yash Omer <yashomer0007@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] Staging: nvec: fix line should not end with a open
 parenthesis.
Date: Fri, 16 Feb 2018 17:06:34 +0530
Message-Id: <20180216113634.12848-1-yashomer0007@gmail.com>
X-Mailer: git-send-email 2.14.3
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
 Larry.Finger@lwfinger.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fix line should not end with open parenthesis found by checkpatch.plscript.

Signed-off-by: Yash Omer <yashomer0007@gmail.com>
---
 drivers/staging/nvec/nvec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 52054a528723..39fb737543b5 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -383,8 +383,8 @@ static void nvec_request_master(struct work_struct *work)
 		msg = list_first_entry(&nvec->tx_data, struct nvec_msg, node);
 		spin_unlock_irqrestore(&nvec->tx_lock, flags);
 		nvec_gpio_set_value(nvec, 0);
-		err = wait_for_completion_interruptible_timeout(
-				&nvec->ec_transfer, msecs_to_jiffies(5000));
+		err = wait_for_completion_interruptible_timeout
+			(&nvec->ec_transfer, msecs_to_jiffies(5000));
 
 		if (err == 0) {
 			dev_warn(nvec->dev, "timeout waiting for ec transfer\n");
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
