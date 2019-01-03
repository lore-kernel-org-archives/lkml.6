Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA6420815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mzkfy880"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbfACPLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:11:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33138 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbfACPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:11:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so33931152wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bztX5GLS2nM4tEUX9wPl/F9/kiH0XADSVNwoqijTUcw=;
        b=mzkfy880idbgY3ZUEea+GPENXKJ/TXULVloJe+8AyryH52ArrckmLgkUWCSEIcR2Cr
         AS4JOUFnnTSUddkvGMNZNA5dNaOUI4AfOHt2OM0nXe/aCKsuHVtRCbdDDmv+VzjoPGI/
         TSnFVMbie9Y8fdFwvnbkYW/1eQc3CTLbzRMKK6MQzqe2mjfKDbvFM3nAatN/LTFXkxvT
         yS/kmRO+Pgnq3MdlxIjpUG0KZlm0DlL4C5ZvPsvpL1KlwqtdwiJLA/68PSgEEdjOatnI
         7lobECsUugLr/mp21OiOeou1GORuHiQT1ziTnMqR2AqcYYunspLauznMRUdeW/G/GjOg
         cbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bztX5GLS2nM4tEUX9wPl/F9/kiH0XADSVNwoqijTUcw=;
        b=Zr+DpgAxhSpmPy4AnrBSrnctYSiVhjZV3BuAs8iV37ExHJYPcZu2DebMHmT2u9XcHg
         NyHNbLo1UykilYx33NU28uRe5FQW/8ctyKX3+jgVhMXdnIRF/OCka7Cuq9nRm5J0ABkM
         oFL+aS7brhqAt+heQdrQPuTo9AFIw/3h8s+SZASkJWYaXctUSTlpbMvcK2dD2PC6OzHB
         mEdpoqoAhkp9F0SeaIzz92YVYP6bNd9B3agoEg+HloQuBa0+VfMd7vac1u0/58qOkJuG
         0p9D3gYqj+oDt0Pkw9GbQqA2kQ1dQZauTo5MHhRID7wpavC8DlafJKaFWJ40cRvimOlT
         SHww==
X-Gm-Message-State: AJcUukcuXoRDoQV6gxBx9KKT9GOKzYRHoiKcobPCLofL2Ev0Wit7oV12
        /ExPvDzhHST4zYm6tSSpl0ASyg==
X-Google-Smtp-Source: ALg8bN4MS1F0pPVMMusxIxLPyNFMi2QrKOzGGvKYF1CAUk3gvLf/sDvc4gX4d4nfIr3mCR/jjHLvzg==
X-Received: by 2002:adf:f649:: with SMTP id x9mr40385684wrp.247.1546528282696;
        Thu, 03 Jan 2019 07:11:22 -0800 (PST)
Received: from debian-brgl.baylibre.local (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
        by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 07:11:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Andrew F . Davis" <afd@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 5/5] ARM: davinci: omapl138-hawk: fix label names in GPIO lookup entries
Date:   Thu,  3 Jan 2019 16:11:04 +0100
Message-Id: <20190103151104.11839-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103151104.11839-1-brgl@bgdev.pl>
References: <20190103151104.11839-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") the gpiochip label no longer has an ID
suffix. Update the GPIO lookup entries.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 8e8d51f4a276..94c4f126ef86 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -134,9 +134,9 @@ static const short hawk_mmcsd0_pins[] = {
 static struct gpiod_lookup_table mmc_gpios_table = {
 	.dev_id = "da830-mmc.0",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio.0", DA850_HAWK_MMCSD_CD_PIN, "cd",
+		GPIO_LOOKUP("davinci_gpio", DA850_HAWK_MMCSD_CD_PIN, "cd",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.0", DA850_HAWK_MMCSD_WP_PIN, "wp",
+		GPIO_LOOKUP("davinci_gpio", DA850_HAWK_MMCSD_WP_PIN, "wp",
 			    GPIO_ACTIVE_LOW),
 	},
 };
-- 
2.19.1

