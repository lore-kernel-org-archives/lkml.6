Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7982EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3769B21470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUZo9laP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3769B21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJRF2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:28:18 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:45789 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeJRF2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:28:17 -0400
Received: by mail-vs1-f74.google.com with SMTP id s13so10653498vsi.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O15kTxbgzt/RIOqNWgHWoDpGet/SMUenjSK030XOI+8=;
        b=PUZo9laPeV4bhwyEP3usfNc6fTdv9KZD+MzcnTK8peypN9NDF7s4u6t5NgYxWmH+Be
         D5P1VWwwJLS7jWlWHl1oEYc5Pd5bXcko6OwIAZiDQUlO/iaZYvFWjEV72dDH1+a/3zs4
         bFASN+k1OejoFycg1srGKdkPxSb3Ox9JsiCTvCo1+MLMiIZsc1LtJkYpHLFhKSgLoz6m
         8tmfqih1jjiRtSNsxQNCNdwI0PW+3FXKfbEZfxdvAiDJH10CA6oEcmfDXT7EZNWLLnbg
         UwObES4meMFFvqIHxsm3wlYv2gl7A4QOykJK9QjFz1NMi+dQtmKibqH8PVj6Q+Y8EB8V
         mrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O15kTxbgzt/RIOqNWgHWoDpGet/SMUenjSK030XOI+8=;
        b=JpZAPnj1T49PMrr84bhOk0ws5zQngbfOPDLThQHK4FP+eNvRUkL0wrGvTRSRoniUwT
         YpK2N3H4EWd7D8KZFVFo3eHbn/5tLnClWU/iMXVLlw75q79TxJnaA0oM51CG7XPLIbwI
         lEHtnMMe0t6Dk2M1JYDSSRM9179nZlQ7E4M3CMu2UJ77yvfIZYaZiRJGqeYunmp/NcbR
         DnGiZzCv2mAqpETvKnnGSv8DIbCMQRfCm8eWs9YhamVwMjW5BWUudt0jP/7WVAsaAhjj
         NXvgLpUsxXRbBmW2nYncxNedmTklaxKL8jfbtZhJLBNOfGNBESD9mFEmycSaai8CFhaQ
         u1TQ==
X-Gm-Message-State: ABuFfohpbU7t5UcMYBoFf7+gnLtvftah0Wfjuep169qBGBDvygcoH0CX
        tXFFu8AqkNzwul99REVKqWEvfaLfhA==
X-Google-Smtp-Source: ACcGV60fTq1qfGOUVvxGoJyLfi//QTmG+LF4Ie18gfsLcxWQbzBJtQcnsjcVlAvMhY8VdF5OcpM7xwVeXQ==
X-Received: by 2002:a1f:85cd:: with SMTP id h196mr3075269vkd.2.1539811841656;
 Wed, 17 Oct 2018 14:30:41 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:30:12 -0700
In-Reply-To: <20181017213012.233957-1-kunyi@google.com>
Message-Id: <20181017213012.233957-3-kunyi@google.com>
Mime-Version: 1.0
References: <20181017213012.233957-1-kunyi@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH 2/2] pinctrl: pinctrl-npcm7xx: Set BGPIOF_VOLATILE_REG
From:   Kun Yi <kunyi@google.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        tmaimon77@gmail.com
Cc:     linux-kernel@vger.kernel.org, avifishman70@gmail.com,
        openbmc@lists.ozlabs.org, Kun Yi <kunyi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indicate that the pins are both controlled by the pinctrl driver and the
generic GPIO driver, thus GPIO driver should read the register value
before updating, instead of using the stored shadow register values.

Signed-off-by: Kun Yi <kunyi@google.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 7ad50d9268aa..ac7b69d53aff 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1904,7 +1904,8 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 					 NULL,
 					 pctrl->gpio_bank[id].base +
 					 NPCM7XX_GP_N_IEM,
-					 BGPIOF_READ_OUTPUT_REG_SET);
+					 BGPIOF_READ_OUTPUT_REG_SET |
+					 BGPIOF_VOLATILE_REG);
 			if (ret) {
 				dev_err(pctrl->dev, "bgpio_init() failed\n");
 				return ret;
-- 
2.19.1.331.ge82ca0e54c-goog

