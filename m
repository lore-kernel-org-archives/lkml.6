Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477779-2-144835182344183853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES sk.us-asciiroen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477778; b=UfJMgYyutL1SWex7R6JezYI/1m7Z20MOISn4gE6Q9QDhszXOlH
    6J27kw3yscytxnRDXah7p5AzRaTH5/UR36nBM0kldHuWeu+lKSqCFXwqhRhhJJCD
    LOSiMAce3gl/0vbWtBT+0/Jj0OJcwhzDh7dqS+5WMwEYNTfKhEgUrDUJoD/foPuA
    4J2bflgqkVCXT0k1AWPJFQJB5AMy1fr0uy4w5HNFcuC+C/if2ZhnW0SclaSxmEk9
    FxOm4sI7kqv47gLGaOqzAmPFZhxjt9FzRn9QDBX5GSBkfQMK3xmr5r3Kr2lWpLhp
    cq0d8fA82ZiItMEUs7gHgmfBBU8ojIxTC3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477778; bh=OcqEWJVhY/0K7C6lAxsZ6xTynls8KE
    lOzJI0qluML6Y=; b=WyzmELwzMLZesjwqotmeAK44L6O6t62Z1RMwKFNI9LjHeT
    0d1As0lrLwoDewHwbIoYfguR5vuIF31flgsHsuDojGqbJYst+ZcSTStA3gffDJ5Z
    N7MqXlQZPICx/MFOnFkjjykM1+bG/NC8J3AYXXvMCctKULE0zI8uyJlZZyllTMA9
    JR6miOm57vuxauk4k4SypwbQzDztOv7A79IeE+g/wVCChmdKqa9UwgLiEvCKBQJg
    D72uqy26J/YwV6IRgvVMIgyUEQ0hzoxk2b+8Cw2nYVuVqc+TsglStnAjzopBiNgs
    /OlpuQwjBciFVVeco4VMy4ej6VigUHJbomSZzsqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLUeibBN3HQiqelHm6O3MzNsgqRDZdrxIMiJGg+VuoxY8kYtXokizLq5F5MvjYMgbDN77frGLROMmA9KLPmjM9KxTQUwiFt475H60wHVDW14GE/DxJEG
    RHS8b3tyA5GrcCHmmVr0Ivx+0bw9XQEdDBBkTnkx3xtZn1OtU5MbdUncYFcefktOB+pnJTPIYMpLcDfaDRmrjGIhEgeSJhPK9oK+a5sL/WwIvzW0aqVLlbhP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3-RhneuVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=cUYKRXiOcPSZwzcurGUA:9
    a=QEXdDO2ut3YA:10 a=VLVLkjT_5ZicWzSuYqSo:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932666AbeDKUQF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:16:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933186AbeDKSxB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rabin Vincent <rabinv@axis.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 016/310] ubi: fastmap: Fix slab corruption
Date: Wed, 11 Apr 2018 20:32:35 +0200
Message-Id: <20180411183622.997741537@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rabin Vincent <rabinv@axis.com>


[ Upstream commit 8a1435880f452430b41374d27ac4a33e7bd381ea ]

Booting with UBI fastmap and SLUB debugging enabled results in the
following splats.  The problem is that ubi_scan_fastmap() moves the
fastmap blocks from the scan_ai (allocated in scan_fast()) to the ai
allocated in ubi_attach().  This results in two problems:

 - When the scan_ai is freed, aebs which were allocated from its slab
   cache are still in use.

 - When the other ai is being destroyed in destroy_ai(), the
   arguments to kmem_cache_free() call are incorrect since aebs on its
   ->fastmap list were allocated with a slab cache from a differnt ai.

