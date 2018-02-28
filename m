Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839344-2-6172053946150973814
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
    t=1519839344; b=PHYLtMhOZKaSKOyo354gGvbrolxRMG8cDMMZJuBASUaWbYH
    1ZYAn7ihuXzp03DH8zteQoiCRLZ/fldfgdz/bZDQIkQGphit9u9Zx5DJXslU4QIg
    rtob5AvkVTdkbT/pa3hLNhPKuiZc0qejv6NlkcoR6zh8wM7odtNImu2I8CSdMWtU
    UX/blDKKcccRWdqEYEx5dpfdak0+oQdTbxe50vHOA/U5BHtcrh4si8i319xYWvxn
    g2N5jFBJEw0tBNJXCix5Y3Atx5KVTLHUjSeE0ZUbZQpeAzCpbg0OLgLlP4Zdyqor
    rWb62x8pEBSMlarV7ybwaiccNP99fqvZzOmh/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839344; bh=x3XYjnvX7NOIihvntWV
    LoQWS7xR0vxFYFTTSmDXz3Eo=; b=p3tNWJiDsQjLvviSHYL1M8BMdgMXAU6sMhI
    zrE/C5+mydbKHO3NbZUJRU/GZp9WmxXvM2cINYlRY2mmclGFZK+PygG36ft5uq6r
    G7DVTre1lH1CXt4HM64JjZF4+z6mMs9qt9RvEL/eMdGH9ox4ANJ7ewE91Q2iyVPT
    UaeBRadDTvdVzoy33ErXwCycHot+mqJPe0gkV0zaqWTVjtPG2R4zZ5TJTOvpEvd9
    hTuoFhL16F2andOEMKrEY/T2/WYPfl5j10Ez94SM99dL+JKTyDVndFrKYmOHh3eg
    yQX8j/j4h/6ZUMz1oe7VFiHT0iGJ07FCMaQh7YrOawIkxFZ4iuw==
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
        id S933104AbeB1RfO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:35:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33204 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932551AbeB1PWO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mike Snitzer" <snitzer@redhat.com>,
        "Joe Thornber" <thornber@redhat.com>,
        "Dennis Yang" <dennisyang@qnap.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.28968656@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 106/140] dm thin metadata: THIN_MAX_CONCURRENT_LOCKS
 should be 6
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

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
