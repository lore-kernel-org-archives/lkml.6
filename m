Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDADC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A00208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tW9Pl0Ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A00208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeH0WMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:12:10 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36004 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:12:09 -0400
Received: by mail-pg1-f201.google.com with SMTP id r2-v6so11453442pgp.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uctRzLAeN/zXob/RMxXvijWe3byfwl+BkVHtGtNr0sI=;
        b=tW9Pl0IhBxMn2fCHpUkGgB3pTBJrN6v7tFfzy4oaE2hUE0WLXuvgOvPzs08egNzbfo
         ROg8gc6DHp+H5lfaqXFC5uTIdZ9wiNohjoPvhDUllKJ+F/1ucyRSpDvGfGaV7iA5KDDX
         aBmN3h137z3CtQOv+RCGaVBeGJ8+/vFXbLhTgXSp9bKSGhJAX11rPmZa/vL5lH2F0ltq
         NHiqx0EjqPEuBORU5Dsl0gsKl+ZkGQ6b4i9Bng2DgHRwoT+SkbgJLOJOiza37j+QWvHc
         4cKuCskUeft5po0nq1Li/HnsCuU4TOPi2KSRDUwXuWxNSB0vBuvjtL29ls8PNTbM8QXD
         GY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uctRzLAeN/zXob/RMxXvijWe3byfwl+BkVHtGtNr0sI=;
        b=J3yhyh0ANr+C3PO4q9txoyf6IAw+/lqZhe+50/4efNRjJw4yFyV2asNzai0I+PXErK
         0toBpV+SFC9N5KK9gbT1peRDR4PlnPUh0EBkwyYe0VjUPl1BMRhRjb5cR4CAQuPe8igl
         sbPz0zA7d7A1FjbqDScejlY1hpVSO+rtp7nT87V/6ajoCQlk2vffB4UkPd1EnC+XIrjK
         UxsbdyL8wZpk9xksZNHd0vqul8jGGA6KOwAnqlttG61ZQFZSMgVLErOfNy14MzEW+nWG
         GmEL0aqdYjK1E2D01pg/+j3wXlBUFuxK/jjsNgNURg9Pe24aYVDI6DXhOdqCitUvM8bS
         TB+g==
X-Gm-Message-State: APzg51DzPYZaBfCCPOSQmEbEYQw/qJJwyFu/Pg/iNVCS1YtOS7OVDR9e
        Fpe86JefjryGgwUwo7qmD8s9GYZl
X-Google-Smtp-Source: ANB0Vdbb1TARpQaee3E0eCaL5J/iGaGyyUQalK/JGBlgQdxjXE1+naW7KSbyFdgqG4qH/LzSSWROJUiX
X-Received: by 2002:a63:ab47:: with SMTP id k7-v6mr3429551pgp.20.1535394267540;
 Mon, 27 Aug 2018 11:24:27 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:13 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-18-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 18/20] platform: goldfish: pipe: Fix alignment to match parenthesis
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

checkpatch: Alignment should match open parenthesis.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 83 +++++++++++++----------
 1 file changed, 48 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 324129879b09..02783bc59dd7 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -252,10 +252,12 @@ static int goldfish_pipe_error_convert(int status)
 	}
 }
 
