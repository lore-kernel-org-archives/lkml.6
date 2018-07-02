Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2273C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964B325167
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGNWLr9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964B325167
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeGBVzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:55:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46111 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeGBVzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:55:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so5040138pfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/eCyUzVEodDEJDj1KMPhPb1uhIgk/F30b0HI1HAROkg=;
        b=uGNWLr9gube3Yj7ltQ2/qTAbwQcDex9b88Z9EJ/J9rav/THRDbDmzZnj5BEIMwTPts
         UuitwjCH2cXHoVbN/Nl+Ygc4xMKj0KOKRbv9OGg1UhUM87JcLKH4sadmjWoVv4IpvfSI
         nffCq0X2+qwn9E4K3n0o/LDVbUCMIwFRZqeGvn3SrPIBWouQ1sURrVmc7btJZ6NIF7fE
         eBJRXOF/j4WDvxtD02Pxb9h2qlXBox40enNm9IarXa9Kv80M0LXMqm3C/VlanH+nL0Qs
         7J+YcRaHOWgkX5PPb1lUxl7WsqviQuY1VYRyQW50D+ByNTq8+syTX76KptPMW3sz2v/v
         Th7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/eCyUzVEodDEJDj1KMPhPb1uhIgk/F30b0HI1HAROkg=;
        b=UROCyTg4mxvssugSOxYeZ1KN5R701U2s8WDQDdDciNt3OpH7j+sH0jRIfluHuCx/QV
         UC6ryuQcUmjWQrlYB1Vzk3OiomWtyu00E+2gAsLzeVCsUQTtDDbMDypgVlRk8Fx1ngBU
         ymM26GyaWMSsbJ6uB71OryfZtWZDul+u+XzzPiB0hRCINCX8Cm01Xydit9jAhRkgmSW4
         yx6n0DtYNoU/HJ+jp18ByL0OhjNXfRUitkAvSaA+uZ+zgrP+M/HvVpavOzFf+iWe+qrO
         R1MGgJaN9CZYLzHjnYlqJhmzij638a7RvHboedFvKaDTDTnIIY683xiSlS9FdMtaZ35c
         RgMg==
X-Gm-Message-State: APt69E2DYOSUSNc/snc+EeT2LLGDRRUvPtm82JZE6N29/zs005qqu8Mw
        UtmdibVTDit4xRafHBs3BFf+0/mgL14=
X-Google-Smtp-Source: AAOMgpdIiH2m3NRo5hW5XQYly2dDF6q51i7PwRwru+MnSGZG7g4IXfWp8CaDS5vi6eyPrBQMfNGjrA==
X-Received: by 2002:a63:c20:: with SMTP id b32-v6mr4351698pgl.400.1530568499617;
        Mon, 02 Jul 2018 14:54:59 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id t78-v6sm10528386pfa.160.2018.07.02.14.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:54:58 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] fs-fsnotify-account-fsnotify-metadata-to-kmemcg.patch.cleanup
Date:   Mon,  2 Jul 2018 14:54:39 -0700
Message-Id: <20180702215439.211597-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180627191250.209150-2-shakeelb@google.com>
References: <20180627191250.209150-2-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andres, this is a small cleanup to the patch "fs: fsnotify: account
fsnotify metadata to kmemcg". Please squash.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/notify/fanotify/fanotify.c        | 2 +-
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6ff1f75d156d..eb4e75175cfb 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -142,7 +142,7 @@ struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
 						 const struct path *path)
 {
 	struct fanotify_event_info *event = NULL;
-	gfp_t gfp = GFP_KERNEL | __GFP_ACCOUNT;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 52e167d04b11..f4184b4f3815 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -101,7 +101,7 @@ int inotify_handle_event(struct fsnotify_group *group,
 
 	/* Whoever is interested in the event, pays for the allocation. */
 	memalloc_use_memcg(group->memcg);
-	event = kmalloc(alloc_len, GFP_KERNEL | __GFP_ACCOUNT);
+	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT);
 	memalloc_unuse_memcg();
 
 	if (unlikely(!event)) {
-- 
2.18.0.399.gad0ab374a1-goog