Fix this by making a copy of the aebs in ubi_scan_fastmap() instead of
moving them.

 =============================================================================
 BUG ubi_aeb_slab_cache (Not tainted): Objects remaining in ubi_aeb_slab_cache on __kmem_cache_shutdown()
 -----------------------------------------------------------------------------

 INFO: Slab 0xbfd2da3c objects=17 used=1 fp=0xb33d7748 flags=0x40000080
 CPU: 1 PID: 118 Comm: ubiattach Tainted: G    B           4.9.15 #3
 [<80111910>] (unwind_backtrace) from [<8010d498>] (show_stack+0x18/0x1c)
 [<8010d498>] (show_stack) from [<804a3274>] (dump_stack+0xb4/0xe0)
 [<804a3274>] (dump_stack) from [<8026c47c>] (slab_err+0x78/0x88)
 [<8026c47c>] (slab_err) from [<802735bc>] (__kmem_cache_shutdown+0x180/0x3e0)
 [<802735bc>] (__kmem_cache_shutdown) from [<8024e13c>] (shutdown_cache+0x1c/0x60)
 [<8024e13c>] (shutdown_cache) from [<8024ed64>] (kmem_cache_destroy+0x19c/0x20c)
 [<8024ed64>] (kmem_cache_destroy) from [<8057cc14>] (destroy_ai+0x1dc/0x1e8)
 [<8057cc14>] (destroy_ai) from [<8057f04c>] (ubi_attach+0x3f4/0x450)
 [<8057f04c>] (ubi_attach) from [<8056fe70>] (ubi_attach_mtd_dev+0x60c/0xff8)
 [<8056fe70>] (ubi_attach_mtd_dev) from [<80571d78>] (ctrl_cdev_ioctl+0x110/0x2b8)
 [<80571d78>] (ctrl_cdev_ioctl) from [<8029c77c>] (do_vfs_ioctl+0xac/0xa00)
 [<8029c77c>] (do_vfs_ioctl) from [<8029d10c>] (SyS_ioctl+0x3c/0x64)
 [<8029d10c>] (SyS_ioctl) from [<80108860>] (ret_fast_syscall+0x0/0x1c)
 INFO: Object 0xb33d7e88 @offset=3720
 INFO: Allocated in scan_peb+0x608/0x81c age=72 cpu=1 pid=118
 	kmem_cache_alloc+0x3b0/0x43c
 	scan_peb+0x608/0x81c
 	ubi_attach+0x124/0x450
 	ubi_attach_mtd_dev+0x60c/0xff8
 	ctrl_cdev_ioctl+0x110/0x2b8
 	do_vfs_ioctl+0xac/0xa00
 	SyS_ioctl+0x3c/0x64
 	ret_fast_syscall+0x0/0x1c
 kmem_cache_destroy ubi_aeb_slab_cache: Slab cache still has objects
 CPU: 1 PID: 118 Comm: ubiattach Tainted: G    B           4.9.15 #3
 [<80111910>] (unwind_backtrace) from [<8010d498>] (show_stack+0x18/0x1c)
 [<8010d498>] (show_stack) from [<804a3274>] (dump_stack+0xb4/0xe0)
 [<804a3274>] (dump_stack) from [<8024ed80>] (kmem_cache_destroy+0x1b8/0x20c)
 [<8024ed80>] (kmem_cache_destroy) from [<8057cc14>] (destroy_ai+0x1dc/0x1e8)
 [<8057cc14>] (destroy_ai) from [<8057f04c>] (ubi_attach+0x3f4/0x450)
 [<8057f04c>] (ubi_attach) from [<8056fe70>] (ubi_attach_mtd_dev+0x60c/0xff8)
 [<8056fe70>] (ubi_attach_mtd_dev) from [<80571d78>] (ctrl_cdev_ioctl+0x110/0x2b8)
 [<80571d78>] (ctrl_cdev_ioctl) from [<8029c77c>] (do_vfs_ioctl+0xac/0xa00)
 [<8029c77c>] (do_vfs_ioctl) from [<8029d10c>] (SyS_ioctl+0x3c/0x64)
 [<8029d10c>] (SyS_ioctl) from [<80108860>] (ret_fast_syscall+0x0/0x1c)
 cache_from_obj: Wrong slab cache. ubi_aeb_slab_cache but object is from ubi_aeb_slab_cache
 ------------[ cut here ]------------
 WARNING: CPU: 1 PID: 118 at mm/slab.h:354 kmem_cache_free+0x39c/0x450
 Modules linked in:
 CPU: 1 PID: 118 Comm: ubiattach Tainted: G    B           4.9.15 #3
 [<80111910>] (unwind_backtrace) from [<8010d498>] (show_stack+0x18/0x1c)
 [<8010d498>] (show_stack) from [<804a3274>] (dump_stack+0xb4/0xe0)
 [<804a3274>] (dump_stack) from [<80120e40>] (__warn+0xf4/0x10c)
 [<80120e40>] (__warn) from [<80120f20>] (warn_slowpath_null+0x28/0x30)
 [<80120f20>] (warn_slowpath_null) from [<80271fe0>] (kmem_cache_free+0x39c/0x450)
 [<80271fe0>] (kmem_cache_free) from [<8057cb88>] (destroy_ai+0x150/0x1e8)
 [<8057cb88>] (destroy_ai) from [<8057ef1c>] (ubi_attach+0x2c4/0x450)
 [<8057ef1c>] (ubi_attach) from [<8056fe70>] (ubi_attach_mtd_dev+0x60c/0xff8)
 [<8056fe70>] (ubi_attach_mtd_dev) from [<80571d78>] (ctrl_cdev_ioctl+0x110/0x2b8)
 [<80571d78>] (ctrl_cdev_ioctl) from [<8029c77c>] (do_vfs_ioctl+0xac/0xa00)
 [<8029c77c>] (do_vfs_ioctl) from [<8029d10c>] (SyS_ioctl+0x3c/0x64)
 [<8029d10c>] (SyS_ioctl) from [<80108860>] (ret_fast_syscall+0x0/0x1c)
 ---[ end trace 2bd8396277fd0a0b ]---
 =============================================================================
 BUG ubi_aeb_slab_cache (Tainted: G    B   W      ): page slab pointer corrupt.
 -----------------------------------------------------------------------------

 INFO: Allocated in scan_peb+0x608/0x81c age=104 cpu=1 pid=118
 	kmem_cache_alloc+0x3b0/0x43c
 	scan_peb+0x608/0x81c
 	ubi_attach+0x124/0x450
 	ubi_attach_mtd_dev+0x60c/0xff8
 	ctrl_cdev_ioctl+0x110/0x2b8
 	do_vfs_ioctl+0xac/0xa00
 	SyS_ioctl+0x3c/0x64
 	ret_fast_syscall+0x0/0x1c
 INFO: Slab 0xbfd2da3c objects=17 used=1 fp=0xb33d7748 flags=0x40000081
 INFO: Object 0xb33d7e88 @offset=3720 fp=0xb33d7da0

 Redzone b33d7e80: cc cc cc cc cc cc cc cc                          ........
 Object b33d7e88: 02 00 00 00 01 00 00 00 00 f0 ff 7f ff ff ff ff  ................
 Object b33d7e98: 00 00 00 00 00 00 00 00 bd 16 00 00 00 00 00 00  ................
 Object b33d7ea8: 00 01 00 00 00 02 00 00 00 00 00 00 00 00 00 00  ................
 Redzone b33d7eb8: cc cc cc cc                                      ....
 Padding b33d7f60: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
 CPU: 1 PID: 118 Comm: ubiattach Tainted: G    B   W       4.9.15 #3
 [<80111910>] (unwind_backtrace) from [<8010d498>] (show_stack+0x18/0x1c)
 [<8010d498>] (show_stack) from [<804a3274>] (dump_stack+0xb4/0xe0)
 [<804a3274>] (dump_stack) from [<80271770>] (free_debug_processing+0x320/0x3c4)
 [<80271770>] (free_debug_processing) from [<80271ad0>] (__slab_free+0x2bc/0x430)
 [<80271ad0>] (__slab_free) from [<80272024>] (kmem_cache_free+0x3e0/0x450)
 [<80272024>] (kmem_cache_free) from [<8057cb88>] (destroy_ai+0x150/0x1e8)
 [<8057cb88>] (destroy_ai) from [<8057ef1c>] (ubi_attach+0x2c4/0x450)
 [<8057ef1c>] (ubi_attach) from [<8056fe70>] (ubi_attach_mtd_dev+0x60c/0xff8)
 [<8056fe70>] (ubi_attach_mtd_dev) from [<80571d78>] (ctrl_cdev_ioctl+0x110/0x2b8)
 [<80571d78>] (ctrl_cdev_ioctl) from [<8029c77c>] (do_vfs_ioctl+0xac/0xa00)
 [<8029c77c>] (do_vfs_ioctl) from [<8029d10c>] (SyS_ioctl+0x3c/0x64)
 [<8029d10c>] (SyS_ioctl) from [<80108860>] (ret_fast_syscall+0x0/0x1c)
 FIX ubi_aeb_slab_cache: Object at 0xb33d7e88 not freed

