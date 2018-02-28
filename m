Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422553-1519831370-2-7803492484679113167
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
    t=1519831369; b=qh6tsWsVllUBwJ5+xTyfqNPSDOshhZWvgnR3XEF/6Pd0Q4T
    ucnIdp9m6JSkCC8U36WmW98Wy82XsQGGfjkXZGyeJY63AgSQ+m0/gNgyKSv8S7+P
    k4qVFRzy8q37pZen623KI4Zzq5EsZVmag5pqSpDNSUVnHSxByLZMtt6SQBHcBD1c
    4Ogb+lTGRtsN0PLCSWjwnHzzZLAcIQ7R4mvhKLbMgyE1sxlIa8I9JHJnkrNsFmJ2
    UHCjpa02kghZ4mVfvyHuOLQSJneCeGsf4kgcsK5j1CUe+49wvDfl+UgIOfq1oHHZ
    b8c4mAQ5NwSs4PCCutvxTTwFK2FyiYbg2bjnYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831369; bh=xs4i8lW7hYj2RCkPwMc
    Hlbm03qXUM0NH9Ux+esAeEI4=; b=i7NC4zy4/iCV++MG0N+ZWjWJt9TIMnIlcng
    mBCE++tKESj8FUWJhGVTtRWjov0/rnQF3e4vB2YmljBIfvmfQ16iB0d95YaS0EGg
    RMmS0oGdmUpOEpntFUEscMT1qVbvmiUOTZUAFf/whMzY+phedNAS1Hf0ydL+dPHk
    GnR21RydDwOwIploWInC04T1PzfASSD0oDtrNrLyf95jmvFRPaLd6yP/AVkwlycN
    rOkxw+qBNC7fHvWh22MYWshNn/WZz211Oq6GcCXflrZnR+Uu/Wbh1dhv5b4I7nWM
    qAfJqitvN/a//UB8494KNIt3e4Jsh659exCjGpmBIH97PPwGzVg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752893AbeB1PWq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:22:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33222 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752586AbeB1PWc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:32 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Sterba" <dsterba@suse.com>,
        "Nikolay Borisov" <nborisov@suse.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.434836948@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 065/254] btrfs: Fix possible off-by-one in
 btrfs_search_path_in_tree
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
@@ -2253,7 +2253,7 @@ static noinline int btrfs_search_path_in
 	if (!path)
 		return -ENOMEM;
 
-	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX];
+	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX - 1];
 
 	key.objectid = tree_id;
 	key.type = BTRFS_ROOT_ITEM_KEY;
