Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8Js1Ox1kHluUYgAAmS7hNA
	; Mon, 11 Jun 2018 12:00:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D185F607A4; Mon, 11 Jun 2018 12:00:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRJEZYKj"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 922B1601C3;
	Mon, 11 Jun 2018 12:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 922B1601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933411AbeFKL7U (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:59:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50808 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933341AbeFKL7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id e16-v6so14167872wmd.0;
        Mon, 11 Jun 2018 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mpZ+drn6cacujdHGq6SRB8FaD877hKNyBjtFWIkRDpo=;
        b=XRJEZYKjiTiIlsIDlvjyeTVe9QvCOck9Kc8zXGMZhrrUl/nl90oQ75MLfml6Qm/x7L
         q2XPfuLH9fl/dBhwroJGrgy3XogkL+xWAqniKHmH+ZL8w4bJ6zjnYAgRCW3YIWUbKsBu
         Vvngd2sDtYBi1bkchQXP8qtiI7KeMt1eE9MdaEU4BuwbtRFd4tUP+8f3U7bBOKF/4XU8
         mVVwV9UGi9eB4iGCoRwla9QBHBOwLrNUe52ZKA6QRu/NDpv0pRKBMV5tqloN43dHvbgP
         yRjQANnaPtD5xSiC9ejh4HVREqqWPQzjtj1rIUqoqxfrFJ3JDopvfoEJtF9GlMiQZGcq
         yjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mpZ+drn6cacujdHGq6SRB8FaD877hKNyBjtFWIkRDpo=;
        b=poFqAoQeS0H5cOVJgzha08kLQ79ys3n/Wu892yXpMXZKDc+oesBsNRRtawGBp8SmEe
         hfdVq42uN3O1pw0s7/uxn1nRsvxyhx+6DMdVYS7DJDdbZ8KM9K2ge+75R0RMF0Giq7zM
         vxmF+JlJiq9bpOefMcnqg/BRfA0qHVsPkTmKH2UnQo4fCZhF5+APewJMP3NbJ8ni97mm
         HOqAP7ntk2+Cl+LP3wGaBgE3eerXv8j7PKNUyUUlkCniZNswnfWVPww9e7qbQxC1OrlJ
         6r3iQv/nSlXC47XKKc7V8YwtOhCE3uz3pth82x0lJASv26Cx89TxPt0rAVKa6qO/0ft4
         PXvA==
X-Gm-Message-State: APt69E3KrIpcq4Dy/7NgO4m/bpzTahr90/xTK5nxTTRsuH3/GSsjOlNm
        6TC+mzkNqi9SUPtIss4CdswYErN8
X-Google-Smtp-Source: ADUXVKJit7oWv+7YRBJux/hSRDIyJq5OENeJvtSLsurYBGjzHR0bXRUoLJQc4dz3pQzwlcIJ0Cq2WA==
X-Received: by 2002:a1c:4189:: with SMTP id o131-v6mr7483171wma.7.1528718351340;
        Mon, 11 Jun 2018 04:59:11 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:10 -0700 (PDT)
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 06/14] mfd: da9063: Replace DA9063_NUM_IRQ with ARRAY_SIZE
Date: Mon, 11 Jun 2018 13:58:43 +0200
Message-Id: <20180611115851.1987-6-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace DA9063_NUM_IRQ macro which is not used anywhere with
plain ARRAY_SIZE().

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V4: New patch
V5: Remove DA9063_IRQ_BASE_OFFSET
V6: No change
---
 drivers/mfd/da9063-irq.c        | 2 +-
 include/linux/mfd/da9063/core.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index 044bd867f540..579947f83486 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -94,7 +94,7 @@ static const struct regmap_irq da9063_irqs[] = {
 static const struct regmap_irq_chip da9063_irq_chip = {
 	.name = "da9063-irq",
 	.irqs = da9063_irqs,
-	.num_irqs = DA9063_NUM_IRQ,
+	.num_irqs = ARRAY_SIZE(da9063_irqs),
 	.num_regs = 4,
 	.status_base = DA9063_REG_EVENT_A,
 	.mask_base = DA9063_REG_IRQ_MASK_A,
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 8e6684d884e0..260cd5834861 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -72,9 +72,6 @@ enum da9063_irqs {
 	DA9063_IRQ_GPI15,
 };
 
-#define DA9063_IRQ_BASE_OFFSET	0
-#define DA9063_NUM_IRQ		(DA9063_IRQ_GPI15 + 1 - DA9063_IRQ_BASE_OFFSET)
-
 struct da9063 {
 	/* Device */
 	struct device	*dev;
-- 
2.16.2
