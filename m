Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D17C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F01214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN6C22zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F01214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbeKPMWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 07:22:01 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40924 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389188AbeKPMWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 07:22:00 -0500
Received: by mail-io1-f67.google.com with SMTP id r7-v6so15870873iog.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 18:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+JRzCqFGveF0LvwRW4yP8tNmBswgGdbNsIW5Tm/R5V8=;
        b=PN6C22zEfyPZIt8kV1UUlu6tMz+NisQwSHU57y2h+XzQvbPhQQTmrBfc1sYRXyleia
         kJqO3pY+XQs7yFYwW6WEtSJNOEzFPK1Y3nNUn5zrbfmZVl62NMW5/SBrKnSlj8kfL8oj
         SvBQQ+PTfsqU4XTUHucXG4KUXelLxprKvNOFz0F20EB8uIMXdQvLlOgny69K2ARurIqd
         gATEX4YHRstL1XWD3zgIXdUtYq0scS3wpzcA8oTk2V7cT6TeVsgOfHGlLCuYxhhN5xBF
         7jcFKDAG/6THLTZAvRWhHXDBl7F8vugyqqriGsCK7QZBoMqPnGdHVTLNCnNtaLm6WauS
         KxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+JRzCqFGveF0LvwRW4yP8tNmBswgGdbNsIW5Tm/R5V8=;
        b=LyBPchQpAFJYKUksFYZzdqRXZZ5ma7qzBFbEYMTzbjjAPkBxt9QDZRNotwFgoI4Z52
         j+DgQIbpwFiqjEfmnQaEkp+stgDEJl+Pfcv62qgBcej08VYMVhHGLC+sjHfRPfufh/RU
         DP4wP7v92EyM706OicHGxw+0YMS4ZGSiAlNTC0o7A0UBsrzsHlWN8j30epBcvVMvH0eP
         vb4ToFghwBnueOigw0PyxbI1n8GLZB2jnMp8SwLEQ43RroJ3OyWuYifwydATwaax4jd0
         qHkK3uILF62RiJeUmqVoWWZoi4PDumi6bdZRzxTnIpFIkaRlSL1uiSTpYfBz9HUzPy97
         hOgA==
X-Gm-Message-State: AGRZ1gIF475gjlL9QFC0NXjVZTfOe2VhBtzGUdEPig3Mti0pXwECvU5j
        VzeUf39I0AeRbIqdHYjqUXgJuUPWOHXTIw==
X-Google-Smtp-Source: AFSGD/V/7GYv/voG3onr90QNk2lJYKVnlWPOLQnd6OqfLvGvA1E+BXGDuAQLXYOSzMK1LzYAlil8eA==
X-Received: by 2002:a6b:be87:: with SMTP id o129-v6mr5445055iof.275.1542334292195;
        Thu, 15 Nov 2018 18:11:32 -0800 (PST)
Received: from bat.mindbit.ro (CPE00fc8d79db03-CM00fc8d79db00.cpe.net.fido.ca. [72.140.67.131])
        by smtp.gmail.com with ESMTPSA id t2sm4401029iob.7.2018.11.15.18.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 18:11:31 -0800 (PST)
From:   Radu Rendec <radu.rendec@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Radu Rendec <radu.rendec@gmail.com>
Subject: [PATCH 1/1] Improve kernfs_notify() poll notification latency
Date:   Thu, 15 Nov 2018 21:09:54 -0500
Message-Id: <20181116020954.24924-2-radu.rendec@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181116020954.24924-1-radu.rendec@gmail.com>
References: <20181116020954.24924-1-radu.rendec@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernfs_notify() does two notifications: poll and fsnotify. Originally,
both notifications were done from scheduled work context and all that
kernfs_notify() did was schedule the work.

This patch simply moves the poll notification from the scheduled work
handler to kernfs_notify(). The fsnotify notification still needs to be
done from scheduled work context because it can sleep (it needs to lock
a mutex).

If the poll notification is time critical (the notified thread needs to
wake as quickly as possible), it's better to do it from kernfs_notify()
directly. One example is calling sysfs_notify_dirent() from a hardware
interrupt handler to wake up a thread and handle the interrupt in user
space.

Signed-off-by: Radu Rendec <radu.rendec@gmail.com>
---
 fs/kernfs/file.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index dbf5bc250bfd..f8d5021a652e 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -857,7 +857,6 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
 static void kernfs_notify_workfn(struct work_struct *work)
 {
 	struct kernfs_node *kn;
-	struct kernfs_open_node *on;
 	struct kernfs_super_info *info;
 repeat:
 	/* pop one off the notify_list */
@@ -871,17 +870,6 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	kn->attr.notify_next = NULL;
 	spin_unlock_irq(&kernfs_notify_lock);
 
-	/* kick poll */
-	spin_lock_irq(&kernfs_open_node_lock);
-
-	on = kn->attr.open;
-	if (on) {
-		atomic_inc(&on->event);
-		wake_up_interruptible(&on->poll);
-	}
-
-	spin_unlock_irq(&kernfs_open_node_lock);
-
 	/* kick fsnotify */
 	mutex_lock(&kernfs_mutex);
 
@@ -934,10 +922,21 @@ void kernfs_notify(struct kernfs_node *kn)
 {
 	static DECLARE_WORK(kernfs_notify_work, kernfs_notify_workfn);
 	unsigned long flags;
+	struct kernfs_open_node *on;
 
 	if (WARN_ON(kernfs_type(kn) != KERNFS_FILE))
 		return;
 
+	/* kick poll immediately */
+	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	on = kn->attr.open;
+	if (on) {
+		atomic_inc(&on->event);
+		wake_up_interruptible(&on->poll);
+	}
+	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+
+	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
 	if (!kn->attr.notify_next) {
 		kernfs_get(kn);
-- 
2.17.2

