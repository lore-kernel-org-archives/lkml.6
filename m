Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A81CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8A320853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nY85CEiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8A320853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeINXI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:26 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56342 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:25 -0400
Received: by mail-pf1-f201.google.com with SMTP id a23-v6so4951147pfo.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mwIMz8FNHqYXOj3Q67DF3CFhIjF6xKD9MSrMXBKndqg=;
        b=nY85CEiW9Hjvt6I7lHjhegjUG6OPpd2CWSiY94pbC3CecUVtGdOcL7s1bUQl8skP9M
         XCnOsEIxkyOB3d9kQoWpT2gIZBz/d59qrRwn1KfYVWu62l6+byx2sfGa/kAzt7GInjWh
         q4zCFhhFUqBP5rmWyVUl2IMtIFKSMwN+CdILBpuUUM7HDK6uC4mUklTELnrJQczjPTET
         olO/I6+OTIlbkuQxhjQ+F1tmzwENET/DoNY3X+mwRBRXRkKgRgT8wzLhXam3mScQcRVH
         UC2Sk3cX2fDaATI65QTAYRCplphBm+4OHCAMBUfjXwcr4v7yPYKTd2mi26VeBsppod0t
         Dw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mwIMz8FNHqYXOj3Q67DF3CFhIjF6xKD9MSrMXBKndqg=;
        b=JfChfYRBG5NYCL3LOsfHAJ4wAlw6FeAN3gcPAKtxLR5W0hMW5w8O2n87BPnGnPehOa
         5E9OpHu0yk9rY2k/YmCeVgUkEE6X5NDAgl+aPInTwW6IHI73wBAjuYirfIuY2ISujWDB
         3Bs4LiUDoKnNoOPje8NujWbyh3HNl7ZpNW2nQI5GeNMdAbl0UWdu9o3Q2L8hXb2H0LZR
         uBwjDusgkkbxWNa6M5ebfyD8ThurFprCButtn5ZTDatuFprbd4ygRvfxvUpoe9o1eiv1
         gIiVLgf+esHxEF2DaCpOEkajAIYIIJdrIGA7MRPeq6sH9szQJwcBQSvE1L4hyT8RJ5ra
         vrvA==
X-Gm-Message-State: APzg51CK614Zf3X9msGn6Q0bLoxZ97M+jJmgCmLGnjZYjTdocS+c4wyD
        slsuhZBvgemdX8XF+AYACWQeBv9K
X-Google-Smtp-Source: ANB0VdZIGDoECf+9qeg4g5TsjqofiLhNNALC+rM1XvFrVkmjJSJXAPMAx867RIdJe4mmM5BNO9Ty3/X3
X-Received: by 2002:a63:64c2:: with SMTP id y185-v6mr653886pgb.140.1536947571981;
 Fri, 14 Sep 2018 10:52:51 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:16 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-15-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 15/21] platform: goldfish: pipe: Rename the init function (add "v2")
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

This is the v2 driver, in the next few patches v1 will be
introduced.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c    | 2 +-
 drivers/platform/goldfish/goldfish_pipe_v2.c | 6 +++---
 drivers/platform/goldfish/goldfish_pipe_v2.h | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 802bbf0d6d23..8a65cdfd6555 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -108,7 +108,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
 
-	return goldfish_pipe_device_init(pdev, base, irq);
+	return goldfish_pipe_device_v2_init(pdev, base, irq);
 }
 
 static int goldfish_pipe_remove(struct platform_device *pdev)
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index 6a8641c7c36e..9fa5136be909 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -1121,9 +1121,9 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 	writel(lower_32_bits(paddr), portl);
 }
 
-int goldfish_pipe_device_init(struct platform_device *pdev,
-			      char __iomem *base,
-			      int irq)
+int goldfish_pipe_device_v2_init(struct platform_device *pdev,
+				 char __iomem *base,
+				 int irq)
 {
 	struct goldfish_pipe_dev *dev;
 	int err;
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.h b/drivers/platform/goldfish/goldfish_pipe_v2.h
index 679d863774a8..8be09ae6d3ec 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.h
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.h
@@ -17,8 +17,8 @@
 #define GOLDFISH_PIPE_V2_H
 
 /* The entry point to the pipe v2 driver */
-int goldfish_pipe_device_init(struct platform_device *pdev,
-			      char __iomem *base,
-			      int irq);
+int goldfish_pipe_device_v2_init(struct platform_device *pdev,
+				 char __iomem *base,
+				 int irq);
 
 #endif /* #define GOLDFISH_PIPE_V2_H */
-- 
2.19.0.397.gdd90340f6a-goog

