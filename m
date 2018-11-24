Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05890C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B576120865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzRYWg9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B576120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeKYBNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:13:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40972 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeKYBNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:13:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so11808492plm.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 06:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BwRpYuYqxl5ddayUH8xwS5LoTS2f3F8bGtPmVx4MF1Q=;
        b=PzRYWg9dEAuw5SYrf8bVf6U+3V477Xj8UvSxK4WsCSCjPkjyYxQBWrj2TEPEOgu+pM
         JRMlrMboJBWNeK3FCPdMrq3PNE0i+IOhwBS8txFBaX9SrIjh3dWiuUZCqIZV/sE2YIi9
         A27VZercKDQnUzo+9O/IYDMKzLKffXGxKQDszg6gVmA/yIoAZwK1tgP9uSRXsOyJ+N+t
         ls5lU4sVa5rxIIyrxRdk/M4wZtPgIYEOyRi7Wq/YrN3sAXaDfGheXqt69vnXuF+MdMz/
         2TvBvDa6yT57vek0uKAEHbnLx1NJoUgF5DQuGoDUrhVI+qFUPlMPy/AOn8iLzkqWd5/+
         +xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BwRpYuYqxl5ddayUH8xwS5LoTS2f3F8bGtPmVx4MF1Q=;
        b=r2uF3PwP2t1voRgKsAwzY+Bmqs70rC6X5bZPTaofbY0c83d1BJPqPC8Oc/AtrqLP7P
         YYdsXxSS/OnELP8BdcuQi63e33CCKsFurhSFvR1FE42oiUaLUN4M/qw+TgSNWrjnmiDc
         m1Q8QcpUCB6XJE1qrJFcCvKOUvdLzOo/Ldi99BKH7lBY7BCppQQ1p7211Yy/5A3fz5rV
         nF7JMtBC9HFPzZoj7oH0Ce9/S2yeNjj1FpGR3Q2Uutpgob+DFJmu0WlU3Q9eiOH/XkQ3
         hjxxUH7BaVRQlnCz4sMsuc21/MOgfKLPKpi0+BcU3XWnotkwZY67X9GR9RhEQ8FGcSaC
         TA2w==
X-Gm-Message-State: AA+aEWZXCU2v40giFyfIin8CmW21Mmfhxa7e7A2ZjPMajtUVJjurv90p
        t/13Ohx8TJAZXfOpm85lFS4=
X-Google-Smtp-Source: AFSGD/UHWsv2GGRBw/8PpW2cxFLb07v4qWLL4sgFTYmA3Hg8nZCCvCy3j49MPXbxC9aDVfoUKusTlw==
X-Received: by 2002:a17:902:c05:: with SMTP id 5mr11754935pls.155.1543069512190;
        Sat, 24 Nov 2018 06:25:12 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x7sm66491171pga.68.2018.11.24.06.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 06:25:11 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] devres: no print device_node.name in devres_log()
Date:   Sat, 24 Nov 2018 09:25:09 -0500
Message-Id: <20181124142509.28822-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
avoid to printf node name.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/devres.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 4aaf00d2098b..34c07e9faaf9 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -52,8 +52,8 @@ static void devres_log(struct device *dev, struct devres_node *node,
 		       const char *op)
 {
 	if (unlikely(log_devres))
-		dev_err(dev, "DEVRES %3s %p %s (%lu bytes)\n",
-			op, node, node->name, (unsigned long)node->size);
+		dev_err(dev, "DEVRES %3s %p (%lu bytes)\n",
+			op, node, (unsigned long)node->size);
 }
 #else /* CONFIG_DEBUG_DEVRES */
 #define set_node_dbginfo(node, n, s)	do {} while (0)
-- 
2.17.0

