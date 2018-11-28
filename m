Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBBFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43850208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYsZ9DBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43850208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeK1VpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34115 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeK1VpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so22962044ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khCHgyFP1X2ZzoL2+GXUA0fcC/Uoru/eZcSqT5OOnpg=;
        b=aYsZ9DBCti5k+CGJHRwNWUiMBAr/FDrzVhrkvBHGEHfLCgXhzS3wMO8NTFX0YxDN4Z
         CfEkzqB/NNRWDz+n3x/yfl4vNd+VIkinlvN7IZbYnYYmmWKoHycSxzrzS2UiGhSm1DIV
         oz48t8t/ubxeHpEsQbpWhwITRj/XrD8GGPNwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khCHgyFP1X2ZzoL2+GXUA0fcC/Uoru/eZcSqT5OOnpg=;
        b=gSKXffcYnAvc7WholgMagJo4mVopKxhK3P7aiBUrBtg/8bAo1eTJicYNlv0SX2Z+QM
         HRL0WQK+d/JiP3zn3WglpGuh/5cbsVxW/WZGCatpf6+us5Cefp9aukjVQyh4d7fSf9M1
         U5XsVa2JH2kG63gSD9CipfjBIJZsoZhl5zfl111/k4uDg6m7aKIL/nOnhQC1hQkKTFMz
         F7Zssp4owj1nnbOOb/HS/3IgDoOvVDT+816fXTRP0XQpP277HVGYJaMXmjQ62pKecAPx
         WInRwz0s2ifBfB1ihrh4x1/+jQysCxMUUPQzo6BADGC6PUVj4YWaYl/8KAKGWGUMXTb/
         PpvA==
X-Gm-Message-State: AA+aEWYmj42l3dayjf/8K3rGRPbkETQfibyKw84zoz+iwQxW5PuyqvPk
        B26OCM71gDvn3BRFmNBNkuFQgA==
X-Google-Smtp-Source: AFSGD/XD8MXb7MwKmW/ovt2cP3G/OsYIJCryMLxL/gsgCORMjdWFzTSbPRh2kqI60Iy1T4HUmwHpvA==
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr22524247ljk.128.1543401835081;
        Wed, 28 Nov 2018 02:43:55 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:43:53 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/10] Regulator ena_gpiod fixups
Date:   Wed, 28 Nov 2018 11:43:40 +0100
Message-Id: <20181128104350.31902-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We noticed a refcounting fight between the kernel device
core devm_* and the regulator core refcounting, pertaining
to enable GPIOd:s that may be shared between multiple
regulators.

Fix this with a series that hand it all over to the
regulator core and remove any devm_* stuff pertaining
to these GPIOs.

This includes a patch to gpiolib to make gpiod_get_from_node()
available. Just go ahead and apply this to the regulator
tree.

If these need to go for fixes or not is up to the
regulator maintainer, but all commits have a proper
Fixes: tag in case they would. I have noted in the
four last commits that the gpiolib patch is a
prerequisite.

Linus Walleij (10):
  regulator: fixed: Let core handle GPIO descriptor
  regulator: lm363x: Let core handle GPIO descriptor
  regulator: lp8788-ldo: Let core handle GPIO descriptor
  regulator: max8952: Let core handle GPIO descriptor
  regulator: max8973: Let core handle GPIO descriptor
  gpio: Export gpiod_get_from_of_node()
  regulator: da9211: Let core handle GPIO descriptors
  regulator: max77686: Let core handle GPIO descriptor
  regulator: s5m8767: Let core handle GPIO descriptors
  regulator: tps65090: Let core handle GPIO descriptors

 drivers/gpio/gpiolib.h                 |  6 -----
 drivers/regulator/da9211-regulator.c   |  4 +--
 drivers/regulator/fixed.c              |  4 ++-
 drivers/regulator/lm363x-regulator.c   |  8 ++++--
 drivers/regulator/lp8788-ldo.c         |  4 ++-
 drivers/regulator/max77686-regulator.c |  3 +--
 drivers/regulator/max8952.c            |  8 +++---
 drivers/regulator/max8973-regulator.c  | 12 ++++++---
 drivers/regulator/s5m8767.c            | 37 ++++++++++++++++++--------
 drivers/regulator/tps65090-regulator.c | 10 +++----
 include/linux/gpio/consumer.h          | 13 +++++++++
 11 files changed, 72 insertions(+), 37 deletions(-)

-- 
2.19.1

