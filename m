Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA5620833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="H8lv7CQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA5620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeGZBNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:13:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36739 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbeGZBNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:13:34 -0400
Received: by mail-pl0-f67.google.com with SMTP id e11-v6so3951433plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=16w7KIxIKq7DVWU2jRPaeALdZ2xcgpzjcsj3qPwpVus=;
        b=H8lv7CQz9Qhs+Me4ITN+H1NBrrZKWUlWKl8IttdoHw9pbcu7/y5Y/ecyBmvtF1RU8s
         LRZWVUWm+88wGlAeFjQnVeasM1NBRW2bkMkPjUCxEk93S95BeyBK3o7UsNdsrhgtnKVU
         ykexTEW1V95SqWAhpKw3QCL+xLTMvY54AYGy8GOwfMDoljdCb9ebAiK+FEi8dudZej9K
         SkQj3xNoOQLOP+llb6POAjraikm3LE7+9vySjfw4OYcSk34g1QgsIv0JFHHi6BnDYjC7
         q8I0aTPPnoIR8hmpjnWejZdupqx9TveBwRWWgjK8tTwzsp/gvF+16H66TVmuq9niJjGJ
         Oy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=16w7KIxIKq7DVWU2jRPaeALdZ2xcgpzjcsj3qPwpVus=;
        b=X1EtfkDhAYwA3UAgLyPnp8+n+EHlVwPcJUy6YiGGbuNm9F+Lr3pn1XByqSMjmQ3asQ
         V63rszrCnuXhMsxmHbzQo68fGAhKm9r28aqw2vtMAxcEqNNGZEAHyKuFjz3ANAo/0XWY
         o/e5+SxEc0I2kICrNptcol/79c+pAyl/ItaSDMctI8zP8nuWSpgwTnMUPwA+0k0iLvLW
         7ItXhgnFf9JKmG3wGp2sLlXpKOxx1SImZ4ESakaFJ9FpKzZrUZ/RQ9IggCehgoZt4vTC
         qqH3wW30QsVMzkmxVsNTsvgDAu65Dq16q7m4oGeZ51nbhD/Edd6lGy2KWWxUE/jKH89Q
         XWEQ==
X-Gm-Message-State: AOUpUlHM9ipppLb5+mdNc4mtPx2pFzPtELxEK0EtUyUhS7nbCFi6wpHV
        1UE4F0JzKKEWnmYvfAp0URjBtFgnYFc=
X-Google-Smtp-Source: AAOMgpeDLN3wf5IeEkZNAzQxRDoFvqbyq1IlL3cCULB9Bm6J8j0uDTc+1FjzIftvLJ3+G9QtTrn7+Q==
X-Received: by 2002:a17:902:7683:: with SMTP id m3-v6mr22545198pll.255.1532563169664;
        Wed, 25 Jul 2018 16:59:29 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id 65-v6sm23188753pfq.81.2018.07.25.16.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 16:59:29 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v4 2/9] proc/kcore: don't grab lock for memory hotplug notifier
Date:   Wed, 25 Jul 2018 16:59:13 -0700
Message-Id: <93fa8dc895f40f2b85d706779b3cd2902567ff7a.1532563124.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532563124.git.osandov@fb.com>
References: <cover.1532563124.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The memory hotplug notifier kcore_callback() only needs kclist_lock to
prevent races with __kcore_update_ram(), but we can easily eliminate
that race by using an atomic xchg() in __kcore_update_ram(). This is
preparation for converting kclist_lock to an rwsem.

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index b0b9a76f28d6..e83f15a4f66d 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -118,7 +118,7 @@ static void __kcore_update_ram(struct list_head *list)
 	LIST_HEAD(garbage);
 
 	write_lock(&kclist_lock);
-	if (kcore_need_update) {
+	if (xchg(&kcore_need_update, 0)) {
 		list_for_each_entry_safe(pos, tmp, &kclist_head, list) {
 			if (pos->type == KCORE_RAM
 				|| pos->type == KCORE_VMEMMAP)
@@ -127,7 +127,6 @@ static void __kcore_update_ram(struct list_head *list)
 		list_splice_tail(list, &kclist_head);
 	} else
 		list_splice(list, &garbage);
-	kcore_need_update = 0;
 	proc_root_kcore->size = get_kcore_size(&nphdr, &size);
 	write_unlock(&kclist_lock);
 
@@ -593,9 +592,8 @@ static int __meminit kcore_callback(struct notifier_block *self,
 	switch (action) {
 	case MEM_ONLINE:
 	case MEM_OFFLINE:
-		write_lock(&kclist_lock);
 		kcore_need_update = 1;
-		write_unlock(&kclist_lock);
+		break;
 	}
 	return NOTIFY_OK;
 }
-- 
2.18.0

