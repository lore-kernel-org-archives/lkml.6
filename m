Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED61C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC442075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1zHhuV94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC442075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934443AbeF2PJj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:09:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34594 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755588AbeF2PJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:09:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so9188365wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ntrw9WA6YMJlZA1RVGO0rFX4H+AG+VQ/onfo0b5libQ=;
        b=1zHhuV94/Crjjli17d+fR24qe17PWdjtbksyJ8HZD/QaPP9NRE4Dz4dvyaDSKH3x9s
         NGB+8F1eb/4ONH5ITm7Tr0LOxwRVdSe9uqKh8LIszfvPzx91WnjZ6zjAaHMr/jhkGsV1
         tw61DCyqgJ5gPBxWIq1X/vGVHRQvExwntp7Y89VVFBE0jOulYavZP7Kt5sRUzLekFpjy
         nizz3JuxSlYS6z6wDtTyJ/8ce5GcUzG/Zjyy7ea1zOXuhBkuYJ/djzOf9Gii9l4yjgV+
         iqu1eGBj8YOCuDNa4sZlSq1XU8MZtDBqGozLaQJzU72O4ToupdxP9gjw8pCVL+Zpgsjq
         1wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ntrw9WA6YMJlZA1RVGO0rFX4H+AG+VQ/onfo0b5libQ=;
        b=X71QivQgfV/sn/YLkRj/o/SDIFXub1Bdo7IZIcxF86tnzmWCJW/gqeyhmzYikfuhnk
         iIQdbDCYOp3TTULPvmen1u2mkD4nyZaxg64t0CiONKaTWe/p8g6g7rrPpcaUSUncoze8
         WhKHO9iFiFk30ivdm4Lw22Xe7DLTqcwRkb5uKp+b/IUw3IffssqdUfYroRNQEGjW62Pt
         zSfZAOX2C3te/YCqwvzvJXRFbXpinKO0tQjJFiGvXLRLRpyUByEpDVdeVrYWq5s2ESQ/
         jDKn3mxmStiNmyod5alzsa1wcPj88buJv9hdAiCcbJZFV7bgsy0/t+T7AIfjVbR0TFeP
         YEUQ==
X-Gm-Message-State: APt69E1y9aAGxuHlCkkBzJT3K6xY/ZDHWuw151A5Z4EXRenrZO/6Il7V
        bAuQDW7JI00onM2vOmE3GQTEhA==
X-Google-Smtp-Source: AAOMgpcAfVGHski9foJaHMxaZj/xznsgHfFGPYAAG5MtyV8H6pk0KIS6a5JQOrr3TjbCarM+JCu8Gw==
X-Received: by 2002:adf:be8d:: with SMTP id i13-v6mr12339873wrh.86.1530284974059;
        Fri, 29 Jun 2018 08:09:34 -0700 (PDT)
Received: from localhost.localdomain (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id b6-v6sm11944222wro.52.2018.06.29.08.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:09:33 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ASoC: es7134: update DT binding with new compatible and supplies
Date:   Fri, 29 Jun 2018 17:09:22 +0200
Message-Id: <20180629150924.18197-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180629150924.18197-1-jbrunet@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to add support for the es7154 and
optional power supplies phandles.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/everest,es7134.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es7134.txt b/Documentation/devicetree/bindings/sound/everest,es7134.txt
index 5495a3cb8b7b..c6bcdc5bded8 100644
--- a/Documentation/devicetree/bindings/sound/everest,es7134.txt
+++ b/Documentation/devicetree/bindings/sound/everest,es7134.txt
@@ -1,7 +1,13 @@
 ES7134 i2s DA converter
 
 Required properties:
-- compatible : "everest,es7134" or "everest,es7144"
+- compatible : "everest,es7134" or
+               "everest,es7144" or
+	       "everest,es7154"
+
+Optional properties:
+- VDD-supply: regulator phandle for the VDD supply
+- AVDD-supply: regulator phandle for the AVDD supply
 
 Example:
 
-- 
2.14.4

