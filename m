Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0B7C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F1F21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SL2goKm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F1F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeJDAHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:38 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:43022 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:37 -0400
Received: by mail-it1-f202.google.com with SMTP id w137-v6so7596202itc.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=56fpYdwjuLAWY1teXB3kj1csxagHoi/tyzvErzQJQaw=;
        b=SL2goKm0UC4XHYXFycRhuRKCdtMasOlcm4qsEfftdpfjIJW4Qfp3CaS/q5e0DUsCPX
         9h8EIBrNP5AU4Zcl8fdWNv3arfOKWot5tqmQPxDzvvO4rZ19Et5ii+WQspgDPwvbRAym
         286TENEvrCviVKjHY1jKtCS5ogpFEFomTvRr/QPNYcLalYUJr4nMSCzC4fGrvERj6jcD
         i/z1pS1z5XkPNAy2s9ZrKI4PRIKmzQBuuwTmh7/xzGZSups1VN7ioYQKoPqBzuRZUbiu
         kY5Rn/CH9qM/Th5oZgq0PaPkeVrgQ8Wg8FCMUMSc2rGqaxvnyA41eLE9XVHKlJG2p4jD
         Yi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=56fpYdwjuLAWY1teXB3kj1csxagHoi/tyzvErzQJQaw=;
        b=Smi9fYIEL50m4zM9zfG9F6HUWAXZsB8F3+HmJlNT4n48RNSUE4zKEJLaIFPNwbGRuq
         Ul0lHOCeSdaNk70jvuMaKSSi3g6CKUi9yMz2fhBPxDHrSE2cQ1751NcbQvlp2salNgbn
         MouGAG+KXquls6TLxj15q5qFqDFtQdWIhp1KamVIEdjPX0GM8fTLfbhX1IGIblAL4fUL
         VDuS5K7xE1IDRuvHEC/icTDK0a2LKoSU7ApzJhsdeHsQKw1eKmIJoqP/FDD+iiTGmxs0
         Vgv+0EBCfR/kR08A8ePWKYb3JH8I5uuprGiN16sRoi/Oo5Z9vfsTeC1ZuVLVGa44g5+L
         M8Vg==
X-Gm-Message-State: ABuFfoiYQ9OtQYFvJ3E3D7QBIvWq661yb1voAu1FApaqtiBrec3J3v3S
        vXv/cJbNeUKtUSPDOgd0jQXGicei
X-Google-Smtp-Source: ACcGV61FoXVamzWwSpzpI/SsN1iyjRozrwLFP8oXHeZYu81L/UC12wHzTSN/8OeqLIeD9rTHB41XJPyQ
X-Received: by 2002:a24:e48b:: with SMTP id o133-v6mr12275351ith.0.1538587099106;
 Wed, 03 Oct 2018 10:18:19 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:17 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-12-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 12/15] platform: goldfish: pipe: Rename the init function
 (add "v2")
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

This is the v2 driver. v1 will be added later.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/goldfish_pipe.c    | 2 +-
 drivers/platform/goldfish/goldfish_pipe_v2.c | 6 +++---
 drivers/platform/goldfish/goldfish_pipe_v2.h | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 792b20bdf76c..7b0920e962eb 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -87,7 +87,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
 
-	return goldfish_pipe_device_init(pdev, base, irq);
+	return goldfish_pipe_device_v2_init(pdev, base, irq);
 }
 
 static int goldfish_pipe_remove(struct platform_device *pdev)
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index 641dfdcc3ffd..9857ce07d0e6 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -787,9 +787,9 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
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
index 03b476fb9978..70bf4ec1fd66 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.h
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.h
@@ -3,8 +3,8 @@
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
2.19.0.605.g01d371f741-goog

