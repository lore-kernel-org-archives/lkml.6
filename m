Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E65C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81D7206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEfNJo8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81D7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeLCO1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:27:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44700 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeLCO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:27:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so6542033pls.11;
        Mon, 03 Dec 2018 06:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2WLebY7xqUbwIPvtMqD+4HTo6gWucwdphTz+WLkITYg=;
        b=fEfNJo8XL8mYdFaEm4rMq2DcyclTdnjEZRHfahNQ8ciGCc27e8Pj+SXnAWw2ZGcQA0
         qryZ1N/SzcZ1zW+Ll4iEoBS/izaHI53k5o1//2TwjaeHsNEUeCVip9xks0gLKxQiaaTF
         65mdzmFm6wDnDpfuQnQxlQVMUPIdF6J45eIv3xu3RnQqPD75OfxoymctHFq8XoQrnUpO
         BUX2lJFkFz7pJEhuZRcVuDMurHYbH9St+IAEWjRIb2+bog9NajoBL1NmoJQq/d013859
         Hozaqqqqd/aPONTpgJZtcKrbtQ4GPRzPTv+g2YzWRuPQEnr/WnOn7Z7ctBFz+iYWrGBR
         EPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2WLebY7xqUbwIPvtMqD+4HTo6gWucwdphTz+WLkITYg=;
        b=KQlk0J6aVcuJbN5dSg04UcVIDlHUAGpnXEpBdlVz3EYWRNYwuoxhBdDbcgQh1Aa5Ng
         MCbrSJsog4uSmFEG3JPEXkPJWgZRZl+j4bxZvLo9iWIqpXEh1r9CAuREHTLiJ6RrGDQn
         N7fsz/1eL/B8SaU0xVLku3jpId5wWcuZrGrYP/1FXALjHB3HmDTPWIfMDXalIq3hOvc6
         97ouiSUxwSooj3ixjbm2ZTpkhw9VRbnhRsT38zDlEeabSzsq0jhY9XyGoelwEZKeX/bC
         MBNKUTRBSQ0SqQl5YCOXSs6GSo1nxNuAXQtOX4m1nI2Et5rNXy+lKkMxyZ9eXI0y9Qd1
         FeMA==
X-Gm-Message-State: AA+aEWZxq/nkIyVn7tGbFBExQzKIR4cdVIdqr3SVJbu1lZ+hd7kPMuM5
        +X8ytc4pGXoCy5+yiFsiQkI=
X-Google-Smtp-Source: AFSGD/V+JejHY7H1ycVH2XRts6GlQjDexS06b3yS5DSRNUdvXDCgkiPLShUU5K8ykt+4Gw5fwWb/aQ==
X-Received: by 2002:a17:902:981:: with SMTP id 1mr15671883pln.142.1543847200885;
        Mon, 03 Dec 2018 06:26:40 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h15sm19720294pgl.43.2018.12.03.06.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 06:26:40 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net, stefan.wahren@i2se.com, joe@perches.com,
        michael.heimpold@i2se.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] net: qca_spi: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Mon,  3 Dec 2018 09:26:38 -0500
Message-Id: <20181203142638.13178-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/net/ethernet/qualcomm/qca_debug.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethernet/qualcomm/qca_debug.c
index a9f1bc013364..264ddc0159ec 100644
--- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -125,19 +125,7 @@ qcaspi_info_show(struct seq_file *s, void *what)
 
 	return 0;
 }
-
-static int
-qcaspi_info_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, qcaspi_info_show, inode->i_private);
-}
-
-static const struct file_operations qcaspi_info_ops = {
-	.open = qcaspi_info_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(qcaspi_info);
 
 void
 qcaspi_init_device_debugfs(struct qcaspi *qca)
@@ -153,7 +141,7 @@ qcaspi_init_device_debugfs(struct qcaspi *qca)
 		return;
 	}
 	debugfs_create_file("info", S_IFREG | 0444, device_root, qca,
-			    &qcaspi_info_ops);
+			    &qcaspi_info_fops);
 }
 
 void
-- 
2.17.0

