Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35942C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1932086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WzIF7m75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1932086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeH2S6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:58:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44584 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbeH2S6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:58:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so5135703wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xudw7HosvH3W7S4koGFg9NQMloENC1Orc4gV4bavhXY=;
        b=WzIF7m75s/Y3pq01Bepd8jIX/flt5Ql76r5eKTNb7ix0v3B4cKhypNDblv71DPOzxC
         mWoDZOc9uRqBQ1nySXdmpNh35lFdJYaze5Cn4rPmauhGAAHz6o4KUM+blDNs3AnivSse
         mHKVr6bmrTejcxE3wx82N8+9i6LwmFcPuCk7RzfFtrCpeC8hSD6BD4SLgti1XT+YvJhq
         +3pwX5BR1Mugf2W5JZM3OAP6s174lGw1BeCY3kB3Z4pcag5m8Ojk8pNkHB+KRJDiR7Fo
         pDtIkYEuoddWHyvJbJXB+Ep/7DFhZXuklbDqP52cbP7NsutSrxlQspfwzMQupnKElmLv
         596A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xudw7HosvH3W7S4koGFg9NQMloENC1Orc4gV4bavhXY=;
        b=MU9LcM4r5BSSQZcWrN9A1McEfEunDcIWM7ek/0LHRvDQDLD4EEbHZhR+tKfWcSgemm
         wIvtKuBQGZUWckTeTGPgmXL8nUckNAzNCMX9ADQmrGNGO5tGb1cDwRmnaO8UK+4qBqwb
         /HU9/bWqj9yH4bTRzlo5yJsOvqWTzSXhE1XpJRUosbNVB9EUUMD4/uIMpnyXNfsnrMQa
         hzp9WvMCHHpvmySbBJiEV0Uq9geDC2v77JLB9oF8NZa2lalXBFJvKZqGakznLyBk25S2
         FLAJjSTA6QNchiFRUn+6siIl1lMNBLWmdJglu37hkqv3mTTlMjqtuWusJLoQmKohnpfR
         USPw==
X-Gm-Message-State: APzg51D/NaY+zx71xyCZjqNQMJTLZrOV2K1G+Whiv5XPpIqBMsqxt/oW
        Ph9Tj+0CQlgFqm9yyvkSTBAGFQ==
X-Google-Smtp-Source: ANB0VdYu0IABOq04A1L8K89obmifBFQ/BUOxlH4A0vSy23FSM4sna2fWD4kj8Aq/GgjQviMod7leMA==
X-Received: by 2002:adf:fe06:: with SMTP id n6-v6mr4775093wrr.171.1535554858744;
        Wed, 29 Aug 2018 08:00:58 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v46-v6sm7267217wrc.63.2018.08.29.08.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 08:00:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ASoC: dmic: add Kconfig prompt for the generic dmic codec.
Date:   Wed, 29 Aug 2018 17:00:48 +0200
Message-Id: <20180829150051.18190-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829150051.18190-1-jbrunet@baylibre.com>
References: <20180829150051.18190-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig prompt for the generic digital mic to make it configurable
through menuconfig

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index adaf26e1989c..9989d35e0fc6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -578,7 +578,11 @@ config SND_SOC_DA9055
 	tristate
 
 config SND_SOC_DMIC
-	tristate
+	tristate "Generic Digital Microphone CODEC"
+	depends on GPIOLIB
+	help
+	  Enable support for the Generic Digital Microphone CODEC.
+	  Select this if your sound card has DMICs.
 
 config SND_SOC_HDMI_CODEC
 	tristate
-- 
2.17.1

