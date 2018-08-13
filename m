Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11764C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0D221755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aO83XHL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0D221755
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbeHNCYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:24:05 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:47755 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNCYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:24:05 -0400
Received: by mail-qk0-f202.google.com with SMTP id 99-v6so18777449qkr.14
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y1yR7DwknJsyXWYESqMJYxBOHIZGCQgygFIYNNOEob0=;
        b=aO83XHL21ioMh1HKPNTYmwboj6sdmE6Rzq4hDdfOw1mmBNPJr1qJtfROdsy5FR5HOU
         Uq06PSYls2Wz6bAqUHGFNnBRqBKfOnp2AWSqZ5kik1nhL+uLjiWJ5mQt+l4We7r97Uvr
         T7oxwAA2vbVkZtRBIr1829EQaqBgSJMRDE91tqsVZRVlijTh1uqBia2sVbz85klCIlQk
         5ZCwFInpJiRuCEk6CY4qpearPYmcXQCsWkhSH0HX/DlLKjP7RbS76tD1J9q2QVYIQAZX
         DcXsYjaGGRVaCFouvJr4yxPQAIVhdF9mRTAmr5f7OD4H/uvQrZ8P4v0lL+5BRlRClT/I
         gEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y1yR7DwknJsyXWYESqMJYxBOHIZGCQgygFIYNNOEob0=;
        b=qB4L8w+05605+4ReeyNx5NHABjGRkFK4LvNOrNnNQxjGZ+CFS6+3vfjTU9aeMTfTTH
         LuYsbOBxDd36GcJ1gc1lhgI2e7cN5OnFKXY66VtmKpiyUDofvwmxx4841KMeFs8SVB8k
         H2IshB3U6VAstfBtMdMVauMnheXoSovxgl0fWpPgMC/Ux+f9vd4jZmx/g1HqpnVbieYx
         trecTJmsjsrAeon+DZgt0bGBubLKGkzOvZW6J4NWAZS+7XpSwBMpOaKrwW4FZaDTlXhP
         EPFs5gKc6nEGXSJXSUCtZcWsxLattRuDGn9xI06yodEwMY2QjAVir61jsldLY75SAKgw
         h4uw==
X-Gm-Message-State: AOUpUlGF9HE+ntOBmSmFr3hk/1ON86GDBoKmAcADKlL34De928ekGK8P
        bYuqiK5fAYSr50DW3yPrwJHufRQ7
X-Google-Smtp-Source: AA+uWPzQb9apDt4SkHgxMgHoU7AwS67kZP2Tk8ATPKnI1yfBIPRPbmsJhgZHrzaFGYcvj0VUuaH+r5bD
X-Received: by 2002:ac8:2ffd:: with SMTP id m58-v6mr10960382qta.39.1534203575987;
 Mon, 13 Aug 2018 16:39:35 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:38:37 -0700
In-Reply-To: <20180813233839.190855-1-rkir@google.com>
Message-Id: <20180813233839.190855-6-rkir@google.com>
Mime-Version: 1.0
References: <20180813233839.190855-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 6/9] platform: goldfish: pipe: Fail compilation if structs are
 too large
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
 drivers/platform/goldfish/goldfish_pipe.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index a4db4d12b09c..5eed4c824a53 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -63,6 +63,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/acpi.h>
+#include <linux/bug.h>
 #include "goldfish_pipe_qemu.h"
 
 /*
@@ -797,9 +798,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 	 * needs to be contained in a single physical page. The easiest choice
 	 * is to just allocate a page and place the buffers in it.
 	 */
-	if (WARN_ON(sizeof(*dev->buffers) > PAGE_SIZE))
-		return -ENOMEM;
-
+	BUILD_BUG_ON(sizeof(*dev->buffers) > PAGE_SIZE);
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page) {
 		kfree(dev->pipes);
@@ -842,8 +841,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	struct resource *r;
 	struct goldfish_pipe_dev *dev = pipe_dev;
 
-	if (WARN_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE))
-		return -ENOMEM;
+	BUILD_BUG_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE);
 
 	/* not thread safe, but this should not happen */
 	WARN_ON(dev->base != NULL);
-- 
2.18.0.865.gffc8e1a3cd6-goog

