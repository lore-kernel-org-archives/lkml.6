Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7858C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8D32080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u3EoRmmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8D32080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeJXA11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:27:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37527 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJXA11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:27:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id g9-v6so2326997wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=NeySEQtH2rtUcpAfpm/aL6G5MfPMD/6HAlrixUP8xB4=;
        b=u3EoRmmQ4PIP7zQCdY8rkkI8VpBK6hmYPjBE5N5ki6NdOslY7QX/cbUDKyDDQCwafu
         3L8jRA7ksQ4DjaQcAyqfOdwW7/6X3DH1eghpKHFvvWItDmvH5fiXQEkAmEug9UCIRt9U
         W/GedCJsZpWJF/WHa4AJq6ae5LA1+qw8kcqNzN15WsLR62zz4en9EkILcsY/FNsT3JkS
         +RNJIBhMRj9bP6t2+H8zEgdgu0JHpObkNuN9KlSdf05seSNKXtry3Z1ut+q2pKBhfes9
         I46LwkFDcVSGCaLWWUr2iD6+CqY05joPZZNNtWRV5k9MpXPSynLUuC64d02c0B7+guM2
         iDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NeySEQtH2rtUcpAfpm/aL6G5MfPMD/6HAlrixUP8xB4=;
        b=tdHyaS5AK85iiqwEb4YzDyx70rzJo/COPn2PbB/9h/VJiWZEgSHFb09nRksrXdGmZE
         qGqxki6wbLBTTfk5yOHQMDsH56At6Ls34H5HQ0Ds8OkkFce9EckIP1absOE1KtorRs4G
         0Ysv6rkIz/iXjoAOKPqXBbJI4qzDx0jHTSh0LrdRx4aXXiCf3ij7sRNQqEPyfTYQ70zp
         bsL0NsSW4ZpfB+ljturILrSqsitCpjpObmfdbSYntJ3+r2Fq5h+TFeKKdLRgYp0vEzU5
         dMLIdkF2wNYtfspFIvTNYKT/uQYEeihJyW0jUXl8M4zvmyfH6KvUv0HLP09PJrWvuHs/
         UIvQ==
X-Gm-Message-State: AGRZ1gJ4Qd6769BlcC10aQLgA3g1iv5pgRw6izmrNHd4Y0BFvHr5yGXz
        OetD5o/T1PBjDFSuGK47X8bOrw==
X-Google-Smtp-Source: AJdET5dXBbuoau3TDOcSJ4oG0I1SJyPhlfakv+dqg7yknL+DGfOkoInU8rQl7DjZI1VVXU9rlfA2WQ==
X-Received: by 2002:adf:b1db:: with SMTP id r27-v6mr9806606wra.95.1540310606641;
        Tue, 23 Oct 2018 09:03:26 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y19-v6sm2319910wra.60.2018.10.23.09.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 09:03:26 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: meson: fix pinconf bias disable
Date:   Tue, 23 Oct 2018 18:03:19 +0200
Message-Id: <20181023160319.27003-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a bias is enabled on a pin of an Amlogic SoC, calling .pin_config_set()
with PIN_CONFIG_BIAS_DISABLE will not disable the bias. Instead it will
force a pull-down bias on the pin.

Instead of the pull type register bank, the driver should access the pull
enable register bank.

Fixes: 6ac730951104 ("pinctrl: add driver for Amlogic Meson SoCs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 29a458da78db..4f3ab18636a3 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -192,7 +192,7 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 			dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
 
 			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
-			ret = regmap_update_bits(pc->reg_pull, reg,
+			ret = regmap_update_bits(pc->reg_pullen, reg,
 						 BIT(bit), 0);
 			if (ret)
 				return ret;
-- 
2.17.2

