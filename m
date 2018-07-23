Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DE2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757F420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqsjbhGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757F420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbeGWDUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:20:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46376 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730798AbeGWDUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:20:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id p23-v6so11087387pgv.13;
        Sun, 22 Jul 2018 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u7xZlJQ5KP9xxRXKk73VOjCWYGFJfRdlavf4Ev+KEaI=;
        b=BqsjbhGqME3UjTlserDHUGUeNzsEZRFWgK6Q+CRfHwTKSqvv5ow7ItIez2O92t8M3j
         YtbmXmlE++BFFyyn58lggvWFAWombmuQTRRyekiT7vf+FBJ5LILPydVvmHO8U508vhuM
         IUuHl+rljojbO+3bbOG21lpCjMItIKKK84oDAVXx1QxE6M5DCIUGGKTUssQo2ielPykk
         YWYSS9UWN5LUyFj8//B5d/gW87Flt8f2T8NqqYrBVfwGKl+BNlbCGo6WKwK5GwAJEl6s
         RtSOqYgKcco3S5TfdYIStTeyXOMHb1l4Yx6CdoXg15pPmv45YRIDpRB6za4yGmdnzd0y
         PaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u7xZlJQ5KP9xxRXKk73VOjCWYGFJfRdlavf4Ev+KEaI=;
        b=uoIXeyQiC9WVvUK+bFuc/+k0Z/5u2j4FaPXBB7C7be57E8XBrgcwWyMlFQh83aa/1D
         XuCOFBs3JUU0c7Fer5AGiaP9Bv9mPEAyTQtFlem6itUEnBtLDt7o3lUMWGda2iwtaXiA
         AFVvlyIPQPXyIC8n2ESh9qM6dCHe8TJWxff9oRN+V/LXRLYqJcTcQVNxn5AAsxcb8qUS
         UXFj2xSp74LPh2eur49x6Eqpdet+1nKS6BGXndSPazyk2aRK0T+O+WPWpaOSgbeWGyEP
         bX/GpDDhsfY1LPN6uhLtpPl0gUZMrhnUaCHB2NxWwklwxKKpak5k8+UKTjX/p8XEh3CV
         KYVg==
X-Gm-Message-State: AOUpUlFnVFKdfNBpeDdy9T0z7ye1zz00v9ahEQjDJwau/lYHkQNmcwWa
        F5UNAm0emg+6ukFSpNDwOpU82Skh
X-Google-Smtp-Source: AAOMgpembL3h7T6gzYXbxfplvPJuz+fp4lp/pVtQFJDAFvP0bPeE4Bh9T1m9pLogdQcckn44Sri0Tw==
X-Received: by 2002:a65:5641:: with SMTP id m1-v6mr10725181pgs.246.1532312484522;
        Sun, 22 Jul 2018 19:21:24 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:c122:f95a:1d53:1f82])
        by smtp.gmail.com with ESMTPSA id n18-v6sm13783715pfa.50.2018.07.22.19.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 19:21:23 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] block: ioprio: Replace GFP_ATOMIC with GFP_KERNEL in set_task_ioprio()
Date:   Mon, 23 Jul 2018 10:21:16 +0800
Message-Id: <20180723022116.6919-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_task_ioprio() is only called by SYSCALL_DEFINE3(), ext4_fill_super(),
ext4_remount() and reada_start_machine_worker().
And these functions are not called in atomic context.

set_task_ioprio() calls get_task_io_context with GFP_ATOMIC, which is
unnecessary. GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 block/ioprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 6f5d0b6625e3..42d91ee7080f 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -51,7 +51,7 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 	if (err)
 		return err;
 
-	ioc = get_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
+	ioc = get_task_io_context(task, GFP_KERNEL, NUMA_NO_NODE);
 	if (ioc) {
 		ioc->ioprio = ioprio;
 		put_io_context(ioc);
-- 
2.17.0

