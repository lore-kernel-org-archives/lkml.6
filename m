Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90526C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594F0214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5TsPJqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594F0214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbeKVB3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45238 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbeKVB3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so5084980edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jp/LfLaAJfVo5R8t93ODciTQnG5UQq2Jvgw4KX1TnZ4=;
        b=i5TsPJqDkdyxGcRcjufnaqTz0g2LrPcualRnmJEKzcMprUOJPTtxFn5AJMOeQ+ttOg
         6jDFqqWEwBOU18TIooyYZAO3L1XZK7Fd6E2iqEKDlJde3egOvLe7K3+XANtznGRbBehy
         Vkn9VkswvckosD5e1U8vyd3zGwcJ7+jok6qvflCS76YhPgm9KzU8gPIg/n1lRW/r0D1O
         sb7RBqYN6gHBt3gbB++4soc7hrnkftLptvZFvzqX5HiY8uWCPwPz+EXG0jnEtLqLmd+s
         76MMZ9d1dCSZ7nrjRhlLHyQvz5Ig1ECEvQasx1+DaCuXb02U8UG14//AbnQpNFL33pDb
         J6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jp/LfLaAJfVo5R8t93ODciTQnG5UQq2Jvgw4KX1TnZ4=;
        b=FJpY5V5FRICtlTnafau0GEEcrqWbxmgQdWzSH4yRnnigpNjY8CuW0HKet/nrdVm+P/
         ssfme9raJ9Jn5AFOuDrJB2vqsedOLyE/xFQB136WA+8YVXeTHPNBLG7R4pwQ6x0WLGG3
         5sWnBqvqe5jK6GuJi3pCW+Ov0jPBxIvGQ3Gs41JPyN1Cd8UFPUuBWACO3gUx6Jg7y4xw
         7Q+GkEMTYhfz5+Tknu8KkOOf+S9u+j/UKLgLIpD+Jce2FpPbHZMVsnLVboZYGmp7QUrN
         f13XB/WpLCeqPfGwfryM9Usr5BxAliXhEig6BAN+r7egeEmBaADlF5wVYRej7URarIKL
         5q2A==
X-Gm-Message-State: AA+aEWYeTmXyAwF0yHWLgtM4hFtaGjbEZLN2cD4N03FklP8UMC9eR3Wo
        o9nC8wJEgctNLEzJ2MT6MKlzBEOz
X-Google-Smtp-Source: AFSGD/Vl2mlfbiq5YDIqzii1acsiBgbj/uUH7gmvYFTYAtT+JHwbHYUelVr7ELvzvHJuicK0Ehrz2g==
X-Received: by 2002:aa7:d817:: with SMTP id v23mr5918483edq.255.1542812077046;
        Wed, 21 Nov 2018 06:54:37 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id n29sm9873029edd.40.2018.11.21.06.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:36 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/19] mailbox: bcm-flexrm: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:14 +0100
Message-Id: <20181121145429.7582-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121145429.7582-1-thierry.reding@gmail.com>
References: <20181121145429.7582-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index d7a8ed7d8097..d713271ebf7c 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1665,7 +1665,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		mbox->controller.chans[index].con_priv = &mbox->rings[index];
 
 	/* Register mailbox controller */
-	ret = mbox_controller_register(&mbox->controller);
+	ret = devm_mbox_controller_register(dev, &mbox->controller);
 	if (ret)
 		goto fail_free_debugfs_root;
 
@@ -1691,8 +1691,6 @@ static int flexrm_mbox_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&mbox->controller);
-
 	debugfs_remove_recursive(mbox->root);
 
 	platform_msi_domain_free_irqs(dev);
-- 
2.19.1