-static int pin_user_pages(unsigned long first_page, unsigned long last_page,
-	unsigned int last_page_size, int is_write,
-	struct page *pages[MAX_BUFFERS_PER_COMMAND],
-	unsigned int *iter_last_page_size)
+static int pin_user_pages(unsigned long first_page,
+			  unsigned long last_page,
+			  unsigned int last_page_size,
+			  int is_write,
+			  struct page *pages[MAX_BUFFERS_PER_COMMAND],
+			  unsigned int *iter_last_page_size)
 {
 	int ret;
 	int requested_pages = ((last_page - first_page) >> PAGE_SHIFT) + 1;
@@ -267,8 +269,8 @@ static int pin_user_pages(unsigned long first_page, unsigned long last_page,
 		*iter_last_page_size = last_page_size;
 	}
 
-	ret = get_user_pages_fast(
-			first_page, requested_pages, !is_write, pages);
+	ret = get_user_pages_fast(first_page, requested_pages, !is_write,
+				  pages);
 	if (ret <= 0)
 		return -EFAULT;
 	if (ret < requested_pages)
@@ -278,7 +280,7 @@ static int pin_user_pages(unsigned long first_page, unsigned long last_page,
 }
 
 static void release_user_pages(struct page **pages, int pages_count,
-	int is_write, s32 consumed_size)
+			       int is_write, s32 consumed_size)
 {
 	int i;
 
@@ -290,12 +292,15 @@ static void release_user_pages(struct page **pages, int pages_count,
 }
 
 /* Populate the call parameters, merging adjacent pages together */
-static void populate_rw_params(
-	struct page **pages, int pages_count,
-	unsigned long address, unsigned long address_end,
-	unsigned long first_page, unsigned long last_page,
-	unsigned int iter_last_page_size, int is_write,
-	struct goldfish_pipe_command *command)
+static void populate_rw_params(struct page **pages,
+			       int pages_count,
+			       unsigned long address,
+			       unsigned long address_end,
+			       unsigned long first_page,
+			       unsigned long last_page,
+			       unsigned int iter_last_page_size,
+			       int is_write,
+			       struct goldfish_pipe_command *command)
 {
 	/*
 	 * Process the first page separately - it's the only page that
@@ -327,16 +332,20 @@ static void populate_rw_params(
 }
 
 static int transfer_max_buffers(struct goldfish_pipe *pipe,
-	unsigned long address, unsigned long address_end, int is_write,
-	unsigned long last_page, unsigned int last_page_size,
-	s32 *consumed_size, int *status)
+				unsigned long address,
+				unsigned long address_end,
+				int is_write,
+				unsigned long last_page,
+				unsigned int last_page_size,
+				s32 *consumed_size,
+				int *status)
 {
 	static struct page *pages[MAX_BUFFERS_PER_COMMAND];
 	unsigned long first_page = address & PAGE_MASK;
 	unsigned int iter_last_page_size;
 	int pages_count = pin_user_pages(first_page, last_page,
-			last_page_size, is_write,
-			pages, &iter_last_page_size);
+					 last_page_size, is_write,
+					 pages, &iter_last_page_size);
 
 	if (pages_count < 0)
 		return pages_count;
@@ -346,8 +355,8 @@ static int transfer_max_buffers(struct goldfish_pipe *pipe,
 		return -ERESTARTSYS;
 
 	populate_rw_params(pages, pages_count, address, address_end,
-		first_page, last_page, iter_last_page_size, is_write,
-		pipe->command_buffer);
+			   first_page, last_page, iter_last_page_size, is_write,
+			   pipe->command_buffer);
 
 	/* Transfer the data */
 	*status = goldfish_pipe_cmd_locked(pipe,
@@ -374,7 +383,7 @@ static int wait_for_host_signal(struct goldfish_pipe *pipe, int is_write)
 
 	while (test_bit(wake_bit, &pipe->flags)) {
 		if (wait_event_interruptible(pipe->wake_queue,
-				!test_bit(wake_bit, &pipe->flags)))
+					     !test_bit(wake_bit, &pipe->flags)))
 			return -ERESTARTSYS;
 
 		if (test_bit(BIT_CLOSED_ON_HOST, &pipe->flags))
@@ -385,7 +394,9 @@ static int wait_for_host_signal(struct goldfish_pipe *pipe, int is_write)
 }
 
 static ssize_t goldfish_pipe_read_write(struct file *filp,
-	char __user *buffer, size_t bufflen, int is_write)
+					char __user *buffer,
+					size_t bufflen,
+					int is_write)
 {
 	struct goldfish_pipe *pipe = filp->private_data;
 	int count = 0, ret = -EINVAL;
@@ -400,7 +411,7 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
 		return 0;
 	/* Check the buffer range for access */
 	if (unlikely(!access_ok(is_write ? VERIFY_WRITE : VERIFY_READ,
-			buffer, bufflen)))
+				buffer, bufflen)))
 		return -EFAULT;
 
 	address = (unsigned long)buffer;
@@ -413,8 +424,8 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
 		int status;
 
 		ret = transfer_max_buffers(pipe, address, address_end, is_write,
-				last_page, last_page_size, &consumed_size,
-				&status);
+					   last_page, last_page_size,
+					   &consumed_size, &status);
 		if (ret < 0)
 			break;
 
@@ -467,19 +478,21 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
 }
 
 static ssize_t goldfish_pipe_read(struct file *filp, char __user *buffer,
-				size_t bufflen, loff_t *ppos)
+				  size_t bufflen, loff_t *ppos)
 {
 	return goldfish_pipe_read_write(filp, buffer, bufflen,
-			/* is_write */ 0);
+					/* is_write */ 0);
 }
 
 static ssize_t goldfish_pipe_write(struct file *filp,
-				const char __user *buffer, size_t bufflen,
-				loff_t *ppos)
+				   const char __user *buffer, size_t bufflen,
+				   loff_t *ppos)
 {
-	return goldfish_pipe_read_write(filp,
-			/* cast away the const */(char __user *)buffer, bufflen,
-			/* is_write */ 1);
+	/* cast away the const */
+	char __user *no_const_buffer = (char __user *)buffer;
+
+	return goldfish_pipe_read_write(filp, no_const_buffer, bufflen,
+					/* is_write */ 1);
 }
 
 static __poll_t goldfish_pipe_poll(struct file *filp, poll_table *wait)
@@ -507,7 +520,7 @@ static __poll_t goldfish_pipe_poll(struct file *filp, poll_table *wait)
 }
 
 static void signalled_pipes_add_locked(struct goldfish_pipe_dev *dev,
-	u32 id, u32 flags)
+				       u32 id, u32 flags)
 {
 	struct goldfish_pipe *pipe;
 
@@ -529,7 +542,7 @@ static void signalled_pipes_add_locked(struct goldfish_pipe_dev *dev,
 }
 
 static void signalled_pipes_remove_locked(struct goldfish_pipe_dev *dev,
-	struct goldfish_pipe *pipe)
+					  struct goldfish_pipe *pipe)
 {
 	if (pipe->prev_signalled)
 		pipe->prev_signalled->next_signalled = pipe->next_signalled;
@@ -805,7 +818,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 	dev->first_signalled_pipe = NULL;
 	dev->pipes_capacity = INITIAL_PIPES_CAPACITY;
 	dev->pipes = kcalloc(dev->pipes_capacity, sizeof(*dev->pipes),
-					GFP_KERNEL);
+			     GFP_KERNEL);
 	if (!dev->pipes)
 		return -ENOMEM;
 
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

