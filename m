Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519831911-2-2950657995521457162
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
    t=1519831911; b=lPPHaXi8BlQV4O6ussW+EUzrZM9ijZvRRWSK9sEx56BwSU8
    71qo0DJr2epW+1uAMKQkM4jHf5w8ckVI7ClWKh2KwW/9E2R9PEVCHoPEjxB35yS9
    UCU2psoNj9L4c9AOpXA0zePlgZ1cI3Gz/vDDswYE0V/hFRFcn/054eqSiVz7F2ue
    2p9rGrvaU185Y5J8vyTJR5WJ2SVzCFtpMAylirxLJdLgeB9JxTtOb3LFjGSeZn9e
    MQSb0arhLnsgTrJ3tSYNIqyiM+DMLanP3ocV2OW4cDi7+er0/e7oqWDH478deb6G
    ZnSsKm+3uf6FOLkiR3Yr9OWV56WYQQxZB1pQ+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831911; bh=6iIzAdfhThLug92mb7x
    AeahKQchZmdWhv//NwLOGkEc=; b=KG6Ggr1uDDxTgHxasy4j9vKbopudyD9lhzG
    O0CQ9lItApbJ/GkP8mU4GVL8LSIBuWMLPb/6ipl6/wJWczpxT0ksGw35vuLXV8nJ
    sARu5/PYCOh16PeC3Ebtkd3jbGOB5MFaS1X3Xcrfg6y6HcVnX1bmr8I2ysYpSXC7
    SmGQLX4BS71rEpa0VtrvQ2jC8MXS0bLO6p3Zue+cuz9R2t7aO+EmN2x5gUW7rbMW
    4LzUC6bDPgD2JctMojaECg24thyFp494vYXvLUr/fUzujfO0O3LWWbTiTjjX2G78
    19Z5XXKzjW8/YcBmEnyVNZRDeE1ZlvQ/vnMVLlkdTnddK9N27yg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932861AbeB1P1L (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:27:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33337 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752874AbeB1PWk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Sterba" <dsterba@suse.com>,
        "Nikolay Borisov" <nborisov@suse.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.977731235@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 034/140] btrfs: Fix possible off-by-one in
 btrfs_search_path_in_tree
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

From: Nikolay Borisov <nborisov@suse.com>

commit c8bcbfbd239ed60a6562964b58034ac8a25f4c31 upstream.

The name char array passed to btrfs_search_path_in_tree is of size
BTRFS_INO_LOOKUP_PATH_MAX (4080). So the actual accessible char indexes
are in the range of [0, 4079]. Currently the code uses the define but this
represents an off-by-one.

Implications:

Size of btrfs_ioctl_ino_lookup_args is 4096, so the new byte will be
written to extra space, not some padding that could be provided by the
allocator.

btrfs-progs store the arguments on stack, but kernel does own copy of
the ioctl buffer and the off-by-one overwrite does not affect userspace,
but the ending 0 might be lost.

Kernel ioctl buffer is allocated dynamically so we're overwriting
somebody else's memory, and the ioctl is privileged if args.objectid is
not 256. Which is in most cases, but resolving a subvolume stored in
another directory will trigger that path.

Before this patch the buffer was one byte larger, but then the -1 was
not added.

Fixes: ac8e9819d71f907 ("Btrfs: add search and inode lookup ioctls")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ added implications ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1751,7 +1751,7 @@ static noinline int btrfs_search_path_in
 	if (!path)
 		return -ENOMEM;
 
-	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX];
+	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX - 1];
 
 	key.objectid = tree_id;
 	key.type = BTRFS_ROOT_ITEM_KEY;
