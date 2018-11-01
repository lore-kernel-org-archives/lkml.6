Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94035C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ADC20821
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sH2hsALW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ADC20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeKAJpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:45:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42237 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbeKAJpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:45:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so18409874wru.9;
        Wed, 31 Oct 2018 17:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K69mVT58wCJTNeQ8VoYFdTzvehDeKtTr6VixolS+jFY=;
        b=sH2hsALWFmuT69xFYPONryWXAa4gxBiehTcWwh1gVIIHdoqYY6Hnb2x+BdWB+lS10x
         Jy5duBiSDW3424VeU6TOMWr4ztjiRT/lC0hVQE/iPT6nOid/WG4cS4CzKVzR0audkdFv
         0Sy7pluxBcSVTzGBKUm1sCaLLbh9dU9TVn1O9F+o0V6A7Y/7qoynPP0VusiCX2IQ7U+b
         UVqTfq/vtesDMoyBwEUoqB3P5mKkfXXJ1RfMq49J+m9i/3Pv3jvRXnLKsHRLY5NdKmjE
         I3mzzWARKVgCaC1ulFVKdhfT5fYiJyvRD41R5DjSfKEOKDQ82thcN5l+o4J+JO7AAtLN
         2ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K69mVT58wCJTNeQ8VoYFdTzvehDeKtTr6VixolS+jFY=;
        b=QrrwBVlRSkY+mMx8YVnxbxkuXClEoscVCYTJ+l0VTjaGKR1UOQ3Tb8XIMqMv7c0xeA
         SfP2Cn+BTNoDIGboiRK9USt3aJ7Fr2/OaBLMBVJRnLrH1D51oB8pLhgNopu0s021ggoX
         lE9BbUSXgRLIo/EOR91qkgeG1HJrxnPXcFFWdMnbDpkosMBfqpaxDV3fKYhT3OAHW+zw
         xi5aDcY6tu+ND6odjnQwKZht5AIBQ0BIMfOFgzU8E8+sCoduJgZkjFUrvEhmQv47GI3J
         Hx1tJg7VtkaafyBPFA0jbsv0b0PC3hw+5duSICgg9MM5WPiKvAQcYzZDHB291OVMVHAF
         tSXA==
X-Gm-Message-State: AGRZ1gJm8wYhuvUni0Jg5bE6AnhhlOy6oG6YUTTO9Qe+McxJfLu1mTli
        lw8NMF1ITnPb5Rfdx0zo8l8=
X-Google-Smtp-Source: AJdET5eRQqTX54GLh3OW4gGvGigbrbRqrxZcqeVgJ6YHXQAmqwg+oE16nEN2ADBjoCYRI2qrfAZx9Q==
X-Received: by 2002:a5d:4a48:: with SMTP id v8-v6mr1471321wrs.7.1541033070452;
        Wed, 31 Oct 2018 17:44:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x8-v6sm71181586wrd.54.2018.10.31.17.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:44:29 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pinctrl: sprd: Use define directive for sprd_pinconf_params values
Date:   Wed, 31 Oct 2018 17:44:10 -0700
Message-Id: <20181101004410.6893-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another:

drivers/pinctrl/sprd/pinctrl-sprd.c:845:19: warning: implicit conversion
from enumeration type 'enum sprd_pinconf_params' to different
enumeration type 'enum pin_config_param' [-Wenum-conversion]
        {"sprd,control", SPRD_PIN_CONFIG_CONTROL, 0},
        ~                ^~~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/sprd/pinctrl-sprd.c:846:22: warning: implicit conversion
from enumeration type 'enum sprd_pinconf_params' to different
enumeration type 'enum pin_config_param' [-Wenum-conversion]
        {"sprd,sleep-mode", SPRD_PIN_CONFIG_SLEEP_MODE, 0},
        ~                   ^~~~~~~~~~~~~~~~~~~~~~~~~~

It is expected that pinctrl drivers can extend pin_config_param because
of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
isn't an issue. Most drivers that take advantage of this define the
PIN_CONFIG variables as constants, rather than enumerated values. Do the
same thing here so that Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/138
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index 4537b5453996..7d9a44bd0047 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -159,10 +159,8 @@ struct sprd_pinctrl {
 	struct sprd_pinctrl_soc_info *info;
 };
 
-enum sprd_pinconf_params {
-	SPRD_PIN_CONFIG_CONTROL = PIN_CONFIG_END + 1,
-	SPRD_PIN_CONFIG_SLEEP_MODE = PIN_CONFIG_END + 2,
-};
+#define SPRD_PIN_CONFIG_CONTROL		(PIN_CONFIG_END + 1)
+#define SPRD_PIN_CONFIG_SLEEP_MODE	(PIN_CONFIG_END + 2)
 
 static int sprd_pinctrl_get_id_by_name(struct sprd_pinctrl *sprd_pctl,
 				       const char *name)
-- 
2.19.1

