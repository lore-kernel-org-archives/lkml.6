Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EE3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ADE208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFHQBhzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21ADE208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeH0WLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:33 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:34163 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:33 -0400
Received: by mail-vk0-f73.google.com with SMTP id o62-v6so6834974vko.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aMsh+OhO3+eG0eAe2tB3C0wZmw5Mkk207ICLxJgOd18=;
        b=eFHQBhzFgLByMEu8elt/2yO0FxyOc2MeYlq1rooPm6Yao3BkTvGE37q1tSyfNE8VHG
         GMQRb2Xa7Fj6UCQBKwyfDLMXMQ4cmi+of+HqiKIm2f5xx/zg4/W97K7Wfo7uHTC6YtQl
         y4f65n+15GEz1bujrVr2FxruznfHtD7/2a4wjA/LlfleQGPllJqIArQ2mj9TDw+5uz/K
         Fxs6zYWqJAvAfIH6fChRntS2rolg169HtL+KjziXty+FM3tryuaEuDWXcuN8Av0GWqlG
         10SVZo/KTaG+ITSGDSY7wLIB9+DE5nYiaHMlwn7U6ozAoDDljn7P6pyKyXSdQiH+lt06
         42Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aMsh+OhO3+eG0eAe2tB3C0wZmw5Mkk207ICLxJgOd18=;
        b=tldOu5XHrj/+Y+pPjTX/WyQCH+pZ6sdx2UiN/lJHOAmsqmhTtqXllvXX/WMER21X6n
         c1nzRLWHMy2ZmX5zK6XukeqA4ybuAsbBzU59/Kpxmkaz5BbZHvBXNlJq+r7no2I1vbfb
         xio3Cc2vUvt9wP6kKb0kfHRxdPZRiTyMVmy8SSAUsZ6IjYPvm8eV+0HjXseBdeYReRUM
         rDnJiGqJOjGciv1DyIzq2CDK+bXGiFONDkGpKYgP2c1Q3cxphytVfSe8UXPkh+M+raZk
         zDBprhFgRnd+0GAY2CKjf9rU1b8220J4j/evMMTaMbYnieJtnsULBTw06rZ8rjrGZ2W7
         VT/Q==
X-Gm-Message-State: APzg51BpiC/PXSOOxuendAIkb9iW4u+CCIXnBNvXUNHVBb6r7T40fh7C
        myHqpnzX2RZSUH6fSNAxRQPMG6Pw
X-Google-Smtp-Source: ANB0VdYJZ35ff5dQ3rEWy06gHGRZVVSjUKvhYGLReypZu6VGR9MrqHB6d30a4KYBYqmQnBG0Pf4o8QvG
X-Received: by 2002:ab0:492b:: with SMTP id z40-v6mr7329597uac.67.1535394230619;
 Mon, 27 Aug 2018 11:23:50 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:01 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-6-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 06/20] platform: goldfish: pipe: Fail compilation if structs
 are too large
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

Since the driver provides no workaround prevent in cases if structs do
no fit into a memory page, it is better to fail complation to find about
the issue earlt instead of returning errors at runtime.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 0c55e657da5a..24e40deb98cc 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -64,6 +64,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/acpi.h>
+#include <linux/bug.h>
 #include "goldfish_pipe_qemu.h"
 
 /*
@@ -689,6 +690,7 @@ static int goldfish_pipe_open(struct inode *inode, struct file *file)
 	 * Command buffer needs to be allocated on its own page to make sure
 	 * it is physically contiguous in host's address space.
 	 */
+	BUILD_BUG_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE);
 	pipe->command_buffer =
 		(struct goldfish_pipe_command *)__get_free_page(GFP_KERNEL);
 	if (!pipe->command_buffer) {
@@ -798,9 +800,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 	 * needs to be contained in a single physical page. The easiest choice
 	 * is to just allocate a page and place the buffers in it.
 	 */
-	if (WARN_ON(sizeof(*dev->buffers) > PAGE_SIZE))
-		return -ENOMEM;
-
+	BUILD_BUG_ON(sizeof(struct goldfish_pipe_dev_buffers) > PAGE_SIZE);
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page) {
 		kfree(dev->pipes);
@@ -843,9 +843,6 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	struct resource *r;
 	struct goldfish_pipe_dev *dev = pipe_dev;
 
-	if (WARN_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE))
-		return -ENOMEM;
-
 	/* not thread safe, but this should not happen */
 	WARN_ON(dev->base != NULL);
 
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

