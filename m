Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1039939-1520362426-2-16089724348905842311
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520362425; b=LVG+A241kQ0Se41tx5EOFHGTHGF1rkNweYRCfDmG6S75p6k
    x1PuaBdNcyJ0+Q6418l95LP95m09Gj0qqGnGFajE77cUeJUKm8Qi6NjZ8JI3tjgr
    j98dKJ5rqshg8G3giX4FVBrmqrjg3pyh9XNTVRrHjs3lqf87jFBNH2E2N3uBSam0
    /OMNnmkafsTL7qX+dr2DlkV9djrJ/KQ4Ws1l9UC+uIRGzlQYwU4xcxUDv6hS0E2r
    ze4vJgtlk0LUIcYoJNrD2nNMoir0EWvz2d39JJ7juKIvqyZgJlQT41enF4GNTAn8
    hTjVeJO716/WBmzrzzNyPSiXMk9/JAWcAT/QxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520362425; bh=D
    NbqygL5duUHLjmgkD0L8wSS1+gjqNuX3ARjkMtAxw4=; b=I5E4qgS+dbUNfmKVm
    C8YKtWXWHMg51S7PcNg4QlbYzrja3tJ3ayfcfNY+XZ8Q45Bwdkq1AYgKlExkBDL4
    0kOuUBLvOP6D9+22wL4nMU3Hme6d3rK3hdZ69tD6i/wzf/QZrZg0hCdoR1s1qexI
    diwIgFmnNsNxAEneKrdjCNLNo7HSvlSw8rt/t8QCjOo+mB4+mRfMHmSnQ5Dv1+W7
    6/qVm8a8clTrsQigX7T3+8NLN+E9ysdqdaEnLxUDvShh1w2spA7Mbrgox5FN8Q8X
    9SuGTVMp6xzFWPAj4blWLxcDZcpMnZzJ9hLYm6t0Xa7pflUsVVRbGnMotcb7CRt5
    dolWA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Kw/11NY+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h5E8OWg+;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Kw/11NY+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h5E8OWg+;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtExw9Ny9xUuvd8xT6n8m4E5yg863GHIvMMfiTwP6dnyyFN5A+YK395ddgmP8yVlaNAzzd0Yg==
From: Horatiu Vultur <hvultur@gmail.com>
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
 greybus-dev@lists.linaro.org
Subject: [PATCH] Fix partial warnings of checkpatch.pl for
 drivers/staging/greybus/i2c.c
Date: Tue,  6 Mar 2018 19:52:46 +0100
Message-Id: <1520362366-10294-1-git-send-email-hvultur@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Horatiu Vultur <hvultur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix partial warnings of checkpatch.pl for drivers/staging/greybus/i2c.c

Signed-off-by: Horatiu Vultur <hvultur@gmail.com>
---
 drivers/staging/greybus/i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/i2c.c b/drivers/staging/greybus/i2c.c
index 58a37de..aec3cc6 100644
--- a/drivers/staging/greybus/i2c.c
+++ b/drivers/staging/greybus/i2c.c
@@ -137,7 +137,7 @@ gb_i2c_operation_create(struct gb_connection *connection,
 }
 
 static void gb_i2c_decode_response(struct i2c_msg *msgs, u32 msg_count,
-				struct gb_i2c_transfer_response *response)
+				   struct gb_i2c_transfer_response *response)
 {
 	struct i2c_msg *msg = msgs;
 	u8 *data;
@@ -164,7 +164,7 @@ static bool gb_i2c_expected_transfer_error(int errno)
 }
 
 static int gb_i2c_transfer_operation(struct gb_i2c_device *gb_i2c_dev,
-					struct i2c_msg *msgs, u32 msg_count)
+				     struct i2c_msg *msgs, u32 msg_count)
 {
 	struct gb_connection *connection = gb_i2c_dev->connection;
 	struct device *dev = &gb_i2c_dev->gbphy_dev->dev;
@@ -199,7 +199,7 @@ static int gb_i2c_transfer_operation(struct gb_i2c_device *gb_i2c_dev,
 }
 
 static int gb_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-		int msg_count)
+			      int msg_count)
 {
 	struct gb_i2c_device *gb_i2c_dev;
 
@@ -249,7 +249,7 @@ static int gb_i2c_device_setup(struct gb_i2c_device *gb_i2c_dev)
 }
 
 static int gb_i2c_probe(struct gbphy_device *gbphy_dev,
-			 const struct gbphy_device_id *id)
+			const struct gbphy_device_id *id)
 {
 	struct gb_connection *connection;
 	struct gb_i2c_device *gb_i2c_dev;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
