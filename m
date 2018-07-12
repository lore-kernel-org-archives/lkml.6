Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F62ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A632087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDVjSWM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A632087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbeGLWlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:41:32 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:37112 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733178AbeGLWlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:41:32 -0400
Received: by mail-qk0-f201.google.com with SMTP id q3-v6so30313136qki.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=pZCDk0LJyCkWFCJPAGY1ZlUzKY9xV4LLkh4d/Phuwsc=;
        b=HDVjSWM4xsIQ+49wf4C0Y9KHHna7Ux0kXPDuRrWpOIs7eyhGI5YD2Itgymn+aLssb8
         r7Nn6Y/yjWct5hfMxa6yKYWYhuWRWHccVxJMe1INbDjJH9Y4DG+QiVOG5oYFh0R6yaaQ
         ifRdVZqALLissZIc6k79Ub9L2zFtXIpRaJulUD1HZZEyKpy1XrVcv/i26tQuFibRNcmF
         5IdTJDLI8Dqc/9uk2otUQDix8mjTdwFXkAQieZ8ZE5RxMDcQoZEes8apLlJAAQi6bXyk
         BRmxe7Xllo90a67jU2LSptfs0x4lRSSjCpMJsQEd92eqYXRzAW8ngP+dyHBzk/HfpjbB
         00Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=pZCDk0LJyCkWFCJPAGY1ZlUzKY9xV4LLkh4d/Phuwsc=;
        b=D6KAmvkW5GJX9Nx2XYjrJGxkxxhF2+Yru2S2JnTKI+Oo0mAeG91+Q5U10kTjfvjczM
         2iDDPFNCUTtbn8+CvJpJM+pmT+iP4D+SFawpNX1saiBcK5wGf3qjQ6xh+Edu0OLqJTPO
         opaFW63XETuF3W4FJ7zLAsE00romCz42Q71iG9AMScgv2Jxuhw6WvlyzfvCbFntrN5pq
         SmOrN4jB6LwNLmKck0Y/ZnK6hQdEWdfPD5ikS4AgfRXZLnn490LzkPVjcqFHMyW2xBJf
         k2o0Wx7CfUyCROC1nWxjZ0ZAbGHyHlRhZZECpmiL4jeU+nOTPq1/zGLDYfnUXOqH3N0e
         Dy5g==
X-Gm-Message-State: AOUpUlHEESI+DEJUnXNNU3Xvm+0cP0tVmJf5Tvzhks7GLMhWZin8WtZZ
        LmrjJ4JYYHDPKkBukVSPI2sKuFSaig==
X-Google-Smtp-Source: AAOMgpcZiYm5bteJQDrQXOyFm5t3v3hhisrWaMaeCjyBjMkfuS4g/jX3tpNLLkkmt/TAjshiJjfVKCkJAw==
MIME-Version: 1.0
X-Received: by 2002:ae9:ebc1:: with SMTP id b184-v6mr2355166qkg.14.1531434594425;
 Thu, 12 Jul 2018 15:29:54 -0700 (PDT)
Date:   Fri, 13 Jul 2018 00:29:36 +0200
Message-Id: <20180712222935.257776-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] staging: speakup: fix wraparound in uaccess length check
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, jannh@google.com
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

If softsynthx_read() is called with `count < 3`, `count - 3` wraps, causing
the loop to copy as much data as available to the provided buffer. If
softsynthx_read() is invoked through sys_splice(), this causes an
unbounded kernel write; but even when userspace just reads from it
normally, a small size could cause userspace crashes.

Fixes: 425e586cf95b ("speakup: add unicode variant of /dev/softsynth")
Cc: stable@vger.kernel.org
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/staging/speakup/speakup_soft.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/speakup/speakup_soft.c b/drivers/staging/speakup/speakup_soft.c
index a61bc41b82d7..947c79532e10 100644
--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -198,11 +198,15 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 	int chars_sent = 0;
 	char __user *cp;
 	char *init;
+	size_t bytes_per_ch = unicode ? 3 : 1;
 	u16 ch;
 	int empty;
 	unsigned long flags;
 	DEFINE_WAIT(wait);
 
+	if (count < bytes_per_ch)
+		return -EINVAL;
+
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	while (1) {
 		prepare_to_wait(&speakup_event, &wait, TASK_INTERRUPTIBLE);
@@ -228,7 +232,7 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 	init = get_initstring();
 
 	/* Keep 3 bytes available for a 16bit UTF-8-encoded character */
-	while (chars_sent <= count - 3) {
+	while (chars_sent <= count - bytes_per_ch) {
 		if (speakup_info.flushing) {
 			speakup_info.flushing = 0;
 			ch = '\x18';
-- 
2.18.0.203.gfac676dfb9-goog

