Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50467C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF8124546
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFJJe0XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF8124546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031633AbeGARYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:24:50 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45533 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031602AbeGARYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:24:42 -0400
Received: by mail-pl0-f66.google.com with SMTP id bi1-v6so6800350plb.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/b+N2DvOUUyA2A2wTJ+2C32b3lKHmvgv0TH8hNrLKeQ=;
        b=gFJJe0XXSL5nNHQZXKnM3keAuD5t6EIoArZmA/JH2g6+7zP9LFvwqyUGztOdpn2ACq
         uLNz2/Lb/yLF4hFZPIg2QevOesmR3wQ5Anr7ZxYNf70bS4Dp9WnBoNrpktifmyPJy8aB
         V/W7D0AEJvY6KtwNwmCeNMsSynOVzefBKVVdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/b+N2DvOUUyA2A2wTJ+2C32b3lKHmvgv0TH8hNrLKeQ=;
        b=JmP7sgAL+HiNgBHEEoV3s4UldkYDmbKplbsdqnisYp/ixpsjIDLMmfvHe2KhefJ8nV
         w9c4ZKxjftEXYU9R/pBq75egTniNt8pxosA2ttJ+RnDBWNlMxKLMUji9o0V2mgIdmnQd
         pV2Ox/vbLGyp/jTPUCGa+CYXaFxgOt6sY17ZZwLr2wyrolkvuONIUjKRJbfyz3S09eXp
         BBLt3DVZ6UnrNLxvY9vEzVAf76DITkdAU1I6sVXc6bwSrmEy9n8E69o/SkSTX0oBgmg5
         Qt9C3O/+t5c6Cb3YUS+I2mYiPutm7KTGa7KvUbmNd7dzYm3up7a+6Do2juhhu69gumz4
         7zxg==
X-Gm-Message-State: APt69E0JvSYjJ3QS/PqI0xupjHKJqls1ainihX/m63+iB4EruN8U3Gd5
        ameHe00c6M9tffuQWLQRu8oL
X-Google-Smtp-Source: ADUXVKIr0EZ1GjGieFHA3f3qFEK1r32g769hKa09h3wnUuiLlFoDIQsVi0jaRA0hxE0U41F0jg2KnA==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37-v6mr22922748pla.219.1530465881631;
        Sun, 01 Jul 2018 10:24:41 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:900:ea77:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id f10-v6sm17989836pgr.30.2018.07.01.10.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 10:24:41 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 6/6] MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver
Date:   Sun,  1 Jul 2018 22:53:05 +0530
Message-Id: <20180701172305.15663-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
References: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for Actions Semiconductor Owl I2C driver under ARM/ACTIONS

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b54e9ebc6f..5084c62712fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1145,12 +1145,14 @@ F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clk/actions/
 F:	drivers/clocksource/owl-*
+F:	drivers/i2c/busses/i2c-owl.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
 F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.17.1

