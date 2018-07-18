Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761FDECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215722075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="cF0Z4Cx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215722075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeGRXjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:39:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41010 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbeGRXjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:39:21 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so2684278ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OwRfXeF6NHIzrPioZ/8+JLBpzHWc2t/vrZ/aQ57UqDg=;
        b=cF0Z4Cx3o1pCQgXtmovhU7GvX2yWA2470gy8ygcUifBPiMV49ps2S/3XwQK36MEvJW
         ioSwSl3mwSHd1s99wPwODReKgJ54EoLrbOteUKA8jmtFgkuwJofr+syvG2TtNYc7nLO9
         OVl0lzHIrOnwn6vikXOl3cUhAPSuVBLyL0OeKCRCH+6FKZMFWeZTWxDZO2iLufo7VKSL
         NkqEc16S6JR4Oa+0hQLoqq2zFjrvY47J0aH+DQvx0AMhkbp6j9j82wnsOcl+9TtazkjV
         xjSElo5ezFmZdJBgGNqKvQhCigNa6KuN7zYtCEHxNZkgIIGb2GU9vqmc2sDFSUYd8diF
         e+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OwRfXeF6NHIzrPioZ/8+JLBpzHWc2t/vrZ/aQ57UqDg=;
        b=gxotVikXdl+MmIvW/DOt1gUiuZ0ER2km/RcVBpMflFx9mW8GMp6OwNuLRFt/6okFHD
         peMWmERcvssi7ITJon3URYyq1iV9nmVAWywiOwSN23YF5AJ5zO8hfZzUqYuTHpdF4m+6
         MTD5wE0J7kXszWoGqr1gu7moTkWOchSGN8kxZA0hcFx6LL0nNK83DxjWhit0kk3OXl40
         P4pGUa1kCcu8K5k26Q6FuST6ezOzqBYal7E24kMTuaO0oaDpqErAj0RI1vi6lMyApv7/
         oS8fVxC0PNKbwgC7P+TBdPSyC2ROdyfI4Xqp4WSgYzUdrDMzxhCeuOYP98aot69Uf3m1
         4tNg==
X-Gm-Message-State: AOUpUlE/vLVkY5KM3CvAreGp5RXiMmDbL3ZCH7/o93cvizaXRR79pdLx
        2LK1gnY3ZJSMDh9rQdV5bk4ppaL3E48=
X-Google-Smtp-Source: AAOMgpeYVGw86XzdZa5L442PRAu081YO9Wzf6lGPvdlkVE2ffqFRj1adxaKZWsCr4wMe1FO4P+jjVg==
X-Received: by 2002:a17:902:262:: with SMTP id 89-v6mr7643504plc.221.1531954754505;
        Wed, 18 Jul 2018 15:59:14 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8800:a9a9:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s16-v6sm6377946pfm.114.2018.07.18.15.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:59:14 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v3 1/8] proc/kcore: don't grab lock for kclist_add()
Date:   Wed, 18 Jul 2018 15:58:41 -0700
Message-Id: <98208db1faf167aa8b08eebfa968d95c70527739.1531953780.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531953780.git.osandov@fb.com>
References: <cover.1531953780.git.osandov@fb.com>
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

