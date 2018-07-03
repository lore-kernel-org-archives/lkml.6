Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A39C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEB721A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="rrJkMw9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEB721A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933810AbeGCPTm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:19:42 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35565 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933954AbeGCPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:15:10 -0400
Received: by mail-qt0-f196.google.com with SMTP id z6-v6so1874910qti.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkdJSYLh9LN7Ss8j0Rn9mX3g9Rqhn9vecXPFB0z5w9o=;
        b=rrJkMw9td3K4lUzUDyX2Al0CdqoicFVk+1YE+PqsAkvDgs5eN40uLaF7U9xzx0/Hql
         WtfifV7wvs6WKR2wFcjO+XbMdo2NDSqi9eCLZrI3ZvoAHzhqLuogxL02+x+NPm2uNgFC
         GoHnSuQ3D5hx5h9Pls5eAfYIwzdlv7l5cWX4WQGxri3/YPsYH6oYYhKBLubVO43BYkUZ
         mzB+A46Di5VPYe9wcveeVoz+q/9WSBbRNAwfg/o+ftXc85VHd8wMrYs5HbIlcZelMljh
         JimjPvW5cth+MGoOlVcD8r/+oe4WLm0bE0/cqcnS4QYRhacZDw3O2oNEm3Jv413ewNPw
         e83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gkdJSYLh9LN7Ss8j0Rn9mX3g9Rqhn9vecXPFB0z5w9o=;
        b=Sk1yTssC1K4vWAh6iRMW2Wk/FtzGAGa/YEauJ5iCFJFf4lF36U2Wcz5dzcyDam/xnL
         070sPgukCgmszgmlxLgaZVKea1irK0ktN0kUFK8on3xo7y3mzFLFODJj1KGKB6fBL+7L
         2W7thtPl/B4EefwqICSFol2dwjk8VU13DK9NRxIQum+MYBZnGNtO/z7EADaQ4gxCiChq
         ypmI5fnAUnxF97b0jFCcz/kjY6HWPj2ZFYp6kZHSU/U9iVz231dyhrds/D0WpHG9Ir+1
         YE89Gf4WGAnxaBKnwJ46xyxrXrUu6+bu5XmGM6uiUOjWSwmbe+onQ43WTkJ7wMu2USd+
         t5FQ==
X-Gm-Message-State: APt69E0Y/xIkW6iH2WGsJKGght5N37EDkNTmoc1gPx5OZzz50hA46v+4
        gnictpRNmoQeD+bVyJiOnKXHUw==
X-Google-Smtp-Source: AAOMgpdaMyoYbchZo3CC7FlkhpC7ldJlRiKeCYbgRKUQ+ThtMhX42jqEZixXZ9K063ljkPhlGxoD+A==
X-Received: by 2002:ac8:3274:: with SMTP id y49-v6mr16177950qta.194.1530630909327;
        Tue, 03 Jul 2018 08:15:09 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y131-v6sm773495qka.30.2018.07.03.08.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:15:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 02/14] block: introduce bio_issue_as_root_blkg
Date:   Tue,  3 Jul 2018 11:14:51 -0400
Message-Id: <20180703151503.2549-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

Instead of forcing all file systems to get the right context on their
bio's, simply check for REQ_META to see if we need to issue as the root
blkg.  We don't want to force all bio's to have the root blkg associated
with them if REQ_META is set, as some controllers (blk-iolatency) need
to know who the originating cgroup is so it can backcharge them for the
work they are doing.  This helper will make sure that the controllers do
the proper thing wrt the IO priority and backcharging.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/blk-cgroup.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6c666fd7de3c..69aa71dc0c04 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -238,6 +238,22 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 	return css_to_blkcg(task_css(current, io_cgrp_id));
 }
 
+/**
+ * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
+ * @return: true if this bio needs to be submitted with the root blkg context.
+ *
+ * In order to avoid priority inversions we sometimes need to issue a bio as if
+ * it were attached to the root blkg, and then backcharge to the actual owning
+ * blkg.  The idea is we do bio_blkcg() to look up the actual context for the
+ * bio and attach the appropriate blkg to the bio.  Then we call this helper and
+ * if it is true run with the root blkg for that queue and then do any
+ * backcharging to the originating cgroup once the io is complete.
+ */
+static inline bool bio_issue_as_root_blkg(struct bio *bio)
+{
+	return (bio->bi_opf & REQ_META);
+}
+
 /**
  * blkcg_parent - get the parent of a blkcg
  * @blkcg: blkcg of interest
-- 
2.14.3

