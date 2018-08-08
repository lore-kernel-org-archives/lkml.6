Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C26C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE712089F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffTtkJS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE712089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeHHLFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:05:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35194 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHLFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:05:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id f18-v6so1017337lfc.2;
        Wed, 08 Aug 2018 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YqQzms+gCxu+LO5nhrMGMFp9MODX1lDTdQMdgdLecug=;
        b=ffTtkJS6xLMB1z039t+ymbOfSK0fYM28py8aycRs/mDG4mUjaad/0Ht1QCnkhuwEwk
         Uq+4LXzDchw+qI+KeCXSyEUXw541VjM6t2/t7SuBSgXv9lcvHe+40iiEs7DF+RadjZrr
         M+MYtmjBaS+qlxgnGu9irFTm9udi7ddrUnBBFkajgw6BIxKNKLBD6dOTlCBWcIhvUV7D
         P/cYbOKfwUEw31ppytk63egkWTNjiqILF8GrGgEeKAMc+5yVAgDVs3Yze8RJz7kaUm4x
         LU2WE4wpA4npbr4SPkwL3l7boJxg9SoLehv83OMpLWqWtsGRz2oO1jsD3eTc3zOlDpKO
         /Bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YqQzms+gCxu+LO5nhrMGMFp9MODX1lDTdQMdgdLecug=;
        b=LlkjFWUUKCyLLnMHxx+JUJvsrJ7FxZGQVFEHxIi/NYGB2xD/Qkpdk0Gzz4YAODxABR
         /18kFHBdhEhCMBeCktmXIrrNbxo+gYez26Qu17TGnIbt2wgtFAbLppYrOgi+yjYOqGgg
         g5+FThhv8O4+NLsWwePMr8DY3prLyunnO9buMyEZFoJm5/RsjcpvfAY1W8/Nk1UCHy0B
         lai56lWQR2plGx01QRSTFHkdcTvOpoK90bK2dsZie/rEYe7AjwkF/fC8ZZcb3H7/Pwtk
         Gi7NXSQqQEES5mnzvJwnmzA1pwzGtHHYup6T92Fqk7+nLpfTi3QGML3eJ8CpIUQED1rZ
         gluQ==
X-Gm-Message-State: AOUpUlGXUNa0QIS/prMSpZgDEkTY6i6D+5Z9Zs7cWnekH3iGzucvmaXO
        PRCfUEe8IgcPyvR+wS3f/+k=
X-Google-Smtp-Source: AA+uWPyViXdEicTGfFQ/kVtaAeicIq45a6ycGtkyZGNa2wdw+Vj8ARwSz0r/cVuh0QnL4k5MoNteaA==
X-Received: by 2002:a19:c64c:: with SMTP id w73-v6mr1384347lff.2.1533718017883;
        Wed, 08 Aug 2018 01:46:57 -0700 (PDT)
Received: from work_station.192.168.3.10 ([88.86.78.118])
        by smtp.gmail.com with ESMTPSA id p88-v6sm598176ljp.90.2018.08.08.01.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 01:46:57 -0700 (PDT)
From:   Ivan Podovalov <ipodovalov@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Podovalov <ipodovalov@gmail.com>
Subject: [PATCH] gpio: it87: add support for IT8718F Super I/O.
Date:   Wed,  8 Aug 2018 11:46:22 +0300
Message-Id: <20180808084622.26392-1-ipodovalov@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DIO connector on the WAFER-945GSE is interfaced to GPIO ports
on the ITE IT8718F Super I/O chipset. From the datasheet of ITE IT8718F,
the GPIO interface is identical to IT8728, so just add it
to the same case as the other chip.

Signed-off-by: Ivan Podovalov <ipodovalov@gmail.com>
---
 drivers/gpio/gpio-it87.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-it87.c b/drivers/gpio/gpio-it87.c
index 7cad14d3f127..b334448e2b46 100644
--- a/drivers/gpio/gpio-it87.c
+++ b/drivers/gpio/gpio-it87.c
@@ -37,6 +37,7 @@
 #define NO_DEV_ID	0xffff
 #define IT8620_ID	0x8620
 #define IT8628_ID	0x8628
+#define IT8718_ID       0x8718
 #define IT8728_ID	0x8728
 #define IT8732_ID	0x8732
 #define IT8761_ID	0x8761
@@ -314,6 +315,7 @@ static int __init it87_gpio_init(void)
 		it87_gpio->simple_size = 0;
 		it87_gpio->chip.ngpio = 64;
 		break;
+	case IT8718_ID:
 	case IT8728_ID:
 	case IT8732_ID:
 	case IT8772_ID:
-- 
2.16.4

