Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324470-2-12031026592832494123
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324469; b=A6KpKCxDZlhLz/j/BTRxJbGKmk7U5whcMVi8dyMF6JbNbTc
    bI8jAOoRicLQOwm50yXu8KyH7ZgYIZea6+i6G+40G3lDfQHs8LGoPatvcQ/WzMbl
    /36LRwTYFwnt9q2iAx0TnNbPMAaoHODSHoA9WsYxJKQI/8DIgLMP+iyOu1WGkC/l
    vpVv9RuK5wACOE+qEejZMXVROz+xNrl7A2z1oO7WMVD/kjPXO9WzCltdbWi4xalT
    wBQpcZfd39/gVkKEO0+f1quRgaLFr+sSzPq4ZzEp1gp1LNcDSvN3pEz8tzE4gTN1
    ipEpGOigLoIvMZa0NoeC5OCv/14GzfCjB32Btjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324469; bh=oiU8XmsU9REKio4ioaw
    txa8rw9c2piHCvmIh1Pdv5FU=; b=FdkBxMMlzdxdh49TA8O8IKKJ5HHxwGOvYcL
    4WelJ7s4gh6cWRWPkF1Rlqo/GXS4XudNgmcGM1GADb8D7jJDwsm/MBFKKj+VX2FM
    7aQ6hyEVFcieWymMr+YhgwcsP0pSAAlgRvXQUDSuTBOHxfBU0buMbsq1CHpzfEPi
    psoMul82XV123AAbayRSBIvRQRV8F254XA6Mzzd6ULZwvMVEwv74/BG6O5LazE3I
    feh6pstGP5trOZ6QsuJvNgsbONBkJmx5h7AbIsMyMQFWfILDR/LJVkjLrJsT/f3W
    naw6utUH5+CJJhMU2pg7awiISVGdyyYPhfqm2/eCqHsMuGhB8uQ==
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
        id S1753332AbeBKErU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:47:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41843 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752852AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mike Snitzer" <snitzer@redhat.com>,
        "Eric Biggers" <ebiggers@google.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.798067463@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 087/136] dm bufio: fix integer overflow when limiting
 maximum cache size
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 74d4108d9e681dbbe4a2940ed8fdff1f6868184c upstream.

The default max_cache_size_bytes for dm-bufio is meant to be the lesser
of 25% of the size of the vmalloc area and 2% of the size of lowmem.
However, on 32-bit systems the intermediate result in the expression

    (VMALLOC_END - VMALLOC_START) * DM_BUFIO_VMALLOC_PERCENT / 100

overflows, causing the wrong result to be computed.  For example, on a
32-bit system where the vmalloc area is 520093696 bytes, the result is
1174405 rather than the expected 130023424, which makes the maximum
cache size much too small (far less than 2% of lowmem).  This causes
severe performance problems for dm-verity users on affected systems.

Fix this by using mult_frac() to correctly multiply by a percentage.  Do
this for all places in dm-bufio that multiply by a percentage.  Also
replace (VMALLOC_END - VMALLOC_START) with VMALLOC_TOTAL, which contrary
to the comment is now defined in include/linux/vmalloc.h.

Depends-on: 9993bc635 ("sched/x86: Fix overflow in cyc2ns_offset")
Fixes: 95d402f057f2 ("dm: add bufio")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-bufio.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -888,7 +888,8 @@ static void __get_memory_limit(struct dm
 		buffers = c->minimum_buffers;
 
 	*limit_buffers = buffers;
-	*threshold_buffers = buffers * DM_BUFIO_WRITEBACK_PERCENT / 100;
+	*threshold_buffers = mult_frac(buffers,
+				       DM_BUFIO_WRITEBACK_PERCENT, 100);
 }
 
 /*
@@ -1778,19 +1779,15 @@ static int __init dm_bufio_init(void)
 	memset(&dm_bufio_caches, 0, sizeof dm_bufio_caches);
 	memset(&dm_bufio_cache_names, 0, sizeof dm_bufio_cache_names);
 
-	mem = (__u64)((totalram_pages - totalhigh_pages) *
-		      DM_BUFIO_MEMORY_PERCENT / 100) << PAGE_SHIFT;
+	mem = (__u64)mult_frac(totalram_pages - totalhigh_pages,
+			       DM_BUFIO_MEMORY_PERCENT, 100) << PAGE_SHIFT;
 
 	if (mem > ULONG_MAX)
 		mem = ULONG_MAX;
 
 #ifdef CONFIG_MMU
-	/*
-	 * Get the size of vmalloc space the same way as VMALLOC_TOTAL
-	 * in fs/proc/internal.h
-	 */
-	if (mem > (VMALLOC_END - VMALLOC_START) * DM_BUFIO_VMALLOC_PERCENT / 100)
-		mem = (VMALLOC_END - VMALLOC_START) * DM_BUFIO_VMALLOC_PERCENT / 100;
+	if (mem > mult_frac(VMALLOC_TOTAL, DM_BUFIO_VMALLOC_PERCENT, 100))
+		mem = mult_frac(VMALLOC_TOTAL, DM_BUFIO_VMALLOC_PERCENT, 100);
 #endif
 
 	dm_bufio_default_cache_size = mem;
