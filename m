Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE20C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39AB2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gSUR43+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39AB2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeIZEAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:00:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46110 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeIZEAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:00:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id d8-v6so5169780pfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0Ce3odqB1qLWdsb9KwAtrrneVWS1aumo0hFHF3fNi7g=;
        b=gSUR43+h76jAdTnpQeXIJ2ffj5rNknYEG5mO5zgIaKOziDQVZdZWYnb7t5XN+s0mAZ
         700yPJYax2GX5nQvqnfN2J0mEfQ9dPgV496JpmNSvu4n7CqiKSFeTxuWG1byOEeqCeO1
         0hqx9Rxnw8FtdgMIX9Z58V6Eu9Kut/C3W0rWCvMXdfVqn9j0ttdueE7M0OhpbDrvieet
         BT2ch5WqEmAF7PYLH0jfNjpsisz3fjqSwgFCbASAcX2WlqktDPl4GnreT6SjmD0BdiRw
         dV/H3eDs4f4GWZZ/78pv0uQ70Qxoy53AgEeKPqx6MyANOEwEr3wvf/1nJ3m82IJcjI1T
         B6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0Ce3odqB1qLWdsb9KwAtrrneVWS1aumo0hFHF3fNi7g=;
        b=asbs8K6Kiv2lJrO6NJ1P3JND12cmAHvqXF49MDUAgP398DTsT2kwLrrwgjD1DXQDQq
         gBxLRMS3qzO7l3JS1kweXy4OLo6pppZEu0wSredmHOjMAmZhnd6k8mRotO4m0drk8qq/
         b6WCd/QpwUTCODvwIafpPstLBkL7jxRaBjF0zMe1tv4zHkRp4XxNBpEJhNHdbi91qB6N
         EpqcWJ1vrX7uh/vyNKN7QDkVQPA0wZa+eBE6qcq+Hf4mlFMBHiZ3/ZkTE0lSnPisOf3K
         7Lb+1MtuB0T2+GE39s/G7FQn76stBXV9agtxSxkpw6ropC1Nzrr0cD/2uRb9kMHrGBVt
         8Gkw==
X-Gm-Message-State: ABuFfohMe3ZUdrp5953MHCxeaWXreAWk9z6/HLlxZIHmkgf28DYNnKAb
        bgqw9S27OLTZqZceBCalXORSLw==
X-Google-Smtp-Source: ACcGV63yYeJuidmH63czgnB0+bv01MSVrw030BquVl8L3phrN2qG9KZSQ2OuuJxigfIdtd7R6R2s9Q==
X-Received: by 2002:a17:902:784a:: with SMTP id e10-v6mr2955073pln.197.1537912253865;
        Tue, 25 Sep 2018 14:50:53 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v83-v6sm8986667pfa.103.2018.09.25.14.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:50:53 -0700 (PDT)
Date:   Tue, 25 Sep 2018 14:50:52 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
cc:     Michal Hocko <mhocko@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [patch v3] mm, thp: always specify disabled vmas as nh in smaps
In-Reply-To: <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1809251449060.96762@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com> <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz> <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com> <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com>
 <20180924195603.GJ18685@dhcp22.suse.cz> <20180924200258.GK18685@dhcp22.suse.cz> <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz> <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
introduced a regression in that userspace cannot always determine the set
of vmas where thp is disabled.

Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
to determine if a vma has been disabled from being backed by hugepages.

Previous to this commit, prctl(PR_SET_THP_DISABLE, 1) would cause thp to
be disabled and emit "nh" as a flag for the corresponding vmas as part of
/proc/pid/smaps.  After the commit, thp is disabled by means of an mm
flag and "nh" is not emitted.

This causes smaps parsing libraries to assume a vma is enabled for thp
and ends up puzzling the user on why its memory is not backed by thp.

This also clears the "hg" flag to make the behavior of MADV_HUGEPAGE and
PR_SET_THP_DISABLE definitive.

Fixes: 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
Signed-off-by: David Rientjes <rientjes@google.com>
---
 v3:
  - reword Documentation/filesystems/proc.txt for eligibility

 v2:
  - clear VM_HUGEPAGE per Vlastimil
  - update Documentation/filesystems/proc.txt to be explicit

 Documentation/filesystems/proc.txt |  7 ++++++-
 fs/proc/task_mmu.c                 | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -491,9 +491,14 @@ manner. The codes are the following:
     sd  - soft-dirty flag
     mm  - mixed map area
     hg  - huge page advise flag
-    nh  - no-huge page advise flag
+    nh  - no-huge page advise flag [*]
     mg  - mergable advise flag
 
+ [*] A process mapping may be advised to not be backed by transparent hugepages
+     by either madvise(MADV_NOHUGEPAGE) or prctl(PR_SET_THP_DISABLE).  See
+     Documentation/admin-guide/mm/transhuge.rst for system-wide and process
+     mapping policies.
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
