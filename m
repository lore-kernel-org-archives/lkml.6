Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1o70Er5jHlucYAAAmS7hNA
	; Mon, 11 Jun 2018 11:59:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D688C607BB; Mon, 11 Jun 2018 11:59:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWnnAJs4"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3AC0360351;
	Mon, 11 Jun 2018 11:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AC0360351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933396AbeFKL7S (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:59:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39637 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933310AbeFKL7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so15956257wmc.4;
        Mon, 11 Jun 2018 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5t4OXh3YN7fJm225qMAwN0eYWpLsXjfBmJlsr43UDiQ=;
        b=qWnnAJs4snlwE77KEf8pulZJYgU4Bx3FYGDm3IcJ6Lf209awCG7g4A5/tfsLOFSmXI
         p2GV1qmNQQrPW0ajF5wDFLQtICXLU2SqIvzBqxtoB/rKG7lQt7GSk+/Im4bJHuZ+zXFm
         EQ8iD5gci/6ka0yKattvaQvuNXYpOiTy6Dh19xPvwVO5mMDRMrr4fh+dEoInNTcYgOvl
         DHefEA7UAXFFGv57FwuxqT18PDO5q6K/5ufqOdVNstpjB86r9MGdZv4yZpFN2TA8oFQ1
         Zlcpet92YDYOl8s5jANX8RFsA1vywPyfypOHAcnf3NOhGxl16kL2SP8hxUJ/0xOcjGIv
         iRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5t4OXh3YN7fJm225qMAwN0eYWpLsXjfBmJlsr43UDiQ=;
        b=Gc5rtjv5ynxdDiCTum05NzfAjW0wVt/zHrNY55UrR0q9gvPO+P6dF0psRbE/KyagvL
         4GY8NZsgUKR3mpz+MhtS2XUzMw6mon8rymnmHXG0ngElHnAAApfW0QZ7YlxWE31jRjpT
         pZS8B0SLReBRtAEq/v5Z3/qCWHYlyLiRvM6NDg+/TAnPzjNHgNMmeu9w36v5zkrKcNLO
         61ptTUnIwUWbXIumHzQppyfiZiqdW0/r999ByldCQras3Q4XAS6hjo7qRad8E8OEZL9V
         Vg0tR59luIx2TxZ5iougS5ycYNSW0RRLFRdvxgv1NDVWgFrWTW2MwUjS+4VGCw1JtZgM
         AuAQ==
X-Gm-Message-State: APt69E3fZJiQiKGifz7vV1vEZQezGDIGHszLOB3KxLHEKnfVdLou37my
        QYn7kqt9cFsfnXefZw5I3mroRNhJ
X-Google-Smtp-Source: ADUXVKI3WET6H7bvHUNArbE5GuYh0DZbQHdU4wecN5ZZ3A8jPRov3dk+PIIjKyEkMOoKOsL3+V1Mug==
X-Received: by 2002:a1c:47cf:: with SMTP id m76-v6mr2913032wmi.80.1528718349603;
        Mon, 11 Jun 2018 04:59:09 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:07 -0700 (PDT)
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
Subject: [PATCH v6 05/14] mfd: da9063: Use PLATFORM_DEVID_NONE
Date: Mon, 11 Jun 2018 13:58:42 +0200
Message-Id: <20180611115851.1987-5-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PLATFORM_DEVID_NONE instead of -1 in mfd_add_devices.

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
V5: Rebase on top of new 01 and 02 patches
V6: No change
---
 drivers/mfd/da9063-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 76258e5709f8..f57558590283 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -226,9 +226,9 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 
 	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
 
-	ret = devm_mfd_add_devices(da9063->dev, -1, da9063_devs,
-				   ARRAY_SIZE(da9063_devs), NULL,
-				   da9063->irq_base, NULL);
+	ret = devm_mfd_add_devices(da9063->dev, PLATFORM_DEVID_NONE,
+				   da9063_devs, ARRAY_SIZE(da9063_devs),
+				   NULL, da9063->irq_base, NULL);
 	if (ret)
 		dev_err(da9063->dev, "Cannot add MFD cells\n");
 
-- 
2.16.2
