Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F40C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D8B20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="f2VVGDA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAVKSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:18:18 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37354 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfAVKSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:18:16 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so19338522iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 02:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=F14VHg3Q6CcoagSvNNNrRfEviAiUaeLFCtdR36qYta8=;
        b=f2VVGDA1hSd/nJ6UptoYZXAWbwxFmQdq+WakgpQ0iTAqmZkMSHkqup6lTjcQsty5UF
         a2+wIU5cCe9jU2y05niFdZQznFlIhKDqzqvZvM/2oRzHBdtrLPsZVSOjwiARElRSAa8F
         ag7uhVTXp/xgyt/psPZQd8ZKRZLEjFHJtjHjluEwXyeI/CPrjcLiRDmssaWLMzKzc4du
         5YFeshWpL4xy7EoGwmBdDkHAOerXxbaRUpJQF1nXvSyZNyrTuH/FkeI4z36RgUFAkZfX
         D4kSlz9m376vBv7WymCmaAQ1vpDZ7LaY3+Q6K53Yte3a7t6AYE7m0+mj73BKQxyPZrI8
         hrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F14VHg3Q6CcoagSvNNNrRfEviAiUaeLFCtdR36qYta8=;
        b=WbC9uNKRCv+3lEtQEWLetgr5mX+MrcvoVr1AQJBkQD1//bkd3LsTuZwYFS4RjnBThj
         7voCMNS3GGioR4WRzWf+Xq1NSL8g14bJA91t5MresQ4nbXl/4HTrWPuwYYiCt4qEV22T
         j6ggvvh/gtKn6sRf6PZVxE7yjompdzwvxnJp4MeuXwvCzmXppwdOM+NlRxeZKTn1S3W9
         w7PKCZADBcrUI3C23/cRHvOVesj5vUcO3PoewVCBNqaEM1UusZtf4AumrhQ6VWYrM5/+
         /Yh2CATwlxYcba5QgZBIbe9+XtwFSOlEqZXOniSD30jSlN6hyUYzGDMFU9Y8d4Doevji
         RGjA==
X-Gm-Message-State: AJcUukd+3JVA5ogWhGcnmW7APuJ+mC7CSsueo9l7wo1ozXF15P5FSbQS
        ArwI9YIhAMv3lv5eDvpJTzQyFw==
X-Google-Smtp-Source: ALg8bN5RojFYpIuMNElloI1m/DbnckjegUxWZjF95Ydq8hEQPwQBu1KoZz/y/8IanNdcCgiCabg0Sg==
X-Received: by 2002:a24:7c58:: with SMTP id a85mr1775263itd.9.1548152295522;
        Tue, 22 Jan 2019 02:18:15 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 18sm7595496itk.28.2019.01.22.02.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 02:18:15 -0800 (PST)
From:   hans@owltronix.com
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     javier@javigon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: use vfree to free metadata on error path
Date:   Tue, 22 Jan 2019 11:17:59 +0100
Message-Id: <20190122101759.31201-1-hans@owltronix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

As chunk metadata is allocated using vmalloc, we need to free it
using vfree.

Fixes: 090ee26fd512 ("lightnvm: use internal allocation for chunk log page")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 1ff165351180..1b5ff51faa63 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -141,7 +141,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
 
 	ret = nvm_get_chunk_meta(dev, ppa, geo->all_chunks, meta);
 	if (ret) {
-		kfree(meta);
+		vfree(meta);
 		return ERR_PTR(-EIO);
 	}
 
-- 
2.17.1

