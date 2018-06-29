Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C218CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8FE28011
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TiS0QXma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8FE28011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935776AbeF2PKE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:10:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41175 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755591AbeF2PJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:09:36 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so9167425wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/wtLKomE6HwHPNbFcDaRgybgHLqVBTbQpGq9S5EpfI=;
        b=TiS0QXmamIDs5z3ePns3W6o7g+lkxgPPhV3q/867tUKWv5VwfPPXxWZMfOyMmqqc2G
         li5zcBQBUM8b+bQ3TZGYqc8jC3gA8pyLZd7oA4Zhw5aKx2DwWLY4uACwJxZwmLDXGIAG
         vqXAQ53WtPgXVlJV9ar2WdhQBUKGV3ietXY9G/4SzL3IWQTNJeG3DoblN7X8KQNycXB1
         o8nwmMVo0XiFpUF1zhEGEFrvA5tgTaJpKWH/Fd984Ku0qG8HGSKA7yTJ2ZGv1Vg8PsZ7
         JPtMfW4WPiJHInXHhNdqPuNsrOyuD/yQRFgROJL4yvfa9mf1vkfzVu6h4LuMFWr5vx0X
         bq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/wtLKomE6HwHPNbFcDaRgybgHLqVBTbQpGq9S5EpfI=;
        b=EYat5Ta+1B8/ag/qRQtXWRz+f9fb6tzoCfQsa7lfWzmLHpPy2yn0XtWfYv75SIfZE9
         UWR14gdhaq9Ve2PZGwWO917MgUzlJ8Vqjbnl9tsKzFlJGMrVb0sVONJcqgLzHuUOZp8B
         lvLR8U8ZtSHfLuwR4OStS9szaw3PRuReQTyvF/bV9uEjI8oZ587BicWN4z1TEj6gHxrj
         jso63EeDw16Mj6OAJiyWwcF7QVl6QfqmeyhNtkGVcFjiaKDU1V1ocZeCNVkZYb6qOq9K
         KX3A5bhEZBOYXONCWNCqbdSDBTA82isi3O+RE2Vev35Y66mC+EzcwE801/7OskuIAGhO
         bj5w==
X-Gm-Message-State: APt69E3iRqY4Qj96M7/FGZ+Z/8Hve6TdYgNRnl1o5j7i8f4HyQEpvyAM
        5fZJcT7QNUSOOsUb1m+4i6d5ng==
X-Google-Smtp-Source: AAOMgpf/NbA+7EKpFEOJcexPNyYIWGESWtWJY5PBhG8h8M1k2nRcvBOho7n4oW/YTlxrYfp+Sx26zw==
X-Received: by 2002:adf:a0c2:: with SMTP id n2-v6mr12939121wrn.23.1530284975139;
        Fri, 29 Jun 2018 08:09:35 -0700 (PDT)
Received: from localhost.localdomain (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id b6-v6sm11944222wro.52.2018.06.29.08.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:09:34 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ASoC: es7134: Add VDD and AVDD power supplies
Date:   Fri, 29 Jun 2018 17:09:23 +0200
Message-Id: <20180629150924.18197-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180629150924.18197-1-jbrunet@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the VDD and AVDD power supplies to the DAPM graph as some board may
need to enable a regulator to turn them on.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/es7134.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 698289dc3e22..5ad59c38fed1 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -167,11 +167,15 @@ static const struct snd_soc_dapm_widget es7134_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("AOUTL"),
 	SND_SOC_DAPM_OUTPUT("AOUTR"),
 	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("AVDD", 0, 0),
 };
 
 static const struct snd_soc_dapm_route es7134_dapm_routes[] = {
 	{ "AOUTL", NULL, "DAC" },
 	{ "AOUTR", NULL, "DAC" },
+	{ "Playback", NULL, "VDD" },
+	{ "DAC", NULL, "AVDD" },
 };
 
 static const struct snd_soc_component_driver es7134_component_driver = {
-- 
2.14.4

