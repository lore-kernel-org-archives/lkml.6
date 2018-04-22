Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406590-2-5117813643844212195
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406589; b=ajjSJNBq4RGwYN2GdJ2G2LwkWeKHHoNwUNgyXBc3AM8vU3onFJ
    3Hz+Z0f4YRQkACKd7euQkivGySxwhUPKiNPW7DKZlePA/OqFdk6dtZ3RTSgyQr4j
    k9JBK6a8m7ASVJzZxSLQ9dTVw3VPuzPtkgEgGdt2PJAPHyUFqPUXyeLgQuOGcLbu
    HzfIPm59SoPmQdFC1c9/+Y7fjat+jiQxxWpbI/YGJ4vXedCe2wC0bL6x5gAvO8zE
    cOA2m55oEw4BTdvlOmAEqCWTmALrc/NviqQeX1UyehHHHCl5bqLpv+TLcI/8wuoO
    kaBA84J07R6j8+AUueP8LQLRsBDVExGj4zFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406589; bh=Z+9mXbR8hHaQbdKGgVLEzeZYjSInkI
    F2C0HwgB8gj1Y=; b=QgZmcY0zbu1RFtLR0kLZM7JgHh/ZwClUpDmLcmjh7HO6QS
    p6L2qGxPvsENb4C5DXdizHMafCaT2j/8Xd6ROEttYUlLoFTVrE+F+rBw/z5s7XcK
    Ze2kcf9dSmiodPjPjqBR9xs+nKG3O54yVYAruYrk1KWswE2472xHNW1y1ZNG+2PU
    VxwGybZuudjRPQgi7n2XR5OStXgJO67ZB8na9eRyQ4XbwR5I27mCJJiMglIHk/Kl
    xr8Li4zy/vD46reSPXfDurp/9B7vFQ5Rc6tQ+oJuchG1XOHim8Llpv69e6iFep5h
    ztH/oxhtYpIJ8Xt2dvc8+vUoDThKjTmwuDoKWfHg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNO2Lq8Axyo7txcriPOEyhwLRWUpl5rLj8dGJHrrPgkMUnA6w/FgmJDGno5To4w1WVNlgJ4hRxoxbYDnrqPU5Tl/yYsl+s8X6wny9kI89+yRxQZLiYmE
    pYADXLdfBixFdv5iJbrKxg6MeIQbdm6VvtdB3gBJe3sEnB/O4U2JfuJ3s3BkfDc3qhZGjFqvaXNBSKKa6P+HPBEF77T6WsdUfbwZyg3dzyVDgKUVCYmvwsZ7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8
    a=QyXUC8HyAAAA:8 a=MqK6kde1AAAA:8 a=PtDNVHqPAAAA:8 a=Z4Rwk6OoAAAA:8
    a=ag1SF4gXAAAA:8 a=7hGXG0wdR98EPOhUFxUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cQPPKAXgyycSBL8etih5:22 a=9aqP8kKXEzZd0rnup5AB:22
    a=BpimnaHY1jUKGyF_4-AF:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756709AbeDVOQZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:16:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbeDVOQW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:16:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d11f321e7f1923157eac80aa990b446596f46439@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 28/97] ipc/shm: fix use-after-free of shm file via remap_file_pages()
Date: Sun, 22 Apr 2018 15:53:06 +0200
Message-Id: <20180422135306.721342962@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 3f05317d9889ab75c7190dcd39491d2a97921984 upstream.

syzbot reported a use-after-free of shm_file_data(file)->file->f_op in
shm_get_unmapped_area(), called via sys_remap_file_pages().

Unfortunately it couldn't generate a reproducer, but I found a bug which
I think caused it.  When remap_file_pages() is passed a full System V
shared memory segment, the memory is first unmapped, then a new map is
created using the ->vm_file.  Between these steps, the shm ID can be
removed and reused for a new shm segment.  But, shm_mmap() only checks
whether the ID is currently valid before calling the underlying file's
->mmap(); it doesn't check whether it was reused.  Thus it can use the
wrong underlying file, one that was already freed.

Fix this by making the "outer" shm file (the one that gets put in
->vm_file) hold a reference to the real shm file, and by making
__shm_open() require that the file associated with the shm ID matches
the one associated with the "outer" file.

Taking the reference to the real shm file is needed to fully solve the
problem, since otherwise sfd->file could point to a freed file, which
then could be reallocated for the reused shm ID, causing the wrong shm
segment to be mapped (and without the required permission checks).

