Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837983-2-10595336782506505896
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837983; b=m/PX6TCDdS1eOFUx2vB5aRXlKOf1NKzZ3YugI2yM7v8IXgV
    4FuCVMzqAE0qSxS5XP+QdeztanHbs78KQSJdhowb5Ta3hIhlstrt3VLvh8dlD8Nc
    kVoBufbFj6fg4ih21ig+l6VWZmCdwUmH57LUlV6lkvBoSv5bPedkhmGqaiPnfbrq
    zwJ72cD3LknefTsy3fnMZ8XSCoCxMp6Fzm21q3kqLt1PQCbvp6T5e38Jr4iXt+5I
    G9+QEXUPKMNNWXnO8ETZUmIG6THuy0MsvUcXZ2znRa/mrBypeGIuD+q9pFYek3V8
    AtyPIaACuKWL3YMbueuPTaNdWobvXQLdEu3+7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837983; bh=h1C1OSi6XkTTDASBtiQ
    Lm3afBJ0unJN7aiEqZZRoH2g=; b=MBavinR/33Essuxpwk6bXPa0HtdQPAN23gw
    x6unrbX1nVlMeUzc6FYdhIvy8qEnHIJpR/o8IN3djxaVO6ZIrmEJGU9lgpGiBZbN
    CleUzszcQ2e9wlmVCrXWFxdUC/fppc6NW9cCWugo6nhGW/myqm7KjrnWDeTfN1pT
    CGCbHfKIMyGLMq2MipR8VAkzBLE0xfxBkPTO3nSkxrUe+f6FUKFot9LlzZVAVGsz
    6M/vuaj+MAHCNXrfkUWxTRWunPOrnvoeZ+peWvs5n6QgHwz0eOvHFOV74cCXksAW
    wdZMbUm+76W6swLpZ+4mGvo5Y1w4G5DSRXH+0iIKOgkwBBtNZrw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932836AbeB1RMe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:12:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34288 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752872AbeB1Ptv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:49:51 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mike Snitzer" <snitzer@redhat.com>,
        "Joe Thornber" <thornber@redhat.com>,
        "Dennis Yang" <dennisyang@qnap.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.60430547@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 214/254] dm thin metadata: THIN_MAX_CONCURRENT_LOCKS
 should be 6
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dennis Yang <dennisyang@qnap.com>

commit 490ae017f54e55bde382d45ea24bddfb6d1a0aaf upstream.

For btree removal, there is a corner case that a single thread
could takes 6 locks which is more than THIN_MAX_CONCURRENT_LOCKS(5)
and leads to deadlock.

A btree removal might eventually call
rebalance_children()->rebalance3() to rebalance entries of three
neighbor child nodes when shadow_spine has already acquired two
write locks. In rebalance3(), it tries to shadow and acquire the
write locks of all three child nodes. However, shadowing a child
node requires acquiring a read lock of the original child node and
a write lock of the new block. Although the read lock will be
released after block shadowing, shadowing the third child node
in rebalance3() could still take the sixth lock.
(2 write locks for shadow_spine +
 2 write locks for the first two child nodes's shadow +
 1 write lock for the last child node's shadow +
 1 read lock for the last child node)

Signed-off-by: Dennis Yang <dennisyang@qnap.com>
Acked-by: Joe Thornber <thornber@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-thin-metadata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -81,10 +81,14 @@
 #define SECTOR_TO_BLOCK_SHIFT 3
 
 /*
+ * For btree insert:
  *  3 for btree insert +
  *  2 for btree lookup used within space map
+ * For btree remove:
+ *  2 for shadow spine +
+ *  4 for rebalance 3 child node
  */
-#define THIN_MAX_CONCURRENT_LOCKS 5
+#define THIN_MAX_CONCURRENT_LOCKS 6
 
 /* This should be plenty */
 #define SPACE_MAP_ROOT_SIZE 128
