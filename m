Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB75BECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6980620854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBAvNf/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6980620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeGUUyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:54:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40653 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeGUUyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:54:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so13741483ljc.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+Q+IdSlDjHDyIp31hmZ6I/QGxqGx/Z2Fo3yoqpRJnI=;
        b=dBAvNf/2G1EI7ygoCnXWdxKhSV7Xke+K5mae7QppgbURx1yA7rNXzBNZ9GwDgrVMG8
         FZn+j8y9ao9yg1yHLfU3AWFPzppeRyQscO7mYAtAOQ/5yoYVN5U6E08oM1x/QN1A6glf
         QtLM5X0fYbG3OyOjoVL9XLc5hf1QGlNaiNKdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+Q+IdSlDjHDyIp31hmZ6I/QGxqGx/Z2Fo3yoqpRJnI=;
        b=jbrAkrcFWw9UuLHJ+/ptF88F48FRNhtXLRqaZKx9wXTcSWMNzZBjuZEK9cyoJLI9cv
         8VIM7TiKj53mOm91EUjiF9siA5CEKGwGwjpO+ijraJWfzHvHpGievcus8T9kCtY1udW0
         90CAEPhHkUp21xkVBD/v8rPvW2L/vU5geDSE6JGNs+BRUTL0DysBUQfEUUpZ7MnQYTfl
         h93Xr/JNNZsK4o0RTeMyD4UCrPNvgTyZBJ1UBGOxzFGVzeqIM8+zWLsjv+p2TBgYzj7y
         htYnHScnDhxfz/knp7YMAkR+PnDg0viR4wr6r8AKMwlYKgKuspQVXX2ub4Ns/g8BG1tj
         jVQg==
X-Gm-Message-State: AOUpUlFEf9ai7ARohuiWwS43t3tA+XGBrSLE6AvXXTvkZdC8AgG6WBmy
        K6TcnrwOX6HMUeGnXjAYOC2ekw==
X-Google-Smtp-Source: AAOMgpebUmsoWIPaACM+i39X7aVEpBob1WsgPnnaSJShwD1l3uwaD780XZcJ8fXo89OatEdK7ZoDKA==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr5215940lji.17.1532203257300;
        Sat, 21 Jul 2018 13:00:57 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id q65-v6sm772607lfb.80.2018.07.21.13.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 13:00:56 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drivers/memory/Kconfig: Add CONFIG_OF dependency
Date:   Sat, 21 Jul 2018 22:00:49 +0200
Message-Id: <20180721200049.7553-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JZ4780_NEMC doesn't depend on OF, and if OF isn't enabled we get this
error:
drivers/memory/jz4780-nemc.c: In function ‘jz4780_nemc_num_banks’:
drivers/memory/jz4780-nemc.c:72:10: error: implicit declaration of
 function ‘of_read_number’; did you mean ‘down_read_nested’?
 [-Werror=implicit-function-declaration]
   bank = of_read_number(prop, 1);
          ^~~~~~~~~~~~~~
          down_read_nested

Make JZ4780_NEMC depend on OF.

Fixes: ab99e11062c1 ("memory: jz4780-nemc: Allow selection of this driver when COMPILE_TEST=y")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/memory/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index a642552dfdc9..63389f075f1d 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -123,7 +123,7 @@ config JZ4780_NEMC
 	bool "Ingenic JZ4780 SoC NEMC driver"
 	default y
 	depends on MACH_JZ4780 || COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && OF
 	help
 	  This driver is for the NAND/External Memory Controller (NEMC) in
 	  the Ingenic JZ4780. This controller is used to handle external
-- 
2.18.0

