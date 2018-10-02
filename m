Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9EBC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E842089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRcADOym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E842089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJCFGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:06:05 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:47591 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:06:04 -0400
Received: by mail-vk1-f201.google.com with SMTP id v4-v6so853837vkd.14
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OYGxSWYkP0x67f8I7ZIiexPSFvIcqqV/bUGJNvwKWnw=;
        b=DRcADOymJXhP5SKMpj9uoaA5qZDEgla/++W6lXcbbz02CgJxu3KmhfKudoEodjw364
         UElBVc7z1L79YOpszMGUKVLQ3h8QwAsRfTJJJQinZBWjn/KiFSkSq/+igdzv3k2d3Pt8
         d2x2yRqwb9TmOPO2TrOuMGRQ9TFgJZ6uwDeePK3zaO0CoSSVAl4v1uEgbulfGSwg/2Ji
         8pdnu9VdEDSoSqZd5WDOopoxLYiSHGw6lAdhHWNMvwrJ6790jH4rywy4xKqBNgXb7Ie3
         WfFreV4+2E2Y1EO476kL/TZjc0oqyi5elJfJ5rE9XnTqQaJcZKtWaHORPO8OCYS6Ps/F
         0FDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OYGxSWYkP0x67f8I7ZIiexPSFvIcqqV/bUGJNvwKWnw=;
        b=O5XzMTrmJIYzvh7bqTk5JF/adf/7gAsK/Ppsawk/OqPmRx+R5qqDKksLGsB7G0Fyos
         Np5fdIwYHRGu56JvWNJeaBfuFqo5w1RFlaFqPgk/7OFzAzWRHVa8iATr8hMvvFcFplHw
         3+i1xlse6ESUclCgC9R3+5lVZy/yG+Ut7HcyMyejVROq2M5bS+LZUfbpGiYnnd9qqOng
         mN3SnUhsbOWF8HKuMBxoRNKhuCjdROdgmoxsBRUfXo7T5jxqKl3YmaaU4gpftdSD5qFA
         oI9I386XRlBdILK7do1m9m6q0ws0MLd4LZ0e7SsuAy6EhDiVrUI0SDr4qdvnfkS+8V3T
         sDYg==
X-Gm-Message-State: ABuFfoiWiZrP9gPIrG9QtC8Gd9INVMMcLfpzMyLSq97a3cqeaCnHCpYO
        WGZeyiw/ZMKVVuZANdWBzlTDMC4s
X-Google-Smtp-Source: ACcGV62ZyaRCZaClGbmklT4uyq1g4YgT4RyuvN1nOs2atoN9Cf/Pew5U3XhNf+wvYNyRq1WSFQrt47D/
X-Received: by 2002:a9f:3766:: with SMTP id a35-v6mr17445092uae.19.1538518830052;
 Tue, 02 Oct 2018 15:20:30 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:18:55 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-7-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 07/15] platform: goldfish: pipe: Return status from "deinit"
 since "remove" does not do much
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

This way deinit will have a chance to report an error.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 445c0c0c66c4..1822d4146778 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -888,13 +888,15 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void goldfish_pipe_device_deinit(struct platform_device *pdev,
-					struct goldfish_pipe_dev *dev)
+static int goldfish_pipe_device_deinit(struct platform_device *pdev,
+				       struct goldfish_pipe_dev *dev)
 {
 	misc_deregister(&dev->miscdev);
 	tasklet_kill(&dev->irq_tasklet);
 	kfree(dev->pipes);
 	free_page((unsigned long)dev->buffers);
+
+	return 0;
 }
 
 static int goldfish_pipe_probe(struct platform_device *pdev)
@@ -941,8 +943,7 @@ static int goldfish_pipe_remove(struct platform_device *pdev)
 {
 	struct goldfish_pipe_dev *dev = platform_get_drvdata(pdev);
 
-	goldfish_pipe_device_deinit(pdev, dev);
-	return 0;
+	return goldfish_pipe_device_deinit(pdev, dev);
 }
 
 static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
-- 
2.19.0.605.g01d371f741-goog

