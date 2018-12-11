Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0990C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1E12081F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2mmxOr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1E12081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeLKAF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:05:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeLKAFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:05:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so12255195wrt.11;
        Mon, 10 Dec 2018 16:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04AGU6znUsheVb7NBNNw+8OY8y+ws90vlv4simqd50o=;
        b=m2mmxOr373f1C3JLr7q4q/fWwHU+3PrIpCii8+ul6q73be1LgrnunI9JY6VrlIxSdg
         e4iCIURwRVlRCpMBhVuosvO2GED6AKLyjNYvLV3+o7vvXRM1fNdwheYJNy5rn3H0lUsB
         R/FAL06JpzX/Ze8LQaIgjBwxf2Kv62tB3+2B1fuqXThBYwJkbasK8hy1C8oJxRQ6EtCO
         noCFPZKzVNbnMg1iz2kD0fR40JSDIbGGyLLy/vf3d/olO9BSUNh1rgibeKrCTwPuZpDq
         iXg55aBwwMHXuf2p8AbGWCfclp6rVzaZGlsxuZtVv8LCvkdXYSSgtAhMHainaFm5R6Fw
         wpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04AGU6znUsheVb7NBNNw+8OY8y+ws90vlv4simqd50o=;
        b=Aog0FmEW07r37N26RHWg8od/KGRbZqKuMHQBZ0ERqa2wDYifmjSm9b43gNBDdAdt1p
         4sdA1Gv2nKMBVz7ncLkOc+dZC5UUMJy0H4sfkGRMSjMsRauIVeUJa5mGzdkqeGQ64o7m
         Bfkf/GyzCvGLk7/wfadSp3AbsO6bt7512lTDjMzhLN2WV7YeqeRphjlVfd1iADVazh2K
         Xk0GtZc9FAT7dd9F4V7pdRRixGaxXr0k2nWwzfHFK1pIUtxiQ6xdEFlEFz7smYaMDhCr
         y94BcRoqIpQQ8AnM9WVAC35qjxQkJPLrybJF9bhisIufwdnrMI3bK/5txgkjZB6B31uG
         I12w==
X-Gm-Message-State: AA+aEWZD0evIfYyBe63VIHwkXXo6Xc3R7mRcmGLWV/56pb0jMEP4fKvZ
        4xHpKfpwltmM2PJ7hpEfbOwxW66++cQRsw==
X-Google-Smtp-Source: AFSGD/UlEqaqBcYEAQ8Nz24y+qVzbYcrgFeMHSnD72a1pyIsdEhZCUlUB0d9GCYvvQzR0ypkQyV2kw==
X-Received: by 2002:adf:f350:: with SMTP id e16mr10978800wrp.125.1544486753443;
        Mon, 10 Dec 2018 16:05:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h16sm36448599wrb.62.2018.12.10.16.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:05:52 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
Date:   Mon, 10 Dec 2018 17:05:06 -0700
Message-Id: <20181211000506.7559-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang does not support this option:

warning: unknown warning option '-Woverride-init'; did you mean
'-Woverride-module'? [-Wunknown-warning-option]
1 warning generated.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pinctrl/aspeed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/Makefile b/drivers/pinctrl/aspeed/Makefile
index 191ed0fc1804..790b406aae19 100644
--- a/drivers/pinctrl/aspeed/Makefile
+++ b/drivers/pinctrl/aspeed/Makefile
@@ -1,6 +1,6 @@
 # Aspeed pinctrl support
 
-ccflags-y += -Woverride-init
+ccflags-y += $(call cc-option,-Woverride-init)
 obj-$(CONFIG_PINCTRL_ASPEED)	+= pinctrl-aspeed.o
 obj-$(CONFIG_PINCTRL_ASPEED_G4)	+= pinctrl-aspeed-g4.o
 obj-$(CONFIG_PINCTRL_ASPEED_G5)	+= pinctrl-aspeed-g5.o
-- 
2.20.0

