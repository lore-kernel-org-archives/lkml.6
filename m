Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF26C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93C22075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UiTj6chj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93C22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIGXEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:04:10 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:43632 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeIGXEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:04:09 -0400
Received: by mail-qt0-f202.google.com with SMTP id 1-v6so14605843qtp.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a/WuAayfLf1w7oRq9kf7B6s9CIycYtQj6wta6Tw3YO4=;
        b=UiTj6chj8FhZTBpfKExQf2OLA0sQwnb3PGPkBMCisBNujcsJs4DoxsUR+QV3WUhopP
         XJc0h7yfyCTHjipZEdEdDQDIM1pLT1HpJCy1hecg1id6RvwRga0Kyf/KR7kEa3HYe5wG
         ZnhQ8AI3hZpDUq/2s4cj7JR1qMQ4kKH5dNSF/zDjN7ARq/GzLxMRBbHPOgMXDAhKPfNV
         sSFdnxtXB+3/aJPIQZlJu3X2Dj01eW1TgYFe6gE/bFztET3eBHHG0s1muXVdzhGwQYsT
         BHHJSRKcGc/ANd4wm1o37KdCKt4GmkZ9ZOBHfyi3XjlBk0/UIg4lCzH72zh+UOOM7IpY
         MWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a/WuAayfLf1w7oRq9kf7B6s9CIycYtQj6wta6Tw3YO4=;
        b=kmIfdW4fKnQTuQTvp4/F8WKQbQ2y+SHY4HaWdkXz2B8T2IuE4n9H+Jf4KrXPt2bXhW
         +hoJMlNHfWj7a/pxK9vcxaBXmVL8V1/Xot5DOXYnG1h3HhTvCAvfM+6NgxK0RkiBQAoN
         5qi357ZrLU83knzELqFBetUPoZIUKmfRA5FIHr5se8qxPWkJNhzfMdv7J8SQnNJIT7N3
         RQoKBiGSg8MtOlZUgBgS2tNWkaDEA86fv27z7401O/wXiicS95e2ACc8yoY8sKLGrBX6
         cWnxfCk6oH1XYLGgsAmLnnCxa7PeIyatSeKUgtSmfOdIVrgqgOztBhqjx1IrBUqW5reM
         YU7Q==
X-Gm-Message-State: APzg51Aneck7hVCqlugR1mvuLBnofiATtoByheJr6qEvzv7+jXG3rirh
        /dAdaDtXVVUOpfgy3wgFaJbhjztLsCgspDBZ
X-Google-Smtp-Source: ANB0VdZugVIYKQWRtmsGZtivtLcR518XaA+i8CSHnNu62iLNzBU+hPVu3V1ripOxoC4EuK+BLyNhEJjXFPfAkOrb
X-Received: by 2002:a0c:9242:: with SMTP id 2-v6mr3025229qvz.12.1536344520555;
 Fri, 07 Sep 2018 11:22:00 -0700 (PDT)
Date:   Fri,  7 Sep 2018 11:21:31 -0700
Message-Id: <20180907182131.144514-1-vnagarnaik@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] ring-buffer: Allow for rescheduling when removing pages
From:   Vaibhav Nagarnaik <vnagarnaik@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Vaibhav Nagarnaik <vnagarnaik@google.com>, jbehmer@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reducing ring buffer size, pages are removed by scheduling a work
item on each CPU for the corresponding CPU ring buffer. After the pages
are removed from ring buffer linked list, the pages are free()d in a
tight loop. The loop does not give up CPU until all pages are removed.
In a worst case behavior, when lot of pages are to be freed, it can
cause system stall.

After the pages are removed from the list, the free() can happen while
the work is rescheduled. Add a check for need_sched() within the loop
to prevent the system hangup.

Reported-by: Jason Behmer <jbehmer@google.com>
Signed-off-by: Vaibhav Nagarnaik <vnagarnaik@google.com>
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1d92d4a982fd..bc1789df7c53 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1546,6 +1546,9 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 	tmp_iter_page = first_page;
 
 	do {
+		if (need_resched())
+			schedule();
+
 		to_remove_page = tmp_iter_page;
 		rb_inc_page(cpu_buffer, &tmp_iter_page);
 
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

