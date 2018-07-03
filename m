Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF2620BED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s+PIFwni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF2620BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbeGCPHJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:07:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38552 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932367AbeGCPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:06:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so2653273wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bHHowAc7EPVrhZfNrBYfT8tRMvQWiWf3T38udQ/l/Sw=;
        b=s+PIFwnisVbicu5qPPNHtVrapv0mRbrUc8PB3Yff/dxYeRbiLBMkMcSGr6E8h5xKoE
         peAJf2Gzeu0D9pa1XPztIxi/VfZ4CTubm3S7u5xQo7mRpCkmrTpzSTQMwBRZYolsgKBm
         /8UNIf6KICwo2OXySP2WByxcxiB8jGgz2CwTsIoPcg3P35YDqZvvdJprQW2tuJzSwg7a
         0b4cn8ndOSao8ORvrdZyQ75jMInEuw+WmYeq90IkBjgyG0kdW6+tYfuVsQhihZJm06UD
         5OIvpjgJZrNyI8CCHyRHV3/CBNUG/JNYtJ1O5Q2peHhVZrSx0bteRXRZ7zK2BYqC4J+i
         gRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bHHowAc7EPVrhZfNrBYfT8tRMvQWiWf3T38udQ/l/Sw=;
        b=EL8dDNbI+I1KZDBpatZUBx92TYZksUfOg89P+1Daa8N+pFiroqkrW6ez+2nCoMKs2x
         VhOBG6EXBeF7jLu9y+9EzrwqFWHiqlFDoeNMETpHQQssn0gzj0AQxe9E6atf78PZPPnr
         XV3LEwhf/3SiMnwk3qG5TZfq/Zd0UJfA3vYHQ7K1w0qFItbX90Th7cHOMqZNK1ECVbma
         MP/jYDnHzmD8DgqBcjMDHMF7CfZvgdOiDTeyfHLH3AqzJyJooSoVMRs9GI126x/r2ZC+
         2MVOmycf4dJZ4o89iwPorvj4stRnRiI6b9RhQ2qqgrF1cCi2a7iD4xidy4fFfBckXFej
         QBcg==
X-Gm-Message-State: APt69E13n+siCui1Kab8cj68r/p4hgcuFKjNfASihHV6+0iHGC18fIkD
        PV4q5Lp71lgSHru/Zx8vws7Kzw==
X-Google-Smtp-Source: AAOMgpfT488c5+zyUct0wTukQ6JXRL2oHbHqbsK/z8zpgU2A6LnL6DnsRbE3eHgE8NTUobQBEbIHJg==
X-Received: by 2002:a1c:e5cd:: with SMTP id c196-v6mr11211274wmh.101.1530630366807;
        Tue, 03 Jul 2018 08:06:06 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x16-v6sm2905842wme.12.2018.07.03.08.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:06:06 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ASoC: es7134: update DT binding with new compatible and supplies
Date:   Tue,  3 Jul 2018 17:05:58 +0200
Message-Id: <20180703150600.17697-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703150600.17697-1-jbrunet@baylibre.com>
References: <20180703150600.17697-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to add support for the es7154 and
optional power supplies phandles.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/everest,es7134.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es7134.txt b/Documentation/devicetree/bindings/sound/everest,es7134.txt
index 5495a3cb8b7b..091666069bde 100644
--- a/Documentation/devicetree/bindings/sound/everest,es7134.txt
+++ b/Documentation/devicetree/bindings/sound/everest,es7134.txt
@@ -1,10 +1,15 @@
 ES7134 i2s DA converter
 
 Required properties:
-- compatible : "everest,es7134" or "everest,es7144"
+- compatible : "everest,es7134" or
+               "everest,es7144" or
+	       "everest,es7154"
+- VDD-supply : regulator phandle for the VDD supply
+- PVDD-supply: regulator phandle for the PVDD supply for the es7154
 
 Example:
 
 i2s_codec: external-codec {
 	compatible = "everest,es7134";
+	VDD-supply = <&vcc_5v>;
 };
-- 
2.14.4