Signed-off-by: Rabin Vincent <rabinv@axis.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/ubi/fastmap.c |   33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -828,6 +828,24 @@ static int find_fm_anchor(struct ubi_att
 	return ret;
 }
 
+static struct ubi_ainf_peb *clone_aeb(struct ubi_attach_info *ai,
+				      struct ubi_ainf_peb *old)
+{
+	struct ubi_ainf_peb *new;
+
+	new = ubi_alloc_aeb(ai, old->pnum, old->ec);
+	if (!new)
+		return NULL;
+
+	new->vol_id = old->vol_id;
+	new->sqnum = old->sqnum;
+	new->lnum = old->lnum;
+	new->scrub = old->scrub;
+	new->copy_flag = old->copy_flag;
+
+	return new;
+}
+
 /**
  * ubi_scan_fastmap - scan the fastmap.
  * @ubi: UBI device object
@@ -847,7 +865,7 @@ int ubi_scan_fastmap(struct ubi_device *
 	struct ubi_vid_hdr *vh;
 	struct ubi_ec_hdr *ech;
 	struct ubi_fastmap_layout *fm;
-	struct ubi_ainf_peb *tmp_aeb, *aeb;
+	struct ubi_ainf_peb *aeb;
 	int i, used_blocks, pnum, fm_anchor, ret = 0;
 	size_t fm_size;
 	__be32 crc, tmp_crc;
@@ -857,9 +875,16 @@ int ubi_scan_fastmap(struct ubi_device *
 	if (fm_anchor < 0)
 		return UBI_NO_FASTMAP;
 
-	/* Move all (possible) fastmap blocks into our new attach structure. */
-	list_for_each_entry_safe(aeb, tmp_aeb, &scan_ai->fastmap, u.list)
-		list_move_tail(&aeb->u.list, &ai->fastmap);
+	/* Copy all (possible) fastmap blocks into our new attach structure. */
+	list_for_each_entry(aeb, &scan_ai->fastmap, u.list) {
+		struct ubi_ainf_peb *new;
+
+		new = clone_aeb(ai, aeb);
+		if (!new)
+			return -ENOMEM;
+
+		list_add(&new->u.list, &ai->fastmap);
+	}
 
 	down_write(&ubi->fm_protect);
 	memset(ubi->fm_buf, 0, ubi->fm_size);
