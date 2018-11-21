Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8524EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECB320C01
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGLtyhyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECB320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbeKUXco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:32:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37171 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeKUXco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:32:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so5464856plr.4;
        Wed, 21 Nov 2018 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JBPlKFNUjgEohKBzk/uHnMcVWPHbdilJKJYsUEFsY2s=;
        b=eGLtyhyCEetn0UQ5IMbyl2U8vJ+iuUgHNEuhxg0bqOqsoTNzDsoAiNyi1x2zZRVpdR
         SyDT7wUanN2pd5sjmeV4IS3vmoNltEvl3Gi/Dh3QGjduICu4rv20eJ90POpWjMojiTcq
         +d1qEM0mbnfiviw68foVeR+TyC8Z2MqoFTnT/hS4M7lC23Kl9RZuDC18a5qi+hf1yZMP
         eHv7GkV/D4BpSiOH6jQM/CSf9nnK12Sytvsbj88veeBnx3TCT3l5MN2iSKtA66HSWglE
         jA1g5PlDwNzt7TIkLeyngQ47tr1DnQfqcJtGe0qlLwI78A9FPOobFHbP9a2Tuy/w+PKg
         xEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JBPlKFNUjgEohKBzk/uHnMcVWPHbdilJKJYsUEFsY2s=;
        b=Pje4aLLMbXOdjQN1UC1U27+2i84ut7P9OEHkQjTtSh2ikueTYGSKfXwz+YHjvXibJH
         rK+Cfy3/bISawF+UpTAo0TeCjMY6JiW3id3ckfVu5LRGYmHg1UVi1WjWHdtKvcVelFdk
         b1s3Ew1QkMQRXc8ymLet6qtB2SI/GxNSCEbEuG0i9Vny666NdhUCCxkWMmvwStcA66qV
         0JEt7OPnLaHp+Y4mG8smgagGBmgZ5GeI1nJi+iqVyFnn/9A4vUUeTwMbTDkCoAjXGB4d
         xODCKbQ/OaZE2YjnfKcInND6vloALw+2bulyWzWqEuOtiVKaTRgarSMLmPdKzRguE1kn
         v8ew==
X-Gm-Message-State: AA+aEWZbUGZxSHwgqYPOiEUESS9rEX72FGv9vwm014HbqgJup/3XIyVa
        EU8n5yytsi1LF2rTZluN0Rs=
X-Google-Smtp-Source: AFSGD/XhpMCS3wsFaohMqX4HNj3h0fkRjnVqddiaqD59ljIqI7yXj+UH1+/b0UhvYKNuUadSuK6OVA==
X-Received: by 2002:a63:e001:: with SMTP id e1mr5912404pgh.39.1542805107867;
        Wed, 21 Nov 2018 04:58:27 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 137-v6sm53626433pfz.103.2018.11.21.04.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 04:58:27 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net, yuehaibing@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] net: amd: add of_node_put()
Date:   Wed, 21 Nov 2018 07:58:24 -0500
Message-Id: <20181121125824.22168-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/net/ethernet/amd/sunlance.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index b4fc0ed5bce8..9d4899826823 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -1419,7 +1419,7 @@ static int sparc_lance_probe_one(struct platform_device *op,
 
 			prop = of_get_property(nd, "tpe-link-test?", NULL);
 			if (!prop)
-				goto no_link_test;
+				goto node_put;
 
 			if (strcmp(prop, "true")) {
 				printk(KERN_NOTICE "SunLance: warning: overriding option "
@@ -1428,6 +1428,8 @@ static int sparc_lance_probe_one(struct platform_device *op,
 				       "to ecd@skynet.be\n");
 				auxio_set_lte(AUXIO_LTE_ON);
 			}
+node_put:
+			of_node_put(nd);
 no_link_test:
 			lp->auto_select = 1;
 			lp->tpe = 0;
-- 
2.17.0