Commit 1ac0b6dec656 ("ipc/shm: handle removed segments gracefully in
shm_mmap()") almost fixed this bug, but it didn't go far enough because
it didn't consider the case where the shm ID is reused.

The following program usually reproduces this bug:

	#include <stdlib.h>
	#include <sys/shm.h>
	#include <sys/syscall.h>
	#include <unistd.h>

	int main()
	{
		int is_parent = (fork() != 0);
		srand(getpid());
		for (;;) {
			int id = shmget(0xF00F, 4096, IPC_CREAT|0700);
			if (is_parent) {
				void *addr = shmat(id, NULL, 0);
				usleep(rand() % 50);
				while (!syscall(__NR_remap_file_pages, addr, 4096, 0, 0, 0));
			} else {
				usleep(rand() % 50);
				shmctl(id, IPC_RMID, NULL);
			}
		}
	}

It causes the following NULL pointer dereference due to a 'struct file'
being used while it's being freed.  (I couldn't actually get a KASAN
use-after-free splat like in the syzbot report.  But I think it's
possible with this bug; it would just take a more extraordinary race...)

	BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
	PGD 0 P4D 0
	Oops: 0000 [#1] SMP NOPTI
	CPU: 9 PID: 258 Comm: syz_ipc Not tainted 4.16.0-05140-gf8cf2f16a7c95 #189
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
	RIP: 0010:d_inode include/linux/dcache.h:519 [inline]
	RIP: 0010:touch_atime+0x25/0xd0 fs/inode.c:1724
	[...]
	Call Trace:
	 file_accessed include/linux/fs.h:2063 [inline]
	 shmem_mmap+0x25/0x40 mm/shmem.c:2149
	 call_mmap include/linux/fs.h:1789 [inline]
	 shm_mmap+0x34/0x80 ipc/shm.c:465
	 call_mmap include/linux/fs.h:1789 [inline]
	 mmap_region+0x309/0x5b0 mm/mmap.c:1712
	 do_mmap+0x294/0x4a0 mm/mmap.c:1483
	 do_mmap_pgoff include/linux/mm.h:2235 [inline]
	 SYSC_remap_file_pages mm/mmap.c:2853 [inline]
	 SyS_remap_file_pages+0x232/0x310 mm/mmap.c:2769
	 do_syscall_64+0x64/0x1a0 arch/x86/entry/common.c:287
	 entry_SYSCALL_64_after_hwframe+0x42/0xb7

[ebiggers@google.com: add comment]
  Link: http://lkml.kernel.org/r/20180410192850.235835-1-ebiggers3@gmail.com
Link: http://lkml.kernel.org/r/20180409043039.28915-1-ebiggers3@gmail.com
Reported-by: syzbot+d11f321e7f1923157eac80aa990b446596f46439@syzkaller.appspotmail.com
Fixes: c8d78c1823f4 ("mm: replace remap_file_pages() syscall with emulation")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 ipc/shm.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -198,6 +198,12 @@ static int __shm_open(struct vm_area_str
 	if (IS_ERR(shp))
 		return PTR_ERR(shp);
 
+	if (shp->shm_file != sfd->file) {
+		/* ID was reused */
+		shm_unlock(shp);
+		return -EINVAL;
+	}
+
 	shp->shm_atim = get_seconds();
 	shp->shm_lprid = task_tgid_vnr(current);
 	shp->shm_nattch++;
@@ -414,8 +420,9 @@ static int shm_mmap(struct file *file, s
 	int ret;
 
 	/*
-	 * In case of remap_file_pages() emulation, the file can represent
-	 * removed IPC ID: propogate shm_lock() error to caller.
+	 * In case of remap_file_pages() emulation, the file can represent an
+	 * IPC ID that was removed, and possibly even reused by another shm
+	 * segment already.  Propagate this case as an error to caller.
 	 */
 	ret =__shm_open(vma);
 	if (ret)
@@ -439,6 +446,7 @@ static int shm_release(struct inode *ino
 	struct shm_file_data *sfd = shm_file_data(file);
 
 	put_ipc_ns(sfd->ns);
+	fput(sfd->file);
 	shm_file_data(file) = NULL;
 	kfree(sfd);
 	return 0;
@@ -1198,7 +1206,16 @@ long do_shmat(int shmid, char __user *sh
 	file->f_mapping = shp->shm_file->f_mapping;
 	sfd->id = shp->shm_perm.id;
 	sfd->ns = get_ipc_ns(ns);
-	sfd->file = shp->shm_file;
+	/*
+	 * We need to take a reference to the real shm file to prevent the
+	 * pointer from becoming stale in cases where the lifetime of the outer
+	 * file extends beyond that of the shm segment.  It's not usually
+	 * possible, but it can happen during remap_file_pages() emulation as
+	 * that unmaps the memory, then does ->mmap() via file reference only.
+	 * We'll deny the ->mmap() if the shm segment was since removed, but to
+	 * detect shm ID reuse we need to compare the file pointers.
+	 */
+	sfd->file = get_file(shp->shm_file);
 	sfd->vm_ops = NULL;
 
 	err = security_mmap_file(file, prot, flags);
