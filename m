Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05ACC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895FA2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="flU6YnWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfAVIrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:47:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32967 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfAVIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:47:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so11458254pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 00:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iqSfxFIJf8+REimT2g05eRx+fSmVQJywEXO+ftuEp3Y=;
        b=flU6YnWoqIRu4K0LO6pUn8kWAe5SavCsrJR7VU4sH0ZGAH+tO6j55c4LxPPOtv9qqy
         /yfnH+Rs8D7bnY4Ynqgg/KQ7rsAp96TL5/rxwPn9CkIiwQO/6C7wMZ+nnrkTosw1+7jy
         3dq9b/jdDFec7dbESwB/IrFylv9hjxjhunCAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iqSfxFIJf8+REimT2g05eRx+fSmVQJywEXO+ftuEp3Y=;
        b=POzzp/TJrGnjiVVy1PLoYwm+/PNG4Easmi4Ma7Dbo4Bv85v2fVcIy5x0HKEshumx38
         32rdX8bguG8BriiiJ7XWtLhoJy2LwMCrBBFW0u5RtivrJCK7eMJtgtS8NRgJSnKnqHNi
         jhEd93GrAum8wjb+W3fWGWaZPcBJNjf01oTsj7UelYE9W9XP2lCOv90gxpK/fKPs6v2x
         wqdW12keGVtFjzSUW6Mki0zkKxB5JwmvDb1nHEGBX+Xi/29GcxQrlv0MtM+UwzxsA1cf
         nJs8dRWIJh9MVMFJWpKMX8NYvRDMmlm0Hwuk9ItYn1Htrlx1WUULotiWplhruv7YHF60
         16pA==
X-Gm-Message-State: AJcUukcK1W+4zX6qfaBdDEHLc7ZXK0l7EgLPkqJ+N5Vq/3MDPb2aifWo
        T67lrzqxMH7ugye678XY15V2Bw==
X-Google-Smtp-Source: ALg8bN7l5+531/BgcdJTR2yJsNro+gsXA+30SQF5G0/ZJqDs7GAnLlrTHhuHm5XJnKtzzYn2edqlTw==
X-Received: by 2002:a62:1c0a:: with SMTP id c10mr32632105pfc.213.1548146858017;
        Tue, 22 Jan 2019 00:47:38 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d18sm21045683pfj.47.2019.01.22.00.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 00:47:37 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] dt-bindings: sdhci-omap: Add properties for using external dma
Date:   Tue, 22 Jan 2019 16:47:06 +0800
Message-Id: <20190122084706.11522-1-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190121232057.GA30919@bogus>
References: <20190121232057.GA30919@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci-omap can support both external dma controller via dmaengine
framework as well as ADMA which standard SD host controller
provides.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 72c4dec7e1db..4485dbceb373 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -14,6 +14,11 @@ Required properties:
 		 "ddr_1_8v-rev11", "ddr_1_8v" or "ddr_3_3v", "hs200_1_8v-rev11",
 		 "hs200_1_8v",
 - pinctrl-<n> : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
+- dmas:		List of DMA specifiers with the controller specific format as described
+		in the generic DMA client binding. A tx and rx specifier is required.
+- dma-names:	List of DMA request names. These strings correspond 1:1 with the
+		DMA specifiers listed in dmas. The string naming is to be "tx"
+		and "rx" for TX and RX DMA requests, respectively.
 
 Example:
 	mmc1: mmc@4809c000 {
@@ -22,4 +27,6 @@ Example:
 		ti,hwmods = "mmc1";
 		bus-width = <4>;
 		vmmc-supply = <&vmmc>; /* phandle to regulator node */
+		dmas = <&sdma 61 &sdma 62>;
+		dma-names = "tx", "rx";
 	};
-- 
2.17.1

