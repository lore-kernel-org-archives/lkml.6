Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2CDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4309206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/CD3JL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4309206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeIHDO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:14:56 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:41276 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIHDO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:14:56 -0400
Received: by mail-yw1-f73.google.com with SMTP id t9-v6so9547280ywg.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=swXSXNYo9e+z3a+rPUiAwcdafcZKfK0bN6Lk7+5yGJw=;
        b=U/CD3JL6Zyd36Lrae6fCr4FQoBxcg4RQYeE+xHs1CFPWsfOwUk5yguHe1uFw8Pxj4/
         R8wudA6o4rxvs8lIsrOVPVYyeDTxI0XkaJil/myjkCJUrdAbtCjH2CSPRyhwAqEApFHq
         1ENXmnseOAiAV4vhoovKNqC000On5wqxab0dkhTg3DS9C75arveA7hMdzHNcEkJ5mOH+
         YIDE35POoFnU+lXvqf6jmZF+4Zcoce+2mnRshNfWBxu8geew+UQS/CvZpPC64QKRb2WI
         zodHxf50txRN1YZ6YlMcM6OzP0CUyb6K8bLKY19YQYX8RvVa+pwo6PdjjuIggywIbtMB
         Xe9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=swXSXNYo9e+z3a+rPUiAwcdafcZKfK0bN6Lk7+5yGJw=;
        b=iGel/bSlXRDiDPVAtkFjs7h5FCXoAXugSfPwYfmTeDo19NGOr5K5qFtKBYIiunKZO/
         ckVQfhpDXwYpyg8OFtjA+J1kss9tW2Guuh0hMoCIa5hVJSe6YnCSJ4Kmehb/pf8C9Z+i
         O7Dka/P8QG0MQYyQbVG5bjgUdlTcyTxglhEx4fK6eMGSKZoKXK17Ldfo49bVFJPvXS8P
         SGGIeQvIx3X+mHx7ClGw9dgu3wMkjiullA3APJvs9vY3cO4cO8zbcBPEXYE+Gb5MrajD
         EqQqCGijuMfxhvYp1WY5OXp7I2X7wP34Knncr0lc2UcdggPxOnyz+qh2KW4b3a0tccrm
         cH5Q==
X-Gm-Message-State: APzg51D6E40BHgIZ17EPaV81c5rRJ+e5gNvNSIl1OBagHoPZhChFjz/T
        /4gPKqama/p+lDBVXnh/jNjgpVN7FFJkrUOt
X-Google-Smtp-Source: ANB0VdY4ojWG4KGvydw0XAN+lsIc753Zr6KKd05mP6t+1ueJuySmd+AVWZW6mxqmQbDZ64ijxiUrrr9V8IjbCYZ7
X-Received: by 2002:a0d:c8c5:: with SMTP id k188-v6mr2300708ywd.130.1536359508435;
 Fri, 07 Sep 2018 15:31:48 -0700 (PDT)
Date:   Fri,  7 Sep 2018 15:31:29 -0700
In-Reply-To: <20180907182131.144514-1-vnagarnaik@google.com>
Message-Id: <20180907223129.71994-1-vnagarnaik@google.com>
Mime-Version: 1.0
References: <20180907182131.144514-1-vnagarnaik@google.com>
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
the work is rescheduled. Call cond_resched() in the loop to prevent the
system hangup.

Reported-by: Jason Behmer <jbehmer@google.com>
Signed-off-by: Vaibhav Nagarnaik <vnagarnaik@google.com>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1d92d4a982fd..65bd4616220d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1546,6 +1546,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 	tmp_iter_page = first_page;
 
 	do {
+		cond_resched();
+
 		to_remove_page = tmp_iter_page;
 		rb_inc_page(cpu_buffer, &tmp_iter_page);
 
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

