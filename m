Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324172-2-7870690982257129273
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
    t=1518324171; b=l7jKQ7+DfG6LhB/lKjk6QBGqgY9WaaG9Dhc9x/pmktA2P1k
    YPTJpDXOycG+g4Pf5hbjhyQEiQwVDuplxkd8otBNbXiOKQEf/SKXFH4IsK+a1Wyk
    q/Fauigp+ATQ6gaviGA2tVWcF1sruoUw0ybJ8ozA4oCkXagkAyywAk/9rLp+5/1R
    BlI7NP0tzeM3vHHMqjl+qarJ5G3L+6OuGBM82GXooa25cEPH+yuW10Vj6dizrFRg
    Aq7GK7Buqv3fJGOI+luRgJch6q/t/DKtic6GihXFMdumW5WBJqEVIFEjQSvmxOcp
    4jHBETnOKndFHgNzjv4Q7rASz2qaPuK49Iey84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324171; bh=F6gJTbuC0B9cAbLne0v
    OBxWFr/CMbbrjSrnOIWidD00=; b=clKzHBJlmfbUwocyI4dLmv9yWrrg4VRiPnO
    nHqyyCyQxK9qYUVdIn8BazHDMrO015sIbbi1DQJgWlUjt0N1zrZHW//3Q99YiXFm
    iZcesSenQWX/OPRifWbXbZm7Tcv0ziaa11gyAkUCqFTSWdmgPICXiPiX1v9v5ZEJ
    JDwge4uhx7AmvoAdMkyM6DLN6+Z8sj7wPPIZi7nSikVAtAozRJIQiqeITJ+D42IC
    EyyYMlPjBbvyeM37TuF7QjV3teqHHFST3le87mubz4flKNQIi8cUCZdoCO4rNU95
    8L1CpQ4X5fotc3e8QU1EtvLc7w750tblcpMSVwCdX7w+5bScMkw==
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
        id S1752921AbeBKEky (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:40:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41687 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752931AbeBKEeH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:07 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Colin Ian King" <colin.king@canonical.com>,
        "David Sterba" <dsterba@suse.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.111048275@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 037/136] btrfs: avoid null pointer dereference on
 fs_info when calling btrfs_crit
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

From: Colin Ian King <colin.king@canonical.com>

commit 3993b112dac968612b0b213ed59cb30f50b0015b upstream.

There are checks on fs_info in __btrfs_panic to avoid dereferencing a
null fs_info, however, there is a call to btrfs_crit that may also
dereference a null fs_info. Fix this by adding a check to see if fs_info
is null and only print the s_id if fs_info is non-null.

Detected by CoverityScan CID#401973 ("Dereference after null check")

Fixes: efe120a067c8 ("Btrfs: convert printk to btrfs_ and fix BTRFS prefix")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -185,7 +185,6 @@ static const char * const logtypes[] = {
 
 void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
 {
-	struct super_block *sb = fs_info->sb;
 	char lvl[4];
 	struct va_format vaf;
 	va_list args;
@@ -207,7 +206,8 @@ void btrfs_printk(const struct btrfs_fs_
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	printk("%sBTRFS %s (device %s): %pV\n", lvl, type, sb->s_id, &vaf);
+	printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
+		fs_info ? fs_info->sb->s_id : "<unknown>", &vaf);
 
 	va_end(args);
 }
