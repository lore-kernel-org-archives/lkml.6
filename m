Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1595FC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B682221ADE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9p5Q/hK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B682221ADE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbeHIAzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:55:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45198 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbeHIAzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:55:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so1731738pgq.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FaqBxE9vdVdgvDb/KJqUSVRZ6PmE81yE4JWG9JL0RMk=;
        b=r9p5Q/hK/MgKq9Bv776i9oXsHg61ho12yaq1QOM7I6RVGu7sZhosuCASsIkKOwSgl7
         +BDEQFY/y4NL3xmO+qiEnZU3sKMdd3cgWMRSeJPhYHJac4njptqMVfdKr/Jljvsn+Tuv
         iuV+m5VWzMoa5AR+GKMPllQC558DnhIR24HfBkJoRBUAodk/JwquJUIvXMa2rLqGNX5G
         EPPcAODfluIaL4eaGARZaWTNGS3m2uv2ncZeNmDIJQFOUWvidtRqnsmkYqijbRq4BrO3
         TUXuBhWQs3/vsix4DDIS+o/SRAqmEM9y9NinLwQGpcWA3v2BgCl9oOsq2ZJZANUhlngw
         VBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FaqBxE9vdVdgvDb/KJqUSVRZ6PmE81yE4JWG9JL0RMk=;
        b=Zrp1kjeX+Ynk2kOYBLfcKhvXRmgVmz8OoShZuk03z+SHh7wDY/f1IZVzDFaaNgZ+sY
         fLU0LPGgBxi70AhWdesRHy51OAcrHi1EcU9w9jp7IO4nkF+m+4Ys955ZPj3KG0qVU6qF
         RAQzxybR2nb8RrUHnN9SMn/KlKlqKJKg3Dg9SbRjmzYWROuPL1m2SFZFi0172JhdLDPC
         gMsoxlg4ABSFlX4mNR1NsSe56WT7QkHS9W/Zx4uGni5Ia4sA6AodfhONHl9PQGxJCfnI
         jUI48CVpXt9KOp/GG5ZEmL0ZvFB6YZrEJL+lpm/O9VozaxaX5ql8sa/v43l3qTenWxtb
         BkYg==
X-Gm-Message-State: AOUpUlHHVyGtQZyT7IEk5wcWBDYTAt8meGT336IXu7IeqcNEcwATFEkv
        Bb9XFNTdvaUOjlTHX9lfOtEk5ikRM3Q=
X-Google-Smtp-Source: AA+uWPzqUxO0TtuK46AxrF9dho78W8PSEv4IiiAnBZ2oql5xt10F+MFvYxbYMhhCRS4iyqnxX+XHJQ==
X-Received: by 2002:a62:45d2:: with SMTP id n79-v6mr4820002pfi.137.1533767609199;
        Wed, 08 Aug 2018 15:33:29 -0700 (PDT)
Received: from localhost (c-67-169-55-77.hsd1.ca.comcast.net. [67.169.55.77])
        by smtp.gmail.com with ESMTPSA id d132-v6sm6430733pgc.93.2018.08.08.15.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 15:33:28 -0700 (PDT)
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, peterz@infradead.org, mingo@elte.hu,
        jolsa@redhat.com
Subject: [PATCH v2] perf ordered_events: fix crash in free_dup_event()
Date:   Wed,  8 Aug 2018 15:33:20 -0700
Message-Id: <1533767600-7794-1-git-send-email-eranian@google.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in ordered_event.c:alloc_event().
An ordered_event struct was not initialized properly potentially
causing crashes later on in free_dup_event() depending on the
content of the memory. If it was NULL, then it would work fine,
otherwise, it could cause crashes such as:

$ perf record -o - -e cycles date |  perf inject -b -i - >/dev/null
Tue Aug  7 12:03:48 PDT 2018
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.000 MB - ]
Segmentation fault (core dumped):

(gdb) r inject -b -i - < tt  >/dev/null
Program received signal SIGSEGV, Segmentation fault.
free_dup_event (oe=0x26a39a0, event=0xffffffff00000000) at util/ordered-events.c:85
(gdb) bt
#0  free_dup_event (oe=0x26a39a0, event=0xffffffff00000000) at util/ordered-events.c:85
#1  ordered_events__free (oe=0x26a39a0) at util/ordered-events.c:310
#2  0x00000000004b5a56 in __perf_session__process_pipe_events (session=<optimized out>) at util/session.c:1753
#3  perf_session__process_events (session=<optimized out>) at util/session.c:1932
#4  0x000000000043a2eb in __cmd_inject (inject=<optimized out>) at builtin-inject.c:750
#5  cmd_inject (argc=<optimized out>, argv=<optimized out>) at builtin-inject.c:924
#6  0x000000000046b175 in run_builtin (p=0xabc640 <commands+576>, argc=4, argv=0x7fffffffe560) at perf.c:297
#7  0x000000000046b062 in handle_internal_command (argc=4, argv=0x7fffffffe560) at perf.c:349
#8  0x000000000046a5e8 in run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:393
#9  main (argc=4, argv=0x7fffffffe560) at perf.c:531

Signed-off-by: Stephane Eranian <eranian@google.com>

---
 tools/perf/util/ordered-events.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index a90dbe5df019..95c91e5a3754 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -118,6 +118,12 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 
 		pr("alloc size %" PRIu64 "B (+%zu), max %" PRIu64 "B\n",
 		   oe->cur_alloc_size, size, oe->max_alloc_size);
+		/*
+		 * must initialize event pointer of commandeered first
+		 * entry to avoid crash in free_dup_event() due to random
+		 * value for this field.
+		 */
+		oe->buffer->event = NULL;
 
 		oe->cur_alloc_size += size;
 		list_add(&oe->buffer->list, &oe->to_free);
-- 
2.18.0.597.ga71716f1ad-goog
