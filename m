Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE69C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E3620875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xn2KrZaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E3620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeFTWnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:43:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46312 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753896AbeFTWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:43:51 -0400
Received: by mail-lf0-f67.google.com with SMTP id m4-v6so251672lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=w8WXNhlTMO4iLhPPkobqVb6Lym9+AxvA55wNz7JtqPI=;
        b=Xn2KrZaYibAcL+XDYQThTmGWoM48DtEkj+He1rmmFOJ2fyWcebTjHi7LGFPFvL2gC1
         wCJyEfJ1oX9WA6VLmSEjZ3bFXAi7VMxAfFE2+ebh9WtwHHnJxowsc7MW2Y1I6lZ7mH9W
         sjH01uHKSp0I8rcXMrd0Qqb4RBPu0aB9ThRH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w8WXNhlTMO4iLhPPkobqVb6Lym9+AxvA55wNz7JtqPI=;
        b=jCbQhYeQ57FpGYk8IX+pEgGq+X/EDaZ0W+5nUo9GVN50W5jaTuTqgIZ4cubnef+I9O
         YSNXa5bsX6/yBSvEMDK4gDELLNlnHFtMX9CRBmxiT0x2VtCbT9iROuZu3+QJByBUYq6O
         sJMsJwuW9BpcvOdJAsbji3FlZ1TadD9iHFSmlnvB/w7kSI5TTjlCLkQZdxUkHHzBxP2Y
         wKmsdxxxwCmmxHxAyHQ+oy6vG9MUyfTEoRoG13rZNLMjEtf94mdjXQhsjaSF1qZT3nOp
         1OCDG8hBcq3Y3DKV+G+5oKTfwf5czYE69v7sD8QvcuxTehcg/nNbv5VnNa5wux9IJ+3b
         tbmg==
X-Gm-Message-State: APt69E0jigYkTNCTn6Ucu+jDi/bvKcqM1SFkTyz5JCki2G7RdhtQdoGp
        9NGllnGJopmwEWMg2yAc/R2W1w==
X-Google-Smtp-Source: ADUXVKIqDLU1+cjPCMQtklB5niYNrMdxsNy5zV4jFKkQbk8hugzZo938JIUCDebDQ5qNMSZpQBqg1A==
X-Received: by 2002:a2e:55cf:: with SMTP id g76-v6mr15951928lje.4.1529534629622;
        Wed, 20 Jun 2018 15:43:49 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id 69-v6sm606715ljq.89.2018.06.20.15.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 15:43:49 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: add tcp_inq to gitignore
Date:   Thu, 21 Jun 2018 00:43:44 +0200
Message-Id: <20180620224344.6425-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sha: 702353b538f5 ("selftest: add test for TCP_INQ") forgot to add
tcp_inq to .gitignore.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 128e548aa377..1a0ac3a29ec5 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -12,3 +12,4 @@ tcp_mmap
 udpgso
 udpgso_bench_rx
 udpgso_bench_tx
+tcp_inq
-- 
2.17.1

