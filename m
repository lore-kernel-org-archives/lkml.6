Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CEFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E3020893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E3020893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbeG3NfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:35:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47483 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeG3NfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:35:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UBwPTb2294537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 04:58:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UBwP8o2294534;
        Mon, 30 Jul 2018 04:58:25 -0700
Date:   Mon, 30 Jul 2018 04:58:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-0e664eee65337082be49fbbd2ee24aa0d111d0f2@git.kernel.org>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, dhgutteridge@sympatico.ca, luto@kernel.org,
        David.Laight@aculab.com, peterz@infradead.org, namhyung@kernel.org,
        mingo@kernel.org, jroedel@suse.de, jolsa@redhat.com,
        dvlasenk@redhat.com, brgerst@gmail.com, eduval@amazon.com,
        boris.ostrovsky@oracle.com, alexander.shishkin@linux.intel.com,
        llong@redhat.com, torvalds@linux-foundation.org, pavel@ucw.cz,
        tglx@linutronix.de, gregkh@linuxfoundation.org, jgross@suse.com,
        jkosina@suse.cz, jpoimboe@redhat.com, hpa@zytor.com,
        will.deacon@arm.com, bp@alien8.de, acme@kernel.org
Reply-To: brgerst@gmail.com, eduval@amazon.com, boris.ostrovsky@oracle.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          jroedel@suse.de, jolsa@redhat.com, dvlasenk@redhat.com,
          dhgutteridge@sympatico.ca, luto@kernel.org, peterz@infradead.org,
          David.Laight@aculab.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, dave.hansen@intel.com,
          aarcange@redhat.com, will.deacon@arm.com, bp@alien8.de,
          acme@kernel.org, tglx@linutronix.de, jkosina@suse.cz,
          jgross@suse.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com,
          hpa@zytor.com, pavel@ucw.cz, llong@redhat.com,
          torvalds@linux-foundation.org
In-Reply-To: <1532533683-5988-3-git-send-email-joro@8bytes.org>
References: <1532533683-5988-3-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] Revert "perf/core: Make sure the ring-buffer is
 mapped in all page-tables"
Git-Commit-ID: 0e664eee65337082be49fbbd2ee24aa0d111d0f2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0e664eee65337082be49fbbd2ee24aa0d111d0f2
Gitweb:     https://git.kernel.org/tip/0e664eee65337082be49fbbd2ee24aa0d111d0f2
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 25 Jul 2018 17:48:02 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 13:53:48 +0200

Revert "perf/core: Make sure the ring-buffer is mapped in all page-tables"

This reverts commit 77754cfa09a6c528c38cbca9ee4cc4f7cf6ad6f2.

The patch was necessary to silence a WARN_ON_ONCE(in_nmi())
that triggered in the vmalloc_fault() function when PTI was
enabled on x86-32.

Faulting in an NMI handler turned out to be safe and the
warning in vmalloc_fault() is gone now. So the above patch
can be reverted.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: David H. Gutteridge <dhgutteridge@sympatico.ca>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1532533683-5988-3-git-send-email-joro@8bytes.org

---
 kernel/events/ring_buffer.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index df2d8cf0072c..5d3cf407e374 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -814,13 +814,6 @@ static void rb_free_work(struct work_struct *work)
 
 	vfree(base);
 	kfree(rb);
-
-	/*
-	 * FIXME: PAE workaround for vmalloc_fault(): Make sure buffer is
-	 * unmapped in all page-tables.
-	 */
-	if (IS_ENABLED(CONFIG_X86_PAE))
-		vmalloc_sync_all();
 }
 
 void rb_free(struct ring_buffer *rb)
@@ -847,15 +840,6 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	if (!all_buf)
 		goto fail_all_buf;
 
-	/*
-	 * FIXME: PAE workaround for vmalloc_fault(): The buffer is
-	 * accessed in NMI handlers, make sure it is mapped in all
-	 * page-tables in the system so that we don't fault on the range in
-	 * an NMI handler.
-	 */
-	if (IS_ENABLED(CONFIG_X86_PAE))
-		vmalloc_sync_all();
-
 	rb->user_page = all_buf;
 	rb->data_pages[0] = all_buf + PAGE_SIZE;
 	if (nr_pages) {
