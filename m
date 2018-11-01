Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCDC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A27820664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfrzm4PB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A27820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeKAJxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:53:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33134 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAJxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:53:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id u1-v6so18460873wrn.0;
        Wed, 31 Oct 2018 17:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxnkFIw1Q+i5FsURVac8qkSHIwEh/FivfEkua9BcaYQ=;
        b=lfrzm4PBamDlflpvUeEIKTKa2N0P0q2UXYVeQINe6l2Rwba4t5wCvbJvR2ivYVN4GM
         3IfB6559wZUO6jiWBFudA/n+VPu0KwZmLDcZu9Lwcf5RMMqHjHr1zFcNBTg+1Sx5shCj
         VoXddsAQHvCkVR1oP+U/B7Pxc3g8QoR9290y9Ru1OU1a0/UvDbbjlyDwP3dguXY5hFsI
         nFOq3JwNuOZK3pKy3GxJMCFllP/IqJO69QI59h1gTzmRjJ7/9c3BwwK7vGfFNmTaJ7r0
         k619lZaafiBg1gShppEPOHqo0sjCj6/K5Yq9k+fYb+6isMbWTapMbvih+LFftzWiFS+s
         spGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxnkFIw1Q+i5FsURVac8qkSHIwEh/FivfEkua9BcaYQ=;
        b=Rsgcc5bTr1tnCQ5oShBx48+8afz0eWIYWDcb6b5Na22JlvtPiCHbskwCdFLfSyN60s
         HTmgK2gXpUtCofFHd4NpDKhvwDwvSat/vn2YM0ZgVdf4lDoLYV3aPqQ2FgJFAPT++WMy
         hiMVI1zzfUBaToTfWsVNB573I+jijDBShPYBWVXYwEVoaKHNpjd/9n0bl6aCdax+fQ28
         YVdbyveCmrxKw4nmaVTNPue7AanQz8VvPxqyyq1peUhiDgbi3L0NWYAcEEf0cCILkmVz
         mQG480uI8h/DIaQjLsXFNeRPgnAX8Yt8PvDE5D/UUF6x9LpnYnzecsUCnwTR0UtVZ3kD
         KSgQ==
X-Gm-Message-State: AGRZ1gJ1/vhe6lwvFiajdqDs1HIsa2N2+Qm22HDXoiWef8oSDFl70Vxo
        O144o1qP19iL7yWTkt744yw=
X-Google-Smtp-Source: AJdET5f7c0m5l4YBCzeg/lqf4vx8lw54pMqdLoidw0SBHIvyrRVb6GOTl5pbzpZ0581+02LY/FZNjw==
X-Received: by 2002:adf:b3c1:: with SMTP id x1-v6mr781270wrd.179.1541033589349;
        Wed, 31 Oct 2018 17:53:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id o17-v6sm41180879wro.2.2018.10.31.17.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:53:08 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pinctrl: lpc18xx: Use define directive for PIN_CONFIG_GPIO_PIN_INT
Date:   Wed, 31 Oct 2018 17:52:57 -0700
Message-Id: <20181101005257.8778-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another:

drivers/pinctrl/pinctrl-lpc18xx.c:643:29: warning: implicit conversion
from enumeration type 'enum lpc18xx_pin_config_param' to different
enumeration type 'enum pin_config_param' [-Wenum-conversion]
        {"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
        ~                          ^~~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-lpc18xx.c:648:12: warning: implicit conversion
from enumeration type 'enum lpc18xx_pin_config_param' to different
enumeration type 'enum pin_config_param' [-Wenum-conversion]
        PCONFDUMP(PIN_CONFIG_GPIO_PIN_INT, "gpio pin int", NULL, true),
        ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
macro 'PCONFDUMP'
        .param = a, .display = b, .format = c, .has_arg = d     \
                 ^
2 warnings generated.

It is expected that pinctrl drivers can extend pin_config_param because
of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
isn't an issue. Most drivers that take advantage of this define the
PIN_CONFIG variables as constants, rather than enumerated values. Do the
same thing here so that Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/140
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pinctrl/pinctrl-lpc18xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
index a14bc5e5fc24..4bee606088e1 100644
--- a/drivers/pinctrl/pinctrl-lpc18xx.c
+++ b/drivers/pinctrl/pinctrl-lpc18xx.c
@@ -631,13 +631,10 @@ static const struct pinctrl_pin_desc lpc18xx_pins[] = {
 };
 
 /**
- * enum lpc18xx_pin_config_param - possible pin configuration parameters
  * @PIN_CONFIG_GPIO_PIN_INT: route gpio to the gpio pin interrupt
  * 	controller.
  */
-enum lpc18xx_pin_config_param {
-	PIN_CONFIG_GPIO_PIN_INT = PIN_CONFIG_END + 1,
-};
+#define PIN_CONFIG_GPIO_PIN_INT		(PIN_CONFIG_END + 1)
 
 static const struct pinconf_generic_params lpc18xx_params[] = {
 	{"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
-- 
2.19.1

