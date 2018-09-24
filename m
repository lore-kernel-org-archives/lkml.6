Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D56C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5C12098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArkkAbBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5C12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeIXX63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:58:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43995 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbeIXX63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:58:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id q19-v6so8626661pgn.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=acQZ1c3ZTnzczKa6BhJggeMTL4Qqf0ubRdo+V93bzPc=;
        b=ArkkAbBGTPYlbajANYiDfnI9eb896L777N0vYOj7yEssBCSjA8IeR7mwMl1lWVQ897
         zpoBtzA8W1x8LUSDZ38osDQYsD/YHB1/0bCyoZ5ePI/tfPznTcuQYG6lpGe/O3m243uB
         8ZwVRfjUbi5L5RnOnYnbO0mD7hW59m1DuDvFrGLj/3+N4AULRZo72+l/e7Ygk5hvJbNW
         6KRDK8aTUiNyySDh9FE9rS41KaHrtY/tJSKg+psRi5l172ffmRW6+hzujEZwfP0k8j0n
         qae1mC2ZSTL1B8VgbhU4WRipqMIFQYZNfuMJbfWaXJ5kBfLXm4YJgV6s5bYQFSlscUeG
         m28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=acQZ1c3ZTnzczKa6BhJggeMTL4Qqf0ubRdo+V93bzPc=;
        b=n9/j8cxQ2YmzC8KiLCDYYUZ6Vsix3Ef+HqLURRVlzZMxNeh7znuO4LQXBEe0nOpd8H
         5Vxk5s3jH5L7X8fjrf33GQpXKSyNGj7FlA/d2zuBl3NtcCOIFxPuNb0FPuueXLUGM8lE
         VfHI3APRVe9TH4NX7P9WBXjDHEkLO/uXi9lWSovlqCZeQiKx//i0OnBcyypM9qYQQEvv
         f3ar9wHrmdPiWvuyAh/vCIrszcpgA5w9/OzcxZ7/cvFrzGDrUHHgjQcb3VYMlPcYkexz
         XEZyiT9mG11Ad0INK/1gBKobF3gzglS/N5a/enUOnvOJhi12ic8sjyu0W4avJtFsaAsB
         U1+g==
X-Gm-Message-State: ABuFfojcF1+F0awIg8kOBqFypNyOoaOXXoyoveJZvGU/RIOXbumgIQwi
        Axq90R8Ffcgh0IJeO0Iqh+Y6QQ==
X-Google-Smtp-Source: ACcGV61TKA+H4q6AWBm0bs4g9nekFT1oAeWeeaxSVrZw+pM2gCwd2+4I7THA+zcE4MF8XI++bnaDDw==
X-Received: by 2002:a63:141c:: with SMTP id u28-v6mr10578246pgl.247.1537811709215;
        Mon, 24 Sep 2018 10:55:09 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t23-v6sm19975632pfl.109.2018.09.24.10.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:55:08 -0700 (PDT)
Date:   Mon, 24 Sep 2018 10:55:05 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: [patch] mm, thp: always specify ineligible vmas as nh in smaps
Message-ID: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
introduced a regression in that userspace cannot always determine the set
of vmas where thp is ineligible.

Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
to determine if a vma is eligible to be backed by hugepages.

Previous to this commit, prctl(PR_SET_THP_DISABLE, 1) would cause thp to
be disabled and emit "nh" as a flag for the corresponding vmas as part of
/proc/pid/smaps.  After the commit, thp is disabled by means of an mm
flag and "nh" is not emitted.

This causes smaps parsing libraries to assume a vma is eligible for thp
and ends up puzzling the user on why its memory is not backed by thp.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 fs/proc/task_mmu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -653,13 +653,23 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 	};
+	unsigned long flags = vma->vm_flags;
 	size_t i;
 
+	/*
+	 * Disabling thp is possible through both MADV_NOHUGEPAGE and
+	 * PR_SET_THP_DISABLE.  Both historically used VM_NOHUGEPAGE.  Since
+	 * the introduction of MMF_DISABLE_THP, however, userspace needs the
+	 * ability to detect vmas where thp is not eligible in the same manner.
+	 */
+	if (vma->vm_mm && test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+		flags |= VM_NOHUGEPAGE;
+
 	seq_puts(m, "VmFlags: ");
 	for (i = 0; i < BITS_PER_LONG; i++) {
 		if (!mnemonics[i][0])
 			continue;
-		if (vma->vm_flags & (1UL << i)) {
+		if (flags & (1UL << i)) {
 			seq_putc(m, mnemonics[i][0]);
 			seq_putc(m, mnemonics[i][1]);
 			seq_putc(m, ' ');
