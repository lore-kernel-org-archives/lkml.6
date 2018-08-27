Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960FFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EE2208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbWyQvg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EE2208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeH0WMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:12:16 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47237 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:12:14 -0400
Received: by mail-pf1-f201.google.com with SMTP id w19-v6so10248330pfa.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qiR+aV04VDZgHPqBcLzThwMgV6gYV1rIQHb2C6nrdP0=;
        b=GbWyQvg84J+rS5O5dSvRYhyqELgPD6inEtyZynmXdFIsKi19TKi2mlh84fK6HLzRxn
         AADvOYredA60qsvVETVf2wjI9ny46JIju5kzspSxiR6RLg9VdnoFf0ufSW6nJOIrcfAv
         HM36+xasFFkMKPVcOzxtJD2o+8ohPQVrkPHPxJ8lXTo9/gtW/YWWMG4ClzFS2BB1UfEM
         hIluiow+iKhi6FOU7Tsqkd8H3tzWMG497b+geeVU4eymTFQWiQ/BAKLDkurLkRqgqamA
         xFp1L5SgE+hLPr4uRMrExyBcx3h5x2uN8zzoE8u2UdU7fcSgMXLL0kgWKdsP/Vu9PNfK
         6rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qiR+aV04VDZgHPqBcLzThwMgV6gYV1rIQHb2C6nrdP0=;
        b=A3Y+8AZ9bvqHBAI4lYc7THyNz9Gkb1ZXJukwKNCjrV6h/cmvnULI2zH454VHWvddnm
         +quF6DDsctGt31F+bIDyEYxkiLNq/WMf+VrkYv7x3E37bVhBTg1fmCkGT0LewhEBIOt4
         7ZG5B0pPoskRyl/8coN5AZ2AFjpI54FPuiYlK//NJECd5TOsK3sYsUN1s3nO7Detlkzy
         jCJPJGPmxRd20Nhusvi0Dmruc9oahau/ulOUUoJ0efVt1Xfa8bTbaNIvh17YuUw5c+if
         Js8x2b9x7a4XP5wnTZUeGUeu1c+VEUYaXYiaRQxtnBhQ8qnWE10a+M7SzAMrcHB6XW65
         kJ4g==
X-Gm-Message-State: APzg51BjnboS9Fp9u8xolvqRF8PpVQm98CQlx0ZCEGpS8y4aH/jRUvDw
        Y0T1sE+3/0JmFUq7UM0gVZgv4I3a
X-Google-Smtp-Source: ANB0VdamT5UrQiyF6qghieiw8cQcnefRy5S6nhtWmXzB9BmQ1Soh6fEAMm2nRG71X4BNXRZPiR+hSmn2
X-Received: by 2002:a63:b448:: with SMTP id n8-v6mr1358187pgu.87.1535394272875;
 Mon, 27 Aug 2018 11:24:32 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:15 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-20-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 20/20] platform: goldfish: pipe: Replace "x==NULL" to "!x"
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

checkpatch: Comparison to NULL could be written "!x"

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index c892a0447a81..b4a484bbcdaa 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -699,7 +699,7 @@ static int goldfish_pipe_open(struct inode *inode, struct file *file)
 
 	/* Allocate new pipe kernel object */
 	struct goldfish_pipe *pipe = kzalloc(sizeof(*pipe), GFP_KERNEL);
-	if (pipe == NULL)
+	if (!pipe)
 		return -ENOMEM;
 
 	pipe->dev = dev;
@@ -865,23 +865,23 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 
 	/* not thread safe, but this should not happen */
-	WARN_ON(dev->base != NULL);
+	WARN_ON(dev->base);
 
 	spin_lock_init(&dev->lock);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (r == NULL || resource_size(r) < PAGE_SIZE) {
+	if (!r || resource_size(r) < PAGE_SIZE) {
 		dev_err(&pdev->dev, "can't allocate i/o page\n");
 		return -EINVAL;
 	}
 	dev->base = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
-	if (dev->base == NULL) {
+	if (!dev->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		return -EINVAL;
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (r == NULL) {
+	if (!r) {
 		err = -EINVAL;
 		goto error;
 	}
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

