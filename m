Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4125545-1527268962-2-7168647064281183229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527268962; b=I6ZGolplqdpe51xDKtpP453drWev6DaqW+wegbwbhGDG4y1LTg
    3WJKtOhOxC1ylb4azE2ru+1i1r0T6WsMDBAGqrBPUMVRIn8T1XeHpmFZo22e4LZU
    YxbFGY0WLLKkk6F7PM/FthNd66PiHKIeUsvDiEMW205s231ssr2oraeHrcQ8Mb+Z
    jF5WxhgZNAxcOFp3Wb3anQz5wwBKbvpFDKsO28UCNvhM0wNTmPdwNCjS9bu8WGCe
    5Wn2ZVSs4QVbihJyFV3P0ICUMMAMQ3p9bKx4l9A20/ZlyhEUozugiv1MzzIshCU9
    OC7hIiB4A+enEMvBdVVC41RJ7FsYsj8TdWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527268962; bh=
    YXxWZgVh8zaQtkU8P5mQzC6eH8eF/xYQbKyFFaBS3Nk=; b=JSsXZTfN9o5T3BBQ
    MrOYBoH7pajejIUYRDVwpGfTMwUzObcjer1ZNbv5Y4AnwQbEAff0qbU3oma3GSnj
    loGbdR2utnR+33cC30u6L1OXwrCHhIX7LbSDbHkXZN+LzuTiE4EFNiVapA/0DIrB
    jKaH4AkU9fI05g5m4ZeaRQfq4Zsv8/iUXLqRI8sUVoWMWkColT3RyIAqxrj+kmWF
    yrTlNJVhQ3i8wCqHb1jjHnFuT/rb2DE3aBQwCpKq6XsTaslKfpzSil7gl2vKBwgZ
    ZmoEMbaHKAbwFmf1cbSBdP6Or2Tq1gpF9xfA7pBrVZbngQeYp1nWZQ3f6i0Nzp3M
    3epzQQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=ttISb9pd x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=XThg3bj7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=ttISb9pd x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=XThg3bj7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPt/mh5XAc9Nksz8L4WU/EQDKGV7HYHc2sV3Q8SnAEtoHQUYpbP9wxaWLSDtpHGsbqWqsjN77XWFgZkL3yJOIgH8l9tBs4WdwHL/Sk9k7ZwISXPsA97q
    wgfdAZrJLZqvjiB7CFOxSHqgMCWt1NBTrecsw3PbiVQnlBFOnazxq7paJJQ101vhQxh2cm9Sa7hu5po5yZiQwvrEaHLUZirMOvgchifpXJFQ+ebgRdKAIiZb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=JALRGD3KuZhRdXIbfCoA:9 a=yyyNe-CYjq54iSaL:21
    a=Q89g2xQBzLwBnR67:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967313AbeEYRWi (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 13:22:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40069 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967587AbeEYRV0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2018 13:21:26 -0400
X-Google-Smtp-Source: AB8JxZp72c6olAyJjMAimxTMq7cygCQpU+tH7cnQx0FDnINms6YsgY0q/YsR24HRDkjF6GQwOup/ew==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v3 4/6] mm, arm64: untag user addresses in mm/gup.c
Date: Fri, 25 May 2018 19:21:14 +0200
Message-Id: <858608ce6ace4ebd71c0318d3d536e9d1918b613.1527268727.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <cover.1527268727.git.andreyknvl@google.com>
References: <cover.1527268727.git.andreyknvl@google.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Here we also need to handle the case of tagged user
pointers.

Add untagging to gup.c functions that use user pointers for vma lookup.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 541904a7c60f..5d0e9715bab7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -650,6 +650,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -804,6 +806,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.17.0.921.gf22659ad46-goog
