Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC517C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78622561A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Fiy3ONr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78622561A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeF3RW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 13:22:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35062 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeF3RWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 13:22:49 -0400
Received: by mail-wr0-f195.google.com with SMTP id h40-v6so522897wrh.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fsd6m5/jf1NYKftQIH165+Sq4V8oS9AKP16X1iBrgJ0=;
        b=Fiy3ONr0l60xkYMvyBs9aaRcUcKBT443cFjU/yh2i317i10DV94nj/majNNvxnAFvh
         xnTs5M+mQxGpQMVHKOwTXNQQ3DifxukNAw+ox1f0ortXIVloHr7ZZGviNA2qJeZQpBEE
         WL9feUN/guFljbsdO3Mudg7hp1Tg8dLW05l2lPiHpYLxAwq9rEe6+Qq3bhFjeU9lMyd4
         J6cEVNkYXaKVwbgjcO5O+BYStMUil4+VYAf61mVkhg9COxaGHQ9kfW9JbpE1Qsd4d3Uv
         wXCj5GxhNHVuYcZLq/Yp3t/Lk9MAqPFgt2YjoOapB5GYWcdzp9/runaDZraitTvXIwUZ
         PSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fsd6m5/jf1NYKftQIH165+Sq4V8oS9AKP16X1iBrgJ0=;
        b=pDVQ6dDuYRgGIs32z6YSnHVZljAdNCAPemZ8EwyhRLhGaRDXmlEl0a8nb2z0KpgWLC
         4Jw1/qkRmNEhAQ7ym9339G9m4CQrX8jeHkIyMlWvy3UCWJCYkLBPF5eFUW/rCyZiOX8B
         glhPXsaY4Q6Nz9uOAFo8AW+K2dkZBtXotlu2Ym0+yizJApl/w022/FAdLKD1iYUemtFf
         FsPMvq3af4mo947dzRDmE6wIt5LQ5iKOTDmlNjfMtBaHXuTejuvCSkLJpeFgt7utaa9P
         Z/p/DfFxn938WApTpY4TkkXm8mbrNc90NTEk6P1PuhZAquI1JC9FTiQsQfWoE7FuMACg
         nOgQ==
X-Gm-Message-State: APt69E0v2AFlR5ELLCsiKK3VRDtxtvpZajhLr0mvN8c/FvCyQ7dSnBcR
        VNDsekIB/sKoOUWABF6zRy2MBQ==
X-Google-Smtp-Source: AAOMgpdUUmJtas8lsvvXQ5Vrz1p1sgA+rmdN2t6nVDTZJnC1sdyu4xPqoWme0G7G0zYZAo7yLnjMxw==
X-Received: by 2002:adf:9e48:: with SMTP id v8-v6mr5581777wre.277.1530379368421;
        Sat, 30 Jun 2018 10:22:48 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h1-v6sm16854885wri.90.2018.06.30.10.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 10:22:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: es7241: add dt-bindings documentation for the es7241 adc
Date:   Sat, 30 Jun 2018 19:22:40 +0200
Message-Id: <20180630172241.10806-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180630172241.10806-1-jbrunet@baylibre.com>
References: <20180630172241.10806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/everest,es7241.txt   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es7241.txt b/Documentation/devicetree/bindings/sound/everest,es7241.txt
new file mode 100644
index 000000000000..adee52281b3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es7241.txt
@@ -0,0 +1,23 @@
+ES7134 i2s DA converter
+
+Required properties:
+- compatible : "everest,es7241"
+
+Optional properties:
+- VDDP-supply: regulator phandle for the VDDA supply
+- VDDA-supply: regulator phandle for the VDDP supply
+- VDDD-supply: regulator phandle for the VDDD supply
+- reset-gpios: gpio connected to the reset pin
+- m0-gpios   : gpio connected to the m0 pin
+- m1-gpios   : gpio connected to the m1 pin
+
+Example:
+
+linein: audio-codec@2 {
+	#sound-dai-cells = <0>;
+	compatible = "everest,es7241";
+	VDDA-supply = <&vcc_3v3>;
+	VDDP-supply = <&vcc_3v3>;
+	VDDD-supply = <&vcc_3v3>;
+	reset-gpios = <&gpio GPIOH_42>;
+};
-- 
2.14.4

