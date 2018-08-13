Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAA1C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF7521758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJDsVwIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF7521758
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbeHNCYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:24:08 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:34588 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNCYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:24:08 -0400
Received: by mail-yw1-f73.google.com with SMTP id p127-v6so24449225ywg.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tzPHKZnCJ+ysZhgRFXOoFa6MhY0aa5NF9i/foceaBQA=;
        b=sJDsVwIpub1rr1iDwlMoSvz6S1OxX1bgwFy735hoIJ1yiVXWYaZZGYWU6V/DtTvIPV
         kxzEYqFeatGZa0+bDDUGl8DU/gJYpGwgEeaxCl9MQHR4ExnsBVUUA0NocF/7Q4r3WfpM
         rcTK/tN6uvAxe1fGOY48c0YDGs2tc25M9WJO+0bvWevgq786HmIbu5CsZWibASa64j1k
         9W/GiAguxsIHhq3pgNYznYQhVqa+XPfc6qhls4KcGnefZcLncam35dhRkwMYbNl3iREe
         7lqVx3C6vrQjfeYAfUEABA0VSnoxve+kt0GOoxGYc7EbHe17pzTZ5rVyXkL7Ft9hWegh
         WbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tzPHKZnCJ+ysZhgRFXOoFa6MhY0aa5NF9i/foceaBQA=;
        b=S4ar+w+Rm0hR3dR7FKpRp8lVYBf5F6PfFDPtvr61zIHuDocb6BxQM3Q3FYTKY2ITbg
         uwnaxCceys9Eur0AvqslILwVvvZaZm4vySGQj+rhMxtpc4V9csIlrpaa6VUy4f3qGGO7
         pxmL1iGDzMHQaUQJtMPvasreHtCW0y2p4SM0yPFDiNp9dLnBJN6+qTfyntajHigmk+jK
         F3zz4AFcKn+q7bRvSmgjW1rOJza+Hs30BywYUb+PecxS1OV0KdJ/CgBuJiuQ3C0YqzBz
         RENJ+cfGPgqIj7bO8wGEIH2RtyOpuZr4Y+PohlTtXoyQ6AqtlAgY+mBu2+wIkZhgoUd7
         WgmQ==
X-Gm-Message-State: AOUpUlG+acZtj2iw2MZYYA+huBM7beVkpYps+29MXhMORk3Wn2nPIPqd
        NbRGjFaJ0/iO+72Cx/XYmv0BSEA8
X-Google-Smtp-Source: AA+uWPzIg816C8odISWxqp83SGg7B4QwjJkO+00GpLXERHjZ9TGfoG7DfjBZSobWaxoguBKjN1dZt9uE
X-Received: by 2002:a5b:444:: with SMTP id s4-v6mr5473051ybp.58.1534203578928;
 Mon, 13 Aug 2018 16:39:38 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:38:38 -0700
In-Reply-To: <20180813233839.190855-1-rkir@google.com>
Message-Id: <20180813233839.190855-7-rkir@google.com>
Mime-Version: 1.0
References: <20180813233839.190855-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 7/9] platform: goldfish: pipe: Replace an array of 1 with a variable
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
index 5eed4c824a53..6f3fc4b30fba 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -204,7 +204,7 @@ struct goldfish_pipe_dev {
 	unsigned char __iomem *base;
 };
 
-static struct goldfish_pipe_dev pipe_dev[1] = {};
+struct goldfish_pipe_dev goldfish_pipe_dev;
 
 static int goldfish_cmd_locked(struct goldfish_pipe *pipe, enum PipeCmdCode cmd)
 {
@@ -563,12 +563,12 @@ static struct goldfish_pipe *signalled_pipes_pop_front(
 
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
@@ -606,7 +606,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	struct goldfish_pipe_dev *dev = dev_id;
 
-	if (dev != pipe_dev)
+	if (dev != &goldfish_pipe_dev)
 		return IRQ_NONE;
 
 	/* Request the signalled pipes from the device */
@@ -671,7 +671,7 @@ static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
  */
 static int goldfish_pipe_open(struct inode *inode, struct file *file)
 {
-	struct goldfish_pipe_dev *dev = pipe_dev;
+	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 	unsigned long flags;
 	int id;
 	int status;
@@ -761,7 +761,7 @@ static const struct file_operations goldfish_pipe_fops = {
 	.release = goldfish_pipe_release,
 };
 
-static struct miscdevice goldfish_pipe_dev = {
+static struct miscdevice goldfish_pipe_miscdev = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "goldfish_pipe",
 	.fops = &goldfish_pipe_fops,
@@ -769,8 +769,8 @@ static struct miscdevice goldfish_pipe_dev = {
 
 static int goldfish_pipe_device_init(struct platform_device *pdev)
 {
+	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 	char *page;
-	struct goldfish_pipe_dev *dev = pipe_dev;
 	int err = devm_request_irq(&pdev->dev, dev->irq,
 				goldfish_pipe_interrupt,
 				IRQF_SHARED, "goldfish_pipe", dev);
@@ -779,7 +779,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 		return err;
 	}
 
-	err = misc_register(&goldfish_pipe_dev);
+	err = misc_register(&goldfish_pipe_miscdev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to register v2 device\n");
 		return err;
@@ -828,18 +828,16 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 
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
 
 	BUILD_BUG_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE);
 
@@ -889,7 +887,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 
 static int goldfish_pipe_remove(struct platform_device *pdev)
 {
-	struct goldfish_pipe_dev *dev = pipe_dev;
+	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 	goldfish_pipe_device_deinit(pdev);
 	dev->base = NULL;
 	return 0;
-- 
2.18.0.865.gffc8e1a3cd6-goog

