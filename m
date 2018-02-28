Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832478-2-4338736849644825425
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
    t=1519832477; b=mNyPQeM71syaHEeE7v5spCxAL0wcDRqvGxWrJdlRLXts4ev
    uvzq3q0RzEbqaeotxbcauSJXs5a9142f72BkkuKrg9BOwKfNBAJvw6H+HZPUdx91
    O0XD2mFrHmX6RiG0QIZWgYxQraNvOCC/t1WrJ9O55+729uy2Q0ytO1+9m7In2sOb
    Vz6eJTx0xsFQ0xgIeEmaupvlozsvOk2KID6mS32ptC0PkY38mfb5HG+FyvboQcLn
    +c0bFP5gAPh7iSQNodUnBcXQD+oHLfccOWLvKpKANgpK7Tjhwk+/45vPz88ZgE3a
    KoANA74vHjvXe2CbdA3cmUSRDl7vEVhGVRF5NXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832477; bh=iMuhM/dCmn4lsZPR6zM
    BtI7ngwO27Xw2d87cOHp+6/c=; b=Wg5N2Wa0z6vSFDCowMcywYElJr6oKPrnm1x
    5y5Us+2KHLnAJdrtnmzMTWhNaZCyBeCKzuPXxHYHYeGCePWr3Q4gHEDdOgJ+X7ql
    QoVBNTY/Zkn4km7RpYXuWtvejvmPX77p6I81NhkbnibOLMfFpB7wAfNxRi7UZfmZ
    1uVAEEI8xePvKCeRGoTwgzhGBmlSIaiqAcF85MEKwfQwD81IPwBsX14omZLuEVJz
    NrLBVA9ODBNJjusz3W737+zyfKgKdPzf0EivCpVosV+wGztcyy/VVz2qjHDiNze7
    8FGQENMYclFrcEPw4gZAAB7KFd3LcTfg1vuaWSwdUUOkXhCMLZg==
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
        id S933155AbeB1PjC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:39:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33212 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932292AbeB1PW1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:27 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Omar Sandoval" <osandov@fb.com>,
        "Qu Wenruo" <wqu@suse.com>, "David Sterba" <dsterba@suse.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.415521723@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 064/254] Btrfs: disable FUA if mounted with nobarrier
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

From: Omar Sandoval <osandov@fb.com>

commit 1b9e619c5bc8235cfba3dc4ced2fb0e3554a05d4 upstream.

I was seeing disk flushes still happening when I mounted a Btrfs
filesystem with nobarrier for testing. This is because we use FUA to
write out the first super block, and on devices without FUA support, the
block layer translates FUA to a flush. Even on devices supporting true
FUA, using FUA when we asked for no barriers is surprising.

Fixes: 387125fc722a8ed ("Btrfs: fix barrier flushes")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16:
 - I/O flag names are different, and are combined with the operation type
 - Use the do_barrier parameter instead of checking the NOBARRIER option again]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3140,6 +3140,7 @@ static int write_dev_supers(struct btrfs
 	int errors = 0;
 	u32 crc;
 	u64 bytenr;
+	int op_flags;
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
@@ -3204,10 +3205,10 @@ static int write_dev_supers(struct btrfs
 		 * we fua the first super.  The others we allow
 		 * to go down lazy.
 		 */
-		if (i == 0)
-			ret = btrfsic_submit_bh(WRITE_FUA, bh);
-		else
-			ret = btrfsic_submit_bh(WRITE_SYNC, bh);
+		op_flags = REQ_SYNC | REQ_NOIDLE;
+		if (i == 0 && do_barriers)
+			op_flags |= REQ_FUA;
+		ret = btrfsic_submit_bh(WRITE | op_flags, bh);
 		if (ret)
 			errors++;
 	}
