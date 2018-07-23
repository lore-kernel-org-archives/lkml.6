Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11687ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7346020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OsLM3ZHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7346020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbeGWMju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:39:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44358 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387816AbeGWMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:39:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so348743wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZNRow973usaHEz8iyxJtArW068Yan7KHiB0oOPKRQE=;
        b=OsLM3ZHSvnBECGWV4BN62hKdg+uNRUfGkDKKNv+fpcnRqUIvTvWo8B1VS46xTnwj8g
         cHHPvG5ePeiJrWfcYKUxa1S94iH6CqmV+j47pvhf1SoX3dzfFkTxMUGKT3mg3XyBppek
         x4vUzs3K1XdyJvGvR9IUJIqdsnXsytQN+8+X9RZcPHa+YohOMHkpNvYcJqX4bTCWub/3
         cE5rwtWP7gWovioqnzMRwXUBnLtRgHoGW/2xFROuCF+RV0Je4W/rEqsyYspo6OXnhf0/
         GPmNxrEBGR+FmuGksjZBpDtxcd4HCd/RvUkByC5iG5rtXstd9u4ePaAIxC3NAYMcLtId
         pEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZNRow973usaHEz8iyxJtArW068Yan7KHiB0oOPKRQE=;
        b=jEhLmyUzyZd92ZLDc45xfuaNzbFu3Ghj2Luup8zGN+gFdjgRF+WWXS4xqqIO2AfHVh
         0nx+aJXYPaLvetVLkUI00KQ7mlsjvBYAUZi8qSYNZCXusyQlHHMz21/xORovzbS9CBql
         evX1xdNPICasLr1eYsJLSFr018GwaWxOWcjKOsJGFo0fbqWuzdqJJhRSoE0poKlAJja6
         2XM7ORwFM/aYUYvc+kz+pgKydxsxOGS1JUwr4BWAFDNaaVOIWJzDR9e1nSIR78CnA/Rp
         li689zZjHpxGvHdimiYK1jeYZ8VmGOH2LuVwOItbITxpmohEq54elQGpHgTnBRedhUoE
         LwkQ==
X-Gm-Message-State: AOUpUlFHucNJfCRUEQWj/NPUNtNtgAGpbLVbl6JCZAzOcfT/mZoDTr4V
        +TO6cHqWjYMFBHCHOAw9g4Qo3g==
X-Google-Smtp-Source: AAOMgpdiJU34zPojZmbqwCl2UfeQ9pplW2WKDr//N81JpI3CPnLAb3MOs16QvDetzM8jYouk7LUPoQ==
X-Received: by 2002:adf:8062:: with SMTP id 89-v6mr7677035wrk.221.1532345941830;
        Mon, 23 Jul 2018 04:39:01 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id j3-v6sm9628552wrt.70.2018.07.23.04.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 04:39:01 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Zubair.Kakakhel@imgtec.com, gregkh@linuxfoundation.org,
        alex@alex-smith.me.uk
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] memory: jz4780-nemc: build depend on OF
Date:   Mon, 23 Jul 2018 11:38:43 +0000
Message-Id: <1532345923-28811-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jz4780-nemc use of_ functions, so it needs to depend on OF

This fix the following build failure on x86
drivers/memory/jz4780-nemc.c: In function ‘jz4780_nemc_num_banks’:
drivers/memory/jz4780-nemc.c:72:10: error: implicit declaration of function ‘of_read_number’ [-Werror=implicit-function-declaration]

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/memory/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index a642552..faa1a23 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -124,6 +124,7 @@ config JZ4780_NEMC
 	default y
 	depends on MACH_JZ4780 || COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on OF
 	help
 	  This driver is for the NAND/External Memory Controller (NEMC) in
 	  the Ingenic JZ4780. This controller is used to handle external
-- 
2.7.4

