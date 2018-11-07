Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F9CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDA72085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDA72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeKHBt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:49:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38252 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeKHBt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:49:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id v83-v6so14267433oia.5;
        Wed, 07 Nov 2018 08:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PlaGOIA5y0amjbVVpDH+1wHg6k2NhdPenVww8rvvdG0=;
        b=a5oJ6vFoKvNcpdE1sqW/WIl4IgSvi4pPLm9ASey5Cd128INihSIsZhOHwTf+vm2slc
         iLn2QYm5X2MQWV1YdLy0yiMCe28Tp9nl6kR3saWimdA7psYbBKC0FAjCgFLFdEws0Ee9
         qrZBrzwNZQzk1HNZOVLsJKmNStD354scanZMbHs/XzfqNzAfwtzRruhAZqiCsjgu0gTy
         A1NvL36x/jwXJnHNqAu4rn5uFT4juygZ/szS6ir6h8TaOk59XPlD8iHV3De7NZN47ZZp
         V0o1hcvoF2EhCzr3apnSGc3LPxTs2AS2ECbVxkznTlipXoep9Y8K/IAN1B5qdJ+wVYve
         DibA==
X-Gm-Message-State: AGRZ1gJCVCLdgWiqimsolrtlTIaWfwQFsN1HXWsg2VuuftMxUH8yALSj
        cY2X4m5vFBMasG5XaHlbzxmVXrE=
X-Google-Smtp-Source: AJdET5ev5ixopMuSejm1veOAUQBXGNY78gg+eS/lA47DZ0yb/b482bf+23gTSPKVP0Y0jp4JHn9Xjg==
X-Received: by 2002:aca:31c1:: with SMTP id x184-v6mr453140oix.213.1541607506397;
        Wed, 07 Nov 2018 08:18:26 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id l6-v6sm381995oia.46.2018.11.07.08.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 08:18:25 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of/pdt: Remove unused of_pdt_build_more function ptr
Date:   Wed,  7 Nov 2018 10:18:24 -0600
Message-Id: <20181107161824.30839-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users of of_pdt_build_more since 2012, so remove it.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/pdt.c       | 5 -----
 include/linux/of_pdt.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index 013e65de074a..4fc0fd96ed04 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -21,8 +21,6 @@
 
 static struct of_pdt_ops *of_pdt_prom_ops __initdata;
 
-void __initdata (*of_pdt_build_more)(struct device_node *dp);
-
 #if defined(CONFIG_SPARC)
 unsigned int of_pdt_unique_id __initdata;
 
@@ -208,9 +206,6 @@ static struct device_node * __init of_pdt_build_tree(struct device_node *parent,
 
 		dp->child = of_pdt_build_tree(dp, of_pdt_prom_ops->getchild(node));
 
-		if (of_pdt_build_more)
-			of_pdt_build_more(dp);
-
 		node = of_pdt_prom_ops->getsibling(node);
 	}
 
diff --git a/include/linux/of_pdt.h b/include/linux/of_pdt.h
index d0b183ab65c6..89e4eb076a01 100644
--- a/include/linux/of_pdt.h
+++ b/include/linux/of_pdt.h
@@ -35,6 +35,4 @@ extern void *prom_early_alloc(unsigned long size);
 /* for building the device tree */
 extern void of_pdt_build_devicetree(phandle root_node, struct of_pdt_ops *ops);
 
-extern void (*of_pdt_build_more)(struct device_node *dp);
-
 #endif /* _LINUX_OF_PDT_H */
-- 
2.19.1

