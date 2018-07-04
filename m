Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19156C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9FD21A74
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hNzyrZ2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9FD21A74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeGDQzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:55:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52528 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeGDQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:55:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id w16-v6so6928684wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PvOudz6RyIskSJn6PgLe79Ph0X6+vNBqQoUnWH/mtIo=;
        b=hNzyrZ2NfoHgzWz+LMdC8LhydMUimXfDODOg6p/yjPhkb5f1GWIXcpc4VAttlTJZQB
         opVtW50hoLRXHm1OdUf/+gbx1Z0u73DrMHfzPAkpQKy94Fq4aXhoMJMoMWbL/a65dxK0
         VSx/89i+RcNRCXQDl2llQFqHKBvWofe0FHl3u+YucQcxpi8s64xsYkzrOMYk1Tc39jkK
         JkI6+CHgEcJunlyty0Qd6P2k8D9FSGuCaERHWqYMdLyKCIfVi638xpCF4j4tStOSHKDM
         nEOOCzFuRMCNICrRKQOZl89Wqy/XPsQZddkdPU1SOoN3UvyEe+2Uookn7kKWKMA76/g9
         h5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PvOudz6RyIskSJn6PgLe79Ph0X6+vNBqQoUnWH/mtIo=;
        b=Sa9uNVbh/hITykrTDt9/TT5tQlIjNkyzL8f/juBUUmIBJ9e5QCSi5Cx52yT29qJ9X9
         ydMU9hCXdKXE6BSSiEKxFFmi6K2aeejbnuy0eoQRhVtNuNS3+5kA+PI5HjJzmoYkmoIT
         HnMMHNxtCfuxZ0BSpHs1YwJzbTJadDSrnK87b6ewgOX7xFUnTlWDvCme+oK/GOT9me8s
         3ayUWY5NqX7z9eigSSIU5kPs45Ocg+S4HANLWrWarZ+fvsLwPlm6omIA5CdEnGjAteYA
         VqG5lUAIdLYpQiLjnQ5B5NFNaDCvgGiYAFjUG6axVe+BPttNvrY4xa4pNyjU1/0IEDB6
         fdvA==
X-Gm-Message-State: APt69E1Wg63jeYOS3TcHqI9Qv5ZvFq7xUwHhQUiNIyrWxnw5lzvzVmR2
        GERkMhrQ4EbhVp89U2gY/wpchw==
X-Google-Smtp-Source: AAOMgpcPXLMPRcF7QqFRBpfxtUUKHdSKyNOGuHfs8tKf9YcF3OiSg+QIGktXl/pTd7m6tlTafLgZWQ==
X-Received: by 2002:a1c:ec06:: with SMTP id k6-v6mr2223557wmh.39.1530723307289;
        Wed, 04 Jul 2018 09:55:07 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d102-v6sm7927618wma.10.2018.07.04.09.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 09:55:06 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: meson: gxbb: remove HHI_GEN_CLK_CTNL duplicate definition
Date:   Wed,  4 Jul 2018 18:54:56 +0200
Message-Id: <20180704165458.24149-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180704165458.24149-1-jbrunet@baylibre.com>
References: <20180704165458.24149-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HHI_GEN_CLK_CTNL is defined twice, just remove the duplicate definition

Fixes: 738f66d3211d ("clk: gxbb: add AmLogic GXBB clk controller driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index ec1a812bf1fd..df6c21d368c6 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -66,7 +66,6 @@
 #define HHI_USB_CLK_CNTL		0x220 /* 0x88 offset in data sheet */
 #define HHI_32K_CLK_CNTL		0x224 /* 0x89 offset in data sheet */
 #define HHI_GEN_CLK_CNTL		0x228 /* 0x8a offset in data sheet */
-#define HHI_GEN_CLK_CNTL		0x228 /* 0x8a offset in data sheet */
 
 #define HHI_PCM_CLK_CNTL		0x258 /* 0x96 offset in data sheet */
 #define HHI_NAND_CLK_CNTL		0x25C /* 0x97 offset in data sheet */
-- 
2.14.4

