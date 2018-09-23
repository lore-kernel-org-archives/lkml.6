Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64984ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C792148D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfJQcUHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C792148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeIWVfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 17:35:24 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50982 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeIWVfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 17:35:23 -0400
Received: by mail-it1-f195.google.com with SMTP id j81-v6so7547486ite.0;
        Sun, 23 Sep 2018 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/+9ukedm13GKdfnsBzmtP+FY4aftCm5t98vYMhcLGAY=;
        b=mfJQcUHTOryfhX3qixHk0Ws+4T0Ru6Q8VOVkG/JTTy0YbwyEsv9y6xbRrptnn/vJaA
         iY7lw+3X/FFQxIJhWWHemMICYIrkUdTr21dyN0V+jQgInSbXqpHx4JhcdQiCFp/In4gR
         di2yL+uimF/uLO+TrLCBB/5U7rVlO5e0hyPMiFuhaiHwzEbqN/SmC9jbxbAznEanjKOa
         ww3O/Vki6HwrqA4XTQ618ib6//5ev5e1OWYX2GL24aBPsaeB9KokF7KvSfVzBHzkagqZ
         nUcg3OMqqPNYFHXydetRHBEHenFqTIqLviIuL5bMBJ8pBnPPmMBiVd7HkvOR01tqFYb0
         G+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/+9ukedm13GKdfnsBzmtP+FY4aftCm5t98vYMhcLGAY=;
        b=lKDFRB0bBYpUV1mlF/xlxPLxKqG9mEpDtiyzIzMGcqUJ65TgvWJJMdRAKJW31VMISx
         3qmFD/GLvun0bVdAeX9WzrD/EzCGcUnM8f+tM/axRIff4tzkYYbEYJbGZ/JB0TYHrWGt
         flo8fX/d9cl2NP5vHUZV/ol5M7f7xra0TfDxUdKjisra/fY3XqqaEUIBf0QYm3Mfr1pt
         ROlQq5t95LfwfFXUEiPNwYVTWa0kTDAfm4Szb9V8Fti08AAIftMAvz30/hAUt5OVgtQU
         V122z3h9/spwa2ByjolVUCwWG2AUktSdmz1ij2L+5IEUiT5b3Ict2pu1txkWLj2pw7Ge
         DL2g==
X-Gm-Message-State: APzg51D4G5Kybg6aj8ESNJLitUJtlJIFBxdQ8hn0yHwXmIri44FJ0lOP
        Dg+Iz60go/5aRhoe4wqT0ESZqs7KthiYpw==
X-Google-Smtp-Source: ANB0VdbqHr+C85ixY62J7IW9HpFIOZgWSPnRtNPtok4nxIgv+fMbM7pajRA8r3pPl5p06HjJ2+mPDQ==
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr5795905jab.113.1537717051005;
        Sun, 23 Sep 2018 08:37:31 -0700 (PDT)
Received: from localhost.localdomain (c-75-73-34-135.hsd1.mn.comcast.net. [75.73.34.135])
        by smtp.gmail.com with ESMTPSA id o141-v6sm2132531itg.35.2018.09.23.08.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 08:37:30 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ARM: configs: omap2plus: Add tlv320aic23 as module
Date:   Sun, 23 Sep 2018 10:37:16 -0500
Message-Id: <20180923153718.15095-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM3517 EVM has an expander board which has two tlv320aic23
codecs.  This enables the driver for these codecs as a module.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6491419b1dad..21cabb7ad970 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -389,6 +389,7 @@ CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
 CONFIG_SND_SOC_CPCAP=m
+CONFIG_SND_SOC_TLV320AIC23_I2C=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_HID_GENERIC=m
-- 
2.17.1

