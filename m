Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD51C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A8520693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJUMC71V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A8520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeFUDc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:32:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40536 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbeFUDcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:32:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id w8-v6so740983pgp.7;
        Wed, 20 Jun 2018 20:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VTMjmXWbd8FJYzPPYIiiGX92oEn31IRxL3XHJIyvM28=;
        b=IJUMC71V47oeq67T7EuHJmGJagX8h6koDAhL3cQFO8FTZ5CfDUgXqN0RXFP8gvhLlG
         e9fHAyJWUiC1rt/Jwsq5yOvjlSrK6+4SGiHGo+cJQpVrW4rb7uYIj5SmdppoYItIrOu/
         vONolksA12tx6I56IgL21raJbimzcUcqVEr1e29tRMwkZzg/p8CoUtnjllTkyc2/r/uk
         G0Ed7ofWsAv9M+KcFJri/ovOxTifLzCyMfrKWSS5PTnKDhWSKXK0yQcHgyJ9nCafJkqw
         JdD2Bjca3d1HHRU2/Ur6st8uDyMmKCE+R99nv9DvB6lXX7myRg7RdRm1FiyVs6LZOYc6
         DKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VTMjmXWbd8FJYzPPYIiiGX92oEn31IRxL3XHJIyvM28=;
        b=Li+No2iI2YFPc0WFiNVobw0DOfiyX7E1YAxDD4MKKn1+0faLjaquCd4VVI4JB2QaPp
         cuAbVBsI5jP7zW9SOFCmPqI7SZpNLVzzXhO97168XzGLN523ZgoWh0Dzgr+JIC02y+ir
         amr/+WIqbRBTuYjjsNsOUUqlvxmgEAtGnfNHp1/XUK5mJhEHLI1ufU2Rlx+W/g1+FC41
         g/ul32IjjrHYB78+7QxpC3m9NH9c+0mS+FFXzrx+ubFpO3PRfEbF6BecSl7ve3+uwXN9
         vFC7t2S/4EArXlloJi1BVKxdDf3xnXpUD0fW0I0+8/J7tK9rZW7fZIW6V9AJ53oXhDps
         sE+A==
X-Gm-Message-State: APt69E2mDr2qhkjSMVnStd67ALq2qYdhr3g5/cUAnIYJ+rhCDGeP6ATh
        kvkpl8cR9gisuN9Q4hZv1DU=
X-Google-Smtp-Source: ADUXVKKPwyG1yKlpp6mlX4rl6haLTMCd9NLDvWF6Go/mllIo7D246jJy6mT3H4/K2xGWmAaLCzsQ3w==
X-Received: by 2002:a62:3f4f:: with SMTP id m76-v6mr25593201pfa.109.1529551974002;
        Wed, 20 Jun 2018 20:32:54 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:1:4413:35c0:9e91:c7fc:672])
        by smtp.gmail.com with ESMTPSA id s68-v6sm8642335pfi.85.2018.06.20.20.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 20:32:53 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com, jack@suse.cz,
        amir73il@gmail.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] kernel: audit_tree: Fix a sleep-in-atomic-context bug
Date:   Thu, 21 Jun 2018 11:32:45 +0800
Message-Id: <20180621033245.10754-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.16.7 are:

[FUNC] kmem_cache_alloc(GFP_KERNEL)
fs/notify/mark.c, 439: 
		kmem_cache_alloc in fsnotify_attach_connector_to_object
fs/notify/mark.c, 520: 
		fsnotify_attach_connector_to_object in fsnotify_add_mark_list
fs/notify/mark.c, 590: 
		fsnotify_add_mark_list in fsnotify_add_mark_locked
kernel/audit_tree.c, 437: 
		fsnotify_add_mark_locked in tag_chunk
kernel/audit_tree.c, 423: 
		spin_lock in tag_chunk

[FUNC] kmem_cache_alloc(GFP_KERNEL)
fs/notify/mark.c, 439: 
		kmem_cache_alloc in fsnotify_attach_connector_to_object
fs/notify/mark.c, 520: 
		fsnotify_attach_connector_to_object in fsnotify_add_mark_list
fs/notify/mark.c, 590: 
		fsnotify_add_mark_list in fsnotify_add_mark_locked
kernel/audit_tree.c, 291: 
		fsnotify_add_mark_locked in untag_chunk
kernel/audit_tree.c, 258: 
		spin_lock in untag_chunk

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool (DSAC-2) and checked by my
code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/notify/mark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index e9191b416434..c664853b8585 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -436,7 +436,7 @@ static int fsnotify_attach_connector_to_object(
 {
 	struct fsnotify_mark_connector *conn;
 
-	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
+	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_ATOMIC);
 	if (!conn)
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
-- 
2.17.0

