Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3729524-1523494382-2-1898268887470503417
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, URIBL_SBL 1.623, URIBL_SBL_A 0.1,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523494382; b=guuGycjeoynGDcHwD4Kb2b2BGf9d1zDqII0MeZgh5beJ4u7iGB
    /sQzTGaWJvItLcQClHWlA7OdO5PA7jivmnkN/LTFQVQ52fY2Np4ChS0IEIwZqwpW
    Mczbu5B2DGqKUKBu0zht3fLre7NXj16yrc7/jRZuwXZnKtK4eM4hZ6x0boQerhv4
    E1qf6UqbmYSsarSMRRVku2O/e67mFa4fdKG6jGDBwKaaowU0XWDOw8yzyvcF4G0b
    5S2xq0qEnaTpMGSHdyCpZ3sRvLrkbb5U5wZ/5k/96HBwFjSJYoPLIa85TAClj3Ja
    JyfGEa7LGIoSEQbsr3ibSc8mTFp1JsUpNSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:in-reply-to:references
    :from:subject:date:sender:list-id; s=fm2; t=1523494382; bh=7C81V
    ZoiugoC61aqnOTPp0fNkLiYkaKP6kmRqJrx34Y=; b=PKiDdsbQ5DrH5MH5rhLes
    B9W1IyPStJMuO0kPLa03DPGubv+wN5QixU+5SKjqx5WJZinhhOr6SPdZw4kHiZEV
    nFF0BfIWTplLilpnzZ09HbpeSlWEopPMXBe0jQ1CRZotptmZd0wcHqq5ka9DgSBH
    uF3QxlliQrveZ/QncHGkL7ebQ5QlYgwfrAnXFUYG6UJNUfz+uxyrwdctiGjzp8Bd
    mIh1nD/PvgbAa4FDVRQie6/BftCjsUu2QxvNtRxS3LTcGAkF0+BQ5qamlRukUmAv
    330hsDdTJa4dFY6TiwFA9NL6fQ8azziuSTt0F7b401auvAogltQAZe7fVX6Dpile
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKe13GjvOnhBFYBvjPEoIRkTVI10DgzD1qPgIACc6kvsbtDXtGiZDC8g41zt+iNfZOxA043q3cA1gHbychvOD+WUSQ7g6mKtj6s/fiYJNhEe2DHo+RFj
    BSOkhXKKgFfKe/lRJQXlb4tiZA7nChyh4/THGoYHLXjtDIIuZBhHqA7W+z1cRQV/4Lx7zO4/rtNvGatj0nv9x0jf6zA5vYgONTdW7Fe6lRoMMMaGN6x9foJ+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=8981fWPbAAAA:8 a=tBb2bbeoAAAA:8
    a=zYvEwg2aL9dim6SEHGUA:9 a=AjGcO6oz07-iQ99wixmX:22 a=o72u2rHnfW5qNJ_4I8LD:22
    a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeDLAwD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:52:03 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39780 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeDLAuP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:15 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Message-Id: <0785f312c30dd54f8fd1cb492fa7957758ef03e9.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 04/10] block/swim: Fix array bounds check
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the floppy_find() function in swim.c is a call to
get_disk(swd->unit[drive].disk). The actual parameter to this call
can be a NULL pointer when drive == swd->floppy_count. This causes
an oops in get_disk().

Data read fault at 0x00000198 in Super Data (pc=0x1be5b6)
BAD KERNEL BUSERR
Oops: 00000000
Modules linked in: swim_mod ipv6 mac8390
PC: [<001be5b6>] get_disk+0xc/0x76
SR: 2004  SP: 9a078bc1  a2: 0213ed90
d0: 00000000    d1: 00000000    d2: 00000000    d3: 000000ff
d4: 00000002    d5: 02983590    a0: 02332e00    a1: 022dfd64
Process dd (pid: 285, task=020ab25b)
Frame format=B ssw=074d isc=4a88 isb=6732 daddr=00000198 dobuf=00000000
baddr=001be5bc dibuf=bfffffff ver=f
Stack from 022dfca4:
        00000000 0203fc00 0213ed90 022dfcc0 02982936 00000000 00200000 022dfd08
        0020f85a 00200000 022dfd64 02332e00 004040fc 00000014 001be77e 022dfd64
        00334e4a 001be3f8 0800001d 022dfd64 01c04b60 01c04b70 022aba80 029828f8
        02332e00 022dfd2c 001be7ac 0203fc00 00200000 022dfd64 02103a00 01c04b60
        01c04b60 0200e400 022dfd68 000e191a 00200000 022dfd64 02103a00 0800001d
        00000000 00000003 000b89de 00500000 02103a00 01c04b60 02103a08 01c04c2e
Call Trace: [<02982936>] floppy_find+0x3e/0x4a [swim_mod]
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<0020f85a>] kobj_lookup+0xde/0x132
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<001be77e>] get_gendisk+0x0/0x130
 [<00334e4a>] mutex_lock+0x0/0x2e
 [<001be3f8>] disk_block_events+0x0/0x6c
 [<029828f8>] floppy_find+0x0/0x4a [swim_mod]
 [<001be7ac>] get_gendisk+0x2e/0x130
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<000e191a>] __blkdev_get+0x32/0x45a
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<000b89de>] complete_walk+0x0/0x8a
 [<000e1e22>] blkdev_get+0xe0/0x29a
 [<000e1fdc>] blkdev_open+0x0/0xb0
 [<000b89de>] complete_walk+0x0/0x8a
 [<000e1fdc>] blkdev_open+0x0/0xb0
 [<000e01cc>] bd_acquire+0x74/0x8a
 [<000e205c>] blkdev_open+0x80/0xb0
 [<000e1fdc>] blkdev_open+0x0/0xb0
 [<000abf24>] do_dentry_open+0x1a4/0x322
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<000b89de>] complete_walk+0x0/0x8a
 [<000baa62>] link_path_walk+0x0/0x48e
 [<000ba3f8>] inode_permission+0x20/0x54
 [<000ac0e4>] vfs_open+0x42/0x78
 [<000bc372>] path_openat+0x2b2/0xeaa
 [<000bc0c0>] path_openat+0x0/0xeaa
 [<0004463e>] __irq_wake_thread+0x0/0x4e
 [<0003a45a>] task_tick_fair+0x18/0xc8
 [<000bd00a>] do_filp_open+0xa0/0xea
 [<000abae0>] do_sys_open+0x11a/0x1ee
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<000abbf4>] SyS_open+0x1e/0x22
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<00002b40>] syscall+0x8/0xc
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<0000c00b>] dyadic+0x1/0x28
Code: 4e5e 4e75 4e56 fffc 2f0b 2f02 266e 0008 <206b> 0198 4a88 6732 2428 002c 661e 486b 0058 4eb9 0032 0b96 588f 4a88 672c 2008
Disabling lock debugging due to kernel taint

Fix the array index bounds check to avoid this.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Fixes: 8852ecd97488 ("[PATCH] m68k: mac - Add SWIM floppy support")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/block/swim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 92f0cddc597e..2cdfc0db5966 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -795,7 +795,7 @@ static struct kobject *floppy_find(dev_t dev, int *part, void *data)
 	struct swim_priv *swd = data;
 	int drive = (*part & 3);
 
-	if (drive > swd->floppy_count)
+	if (drive >= swd->floppy_count)
 		return NULL;
 
 	*part = 0;
-- 
2.16.1
