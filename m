Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955EBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C613208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGxzlF/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C613208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeH0WLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:45 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:42446 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:45 -0400
Received: by mail-qk0-f201.google.com with SMTP id z17-v6so15046010qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LUhEpBtMAoapHe1f39BXO+A8sN/iXsBU5iE07wK0RtA=;
        b=bGxzlF/L5oOSS9TbN4u5FzxkjLJL3eXvoFWJli/OARjkZi4d75+EQbygXhXb0B3sR/
         fpLQgINmq253Dc1tTyXb29pGvPOvq1aGoWvdYJFSlC4WQyzlO5DwTxOp5Xjf5JDZwWQd
         HvVAgo0Lnx9Sj1R4XT3l0bdZ5pAV91U7dCE3/5HRT9BXDfJxMRttT//m5BX6ii8mGYi3
         zJcm04Jlsg6aeo2NMzW1dkOUtjB+y89r6uE0RIwSUakQn5nymxDf5W7BEZhflbfTAqvk
         BCmc95iDmDxGaBzan+IjvITzoSt489+cSv5N9ESoFZVZeCD5ucdCqVwjc5UdWLIMOw7f
         onyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LUhEpBtMAoapHe1f39BXO+A8sN/iXsBU5iE07wK0RtA=;
        b=LIEKsPEmmgh6ZnD/txTcWQXiVUHpSOp1IeaEILYeGm1A8DAJiuwoSPUXLPxo/GvqUx
         0PRpig5m65SKUzS+CADqzyhN4zMnmPwe5FQ5RPWISunFsZGD7JGHY5CF4yFVP3aL3lco
         v/IlWofhpyQbLasPAcCWqIgn7rWh8X7wJMspKkUHc5IzOT9vPWJ0JUX/6Ua3ZZ/1c7hh
         YlmdsUk3/SRTcd/uRDW4s53SPL6HcToPqbk2ZM0wYfMiVegJKIC38V2xQAYPdCoRYUIj
         pt/uDGpLUNBIWvBCRYdViyLewX+uBuToLb81Nz5+Is7zVgPgXazcjLMzkyvFyKlXhcmU
         cabg==
X-Gm-Message-State: APzg51B6j5Sa+CkPopM2YXEmARMhr7dueJiY4mf828FoSzS3bgO6pnad
        cIvSQNZmprziGInezxqdXUIz3l7I
X-Google-Smtp-Source: ANB0VdbXT3PWZhKxLloi59BZAIt05MwlB2lNcbVyRoV7eXusl1gJq+gTDuIyWYND01YpvHQ+cJfL0OM5
X-Received: by 2002:ac8:707:: with SMTP id g7-v6mr8218779qth.26.1535394243020;
 Mon, 27 Aug 2018 11:24:03 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:05 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-10-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 10/20] platform: goldfish: pipe: Remove a redundant variable
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

The variable was not very useful.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 62422a4282f5..3d28a9be5722 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -779,7 +779,6 @@ static struct miscdevice goldfish_pipe_miscdev = {
 static int goldfish_pipe_device_init(struct platform_device *pdev)
 {
 	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
-	char *page;
 	int err = devm_request_irq(&pdev->dev, dev->irq,
 				goldfish_pipe_interrupt,
 				IRQF_SHARED, "goldfish_pipe", dev);
@@ -809,12 +808,12 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 	 * is to just allocate a page and place the buffers in it.
 	 */
 	BUILD_BUG_ON(sizeof(struct goldfish_pipe_dev_buffers) > PAGE_SIZE);
-	page = (char *)__get_free_page(GFP_KERNEL);
-	if (!page) {
+	dev->buffers = (struct goldfish_pipe_dev_buffers *)
+		__get_free_page(GFP_KERNEL);
+	if (!dev->buffers) {
 		kfree(dev->pipes);
 		return -ENOMEM;
 	}
-	dev->buffers = (struct goldfish_pipe_dev_buffers *)page;
 
 	/* Send the buffer addresses to the host */
 	{
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

