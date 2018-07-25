Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2ACC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5B520852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="qMJsK+nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5B520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeGZBNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:13:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42552 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbeGZBNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:13:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so3951237plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uFyUSqGZcwUpvs/8kOWqA1xeN7gtaJ5Do2y1aq/Opn0=;
        b=qMJsK+nbeiwj3QxjU0RFGknPmtGyvXTJg274hVG1APprnfzdkWAz78Q8181S3Lb07+
         6P8wW2uhErXsPU0V5z2puQyAzRJVxgw3GdtpFTN2hA5SbgC9rDJ1AGR7ksWyz+eTC0Se
         5UdYr0aFoDYt+XxYYqwZSh8/TFUQqOnFCgRdXJ7/ZvOTLw7D8b02SvBI7OlCpS5qXnjB
         dD1ZbfWb9ih8/F2siqgekm+cRRgcWwgGnOR7SSWNP1AE76q5+0c6/Ciexlst9/v1WnBc
         j4AADh2ysFMKjRBqpVLdRDMENC4WQhd+ToOmkX/yaie9JRmlWi3tMvRstaJqtv/cfLz7
         D76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uFyUSqGZcwUpvs/8kOWqA1xeN7gtaJ5Do2y1aq/Opn0=;
        b=AXK29br6+4IgYKBSxPfEzHPowlZQ05Y9n4gHOAnvIlG2v1A2T84WoZcQ10ks6ELX26
         Zsw/S7lu/6W+hafH/j5t2ri65VgAh62DkgU9CWBorfq+d8EgDsoUrXW7fU7/cHlA7Xq7
         HOFwpeS243/SwNKUuyMgBCmuwfxkeoS+t4ZsZ5/++wUPw60wXQHyy/jXBNB7YSx3PnLW
         A8J+Q6329n8mKHIVXTdYXBxX0kvK050L/JZMGVbG3NoeUPTbpX3xKdh1i9YolbnMe0t2
         6ZKerHvy+ljO4rV5FWwNnPr8dItTc4xXQIVh/Ro/InjB65t78WRuJOEheTqZsrCU9NwV
         ZyqQ==
X-Gm-Message-State: AOUpUlHx6jstJy9DK89bcZcJ71Zx3JP6FeCeXbJe41tZTqVzUyxMcfG0
        kitXdPfwn38ILiAarjUFdX3lSgI2LUk=
X-Google-Smtp-Source: AAOMgpfUVbLhe2D3DOr0xi0xnNoeC8Pj2sFhNWZYRHSG2OzwyRqbIujvX7WGWYrAM0yqBxQp1m3TFQ==
X-Received: by 2002:a17:902:e005:: with SMTP id ca5-v6mr22929578plb.224.1532563168526;
        Wed, 25 Jul 2018 16:59:28 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id 65-v6sm23188753pfq.81.2018.07.25.16.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 16:59:28 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v4 1/9] proc/kcore: don't grab lock for kclist_add()
Date:   Wed, 25 Jul 2018 16:59:12 -0700
Message-Id: <12f4b3dc5254547d12cb6669c45c533e647511fb.1532563124.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532563124.git.osandov@fb.com>
References: <cover.1532563124.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

kclist_add() is only called at init time, so there's no point in
grabbing any locks. We're also going to replace the rwlock with a rwsem,
which we don't want to try grabbing during early boot.

While we're here, mark kclist_add() with __init so that we'll get a
warning if it's called from non-init code.

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c       | 7 +++----
 include/linux/kcore.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 66c373230e60..b0b9a76f28d6 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -62,16 +62,15 @@ static LIST_HEAD(kclist_head);
 static DEFINE_RWLOCK(kclist_lock);
 static int kcore_need_update = 1;
 
-void
-kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
+/* This doesn't grab kclist_lock, so it should only be used at init time. */
+void __init kclist_add(struct kcore_list *new, void *addr, size_t size,
+		       int type)
 {
 	new->addr = (unsigned long)addr;
 	new->size = size;
 	new->type = type;
 
-	write_lock(&kclist_lock);
 	list_add_tail(&new->list, &kclist_head);
-	write_unlock(&kclist_lock);
 }
 
 static size_t get_kcore_size(int *nphdr, size_t *elf_buflen)
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 8de55e4b5ee9..c20f296438fb 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -35,7 +35,7 @@ struct vmcoredd_node {
 };
 
 #ifdef CONFIG_PROC_KCORE
-extern void kclist_add(struct kcore_list *, void *, size_t, int type);
+void __init kclist_add(struct kcore_list *, void *, size_t, int type);
 #else
 static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
-- 
2.18.0

