Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A00EECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E3E20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRAJSzA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E3E20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeINXH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:07:26 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:41291 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeINXHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:07:25 -0400
Received: by mail-io1-f74.google.com with SMTP id q24-v6so9289114iog.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tj/l0hcCIl2eKCVm6u6jw6ca3K5TtMntTmpq8sUfzG8=;
        b=SRAJSzA39sazghDEMysK9EqFtSi1KppbgBwhVI7B0h7zIb86Yr5i3Oy0j7Sxy8kPlt
         T0BYptKrRnCI0elt9IVACrRt1izyRqKAIBo9OOFZF5IFcp3I3tenCw0JDrwyg/AAyXHg
         5wznVYQRsvEJpMzjg64MO0u5aDfyh2eMwrETtGb/PIgCw3kCFdfCRp41YIdJ161RFNyM
         wKh0uZS+GMSUVQM5k7nwXHz417nI4i9CmKnoEu6UhNhd17BAnW6xq+UeSN2d3zVPGk3w
         pB8C2S3Yb8bvvdmYx4IpxiQA4CgQ+3HQIhO54nSBxOfvcD++w4yfC9Cls1+7kSHsqnAg
         ZXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tj/l0hcCIl2eKCVm6u6jw6ca3K5TtMntTmpq8sUfzG8=;
        b=gxT9xFTEXoauDICVrz0Mn+A1HD1cx6J6oL0/ksFOnxKJC91nebhlEwmtxog/IV8p2m
         hgE7VAeaQgQeV3gobZZ+ApBaMMp5cgQ7Ge0WB52fJjHZWSHJdIk0MfJCxLyYGFAxHZwz
         VQ3AktW+3ms+nhHj7ZX4d2Na5Gyq4Ym3zXkGI4VaZTLzvNcaKgB8HoMApATjbpyYS7fI
         ZIoVBDsCYksQSWo7d+FKlZrQTTlHCN2VtAD85+8i1y/FoGzi0Mu5D97FFyOIT1r8XoQd
         XCXSz1W4XTLPAirdWJNrc+mytPuMWg0i/pKZ63DCptLHCq4xDa1181w7iCJruP1NovRq
         NIkQ==
X-Gm-Message-State: APzg51Dv8WAdgH8m4kwZb8aMFefHcEQOSaDBvIIcTX22CL71xSUzy/pn
        SHLOKQy23N/E3Vwpc9pddfA87BFD
X-Google-Smtp-Source: ANB0VdYe92Y7yEnL5EP3G6+xRyu8VZIKL8+h4KJK8VmX0U003/XOjz19vyfQ8Axx/R6K0rgXQHFZnZTX
X-Received: by 2002:a24:74cd:: with SMTP id o196-v6mr2945250itc.46.1536947512204;
 Fri, 14 Sep 2018 10:51:52 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:03 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-2-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 02/21] platform: goldfish: pipe: Prevent memory corruption
 from several threads writing to the same variable
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Move the "pages" buffer into "struct goldfish_pipe". Since we are
locking the mutex on the pipe in transfer_max_buffers, other threads
willnot be able to write into it, but other pipe instances could be
served because they have its own buffer.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 24 +++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index b4a484bbcdaa..6ae2b00f4bff 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -163,6 +163,9 @@ struct goldfish_pipe {
 
 	/* Pointer to the parent goldfish_pipe_dev instance */
 	struct goldfish_pipe_dev *dev;
+
+	/* A buffer of pages, too large to fit into a stack frame */
+	struct page *pages[MAX_BUFFERS_PER_COMMAND];
 };
 
 /* The global driver data. Holds a reference to the i/o page used to
@@ -340,21 +343,23 @@ static int transfer_max_buffers(struct goldfish_pipe *pipe,
 				s32 *consumed_size,
 				int *status)
 {
-	static struct page *pages[MAX_BUFFERS_PER_COMMAND];
 	unsigned long first_page = address & PAGE_MASK;
 	unsigned int iter_last_page_size;
-	int pages_count = pin_user_pages(first_page, last_page,
-					 last_page_size, is_write,
-					 pages, &iter_last_page_size);
-
-	if (pages_count < 0)
-		return pages_count;
+	int pages_count;
 
 	/* Serialize access to the pipe command buffers */
 	if (mutex_lock_interruptible(&pipe->lock))
 		return -ERESTARTSYS;
 
-	populate_rw_params(pages, pages_count, address, address_end,
+	pages_count = pin_user_pages(first_page, last_page,
+				     last_page_size, is_write,
+				     pipe->pages, &iter_last_page_size);
+	if (pages_count < 0) {
+		mutex_unlock(&pipe->lock);
+		return pages_count;
+	}
+
+	populate_rw_params(pipe->pages, pages_count, address, address_end,
 			   first_page, last_page, iter_last_page_size, is_write,
 			   pipe->command_buffer);
 
@@ -364,10 +369,9 @@ static int transfer_max_buffers(struct goldfish_pipe *pipe,
 
 	*consumed_size = pipe->command_buffer->rw_params.consumed_size;
 
-	release_user_pages(pages, pages_count, is_write, *consumed_size);
+	release_user_pages(pipe->pages, pages_count, is_write, *consumed_size);
 
 	mutex_unlock(&pipe->lock);
-
 	return 0;
 }
 
-- 
2.19.0.397.gdd90340f6a-goog

