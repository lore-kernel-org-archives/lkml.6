Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8FAECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29450208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQer5cp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29450208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeIYBdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:33:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45594 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeIYBdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:33:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so4847623pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=y3/6bU7rADT46TOcEOr8FsIuUf9WoWa/vu2klU9m74I=;
        b=cQer5cp88AmIRKyJ0UbSg3YLRV0/+mfA/oNmukzdcJSng9fsvVqph1vwD5wfqlDX2S
         DK93+7zdTTdDgwj9ygjnnAviWMUkR/Mw6BbxSrSATc53L3YqhcCxJKoSQL28HJA3HM/9
         rreDtVPpdlgDc2sNiyPTLeWFLEtJYrFOKFTJGH2P1Fx4Wn7uuKO89AibeYe827urjySq
         JN/+0OcZY4TBMfaxqUJ+6fVpaJjph/v7O17q0q5Do9T6ycAIJ+6XXB2Y3wkHHXqGBNEP
         odddco1M09Uz/2yGCzCpWp8iY/bU2VUuAQe9PusTfjuKB4MaFUxHPamQ5PpIALQ/g0vF
         kMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=y3/6bU7rADT46TOcEOr8FsIuUf9WoWa/vu2klU9m74I=;
        b=A7aoGaDnCoSQ47GokNZTOvMavyqqNscQiKHByABSEphocB/lN9pJTU5qChWEeR57sF
         xpzkDgvqqussTbhXYhC1tNDnn7m70Hs8IPvDF8NYa+kOuLzL+fDL2HY5XKhrt4YRkgFB
         +H6rZ4jnRZaCiiikMdN6Qoudar4feYfHSlDoJ1q6nfM9CLDwlsaZV2n/hs4BnHao6ie8
         YLxrF5OssMFgDoEu3pvQXkL3v3xTpO3b+bQyxMEiNJpvlNj2k3Lf0ihqaINupSh4ujnb
         p0tBeKm1pByWE9Gubtm1xJXBQj7xCOLbUm27f1KXd+KiOzEwWXc+zAXQtZN15ovvD3FC
         AuDQ==
X-Gm-Message-State: ABuFfogoxDCAtKeiidMTrkNIpLk4zGsonrbOpXTnal2CarvrvQA1uEBh
        G5XYdLbmCneMr3DRmSeFH88AjA==
X-Google-Smtp-Source: ACcGV63MuqL6FRd4MqKm+ZD7TdPATSAEoGIr+2t+Z3GOdWrm8AdCKB4xKCsELZfrBb3W5dvyWUb7Zg==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13-v6mr249066plm.230.1537817411233;
        Mon, 24 Sep 2018 12:30:11 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id w23-v6sm139896pgi.18.2018.09.24.12.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 12:30:10 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:30:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: [patch v2] mm, thp: always specify ineligible vmas as nh in smaps
In-Reply-To: <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com> <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz> <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com>
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

This also clears the "hg" flag to make the behavior of MADV_HUGEPAGE and
PR_SET_THP_DISABLE definitive.

Fixes: 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
Signed-off-by: David Rientjes <rientjes@google.com>
---
 v2:
  - clear VM_HUGEPAGE per Vlastimil
  - update Documentation/filesystems/proc.txt to be explicit

 Documentation/filesystems/proc.txt | 12 ++++++++++--
 fs/proc/task_mmu.c                 | 14 +++++++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -490,10 +490,18 @@ manner. The codes are the following:
     dd  - do not include area into core dump
     sd  - soft-dirty flag
     mm  - mixed map area
-    hg  - huge page advise flag
-    nh  - no-huge page advise flag
+    hg  - eligible for transparent hugepages [*]
+    nh  - not eligible for transparent hugepages [*]
     mg  - mergable advise flag
 
+ [*] A process mapping is eligible to be backed by transparent hugepages (thp)
+     depending on system-wide settings and the mapping itself.  See
+     Documentation/admin-guide/mm/transhuge.rst for default behavior.  If a
+     mapping has a flag of "nh", it is not eligible to be backed by hugepages
+     in any condition, either because of prctl(PR_SET_THP_DISABLE) or
+     madvise(MADV_NOHUGEPAGE).  PR_SET_THP_DISABLE takes precedence over any
+     MADV_HUGEPAGE.
+
 Note that there is no guarantee that every flag and associated mnemonic will
 be present in all further kernel releases. Things get changed, the flags may
 be vanished or the reverse -- new added.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -653,13 +653,25 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
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
+	if (vma->vm_mm && test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)) {
+		flags &= ~VM_HUGEPAGE;
+		flags |= VM_NOHUGEPAGE;
+	}
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
