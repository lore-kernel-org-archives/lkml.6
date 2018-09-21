Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3B2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9D21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF5xKHDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB9D21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389547AbeIUPcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:32:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50409 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUPcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:32:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id s12-v6so2388048wmc.0;
        Fri, 21 Sep 2018 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kx46yteSVNa9QzJTKqVKU9Ad4J08Qp7uAUEIe/0jHx0=;
        b=jF5xKHDevb1GkMQzfW9R9PaeJYEE1U/LR5plHhM8PMIdqjjpFxn4t8kcId0NzhUHK9
         xNUKx3j6wXKlc1b0e5LoQhljb+0bNHJ3YAjkyh4Eba+4RNXuABZJxWb/cBHftUQXh2+5
         cEtbWfy/KGrVe8PiY9I6DDuHoKn2aKWPpgc8aiPhDZYNwUdpnMhK6juSQIqv0zMCjmP2
         JdHzCctYFeciRmGugwBie7oRLSYLhNRORjg0uYSeKFdbS32/4jm2X+ctp/HfNQAg4cBB
         kYAFIFnTo0ygAji1MMLUvRz+BbiHV8XB+zS52jjVzZkVXMknrTMlSqjVwIaBwQ7CEHWb
         YYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kx46yteSVNa9QzJTKqVKU9Ad4J08Qp7uAUEIe/0jHx0=;
        b=VI5gJ1sPcjw1MPOPvFJa5FgUVL1W9RFRCotrlnpYBvtG/Sb+33N4FhBHPDCOZWmqV+
         OvXv21q4yI7k5RN94BQMXImmADTXvp5Q2hAtU1jVk/zCZcq22JBGGsc+F7zlkPDzGVNM
         F4ox2v0cH8eko/uvfmeeJjp4kkFpl8eWLz3pQNgx/ZE1E5r8GQ1J7RBTPSSaeO+o0Pbo
         F6jBfT089ePoQpVv0mejAYONzBnbYRywm+F5d0oHOTBfx/gJn8kV1f2g2xasNCStL/XG
         wapZxz/Qgd0v081/oQGyasFXxh6d4zg39FIJX/FBtD5Dd7D4yAzP8wfNafj9wdLDf+S4
         ubjA==
X-Gm-Message-State: APzg51AApawsXGi6c0oPLrSVXWks+ZsJMnLxBIFPddRUpQAcdbVbWstM
        kw2O0k5JGskJfeis4lxgNEM=
X-Google-Smtp-Source: ANB0VdYBqBIlHKtpj3o+085FfP0MizqrwoPmWSQ4vTZBPwHruLd9fEWnkxF6hXSuN/iZ0q9UgWR7gA==
X-Received: by 2002:a1c:8e81:: with SMTP id q123-v6mr6148078wmd.56.1537523058900;
        Fri, 21 Sep 2018 02:44:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t20-v6sm3547091wmi.24.2018.09.21.02.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 02:44:18 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] net/mlx4: Use cpumask_available for eq->affinity_mask
Date:   Fri, 21 Sep 2018 02:44:12 -0700
Message-Id: <20180921094412.15547-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the address of a pointer will always evaluated as true
in a boolean context:

drivers/net/ethernet/mellanox/mlx4/eq.c:243:11: warning: address of
array 'eq->affinity_mask' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (!eq->affinity_mask || cpumask_empty(eq->affinity_mask))
            ~~~~~^~~~~~~~~~~~~
1 warning generated.

Use cpumask_available, introduced in commit f7e30f01a9e2 ("cpumask: Add
helper cpumask_available()"), which does the proper checking and avoids
this warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/86
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx4/eq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
index 1f3372c1802e..2df92dbd38e1 100644
--- a/drivers/net/ethernet/mellanox/mlx4/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
@@ -240,7 +240,8 @@ static void mlx4_set_eq_affinity_hint(struct mlx4_priv *priv, int vec)
 	struct mlx4_dev *dev = &priv->dev;
 	struct mlx4_eq *eq = &priv->eq_table.eq[vec];
 
-	if (!eq->affinity_mask || cpumask_empty(eq->affinity_mask))
+	if (!cpumask_available(eq->affinity_mask) ||
+	    cpumask_empty(eq->affinity_mask))
 		return;
 
 	hint_err = irq_set_affinity_hint(eq->irq, eq->affinity_mask);
-- 
2.19.0

