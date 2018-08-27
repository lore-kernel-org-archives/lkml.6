Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37C8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7882208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqqZyXj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7882208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeH0WLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:36 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:40138 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:35 -0400
Received: by mail-io0-f201.google.com with SMTP id p22-v6so14569761ioh.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZBmsTb6IwksazDs4PyROyPhoVAiGchwtF1sGndheJ9k=;
        b=uqqZyXj4OPPzAOWXDFegJNbR+zus6oO1ECLnCr+O/jiY9CgCTciazZdNBv1PRVa08r
         Q/xvwVUgz/Hn0NrE6IFiangdvr8rhOH+rqk2QavNaSJDgjtxTJmyFqMUUWiEnuwRab2J
         NCcZyUMidFK7xmxbTO8+fhiP1fweRpFF0c1ve9v8TD3Mj12Fg6iFGkeO1jdxQOjCbcKc
         +Sicn5foPdhnJQ8qH9WONpZ2/sTCQRb/UDXXgFIrJXzK2SJYjfH7USmKYKq2aYL/QMnZ
         j9+iac1MkHipADxiVFKqOV8/m25SXS9LVbePrLp7ePfDvcDT39RAs0TxSKVVmEHPRVV2
         egNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZBmsTb6IwksazDs4PyROyPhoVAiGchwtF1sGndheJ9k=;
        b=CTZFpBzuBgQ+qUqpC96tX9HvAnHGzS4AMPRYiJRIsPONwuP6KNVBA27EYhYg/nAKre
         j+DAsXLPCFqk8h+qR/w2VtKz1w1UScreBLCqR2Hw+CgIu+45BXKSrI4dCM23Zdru6lna
         5SckCSzphKL+g+bMnv4U/JmDgdPg3T8aMSb4845YR1olivBCwdU9CmwR1WenkMSk0+gi
         BmWzRZ8EyRvt+0D+oPJnBxGFR+zTWrlICZhEdE2DpOcNcsxLKDcxLpI81b/+5OEQ45k1
         GGJJeqJGgefCjSQeUxaSr+Ax5fvxVeL9ukikIx1rH38l8V5iLsb5WWIi6VV1SuzfeROy
         qRfw==
X-Gm-Message-State: APzg51DKTNjL5F5H+VQK9zQuGefujf55MDUBYTJu0Z2LatDHE/kYX+Vc
        NE+23VmujBMS86E0WNOxJr9k2b2F
X-Google-Smtp-Source: ANB0Vda/qrgwkqWJ17R0wO++2hULxsXu1awVIZNWVuCCjgwLPFrDA7KwjuzXN+8kdAmE0u7ACf7l0klc
X-Received: by 2002:a24:a85:: with SMTP id 127-v6mr4677081itw.9.1535394233374;
 Mon, 27 Aug 2018 11:23:53 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:02 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-7-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 07/20] platform: goldfish: pipe: Replace an array of 1 with a variable
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

There is no reason to have an array of 1.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 28 +++++++++++------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 24e40deb98cc..e9e3e791c0d4 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -205,7 +205,7 @@ struct goldfish_pipe_dev {
 	unsigned char __iomem *base;
 };
 
-static struct goldfish_pipe_dev pipe_dev[1] = {};
+struct goldfish_pipe_dev goldfish_pipe_dev;
 
 static int goldfish_cmd_locked(struct goldfish_pipe *pipe, enum PipeCmdCode cmd)
 {
@@ -564,12 +564,12 @@ static struct goldfish_pipe *signalled_pipes_pop_front(
 
 static void goldfish_interrupt_task(unsigned long unused)
 {
-	struct goldfish_pipe_dev *dev = pipe_dev;
 	/* Iterate over the signalled pipes and wake them one by one */
 	struct goldfish_pipe *pipe;
 	int wakes;
 
-	while ((pipe = signalled_pipes_pop_front(dev, &wakes)) != NULL) {
+	while ((pipe = signalled_pipes_pop_front(&goldfish_pipe_dev, &wakes)) !=
+			NULL) {
 		if (wakes & PIPE_WAKE_CLOSED) {
 			pipe->flags = 1 << BIT_CLOSED_ON_HOST;
 		} else {
@@ -607,7 +607,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	struct goldfish_pipe_dev *dev = dev_id;
 
-	if (dev != pipe_dev)
+	if (dev != &goldfish_pipe_dev)
 		return IRQ_NONE;
 
 	/* Request the signalled pipes from the device */
@@ -672,7 +672,7 @@ static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
  */
 static int goldfish_pipe_open(struct inode *inode, struct file *file)
 {
-	struct goldfish_pipe_dev *dev = pipe_dev;
+	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 	unsigned long flags;
 	int id;
 	int status;
@@ -763,7 +763,7 @@ static const struct file_operations goldfish_pipe_fops = {
 	.release = goldfish_pipe_release,
 };
 
-static struct miscdevice goldfish_pipe_dev = {
+static struct miscdevice goldfish_pipe_miscdev = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "goldfish_pipe",
 	.fops = &goldfish_pipe_fops,
@@ -771,8 +771,8 @@ static struct miscdevice goldfish_pipe_dev = {
 
 static int goldfish_pipe_device_init(struct platform_device *pdev)
 {
+	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 	char *page;
-	struct goldfish_pipe_dev *dev = pipe_dev;
 	int err = devm_request_irq(&pdev->dev, dev->irq,
 				goldfish_pipe_interrupt,
 				IRQF_SHARED, "goldfish_pipe", dev);
@@ -781,7 +781,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 		return err;
 	}
 
-	err = misc_register(&goldfish_pipe_dev);
+	err = misc_register(&goldfish_pipe_miscdev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to register v2 device\n");
 		return err;
@@ -830,18 +830,16 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 
 static void goldfish_pipe_device_deinit(struct platform_device *pdev)
 {
-	struct goldfish_pipe_dev *dev = pipe_dev;
-
-	misc_deregister(&goldfish_pipe_dev);
-	kfree(dev->pipes);
-	free_page((unsigned long)dev->buffers);
+	misc_deregister(&goldfish_pipe_miscdev);
+	kfree(goldfish_pipe_dev.pipes);
+	free_page((unsigned long)goldfish_pipe_dev.buffers);
 }
 
 static int goldfish_pipe_probe(struct platform_device *pdev)
 {
 	int err;
 	struct resource *r;
-	struct goldfish_pipe_dev *dev = pipe_dev;
+	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 
 	/* not thread safe, but this should not happen */
 	WARN_ON(dev->base != NULL);
@@ -889,7 +887,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 
 static int goldfish_pipe_remove(struct platform_device *pdev)
 {
-	struct goldfish_pipe_dev *dev = pipe_dev;
+	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 	goldfish_pipe_device_deinit(pdev);
 	dev->base = NULL;
 	return 0;
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

