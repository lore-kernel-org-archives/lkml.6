Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656BFC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3148E21486
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfrumnnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3148E21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeJEXNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbeJEXNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:13:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38EE82147D;
        Fri,  5 Oct 2018 16:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756071;
        bh=16wPEcqVFhK0cVG7MOtg/KfrSWsNjUvsfYGHbG/VpUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfrumnnHpiiDOAr3FAID+7unEpumXUsWeJtlcZ9iVJC2laueQlBJx+pxCnaVhIE5k
         4eO45HEa8g/B8ikIYgp//9HoqRl9kJygh9ILHt+Y2Si1wqmy/PhU0D2Gt/eM9wLEPN
         fYdqK00LrDUOVyJ7ufqIHGh5cU+DAgFFZpaapTxo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ryan Lee <ryans.lee@maximintegrated.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 06/48] ASoC: max98373: Added 10ms sleep after amp software reset
Date:   Fri,  5 Oct 2018 12:13:42 -0400
Message-Id: <20181005161424.20521-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Lee <ryans.lee@maximintegrated.com>

[ Upstream commit ca917f9fe1a0fab3dde41bba4bbd173c5a3c5805 ]

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/max98373.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index eb2e9b3c7201..f0948e84f6ae 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -729,6 +729,7 @@ static int max98373_probe(struct snd_soc_component *component)
 	/* Software Reset */
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	usleep_range(10000, 11000);
 
 	/* IV default slot configuration */
 	regmap_write(max98373->regmap,
@@ -817,6 +818,7 @@ static int max98373_resume(struct device *dev)
 
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	usleep_range(10000, 11000);
 	regcache_cache_only(max98373->regmap, false);
 	regcache_sync(max98373->regmap);
 	return 0;
-- 
2.17.1

