Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9996EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D234222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196549;
	bh=KqEry358mul7LGC+jj2E+46hRdlq5jCRIfC3/q1jCgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U2ErnTG6JN/UKvcFWnfOqgAjP0iFWft5uLtD5WJGg9nvDsh+/PEOFtTkDlZJo0uQq
	 RpdGJEcZFzWu4kPf12+JXHzNoyatU321HXP48xfyTwwnEM92ehXjWPQr8wqOvNxVph
	 yKfpEREoPHd/i8TfehZd+YqgqHRXoq3C4mINr8f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfBOCJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731437AbfBOCJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09591222D7;
        Fri, 15 Feb 2019 02:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196543;
        bh=KqEry358mul7LGC+jj2E+46hRdlq5jCRIfC3/q1jCgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arJFkIrI6IM1tBRCtwfxrWRK51MJcuXw0HUZotoIpm7Du3Pi9vGAdUIFUGUvRiX1Y
         k4ANOi3jJQ2hgVStd1xgVWu06cPiUKLdlR/Vc1XbxuSlSMN/vjrAD0mlSZqVxGnBNf
         YFGX0aFY5M2ZyjB7Rzb5PG5QaVEIOSNzhoEQQbNQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 04/77] ASoC: rt5682: Fix recording no sound issue
Date:   Thu, 14 Feb 2019 21:07:42 -0500
Message-Id: <20190215020855.176727-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit 22c7d5e7bad1fb2d8b9c611acb55a389f5d848d8 ]

The ADC mixer setting needs to restore to default value
after calibration.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 34cfaf8f6f34..89c43b26c379 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2512,6 +2512,7 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0000);
 	regmap_write(rt5682->regmap, RT5682_CHOP_DAC, 0x2000);
 	regmap_write(rt5682->regmap, RT5682_CALIB_ADC_CTRL, 0x2005);
+	regmap_write(rt5682->regmap, RT5682_STO1_ADC_MIXER, 0xc0c4);
 
 	mutex_unlock(&rt5682->calibrate_mutex);
 
-- 
2.19.1

