Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1414047-1519989643-2-970401992092031236
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989642; b=mdYQiyvhN7Q7ht3LPGm3TooACNQDrnPGLFJYsa2vEzArbD/
    kvUj4NT8A8bzxSouRpnzUtC1WM1xJ1/Xp5Px5IPXTqAcQelxeJXcUYGrhc6l9xTf
    jVZW2pBcI8lFrCbunBQgH5GnT5xPLz9WN8kTsFHZYW9viPUfrPpl87H8iQBtLMgM
    KQLiX3DgqVIiCD/8TJoU3E6t4pG3vml508q83poulAIXZ2GK/K/oUVW4CIZdDJvN
    k0KIOqeGsKcWbDW+CBLKbRGzZOlD2IH1TexS+fhtu99XrSpDC8YhNwlPa9CqfKbo
    tmE7+vR3QLaRHnVnRCnjOiZ4156yAGVXYi60a4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519989642; bh=ScFzQaYYl5ulLpUHMYwXr4/heP
    ga9oBPdd92czawdhk=; b=Efq3fGJ2L2/dAaqOKvKzVmrTa0Y7Fs5c8dRgCha+Rm
    /ULX0IMt/a6KiK6+GTRLMGf9Z1sMLCLAxBMqBIIeuW/QSZy5lG4ga1IQjV5zTlU8
    7xg/RduTU/a2br7ZY2IYvWQ81n14edOEq+O+j7R6Oy/yMD/adKnVRQ1VecgthLOW
    ZpK+RJEjHBmS/K/tQ5SlgRWV/mpy9Ymtd5CdywRSk8SeyNW1HSQOdkXzP4yY9eR1
    arQGLTNa8uTrbkIZCZtdpJ98sogzoKWRqazfbmjHXIyGybNLmcctkLzcCAz017g1
    o4gkYxz5RpzEovlwEZHxSmivhjVgvwjrJ9i88dAoHBxA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.alibaba.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.alibaba.com header.result=pass header_org.domain=alibaba.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.alibaba.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.alibaba.com header.result=pass header_org.domain=alibaba.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427052AbeCBLUV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:20:21 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46640 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1423202AbeCBLUQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 2 Mar 2018 06:20:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xinyong.fang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0SynxPsz_1519989607;
From: Xinyong <xinyong.fang@linux.alibaba.com>
To: balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc: zhangjerry@google.com, mina86@mina86.com, plr.vincent@gmail.com,
        shuang.liu@intel.com, xulun@linux.alibaba.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/1] usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()
Date: Fri,  2 Mar 2018 19:20:07 +0800
Message-Id: <1519989607-16098-1-git-send-email-xinyong.fang@linux.alibaba.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When I debug a kernel crash issue in funcitonfs, found ffs_data.ref
overflowed, While functionfs is unmounting, ffs_data is put twice.

Commit 43938613c6fd ("drivers, usb: convert ffs_data.ref from atomic_t to
refcount_t") can avoid refcount overflow, but that is risk some situations.
So no need put ffs data in ffs_fs_kill_sb, already put in ffs_data_closed.

The issue can be reproduced in Mediatek mt6763 SoC, ffs for ADB device.
KASAN enabled configuration reports use-after-free errro.

BUG: KASAN: use-after-free in refcount_dec_and_test+0x14/0xe0 at addr ffffffc0579386a0
Read of size 4 by task umount/4650
====================================================
BUG kmalloc-512 (Tainted: P        W  O   ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in ffs_fs_mount+0x194/0x844 age=22856 cpu=2 pid=566
    alloc_debug_processing+0x1ac/0x1e8
    ___slab_alloc.constprop.63+0x640/0x648
    __slab_alloc.isra.57.constprop.62+0x24/0x34
    kmem_cache_alloc_trace+0x1a8/0x2bc
    ffs_fs_mount+0x194/0x844
    mount_fs+0x6c/0x1d0
    vfs_kern_mount+0x50/0x1b4
    do_mount+0x258/0x1034
INFO: Freed in ffs_data_put+0x25c/0x320 age=0 cpu=3 pid=4650
    free_debug_processing+0x22c/0x434
    __slab_free+0x2d8/0x3a0
    kfree+0x254/0x264
    ffs_data_put+0x25c/0x320
    ffs_data_closed+0x124/0x15c
    ffs_fs_kill_sb+0xb8/0x110
    deactivate_locked_super+0x6c/0x98
    deactivate_super+0xb0/0xbc
INFO: Object 0xffffffc057938600 @offset=1536 fp=0x          (null)
......
Call trace:
[<ffffff900808cf5c>] dump_backtrace+0x0/0x250
[<ffffff900808d3a0>] show_stack+0x14/0x1c
[<ffffff90084a8c04>] dump_stack+0xa0/0xc8
[<ffffff900826c2b4>] print_trailer+0x158/0x260
[<ffffff900826d9d8>] object_err+0x3c/0x40
[<ffffff90082745f0>] kasan_report_error+0x2a8/0x754
[<ffffff9008274f84>] kasan_report+0x5c/0x60
[<ffffff9008273208>] __asan_load4+0x70/0x88
[<ffffff90084cd81c>] refcount_dec_and_test+0x14/0xe0
[<ffffff9008d98f9c>] ffs_data_put+0x80/0x320
[<ffffff9008d9d904>] ffs_fs_kill_sb+0xc8/0x110
[<ffffff90082852a0>] deactivate_locked_super+0x6c/0x98
[<ffffff900828537c>] deactivate_super+0xb0/0xbc
[<ffffff90082af0c0>] cleanup_mnt+0x64/0xec
[<ffffff90082af1b0>] __cleanup_mnt+0x10/0x18
[<ffffff90080d9e68>] task_work_run+0xcc/0x124
[<ffffff900808c8c0>] do_notify_resume+0x60/0x70
[<ffffff90080866e4>] work_pending+0x10/0x14

Cc: stable@vger.kernel.org
Signed-off-by: Xinyong <xinyong.fang@linux.alibaba.com>
---
 drivers/usb/gadget/function/f_fs.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index c2592d8..d2428a9 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1538,7 +1538,6 @@ static int ffs_fs_parse_opts(struct ffs_sb_fill_data *data, char *opts)
 	if (sb->s_fs_info) {
 		ffs_release_dev(sb->s_fs_info);
 		ffs_data_closed(sb->s_fs_info);
-		ffs_data_put(sb->s_fs_info);
 	}
 }
 
-- 
1.7.9.5

