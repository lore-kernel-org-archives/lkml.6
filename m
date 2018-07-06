Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5E5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D87223B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="tgBkn+zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D87223B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934868AbeGFTeL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:34:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40541 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934718AbeGFTcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:32:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so9189019pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uFlzTZ0zFM/O1ySzVbJUUjy3l6Fednek6oq+KppzKd0=;
        b=tgBkn+zlhOrPbUe0CtZnHPqgnbz2naE+0YiHNlqSIvW48ZsMyUciYERN9wwlFy4Zwv
         bm8bc2/FZF+1OJBStOzj6A74kqijWPDfqLQspQnsHRVzPRRcuyl8QYygF5GqjAsykjjs
         3+zk8KZs32D6Vd/9H+AcYhTn/vTHVnXoUPtyH80ayfi96HhHbLnlGJGdJF0UK6M1vyZE
         sofqjsRdM4K0u88pBp3KFBR4d5j2BfM674VsjkdqHq/NCWJVjjxG0hD5TVXDfYWjrGjL
         oc2/mzNI/IliGcHGyP29joOcFDx5afy0UDSpSPkBvFyB5I2uybIOeyMag1+Raxy2SjI0
         ZQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uFlzTZ0zFM/O1ySzVbJUUjy3l6Fednek6oq+KppzKd0=;
        b=SbJk8SKHuM/Nvjy0+vv043OmoL3WHW50spvS+k3ED7SxKES1oy1RpbYTJXjz2eQJyS
         5UHE3AKHkp61E/KbXGkFSyYiP6V2xUY/M8VhgNseGGrxSnC26WtDz1vbpxu4V97/Gmyb
         A4gcivimhC5YMETDf3/qPbFLoxg99NEWo3eoGYZDsKq3BlWIweZYgQ8RSGv56gxlCcjF
         V9LQfUkDhDY8a1Ws+d6XOst975S0LI5KI4YrgFIsVfT8HqNXbcCiD66TU9BBsXgA/tZ9
         X0ofOX0VqnZg27FwwD4YoarsOolUGNwKrST1cnIzp9c2in8eZ6KH7hqUlEEFrOVoyR2/
         0f2Q==
X-Gm-Message-State: APt69E1U1HiwlltLz7GHKM+Ny/HNpz1bxYSogbEgzy5a0tWv7k8Jwh8J
        drv6WN7uEz2+BTU/7bkynNoBRDWuqpU=
X-Google-Smtp-Source: AAOMgpfdcu0f/rSulQtKh1hBAPy8Y2qbiXPB95yCQD9ir1ZFwUwJhattho/umjC0ksfJ0o9nb0I+pQ==
X-Received: by 2002:a65:6210:: with SMTP id d16-v6mr10250232pgv.272.1530905566337;
        Fri, 06 Jul 2018 12:32:46 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::4:984e])
        by smtp.gmail.com with ESMTPSA id a11-v6sm12846162pgq.32.2018.07.06.12.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 12:32:45 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kernel-team@fb.com
Subject: [PATCH 1/7] proc/kcore: don't grab lock for kclist_add()
Date:   Fri,  6 Jul 2018 12:32:32 -0700
Message-Id: <a02eecc5a0ab14e5a65407472f827abfc6554e03.1530904769.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530904769.git.osandov@fb.com>
References: <cover.1530904769.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

kclist_add() is only called at init time, so there's no point in
grabbing any locks. We're also going to replace the rwlock with a rwsem,
which we don't want to try grabbing during early boot.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index e64ecb9f2720..afd1ff8c2d3f 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -62,6 +62,7 @@ static LIST_HEAD(kclist_head);
 static DEFINE_RWLOCK(kclist_lock);
 static int kcore_need_update = 1;
 
+/* This doesn't grab kclist_lock, so it should only be used at init time. */
 void
 kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 {
@@ -69,9 +70,7 @@ kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 	new->size = size;
 	new->type = type;
 
-	write_lock(&kclist_lock);
 	list_add_tail(&new->list, &kclist_head);
-	write_unlock(&kclist_lock);
 }
 
 static size_t get_kcore_size(int *nphdr, size_t *elf_buflen)
-- 
2.18.0

